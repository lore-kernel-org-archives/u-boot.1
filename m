Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF63CCF2CA
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EEF140B3A;
	Fri, 16 Oct 2026 21:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ncy7Ffa9AeWQ; Fri, 16 Oct 2026 21:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3519F40A39
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184510;
	b=Vvuzbxgs9Ayfm1aK0ywo2Nd5x55kBQDRlfZBjCpnfmKW4KOqj25srlLxBIyWkEQKnG0w
	 X2QE+pwSufeHQLThmceGaOJoIYmgBo1+vN9Ivge/jKEIH4TwtbZJ/LHQYlhPpcrv+q+t3
	 GCCRHqT7C+YXnXc6IW0981GKLIzCISoQFsVzD1WU4rqnjU0sgpgvJu/sQg1/zypDGLIdp
	 XHGK+n5jLjyEFIToEnrhf2DDH0aTnv0MA53JJasrxmjOscRtt37AX/hCXlaXAYhg5AGup
	 AdZontcGHoLTzhNZ6aqoywBQHt6TODB22YJKBYcjY1TVpGxjf3J74FcCZGLkcvpsGSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184510;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ou+dUVl3rwpEbYgGuT18TPMbfdh3cr0Eo5IeyCLwKLA=;
	b=cvobydAKAbHfo08Fl3vDzZylUKbwsboh5u6WvllFRGt2UAxBKDXRlEpDLWeo+ux3YJbA
	 ARV0pL0Blt3jsAMF2ZB90Jhf/VEuCPM4R5+mBGKJBdvbQatJ5/xKY24t62GnC/L3ww8bm
	 hgLsufqfODEGQVrJXd1h7+HvAXNo8H8Gccuevg3pIJwL9BnfoNpp4VaVps3Ttyu9BUvix
	 BhOSYh1HCXWTf6yMPfopiAFbKa2bJhhJV89ct3zqdarCnzzITHYugeJUifq8Hw9g1IUq+
	 2SxKnXupz+7whQ1pIx+Np02BRpGgXLBtOoEkYX5QjhbR09ftFYFLvs63aDxi/HKmxtw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RBZKWq8N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184510;
	bh=ou+dUVl3rwpEbYgGuT18TPMbfdh3cr0Eo5IeyCLwKLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6XdhsDo30cXQkaZJB6Nd3Bb7LneMxAyBVMtCOXJ4cBXlJALbCaMztRUUxx+71VTk
	 2NqLg/6JkCq+yG2H9bQzH/Y5iG/bhh9sOr3VOPXbjZw42DtyQNA5bNi3oafRKZiAh3
	 hntXTb57Ba8NV1g8UNE4cEqSRNSTdBkEo2vUNIdZkS9MPmFSrSFOlwwM/KLHRXAzhK
	 ybWAn0EkWnJixWTGa/180yYc3wI8y8zJviLIp8iSuoNpcl4HGFVbOqEMb6YkMgZCUr
	 Fdb51Cu151zUVrBFXwL8KCUmqR+XbY954nHo1tpsjxeuiU1ADe7vMUryf52asJFpkq
	 gI3NznIz3/ALQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3519F40A39;
	Fri, 16 Oct 2026 21:01:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D5916255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C78DF40B86
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MG1Sap7LpSCb for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 19:53:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 85CEA40C13
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792180390;
 b=m14LsiRJlDZzYXZ4CUWUrp0NpD1SHR5xs1QcfVKg7SGHM0ocPYMSKKvQZCPL+4rleL7r
 8LnPa1ILyqDSMW/ezkn4GhlGrPQ59F54nrx+kJhNTAItXVbVgIBQkbWJvkq4qaAa+OQGb
 CUEE9y7n9ohcM6a372p6CJ7ggWzFB2huaesK7V8xq8D662zkEUz+qwUgdSERjv5Qa0XZK
 7i0Enih67NlnnH1qK4A8n18uKFEKepu/6hVpix6AxBd4GLvNufmjLVxJ6RuDaq2c50lkd
 /hdOD2dxKBwIPNOA4rRRtK4+jwXJ1QxorNo05L4Kt7CyMAgwh50oO5wGybu169PqVLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792180390;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ou+dUVl3rwpEbYgGuT18TPMbfdh3cr0Eo5IeyCLwKLA=;
 b=QCFJgpPu/cQ5h/QdJKVH6pbaY1EliZ2et9CWC6n/Mk93CxqUpZjhKE16JgHxW8dXuOsV
 R+aC/PNH7h34m0VSzmSBXdn6GGERsMVEfpQ52g+a9EM6C6VEZkVEmdgeev/wm2u9Zxdhm
 TsFtAQ6dcnYfPRqA3zb3fGTv8NrjxFOSDxa6Wz+Kobcmn9hRZlRKIj6CmU8cpES3MOu+R
 2CNwSSyvXOFWziW8L1Hwu1z7UTr8HxDO2BUe301+/fSm2AZQ4AEDlNjISThCSk+vdC5F2
 tAw3xQZsBZVz7qAr5kwe1kg6jlsK6HGVV5S1U/Vvsmm7/xpKrMy7p54TQfbODUR2FsQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RBZKWq8N; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2a; helo=mail-vk1-xa2a.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RBZKWq8N
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85CEA40C13
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:10 +0000 (UTC)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5e930a11148so205497e0c.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792180389; x=1792785189;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ou+dUVl3rwpEbYgGuT18TPMbfdh3cr0Eo5IeyCLwKLA=;
 b=RBZKWq8N5cRBOoyQg3tmWxF510090/dD/1iRprgkorr1m9fTB/tVmvSv/a11jiQepm
 44sJbFX9gNthPpoeApbwfxDfcw1UJZla1tRFUFzrwFHdtPlIvhNIE+eAlgdsJYivb1bV
 +hDdscHdNb9o3J//518bnE7+y4IYgOSNXFsweq0KFE6vJ8BwwnV3c+lGtcBu4dhR/7bn
 bQcyKoO5PNDOquahCcGsiZYKw7s6sfcSzA27j+3kOtBsodG7T8S5Isjfwb6wZ1bcT49L
 FlJMntTaGli0t6eIAlziL1BkhW3uoLwtspCH5bs4mZSBhxYkqpqQey69CweubCtfUcl4
 18gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792180389; x=1792785189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ou+dUVl3rwpEbYgGuT18TPMbfdh3cr0Eo5IeyCLwKLA=;
 b=QXNOYuClmucmIgz1tERTQ673eAYiU5TesXAcstfvUR/J899xFT+LVTLUF5XGw/2KAP
 X1c8P2I7EOzG9bZjeeTs0N292jAWQwHLJBYvL5DLhbkzMIEtADz8xsdQMRiaN461oyu3
 MO2hjK7nU0HR8IU0ljkQ8w312ZT4wqRdvRD9Y0MBQF9lGSeWkuA5hKg8BK3EoktPtwmV
 1Ck0wc3W4uexHpxg/aFoc0jKf4xrZe+x/8GhPiQG3lCv3UIaWcfwGzQildEsKqmDne3B
 +Gp+wWgQtFWMZzIlKl7VORStSJnIsbZ2G7Q+KvNx/MXjRnWtuAm7/iY+siaJYgZHDpHi
 l/+w==
X-Gm-Message-State: AFq9FYIPdyeyZp0fmi3hGMtHo9toSFNWN9uvVyYGPkE/qP8NYhH5lAbM
 Q6CQ9xCzzs+mH+gfW3rUJnJ2pj76mYXJnxr4tmVcI11GHajJJTWnAtVt
X-Gm-Gg: AYBFou0rWiuKxumh75qVTsuIYMJSkZ7EnzoaF4Kt2zpeRANqjlqsI1R9VWcHifS2EHE
 8LBHdl1DX8/yHKSoXFvO+EHuxDjC7k4i1ofZU9jDJ3tRPF9tenjpbKPSkxDpgbwGsa2HOCpHmSR
 HT37gF7mpVLpp8Nv9jqNHz2LthMHAeBL/8n5s1a8/MoMRL91VUi1BLI1fc79dvBnqOOdrUhFHlG
 Ny2JZ3eWq8h6sXlcIzVNykDfMu8fi39Q38Q/PpIl+AFHKdF7KzMbXxziQBnter2YPAxHBbxzrkl
 CNJsMgZsRMvTQ4lhMZdP3S2rxDpYugAdrXHylVKudzM1L+CQWYbCnndUNnmxvp6+TIiG7FA2mXF
 HdSDGPLnFa8OGPpu9V/Lup+KrqGdflfRXbwdlcNVTPlm16GB++YcZUr42f2OTYR2ccNxo4F9uLa
 KX/uF/UeVq1Zr9Yf7N722wsF4X/bed4X/kOfICB8h0OdgxQjZ3UVQHHEyGqtFuNVy8dA53flKRQ
 zgPFiNj9zZyg3UB0xrEj2TesQ==
X-Received: by 2002:a05:6122:4217:b0:5ea:9f07:5134 with SMTP id
 71dfb90a1353d-5eaaa37e98dmr481469e0c.5.1792180388967; 
 Fri, 16 Oct 2026 12:53:08 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b2fef79sm2340305e0c.1.2026.10.16.12.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 12:53:08 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Fri, 16 Oct 2026 16:52:34 -0300
Subject: [PATCH 4/4] board: sophgo: Add support for Milk-V Duo S
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-upstream-v1-milk-duo-s-v1-4-e4bf386eea2d@gmail.com>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
In-Reply-To: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Fri, 16 Oct 2026 21:01:39 +0000
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

Add support for the Milk-V Duo S, a development board based on the
Sophgo SG2000 SoC with 512 MiB of RAM.

The SG2000 differs from the CV1800B used on the Milk-V Duo 64M and the
SG2002 used on the Milk-V Duo 256M, but these SoCs share most of their
IP blocks, including the CPU core, so the existing CV1800B support can
be reused.

Add a separate board directory, target and defconfig for the Duo S,
based on the Milk-V Duo 256M ones. Like the Duo 256M, it reuses the
common Milk-V Duo board code. The defconfig uses the upstream devicetree
via OF_UPSTREAM.

Link: https://milkv.io/docs/duo/getting-started/duos
Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
Acked-by: Andrei Lalaev <andrey.lalaev@gmail.com>
Acked-by: Hiago De Franco <hfranco@baylibre.com>
---
 arch/riscv/Kconfig                       |  4 ++
 board/sophgo/milkv_duo_s/Kconfig         | 30 +++++++++++
 board/sophgo/milkv_duo_s/MAINTAINERS     |  8 +++
 board/sophgo/milkv_duo_s/Makefile        |  6 +++
 board/sophgo/milkv_duo_s/milkv_duo_s.env |  8 +++
 configs/milkv_duo_s_defconfig            | 43 ++++++++++++++++
 doc/board/sophgo/index.rst               |  1 +
 doc/board/sophgo/milkv_duo_s.rst         | 86 ++++++++++++++++++++++++++++++++
 include/configs/milkv_duo_s.h            | 12 +++++
 9 files changed, 198 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a0..df10354e9aef 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,9 @@ config TARGET_MILKV_DUO
 config TARGET_MILKV_DUO_256M
 	bool "Support Milk-V Duo 256M Board"
 
+config TARGET_MILKV_DUO_S
+	bool "Support Milk-V Duo S Board"
+
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
@@ -125,6 +128,7 @@ source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/milkv_duo_256m/Kconfig"
+source "board/sophgo/milkv_duo_s/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
 source "board/spacemit/k1/Kconfig"
 source "board/spacemit/k3/Kconfig"
diff --git a/board/sophgo/milkv_duo_s/Kconfig b/board/sophgo/milkv_duo_s/Kconfig
new file mode 100644
index 000000000000..6ec6bd65d938
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/Kconfig
@@ -0,0 +1,30 @@
+if TARGET_MILKV_DUO_S
+
+config SYS_BOARD
+	default "milkv_duo_s"
+
+config SYS_VENDOR
+	default "sophgo"
+
+config SYS_CPU
+	default "cv1800b"
+
+config SYS_CONFIG_NAME
+	default "milkv_duo_s"
+
+# The vendor FIP tool prepends a 32-byte loader header to u-boot.bin and loads
+# the result at 0x80200000, so the U-Boot code runs 0x20 bytes above that.
+config TEXT_BASE
+	default 0x80200020
+
+config ENV_SIZE
+	default 0x20000
+
+config ENV_SECT_SIZE
+	default 0x40000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SOPHGO_CV1800B
+
+endif
diff --git a/board/sophgo/milkv_duo_s/MAINTAINERS b/board/sophgo/milkv_duo_s/MAINTAINERS
new file mode 100644
index 000000000000..86533c03fd9a
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/MAINTAINERS
@@ -0,0 +1,8 @@
+Milk-V Duo S
+M:	Andrei Lalaev <andrey.lalaev@gmail.com>
+M:	Hiago De Franco <hfranco@baylibre.com>
+S:	Maintained
+F:	board/sophgo/milkv_duo_s/
+F:	configs/milkv_duo_s_defconfig
+F:	doc/board/sophgo/milkv_duo_s.rst
+F:	include/configs/milkv_duo_s.h
diff --git a/board/sophgo/milkv_duo_s/Makefile b/board/sophgo/milkv_duo_s/Makefile
new file mode 100644
index 000000000000..a1b6aaee1489
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+
+obj-y += ../milkv_duo/board.o
+obj-$(CONFIG_NET_LEGACY) += ../common/ethernet.o
diff --git a/board/sophgo/milkv_duo_s/milkv_duo_s.env b/board/sophgo/milkv_duo_s/milkv_duo_s.env
new file mode 100644
index 000000000000..4c9f53d08118
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/milkv_duo_s.env
@@ -0,0 +1,8 @@
+fdt_addr_r=0x84000000
+fdtfile=DEFAULT_DEVICE_TREE.dtb
+kernel_addr_r=0x80200000
+kernel_comp_addr_r=0x88000000
+kernel_comp_size=0x4000000
+pxefile_addr_r=0x84300000
+ramdisk_addr_r=0x84400000
+scriptaddr=0x84200000
diff --git a/configs/milkv_duo_s_defconfig b/configs/milkv_duo_s_defconfig
new file mode 100644
index 000000000000..41a31c4ad46c
--- /dev/null
+++ b/configs/milkv_duo_s_defconfig
@@ -0,0 +1,43 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2000-milkv-duo-s"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_IDENT_STRING=" milkv_duo_s"
+CONFIG_TARGET_MILKV_DUO_S=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+CONFIG_SD_BOOT=y
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_PROMPT="milkv_duo_s# "
+# CONFIG_CMD_BOOTDEV is not set
+CONFIG_CMD_MBR=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_SOPHGO_CV1800B=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
index 19c9a19b1d4b..61aceafceea3 100644
--- a/doc/board/sophgo/index.rst
+++ b/doc/board/sophgo/index.rst
@@ -7,4 +7,5 @@ Sophgo
 
    milkv_duo
    milkv_duo_256m
+   milkv_duo_s
    licheerv_nano
diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
new file mode 100644
index 000000000000..2ae749a08215
--- /dev/null
+++ b/doc/board/sophgo/milkv_duo_s.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Duo S
+============
+
+SG2000 RISC-V SoC
+-----------------
+The SG2000 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
+
+Mainline support
+----------------
+Support for the following drivers is already enabled:
+
+1. ns16550 UART Driver.
+2. Synopsys Designware MSHC Driver.
+3. Synopsys Designware Ethernet Controller.
+
+Building
+~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+   cd <U-Boot-dir>
+   make milkv_duo_s_defconfig
+   make
+
+This will generate u-boot.bin
+
+Booting
+~~~~~~~
+Currently, we rely on vendor FSBL (First Stage Boot Loader) to initialize the
+clock and load OpenSBI and the u-boot image, then bootup from it.
+
+To run u-boot.bin on top of FSBL, follow these steps:
+
+1. Generate a compatible u-boot.bin using U-Boot with the Milk-V Duo S
+   default configuration.
+
+2. Use mainline OpenSBI with a newer version than 1.5 to generate fw_dynamic.
+   Use FW_FDT_PATH to point to sg2000-milkv-duo-s.dtb device tree file while
+   compiling fw_dynamic. Example:
+
+.. code-block:: console
+
+   cd open-sbi
+   PLATFORM=generic FW_FDT_PATH=../u-boot/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dtb make
+
+This will generate build/platform/generic/firmware/fw_dynamic.bin.
+
+3. Use the vendor-provided tool [1] to create a unified fip.bin file containing
+   FSBL, OpenSBI, and U-Boot.
+   Note that you will have to use the file cv181x.bin as the FSBL.
+
+4. Place the generated fip.bin file into the FAT partition of the SD card.
+
+5. Set the board's boot core selection switch to RISC-V.
+
+6. Insert the SD card into the board and power it on.
+
+The board will automatically execute the FSBL from the fip.bin file.
+Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
+U-Boot.
+
+[1]: https://github.com/sophgo/fiptool
+
+Sample boot log from Milk-V Duo S board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+  U-Boot 2026.10-g3c39950264fd (Oct 16 2026 - 19:45:23 +0000) milkv_duo_s
+
+  DRAM:  512 MiB
+  Core:  28 devices, 13 uclasses, devicetree: separate
+  MMC:   mmc@4310000: 0, mmc@4320000: 2, mmc@4300000: 1
+  Loading Environment from nowhere... OK
+  In:    serial@4140000
+  Out:   serial@4140000
+  Err:   serial@4140000
+  Net:
+  Warning: ethernet@4070000 (eth0) using random MAC address - de:19:4d:5d:74:41
+  eth0: ethernet@4070000
+  Hit any key to stop autoboot: 0
+  milkv_duo_s#
diff --git a/include/configs/milkv_duo_s.h b/include/configs/milkv_duo_s.h
new file mode 100644
index 000000000000..f60aa23fc181
--- /dev/null
+++ b/include/configs/milkv_duo_s.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE	0x80000000
+
+#endif /* __CONFIG_H */

-- 
2.53.0

