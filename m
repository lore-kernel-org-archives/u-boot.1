Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA2C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 03:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618CB8362C;
	Thu, 29 May 2025 05:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hGcRkUQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3EA835B9; Thu, 29 May 2025 05:31:10 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA4583612
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 05:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so469997b3a.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 20:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748489467; x=1749094267; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9lJQwCxeAWohxZr10c91rOwvMFWrZ3PBcdvZy1Ha0I=;
 b=hGcRkUQIqRVmqKGX0feLlmLbV6LCcYjat89OoDRQ4wv4S9sIrnoDZK4dS7zOY65H4B
 YwaLeoduU/iQ9EmMDiBzm2ZABDKDGm+PgijsK16BbFPS4Qhng9/Uln3Plq7ugS8xUUtv
 h2i+dON/fyKwHBjr9ZFbtBvnjbfpYgI5nP0Jo+xejrLZzADaTT0PYeJofJ32jqdaYXnq
 zNzRqKH5b5n/nGPx8r43n1wP37b0KlVlVgc1OkWssi1XFpGDGIrMzNXJLRw7MTaNZAvc
 Q5ww9TUJz/q4tglEMKPToJdNXNcrLT5BWmuKtlHDIsrOVlvF8CsLw9k5kGnj3WE3cGRZ
 USnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748489467; x=1749094267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9lJQwCxeAWohxZr10c91rOwvMFWrZ3PBcdvZy1Ha0I=;
 b=vuNWWjFDH9NMRcZK0QCUV+EI2ewiilXzsukYiY7i1y63cb3BBZJdc8+oW7SqENYSOL
 Sc2dsD4KVALDGqdP6MWQaefT87+m+FHjkJotleqMQNCEipTFeaPBZyVwxo7rH6gKml7t
 4h60h+1X5gQ+ZLeKEbfgj7VurCQQwR8loCq5lfT9sAQ0W2cHvxhdBox1hWPguMa6ktAX
 QE03xM5Sdpj43TpHM7LNTFZsnjFJG1dsXYEhIpgqgXg90gDE1EReyfgcCHtWXnI6GoGi
 Dn7IQC1EIeFH01k4v7QhuEe83S+MYVKWjPeHbjvbNYR60jfgsnJ0ZncIPwD+BY5xpG7I
 vA2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWbxdi8cxNGZnzTOZ12pB08I2hASAqD6aA1MvuWbBt9sGk3PyVIPl7JqgWzN1KeftDpU5J25g=@lists.denx.de
X-Gm-Message-State: AOJu0Yxt1UBYNbsz9BjwB5o3tJTth6oRSDAu+RrSVzWyHL4y6TnxDkGo
 0pwv+CuP7dfHqaInfdRvLX7I7QzEJZHe1ruLjHLTZDM8VosBieo3kPYsGI5Dv8Y0fEg=
X-Gm-Gg: ASbGncspLUhzQ+sjeoBbNF0X581Bi85FtQDsJgOoY4lWigSRf1bg5qBnB3wVOt4Iv0U
 4aWicd2dSnJaZOQDg1GTQmhuFYDTLgi7mmiD5DDU8+i4M72n63thEVo9IWtOLWBeiBATLJC/Zvj
 F3NxUsAR5t2KsWZ2DqVah1HiIzk1THAinF4Kodoe27L92YWix++EHHYp366Xq5fJ/FNlD7JurLm
 MrdUm93Yb20LxfBbFvQNzk6kC9SjzcChOdrlXldpJWese05XneLNi1+N1k3k/cNkqo6HjlM/VKq
 H2ol4LtFElUldmhZVh9EFL8J0RYBuOPP2B1wKKifkBaz+HNXGwRFJYTkmruSXqTEvmc15koa
X-Google-Smtp-Source: AGHT+IEds+oCLZZnp5mQT9CpDmpkTPqF0JEMYOKD5WtA7wq/oP4K/RSyMxBC4BLpfVqq0c8fmGfrFw==
X-Received: by 2002:a05:6a20:cf8c:b0:204:4573:d856 with SMTP id
 adf61e73a8af0-2188c1e7e13mr28104263637.4.1748489466883; 
 Wed, 28 May 2025 20:31:06 -0700 (PDT)
Received: from localhost.localdomain ([223.228.139.23])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b2d9872cca0sm1847252a12.15.2025.05.28.20.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 20:31:06 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: trini@konsulko.com
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	u-boot@lists.denx.de
Subject: [PATCH] Revert "riscv: image: Add new image type for RV64"
Date: Thu, 29 May 2025 03:30:51 +0000
Message-ID: <20250529033052.399573-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529033052.399573-1-mchitale@ventanamicro.com>
References: <20250529033052.399573-1-mchitale@ventanamicro.com>
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

This reverts commit 14a4792a71db3561bea065415ac1f2ac69ef32b5 as
discussed in [1].

[1] https://lists.denx.de/pipermail/u-boot/2025-May/590841.html

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 boot/image.c    | 3 +--
 include/image.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index 45299a7dc33..139c5bd035a 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -92,8 +92,7 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_ARC,		"arc",		"ARC",		},
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
-	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
-	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
+	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index 4620782c069..c1db8383459 100644
--- a/include/image.h
+++ b/include/image.h
@@ -138,8 +138,7 @@ enum {
 	IH_ARCH_ARC,			/* Synopsys DesignWare ARC */
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
-	IH_ARCH_RISCV,			/* RISC-V 32 bit*/
-	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
+	IH_ARCH_RISCV,			/* RISC-V */
 
 	IH_ARCH_COUNT,
 };
-- 
2.43.0

