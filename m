Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CF4109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C1A83DA7;
	Wed, 25 Mar 2026 20:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="Kv9KAw3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E62383FC6; Wed, 25 Mar 2026 20:27:25 +0100 (CET)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D6C83FC6
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=Zq0qmAlMWxTJOYcL3mW4bjKwgi3QCMcSHdbIEEhZnxM=;
 b=Kv9KAw3cF4y8AYcOMxOHP35E9eIipUNVjKoyDG739Yg7y3MvyuUvv6XJaYqx1EDlMuvLMrccNtmr4Rgfp7gxaQGv6//58iQcje65u0bBl88Cv2WOAuuSpvM2TTFs22Eecd4j3PE1gIOgynyfj0hCm2YFQzH8jIyenJd35rFvl3c=
Received: from lukas-hpz440workstation.lan.sk100508.local
 (193-80-178-216.hdsl.highway.telekom.at [193.80.178.216])
 by mail.netcube.li with ESMTPA ; Wed, 25 Mar 2026 20:27:20 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH 4/6] boot: allow SPL FIT signature verification without DM
Date: Wed, 25 Mar 2026 20:26:11 +0100
Message-ID: <20260325192628.750398-5-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325192628.750398-1-lukas.schmid@netcube.li>
References: <20260325192628.750398-1-lukas.schmid@netcube.li>
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

SPL FIT verification was effectively tied to Driver Model. The RSA
verifier assumed a DM-backed modexp device, and SPL_FIT_SIGNATURE
depended on SPL_DM. This prevents non-DM SPL platforms from using
FIT signature verification even though the software modular exponent
fallback is already available.

Drop the hard SPL_DM dependency and only look up the modexp device
when DM is enabled. Non-DM SPL builds then fall back to the software
implementation and can enable signed FIT verification.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 boot/Kconfig         |  1 -
 lib/rsa/rsa-verify.c | 16 ++++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 4e9bc9491a0..6ccb7d44a5e 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -202,7 +202,6 @@ config SPL_FIT_FULL_CHECK
 
 config SPL_FIT_SIGNATURE
 	bool "Enable signature verification of FIT firmware within SPL"
-	depends on SPL_DM
 	depends on SPL_LOAD_FIT
 	select FIT_SIGNATURE
 	select SPL_FIT
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 3169c3a6dd1..24b23ab565a 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -355,13 +355,17 @@ static int rsa_verify_key(struct image_sign_info *info,
 	hash_len = checksum->checksum_len;
 
 #if !defined(USE_HOSTCC)
-	ret = uclass_get_device(UCLASS_MOD_EXP, 0, &mod_exp_dev);
-	if (ret) {
-		printf("RSA: Can't find Modular Exp implementation\n");
-		return -EINVAL;
-	}
+	if (CONFIG_IS_ENABLED(DM)) {
+		ret = uclass_get_device(UCLASS_MOD_EXP, 0, &mod_exp_dev);
+		if (ret) {
+			printf("RSA: Can't find Modular Exp implementation\n");
+			return -EINVAL;
+		}
 
-	ret = rsa_mod_exp(mod_exp_dev, sig, sig_len, prop, buf);
+		ret = rsa_mod_exp(mod_exp_dev, sig, sig_len, prop, buf);
+	} else {
+		ret = rsa_mod_exp_sw(sig, sig_len, prop, buf);
+	}
 #else
 	ret = rsa_mod_exp_sw(sig, sig_len, prop, buf);
 #endif
-- 
2.47.3


