Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E8BC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B9B78753D;
	Tue,  7 Nov 2023 17:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BPVgC3Wl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA03187519; Tue,  7 Nov 2023 17:18:56 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EA387538
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52D9C1C0007;
 Tue,  7 Nov 2023 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699373934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SE6HGY9LPrpAFawS3pORqz5JFbI0lf+z/YEoYVt5aHQ=;
 b=BPVgC3Wl4WKBFlaLoh/sGAKc0rFBWHQGhIYsfoXmjWu6GZblgt8x9IWYdGfiYRliw+WCgP
 3Ht4/hM0etA338Dt4qadg5Vyw49YOGgiQ8ZEJyRVJqJGGTBq9mqsLLt7ZS7h7sm2ji/biI
 1UjtoDKkGBin0wTUDnmlocZfhafVII51mFD6m5UzA3DgXbQXLOMhpcgMRAefA1UXc6l9RP
 3Vs4QYMAfY7yp6O5Z8ZwaEPY3BUS25pOSeakxihmZoph5A/P7zPaty3CgcP7bFgB/pyqmN
 MxfNR6Q88n1mrfJdBJhOY3hp/3MHtyRdciy7xLBPXhlk2jc+mNavspEJ8kzlHQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.richard@bootlin.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 8/8] arm: mach-k3: j7200: Skip fit processing when resuming
Date: Tue,  7 Nov 2023 17:18:02 +0100
Message-Id: <20231107161802.855154-9-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107161802.855154-1-thomas.richard@bootlin.com>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
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

