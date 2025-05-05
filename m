Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6401C3ABC3
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 04:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2C780BAE;
	Mon,  5 May 2025 06:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jeyK5NEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C97C80F03; Mon,  5 May 2025 06:15:23 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26452805D7
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 06:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so3088503a91.3
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 21:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746418519; x=1747023319; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vLkTQ04GVMllEfVF0f5ym3HfEKjRllnv+JByhJKNeSI=;
 b=jeyK5NEokVU63WCUXcKmh4TPyKMqjxFlxQ8EqkqGXKJwHNWZ7fhT1vAL0gDZmuoeD3
 jFIRYRO1SU9s5S8h4WfvmysE0A2pifEu9hOqR4Lz+KK69kk9cGAsRXzSEPUYcWSIJdwC
 0ewOmcn77MgLFlbKUYefbHFhC6/lBIhkD3EKJ8XFJWU2EHu6uW/c/08wnBvC91jpWqht
 m0vYiipsukMfRVTCfM/yqkmb7cwOsZYaYW1HaSL06FkM4CJPPF6oRk2NOFrkD9x+mRRj
 WjLzAkFNuauCVrv/V/mLkcESR0vZnL16lFULRVrbcIttue2wYFMsnJMGXjW39Y78etDa
 Df0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746418519; x=1747023319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLkTQ04GVMllEfVF0f5ym3HfEKjRllnv+JByhJKNeSI=;
 b=qA3orPcR8VsY+V4wy2E7HWNEli8EZe3q8nGHvQdhyv980lI/88H/bM9aQZeJNV24ao
 QM5KGYhu0/LmGoiVjuQBeSQHpbXUrB4xG8qzk7iLvfY4F63bYUGoqx7ZNdWXx2BLDRBj
 TX32eZ05YxlPIBNYPNL2y/HRHcNDnb2LTD4HC7CLIjFfQ5LU6WkIWV+zukGOrQtWB/h0
 LgyBchG2Uj+/muCajabIMbjLNfwpfdjLTbqjYpAH/TpNXKKHG2Vp1Hsg+K679pwwx5Nq
 UK7d75cLOh4CYFFtj0KCWwEPjy0Y3j9+YMa6+q7+bFYBT1knSsyLvHJTHO/O2OEcJSj+
 FREw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfWkFr0hReHzcGqDwtlYCElRyxn/laUX72cdaLhNEJSGmu60oE/hktUygFP1zTv6Oa4hVHRcc=@lists.denx.de
X-Gm-Message-State: AOJu0YwwjVed1xh3LJ0PbjBWK3OTPZOfTENoJmgOoXx590IgO46RF7+e
 HI0FezN8yqsJt9QOIGf67zaOYKH3IwxV/L/Hw651wijcDVNcXcpp
X-Gm-Gg: ASbGncu69NZOE9HAjoaFPMmHYiyjlLKPKSopsa3JdktHRkCaoWTH2K0q51qlNMgD/wK
 bqSz0fo4L4lFyasF6mKjjsI04S1T7DIOHB/6AJ1FQXPqUWIQbYblEX1LcEy8GbFysPK6Z/RIB8r
 nTi09z/732/ab5JgwTXpzDFyun1cvkwF1faRQdexw2+KeTzKIxyt999/JBSKispH93+iheTMG0m
 llsHGsoG51xS7mFxs4Q8k6Qe+08SN0vxUaSTK1T9otnelX7OGuEwhqhikb/vd+eXI772RRBP4XJ
 Zy9sgK+zQwQGXfeCDrjG1kdMs7M5dZA7Q/bvkHStg8hb5qEMxqak
X-Google-Smtp-Source: AGHT+IESGg6PgzW4rpb9cOoiGFvNp38eYT6ORNI8AFc6CE2Z6xBwt/EebO6Gtv9wpgsK+Oou8bxNrg==
X-Received: by 2002:a17:90a:e706:b0:306:b78a:e22d with SMTP id
 98e67ed59e1d1-30a619a1979mr8695016a91.20.1746418519420; 
 Sun, 04 May 2025 21:15:19 -0700 (PDT)
Received: from octofox.metropolis ([2601:646:a200:bbd0:92b8:6516:7b20:95ab])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a348266ccsm10438503a91.42.2025.05.04.21.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 21:15:19 -0700 (PDT)
Date: Sun, 4 May 2025 21:14:57 -0700
From: Max Filippov <jcmvbkbc@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Subject: Re: Convert xtfpga U-Boot platform to DM_SERIAL
Message-ID: <aBg7QQlJiV8FftqG@octofox.metropolis>
References: <20250501230349.GM1261075@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501230349.GM1261075@bill-the-cat>
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

Hi Tom,

On Thu, May 01, 2025 at 05:03:49PM -0600, Tom Rini wrote:
> Does anyone have time and knowledge to convert the xtfpga platform to
> using DM_SERIAL in U-Boot? It wasn't just a trivial enable
> CONFIG_DM_SERIAL and have success so I didn't look harder than that yet.

I was able to build working u-Boot for the kc705 xtfpga variant with the
change below. I can submit a proper patch If it looks correct:
--8<--
From f0b6e632da8b72f0437a39dc1769b740fef04cf6 Mon Sep 17 00:00:00 2001
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 4 May 2025 18:40:44 -0700
Subject: [PATCH] WIP: xtensa: enable DM_SERIAL

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/Kconfig             | 1 +
 configs/xtfpga_defconfig | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9bb3fe22402f..8d469a395f8c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -361,6 +361,7 @@ config X86
 config XTENSA
 	bool "Xtensa architecture"
 	select CREATE_ARCH_SYMLINK
+	select DM_SERIAL
 	select HAVE_PRIVATE_LIBGCC
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
diff --git a/configs/xtfpga_defconfig b/configs/xtfpga_defconfig
index b96dc10d85be..68656949660a 100644
--- a/configs/xtfpga_defconfig
+++ b/configs/xtfpga_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="kc705"
 CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SYS_LOAD_ADDR=0x02000000
 CONFIG_ENV_ADDR=0xF7FE0000
@@ -28,6 +29,8 @@ CONFIG_CMD_SAVES=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_DIAG=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_EMBED=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
@@ -46,7 +49,5 @@ CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_MAX_FLASH_SECT=1027
 CONFIG_PHYLIB=y
 CONFIG_ETHOC=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_SYS_NS16550=y
 CONFIG_SYSRESET=y
-CONFIG_OF_LIBFDT=y
-- 
Thanks.
-- Max
