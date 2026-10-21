Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8F606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xv03wzaT;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=J0dnolSd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 152366083B;
	Wed, 21 Oct 2026 12:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0k8xYXz3rSBM; Wed, 21 Oct 2026 12:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF703608A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587306;
	b=mVZPlGrl+UkJwdeaCOplEnvBzmH9fG5PYZKgDOh2eVOouDRGOzyC8DdyVytpsKUqhlvJ
	 kEfTicCYGQFxBWkjY1Tm9L4iYfluGWc7U04pKDcnEdpczfyMRkwzY7zf4I2WFwu9uL0yM
	 SL9ukIh/FCvXNhsQkuRFx7dGxTqmdzIdz190yM6iSg+tr6veeeddAj+HpjA0n6RBwSexV
	 GZOu97U89oh3J77DTbt+by2/m0YflBeuKpUT8VygikioJ4tv6eUvQONCA0uId6xFowliA
	 eiRnibY5SuggvM9b3GgFD0hOrsFgwbJbSNSXvaBbTJXyaLYdsD1dyuqnfdWpnPFK8Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587306;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UzHCT04BRdq1NkoXo1FPgd2DNVDdzWiRhKSN+lF9zBU=;
	b=HWhx3bnZnm4wuQ93jda3yx6IYc5ebIydx0Kw4QYG/T/pVnYHBLXCq80ggbLpw+c4/bMW
	 C9NoXyiCtBcpmAd5e7JuCsZSkCJPJQHlzv0MbfH/JddUxszKf8aXU85K5P6c4E2aof19/
	 MUeh4fGES0KpE4KrTKOG36IKGHzGMgjj6wqFqmXOTFDxUl7MDJZQVjkbHcsck43QVOkr7
	 1mffCBY/68DtapfP7S1fxSdPC2fVK/w+RDNEeFor4N1G6eSfzI8RbzM8hFV0U9V6rb+Zx
	 xLec1iPMIhdqykTnXcDQelK4agNtz/Q0AxHSEX0xq8iXKtsYvYIVfQ3IYJeH08IpVbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587306;
	bh=UzHCT04BRdq1NkoXo1FPgd2DNVDdzWiRhKSN+lF9zBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xv03wzaTCi+2n7lHMsMf1ISwUC6GBVRoZNT6WqxuprriPmhSMPehbsKnX9wL3bahO
	 AjQfVEY8BGEK9kwHqA5Er/FRZ7PulUmMdW9SqPxm4dUpeZlfr48uDQvM1G5bv+Fx/D
	 NMqJUVddhRihf2BH7MRyWVHDhqNjzx9yv+y51saNJDjHpyTOe8gO7C2vnawIVRHXEx
	 r7gWYQoYxZ6rQT3/c/ceiSYGiinmBLG9WOvo8vIyq59oXJdDNm+pSNXF7k2ONoJ4oY
	 C7bBy754b9tLioCqbF0Kt1SDKs8SYD419n28TPcZnKJ8eTUoyl0g0OZpy048l3i+/f
	 VZwuMpEeghbXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF703608A9;
	Wed, 21 Oct 2026 12:55:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 545721AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A9D5403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VAFR3AL5QZwU for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:55:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0127C403A6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::936"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587303;
 b=kOGqF7LOHwqogmq+YMBWP3ZMt1VBcuBcz3dhgxOGOrybFuw5Tc9IHuXZp8tw9g+wvlyf
 UvyQ8wLvKnbYqFIiXsnJKlAEbDCL0CA33r/C4gka1TvyoKQwwrSvBy6ZorESEOZxJ/dHP
 mkC1UNHAw2SAxWCVaoPgj5DxlBALrXwVlAa6VVZtpIzsgN2JpJnG3i1dRKnW9buq+bMxL
 urPfjZYanGF5h+vBy9TqTkY/Vzpe1ptHHP9aP3eG8iop8nu9J78m32WLE08gfPREYuYN/
 LN6ebCAKp0dcPb6eH4Y8deogj4Ga80aDoJVRXEeUs9BLe40NSt1DXW+UbK2UpAV5Xcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587303;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=UzHCT04BRdq1NkoXo1FPgd2DNVDdzWiRhKSN+lF9zBU=;
 b=oqd+2wbZQxWGqA7kwqwHFG3GpdNbhIm8hsC4DCm6e7Yf+Ap8n9x4QEJIfJQF1sVLrKj7
 clf+Z4Z0+EAw/EbmnVd1dkbZLu0Vlg/IAgXOsxCdCW8ULZxcyvkN9Kp60SErjLO6kjh83
 TKu3qzT3caZeR3tYeXTqb5QnMTTx5IaSm67u4nc6i5+3mQT8Dy/CC7nVmdJXPBarfnB0W
 6yIrozWjBVF0mbtaZGsTs0f8jcNKz8anuiPWNARN5WdMekbSdULjc60l6fPX6I0YPX0tj
 H+FS9n1G4rjEDXWzIcNrBOLSCiq3m/tEZpglvs28eDQw7TV82ooEghGPJcmyTeJapTA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=J0dnolSd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::936"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=J0dnolSd
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0127C403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:01 +0000 (UTC)
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-9851592ada1so269655241.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792587300; x=1793192100;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UzHCT04BRdq1NkoXo1FPgd2DNVDdzWiRhKSN+lF9zBU=;
 b=J0dnolSdWD+NcGTm0yzWz9mR1nS8EIHzqX5snigXN33eYdw8zJ5bBl4Ao8trCVpDlE
 dSTS8zsHUTUoInrBAh8rfMtk28Kj40DIQJ+delgdikmV2hH1+EQVgHNyXVMdG54iSpAG
 WdicrwRD8AgcA284juKfc+DlpyAJgw7D87JH5Xhkgg1upi1TWDkNAw2XSprDrlEnO88R
 +z79D3zr6h4MYmpHS7L7Ok5n6ygNjGKmwlNhyMKY4K8XMAddgxhmxrbimlBW4SiCZExz
 NbPoTtKbDOEKZSHPsqb2oVSl6g0SiYj8AeSPlqgOd5irkX55QhJYavZz7NUoOd0c7c5V
 fO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587300; x=1793192100;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UzHCT04BRdq1NkoXo1FPgd2DNVDdzWiRhKSN+lF9zBU=;
 b=I7y3yG9VUSX6NovF3l7ZcRVpCXoLuNs3tNt/hSTUT0GIfRxhDheOzTFpgDfDoZFgkG
 T5i/2jUk4q3TaGrtKO705KJRlD67eR/lyxddeoJg+laiGHsIX/6xuEiXB5qYYRSXslxb
 yub7TVtmyILjb48pnv3wlXRwzKnNfszUP6GVWOBegQfB4Rvjxuviio6n6hL22Ry/+6Aw
 cK2URoX/SQG0rGmz/0BaHtxMOiZxxhTztu3YcyHcPT50EX0dYKpqeFt7a8Rd3PSyb7e3
 ZL8sBnUZqtVgdhc8bwzJKjIS3HpbG1QWN0W41FzAaUUo5fE96aW5lbpJZOcvz+U+yHVq
 bwqA==
X-Gm-Message-State: AFq9FYLDKzfoi4Z7q4mo6TIvtXR7luWI6oWUqkAIux6BPNRFIxlPAXVX
 3J8jAsT8fkTJZQQU63MN/4sHJCqVW2ZtO6mee7VELPuFSEDimb2wmvGn8GtuBm+CaiY=
X-Gm-Gg: AYBFou3+XBSTgno2Xi8D1x9YkwRbGhCWRoBOaOiAcAQAiAFGzqM3fnzZ/BhyNACbKmA
 IRha7Mgr30gcBMBN8ln/erunSqyw5nlMjCDhkycixhAF4MQIadQL5oTImRYK8ZQmy2n/S7PVQv2
 nGDfUYQX5zUDS2KSPYP6u7woDVnewRGbW/aQ3AvqWMJka8BVW0+mItibiMwORAwGhnHS+6OuVTx
 mcjsiOwzWOSCEyv0F0Tx36NZ18OWyxqlTV02MvA8NlKr8zfzgbeIKySproZieB87dlXDDYRq3LJ
 HKEQQpl+7mUBSi8fQ5UeD32HKktSkQ3pgbXZP2vC3ELxRPbVSQBDi5/wDBfWZThUImmfl6jOtep
 OwsF8ZFTCBgl52O0ePo7SpAEmpGTFrjXTio/G/sLt/cwKOzPSxwo5wqiYb5917x+uZmOhd9AuhH
 bFTTuEvNWUBUOlfl6aCtjGQlbgDV1R9/PIHymLU/wYU9+DwkExSTKFXDD6t5chLqarUa1/wEbiJ
 +1/m6cPLFZnLbiMdeBXf/I/DQH2L0EUqK3M6yZ1cOOTxM2szDQAG9RlEMjJK4xyJAqb7u19gp9w
 llfLhug+7I6hY2jm9Yk=
X-Received: by 2002:a05:6102:3709:b0:7b5:4700:3a6a with SMTP id
 ada2fe7eead31-7cc926d0a55mr619813137.26.1792587300452; 
 Wed, 21 Oct 2026 05:55:00 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d0e0ba56sm3013863241.1.2026.10.21.05.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:55:00 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 21 Oct 2026 09:54:18 -0300
Subject: [PATCH 2/8] riscv: cv1800b: add SPL support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-milkv-duo-spl-v1-2-ee7618860237@baylibre.com>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
In-Reply-To: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add SUPPORT_SPL and SPL_CPU.

harts_early_init() enables the C906 caches and T-HEAD ISA extensions.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 arch/riscv/cpu/cv1800b/Kconfig  |  2 ++
 arch/riscv/cpu/cv1800b/Makefile |  4 ++++
 arch/riscv/cpu/cv1800b/spl.c    | 31 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/riscv/cpu/cv1800b/Kconfig b/arch/riscv/cpu/cv1800b/Kconfig
index 57f724ae043..29a65b93942 100644
--- a/arch/riscv/cpu/cv1800b/Kconfig
+++ b/arch/riscv/cpu/cv1800b/Kconfig
@@ -7,7 +7,9 @@ config SOPHGO_CV1800B
 	select ARCH_EARLY_INIT_R
 	select SYS_CACHE_SHIFT_6
 	select SYS_CACHE_THEAD_CMO
+	select SUPPORT_SPL
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER
+	imply SPL_CPU
 	imply CMD_CPU
diff --git a/arch/riscv/cpu/cv1800b/Makefile b/arch/riscv/cpu/cv1800b/Makefile
index da12e0f64e1..d16211f3a60 100644
--- a/arch/riscv/cpu/cv1800b/Makefile
+++ b/arch/riscv/cpu/cv1800b/Makefile
@@ -2,5 +2,9 @@
 #
 # Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
 
+ifdef CONFIG_XPL_BUILD
+obj-y += spl.o
+else
 obj-y += dram.o
 obj-y += cpu.o
+endif
diff --git a/arch/riscv/cpu/cv1800b/spl.c b/arch/riscv/cpu/cv1800b/spl.c
new file mode 100644
index 00000000000..6fd62d66da7
--- /dev/null
+++ b/arch/riscv/cpu/cv1800b/spl.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+ *
+ * CSR setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
+ * lib/cpu/riscv/bl2_entrypoint.S.
+ */
+
+#include <asm/csr.h>
+#include <linux/bitops.h>
+
+#define CSR_MCOR			0x7c2
+#define  CSR_MCOR_CACHE_INV		BIT(4)
+#define  CSR_MCOR_CACHE_SEL_BOTH	(BIT(1) | BIT(0))
+#define CSR_MHCR			0x7c1
+#define  CSR_MHCR_DE			BIT(1)
+#define  CSR_MHCR_IE			BIT(0)
+#define CSR_MXSTATUS			0x7c0
+#define  CSR_MXSTATUS_CLINTEE		BIT(17)
+#define  CSR_MXSTATUS_MAEE		BIT(21)
+#define  CSR_MXSTATUS_MM		BIT(15)
+#define  CSR_MXSTATUS_THEADISAEE	BIT(22)
+#define  CSR_MXSTATUS_UCME		BIT(16)
+
+void harts_early_init(void)
+{
+	csr_write(CSR_MXSTATUS, CSR_MXSTATUS_THEADISAEE | CSR_MXSTATUS_MAEE |
+		  CSR_MXSTATUS_CLINTEE | CSR_MXSTATUS_UCME | CSR_MXSTATUS_MM);
+	csr_write(CSR_MCOR, CSR_MCOR_CACHE_INV | CSR_MCOR_CACHE_SEL_BOTH);
+	csr_set(CSR_MHCR, CSR_MHCR_IE | CSR_MHCR_DE);
+}

-- 
2.53.0

