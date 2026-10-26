Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C6606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SiST+5aF;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HnA9Sx2t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BFC340611;
	Mon, 26 Oct 2026 22:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1jOV1JPTj2PA; Mon, 26 Oct 2026 22:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 451834061D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793052717;
	b=tFO33VywN1e1RX5UzxTyaiTFDnYBR2EmfKE7LUV0n1ORTRTggr3llRKg5dwzZedVoH7s
	 Fv8v4t1lpd9gZwcnUiY9xwBGnqntTMk+Vmn9Ag4/SBvxHseQYH1/TA+v8cy5i1EFGGtvW
	 ClA/HPQIZd+xH3AcEhOTHt5Ka0kSrF2hoX+SvMzSirJNwCF/Rh6IVXYCWAogKW3DLyttt
	 jZ6aX/YYBqmKPDUtvPs9lHBVXQAdo3Au62Qw8ctZzRf6jWe/ka1UNcUMaSXImfdbMMgiZ
	 N7k9TWrilJX3wd5Zy07N28rk+Fmj2jhxOz4e56fTDniaCOghy2dP0zI+fHarMW6S2ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793052717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o3Qe0ezcre6zJkthBA3JAh6Qi/nH6/iMFvMJln9l3fQ=;
	b=BqvM/OlyopsjprT/AWJLMxgpQpHSAkGBDbVv9BfsA4Z/5JqgSKQ5FgP1KcjhLP1hfUJI
	 qVE3IptL8U4oUSXgz0G+Nck/H3LlIxzbngDKZLlG9fqrEmJmO/CeH7JFpO141WDB+K2cI
	 v6Y3j6IGUjrb6hEqrZhXBNSNRzVYZRqfVJ4R+oAAtBEzTsoIOr6UvL2hsrppM3Xdf6nAi
	 IjSyEj8cwjEfVDrxdJ3WD9/5GrWwPd9uJ1n5xxxxwfyKIpF4MR2nVgzMn2v/96RziiwMv
	 RpU7NL9IAGryhl9/NOphUetPSrgNazaNsTszUXeaoweGzHz6z+dxlzf1qdj0w+DwtWw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793052717;
	bh=o3Qe0ezcre6zJkthBA3JAh6Qi/nH6/iMFvMJln9l3fQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SiST+5aFevUW1TE9SMRWRrdtbAtn1Td8+gaAD4xApJda8yLCup0M3l8/Lr8dV6f4m
	 Zs81QE8Z5j3jBBKtl7CQPrZ320OKrmR5n6GRXpJMLe2IzbNeGon6rSBto0h2G2Pmwe
	 6KsMrljPKwBzrnTmFbwmKiNN5kz4wMphPKLQtbd1LTbhYePrGf7bh4VUZjJZw6bqFS
	 OZemRfYf/cS6u+1rA3FhCtSbIO3+H//Ak2sW9dkjXTtZxQxBUZM2AXAmV+pe1PctE+
	 4zCZWBgRgFMQDKgYRfUEPFq1a9sZOly0JLkWla8O2jUeVJRXHrNTtlnoGTR8IpOD3f
	 MEzzgalL9KRwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 451834061D;
	Mon, 26 Oct 2026 22:11:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5456D3421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FFA940205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:11:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Da1fw4_CrYGK for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:11:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D6AD440075
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793052713;
 b=EgivlthE3ZGjc3Kc1ILQfezmLMJtc89e+PIk7Z+iSXZr3QqOmf7t7D8sJeRtarCi4JUE
 eQRVWCduzexTByrCvRaZeTJdlhVG26msrVAyMFXE93VgmRkk6H3uQOXs+0jC3AS3eAuvS
 cfe+1rasgd0cUUcGTyB5G3X6jA2lqRvT+FhC8FMKcY4okPDqQVVyRfKYOK4uaDoV765ro
 +R01a2V+hOnIK6XEveOb6CIIveEFMQt6FApCdSUD7oLAxR5Q+ll9LK9QMHqqiqqXcmT52
 F15s3hS+kUTp5oM4WV456d/mfVgGGMtyDUFyoxfFwmbjdgJEv/e6G4dq1RgnP8XXLrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793052713;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=o3Qe0ezcre6zJkthBA3JAh6Qi/nH6/iMFvMJln9l3fQ=;
 b=TBvR/N7werSEkNokVeJQZmUhKngUzaWJHQbj2T3GaIZ3JQ3buFFJYBsjvTsDm446fWg7
 /29MMtbTwur/GehoF0cVBLzweCDtrECc2ULWnpffd4gr7vBlS6Flr32sj5Dc8OQUVfkuG
 szaKfdA+K3HiR+Gs/eDLpGa5P49+IhhbuMh8psrt4KXey0LpuC08qAnEIns05+EkHFcVp
 ESR3ur5zO8QcHx+BbglHmeaY4wNgamSuBQj/gsyasiTX3EVSvYak00VOYusx0vzPj3NrU
 DSr0soUbhH3EICuEHc133fZQRi+zx9zjwUnJ5NfdI4Ei7qhTE++r3WRIdX7HvBVT7jA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=HnA9Sx2t; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=HnA9Sx2t
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6AD440075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:11:52 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jD7Bs3pJTzKnDY;
 Mon, 26 Oct 2026 23:11:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793052709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=o3Qe0ezcre6zJkthBA3JAh6Qi/nH6/iMFvMJln9l3fQ=;
 b=HnA9Sx2ttUIigM6eNdhpuumu34/n2bQ62E4+in7b0WXaXxqvrOxILaOItYCOBC26mSApOd
 j44YPNwz4FxiSE8Xx4PVr0yWjlfqiITXtlhLTP67LhgO3FLoHv9yukIaPI1bq5sb9+azL8
 PjpBvwoXX8ogPzPZu3n4zWnRIGJetAXdyZY3wRxiWdCtsNaJKiOh43GnE6TM+RtgKAid6B
 sfaPLRkSL5vkI2bcCfr2dB+DsgTG0aaVl5il22zGZLc6m0fSDXIFg8feluhssAV+1HkGr7
 kkobBj5s7SJB6luXlzDo7GXe3442el3Jj90krdSZHHQw1bANvoWFV8RmOhcGkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 MD Danish Anwar <danishanwar@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC conditional
Date: Mon, 26 Oct 2026 23:11:32 +0100
Message-ID: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 827d82fa66086f1787d
X-MBO-RS-META: zjne9bpqdzw1tmjdboizbsax16ofpdd1
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
configurable boolean, and update all defconfigs and Kconfigs which
previously only selected REMOTEPROC driver to also select REMOTEPROC
itself.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/mach-imx/imx8m/Kconfig               |  5 +++++
 arch/arm/mach-imx/imx9/Kconfig                |  4 ++++
 configs/am62_pocketbeagle2_a53_defconfig      |  1 +
 configs/am62_pocketbeagle2_r5_defconfig       |  1 +
 configs/am62ax_evm_a53_defconfig              |  1 +
 configs/am62ax_evm_r5_defconfig               |  1 +
 configs/am62px_evm_a53_defconfig              |  1 +
 configs/am62px_evm_r5_defconfig               |  1 +
 configs/am62x_beagleplay_a53_defconfig        |  1 +
 configs/am62x_beagleplay_r5_defconfig         |  1 +
 configs/am62x_evm_a53_defconfig               |  1 +
 configs/am62x_evm_r5_defconfig                |  1 +
 configs/am64x_evm_a53_defconfig               |  1 +
 configs/am64x_evm_r5_defconfig                |  1 +
 configs/am65x_evm_r5_defconfig                |  1 +
 configs/am65x_evm_r5_usbmsc_defconfig         |  1 +
 configs/am67a_beagley_ai_a53_defconfig        |  1 +
 configs/am67a_beagley_ai_r5_defconfig         |  1 +
 configs/aquila-am69_r5_defconfig              |  1 +
 configs/aquila-imx95_defconfig                |  1 +
 configs/imx95_15x15_evk_defconfig             |  1 +
 configs/imx95_evk.config                      |  1 +
 configs/imx95_navq.config                     |  1 +
 configs/j7200_evm_r5_defconfig                |  1 +
 configs/j721e_beagleboneai64_r5_defconfig     |  1 +
 configs/j721e_evm_r5_defconfig                |  1 +
 configs/j721s2_evm_r5_defconfig               |  1 +
 configs/j722s_evm_a53_defconfig               |  1 +
 configs/j722s_evm_r5_defconfig                |  1 +
 configs/j784s4_evm_r5_defconfig               |  1 +
 configs/k2g_evm_defconfig                     |  1 +
 configs/k2g_hs_evm_defconfig                  |  1 +
 configs/phycore_am62ax_a53_defconfig          |  1 +
 configs/phycore_am62ax_r5_defconfig           |  1 +
 configs/phycore_am62x_a53_defconfig           |  1 +
 configs/phycore_am62x_r5_defconfig            |  1 +
 configs/phycore_am64x_a53_defconfig           |  1 +
 configs/phycore_am64x_r5_defconfig            |  1 +
 configs/phycore_am68x_r5_defconfig            |  1 +
 configs/r8a779g0_whitehawk_defconfig          |  1 +
 configs/r8a779g3_sparrowhawk_defconfig        |  1 +
 configs/r8a78000_ironhide_cm33_defconfig      |  1 +
 configs/sandbox64_defconfig                   |  1 +
 configs/sandbox_defconfig                     |  1 +
 configs/sandbox_flattree_defconfig            |  1 +
 configs/sandbox_noinst_defconfig              |  1 +
 configs/sandbox_spl_defconfig                 |  1 +
 configs/sandbox_vpl_defconfig                 |  1 +
 configs/sc598-som-ezkit-spl_defconfig         |  1 +
 configs/sc598-som-ezlite-spl_defconfig        |  1 +
 ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |  1 +
 ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |  1 +
 ...-microgea-stm32mp1-microdev2-of7_defconfig |  1 +
 ...mp15-microgea-stm32mp1-microdev2_defconfig |  1 +
 configs/stm32mp15-odyssey_defconfig           |  1 +
 configs/stm32mp15_basic_defconfig             |  1 +
 configs/stm32mp15_defconfig                   |  1 +
 configs/stm32mp15_dhsom.config                |  1 +
 configs/stm32mp15_trusted_defconfig           |  1 +
 configs/toradex-smarc-imx95_defconfig         |  1 +
 configs/verdin-am62_a53_defconfig             |  1 +
 configs/verdin-am62_r5_defconfig              |  1 +
 configs/verdin-am62p_a53_defconfig            |  1 +
 configs/verdin-am62p_r5_defconfig             |  1 +
 configs/verdin-imx95_defconfig                |  1 +
 drivers/remoteproc/Kconfig                    | 21 +++++--------------
 66 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 4ef35004c57..c852c1c742e 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -69,6 +69,7 @@ config TARGET_IMX8MQ_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
@@ -103,6 +104,7 @@ config TARGET_IMX8MM_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
@@ -198,6 +200,7 @@ config TARGET_IMX8MN_EVK
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
@@ -213,6 +216,7 @@ config TARGET_IMX8MN_DDR4_EVK
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
@@ -274,6 +278,7 @@ config TARGET_IMX8MP_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 5089f44c247..96ddd8af8b3 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -89,6 +89,7 @@ config TARGET_IMX93_9X9_QSB
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
@@ -101,6 +102,7 @@ config TARGET_IMX93_11X11_EVK
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
@@ -113,6 +115,7 @@ config TARGET_IMX93W_EVK
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
@@ -125,6 +128,7 @@ config TARGET_IMX93_FRDM
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
 	select CMD_REMOTEPROC
+	select REMOTEPROC
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
diff --git a/configs/am62_pocketbeagle2_a53_defconfig b/configs/am62_pocketbeagle2_a53_defconfig
index 7428926a8ba..5f13fd597f6 100644
--- a/configs/am62_pocketbeagle2_a53_defconfig
+++ b/configs/am62_pocketbeagle2_a53_defconfig
@@ -106,6 +106,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
diff --git a/configs/am62_pocketbeagle2_r5_defconfig b/configs/am62_pocketbeagle2_r5_defconfig
index 76c7fa40fad..688951f0e24 100644
--- a/configs/am62_pocketbeagle2_r5_defconfig
+++ b/configs/am62_pocketbeagle2_r5_defconfig
@@ -86,6 +86,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index 167ba7ff8df..1744c23f50b 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -89,6 +89,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 37c034890cc..50882b9da96 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -90,6 +90,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index aa241a73c3f..2a169a94c63 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -128,6 +128,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 52e4ca6faae..51f57c8a008 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -106,6 +106,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index c9bc7cd8d39..758dfa37267 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -106,6 +106,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index 08b2c38b80d..6431d351817 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -85,6 +85,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 3d472e84ecd..9edc774d6db 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -121,6 +121,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 083fa780ca0..7ebe09986d7 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -103,6 +103,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 3a35df830e3..05664fc595a 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -161,6 +161,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 0ed15f5d553..b03b735fc51 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -125,6 +125,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 2cd3b263831..e3eeae05b8c 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -113,6 +113,7 @@ CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS62360=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index ad81ac4281a..5bd2ad73ae5 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -91,6 +91,7 @@ CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS62360=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am67a_beagley_ai_a53_defconfig b/configs/am67a_beagley_ai_a53_defconfig
index 09ac2044d41..316a08bf187 100644
--- a/configs/am67a_beagley_ai_a53_defconfig
+++ b/configs/am67a_beagley_ai_a53_defconfig
@@ -109,6 +109,7 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am67a_beagley_ai_r5_defconfig b/configs/am67a_beagley_ai_r5_defconfig
index 269dbc35e36..2edef87484f 100644
--- a/configs/am67a_beagley_ai_r5_defconfig
+++ b/configs/am67a_beagley_ai_r5_defconfig
@@ -86,6 +86,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/aquila-am69_r5_defconfig b/configs/aquila-am69_r5_defconfig
index ca1e78fc731..bbe48a97c16 100644
--- a/configs/aquila-am69_r5_defconfig
+++ b/configs/aquila-am69_r5_defconfig
@@ -96,6 +96,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR_TPS6287X=y
 CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/aquila-imx95_defconfig b/configs/aquila-imx95_defconfig
index 24b41fc8d5f..fccf125d1cb 100644
--- a/configs/aquila-imx95_defconfig
+++ b/configs/aquila-imx95_defconfig
@@ -159,6 +159,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index 82d4aae56bb..e5b50bfa28d 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -138,6 +138,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 7c429fe0bfe..4c2aa2271c1 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -141,6 +141,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/imx95_navq.config b/configs/imx95_navq.config
index f002fefddd4..e9a06994e51 100644
--- a/configs/imx95_navq.config
+++ b/configs/imx95_navq.config
@@ -141,6 +141,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index cf92381111a..b0800484c62 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -131,6 +131,7 @@ CONFIG_PMIC_TPS65941=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j721e_beagleboneai64_r5_defconfig b/configs/j721e_beagleboneai64_r5_defconfig
index ef08fb37409..a05f62635a9 100644
--- a/configs/j721e_beagleboneai64_r5_defconfig
+++ b/configs/j721e_beagleboneai64_r5_defconfig
@@ -101,6 +101,7 @@ CONFIG_PMIC_TPS65941=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index 3fd9a6253a8..95dc0e5c924 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -139,6 +139,7 @@ CONFIG_PMIC_TPS65941=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 6e493c97635..6f24b88e00b 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -137,6 +137,7 @@ CONFIG_PMIC_TPS65941=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 8ee736ccdf1..fe4017ef176 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -132,6 +132,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 7ce8b6be564..f84aa51187a 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -113,6 +113,7 @@ CONFIG_PMIC_TPS65941=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 5fe9466bdda..0fb4f1cab15 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -141,6 +141,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR_TPS6287X=y
 CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/k2g_evm_defconfig b/configs/k2g_evm_defconfig
index a5a987c235c..5dc3de140a8 100644
--- a/configs/k2g_evm_defconfig
+++ b/configs/k2g_evm_defconfig
@@ -92,6 +92,7 @@ CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY=y
 CONFIG_NOP_PHY=y
 CONFIG_KEYSTONE_USB_PHY=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_TI_POWER=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
diff --git a/configs/k2g_hs_evm_defconfig b/configs/k2g_hs_evm_defconfig
index 74500febacd..5b8404f86a5 100644
--- a/configs/k2g_hs_evm_defconfig
+++ b/configs/k2g_hs_evm_defconfig
@@ -65,6 +65,7 @@ CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_PHY=y
 CONFIG_NOP_PHY=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_TI_POWER=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index a77bfd3d4c1..9cc714efec0 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -148,6 +148,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax_r5_defconfig
index 947fe46d73e..b9c28c2e79a 100644
--- a/configs/phycore_am62ax_r5_defconfig
+++ b/configs/phycore_am62ax_r5_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index ddf53b481cd..e5215bc9230 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -142,6 +142,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
index e1c1b101694..f5efdb3fa8f 100644
--- a/configs/phycore_am62x_r5_defconfig
+++ b/configs/phycore_am62x_r5_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 7793f8b9c8a..32e375e3dc3 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -149,6 +149,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index c40ac042a90..3fe5fe0df29 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -128,6 +128,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/phycore_am68x_r5_defconfig b/configs/phycore_am68x_r5_defconfig
index 1798f76aeeb..0dc762ae855 100644
--- a/configs/phycore_am68x_r5_defconfig
+++ b/configs/phycore_am68x_r5_defconfig
@@ -140,6 +140,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR_TPS6287X=y
 CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 9be831720ed..b4fb0642c9d 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -16,6 +16,7 @@ CONFIG_BINMAN=y
 CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a779g0-white-hawk.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a779g0-white-hawk.dtb"
 CONFIG_CMD_REMOTEPROC=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_RENESAS_APMU=y
 CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index a36ed3ffa3a..8513fe4f040 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -23,6 +23,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DEFAULT_FDT_FILE="r8a779g3-sparrow-hawk.dtb"
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_GPIO_HOG=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_RENESAS_APMU=y
 CONFIG_BITBANGMII=y
 CONFIG_CLK_RS9_PCIE=y
diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index 3f09a7c2556..36036d80fe0 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -54,6 +54,7 @@ CONFIG_PHY_TI_DP83869=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_RAM=y
 CONFIG_RAM_RENESAS_DBSC5=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_RENESAS_RSIP=y
 CONFIG_RENESAS_ETHER_SWITCH=y
 CONFIG_RENESAS_R8A78000_POWER_DOMAIN=y
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index f861d3ef06d..85e2b6c200d 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -229,6 +229,7 @@ CONFIG_DM_PWM=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_PWM_SANDBOX=y
 CONFIG_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_SANDBOX=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_RV8803=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a3fa5246082..ea64da923ed 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -332,6 +332,7 @@ CONFIG_RAM=y
 CONFIG_DM_REBOOT_MODE=y
 CONFIG_DM_REBOOT_MODE_GPIO=y
 CONFIG_DM_REBOOT_MODE_RTC=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_SANDBOX=y
 CONFIG_RESET_SYSCON=y
 CONFIG_RESET_SCMI=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 0035aeae517..278cb97722f 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -183,6 +183,7 @@ CONFIG_DM_PWM=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_PWM_SANDBOX=y
 CONFIG_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_SANDBOX=y
 CONFIG_DM_RTC=y
 CONFIG_SANDBOX_SERIAL=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index c2faae502ea..5dab31dec2f 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -228,6 +228,7 @@ CONFIG_DM_PWM=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_PWM_SANDBOX=y
 CONFIG_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_SANDBOX=y
 CONFIG_DM_RTC=y
 CONFIG_SPL_DM_RTC=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index b1112fd45e7..300de04876f 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -195,6 +195,7 @@ CONFIG_DM_PWM=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_PWM_SANDBOX=y
 CONFIG_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_SANDBOX=y
 CONFIG_DM_RTC=y
 CONFIG_SPL_DM_RTC=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 07cf968f8ed..cbc7d125f0b 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -202,6 +202,7 @@ CONFIG_DM_PWM=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_PWM_SANDBOX=y
 CONFIG_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_SANDBOX=y
 CONFIG_DM_RTC=y
 CONFIG_SPL_DM_RTC=y
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index 7d5228a2ded..9e7246a2a6d 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -99,6 +99,7 @@ CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
 # CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_ADI_SC5XX=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 8d42e9a4d2f..eb8a18f231e 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -98,6 +98,7 @@ CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
 # CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_ADI_SC5XX=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
index 6237e774dc1..ea321442c09 100644
--- a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
@@ -84,6 +84,7 @@ CONFIG_PMIC_STPMIC1=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_STM32=y
diff --git a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
index 873bbc3c546..69dd29248f3 100644
--- a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
@@ -84,6 +84,7 @@ CONFIG_PMIC_STPMIC1=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_STM32=y
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
index 52ce08a5d68..d73189e066a 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
@@ -84,6 +84,7 @@ CONFIG_PMIC_STPMIC1=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_STM32=y
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
index 322ca332049..8c62c0f3ba3 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
@@ -84,6 +84,7 @@ CONFIG_PMIC_STPMIC1=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_STM32=y
diff --git a/configs/stm32mp15-odyssey_defconfig b/configs/stm32mp15-odyssey_defconfig
index 88552d3f94f..1caed1356ac 100644
--- a/configs/stm32mp15-odyssey_defconfig
+++ b/configs/stm32mp15-odyssey_defconfig
@@ -124,6 +124,7 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_STM32_VREFBUF=y
 CONFIG_DM_REGULATOR_STPMIC1=y
 CONFIG_DM_REGULATOR_SCMI=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_RESET_SCMI=y
 CONFIG_DM_RNG=y
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index ac1768270b5..5b67ac7ca04 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -156,6 +156,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_STM32_VREFBUF=y
 CONFIG_DM_REGULATOR_STPMIC1=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_STM32=y
diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index 53903376524..ef16fe17d70 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -127,6 +127,7 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_STM32_VREFBUF=y
 CONFIG_DM_REGULATOR_STPMIC1=y
 CONFIG_DM_REGULATOR_SCMI=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_RESET_SCMI=y
 CONFIG_DM_RNG=y
diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
index 24420372e3f..86bde6407e6 100644
--- a/configs/stm32mp15_dhsom.config
+++ b/configs/stm32mp15_dhsom.config
@@ -21,6 +21,7 @@ CONFIG_KS8851_MLL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
 CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PINCTRL_STMFX=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_SERVERIP="192.168.1.1"
 CONFIG_SF_DEFAULT_SPEED=50000000
diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index d7879631746..864f4f95cf5 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -127,6 +127,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_STM32_VREFBUF=y
 CONFIG_DM_REGULATOR_STPMIC1=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
 CONFIG_RESET_SCMI=y
 CONFIG_DM_RNG=y
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 3e4d75d3239..f4f284dc29b 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -160,6 +160,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 71ddfff7d61..dd9e09aba7c 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -162,6 +162,7 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index 5beb29ca6c4..656cc72b116 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -81,6 +81,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index 70a9f2389f4..c7cba8fe773 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -160,6 +160,7 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_REMOTEPROC_TI_K3_DSP=y
diff --git a/configs/verdin-am62p_r5_defconfig b/configs/verdin-am62p_r5_defconfig
index 6eecf4f5fb2..3a5daf37d68 100644
--- a/configs/verdin-am62p_r5_defconfig
+++ b/configs/verdin-am62p_r5_defconfig
@@ -79,6 +79,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index 85c4acbb958..9717959d12f 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -162,6 +162,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index cde572d61c1..bdb8bfbba8d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -9,14 +9,15 @@ menu "Remote Processor drivers"
 # REMOTEPROC gets selected by drivers as needed
 # All users should depend on DM
 config REMOTEPROC
-	bool
+	bool "Support for Remote Processor subsystem"
 	depends on DM
 
 # Please keep the configuration alphabetically sorted.
 
+if REMOTEPROC
+
 config K3_SYSTEM_CONTROLLER
 	bool "Support for TI' K3 System Controller"
-	select REMOTEPROC
 	depends on DM
 	depends on ARCH_K3
 	depends on OF_CONTROL
@@ -25,7 +26,6 @@ config K3_SYSTEM_CONTROLLER
 
 config REMOTEPROC_ADI_SC5XX
 	bool "Support for ADI SC5xx SHARC cores"
-	select REMOTEPROC
 	depends on DM
 	depends on ARCH_SC5XX
 	depends on SYSCON
@@ -35,14 +35,12 @@ config REMOTEPROC_ADI_SC5XX
 
 config REMOTEPROC_IMX
 	bool "Support for NXP i.MX remoteproc"
-	select REMOTEPROC
 	depends on DM && MACH_IMX && OF_CONTROL
 	help
 	  Say 'y' here to add support for i.MX remoteproc.
 
 config REMOTEPROC_RENESAS_APMU
 	bool "Support for Renesas R-Car Gen4 APMU start of CR52 processor"
-	select REMOTEPROC
 	depends on ARCH_RENESAS && RCAR_GEN4 && DM && OF_CONTROL
 	help
 	  Say 'y' here to add support for Renesas R-Car Gen4 Cortex-R52
@@ -50,7 +48,6 @@ config REMOTEPROC_RENESAS_APMU
 
 config REMOTEPROC_RENESAS_RSIP
 	bool "Support for Renesas R-Car Gen5 RSIP start of SCP/CR52/CA720 processors"
-	select REMOTEPROC
 	depends on ARCH_RENESAS && RCAR_GEN5 && DM && OF_CONTROL
 	help
 	  Say 'y' here to add support for Renesas R-Car Gen5 RSIP
@@ -59,7 +56,6 @@ config REMOTEPROC_RENESAS_RSIP
 
 config REMOTEPROC_SANDBOX
 	bool "Support for Test processor for Sandbox"
-	select REMOTEPROC
 	depends on DM
 	depends on SANDBOX
 	help
@@ -68,7 +64,6 @@ config REMOTEPROC_SANDBOX
 
 config REMOTEPROC_STM32_COPRO
 	bool "Support for STM32 coprocessor"
-	select REMOTEPROC
 	depends on DM
 	depends on ARCH_STM32MP
 	depends on OF_CONTROL
@@ -78,7 +73,6 @@ config REMOTEPROC_STM32_COPRO
 
 config REMOTEPROC_TI_K3_ARM64
 	bool "Support for TI's K3 based ARM64 remoteproc driver"
-	select REMOTEPROC
 	depends on DM
 	depends on ARCH_K3
 	depends on OF_CONTROL
@@ -90,7 +84,6 @@ config REMOTEPROC_TI_K3_ARM64
 
 config REMOTEPROC_TI_K3_DSP
 	bool "TI K3 C66 and C71 remoteproc support"
-	select REMOTEPROC
 	depends on ARCH_K3
 	depends on TI_SCI_PROTOCOL
 	help
@@ -100,7 +93,6 @@ config REMOTEPROC_TI_K3_DSP
 
 config REMOTEPROC_TI_K3_M4F
 	bool "TI K3 M4F remoteproc support"
-	select REMOTEPROC
 	depends on ARCH_K3
 	depends on TI_SCI_PROTOCOL
 	help
@@ -110,7 +102,6 @@ config REMOTEPROC_TI_K3_M4F
 
 config REMOTEPROC_TI_K3_R5F
 	bool "TI K3 R5F remoteproc support"
-	select REMOTEPROC
 	depends on ARCH_K3
 	depends on TI_SCI_PROTOCOL
 	help
@@ -120,7 +111,6 @@ config REMOTEPROC_TI_K3_R5F
 
 config REMOTEPROC_TI_POWER
 	bool "Support for TI Power processor"
-	select REMOTEPROC
 	depends on DM
 	depends on ARCH_KEYSTONE
 	depends on OF_CONTROL
@@ -130,7 +120,6 @@ config REMOTEPROC_TI_POWER
 
 config REMOTEPROC_TI_PRU
 	bool "Support for TI's K3 based PRU remoteproc driver"
-	select REMOTEPROC
 	depends on DM
 	depends on TI_PRUSS
 	depends on ARCH_K3
@@ -140,7 +129,6 @@ config REMOTEPROC_TI_PRU
 
 config REMOTEPROC_TI_IPU
 	bool "Support for TI's K3 based IPU remoteproc driver"
-	select REMOTEPROC
 	depends on ARCH_K3
 	depends on DM
 	depends on SPL_DRIVERS_MISC
@@ -151,10 +139,11 @@ config REMOTEPROC_TI_IPU
 
 config REMOTEPROC_MAX_FW_SIZE
 	hex "Maximum size of firmware file that needs to be loaded to the remote processor"
-	depends on REMOTEPROC
 	default 0x10000
 	help
 	  Maximum size of the firmware file (elf, binary) that needs to be
 	  loaded to the remote processor.
 
+endif
+
 endmenu
-- 
2.53.0

