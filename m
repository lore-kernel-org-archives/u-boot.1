Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED4606A326
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eGmD57sT;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=DMv+IWPU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 235BF406A1;
	Sun,  8 Nov 2026 00:43:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADhiTCvA6sTS; Sun,  8 Nov 2026 00:43:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A873E40684
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794098580;
	b=eO+WUuqijIzJw+5DCXsCWgUixXkjZ8cZ2USDm/J/Zx5Z2E1+ZWWYlMvJdNMqYEIqZqAR
	 LwdydEH3kvom+8tnCNQZPtwTTL9PKeezm7QM1JuysjQSWQL0QH9k+wsfF0+XcA5me6DYE
	 BYIWPCGOc9Uwb6B4N5jmCEi6iUnWTh4Qr4ZyA2B0GoFeufVKrOVHAvlM3+6iYGcOi5qh7
	 8j+SXis/hCvUf4eJ2UrddlOVJXUbTVulI18R51qiw/vMEXyZVn9QuO3yoMdweJ/UGEpS1
	 YIGi/cy9Dh2GSSItHodsVA+Ne+9xJZ07L7runVSxnQh/gdyoaMKeq2Yo5zDiUPotZPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794098580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zFoyD+634rZfbyt7xN2WmREVEsGdvsPXIRfqfQejiCE=;
	b=IwIpAfmFDbVF5sR4gn81AiLyNusj4nyAF8KDxYFtaJ+MeEUD9uT3e41WIYIE4t3gFzUN
	 1tKDwFaBx5QssCz4Tlkr78wLj33i4P5EWjONdLlbOEFPdPWnXNYtENKh70seweMBABCLD
	 T2eIfADRp1UIs7QExdMF+q6jF4EprZcq8QxnDDd5pNYVAqhb5nHbEhIIS1fBngnO0PYag
	 kIBkdisxZeA88fVB4XVYQKeVrSAfTwVI9JJvQdm48zC4N1m0bd7yHOjgG8fPnqpmwmFVU
	 ym0u782qkLQs6ZToblWfDdbs1RZ1c6afqUE1lWjW5eMV2vzJBtwWRuWpt6zuBb2fjOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794098580;
	bh=zFoyD+634rZfbyt7xN2WmREVEsGdvsPXIRfqfQejiCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eGmD57sTuKxK93J06taYtSlgkWSoBwOjKiI92oRazfWS6RbMYQkaZndp/8FVA6xHh
	 Ep+x3BhCk4ZaIeDrjFcT2bnf84IADw7za5+gB6cAS3uMjoKty7jnkbgyDZzGaEJWtG
	 +xPz94zQ/uhmMpQfFFg6Yhh2r0WKTbJWO/2Ok7KFWyNTxwpg5ZXm06p4bGz2je5tet
	 kqlTOb8mAzx6kRGjcypEFyjZEpaZEcRHz6kBQAVZm2YugPEP9wsg5dzIrfjTiqBeU7
	 igaqqYh3CPJVmWHh9TdYHsrLHQeVhvVavoqRRNVAxQgRhJcM0YX21QtQkq6pJSfHwD
	 am+C593eGdavw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A873E40684;
	Sun,  8 Nov 2026 00:43:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8236A3AD
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73C10400AE
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x6BmjyhNLd63 for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 00:42:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 112C940074
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=DMv+IWPU
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 112C940074
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:56 +0000 (UTC)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67bf3c6654fso76853d50.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 16:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1794098575; x=1794703375;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFoyD+634rZfbyt7xN2WmREVEsGdvsPXIRfqfQejiCE=;
 b=DMv+IWPUdp3rfIg5cYxZHHBNevfZKoONDV+YhiY1SDYetZbJQHBGo8g3DumaMGB9nS
 qPkY49pqIUuZU79frruxQNtxxihR2W5gBfYiVi0ge4OmNihPOBZ4bxH+KRxknohAy8vE
 pvvfU7z6BpSewtJ1ln8yAtCwTcmAOTo/7RSPkv9JgzbfC1AMFr33CXyBqbeVWn01atgE
 ynbv789IJVVoJIKyjn691yZrv5AKY2QOliu07NJAe0hKZ9mBwibR7eQyGcuvReGe2G4a
 zLsN6acFutocMImnkYpHnWznzGMKuyXWtCXAnCJAwOGTNrI/isqlR4H84JCdCteKMNWf
 vIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794098575; x=1794703375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zFoyD+634rZfbyt7xN2WmREVEsGdvsPXIRfqfQejiCE=;
 b=U9y9OBU10tS0ffccc4BA+UnzOiQJu3I9QSbvexjA9mjLm1F27YVESrAp+eM1az/IKK
 K2o4ZIC0ftDjEkGH4avCx5JNAhnLTSm0NMId4R3Y2jvd5d9sXxVMgFpZ2HnpSNkCBj9o
 E45OsGK9XQmEq6WzDrk1tkGWa1RgXzrdHITlGerXHfmWU1GFtMcQjFR7BBy90INHavdU
 JgGmIZg4VgvBnw8T/xIU7+q5CIRrjkj0lsftZioN3JL9WkalfUq1k493ymWhh90v9ZgF
 jSr9KYQxjVKna7zQslSyY06FzppyyASMLk0s4qkwVUXN7iwF1mRw4yWExBE1mkG6AHrI
 Jgaw==
X-Forwarded-Encrypted: i=1;
 AL+hErFcBu83HVVhT++0D6cbrNl/dQGFgoysMjC271L0sJyEStz3KZfuoCH3E9UPGLwb7QkYkuqVQac=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8MbbK2nwtwLKwNH4ucEqXaN50HxYZfDPjyAGhdFGbJLHJmec6m
 3rkSX/gprN164wtGkGHvJzktQYOEMdN1BCB8Mg7GFgHBOKdu6+z5BhNDpUqRG4pnPIU=
X-Gm-Gg: AYBFou23WHWSpD4mOeVsTfGC71jMXCVA97UHGZqseodbzcixS7V8KW06KFHpbJV47no
 G9v9GpTJQSaS3qD8SMjbuabN6e24Jfvn+cLTwP1v5z0Vl4YrN782AGrD5rCJchjePf5RNFEOoUC
 gYVy6PyhoyWL36VtiWXPzagP0yBQDim8en4tYrdzFGr0RGx3uYemFS31mtyKVtsoJ34WL52fFXV
 iISgvVLaljSa923wjcR04CkFuM2SVF3jCpl57+hFdreygPkxjdSYQ1FYbQrxuT4xRg3fqy1Qb3n
 CrFW26eCr7wd+9RFp+jlyqeh8Eko69PBP0n8HwyVIoXlr3jCYdUZfjEHM7xQH4POan+XvqeVj3y
 QCtBevftnrcdv7S9CGbtRBc8PqI5fcsbeg2PD984syChqu2KFOmfjh3knB2Ix+GPVJOU0GE0+fZ
 alk97IKXqu21BJ1VTjEExn2FxR3RmR9SnHE2xccXWUYvbVNb4m9ce1JZh1otsFOCoiL4TYzS/lz
 abpgO8p1gjkYZHHtHB3dJzH7/yzX9hY4QkbO3veRcx9D7aYuHUK4sfU1fE+FJg8ndsTtSzbGto9
 CY8Kf+g+rLqDxFPdkoQaghOLo1c25WJR0JQC0qnbr3SrW6NiUmD1fasFTfOjksaqzFDF26LxwOb
 g4Do1NjQ=
X-Received: by 2002:a05:690e:400f:b0:67c:3389:2bcc with SMTP id
 956f58d0204a3-67c3d9ce568mr181960d50.72.1794098575154; 
 Sat, 07 Nov 2026 16:42:55 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:974a:b1a3:b1b8:ea0])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b97dd68sm658485d50.21.2026.11.07.16.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 16:42:54 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 07 Nov 2026 18:42:01 -0600
Subject: [PATCH 1/2] riscv: move ACLINT MSWI based IPIs to separate Kconfig
 symbol
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-mimsic_ipi-v1-1-c08bdd2bf482@oss.tenstorrent.com>
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ACLINT specification [1] describes multiple components: 2 of which
are an M-mode timer and a MSWI device for M-mode sofware interrupts. The
specification was never ratified [2], as systems with AIA have an M-mode
IMSIC that provides software interrupts in M-mode. Some hardware
implement both components, while others (like Tensorrent Ascalon based
SoCs) drop the MSWI funcitonality and rely on the M-mode IMSIC.

The CONFIG_RISCV_ACLINT symbol currently is used to pick both
aclint_timer.o (which covers the timer functionality) and aclint_ipi.o
(which covers the mswi software interrupts functionality). Introduce a
new symbol called CONFIG_RISCV_ACLINT_IPI that SoCs can pick if they
rely on the ACLINT for M mode IPI functionality. All boards that
currently pick/imply the CONFIG_RISCV_ACLINT symbol have been updated to
also pick this newly added symbol.

[1] https://github.com/riscvarchive/riscv-aclint/blob/4e570bfd3201f2c09e5afd290b5091526b0f099a/riscv-aclint.adoc
[2] https://lists.riscv.org/g/tech-aia/topic/connections_between_aia_and/107177435

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 arch/riscv/Kconfig              | 12 ++++++++++++
 arch/riscv/cpu/fu540/Kconfig    |  1 +
 arch/riscv/cpu/fu740/Kconfig    |  1 +
 arch/riscv/cpu/generic/Kconfig  |  2 ++
 arch/riscv/cpu/jh7110/Kconfig   |  1 +
 arch/riscv/cpu/k1/Kconfig       |  2 ++
 arch/riscv/cpu/th1520/Kconfig   |  2 ++
 arch/riscv/lib/Makefile         |  2 +-
 board/openpiton/riscv64/Kconfig |  1 +
 board/sipeed/maix/Kconfig       |  1 +
 10 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a..17194f9f6ac 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -404,6 +404,18 @@ config SPL_RISCV_ACLINT
 	  The RISC-V ACLINT block holds memory-mapped control and status registers
 	  associated with software and timer interrupts.
 
+config RISCV_ACLINT_IPI
+	bool
+	depends on RISCV_ACLINT
+	help
+	  Use the MSWI block in ACLINT for IPI in M-Mode U-boot.
+
+config SPL_RISCV_ACLINT_IPI
+	bool
+	depends on SPL_RISCV_ACLINT
+	help
+	  Use the MSWI block in ACLINT for IPI in M-Mode U-boot SPL.
+
 config SIFIVE_CACHE
 	bool
 	help
diff --git a/arch/riscv/cpu/fu540/Kconfig b/arch/riscv/cpu/fu540/Kconfig
index f2934cb33e7..87a810ad2e0 100644
--- a/arch/riscv/cpu/fu540/Kconfig
+++ b/arch/riscv/cpu/fu540/Kconfig
@@ -12,6 +12,7 @@ config SIFIVE_FU540
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply SPL_RISCV_ACLINT
+	imply SPL_RISCV_ACLINT_IPI
 	imply CMD_CPU
 	imply SPL_CPU
 	imply SPL_OPENSBI
diff --git a/arch/riscv/cpu/fu740/Kconfig b/arch/riscv/cpu/fu740/Kconfig
index 66f9a8d5fa5..05158b8d023 100644
--- a/arch/riscv/cpu/fu740/Kconfig
+++ b/arch/riscv/cpu/fu740/Kconfig
@@ -12,6 +12,7 @@ config SIFIVE_FU740
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply SPL_RISCV_ACLINT
+	imply SPL_RISCV_ACLINT_IPI
 	imply CMD_CPU
 	imply SPL_CPU
 	imply SPL_OPENSBI
diff --git a/arch/riscv/cpu/generic/Kconfig b/arch/riscv/cpu/generic/Kconfig
index 2baba229923..0b607627739 100644
--- a/arch/riscv/cpu/generic/Kconfig
+++ b/arch/riscv/cpu/generic/Kconfig
@@ -12,6 +12,8 @@ config GENERIC_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply RISCV_ACLINT if RISCV_MMODE
 	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
+	imply RISCV_ACLINT_IPI if RISCV_MMODE
+	imply SPL_RISCV_ACLINT_IPI if SPL_RISCV_MMODE
 	imply CMD_CPU
 	imply SPL_CPU
 	imply SPL_OPENSBI
diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index fa47e55226e..20ce79e51b6 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -18,6 +18,7 @@ config STARFIVE_JH7110
 	select PINCTRL_STARFIVE_JH7110
 	imply SMP
 	imply SPL_RISCV_ACLINT
+	imply SPL_RISCV_ACLINT_IPI
 	imply SIFIVE_CACHE
 	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
 	imply SPL_LOAD_FIT
diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index b155535658d..d5e17c56bda 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -16,6 +16,8 @@ config SPACEMIT_K1
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply RISCV_ACLINT if RISCV_MMODE
 	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
+	imply RISCV_ACLINT_IPI if RISCV_MMODE
+	imply SPL_RISCV_ACLINT_IPI if SPL_RISCV_MMODE
 	imply CMD_CPU
 	imply DM_RESET
 	imply SPL_CPU
diff --git a/arch/riscv/cpu/th1520/Kconfig b/arch/riscv/cpu/th1520/Kconfig
index a02f5f24906..59720fd6c5d 100644
--- a/arch/riscv/cpu/th1520/Kconfig
+++ b/arch/riscv/cpu/th1520/Kconfig
@@ -17,6 +17,8 @@ config THEAD_TH1520
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply RISCV_ACLINT if RISCV_MMODE
 	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
+	imply RISCV_ACLINT_IPI if RISCV_MMODE
+	imply SPL_RISCV_ACLINT_IPI if SPL_RISCV_MMODE
 	imply CMD_CPU
 	imply SPL_CPU
 	imply SPL_OPENSBI
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index a527b3e9ae3..a4f2968f05f 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -15,7 +15,7 @@ obj-y	+= cache.o
 obj-$(CONFIG_SIFIVE_CACHE) += sifive_cache.o
 obj-$(CONFIG_SYS_CACHE_THEAD_CMO) += thead_cmo.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
-obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) += aclint_ipi.o
+obj-$(CONFIG_$(PHASE_)RISCV_ACLINT_IPI) += aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) += andes_plicsw.o
 else
 obj-$(CONFIG_SBI) += sbi.o
diff --git a/board/openpiton/riscv64/Kconfig b/board/openpiton/riscv64/Kconfig
index b646aa8cbb2..5be8c77b37e 100644
--- a/board/openpiton/riscv64/Kconfig
+++ b/board/openpiton/riscv64/Kconfig
@@ -30,6 +30,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CPU_RISCV
 	imply RISCV_TIMER
 	imply SPL_RISCV_ACLINT
+	imply SPL_RISCV_ACLINT_IPI
 	imply CMD_CPU
 	imply SPL_CPU
 	imply SPL_SMP
diff --git a/board/sipeed/maix/Kconfig b/board/sipeed/maix/Kconfig
index d34ea4be71f..0350eb9c01e 100644
--- a/board/sipeed/maix/Kconfig
+++ b/board/sipeed/maix/Kconfig
@@ -35,6 +35,7 @@ config BOARD_SPECIFIC_OPTIONS
 	imply DM_SERIAL
 	imply SIFIVE_SERIAL
 	imply RISCV_ACLINT
+	imply RISCV_ACLINT_IPI
 	imply POWER_DOMAIN
 	imply SIMPLE_PM_BUS
 	imply CLK_K210

-- 
2.43.0

