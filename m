Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5154ACD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDDA8493F;
	Mon,  1 Jun 2026 14:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZpgR7JbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D6D68487F; Mon,  1 Jun 2026 10:12:59 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD0684852
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 58BC044650;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 382D7C2BCFB;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301572;
 bh=6R0f9KbCcC6LHFQOAljn19sM7qiPZjVLZbQiR8jnwq0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ZpgR7JbIopzDOm4YJD/YFOqN3ck3VtEr6MFn1XfFnOvxnDsbImoM8Duq5nu6Jb6U8
 6olKdXDvTBsX2/O9VipghfoOU30NwhOJiIZJHPpM0qsbTO708CU6S0eBQ9gI2Ka+de
 VyB8Kt90NL242GmMR+d5JvyGF8Xq6LtOBponSgkhfmJ7P6KlcSA+rKysA9VkaMbWCa
 lA5ahcMv9bs+eIAzRYpwEaxpdiNqZ58wHqYEoPHGavFTak31acVfedytvF6VXONIq6
 ZeSeYf2blvWsrsmozNf1Mp3fH5vzjpniC4IndkH4XgUYO3MxXdEx4wZptRGIi7X3bl
 ODrNP6YQ+iF/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2EFCD6E60;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:47 +1000
Subject: [PATCH RESEND 06/16] mach-snapdragon: introduce ARCH_SNAPDRAGON_ARM32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-6-05a08d87e476@samcday.com>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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
 Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=1775;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=CeQPeO7BRJn6Vqd3ZzjZhpN9ywFiQJrT8v1EeDohT0w=;
 b=JFpVi8NeqYEBoFlfy88EhE2INqOUNfzpB9nzTMtZo+gBxpqBaiVY6VdcBYTItUYzav6HqT6df
 8PynJM+l943BEwSY7xOnX0+zZ5uRieaB66gaLfoJvoIT5zj4xtcm5CK
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

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
 
 config ARCH_SNAPDRAGON
 	bool "Qualcomm Snapdragon SoCs"
-	select ARM64
+	select ARM64 if !ARCH_SNAPDRAGON_ARM32
+	select CPU_V7A if ARCH_SNAPDRAGON_ARM32
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
@@ -1148,11 +1149,11 @@ config ARCH_SNAPDRAGON
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
-	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+	select LINUX_KERNEL_IMAGE_HEADER if ARM64 && !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI
-	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
-	select MMU_PGPROT
+	select SYSRESET_PSCI if ARM64
+	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR if ARM64
+	select MMU_PGPROT if ARM64
 	imply OF_UPSTREAM
 	imply CMD_DM
 	imply DM_USB_GADGET
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index d3de8693b5a..e663b0015c7 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -1,5 +1,11 @@
 if ARCH_SNAPDRAGON
 
+config ARCH_SNAPDRAGON_ARM32
+	bool "Build Snapdragon support for ARMv7-A SoCs"
+	help
+	  Enable this when building U-Boot for older 32-bit Snapdragon
+	  platforms, such as the MSM8960 family.
+
 config SYS_SOC
 	default "snapdragon"
 

-- 
2.54.0


