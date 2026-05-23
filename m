Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E1DCD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8938485F;
	Sat, 23 May 2026 14:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XUO1VuB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4A783E81; Sat, 23 May 2026 14:18:04 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 628DB847AF
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CC3C8272F0;
 Sat, 23 May 2026 14:18:00 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y60zrPjQNKZo; Sat, 23 May 2026 14:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779538680; bh=CNB4V0zWgj2UQP0Tdknj2Bmdnuk8cnAi1mvwoC3S7Z4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XUO1VuB1OMmYqNG8QTT5rHs3SCh1pgfJW/LtAX4VSslMPhJmulCjnnB3sdYeDWodd
 KduiCgrpA0Y0BLoOBiSCNoew28qSu+wrnTNPfAMTwehrwbNkytwkWMi1GqQGkHSZ8S
 0jdThntwcoER6TfFKKUOsql8psgeY/FHLvJp5Vkq91psl8p31iqqASu/vDgcHC/aSS
 HD0I2IwOdN14f7r3s8ZF2RfWrc2YdBo8SMiuecBdcA6DR2HPIGgAOzUq0tzP+8mvE1
 pLEzk4NQGsYLRqaD4rMWyOblDSBFKunyALutYCJ6LuC4zKyNQFnMAioOOxIWjnMxQx
 dety3zqsgAAAg==
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] armv8: sec_firmware: validate loadables string list
Date: Sat, 23 May 2026 12:18:00 +0000
Message-ID: <20260523121801.9235-2-josh2@disroot.org>
In-Reply-To: <20260523121801.9235-1-josh2@disroot.org>
References: <20260523121801.9235-1-josh2@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

sec_firmware_check_copy_loadable() walks the loadables property by hand
and treats each entry as a C string. If a malformed property is missing
the trailing NUL inside its length, strchr() can read past the property
while looking for the end of the entry.

Use libfdt string list helpers for the walk. Missing loadables still
means there is nothing to copy, and malformed loadables now fail before
use.

Signed-off-by: Josh Law <josh2@disroot.org>
---
 arch/arm/cpu/armv8/sec_firmware.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index 44372cbe4a1..8c31fd19399 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -86,8 +86,8 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 	const void *data;
 	size_t size;
 	ulong load;
-	const char *name, *str, *type;
-	int len;
+	const char *str, *type;
+	int count, i, len;
 
 	conf_node_off = fit_conf_get_node(sec_firmware_img, NULL);
 	if (conf_node_off < 0) {
@@ -104,16 +104,28 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 
 	type = FIT_LOADABLE_PROP;
 
-	name = fdt_getprop(sec_firmware_img, conf_node_off, type, &len);
-	if (!name) {
+	count = fdt_stringlist_count(sec_firmware_img, conf_node_off, type);
+	if (count == -FDT_ERR_NOTFOUND) {
 		/* Loadables not present */
 		return 0;
 	}
+	if (count < 0) {
+		printf("SEC Firmware: invalid '%s' property: %s\n", type,
+		       fdt_strerror(count));
+		return -EINVAL;
+	}
 
 	printf("SEC Firmware: '%s' present in config\n", type);
 
-	for (str = name; str && ((str - name) < len);
-	     str = strchr(str, '\0') + 1) {
+	for (i = 0; i < count; i++) {
+		str = fdt_stringlist_get(sec_firmware_img, conf_node_off, type,
+					 i, &len);
+		if (!str) {
+			printf("SEC Firmware: can't read '%s' entry %d: %s\n",
+			       type, i, fdt_strerror(len));
+			return -EINVAL;
+		}
+
 		printf("%s: '%s'\n", type, str);
 		ld_node_off = fdt_subnode_offset(sec_firmware_img, images, str);
 		if (ld_node_off < 0) {
-- 
2.47.3

