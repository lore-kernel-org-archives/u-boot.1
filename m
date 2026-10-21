Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95597606BF18
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UaMnFsKN;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=Jtgq9sZT;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=yECbhXRU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4ACC060ACF;
	Wed, 21 Oct 2026 16:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ulAx_OxBrstJ; Wed, 21 Oct 2026 16:16:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EEADD60A62
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599389;
	b=YjttaWQ9ItUvjOEdoqfYiFfhO4Mhftc2eHHWaDZ2ONz3EFrc43ZHp9cgbygNOppwNIYa
	 xLoXAh8tFRBgKse+9P54z38klnV0FsVqpRngvm9Tm5AqgHWtRIB61Q6GKdb9vUEAchpc9
	 NEvhoV+Gn93t+0SZ1vk+3Luhh7GASdBxlXTqPdVXd/8KStj+MoJmrloPSp+89SRjS3InY
	 FWTvMhcOsUGQ7PoN3+W0Dum8spe7marynDtLuwYSnPgIAVBOw8T+dCrOCHwRIGUtSeUK8
	 1VFTNoRIZWSCNdJNm/rE9Hv5HTACRV4AWuUhQwtQWibvhTVqD7+BwLJQjAPocAI5GIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qiRopueyvWrTwZYw/9jsPIFQh/uKQL81oBU+NdRbmTk=;
	b=Ht6DQqv0LrKPh9Kss3F+7ByoJd9RVQ7nhHty9SPqOdbBjUEHlmF3jJWbE4TFArM02ck/
	 de1tDCJ7Vx+z7av0Jyb1iZWMVOMoS/yyTRx0ifTP7N14c462EhIsRQUxN5fzj0/3K3LXB
	 I1f5r/XGgaU3XpYAcrGLEb7tDPOOf4g4a/zsfIqRekDQ0oScCH3/LaDoprf2w2GEN+mCw
	 SUVCX1uqq9CdKrGEdRVEBjrIbMpqUo2O3gS/zPZzbYnzQDplRdTqxbspmE3gAGxMC53zG
	 saG61gAKk7/3Neb3WWzQ1JbxGI1mpXc4sRPemklSD0sXZS6Y5qii2Vm+GeMsfSW6IWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599389;
	bh=qiRopueyvWrTwZYw/9jsPIFQh/uKQL81oBU+NdRbmTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UaMnFsKNft+TO4mSz00qoHGrCCGh8pLaTmXnQkIvHHvF0mDlQUwdl1IfN6vEqVr9S
	 5kIsIjaXbOqyl5cNDNCPDyMBwN6K0IzKJa48dvem5KR6gdCnyfbGPcvwYwfBibpCSU
	 yF9EH4lwWxFI/HHPdW3x6Tuz09xCZ8Jc1bQ5BdAHz3lKQgz65kSF2sDSFVsgHLVO68
	 Rd6PZNO3ocXup+PAheNqv59Q3NDP1H2Dkp1H24///BV9UIR8bOzlsPuWuXXYEi/8EB
	 BoObjYrKabCIy9dLwk5ayMLhmQASciXSNR8XNM6uPNjxRwpo9354eiGP7CP+I6q2u+
	 IpNw0XqqfjHTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEADD60A62;
	Wed, 21 Oct 2026 16:16:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 4BCA295C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 3D59540889
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id HYPwFJfvSCiA for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0DC1A40877
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598517;
 b=GuyN/1zPG5d7aetJpbMQm/hoorMoDRv6fmE1RH7M46wHGHQXcqY8XRYiWMmQ32YhOlDL
 t44vwFT6wzEBkpGU6ZFKd9Jg2IDrLeC+G1TAlLq6RqjJktYOxoGfFea64uTGl/EEJI4tp
 2/0aEPDntbQUs2FOneoA+fRDlYU9K0fFw3LupfTrqtLKYMgYUyFUIOHXA5Dz4K/F3TG73
 YvRb4RsSpYh0MlQ4PQwYnCfRSh7bUCJU8E07r49DxD6x/qCnchr711xEpszmuqsW129r7
 uk1JxqAnJNz8kFYl1r/t+aTvPsLeZAO4aWtmIyy+GF44G3jdGXzE01dtXt54/UZD4QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598517;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qiRopueyvWrTwZYw/9jsPIFQh/uKQL81oBU+NdRbmTk=;
 b=cCqKME64f89q0K25c4Qp5G76lXbPUxIc3YUcPJ2dUGNRJuTHUkHz1jKqojKf7/xyoM35
 /Pq6s7GAPduOwgtYyNOVWa5d0ZM70+Zm/wiSuzddcKWFB8rUO8z7l7qJGoRLT7uYFUkOf
 Fc8aCc+Xo+66wJ09Qgf0+mYu/iQgpVwBGucoxUyGxV4Mbo7LMjDFsb526PNvmTpMzY2lM
 ivenDg9Y3jvghbjixxEdM8WXNWoQfm8QaG3D5n/0Zulh4sBW0c/HqUXjyAx3ugkaR+PKm
 1ZPo/2xVYn6uR5rAFXG3J2ulKG9B4ljMkavQAQKHHeJholFP4g0zIB88IC34P0CoYUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=Jtgq9sZT; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=yECbhXRU; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=Jtgq9sZT; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=yECbhXRU
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 0DC1A40877
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598510; bh=qiRopueyvWrTwZYw/9jsPIF
 Qh/uKQL81oBU+NdRbmTk=; b=Jtgq9sZT0pCoj2o7y2kbsWVtWDuY+9KHNFVysywFOADCx89Wfh
 pfrEWSzcu/69FKSnA81mQXaTarsWhuc/nxEauJMrYtjgjU3RxefDqujyWe9YuW9sSquzhvMpQeo
 Pyloij7eTYg7HHEkkG/C7+yZNzL7yHuGD9OA0029+FzDTfRhqU7LsdtVBiVeUeRmjZ4ETfufFEU
 0GmPS3zsLLQrapQmdzEgS6gYrUmNKYkwPizMHcv66OtuqV5xIngiMKZEjd5ZwAvjUDMiE942wKn
 US7I4B4Yl35MhxE+0bSKIQXqZWHsEFeO9+u1k45gLZA+NkwVLv9qJQspXOC7gl+X+AA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598510; bh=qiRopueyvWrTwZYw/9jsPIF
 Qh/uKQL81oBU+NdRbmTk=; b=yECbhXRU+y79CLU9QhzUw6VCDchzUFPScVPJI2afpWonUXaoHj
 WxeKlNnTbrUx7EOKfK5olx3pWvMvM1X1kNCQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>, Mario Six <mario.six@gdsys.cc>,
 Sinan Akman <sinan@writeme.com>
Subject: [PATCH v3 11/26] powerpc: mpc83xx: Remove MPC837x support
Date: Wed, 21 Oct 2026 16:01:07 +0000
Message-ID: <20261021160145.10430-12-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160145.10430-1-brads@mainlining.org>
References: <20261021160145.10430-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 16:16:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MPC837XERDB was the last user in the tree of ARCH_MPC837X. With that
board removed, nothing selects the SoC option now.

Drop its unmaintained clock, CPU, reset and peripheral support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc83xx/Kconfig              |  20 ---
 arch/powerpc/cpu/mpc83xx/cpu.c                |   3 -
 arch/powerpc/cpu/mpc83xx/hid/Kconfig          |   4 +-
 arch/powerpc/cpu/mpc83xx/hrcw/Kconfig         |  52 ++++----
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr |   2 +-
 arch/powerpc/cpu/mpc83xx/speed.c              |  57 ++-------
 arch/powerpc/include/asm/arch-mpc83xx/gpio.h  |   2 +-
 arch/powerpc/include/asm/arch-mpc83xx/soc.h   |  16 +--
 arch/powerpc/include/asm/global_data.h        |   8 +-
 arch/powerpc/include/asm/immap_83xx.h         |  45 -------
 arch/powerpc/include/asm/mpc8xxx_spi.h        |   3 +-
 doc/README.sata                               |  68 ----------
 .../clock/fsl,mpc83xx-clk.txt                 |   3 +-
 doc/device-tree-bindings/cpu/fsl,mpc83xx.txt  |   3 +-
 drivers/clk/mpc83xx_clk.c                     |   1 -
 drivers/clk/mpc83xx_clk.h                     |  11 +-
 drivers/cpu/mpc83xx_cpu.c                     |  13 --
 drivers/cpu/mpc83xx_cpu.h                     |  11 --
 drivers/ram/mpc83xx_sdram.c                   |  12 +-
 include/mpc83xx.h                             | 120 +-----------------
 20 files changed, 58 insertions(+), 396 deletions(-)
 delete mode 100644 doc/README.sata

diff --git a/arch/powerpc/cpu/mpc83xx/Kconfig b/arch/powerpc/cpu/mpc83xx/Kconfig
index 088283d646c..daae933e52e 100644
--- a/arch/powerpc/cpu/mpc83xx/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/Kconfig
@@ -103,15 +103,9 @@ config MPC83XX_TSEC2_SUPPORT
 config MPC83XX_PCIE1_SUPPORT
 	bool
 
-config MPC83XX_PCIE2_SUPPORT
-	bool
-
 config MPC83XX_SDHC_SUPPORT
 	bool
 
-config MPC83XX_SATA
-	bool
-
 config MPC83XX_SECOND_I2C
 	bool
 
@@ -162,20 +156,6 @@ config ARCH_MPC8360
 	select MPC83XX_SECOND_I2C
 	select SYS_CACHE_SHIFT_5
 
-config ARCH_MPC837X
-	bool
-	select MPC83XX_PCI_SUPPORT
-	select MPC83XX_TSEC1_SUPPORT
-	select MPC83XX_TSEC2_SUPPORT
-	select MPC83XX_PCIE1_SUPPORT
-	select MPC83XX_PCIE2_SUPPORT
-	select MPC83XX_SDHC_SUPPORT
-	select MPC83XX_SATA
-	select MPC83XX_LDP_PIN
-	select MPC83XX_SECOND_I2C
-	select SYS_CACHE_SHIFT_5
-	select FSL_ELBC
-
 source "arch/powerpc/cpu/mpc83xx/hrcw/Kconfig"
 source "arch/powerpc/cpu/mpc83xx/bats/Kconfig"
 source "arch/powerpc/cpu/mpc83xx/lblaw/Kconfig"
diff --git a/arch/powerpc/cpu/mpc83xx/cpu.c b/arch/powerpc/cpu/mpc83xx/cpu.c
index 3c8cbd4252d..f8e9f716936 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu.c
@@ -61,9 +61,6 @@ int checkcpu(void)
 		CPU_TYPE_ENTRY(8358_TBGA_),
 		CPU_TYPE_ENTRY(8358_PBGA_),
 		CPU_TYPE_ENTRY(8360),
-		CPU_TYPE_ENTRY(8377),
-		CPU_TYPE_ENTRY(8378),
-		CPU_TYPE_ENTRY(8379),
 	};
 
 	immr = (immap_t *)CONFIG_SYS_IMMR;
diff --git a/arch/powerpc/cpu/mpc83xx/hid/Kconfig b/arch/powerpc/cpu/mpc83xx/hid/Kconfig
index 9473213bac4..e733a59d021 100644
--- a/arch/powerpc/cpu/mpc83xx/hid/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/hid/Kconfig
@@ -434,7 +434,7 @@ config HID2_IWLCK_1
 config HID2_IWLCK_2
 	bool "Way 0 through 2 locked"
 
-if ARCH_MPC8360 || ARCH_MPC837X
+if ARCH_MPC8360
 
 config HID2_IWLCK_3
 	bool "Way 0 through 3 locked"
@@ -470,7 +470,7 @@ config HID2_DWLCK_1
 config HID2_DWLCK_2
 	bool "Way 0 through 2 locked"
 
-if ARCH_MPC8360 || ARCH_MPC837X
+if ARCH_MPC8360
 
 config HID2_DWLCK_3
 	bool "Way 0 through 3 locked"
diff --git a/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig b/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
index 0fc3b7765f2..49d5db098f7 100644
--- a/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
@@ -7,7 +7,7 @@ config LBMC_CLOCK_MODE_1_1
 	bool "1 : 1"
 
 config LBMC_CLOCK_MODE_1_2
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "1 : 2"
 
 endchoice
@@ -19,7 +19,7 @@ config DDR_MC_CLOCK_MODE_1_2
 	bool "1 : 2"
 
 config DDR_MC_CLOCK_MODE_1_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "1 : 1"
 
 endchoice
@@ -30,7 +30,6 @@ choice
 	prompt "System PLL VCO division"
 
 config SYSTEM_PLL_VCO_DIV_1
-	depends on !ARCH_MPC837X
 	bool "1"
 
 config SYSTEM_PLL_VCO_DIV_2
@@ -67,39 +66,39 @@ config SYSTEM_PLL_FACTOR_6_1
 	bool "6 : 1"
 
 config SYSTEM_PLL_FACTOR_7_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "7 : 1"
 
 config SYSTEM_PLL_FACTOR_8_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "8 : 1"
 
 config SYSTEM_PLL_FACTOR_9_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "9 : 1"
 
 config SYSTEM_PLL_FACTOR_10_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "10 : 1"
 
 config SYSTEM_PLL_FACTOR_11_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "11 : 1"
 
 config SYSTEM_PLL_FACTOR_12_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "12 : 1"
 
 config SYSTEM_PLL_FACTOR_13_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "13 : 1"
 
 config SYSTEM_PLL_FACTOR_14_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "14 : 1"
 
 config SYSTEM_PLL_FACTOR_15_1
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "15 : 1"
 
 config SYSTEM_PLL_FACTOR_16_1
@@ -391,10 +390,6 @@ config BOOT_ROM_INTERFACE_PCI1
 	depends on MPC83XX_PCI_SUPPORT
 	bool "PCI1"
 
-config BOOT_ROM_INTERFACE_ON_CHIP_BOOT_ROM
-	depends on ARCH_MPC837X
-	bool "PCI2"
-
 config BOOT_ROM_INTERFACE_GPCM_8BIT
 	bool "Local bus GPCM - 8-bit ROM"
 
@@ -402,7 +397,7 @@ config BOOT_ROM_INTERFACE_GPCM_16BIT
 	bool "Local bus GPCM - 16-bit ROM"
 
 config BOOT_ROM_INTERFACE_GPCM_32BIT
-	depends on ARCH_MPC8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360
 	bool "Local bus GPCM - 32-bit ROM"
 
 config BOOT_ROM_INTERFACE_NAND_FLASH_8BIT_SMALL
@@ -431,11 +426,11 @@ config TSEC1_MODE_RGMII
 	bool "RGMII"
 
 config TSEC1_MODE_RTBI
-	depends on ARCH_MPC831X || ARCH_MPC837X
+	depends on ARCH_MPC831X
 	bool "RTBI"
 
 config TSEC1_MODE_SGMII
-	depends on ARCH_MPC831X || ARCH_MPC837X
+	depends on ARCH_MPC831X
 	bool "SGMII"
 
 endchoice
@@ -458,11 +453,11 @@ config TSEC2_MODE_RGMII
 	bool "RGMII"
 
 config TSEC2_MODE_RTBI
-	depends on ARCH_MPC831X || ARCH_MPC837X
+	depends on ARCH_MPC831X
 	bool "RTBI"
 
 config TSEC2_MODE_SGMII
-	depends on ARCH_MPC831X || ARCH_MPC837X
+	depends on ARCH_MPC831X
 	bool "SGMII"
 
 endchoice
@@ -540,12 +535,12 @@ config DDR_MC_CLOCK_MODE
 config SYSTEM_PLL_VCO_DIV
 	int
 	default 2 if ARCH_MPC8313 || ARCH_MPC832X
-	default 0 if SYSTEM_PLL_VCO_DIV_2 && !ARCH_MPC8360 && !ARCH_MPC837X
-	default 1 if SYSTEM_PLL_VCO_DIV_4 && !ARCH_MPC8360 && !ARCH_MPC837X
-	default 2 if SYSTEM_PLL_VCO_DIV_8 && !ARCH_MPC8360 && !ARCH_MPC837X
-	default 0 if SYSTEM_PLL_VCO_DIV_4 && (ARCH_MPC8360 || ARCH_MPC837X)
-	default 1 if SYSTEM_PLL_VCO_DIV_8 && (ARCH_MPC8360 || ARCH_MPC837X)
-	default 2 if SYSTEM_PLL_VCO_DIV_2 && (ARCH_MPC8360 || ARCH_MPC837X)
+	default 0 if SYSTEM_PLL_VCO_DIV_2 && !ARCH_MPC8360
+	default 1 if SYSTEM_PLL_VCO_DIV_4 && !ARCH_MPC8360
+	default 2 if SYSTEM_PLL_VCO_DIV_8 && !ARCH_MPC8360
+	default 0 if SYSTEM_PLL_VCO_DIV_4 && ARCH_MPC8360
+	default 1 if SYSTEM_PLL_VCO_DIV_8 && ARCH_MPC8360
+	default 2 if SYSTEM_PLL_VCO_DIV_2 && ARCH_MPC8360
 	default 3 if SYSTEM_PLL_VCO_DIV_1
 
 config SYSTEM_PLL_FACTOR
@@ -610,7 +605,6 @@ config BOOT_ROM_INTERFACE
 	hex
 	default 0x0 if BOOT_ROM_INTERFACE_DDR_SDRAM
 	default 0x4 if BOOT_ROM_INTERFACE_PCI1
-	default 0xc if BOOT_ROM_INTERFACE_ON_CHIP_BOOT_ROM
 	default 0x14 if BOOT_ROM_INTERFACE_GPCM_8BIT
 	default 0x18 if BOOT_ROM_INTERFACE_GPCM_16BIT
 	default 0x1c if BOOT_ROM_INTERFACE_GPCM_32BIT
@@ -648,7 +642,7 @@ config TRUE_LITTLE_ENDIAN
 
 config LALE_TIMING
 	int
-	default 0 if ARCH_MPC830X || ARCH_MPC837X
+	default 0 if ARCH_MPC830X
 	default 0 if LALE_TIMING_NORMAL
 	default 1 if LALE_TIMING_EARLIER
 
diff --git a/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr b/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr
index 33e1295df14..91686b3b8b4 100644
--- a/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr
+++ b/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr
@@ -14,7 +14,7 @@ config SPCR_OPT_SPEC_READ
 
 endchoice
 
-if ARCH_MPC8308 || ARCH_MPC831X || ARCH_MPC837X
+if ARCH_MPC8308 || ARCH_MPC831X
 
 choice
 	prompt "TSEC emergency priority"
diff --git a/arch/powerpc/cpu/mpc83xx/speed.c b/arch/powerpc/cpu/mpc83xx/speed.c
index 0185ab50ad9..a2343c67f28 100644
--- a/arch/powerpc/cpu/mpc83xx/speed.c
+++ b/arch/powerpc/cpu/mpc83xx/speed.c
@@ -88,7 +88,7 @@ int get_clocks(void)
 
 	u32 csb_clk;
 #if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC837X)
+	defined(CONFIG_ARCH_MPC834X)
 	u32 tsec1_clk;
 	u32 tsec2_clk;
 	u32 usbdr_clk;
@@ -117,14 +117,10 @@ int get_clocks(void)
 	u32 qe_clk;
 	u32 brg_clk;
 #endif
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC837X)
+#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
 	u32 pciexp1_clk;
 	u32 pciexp2_clk;
 #endif
-#if defined(CONFIG_ARCH_MPC837X)
-	u32 sata_clk;
-#endif
 
 	if ((im->sysconf.immrbar & IMMRBAR_BASE_ADDR) != (u32) im)
 		return -1;
@@ -151,7 +147,7 @@ int get_clocks(void)
 	sccr = im->clk.sccr;
 
 #if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC837X)
+	defined(CONFIG_ARCH_MPC834X)
 	switch ((sccr & SCCR_TSEC1CM) >> SCCR_TSEC1CM_SHIFT) {
 	case 0:
 		tsec1_clk = 0;
@@ -172,7 +168,7 @@ int get_clocks(void)
 #endif
 
 #if defined(CONFIG_ARCH_MPC830X) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC837X)
+	defined(CONFIG_ARCH_MPC834X)
 	switch ((sccr & SCCR_USBDRCM) >> SCCR_USBDRCM_SHIFT) {
 	case 0:
 		usbdr_clk = 0;
@@ -192,8 +188,7 @@ int get_clocks(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC834X) || \
-	defined(CONFIG_ARCH_MPC837X)
+#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC834X)
 	switch ((sccr & SCCR_TSEC2CM) >> SCCR_TSEC2CM_SHIFT) {
 	case 0:
 		tsec2_clk = 0;
@@ -295,15 +290,12 @@ int get_clocks(void)
 	i2c1_clk = enc_clk;
 #elif defined(CONFIG_FSL_ESDHC)
 	i2c1_clk = sdhc_clk;
-#elif defined(CONFIG_ARCH_MPC837X)
-	i2c1_clk = enc_clk;
 #endif
 #if !defined(CONFIG_ARCH_MPC832X)
 	i2c2_clk = csb_clk; /* i2c-2 clk is equal to csb clk */
 #endif
 
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC837X)
+#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
 	switch ((sccr & SCCR_PCIEXP1CM) >> SCCR_PCIEXP1CM_SHIFT) {
 	case 0:
 		pciexp1_clk = 0;
@@ -341,26 +333,6 @@ int get_clocks(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_MPC837X)
-	switch ((sccr & SCCR_SATA1CM) >> SCCR_SATA1CM_SHIFT) {
-	case 0:
-		sata_clk = 0;
-		break;
-	case 1:
-		sata_clk = csb_clk;
-		break;
-	case 2:
-		sata_clk = csb_clk / 2;
-		break;
-	case 3:
-		sata_clk = csb_clk / 3;
-		break;
-	default:
-		/* unknown SCCR_SATA1CM value */
-		return -11;
-	}
-#endif
-
 	lbiu_clk = csb_clk *
 		   (1 + ((im->clk.spmr & SPMR_LBIUCM) >> SPMR_LBIUCM_SHIFT));
 	lcrr = (im->im_lbc.lcrr & LCRR_CLKDIV) >> LCRR_CLKDIV_SHIFT;
@@ -421,7 +393,7 @@ int get_clocks(void)
 
 	gd->arch.csb_clk = csb_clk;
 #if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC837X)
+	defined(CONFIG_ARCH_MPC834X)
 	gd->arch.tsec1_clk = tsec1_clk;
 	gd->arch.tsec2_clk = tsec2_clk;
 	gd->arch.usbdr_clk = usbdr_clk;
@@ -448,13 +420,9 @@ int get_clocks(void)
 	gd->arch.qe_clk = qe_clk;
 	gd->arch.brg_clk = brg_clk;
 #endif
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC837X)
+#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
 	gd->arch.pciexp1_clk = pciexp1_clk;
 	gd->arch.pciexp2_clk = pciexp2_clk;
-#endif
-#if defined(CONFIG_ARCH_MPC837X)
-	gd->arch.sata_clk = sata_clk;
 #endif
 	gd->arch.pci_clk = pci_sync_in;
 	gd->cpu_clk = gd->arch.core_clk;
@@ -524,7 +492,7 @@ static int do_clocks(struct cmd_tbl *cmdtp, int flag, int argc,
 	       strmhz(buf, gd->arch.sdhc_clk));
 #endif
 #if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC837X)
+	defined(CONFIG_ARCH_MPC834X)
 	printf("  TSEC1:               %-4s MHz\n",
 	       strmhz(buf, gd->arch.tsec1_clk));
 	printf("  TSEC2:               %-4s MHz\n",
@@ -536,16 +504,11 @@ static int do_clocks(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("  USB MPH:             %-4s MHz\n",
 	       strmhz(buf, gd->arch.usbmph_clk));
 #endif
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC837X)
+#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
 	printf("  PCIEXP1:             %-4s MHz\n",
 	       strmhz(buf, gd->arch.pciexp1_clk));
 	printf("  PCIEXP2:             %-4s MHz\n",
 	       strmhz(buf, gd->arch.pciexp2_clk));
-#endif
-#if defined(CONFIG_ARCH_MPC837X)
-	printf("  SATA:                %-4s MHz\n",
-	       strmhz(buf, gd->arch.sata_clk));
 #endif
 	return 0;
 }
diff --git a/arch/powerpc/include/asm/arch-mpc83xx/gpio.h b/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
index df95d2238fd..dd368af7b91 100644
--- a/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
+++ b/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
@@ -8,7 +8,7 @@
  */
 #if defined(CONFIG_ARCH_MPC8313) || defined(CONFIG_ARCH_MPC8308)
 #define MPC83XX_GPIO_CTRLRS 1
-#elif defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC837X)
+#elif defined(CONFIG_ARCH_MPC834X)
 #define MPC83XX_GPIO_CTRLRS 2
 #else
 #define MPC83XX_GPIO_CTRLRS 0
diff --git a/arch/powerpc/include/asm/arch-mpc83xx/soc.h b/arch/powerpc/include/asm/arch-mpc83xx/soc.h
index ce54f9bebbe..d61d3a944f1 100644
--- a/arch/powerpc/include/asm/arch-mpc83xx/soc.h
+++ b/arch/powerpc/include/asm/arch-mpc83xx/soc.h
@@ -15,14 +15,12 @@ enum soc_type {
 	SOC_MPC832X,
 	SOC_MPC8349,
 	SOC_MPC8360,
-	SOC_MPC8379,
 };
 
 static inline bool mpc83xx_has_sdhc(int type)
 {
 	return (type == SOC_MPC8308) ||
-	       (type == SOC_MPC8309) ||
-	       (type == SOC_MPC8379);
+	       (type == SOC_MPC8309);
 }
 
 static inline bool mpc83xx_has_tsec(int type)
@@ -30,27 +28,23 @@ static inline bool mpc83xx_has_tsec(int type)
 	return (type == SOC_MPC8308) ||
 	       (type == SOC_MPC8313) ||
 	       (type == SOC_MPC8315) ||
-	       (type == SOC_MPC8349) ||
-	       (type == SOC_MPC8379);
+	       (type == SOC_MPC8349);
 }
 
 static inline bool mpc83xx_has_pcie1(int type)
 {
 	return (type == SOC_MPC8308) ||
-	       (type == SOC_MPC8315) ||
-	       (type == SOC_MPC8379);
+	       (type == SOC_MPC8315);
 }
 
 static inline bool mpc83xx_has_pcie2(int type)
 {
-	return (type == SOC_MPC8315) ||
-	       (type == SOC_MPC8379);
+	return type == SOC_MPC8315;
 }
 
 static inline bool mpc83xx_has_sata(int type)
 {
-	return (type == SOC_MPC8315) ||
-	       (type == SOC_MPC8379);
+	return type == SOC_MPC8315;
 }
 
 static inline bool mpc83xx_has_pci(int type)
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 26cbc7854d9..608e49667af 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -27,7 +27,7 @@ struct arch_global_data {
 	/* There are other clocks in the MPC83XX */
 	u32 csb_clk;
 # if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC837X)
+	defined(CONFIG_ARCH_MPC834X)
 	u32 tsec1_clk;
 	u32 tsec2_clk;
 	u32 usbdr_clk;
@@ -39,14 +39,10 @@ struct arch_global_data {
 	u32 enc_clk;
 	u32 lbiu_clk;
 	u32 lclk_clk;
-# if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC837X)
+# if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
 	u32 pciexp1_clk;
 	u32 pciexp2_clk;
 # endif
-# if defined(CONFIG_ARCH_MPC837X)
-	u32 sata_clk;
-# endif
 # if defined(CONFIG_ARCH_MPC8360)
 	u32 mem_sec_clk;
 # endif /* CONFIG_ARCH_MPC8360 */
diff --git a/arch/powerpc/include/asm/immap_83xx.h b/arch/powerpc/include/asm/immap_83xx.h
index 1fa6073b268..2eff504a80d 100644
--- a/arch/powerpc/include/asm/immap_83xx.h
+++ b/arch/powerpc/include/asm/immap_83xx.h
@@ -760,51 +760,6 @@ typedef struct immap {
 } immap_t;
 static_assert(sizeof(immap_t) == 0x100000);
 
-#elif defined(CONFIG_ARCH_MPC837X)
-typedef struct immap {
-	sysconf83xx_t		sysconf;	/* System configuration */
-	wdt83xx_t		wdt;		/* Watch Dog Timer (WDT) Registers */
-	rtclk83xx_t		rtc;		/* Real Time Clock Module Registers */
-	rtclk83xx_t		pit;		/* Periodic Interval Timer */
-	gtm83xx_t		gtm[2];		/* Global Timers Module */
-	ipic83xx_t		ipic;		/* Integrated Programmable Interrupt Controller */
-	arbiter83xx_t		arbiter;	/* System Arbiter Registers */
-	reset83xx_t		reset;		/* Reset Module */
-	clk83xx_t		clk;		/* System Clock Module */
-	pmc83xx_t		pmc;		/* Power Management Control Module */
-	gpio83xx_t		gpio[2];	/* General purpose I/O module */
-	u8			res0[0x1200];
-	ddr83xx_t		ddr;		/* DDR Memory Controller Memory */
-	fsl_i2c_t		i2c[2];		/* I2C Controllers */
-	u8			res1[0x1300];
-	duart83xx_t		duart[2];	/* DUART */
-	u8			res2[0x900];
-	fsl_lbc_t		im_lbc;		/* Local Bus Controller Regs */
-	u8			res3[0x1000];
-	spi8xxx_t		spi;		/* Serial Peripheral Interface */
-	dma83xx_t		dma;		/* DMA */
-	pciconf83xx_t		pci_conf[1];	/* PCI Software Configuration Registers */
-	u8			res4[0x80];
-	ios83xx_t		ios;		/* Sequencer */
-	pcictrl83xx_t		pci_ctrl[1];	/* PCI Controller Control and Status Registers */
-	u8			res5[0xa00];
-	pex83xx_t		pciexp[2];	/* PCI Express Controller */
-	u8			res6[0xd000];
-	sata83xx_t		sata[4];	/* SATA Controller */
-	u8			res7[0x7000];
-	usb83xx_t		usb[1];		/* USB DR Controller */
-	tsec83xx_t		tsec[2];
-	u8			res8[0x8000];
-	sdhc83xx_t		sdhc;		/* SDHC Controller */
-	u8			res9[0x1000];
-	security83xx_t		security;
-	u8			res10[0xA3000];
-	serdes83xx_t		serdes[2];	/* SerDes Registers */
-	u8			res11[0xCE00];
-	rom83xx_t		rom;		/* On Chip ROM */
-} immap_t;
-static_assert(sizeof(immap_t) == 0x100000);
-
 #elif defined(CONFIG_ARCH_MPC8360)
 typedef struct immap {
 	sysconf83xx_t		sysconf;	/* System configuration */
diff --git a/arch/powerpc/include/asm/mpc8xxx_spi.h b/arch/powerpc/include/asm/mpc8xxx_spi.h
index 2b2095ad481..c136b3fb4af 100644
--- a/arch/powerpc/include/asm/mpc8xxx_spi.h
+++ b/arch/powerpc/include/asm/mpc8xxx_spi.h
@@ -13,8 +13,7 @@
 #if defined(CONFIG_ARCH_MPC8308) || \
 	defined(CONFIG_ARCH_MPC8313) || \
 	defined(CONFIG_ARCH_MPC832X) || \
-	defined(CONFIG_ARCH_MPC834X) || \
-	defined(CONFIG_ARCH_MPC837X)
+	defined(CONFIG_ARCH_MPC834X)
 
 typedef struct spi8xxx {
 	u8 res0[0x20];	/* 0x0-0x01f reserved */
diff --git a/doc/README.sata b/doc/README.sata
deleted file mode 100644
index b1104bbd3b9..00000000000
--- a/doc/README.sata
+++ /dev/null
@@ -1,68 +0,0 @@
-1. SATA usage in U-Boot
-
-	There are two ways to operate the hard disk
-
-	* Read/write raw blocks from/to SATA hard disk
-	* ext2load to read a file from ext2 file system
-
-1.0 How to read the SATA hard disk's information?
-
-	=> sata info
-
-SATA device 0: Model: ST3320620AS Firm: 3.AAD Ser#:		4QF01ZTN
-	    Type: Hard Disk
-	    Supports 48-bit addressing
-	    Capacity: 305245.3 MB = 298.0 GB (625142448 x 512)
-
-1.1 How to raw write the kernel, file system, dtb to a SATA hard disk?
-
-	Notes: Hard disk sectors are normally 512 bytes, so
-		0x1000 sectors = 2 MBytes
-
-	write kernel
-	=> tftp 40000 /tftpboot/uImage.837x
-	=> sata write 40000 0 2000
-
-	write ramdisk
-	=> tftp 40000 /tftpboot/ramdisk.837x
-	=> sata write 40000 2000 8000
-
-	write dtb
-	=> tftp 40000 /tftpboot/mpc837xemds.dtb
-	=> sata write 40000 a000 1000
-
-1.2 How to raw read the kernel, file system, dtb from a SATA hard disk?
-
-	load kernel
-	=> sata read 200000 0 2000
-
-	load ramdisk
-	=> sata read 1000000 2000 8000
-
-	load dtb
-	=> sata read 2000000 a000 1000
-
-	boot
-	=> bootm 200000 1000000 2000000
-
-1.3 How to load an image from an ext2 file system in U-Boot?
-
-	U-Boot doesn't support writing to an ext2 file system, so the
-	files must be written by other means (e.g. linux).
-
-	=> ext2ls sata 0:1 /
-	<DIR>	    4096 .
-	<DIR>	    4096 ..
-	<DIR>	   16384 lost+found
-		 1352023 uImage.837x
-		 3646377 ramdisk.837x
-		   12288 mpc837xemds.dtb
-		      12 hello.txt
-
-	=> ext2load sata 0:1 200000 /uImage.837x
-
-	=> ext2load sata 0:1 1000000 /ramdisk.837x
-
-	=> ext2load sata 0:1 2000000 /mpc837xemds.dtb
-
-	=> bootm 200000 1000000 2000000
diff --git a/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt b/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
index 8313da85076..065575d87f0 100644
--- a/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
+++ b/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
@@ -10,8 +10,7 @@ Required properties:
                              "fsl,mpc8315-clk",
                              "fsl,mpc832x-clk",
                              "fsl,mpc8349-clk",
-                             "fsl,mpc8360-clk",
-                             "fsl,mpc8379-clk"
+                             "fsl,mpc8360-clk"
   depending on which SoC is employed
 - #clock-cells: Must be 1
 
diff --git a/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt b/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
index ac563d906ac..efdcdfbdba0 100644
--- a/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
+++ b/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
@@ -10,8 +10,7 @@ Required properties:
                              "fsl,mpc8315",
                              "fsl,mpc832x",
                              "fsl,mpc8349",
-                             "fsl,mpc8360",
-                             "fsl,mpc8379"
+                             "fsl,mpc8360"
 - clocks: has to have two entries, which must be the core clock at index 0 and
   the CSB (Coherent System Bus) clock at index 1. Both are given by a suitable
   "fsl,mpc83xx-clk" device
diff --git a/drivers/clk/mpc83xx_clk.c b/drivers/clk/mpc83xx_clk.c
index a43fff2e7ed..20f77a983da 100644
--- a/drivers/clk/mpc83xx_clk.c
+++ b/drivers/clk/mpc83xx_clk.c
@@ -326,7 +326,6 @@ static const struct udevice_id mpc83xx_clk_match[] = {
 	{ .compatible = "fsl,mpc832x-clk", .data = SOC_MPC832X },
 	{ .compatible = "fsl,mpc8349-clk", .data = SOC_MPC8349 },
 	{ .compatible = "fsl,mpc8360-clk", .data = SOC_MPC8360 },
-	{ .compatible = "fsl,mpc8379-clk", .data = SOC_MPC8379 },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/clk/mpc83xx_clk.h b/drivers/clk/mpc83xx_clk.h
index 6b74fc5f16b..b9486a4c202 100644
--- a/drivers/clk/mpc83xx_clk.h
+++ b/drivers/clk/mpc83xx_clk.h
@@ -244,15 +244,8 @@ static int retrieve_mode(int clk, int soc_type, struct clk_mode *mode)
 		break;
 	case MPC83XX_CLK_SATA:
 		/* FIXME(mario.six@gdsys.cc): All SATA controllers must have the same clock ratio */
-		if (soc_type == SOC_MPC8379) {
-			set_mode(mode, 24, 25, TYPE_SCCR_STANDARD);
-			set_mode(mode, 26, 27, TYPE_SCCR_STANDARD);
-			set_mode(mode, 28, 29, TYPE_SCCR_STANDARD);
-			set_mode(mode, 30, 31, TYPE_SCCR_STANDARD);
-		} else {
-			set_mode(mode, 18, 19, TYPE_SCCR_STANDARD);
-			set_mode(mode, 20, 21, TYPE_SCCR_STANDARD);
-		}
+		set_mode(mode, 18, 19, TYPE_SCCR_STANDARD);
+		set_mode(mode, 20, 21, TYPE_SCCR_STANDARD);
 		break;
 	case MPC83XX_CLK_TDM:
 		set_mode(mode, 26, 27, TYPE_SCCR_STANDARD);
diff --git a/drivers/cpu/mpc83xx_cpu.c b/drivers/cpu/mpc83xx_cpu.c
index 127d3c3af08..780b08f0885 100644
--- a/drivers/cpu/mpc83xx_cpu.c
+++ b/drivers/cpu/mpc83xx_cpu.c
@@ -82,9 +82,6 @@ static inline void determine_family(const struct udevice *dev)
 	case 0x804:
 		priv->family = FAMILY_836X;
 		break;
-	case 0x80C:
-		priv->family = FAMILY_837X;
-		break;
 	default:
 		priv->family = FAMILY_UNKNOWN;
 	}
@@ -150,15 +147,6 @@ static inline void determine_type(const struct udevice *dev)
 	case 0x8048:
 		priv->type = TYPE_8360;
 		break;
-	case 0x80C6:
-		priv->type = TYPE_8377;
-		break;
-	case 0x80C4:
-		priv->type = TYPE_8378;
-		break;
-	case 0x80C2:
-		priv->type = TYPE_8379;
-		break;
 	default:
 		priv->type = TYPE_UNKNOWN;
 	}
@@ -338,7 +326,6 @@ static const struct udevice_id mpc83xx_cpu_ids[] = {
 	{ .compatible = "fsl,mpc832x", },
 	{ .compatible = "fsl,mpc8349", },
 	{ .compatible = "fsl,mpc8360", },
-	{ .compatible = "fsl,mpc8379", },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/cpu/mpc83xx_cpu.h b/drivers/cpu/mpc83xx_cpu.h
index 2aaa4e18844..20579cecf5e 100644
--- a/drivers/cpu/mpc83xx_cpu.h
+++ b/drivers/cpu/mpc83xx_cpu.h
@@ -39,7 +39,6 @@ static const char * const e300_names[] = {
  * @FAMILY_832X:    Identifier for the MPC832x CPU family
  * @FAMILY_834X:    Identifier for the MPC834x CPU family
  * @FAMILY_836X:    Identifier for the MPC836x CPU family
- * @FAMILY_837X:    Identifier for the MPC837x CPU family
  * @FAMILY_UNKNOWN: Identifier for an unknown MPC83xx CPU family
  */
 enum mpc83xx_cpu_family {
@@ -48,7 +47,6 @@ enum mpc83xx_cpu_family {
 	FAMILY_832X,
 	FAMILY_834X,
 	FAMILY_836X,
-	FAMILY_837X,
 	FAMILY_UNKNOWN,
 };
 
@@ -73,9 +71,6 @@ enum mpc83xx_cpu_family {
  * @TYPE_8358_PBGA: Identifier for the MPC8358 CPU type (Plastic Ball Grid Array
  *		    version)
  * @TYPE_8360:      Identifier for the MPC8360 CPU type
- * @TYPE_8377:      Identifier for the MPC8377 CPU type
- * @TYPE_8378:      Identifier for the MPC8378 CPU type
- * @TYPE_8379:      Identifier for the MPC8379 CPU type
  * @TYPE_UNKNOWN:   Identifier for an unknown MPC83xx CPU type
  */
 enum mpc83xx_cpu_type {
@@ -94,9 +89,6 @@ enum mpc83xx_cpu_type {
 	TYPE_8358_TBGA,
 	TYPE_8358_PBGA,
 	TYPE_8360,
-	TYPE_8377,
-	TYPE_8378,
-	TYPE_8379,
 	TYPE_UNKNOWN,
 };
 
@@ -117,9 +109,6 @@ static const char * const cpu_type_names[] = {
 	[TYPE_8358_TBGA] = "8358_TBGA",
 	[TYPE_8358_PBGA] = "8358_PBGA",
 	[TYPE_8360] = "8360",
-	[TYPE_8377] = "8377",
-	[TYPE_8378] = "8378",
-	[TYPE_8379] = "8379",
 	[TYPE_UNKNOWN] = "Unknown CPU",
 };
 
diff --git a/drivers/ram/mpc83xx_sdram.c b/drivers/ram/mpc83xx_sdram.c
index 28a663289a2..d45c4e6264e 100644
--- a/drivers/ram/mpc83xx_sdram.c
+++ b/drivers/ram/mpc83xx_sdram.c
@@ -167,8 +167,7 @@ static int mpc83xx_sdram_static_init(ofnode node, u32 cs, u32 mapaddr, u32 size)
 	odt_rd_cfg = ofnode_read_u32_default(node, "odt_rd_cfg", 0);
 	switch (odt_rd_cfg) {
 	case ODT_RD_ONLY_OTHER_DIMM:
-		if (!IS_ENABLED(CONFIG_ARCH_MPC8360) &&
-		    !IS_ENABLED(CONFIG_ARCH_MPC837X)) {
+		if (!IS_ENABLED(CONFIG_ARCH_MPC8360)) {
 			debug("%s: odt_rd_cfg value %d invalid.\n",
 			      ofnode_get_name(node), odt_rd_cfg);
 			return -EINVAL;
@@ -179,8 +178,7 @@ static int mpc83xx_sdram_static_init(ofnode node, u32 cs, u32 mapaddr, u32 size)
 	case ODT_RD_ONLY_OTHER_CS:
 		if (!IS_ENABLED(CONFIG_ARCH_MPC830X) &&
 		    !IS_ENABLED(CONFIG_ARCH_MPC831X) &&
-		    !IS_ENABLED(CONFIG_ARCH_MPC8360) &&
-		    !IS_ENABLED(CONFIG_ARCH_MPC837X)) {
+		    !IS_ENABLED(CONFIG_ARCH_MPC8360)) {
 			debug("%s: odt_rd_cfg value %d invalid.\n",
 			      ofnode_get_name(node), odt_rd_cfg);
 			return -EINVAL;
@@ -198,8 +196,7 @@ static int mpc83xx_sdram_static_init(ofnode node, u32 cs, u32 mapaddr, u32 size)
 	odt_wr_cfg = ofnode_read_u32_default(node, "odt_wr_cfg", 0);
 	switch (odt_wr_cfg) {
 	case ODT_WR_ONLY_OTHER_DIMM:
-		if (!IS_ENABLED(CONFIG_ARCH_MPC8360) &&
-		    !IS_ENABLED(CONFIG_ARCH_MPC837X)) {
+		if (!IS_ENABLED(CONFIG_ARCH_MPC8360)) {
 			debug("%s: odt_wr_cfg value %d invalid.\n",
 			      ofnode_get_name(node), odt_wr_cfg);
 			return -EINVAL;
@@ -210,8 +207,7 @@ static int mpc83xx_sdram_static_init(ofnode node, u32 cs, u32 mapaddr, u32 size)
 	case ODT_WR_ONLY_OTHER_CS:
 		if (!IS_ENABLED(CONFIG_ARCH_MPC830X) &&
 		    !IS_ENABLED(CONFIG_ARCH_MPC831X) &&
-		    !IS_ENABLED(CONFIG_ARCH_MPC8360) &&
-		    !IS_ENABLED(CONFIG_ARCH_MPC837X)) {
+		    !IS_ENABLED(CONFIG_ARCH_MPC8360)) {
 			debug("%s: odt_wr_cfg value %d invalid.\n",
 			      ofnode_get_name(node), odt_wr_cfg);
 			return -EINVAL;
diff --git a/include/mpc83xx.h b/include/mpc83xx.h
index aa8803413cd..b8d2c3edd56 100644
--- a/include/mpc83xx.h
+++ b/include/mpc83xx.h
@@ -74,11 +74,6 @@
 #define SPR_8358_TBGA_			0x804A
 #define SPR_8358_PBGA_			0x804E
 #define SPR_8360			0x8048
-#define SPR_837X_FAMILY			0x80C
-#define SPR_8377			0x80C6
-#define SPR_8378			0x80C4
-#define SPR_8379			0x80C2
-
 /*
  * SPCR - System Priority Configuration Register
  */
@@ -118,9 +113,8 @@
 #define SPCR_TSEC2EP			0x00000003
 #define SPCR_TSEC2EP_SHIFT		(31-31)
 
-#elif defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC837X)
-/* SPCR bits - MPC8308, MPC831x and MPC837X specific */
+#elif defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+/* SPCR bits - MPC8308 and MPC831x specific */
 /* TSEC data priority */
 #define SPCR_TSECDP			0x00003000
 #define SPCR_TSECDP_SHIFT		(31-19)
@@ -237,59 +231,6 @@
 #define SICRH_TSOBI1			0x00000002
 #define SICRH_TSOBI2			0x00000001
 
-#elif defined(CONFIG_ARCH_MPC837X)
-/* SICRL bits - MPC837X specific */
-#define SICRL_USB_A			0xC0000000
-#define SICRL_USB_B			0x30000000
-#define SICRL_USB_B_SD			0x20000000
-#define SICRL_UART			0x0C000000
-#define SICRL_GPIO_A			0x02000000
-#define SICRL_GPIO_B			0x01000000
-#define SICRL_GPIO_C			0x00800000
-#define SICRL_GPIO_D			0x00400000
-#define SICRL_GPIO_E			0x00200000
-#define SICRL_GPIO_F			0x00180000
-#define SICRL_GPIO_G			0x00040000
-#define SICRL_GPIO_H			0x00020000
-#define SICRL_GPIO_I			0x00010000
-#define SICRL_GPIO_J			0x00008000
-#define SICRL_GPIO_K			0x00004000
-#define SICRL_GPIO_L			0x00003000
-#define SICRL_DMA_A			0x00000800
-#define SICRL_DMA_B			0x00000400
-#define SICRL_DMA_C			0x00000200
-#define SICRL_DMA_D			0x00000100
-#define SICRL_DMA_E			0x00000080
-#define SICRL_DMA_F			0x00000040
-#define SICRL_DMA_G			0x00000020
-#define SICRL_DMA_H			0x00000010
-#define SICRL_DMA_I			0x00000008
-#define SICRL_DMA_J			0x00000004
-#define SICRL_LDP_A			0x00000002
-#define SICRL_LDP_B			0x00000001
-
-/* SICRH bits - MPC837X specific */
-#define SICRH_DDR			0x80000000
-#define SICRH_TSEC1_A			0x10000000
-#define SICRH_TSEC1_B			0x08000000
-#define SICRH_TSEC2_A			0x00400000
-#define SICRH_TSEC2_B			0x00200000
-#define SICRH_TSEC2_C			0x00100000
-#define SICRH_TSEC2_D			0x00080000
-#define SICRH_TSEC2_E			0x00040000
-#define SICRH_TMR			0x00010000
-#define SICRH_GPIO2_A			0x00008000
-#define SICRH_GPIO2_B			0x00004000
-#define SICRH_GPIO2_C			0x00002000
-#define SICRH_GPIO2_D			0x00001000
-#define SICRH_GPIO2_E			0x00000C00
-#define SICRH_GPIO2_E_SD		0x00000800
-#define SICRH_GPIO2_F			0x00000300
-#define SICRH_GPIO2_G			0x000000C0
-#define SICRH_GPIO2_H			0x00000030
-#define SICRH_SPI			0x00000003
-#define SICRH_SPI_SD			0x00000001
-
 #elif defined(CONFIG_ARCH_MPC8308)
 /* SICRL bits - MPC8308 specific */
 #define SICRL_SPI_PF0			(0 << 28)
@@ -522,13 +463,6 @@
 #define HRCWL_SVCOD_DIV_8		0x20000000
 #define HRCWL_SVCOD_DIV_1		0x30000000
 
-#elif defined(CONFIG_ARCH_MPC837X)
-#define HRCWL_SVCOD			0x30000000
-#define HRCWL_SVCOD_SHIFT		28
-#define HRCWL_SVCOD_DIV_4		0x00000000
-#define HRCWL_SVCOD_DIV_8		0x10000000
-#define HRCWL_SVCOD_DIV_2		0x20000000
-#define HRCWL_SVCOD_DIV_1		0x30000000
 #endif
 
 /*
@@ -576,15 +510,11 @@
 #if defined(CONFIG_ARCH_MPC834X)
 #define HRCWH_ROM_LOC_PCI2		0x00200000
 #endif
-#if defined(CONFIG_ARCH_MPC837X)
-#define HRCWH_ROM_LOC_ON_CHIP_ROM	0x00300000
-#endif
 #define HRCWH_ROM_LOC_LOCAL_8BIT	0x00500000
 #define HRCWH_ROM_LOC_LOCAL_16BIT	0x00600000
 #define HRCWH_ROM_LOC_LOCAL_32BIT	0x00700000
 
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC837X)
+#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
 #define HRCWH_ROM_LOC_NAND_SP_8BIT	0x00100000
 #define HRCWH_ROM_LOC_NAND_SP_16BIT	0x00200000
 #define HRCWH_ROM_LOC_NAND_LP_8BIT	0x00500000
@@ -636,8 +566,7 @@
 /*
  * RSR - Reset Status Register
  */
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
-	defined(CONFIG_ARCH_MPC837X)
+#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
 #define RSR_RSTSRC			0xF0000000	/* Reset source */
 #define RSR_RSTSRC_SHIFT		28
 #else
@@ -850,45 +779,6 @@
 #define SCCR_TDMCM_2			0x00000020
 #define SCCR_TDMCM_3			0x00000030
 
-#elif defined(CONFIG_ARCH_MPC837X)
-/* SCCR bits - MPC837X specific */
-#define SCCR_TSEC1CM			0xc0000000
-#define SCCR_TSEC1CM_SHIFT		30
-#define SCCR_TSEC1CM_0			0x00000000
-#define SCCR_TSEC1CM_1			0x40000000
-#define SCCR_TSEC1CM_2			0x80000000
-#define SCCR_TSEC1CM_3			0xC0000000
-
-#define SCCR_TSEC2CM			0x30000000
-#define SCCR_TSEC2CM_SHIFT		28
-#define SCCR_TSEC2CM_0			0x00000000
-#define SCCR_TSEC2CM_1			0x10000000
-#define SCCR_TSEC2CM_2			0x20000000
-#define SCCR_TSEC2CM_3			0x30000000
-
-#define SCCR_SDHCCM			0x0c000000
-#define SCCR_SDHCCM_SHIFT		26
-#define SCCR_SDHCCM_0			0x00000000
-#define SCCR_SDHCCM_1			0x04000000
-#define SCCR_SDHCCM_2			0x08000000
-#define SCCR_SDHCCM_3			0x0c000000
-
-#define SCCR_USBDRCM			0x00c00000
-#define SCCR_USBDRCM_SHIFT		22
-#define SCCR_USBDRCM_0			0x00000000
-#define SCCR_USBDRCM_1			0x00400000
-#define SCCR_USBDRCM_2			0x00800000
-#define SCCR_USBDRCM_3			0x00c00000
-
-/* All of the four SATA controllers must have the same clock ratio */
-#define SCCR_SATA1CM			0x000000c0
-#define SCCR_SATA1CM_SHIFT		6
-#define SCCR_SATACM			0x000000ff
-#define SCCR_SATACM_SHIFT		0
-#define SCCR_SATACM_0			0x00000000
-#define SCCR_SATACM_1			0x00000055
-#define SCCR_SATACM_2			0x000000aa
-#define SCCR_SATACM_3			0x000000ff
 #endif
 
 #define SCCR_PCIEXP1CM			0x00300000
@@ -932,7 +822,7 @@
 #elif defined(CONFIG_ARCH_MPC832X)
 #define CSCONFIG_ODT_RD_CFG		0x00400000
 #define CSCONFIG_ODT_WR_CFG		0x00040000
-#elif defined(CONFIG_ARCH_MPC8360) || defined(CONFIG_ARCH_MPC837X)
+#elif defined(CONFIG_ARCH_MPC8360)
 #define CSCONFIG_ODT_RD_NEVER		0x00000000
 #define CSCONFIG_ODT_RD_ONLY_CURRENT	0x00100000
 #define CSCONFIG_ODT_RD_ONLY_OTHER_CS	0x00200000
-- 
2.47.3

