Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F618C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 12:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A1880F9E;
	Fri, 21 Feb 2025 13:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="X8lE09nq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6292580F96; Fri, 21 Feb 2025 13:59:29 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA5480F5C
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so4145844a91.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 04:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740142765; x=1740747565; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnAdUxGFT3p7wadzkmiIonI4uZceA5XS+2UzpsFK2yU=;
 b=X8lE09nqk76wLxaqQqkm0tyBolUz5FMcVXoxoSLleDABUsjL0iU7UcH6v60h94ikIL
 vxq1PSp3RCi2lQZgSPcPbD2zUk1zKk1VEVDFe3lvvkt3mG7mfENN/3clsyiydVWw0vu0
 28fiM5iJbDQdTl/I4DM/u5fyxHgcQ16Mg34vXXSIrSxtloO5g8OmQdF97J/EBTUzXWdQ
 mwDKI2LAvnyi/6VI59VPfhYwBPUJH3urNUznkoScm9oAJSErZmaIzIYIQi2HATTaub1h
 tSJZnMKG/aEa7ulDDLLynsfjQ8+P6PeSjL13RVTOdxXdbQGKxBdeU4jgCOHtS6DlCIfI
 jEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740142765; x=1740747565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnAdUxGFT3p7wadzkmiIonI4uZceA5XS+2UzpsFK2yU=;
 b=XKKvmTUqTAzRQsoWFg0K0dcA5EnW1xJLjUWvUOqxFMWn4AJTi+J+iZj7FJJ8FtB+Q+
 f979eEPVWKEYBTPrzLOl3QeMIXYay7Wt2If2va6ycyUDTG7+QFmXW2Bw9GlV5LUaHvPU
 WXMjTyJnth+faDflLoLDPzIEomJfwlMpaxOJMtXy+AoHkZpvWH4IITuy4DVvCninup1e
 JBq/PbQyiomb+YflqVDDYV9mMNY/pnN2HzqC9qTQQM2L7HXYGcJWETc9xLF0DEAq3PfU
 SG3974bhEye0psdp+D92IHDReEWYSdSBrJtgz26ah5/KD0LoGC9sggoi8ppZ4nrYAC7C
 xO5A==
X-Gm-Message-State: AOJu0YyVQCX30X+1cAeoQm0A65jXZoxZdQZ57wihD2h2yWNnrsh6B25d
 TGxwDM47yaj6ErqkVeHQK/b39DNkNOfIyG2VFnX15Og60BnFQw7S5EMom+j387QDT5EHnLnUhzk
 p
X-Gm-Gg: ASbGnctxqLPeuragvG3akKp5P90rWkfXf73G3ndcKFi0xtcguO0C1RQr7hZIYSrslCI
 FBPNjOBZfi15RhkeyCnJ3MrK0I+Me6GW39tb+Vq3hiElSuiVsZanAsgQ5nus1SxfDu7t/tDxGMw
 rnl+BxqZjSOJtzi1+gyKye3qRCDkltICA7lGIZ44ydpKDXgIYf+EG5u8rnRdpd23n4A1lgEowCS
 ayeoQZHh9zd+64D3lmn/dCubRMDFqClvLvUxWJhrgVkLsjOrdEsEX+Oxi8a1LuBU3vG3JkHLs2g
 t42r90nwT7Or+rG4mWhzsy8=
X-Google-Smtp-Source: AGHT+IHSu3GKQIOJpS6/IXoeaNk4v1n2bdKpEtsZ3UA3H54VuSjPorOcU/ot+tkr6AHeskyxcmZlgA==
X-Received: by 2002:a17:90b:3ccc:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2fce872448amr4597461a91.28.1740142765490; 
 Fri, 21 Feb 2025 04:59:25 -0800 (PST)
Received: from vm.. ([106.195.8.203]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2fceb09f6basm1273971a91.42.2025.02.21.04.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:59:25 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tom Rini <trini@konsulko.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 1/3] riscv: image: Add new image type for RV64
Date: Fri, 21 Feb 2025 12:58:51 +0000
Message-ID: <20250221125855.300717-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250221125855.300717-1-mchitale@ventanamicro.com>
References: <20250221125855.300717-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Similar to ARM and X86, introduce a new image type which allows u-boot
to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 boot/image.c    | 3 ++-
 include/image.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/image.c b/boot/image.c
index abac254e026..03d5e59b634 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_ARC,		"arc",		"ARC",		},
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
-	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
+	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
+	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index 8a9f779d3ff..12b31166e86 100644
--- a/include/image.h
+++ b/include/image.h
@@ -139,6 +139,7 @@ enum {
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
 	IH_ARCH_RISCV,			/* RISC-V */
+	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
 
 	IH_ARCH_COUNT,
 };
-- 
2.45.2

