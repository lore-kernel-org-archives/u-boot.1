Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51ABC28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 03:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BBB4809A5;
	Sat, 29 Mar 2025 04:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83AA080ECC; Sat, 29 Mar 2025 04:12:58 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ABE080050
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 04:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1tyMcu-000000004Z6-3PYI; Sat, 29 Mar 2025 03:12:52 +0000
Date: Sat, 29 Mar 2025 03:12:50 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, u-boot@lists.denx.de
Cc: Thomas =?iso-8859-1?Q?H=FChn?= <thomas.huehn@hs-nordhausen.de>
Subject: [PATCH 1/2] image-fit-sig: skip in tools build if key is missing
Message-ID: <bf6a90e864b713db41bf788797554649eeaa0732.1743217745.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Skip signature verification in case no public key was given in order to
allow using fit_check_sign also to validate uImage.FIT images without
signatures. Guarded by USE_HOSTCC macro the behavior on target is
unchanged.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/image-fit-sig.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index a121de60ae2..f23e9d5d0b0 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -191,6 +191,11 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 	int noffset;
 	int key_node;
 
+#ifdef USE_HOSTCC
+	if (!key_blob)
+		return 0;
+#endif
+
 	/* Work out what we need to verify */
 	*no_sigsp = 1;
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
@@ -477,6 +482,11 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	bool reqd_policy_all = true;
 	const char *reqd_mode;
 
+#ifdef USE_HOSTCC
+	if (!key_blob)
+		return 0;
+#endif
+
 	/*
 	 * We don't support this since libfdt considers names with the
 	 * name root but different @ suffix to be equal
-- 
2.49.0
