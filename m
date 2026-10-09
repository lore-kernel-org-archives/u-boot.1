Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BB8CA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 436AB814D5;
	Fri,  9 Oct 2026 19:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M-TZJm2Pc_rZ; Fri,  9 Oct 2026 19:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B15E2812D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575658;
	b=OuoUmAWPkxHgucNeMrWsLGEU2vyaSk53kkCLkNABBAWBsIz3wpC3+S4rNQDB3RwJ4AOi
	 YZemN9D2kLN1Rkl8T/yShSJENLf6ZL5E+ekMiON0fEI/d1la/PUXoC+y/Gj0gKWrXDAGu
	 m+bvVSrcfRNLfCTMdf3CvPUq2HsXKWqnhOE75ZzKrl+XaVHZDzHwAgkgMWCKRrjSvBqzE
	 vVkOyYOPRrP7ssWo3rchiYz5O1H3pYxcHnK3d2JIyh5RoFYC7kqzwpp0/DkY61Xceft0v
	 mUG3g5CmoJxiMSbT7PPpTV053JoQd/2fQ8qAC0XCyquN9usVfTsrastqBWX9cN6LIwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=btdZ+oBFv6iUJXTraS2MM7hJCJF3giLD6Afk67iYrTU=;
	b=JuKr3GWac5swVpmGeSpHE35hQSnCq6rGhy0IMPJTXiVYJgtJ90fmGdKiXgMoGT6vXATX
	 PqvZo6DvhI0dq6ra3mSeIZlltP72Qn5TgrS2yndhMRHGISj0+9la2K+I3RO5XhNH9Bm57
	 vtEhFTwyN1HjqS6PMcALW4s6w8FDXqjW0QEbJBd5KvQ2Df5SDtttcE9cdCF+9bY18C+fX
	 aDgMC+PPFcTA1xuimmJZ9ewGjuasspZeaQNhApGbvqzqkKj0grKV8nQaJ/E1zavgFFHCr
	 Ktk5oCvLeaw10GnANjGtXjTei5T03sVhjdSD+H8SzS9FkAyCwQNXcnkUxhKeuBRI4Bg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575657;
	bh=btdZ+oBFv6iUJXTraS2MM7hJCJF3giLD6Afk67iYrTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TeYfTDOPZiiLD0Wjduulks9ohmTz/FeZ2otL4oLzHKKyQIUXtCPC3hU2AM4DkscSQ
	 gayMi2OHS40akGAFQurIF6CUht1/hqCjnS9bKQU4a5IGs3Ng7PzurakqsLYpdPjJY6
	 iB0VkD5FtCkeySKlQez7iUDD0RPRPyPHd6kAnpt684JDwGsWYTx03FhUmsbLc84uoA
	 sQqIMDzKYjNVRn9pTr2A3Y5a8tVteIjgFqk7Jc2xcR212x+ytB+KnWS36Eq6WqVylS
	 PHGeZsKDWDuVxa7hY1ujq2kFW3bTLsnWr582m6Lh92G/xcLlrRyvgugbz+7X636o8N
	 ebVuL5qFaJdLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B15E2812D3;
	Fri,  9 Oct 2026 19:54:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id F1F13184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id E456E40935
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id pru26rRDXHga for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E3852408CB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574809;
 b=dhplOQ13SCHDeaqVdY/3GpPjPksdCX5evT3Uqo6TpLJAXrtxH/Fr3AmEIQWKg2pDf1Yt
 wNEMy0pX1q+ZGi8MOL80J7o89RpktuFBiWgIPT1q7HeirmhhjdCWeD3qF2w2yHs8V4JKn
 NKHQJtHkOGxDuHT0S0Gf3cUmUJDKgjGYkzShVIQ5Rsk+Ng5bIIQCm7A+iaMN3UZWbXKsR
 Rc0gRBAJDBUT7ggRmiUgiz+zzs6pDH2RE6oH37QmJovD3Kg2DZ/isZmYR3Z5Dq/E6Hck3
 e4iOo6lfMK3nrUwEdTmRqGe3UREu9ErN+7nAjS4YRc+M60aQXqnn2ZV25+V65nG1Aag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574809;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=btdZ+oBFv6iUJXTraS2MM7hJCJF3giLD6Afk67iYrTU=;
 b=ARbVbTIV7aEvqoGNvx8meYr4sHofLnVOO+QlUWJFkp4apMbDzLQIZmpqP+o6NsZjyNls
 QsUXvv/nFItbMICBuwhcjJjsr4gPPz7JbMPqKrXo1t2iNY+KR3OlodFDOUYAJ6SdZu5X6
 kJIcQiIn2iP/msTnO8MAFjQ1F0rpd91ZF1J5ibMucPPZQXbHExnBzzfAeCjp4GYxNWQrk
 LCqL64gavtYLSWHgKN8uhJsFnouseqimoqicbiHfU2Cpqyg74N5xcQDT4ARf9F4AU0wFE
 vFaQZWSsrpmil+vz4zyC6Ys9RBiC4Oxn+eMvWhVEgglN1a+DJbqDf/mvazXt3Kq4Wvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=oG5gm4Sz; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=WAZt8RYq; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=oG5gm4Sz; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=WAZt8RYq
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id E3852408CB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574631; bh=btdZ+oBFv6iUJXTraS2MM7h
 JCJF3giLD6Afk67iYrTU=; b=oG5gm4SzPlblI5uVZJXn7nY18F2m34KuM4vLe2Lm3I1NBis7Kb
 oMtnvbhFTTSE2Gfsnaa08bIlRPMHYayEw8Brh6e/bW2eNF+fY9nabMdKUoJBC7TWXz8IjtmfwKX
 LPeBqzRIVqKB6uig9INxA7YbNNha6EvrarZDDbpUT9ghyiTSJ53IIJLw2ENBlfev0t7866t89CR
 QWbmObM8Odl4FtYCllJBlFaKJGq236GT4uy2jK0UImoUQ1/kNxwnpFdJb8AVmYsfJ2FK3DftBpM
 mD61cFVUpS2ZOq+ydmlPaMzAuipUIKJg5eBdCs0K6GvyOGgxzU8+gDiWJkqSYORTMng==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574631; bh=btdZ+oBFv6iUJXTraS2MM7h
 JCJF3giLD6Afk67iYrTU=; b=WAZt8RYqxyQPx7uMo87oLQy7nPB9sWz57J848HxCYAfP7f8nVa
 pzSmY5wZm1p7lpEdtZWH6JdK6BcxghAchtBw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Mario Six <mario.six@gdsys.cc>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Pengpeng Hou <hppiscas@163.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>, Vincent Jardin <vjardin@free.fr>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 15/26] powerpc: mpc85xx: Remove P1025 support
Date: Fri,  9 Oct 2026 19:36:53 +0000
Message-ID: <20261009193704.13061-16-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009193704.13061-1-brads@mainlining.org>
References: <20261009193704.13061-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 19:54:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

NXP lists the P1025/P1016 family as no longer manufactured. No board in the tree selects ARCH_P1025, so remove its configuration and variant specific
code while retaining the shared P1021 support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig                              |  2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig          | 22 ----------------------
 arch/powerpc/cpu/mpc85xx/Makefile         |  1 -
 arch/powerpc/cpu/mpc85xx/speed.c          |  2 +-
 arch/powerpc/cpu/mpc8xxx/cpu.c            |  1 -
 arch/powerpc/include/asm/config_mpc85xx.h |  6 ------
 arch/powerpc/include/asm/immap_85xx.h     |  2 +-
 arch/powerpc/include/asm/processor.h      |  1 -
 doc/README.mpc85xx-sd-spi-boot            |  2 --
 drivers/qe/Kconfig                        |  3 +--
 10 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 07214f2af7c..e806fa2e3e7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -471,7 +471,7 @@ config SYS_IMMR
 	default 0xE0000000 if MPC83xx && !ARCH_MPC8313
 	default 0x01000000 if ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3
 	default 0xFFE00000 if ARCH_P1010 || ARCH_P1020 || \
-			      ARCH_P1021 || ARCH_P1024 || ARCH_P1025 || \
+			      ARCH_P1021 || ARCH_P1024 || \
 			      ARCH_P2020
 	default SYS_CCSRBAR_DEFAULT
 	help
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index f4e34adbaea..6ca0ccd65e7 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -466,24 +466,6 @@ config ARCH_P1024
 	imply CMD_REGINFO
 	imply SATA_SIL
 
-config ARCH_P1025
-	bool
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A004508
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_ELBC_A001
-	select SYS_FSL_ERRATUM_ESDHC111
-	select FSL_PCIE_DISABLE_ASPM
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_2
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_ELBC
-	imply SATA
-	imply CMD_REGINFO
-
 config ARCH_P2020
 	bool
 	select BTB
@@ -781,7 +763,6 @@ config MAX_CPUS
 		     ARCH_P1020 || \
 		     ARCH_P1021 || \
 		     ARCH_P1024 || \
-		     ARCH_P1025 || \
 		     ARCH_P2020 || \
 		     ARCH_T1024
 	default 1
@@ -804,7 +785,6 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_P1020	|| \
 				ARCH_P1021	|| \
 				ARCH_P1024	|| \
-				ARCH_P1025	|| \
 				ARCH_P2020
 	default 0xfe000000 if	ARCH_B4420	|| \
 				ARCH_B4860	|| \
@@ -1012,7 +992,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
-			ARCH_P1025	|| \
 			ARCH_P2020
 	default 10 if ARCH_MPC8544
 	default 8 if	ARCH_MPC8540	|| \
@@ -1125,7 +1104,6 @@ config SYS_PPC_E500_DEBUG_TLB
 	default 2 if	ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
-			ARCH_P1025	|| \
 			ARCH_P2020
 	default 3 if	ARCH_P1010	|| \
 			ARCH_BSC9132
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index c40558880ea..3746d5c6fdb 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1021)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1024)	+= p1021_serdes.o
-obj-$(CONFIG_ARCH_P1025)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P2020)	+= p2020_serdes.o
 obj-$(CONFIG_ARCH_P2041) += p2041_serdes.o
 obj-$(CONFIG_ARCH_T4240) += t4240_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/speed.c b/arch/powerpc/cpu/mpc85xx/speed.c
index d17a19026dd..01fe85ffd57 100644
--- a/arch/powerpc/cpu/mpc85xx/speed.c
+++ b/arch/powerpc/cpu/mpc85xx/speed.c
@@ -544,7 +544,7 @@ void get_sys_info(sys_info_t *sys_info)
 #endif
 
 #ifdef CONFIG_QE
-#if defined(CONFIG_ARCH_P1021) || defined(CONFIG_ARCH_P1025)
+#if defined(CONFIG_ARCH_P1021)
 	sys_info->freq_qe =  sys_info->freq_systembus;
 #else
 	qe_ratio = ((gur->porpllsr) & MPC85xx_PORPLLSR_QE_RATIO)
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 52817a4fc2a..8c02893f63b 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -49,7 +49,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(P1021, P1021, 2),
 	CPU_TYPE_ENTRY(P1022, P1022, 2),
 	CPU_TYPE_ENTRY(P1024, P1024, 2),
-	CPU_TYPE_ENTRY(P1025, P1025, 2),
 	CPU_TYPE_ENTRY(P2010, P2010, 1),
 	CPU_TYPE_ENTRY(P2020, P2020, 2),
 	CPU_TYPE_ENTRY(P2040, P2040, 4),
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index 67804ada5ed..3cc952797a7 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -15,12 +15,6 @@
 #define MAX_QE_RISC			1
 #define QE_NUM_OF_SNUM			28
 
-/* P1025 is lower end variant of P1021 */
-#elif defined(CONFIG_ARCH_P1025)
-#define QE_MURAM_SIZE			0x6000UL
-#define MAX_QE_RISC			1
-#define QE_NUM_OF_SNUM			28
-
 #elif defined(CONFIG_ARCH_P2020)
 #define CFG_SYS_FSL_SRIO_MAX_PORTS	2
 #define CFG_SYS_FSL_SRIO_OB_WIN_NUM	9
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 39ddfcfe308..9f5e9a7cfcd 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -2077,7 +2077,7 @@ typedef struct ccsr_gur {
 	u32	svr;		/* System version */
 	u8	res10[8];
 	u32	rstcr;		/* Reset control */
-#if defined(CONFIG_ARCH_P1021) || defined(CONFIG_ARCH_P1025)
+#if defined(CONFIG_ARCH_P1021)
 	u8      res11a[12];
 	u32     iovselsr;
 	u8      res11b[60];
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 2612f182a4c..748cf1a3f54 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1041,7 +1041,6 @@
 #define SVR_P1021	0x80E401
 #define SVR_P1022	0x80E600
 #define SVR_P1024	0x80E402
-#define SVR_P1025	0x80E403
 #define SVR_P2010	0x80E300
 #define SVR_P2020	0x80E200
 #define SVR_P2040	0x821000
diff --git a/doc/README.mpc85xx-sd-spi-boot b/doc/README.mpc85xx-sd-spi-boot
index 086c8f9e49b..7a5748f5df3 100644
--- a/doc/README.mpc85xx-sd-spi-boot
+++ b/doc/README.mpc85xx-sd-spi-boot
@@ -64,8 +64,6 @@ P1010RDB	config_ddr3_1gb_p1010rdb_800M.dat
 P1021RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1022DS		config_ddr3_2gb_p1022ds.dat
 P1024RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
-P1025RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
-P1016RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
 P1020UTM	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1020MBG	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 MPC8536DS	config_ddr2_512m_mpc8536ds_667M.dat
diff --git a/drivers/qe/Kconfig b/drivers/qe/Kconfig
index 22ed80bfc66..1d10422dd37 100644
--- a/drivers/qe/Kconfig
+++ b/drivers/qe/Kconfig
@@ -4,8 +4,7 @@
 config QE
 	bool "Enable support for QUICC Engine"
 	depends on PPC
-	default y if ARCH_T1040 || ARCH_T1042 || ARCH_T1024 || ARCH_P1021 \
-		|| ARCH_P1025
+	default y if ARCH_T1040 || ARCH_T1042 || ARCH_T1024 || ARCH_P1021
 	help
 	  Chose this option to add support for the QUICC Engine.
 
-- 
2.47.3

