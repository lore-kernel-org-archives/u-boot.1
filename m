Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D7EC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39198849FB;
	Tue, 30 Jun 2026 03:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="zswj0a33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C47DA84AD3; Tue, 30 Jun 2026 03:19:49 +0200 (CEST)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A008849FB
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-13b2b08a553so623565c88.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782386; x=1783387186;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rS5GzTwNS5rLggojVaZl/YVMG6g1yo5QGj5vecNIl2Y=;
 b=zswj0a33Gd6r7ZxQdHlRFQFNNawW8yVqSYGZQzXRrvedfvBV44N0I5qqUJhVIBFoSx
 5MPp7rKcySDh9D03pe2m6OxUVHr44CLUc/Sc/E4mDppBXKgpXSb51RoLbdFGq1RhgSko
 KK/dkphemwiAWqx1YjhncOOUeI5jdZKtGrlg1gW0fzFBSbzM3xC7a08xCXg6ssYBr5xs
 qMBTT7MAovXmI7CIXl/Y7orcGy6yO+a5AZ8yohsC1EFiWJSIwJxCc0KtKwtCVPmz05h/
 zDgs2zTkYpI/mxR5I2tb/n5+bGcsMa2Ee3VPgSIULbCOeLKniOl7nlETgaHjWmivJL+m
 /kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782386; x=1783387186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rS5GzTwNS5rLggojVaZl/YVMG6g1yo5QGj5vecNIl2Y=;
 b=RguvFKywTdRkc1AOJgTkyVD0Kkx973kdNTHBS1obDRZ4PJT8yKMdzOYPRKwf841saQ
 Rs9aNjtyNEnoUu44QO/Iq1hYZ1qKVeQgnt5D+0XfkngpEunQytxCyw4crP93moKz5Uck
 7Tml4914bs34tbvvSayGZ9UgFvTY3Lc1JGcvliZ2c9gmY7cZtDgWcflAGqL3jA3D6Ffe
 BpLQggIRAF5eFly4IpZdA7rZCZq4E+MdOVjuYa2rLiIFqsETDrNLPKlZqzhfXlFnAmuC
 Jlo7e+LJR4/VJs8L2BsU9WpI5BlqmLA9la3jCeV4sePAt3sd1r4mF0tks96Ta0Z4x6vb
 DOog==
X-Gm-Message-State: AOJu0YwyNPD0iEg5bXrRQBFx+yehOxKdK76LlkC1/4gBOzG1rPjCHGlE
 Bt0ijBoBl6LMmpANdrVy0oF9HBwtbOiw4ObhjrHCh2aRTg/5EEmZm7XYG435sQp/JtA=
X-Gm-Gg: AfdE7ck6PjBLIjVTQawVczJp5p+x90iWqQkR/ZUdJCxxMee4yzquGMeAWVsgQNCe/1K
 5O7gEf2O21oEw7nH69SbcOJj1fjiYf4lzEt91sLxPGhjANp9wXm3zGdiHMCNJzkpLkoXGDhX6pQ
 xzCvp2ANuNf3Us7NhoOBPluM/D+zVJTeDVbs+E9DqDIHHQTD2SMsUVH32+yrf0KGcfzxCnOzwoa
 mc/4uuLh4xxP3uXnyhl3FCA3OKR0/0Hsgd52/rKoD6TmyoSmO5NtDazV8arPXcOHBobkmd4ASPt
 SE0Lci/vGQ6lVEURanaG8pBUMomO6LSwS1biUcuQuIJGLMddfkaBn8rr42bXn5CWsaAQjLgZtw1
 wVJZmEJnO8b8meEO6SpVNMvXv7gAh2GBXCCTzwNuJWAyrRa3nUWV5TW+jkTP8AKnKylJnBrBYKT
 m54/lZ8PwEFBPM8xkY6EOSAMc6J7FhT+S1wFaU2NvsWaSZGJX4Ha4cwyAn/c2fIZazDKLs3Q4c+
 ZXQEdWc+Q8x5Sp30jPKt2eSHfGpX3jJwyiJhid8eZfmTAPI5TRCiQ==
X-Received: by 2002:a05:7022:4381:b0:12d:c730:c7f with SMTP id
 a92af1059eb24-13b2a1c0d88mr973833c88.33.1782782386045; 
 Mon, 29 Jun 2026 18:19:46 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:45 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:06 +0800
Subject: [PATCH v5 05/14] configs: k1: add default option for clock driver
 in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-5-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add default option for enabling clock driver in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 configs/spacemit_k1_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index fd0d228992a..23019266103 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -1,9 +1,11 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x5000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_STACK=0xc083fb00
 CONFIG_SPL_TEXT_BASE=0xc0801000
 CONFIG_SPL_BSS_START_ADDR=0xc083fc00
@@ -29,11 +31,14 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_SPL_MAX_SIZE=0x33000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_DM_RESET=y
 CONFIG_HUSH_PARSER=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
@@ -44,3 +49,4 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_TIMER_EARLY=y
+CONFIG_SPL_LIB_RATIONAL=y

-- 
2.51.0

