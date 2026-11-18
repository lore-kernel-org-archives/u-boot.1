Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BD606A335
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N+N7SzNV;
	dkim=pass (2048-bit key) header.d=e-labworks-com.20260707.gappssmtp.com header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oqaCFEdX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C3B080D10;
	Wed, 18 Nov 2026 17:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QVvqYcW5RAb; Wed, 18 Nov 2026 17:43:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3D8B80D1E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795023806;
	b=gozrWMEz46djn++LDKRy16CnXZvaP3KKgrJYKFQ6kg2NiyHtVJi40LfUCbHcQNwQKwqt
	 /rZ7AxaL0quEysEGxbrZkeIi3h0GfGk0b1IbOP6xBm/PJOMrFaW9fSZOiTUxu6RMKL6GE
	 ADkwkCpqxF7egey2XUw19ItbrIkT56jyEpgrvfKGXSmWNLMlieDJiPplihTiZyRjoX4WT
	 rCG6AX9ZfBbY8wdQ7ZAkEQ9XFHOhHG+ECBWrkAwbvdCRWhOX69tXotmnICL9EaFmNbM42
	 geY2rLNNNZlLHMnf90MqWebbHsqK4dtatOhngWvIERKbqiro0hqiPRUQIVANOg2I+ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795023806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Yk9/wwJW3muVr4+MoQx3QUma4sicEUgEXhB25JqzkYA=;
	b=dfdCugjF70etTcr/d6i5CcInR14QNbg7tfgt37TWE4tgkwODAIMKRbrh61hG2zYwWM1i
	 e6o+w67u5QEqGZrn3HtCNclmPP3IEaI8W2bz/A469XvAtxQv7lnVljyLuP/89nrNIhRHm
	 aV1WsYc7PXTfMKX5P7S5E/9sxVxUasjw5MDsE4qVHgW/9/2neMOC525TJaT2u2Z6uDYMJ
	 RCmmY/BsKGJ+J8H0ej++Q2GYQWZambWQLDl1rX4Viy3DXFNVKY/PZZltzNIrhC8koP/kR
	 pFHjilCi+Gd/tbXqChj772mFTxYl5XpixYVYaBhRMCHepLOJeR13tsZAoZkt24a4fNw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=fail header.from=e-labworks.com;
	dkim=pass header.d=e-labworks-com.20260707.gappssmtp.com header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oqaCFEdX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795023805;
	bh=Yk9/wwJW3muVr4+MoQx3QUma4sicEUgEXhB25JqzkYA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=N+N7SzNV7YcWryI7km+Tc2osPuHD7u3EAw+T1whxHbdfYy63q+Rh+0ZjNkBg6NUek
	 mhJgl4mu/Ud4DvauSagzLCTu7tS1FSTdRNXTvlPsj9JohXmWYtzULZ0hmMIYh/2HXD
	 2572QzBvRbwMbtcen6aWmqURf8BQx6RHcmjYgMG9zHA7jTDir6mInl+eF9XPGUrWIt
	 iehJBUqA9ZKbI2BkW95wSCEY6bbRWd5FeEV5dwMm9s12BPkTA3C/wkOENl6nn/aATW
	 8HVkOvYFRqYHE4cHJSOrzQN8jYV5wsa+ss0cJ0d6IGrkQtZdI9z7AX2UhHqaXt9thJ
	 LxdznaFjlbTGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3D8B80D1E;
	Wed, 18 Nov 2026 17:43:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E761E49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9A2D80D1E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 06V_KB_yCvqQ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C393980D10
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com;
 envelope-from=sergio.prado@e-labworks.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20260707.gappssmtp.com
 header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=oqaCFEdX
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C393980D10
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:43:22 +0000 (UTC)
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-1a2af4c8d00so2576505c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20260707.gappssmtp.com; s=20260707; t=1795023801; x=1795628601;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yk9/wwJW3muVr4+MoQx3QUma4sicEUgEXhB25JqzkYA=;
 b=oqaCFEdXaeI1skZHYAeDBIcX+eaurKy3OpVSPO7HRYHQ9oIi93CoZ2+un0TNAi1rmo
 wNTOgF63ucwRDvrGBq+6zZjeXI77ehVcQThkJc8Z/FEgI5yLtW7YGtm+5+3d+O7h+VPj
 znwe2B7R68XTjec+TMjRLbeS/vIFL0wYeyrb8bzjcpQBIWzw4dAXoMZdXKhL7imC5aOD
 mSFfE8WFW+Lgq7ANKzCzpF4ZmF/p1U3oOEuhhfPVH8gLXImqtk7TjviJaEPmuagrTzlh
 kLlsEBdxqDqaiYIAa6O3/tknVzZgoQn4luYx4uTq+JxTuENQzptRpWtSNDXrQjo/PHuK
 Hldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023801; x=1795628601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yk9/wwJW3muVr4+MoQx3QUma4sicEUgEXhB25JqzkYA=;
 b=Rad8/mKWKvbJgOS1APQu6BCHRQkW8i1iJtPfNac0drciL0Rel1ZAHnzfA0o8Xo5a3A
 FKLNIWbw2Rl4usDm1dYt/3aDDkSiFehJnV29he07QQMtxy3JI5TAiIsHl8fuMD+Ur4CN
 LAKkPRkuYzAS1qxQZLbvaWefn0lU7b0dgCfUg38n4atJoiq2rD/IM6Rwl+qCblQj438M
 QrMzQtgFCnbK6tAHL9cZ6Zg1AxdM14zHQ/1xM7lgvsQ6/exA3sIUub5a9jx9KkaRY9HD
 D+62SWF+u5Q6qQY+VbBKG9NM9YhjUO3t8tb2vRV9RE447Nvp2Usu817B04Ooplq2SOxK
 FR8A==
X-Gm-Message-State: APuU4Z/jMVst2c33cq/l2ddHl0awb+gixG3Q37HNps+SaaDw9Ww9MkYy
 DgfSmM0vqcXysZlnK9evUuOk06pWHziyJCrqSUI2x3lrgoRZgnrF/BwCosnPEh7oktNNZABm4RV
 RN7Hy
X-Gm-Gg: AYBFou30NLe06sQEicfNOCiLefBhYIG6MwdTpx/z/+QgeNs9ECpRx+fhzXDQ00vHb7V
 9zp+HG/NSZIEBUBSHx3wZ5T4dxUuvVq5LbkUjzZLFRFz9M9pPiMZ33vjPE/N1DuS+6/S9/RLIQg
 gnsKM0vj6E0ZhdZqUNI5CXghHxo7HvLwGQmT5SAQlcQYuDLPyzmD3DFeTEmmTjJiqRrzaLJ2YWs
 9Vj/RxCMgIHGxmmaOPrYMXNtjw9xmm1lPVO9Fzh9q8cnglWOluUPa/1RlAR+DKRjQlTAj/Cdalg
 8BFQSDBNvn1xOGyXleYhr1THGGVIq9J1nvN5svxG9385nNDvZ+kSztimtF2wQUIdHwnF8n+yONP
 aNXQ5+YmJ+z8gyq1Vf8XKNt7Hs4VU0DrUd9NhZlaf/LWiZf9GtJP1W4FZrfKF2RGP5+CY35sy4k
 rJBlID2+TWcEw4s4A7WFh0EqjkgXAwKKGK28DxnckOfbczSCn0FmTxx6ZpZHUJQsUVowZZ0sSiU
 arsTfgY8V7daxXZEkUcVse/t5MuJzAoCoYvJkIvgqOSB73a1mUZLTRujnmvWM32jjdm/NILJi86
 EkCXUolAMbvi49mQ0puPO8nSYE7Andp4sCj8
X-Received: by 2002:a05:7022:f90b:b0:1b0:166c:6a94 with SMTP id
 a92af1059eb24-1b543d11160mr2797455c88.28.1795023801257; 
 Wed, 18 Nov 2026 09:43:21 -0800 (PST)
Received: from desktop.. ([2804:7f0:6400:bd84:18c3:e951:40b8:2272])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447dc5e9sm11580617c88.11.2026.11.18.09.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:43:20 -0800 (PST)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.u-boot-project.org
Cc: francesco.dolcini@toradex.com, festevam@gmail.com, sbabic@nabladev.com,
 uboot-imx@nxp.com, trini@konsulko.com, marex@nabladev.com,
 o.mandel@menlosystems.com, Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v2] board: toradex: verdin-imx8mm: adjust U-Boot proper offset
 for eMMC fastboot
Date: Wed, 18 Nov 2026 14:42:55 -0300
Message-Id: <20261118174255.3388175-1-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Verdin iMX8MM boots from the eMMC boot partitions with the eMMC
fast boot fuse enabled, so the boot ROM loads flash.bin from offset
1 KiB instead of the usual 33 KiB. The SPL loads U-Boot proper from the
fixed sector CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, so the board
device tree moved the FIT in flash.bin to 0x5fc00 to compensate.

That override only works while the fit node is placed directly in the
binman section. With CONFIG_IMX_HAB, imx8mm-u-boot.dtsi wraps the FIT
in an nxp-imx8mcst node with its own offset of 0x57c00, which takes
precedence, so a signed flash.bin has the FIT at 0x57c00. When booting
from eMMC, the SPL does not find the FIT at the expected sector, treats
the data there as a raw U-Boot image and fails to authenticate it:

  Authenticate image from DDR location 0x40200000...
  bad magic magic=0x75 length=0x206d version=0x63
  bad length magic=0x75 length=0x206d version=0x63
  bad version magic=0x75 length=0x206d version=0x63
  Error: Invalid IVT structure

Drop the FIT offset override and set
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR to 0x2c0 instead. With flash.bin
at 1 KiB and the FIT at the default 0x57c00, U-Boot proper starts at
0x58000, which is sector 0x2c0, with or without HAB. Do the same for
the MX8Menlo, which uses the same module and includes the Verdin U-Boot
device tree.

Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
Changes in v2:
- Drop the runtime check of the eMMC fast boot fuse and set
  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR to 0x2c0 in the defconfigs
  instead, since the Verdin iMX8MM always boots from the eMMC boot
  partition with fast boot enabled (suggested by Francesco).

Tested on a Verdin iMX8M Mini booting from the eMMC boot partition,
without CONFIG_IMX_HAB on this tree and with CONFIG_IMX_HAB on
v2026.07. The MX8Menlo was build-tested only.

 arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi | 4 ----
 configs/imx8mm-mx8menlo_defconfig               | 2 +-
 configs/verdin-imx8mm_defconfig                 | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 183de46f66a8..2dd80338c0c0 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -35,10 +35,6 @@
 	bootph-pre-ram;
 };
 
-&binman_imx_fit {
-	offset = <0x5fc00>;
-};
-
 &gpio1 {
 	bootph-pre-ram;
 };
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index b3ba43a73a2b..2ce1854f9296 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -52,7 +52,7 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x2c0
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index c4aa0cf10d4e..9c279b577b66 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -47,7 +47,7 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x2c0
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
-- 
2.34.1

