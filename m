Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BA0C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 16:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C82887AD9;
	Mon,  8 Jan 2024 17:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PXJdCLKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D5B87AC7; Mon,  8 Jan 2024 17:58:35 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4DB87AB4
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 17:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8594FFF805;
 Mon,  8 Jan 2024 16:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1704733111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SE6HGY9LPrpAFawS3pORqz5JFbI0lf+z/YEoYVt5aHQ=;
 b=PXJdCLKi0DP0y9Q0tNfS5/9xYzqhkIeSR3wAQPI/+QHNeQZI+UdAPpwYpzNuXPgQMJyGOq
 9etBx9n3bIs+B0DXJcbR6XdICpaTjBRnrvJUw5GiLTdLvJKvPzH1JLSP2xE/zfU5iZGW6C
 PE3dkoqd1NvzPucSzEGOPAgvT2MC664ZxblyQj3PqAqCsTSR75JJ/2hdJiLApq1nwEZuHa
 ZrUX/LovAknEFYeyuKFG4Am6TOGc/WFL2zxzxBc5GMgc4kbP1INj5XtUMomIiPmRCO1RfL
 6eKcGz6MXfZ4oeAMN6SXeVOea62JU2e5E4x2W3NMXZtwni/wD0FDG54jwpKsvQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com, nm@ti.com,
 u-kumar1@ti.com, gregory.clement@bootlin.com, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 8/8] arm: mach-k3: j7200: Skip fit processing when resuming
Date: Mon,  8 Jan 2024 17:56:28 +0100
Message-Id: <20240108165628.3935756-9-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108165628.3935756-1-thomas.richard@bootlin.com>
References: <20240108165628.3935756-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
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

No need to process fit image during resume.
All needed parts are already available in DRAM.

Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

---

(no changes since v1)

 arch/arm/mach-k3/sysfw-loader.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index e6d452e590..89daf9b7f8 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -100,6 +100,11 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 		panic("SYSFW load address not defined!");
 }
 
+__weak int board_is_resuming(void)
+{
+	return 0;
+}
+
 /*
  * Populate SPL hook to skip the default SPL loader FIT post-processing steps
  * during SYSFW loading and return to the calling function so we can perform
@@ -107,7 +112,7 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
  */
 bool spl_load_simple_fit_skip_processing(void)
 {
-	return !sysfw_loaded;
+	return board_is_resuming() ? true : !sysfw_loaded;
 }
 
 static int fit_get_data_by_name(const void *fit, int images, const char *name,
-- 
2.39.2

