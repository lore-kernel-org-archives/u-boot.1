Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91471CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ACC5848D8;
	Mon,  1 Jun 2026 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="ZP2IOlbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A851D846D3; Mon,  1 Jun 2026 10:04:33 +0200 (CEST)
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch
 [79.135.106.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C06A6846F8
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780301070; x=1780560270;
 bh=EtpuDUQ+uv7kSTk0g9w/xI3Hc92X6fJJnVCpN3WCktY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZP2IOlbj6b9KSSCkgWuJEaIK2awVJrwOrQDsHtC1A/sawBcR0YekVxZney+5iLUcG
 ExDuGRwZPVeQNx/BeUPMvrLLi4ZZNOblGE+F3kktY6pvG0TE8XhwCOBNXXnwH/IlG5
 VjPFTBEsbGOK8kvmocNV2wKQgbz9lMxodn9BrX1RJ4Wk0/vBrWjuT9cwj4u5p+AWQZ
 j9VZhN4a82MHvhNhqo4nohYd4lRoGDmiVg00TfSSKa36ejWoGSV81pqBFhmYFsShdx
 CM/IEen7/Je7wuB9Yg1OkRufXhV9Yst+5W2TeTp5XT90mwSCc6cVxjJx5f/Ntj8dYA
 q7aWKm4tajb+g==
Date: Mon, 01 Jun 2026 08:04:23 +0000
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
Subject: [PATCH 06/16] mach-snapdragon: introduce ARCH_SNAPDRAGON_ARM32
Message-ID: <20260601-qcom-armv7-v1-6-c4b7f7aae1eb@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
References: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 7448b5f261ba624618e7d86b79bd233ca36888e0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

This config symbol lays the groundwork for arm32 support in the
Snapdragon board code.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/Kconfig                 | 11 ++++++-----
 arch/arm/mach-snapdragon/Kconfig |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 514bf2000b4..0847985a367 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1134,7 +1134,8 @@ config ARCH_RENESAS
=20
 config ARCH_SNAPDRAGON
 =09bool "Qualcomm Snapdragon SoCs"
-=09select ARM64
+=09select ARM64 if !ARCH_SNAPDRAGON_ARM32
+=09select CPU_V7A if ARCH_SNAPDRAGON_ARM32
 =09select DM
 =09select DM_GPIO
 =09select DM_SERIAL
@@ -1148,11 +1149,11 @@ config ARCH_SNAPDRAGON
 =09select BOARD_LATE_INIT
 =09select OF_BOARD
 =09select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
-=09select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+=09select LINUX_KERNEL_IMAGE_HEADER if ARM64 && !ENABLE_ARM_SOC_BOOT0_HOOK
 =09select SYSRESET
-=09select SYSRESET_PSCI
-=09select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
-=09select MMU_PGPROT
+=09select SYSRESET_PSCI if ARM64
+=09select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR if ARM64
+=09select MMU_PGPROT if ARM64
 =09imply OF_UPSTREAM
 =09imply CMD_DM
 =09imply DM_USB_GADGET
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kc=
onfig
index d3de8693b5a..e663b0015c7 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -1,5 +1,11 @@
 if ARCH_SNAPDRAGON
=20
+config ARCH_SNAPDRAGON_ARM32
+=09bool "Build Snapdragon support for ARMv7-A SoCs"
+=09help
+=09  Enable this when building U-Boot for older 32-bit Snapdragon
+=09  platforms, such as the MSM8960 family.
+
 config SYS_SOC
 =09default "snapdragon"
=20

--=20
2.54.0


