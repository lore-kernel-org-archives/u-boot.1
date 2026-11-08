Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A2606A326
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UFpISfps;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=QRg+fVkx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EF6E605A9;
	Sun,  8 Nov 2026 00:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iDc9HPsXo3NG; Sun,  8 Nov 2026 00:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4CEFF60699
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794098582;
	b=rg/qVmHTLuLz4WIbZ/FQy+NnVd5niemuZlpUE1ApktcyfdxCKF1CDxLFi7VzBqQDmOYm
	 SP6XW43VfM+D43GPmwKKLDmkLEOyZ50LwokTz/pS3tjykp45+KktsIpem2iomsktH3erq
	 CMUOgjLfK9p/ZzrbRybiolwTg8KAkPOnul3y0M7O6rT43fOgzIBMX2qxJ7eUQf5xo6v0s
	 pggt9UVa09CMelqzuMFD4ihkCyUy12RMMKbbs8l1aFHiJ86Gpx90NnJjztJkww8FGKc69
	 DriXD7uzYTHFgO1lFRj9w9FXGrn4ShREUYTCEa/UlyiBnW5mVuJPGrq96QOfCDeJ4Lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794098582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=95cs9n6N9bbovItPAoaQu5GQC3WpHJHLivoq0PER7mI=;
	b=mI1BcKa4elbo6nmom9jKQ7oFwIAhm8RUPZdXu1W66ThXH26ALKMFG6OPiI/uTMmfK3vX
	 vGFgGTNWR6nqH71B8uvjo9Invvp3ob51ZG/FYvW/3FeVdScKznq1oOu7q8AkNYdK8bR/e
	 a56bXdoeOpmlDLJOKXDfLC/zMMW5gZu+ZhwJ1hAGvkUaULPGBifzvvSx2ucMTJ6mQ9yPO
	 Gz1QjiEcA9V0Mc3+eS805ygJyqGO/nEjWctJ/yyxpKPaWHWlrG4zpYtI/b40i6OLJR0MD
	 BUcN4BPOA5V/jtf47PQYIS32O4sWX74rrTiwd9lGbQGL/WyLM5YgGBOjuslTtAhLp9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794098582;
	bh=95cs9n6N9bbovItPAoaQu5GQC3WpHJHLivoq0PER7mI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UFpISfps4y/el/Wbs0QTFpJFcbo2xw3ZQH4D6d9E8cdAmWg1CTKUGnW9RvObhVfA/
	 YbTW4E2hfOIiApGo/yDn1n6AChdqR8u/E64yp0OTplG3vBPUuOAN3kSRQVqjoo/bdj
	 DbfGR/vEuXCpfeoj2z9HPlq0eEHnErVNmQF6MCHsQPXuaMdsPfacBD5w+RFufLBhli
	 aI/2jIY827rYUrboK//jXteGtVP2bW2gELaxwW5Q8IScxxxGeIr7U8JrqzdvC0EA6v
	 BA2YwtV47ozuQJv98yP16e8cWxVKXAQJZQ6Mlf63XGUrbEr2NEY7Rbn3gmRAmRJ4NU
	 N897XbfeEhoyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CEFF60699;
	Sun,  8 Nov 2026 00:43:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4158837D
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 277E880E86
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJW7mwmbG6sG for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 00:42:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15E8A80E83
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=QRg+fVkx
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15E8A80E83
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:57 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b0d63f60bcso844677b3.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 16:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1794098576; x=1794703376;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=95cs9n6N9bbovItPAoaQu5GQC3WpHJHLivoq0PER7mI=;
 b=QRg+fVkxbD0m5d6MRQQPdxVeTZxFffMu4NDl686GAbEUQz+fFwa9hK6f8ZuaknNehg
 zgBLfUp+0e2WQzBM5mjeEJagLhuXhRgT6N3Kbnzej8vAN7BZ9Qr5EAvtNzUZAqpkStny
 n3dgeiOaFm4AS8A+eewZGoe5y0LqFcpHCgUYApeBBH5KXSYLjPryfTEC7DNXpr74TPb4
 Ym/YR1+6scHIclYp6ilgXDCLoIht4QS/CGgol/6exXRFqerrGA1zvfnOpAzaSj7zSpA8
 8AVPEmVJHSd+mguF4d3SpP2DbD9UhOUL8mQhoOzic3Aux1LLoAeD0MPNDNpZQBCcWlzN
 t9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794098576; x=1794703376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=95cs9n6N9bbovItPAoaQu5GQC3WpHJHLivoq0PER7mI=;
 b=bdDTTt1s+HsQ/UQiIskHCCA2S/qH+2WBo1/M3YoY6nzdLRL+4No6NYIpdF8GrdWbKN
 uPo41H0UdbQ9GyuAfoLnMCnWcEeCtZvK0ETU9e5it/J/DzefkzppALmy+ExZey2QFRaS
 zkStjOjuOPuJ2pTUD+VbluVLGqT0zOhZ3yEjjkL4c+Lpbskyi00351PY1QxUOpqQsrDg
 5vDu3NtPg0pmrTzGMTum4TqE7lGRPV+QSmVAwI+T0fJ3EU9LSbC0JyZ2jPktet8mjocL
 4TTa320i/+d6i5w/jeX820xNbAWQDi4cft2hH6U7Fekg8797E7dX0y/eBxb1P5hQzwdb
 FGog==
X-Forwarded-Encrypted: i=1;
 AL+hErGpchVrbrJnyn23CGzNW9tnvQ9roYugT3P9EteW1Un6i5u/vDRFWKAQqnRUlCkmdB7t31I1KlQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/QqQfu8xSJzgGh+hMhr0UjMtVsIR0Os1MLeVkZpOrDv+n39pdv
 PIh8v+H1wePYpcTS/pr+KWjP9HSo+3P6wRNmSnUZ0P5ii4sWiSfYT52KZEwSaAvCHHM=
X-Gm-Gg: AYBFou3rm9TQDUY8tCPLsPFusxNNY/fSpppTEDmGffAtaeM8Lw8NIla6b63W78tm73Z
 KQfdNhjWVubGCzqtof2bPKwWIaRZrFwOG4RSSG+BLhWWbW0ycylNz2q8aLyX7bj+G2gJxosMqep
 QGmaz6cSmgb66ORgu5NicGeDWkv/AReK2gWGFlSmoyMHoqn8ax4OOlByJ3kYPVDsc7i7SeI/Sa/
 r6MbmFpQYCc7TEyj2r7izY4NfHyKDUwXnK338Pch+nDlOWMy+PQacMviLkdGlpALze9RGjPBor2
 zuJ5NN6nD4BIDjxF30XE0k7sEi2+Q3rboq5gG/KUHqMEG5wBEquPyihU9iHjn0jxFS97SlveOSF
 ap3srcUfYVK60BMUE0DVQUZ6zbee1Qtvdx3JIuD4pOYBdFznVDRcaBuREolKTGXjN3Ks+DG7+s9
 CfIzZoEJ29X22en1c3U+lWcs4zkZ0JDtjXKNgTukO8MhANz+w4ePfN2X47wZ03EmO2THrOOyQ2V
 96eUHXN/5Kdv5Y/IRuuNyyQcBJaf1azMV7mP2eTUW/eOn0udWx8N9ejNLBLiG+KKHzX/LWP5vzC
 DJbM2EwTA2JFIpGe4lYGO/TSEPcdkwPmrHlw1nPWrk8a8oKeRSHKi5WmO5SMWl9jwFWiLKGkaV8
 ViF88jiVaQxfqaNlB7J76SYDSJnDs
X-Received: by 2002:a05:690e:4391:b0:67b:f521:e2a3 with SMTP id
 956f58d0204a3-67c3da53aeamr125318d50.87.1794098576146; 
 Sat, 07 Nov 2026 16:42:56 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:974a:b1a3:b1b8:ea0])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b97dd68sm658485d50.21.2026.11.07.16.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 16:42:55 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 07 Nov 2026 18:42:02 -0600
Subject: [PATCH 2/2] riscv: Add driver for M-mode IPIs using M-mode IMSIC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-mimsic_ipi-v1-2-c08bdd2bf482@oss.tenstorrent.com>
References: <20261107-mimsic_ipi-v1-0-c08bdd2bf482@oss.tenstorrent.com>
In-Reply-To: <20261107-mimsic_ipi-v1-0-c08bdd2bf482@oss.tenstorrent.com>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Tianrui Wei <tianrui-wei@outlook.com>, 
 Sean Anderson <seanga2@gmail.com>, Yixun Lan <dlan@kernel.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Guodong Xu <guodong@riscstar.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds functionality for RISC-V CPUs that have an M-mode IMISC to use that
for IPIs in U-boot SPL and M-mode U-boot.

This driver supports SoCs which have monotonically increasing hart IDs
starting from 0 and a single IMSIC address range.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 arch/riscv/Kconfig                   |  16 ++++++
 arch/riscv/cpu/start.S               |  32 +++++++++++
 arch/riscv/include/asm/csr.h         |  11 ++++
 arch/riscv/include/asm/global_data.h |   5 ++
 arch/riscv/include/asm/syscon.h      |   1 +
 arch/riscv/lib/Makefile              |   1 +
 arch/riscv/lib/mimsic_ipi.c          | 103 +++++++++++++++++++++++++++++++++++
 7 files changed, 169 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 17194f9f6ac..0aad105b972 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -416,6 +416,22 @@ config SPL_RISCV_ACLINT_IPI
 	help
 	  Use the MSWI block in ACLINT for IPI in M-Mode U-boot SPL.
 
+config RISCV_MIMSIC_IPI
+	bool
+	depends on RISCV_MMODE
+	select REGMAP
+	select SYSCON
+	help
+	  Use M-Mode IMSIC for IPI in M-Mode U-boot.
+
+config SPL_RISCV_MIMSIC_IPI
+	bool
+	depends on SPL_RISCV_MMODE
+	select SPL_REGMAP
+	select SPL_SYSCON
+	help
+	  Use M-Mode IMSIC for IPI in M-Mode U-boot SPL.
+
 config SIFIVE_CACHE
 	bool
 	help
diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 7bafdfd390a..1a16636d362 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -79,11 +79,38 @@ _start:
 
 	/* set xSIE bit to receive IPIs */
 #if CONFIG_IS_ENABLED(RISCV_MMODE)
+#if CONFIG_IS_ENABLED(RISCV_MIMSIC_IPI)
+	li	t0, MIE_MEIE
+#else
 	li	t0, MIE_MSIE
+#endif
 #else
 	li	t0, SIE_SSIE
 #endif
 	csrs	MODE_PREFIX(ie), t0
+
+#if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(RISCV_MIMSIC_IPI)
+	/* Disable trapping on interrupts */
+	li      t0, MSTATUS_MIE
+	csrc    CSR_MSTATUS, t0
+
+	/* Enable IMSIC interrupt delivery to mip.MEIP on this hart */
+	li	t0, IMSIC_EIDELIVERY
+	csrw	CSR_MISELECT, t0
+	li	t0, 1
+	csrw	CSR_MIREG, t0
+
+	/* Set threshold to 0 so all priorities are delivered */
+	li	t0, IMSIC_EITHRESHOLD
+	csrw	CSR_MISELECT, t0
+	csrw	CSR_MIREG, zero
+
+	/* Enable interrupt identity 1 (IPI) in eie0 */
+	li	t0, IMSIC_EIE0
+	csrw	CSR_MISELECT, t0
+	li	t0, (1 << IMSIC_IPI_ID)
+	csrw	CSR_MIREG, t0
+#endif
 #endif
 
 /*
@@ -452,7 +479,12 @@ secondary_hart_loop:
 #if CONFIG_IS_ENABLED(SMP)
 	csrr	t0, MODE_PREFIX(ip)
 #if CONFIG_IS_ENABLED(RISCV_MMODE)
+#if CONFIG_IS_ENABLED(RISCV_MIMSIC_IPI)
+	li	t1, MIE_MEIE
+	and	t0, t0, t1
+#else
 	andi	t0, t0, MIE_MSIE
+#endif
 #else
 	andi	t0, t0, SIE_SSIE
 #endif
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 986f951c31a..0f9f803b212 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -93,10 +93,18 @@
 
 /* SIE (Interrupt Enable) and SIP (Interrupt Pending) flags */
 #define MIE_MSIE		(_AC(0x1, UL) << IRQ_M_SOFT)
+#define MIE_MEIE		(_AC(0x1, UL) << IRQ_M_EXT)
 #define SIE_SSIE		(_AC(0x1, UL) << IRQ_S_SOFT)
 #define SIE_STIE		(_AC(0x1, UL) << IRQ_S_TIMER)
 #define SIE_SEIE		(_AC(0x1, UL) << IRQ_S_EXT)
 
+/* IMSIC indirect register addresses (indexed via CSR_MISELECT) */
+#define IMSIC_EIDELIVERY	0x70
+#define IMSIC_EITHRESHOLD	0x72
+#define IMSIC_EIE0		0xC0
+
+#define IMSIC_IPI_ID		1
+
 #define CSR_FCSR		0x003
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
@@ -131,6 +139,9 @@
 #define CSR_MCAUSE		0x342
 #define CSR_MTVAL		0x343
 #define CSR_MIP			0x344
+#define CSR_MISELECT		0x350
+#define CSR_MIREG		0x351
+#define CSR_MTOPEI		0x35C
 #ifdef CONFIG_RISCV_PRIV_1_9
 #define CSR_MBASE		0x380
 #define CSR_MBOUND		0x381
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 33f2b5ec5c8..95fdc6f121d 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -26,6 +26,11 @@ struct arch_global_data {
 #ifdef CONFIG_ANDES_PLICSW
 	void __iomem *plicsw;	/* andes plicsw base address */
 #endif
+#if CONFIG_IS_ENABLED(RISCV_MIMSIC_IPI)
+	void __iomem *mimsic;
+	u32 mimsic_guest_index_bits;
+	unsigned int mimsic_ipi_pending[CONFIG_NR_CPUS];
+#endif
 #if CONFIG_IS_ENABLED(SMP)
 	struct ipi_data ipi[CONFIG_NR_CPUS];
 #endif
diff --git a/arch/riscv/include/asm/syscon.h b/arch/riscv/include/asm/syscon.h
index 5787702e746..f79ff7145eb 100644
--- a/arch/riscv/include/asm/syscon.h
+++ b/arch/riscv/include/asm/syscon.h
@@ -14,6 +14,7 @@ enum {
 	RISCV_NONE,
 	RISCV_SYSCON_ACLINT,	/* Advanced Core Local Interruptor (ACLINT) */
 	RISCV_SYSCON_PLICSW,	/* Andes PLICSW */
+	RISCV_SYSCON_MIMSIC,	/* M-mode IMSIC on AIA Compatible Machine */
 };
 
 #endif /* _ASM_SYSCON_H */
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index a4f2968f05f..54fa18a955a 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SIFIVE_CACHE) += sifive_cache.o
 obj-$(CONFIG_SYS_CACHE_THEAD_CMO) += thead_cmo.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
 obj-$(CONFIG_$(PHASE_)RISCV_ACLINT_IPI) += aclint_ipi.o
+obj-$(CONFIG_$(PHASE_)RISCV_MIMSIC_IPI) += mimsic_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) += andes_plicsw.o
 else
 obj-$(CONFIG_SBI) += sbi.o
diff --git a/arch/riscv/lib/mimsic_ipi.c b/arch/riscv/lib/mimsic_ipi.c
new file mode 100644
index 00000000000..ca974b49bd6
--- /dev/null
+++ b/arch/riscv/lib/mimsic_ipi.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Tenstorrent
+ */
+
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/syscon.h>
+#include <asm/csr.h>
+#include <dm/device-internal.h>
+
+#define IMSIC_MMIO_PAGE_SHIFT 12
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int riscv_init_ipi(void)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	const fdt32_t *prop;
+	bool mimsic_found = false;
+	int size;
+	int ret;
+
+	uclass_id_foreach_dev(UCLASS_SYSCON, dev, uc) {
+		if (dev_get_driver_data(dev) == RISCV_SYSCON_MIMSIC) {
+			/*
+			 * Look at interrupts-extended property for each IMSIC node
+			 * to check the 2nd entry
+			 * M-Mode IMSICs would have IRQ_M_EXT (11), which we want
+			 * S-Mode IMSICs would have IRQ_S_EXT (9), which we don't want
+			 */
+			prop = dev_read_prop(dev, "interrupts-extended", &size);
+			if (!prop || size < 2 * sizeof(fdt32_t))
+				continue;
+
+			if (fdt32_to_cpu(prop[1]) == IRQ_M_EXT) {
+				mimsic_found = true;
+				break;
+			}
+		}
+	}
+
+	if (!mimsic_found)
+		return -ENODEV;
+
+	ret = device_probe(dev);
+	if (ret)
+		return ret;
+
+	gd->arch.mimsic = regmap_get_range(syscon_get_regmap(dev), 0);
+	if (!gd->arch.mimsic)
+		return -ENOENT;
+
+	gd->arch.mimsic_guest_index_bits =
+		dev_read_u32_default(dev, "riscv,guest-index-bits", 0);
+
+	return 0;
+}
+
+int riscv_send_ipi(int hart)
+{
+	__smp_store_release(&gd->arch.mimsic_ipi_pending[hart], 1);
+	writel(IMSIC_IPI_ID,
+	       (void __iomem *)(gd->arch.mimsic +
+				(hart << (IMSIC_MMIO_PAGE_SHIFT +
+					  gd->arch.mimsic_guest_index_bits))));
+
+	return 0;
+}
+
+int riscv_clear_ipi(int hart)
+{
+	/*
+	 * Read and write to mtopei in one instruction to claim the interrupt
+	 * Value written to mtopei is ignored.
+	 */
+	csr_swap(CSR_MTOPEI, 0);
+	__smp_store_release(&gd->arch.mimsic_ipi_pending[hart], 0);
+	return 0;
+}
+
+int riscv_get_ipi(int hart, int *pending)
+{
+	*pending = __smp_load_acquire(&gd->arch.mimsic_ipi_pending[hart]);
+	return 0;
+}
+
+static const struct udevice_id riscv_mimsic_ipi_ids[] = {
+	{ .compatible = "riscv,imsics", .data = RISCV_SYSCON_MIMSIC },
+	{}
+};
+
+U_BOOT_DRIVER(riscv_mimsic_ipi) = {
+	.name = "riscv_mimsic_ipi",
+	.id = UCLASS_SYSCON,
+	.of_match = riscv_mimsic_ipi_ids,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.43.0

