Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E4ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3749D86EE7;
	Mon, 16 Oct 2023 16:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="B6PWuSej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D0D86823; Mon, 16 Oct 2023 16:14:44 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F7086BA4
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD6CA2000D;
 Mon, 16 Oct 2023 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697465678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23M0wps2yvzekYEDqTrHngufgqV9TWRS7a0fS8mjXo0=;
 b=B6PWuSejBLEbK5f22TOuoiPw+9ri453eP6jJE1xYADhcj8gDecKS0pzyY4lE4JA9h0Ey2P
 pMJHbOHz4Bej1SXzKuUGEdoPEhv/fiogNwf6Da3qOAzkE1/oVVRlQNUd+Kkdi43EhddZFn
 VtMJiO0/xyjAfSOPQq1X/NS8mVnqtdvtL6NuBWg8lhEoFDlJQq5qrxgxARPXVVpfp5fX1h
 M6IX9ZN5p4iANgbfTeFVpN28hq5ZDEx4yCTcKgA3GoYCEYUmuZJtK+riiQG4u722OW4wda
 zuGNtOnKi/DEUUhCb3KqH9ipn800ke8+kSuf++EGObB8XBJ7aR36tzH6YYtCgQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com, Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/9] arm: mach-k3: j7200: Skip fit processing when resuming
Date: Mon, 16 Oct 2023 16:11:34 +0200
Message-Id: <20231016141135.325698-9-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016141135.325698-1-thomas.richard@bootlin.com>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Mailman-Approved-At: Mon, 16 Oct 2023 16:15:29 +0200
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

