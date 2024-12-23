Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAC2E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B32806DD;
	Mon, 23 Dec 2024 08:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WgfgZ9dR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6023A806FE; Mon, 23 Dec 2024 08:07:23 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4109B806FF
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so613761166b.1
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734937640; x=1735542440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vip+lnXlyer7BlGRVafYEyKOTKYJuh5V4DX4LQrbidc=;
 b=WgfgZ9dR0iq97Qkc35LSkOyMkCXBiYUJtKLv49ERb3lZIxfvBciPN0aQ2xCf5PmWmg
 JSpzmVrql+hgYHxmfq/EnaHsNR9ulsXYNxShX9CQ1oCcnyg3QUg48zR7GOWezYA3KSF6
 A4JEd9zbFpVt5VsYH/LNDQDuekizANKgzOpGKiRnQ6pbw+u7Ni24MbkuFEbmG3GJ6pNY
 3E+6VuR9CImc/u38hblLao8nWQKkZ+VlVHbPtS0biPwWawM5ERuGcl1UXRL9NMErNIuT
 gjjHRjUBBhKQ+c90E9Lv3CDG/kSrKeTAoNJZqNo9UIy32wSB6auUVZm2OMcx38jxOuWW
 Il1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734937640; x=1735542440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vip+lnXlyer7BlGRVafYEyKOTKYJuh5V4DX4LQrbidc=;
 b=PqGLUucexoG5HAP0lgD9cuPBPWWmSNgDjss8Udvc1RPaR6ebUCG/zXpq9bIIOdYnLv
 ZNTZK1aE0yKqvnw96Ih34ObPXpAeFK9DcUkWcyX2U1T1kvG8Fm8WhvTGb+JfwWukgnFv
 j2LIlCTKvXkRNX8tTX2rDOHIPxNJKdNvDutryKTlddoFz3YhQHuYQZZ0gZTTkZKF2Qgr
 TXnuRjvthSob71W0VM50Yqzze+5kFdsCZ3hXv0ZSQZJzmu4ZPCF3UxEuO7iNuOF+PnRh
 4UvXvfUf05zrXI4YUFitSqP7A3XgUZLnTgQxGrQFdDPbx9PIY7eUiMfTIadsbOiSYC3N
 dZ0w==
X-Gm-Message-State: AOJu0YzlMaZenhlkFTs1kVZoYWbzlZc35WvF/1oppkkBj710dtFdL7RQ
 BnWHJabn/Sp0xsQN7UzpVd6n9skAb1A0kT3Q2jztD2+FYD4BStCK
X-Gm-Gg: ASbGncuVC5pndew+tc2YtUW7dzXYLDiGTsXSHZmyxKmoH1PyyKMxwOLn6DpOFNTy7kj
 3WVi1cPflChZZSXpJFXBPvVD3db32xdMa6KmA6nZfN+LTUmY67UoeZhe7iFS4x1epagvpHpIjNB
 TusKk4Xysh+7dnQ8nlgUQ2eoNZXR25TrX0mNM25NeweLhASG6yKXWDaXmDda13ZZjep30i9Lm69
 QKaWFwlfPD8TGAblJ5AivNdhVDp4D+pFZGu0rQB/lzLXQtD
X-Google-Smtp-Source: AGHT+IF6gR/riVRkEPH3164GEQgwCAzXr+Z/B79e1hZWWom/uj1DZxWaeDmn4UCJU7Ai35c1s2/c8Q==
X-Received: by 2002:a17:907:7fa1:b0:aa6:1c6a:30a1 with SMTP id
 a640c23a62f3a-aac2d0479d1mr1208351666b.32.1734937639529; 
 Sun, 22 Dec 2024 23:07:19 -0800 (PST)
Received: from xeon.. ([188.163.112.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm4511895a12.40.2024.12.22.23.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 23:07:19 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 6/7] ARM: tegra124: implement BCT patching
Date: Mon, 23 Dec 2024 09:06:37 +0200
Message-ID: <20241223070638.35748-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241223070638.35748-1-clamor95@gmail.com>
References: <20241223070638.35748-1-clamor95@gmail.com>
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

This function allows updating bootloader from u-boot
on production devices without need in host PC.

Be aware! It works only with re-crypt BCT and AES
encrypted devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/Kconfig           |  2 +-
 arch/arm/mach-tegra/tegra124/Makefile |  1 +
 arch/arm/mach-tegra/tegra124/bct.c    | 91 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra124/bct.h    | 55 ++++++++++++++++
 4 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-tegra/tegra124/bct.c
 create mode 100644 arch/arm/mach-tegra/tegra124/bct.h

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 04612895576..333d432f728 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -247,7 +247,7 @@ config CMD_ENTERRCM
 
 config CMD_EBTUPDATE
 	bool "Enable 'ebtupdate' command"
-	depends on TEGRA20 || TEGRA30
+	depends on TEGRA20 || TEGRA30 || TEGRA124
 	select TEGRA_CRYPTO
 	help
 	  Updating u-boot from within u-boot in rather complex or even
diff --git a/arch/arm/mach-tegra/tegra124/Makefile b/arch/arm/mach-tegra/tegra124/Makefile
index dee790015a3..7b93db89c0f 100644
--- a/arch/arm/mach-tegra/tegra124/Makefile
+++ b/arch/arm/mach-tegra/tegra124/Makefile
@@ -6,6 +6,7 @@
 #
 
 obj-$(CONFIG_XPL_BUILD) += cpu.o
+obj-$(CONFIG_$(XPL_)CMD_EBTUPDATE) += bct.o
 
 obj-y	+= clock.o
 obj-y	+= pmc.o
diff --git a/arch/arm/mach-tegra/tegra124/bct.c b/arch/arm/mach-tegra/tegra124/bct.c
new file mode 100644
index 00000000000..a71aa87fce1
--- /dev/null
+++ b/arch/arm/mach-tegra/tegra124/bct.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022, Ramin <raminterex@yahoo.com>
+ * Copyright (c) 2022, Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <command.h>
+#include <log.h>
+#include <vsprintf.h>
+#include <asm/arch-tegra/crypto.h>
+#include "bct.h"
+#include "uboot_aes.h"
+
+/* Device with "sbk burned: false" will expose zero key */
+const u8 nosbk[AES128_KEY_LENGTH] = { 0 };
+
+/*
+ * @param  bct		boot config table start in RAM
+ * @param  ect		bootloader start in RAM
+ * @param  ebt_size	bootloader file size in bytes
+ * Return: 0, or 1 if failed
+ */
+static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
+{
+	struct nvboot_config_table *bct_tbl = NULL;
+	u8 ebt_hash[AES128_KEY_LENGTH] = { 0 };
+	u8 bct_hash[AES128_KEY_LENGTH] = { 0 };
+	u8 sbk[AES128_KEY_LENGTH] = { 0 };
+	u8 *sbct = bct + UBCT_LENGTH;
+	bool encrypted;
+	int ret;
+
+	ebt_size = roundup(ebt_size, EBT_ALIGNMENT);
+
+	memcpy(sbk, (u8 *)(bct + UBCT_LENGTH + SBCT_LENGTH),
+	       NVBOOT_CMAC_AES_HASH_LENGTH * 4);
+
+	encrypted = memcmp(&sbk, &nosbk, AES128_KEY_LENGTH);
+
+	if (encrypted) {
+		ret = decrypt_data_block(sbct, SBCT_LENGTH, sbk);
+		if (ret)
+			return 1;
+
+		ret = encrypt_data_block(ebt, ebt_size, sbk);
+		if (ret)
+			return 1;
+	}
+
+	ret = sign_enc_data_block(ebt, ebt_size, ebt_hash, sbk);
+	if (ret)
+		return 1;
+
+	bct_tbl = (struct nvboot_config_table *)bct;
+
+	memcpy((u8 *)&bct_tbl->bootloader[0].crypto_hash,
+	       ebt_hash, NVBOOT_CMAC_AES_HASH_LENGTH * 4);
+	bct_tbl->bootloader[0].entry_point = CONFIG_SPL_TEXT_BASE;
+	bct_tbl->bootloader[0].load_addr = CONFIG_SPL_TEXT_BASE;
+	bct_tbl->bootloader[0].length = ebt_size;
+
+	if (encrypted) {
+		ret = encrypt_data_block(sbct, SBCT_LENGTH, sbk);
+		if (ret)
+			return 1;
+	}
+
+	ret = sign_enc_data_block(sbct, SBCT_LENGTH, bct_hash, sbk);
+	if (ret)
+		return 1;
+
+	memcpy((u8 *)&bct_tbl->crypto_hash, bct_hash,
+	       NVBOOT_CMAC_AES_HASH_LENGTH * 4);
+
+	return 0;
+}
+
+static int do_ebtupdate(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	u32 bct_addr = hextoul(argv[1], NULL);
+	u32 ebt_addr = hextoul(argv[2], NULL);
+	u32 ebt_size = hextoul(argv[3], NULL);
+
+	return bct_patch((u8 *)bct_addr, (u8 *)ebt_addr, ebt_size);
+}
+
+U_BOOT_CMD(ebtupdate,	4,	0,	do_ebtupdate,
+	   "update bootloader on re-crypted Tegra124 devices",
+	   ""
+);
diff --git a/arch/arm/mach-tegra/tegra124/bct.h b/arch/arm/mach-tegra/tegra124/bct.h
new file mode 100644
index 00000000000..eb0f712d595
--- /dev/null
+++ b/arch/arm/mach-tegra/tegra124/bct.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _BCT_H_
+#define _BCT_H_
+
+/*
+ * Defines the BCT parametres for T124
+ */
+#define UBCT_LENGTH		0x6b0  /* bytes */
+#define SBCT_LENGTH		0x1950 /* bytes */
+
+#define BCT_HASH		0x10
+#define EBT_ALIGNMENT		0x10
+
+/*
+ * Defines the CMAC-AES-128 hash length in 32 bit words. (128 bits = 4 words)
+ */
+#define NVBOOT_CMAC_AES_HASH_LENGTH		4
+
+/*
+ * Defines the RSA modulus length in 32 bit words used for PKC secure boot.
+ */
+#define NVBOOT_SE_RSA_MODULUS_LENGTH		64
+
+/*
+ * Defines the maximum number of bootloader descriptions in the BCT.
+ */
+#define NVBOOT_MAX_BOOTLOADERS			4
+
+struct nv_bootloader_info {
+	u32 version;
+	u32 start_blk;
+	u32 start_page;
+	u32 length;
+	u32 load_addr;
+	u32 entry_point;
+	u32 attribute;
+
+	/* Specifies the AES-CMAC MAC or RSASSA-PSS signature of the BL. */
+	u32 crypto_hash[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 bl_rsa_sig[NVBOOT_SE_RSA_MODULUS_LENGTH];
+};
+
+struct nvboot_config_table {
+	u32 ubct_unused1[196];
+	u32 crypto_hash[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 ubct_unused2[228];
+
+	u32 sbct_unused1[1318];
+	u32 bootloader_used;
+	struct nv_bootloader_info bootloader[NVBOOT_MAX_BOOTLOADERS];
+	u32 sbct_unused2;
+};
+
+#endif /* _BCT_H_ */
-- 
2.43.0

