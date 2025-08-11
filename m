Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D8DCA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1772C831E4;
	Mon, 11 Aug 2025 18:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="kcXajUsl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7517831E4; Mon, 11 Aug 2025 18:11:18 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9344831BE
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=xhkxCLrK6T+ClgG3DV9kM59BxyMRJdTMZ/R1nL2/nIM=;
 b=kcXajUslJii4v/cLU0HLV8Ej64kfxArxaVIq7ddpkP3XmNwUVD6d0+fw4irsoK/MZJQoDmJ579Nr9COE+af81StY9Y8ou+wynlmnvNsad0tY1nzkGpXdZj6nKCPfpsOGAeHeJaE/k70NUI+ziL+HoS+fkTt5rTgEMH/xXNvCJqI=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Mon, 11 Aug 2025 18:11:15 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Tom Rini <trini@konsulko.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/2] rsa: allow operation without SPL_DM by falling back to
 software
Date: Mon, 11 Aug 2025 18:10:33 +0200
Message-Id: <20250811161035.2703435-2-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811161035.2703435-1-lukas.schmid@netcube.li>
References: <20250811161035.2703435-1-lukas.schmid@netcube.li>
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

Boards using secure boot but lacking SPL_DM support currently cannot
use FIT signature verification in SPL, as SPL_FIT_SIGNATURE depends
on SPL_DM.  This dependency is only needed for hardware RSA modular
exponentiation drivers; software RSA verification works without DM.

Remove the SPL_DM dependency in Kconfig and guard the hardware RSA
path in rsa-verify.c with CONFIG_IS_ENABLED(DM).  This allows SPL to
verify signed FIT images using the software RSA implementation on
non-DM systems.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 boot/Kconfig         |  2 +-
 lib/rsa/rsa-verify.c | 27 ++++++++++++++++-----------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a671d78e..6c0e2a49 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -203,7 +203,7 @@ config SPL_FIT_FULL_CHECK
 
 config SPL_FIT_SIGNATURE
 	bool "Enable signature verification of FIT firmware within SPL"
-	depends on SPL_DM
+#	depends on SPL_DM
 	depends on SPL_LOAD_FIT || SPL_LOAD_FIT_FULL
 	select FIT_SIGNATURE
 	select SPL_FIT
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index b65fbe44..314f75a2 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -327,8 +327,9 @@ static int rsa_verify_key(struct image_sign_info *info,
 			  const uint32_t key_len)
 {
 	int ret;
-#if !defined(USE_HOSTCC)
-	struct udevice *mod_exp_dev;
+#ifndef USE_HOSTCC
+	if (IS_ENABLED(CONFIG_DM))
+		struct udevice *mod_exp_dev;
 #endif
 	struct checksum_algo *checksum = info->checksum;
 	struct padding_algo *padding = info->padding;
@@ -354,17 +355,21 @@ static int rsa_verify_key(struct image_sign_info *info,
 	uint8_t buf[sig_len];
 	hash_len = checksum->checksum_len;
 
-#if !defined(USE_HOSTCC)
-	ret = uclass_get_device(UCLASS_MOD_EXP, 0, &mod_exp_dev);
-	if (ret) {
-		printf("RSA: Can't find Modular Exp implementation\n");
-		return -EINVAL;
-	}
+#ifndef USE_HOSTCC
+	if (IS_ENABLED(CONFIG_DM)) {
+		ret = uclass_get_device(UCLASS_MOD_EXP, 0, &mod_exp_dev);
+		if (ret) {
+			printf("RSA: Can't find Modular Exp implementation\n");
+			return -EINVAL;
+		}
 
-	ret = rsa_mod_exp(mod_exp_dev, sig, sig_len, prop, buf);
-#else
-	ret = rsa_mod_exp_sw(sig, sig_len, prop, buf);
+		ret = rsa_mod_exp(mod_exp_dev, sig, sig_len, prop, buf);
+	} else
 #endif
+	{
+		ret = rsa_mod_exp_sw(sig, sig_len, prop, buf);
+	}
+
 	if (ret) {
 		debug("Error in Modular exponentation\n");
 		return ret;
-- 
2.39.5


