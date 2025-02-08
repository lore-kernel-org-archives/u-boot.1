Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E863C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEBF580EB7;
	Sat,  8 Feb 2025 18:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dfn07axR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D2280EB7; Sat,  8 Feb 2025 18:13:02 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6028082A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3ce868498d3so9212025ab.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034778; x=1739639578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtSEeuMiupA/PWWHjaSAkrW4hxdrLSxNODrAc4mv4So=;
 b=Dfn07axRSNbfraDeAbelz/RJjgjn8A6SO9blTuGbY0rps2sxUnejqFxtdXjhGu3UOM
 L4wRO3JvObJVyyszjsanvmuOH1ses2Hsg76IH8kZ5vLYXgBky05LUJmhikdVmn9RY9hs
 dhxt1ASSfSuHSLSkJBYqGguBTxq9Jm0cAgkZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034778; x=1739639578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtSEeuMiupA/PWWHjaSAkrW4hxdrLSxNODrAc4mv4So=;
 b=QhO9+KWmkgUDJ8nMtKaLZR9JIFFYZUFgO9xgewZdBk03SsCzLWEJosxnzgJgxdcfnk
 XgcusZl+q+QkKY7S7F0eMe8mXUl3bPWE8FTovEWRf5v7j5Ymv6Y29ihvvGiqxZLzFms1
 GPWMZlkZJRBNYHPQWgaPNvrDR0m1BeWu/NmUgpJlpN7LShu3Fvb4DB2Xvmd4O5Tm/23h
 F5BP4xsAs73poX1k7kCDSlSdidI3sTSM85hdwmLTSrLUJNrXZlsmk4NUho7gJrrqT315
 iE71kVoxSjum2Dll8XhiC37ICKAluz8srYVOX2YfXp/Pb3XbiHYQRTjVEWnY833JTrRI
 hvAg==
X-Gm-Message-State: AOJu0YypyGeD1Z/8K3Fzf2oSQWjbMTFBXEciHfG6KRktzrrdpBPERAci
 z6QobnufprcRh7eMaGJhGn+bIVhAzpO4dJMcd0dqTAHkXGnp7HE3+RdgQ9E5mSwROCsBT2xwgYw
 =
X-Gm-Gg: ASbGncvtXMFc8hziaHjC9U9k8ZDLfWmX4WS1JHN1fk1oU/4OHHPW97s8oTeir4BQ67S
 g+rPXLUQBy7LAvBj0KXNUOV/cCVM8E4nKcH3+Qmao0ZqZ5k3agAybKByx5hyKIX14N/k2l0/FSd
 5BoLVJRYetFprtHr/qAZxtKTNr/wFyCV4UgHMoCOD4X+XgSCLFLBPwSY+qVYVSXD/xYIKP8otMu
 czt9ffU7AmZAz+h1AEgtIrqb9xuJuGfy5ET2072oznnd3Ssa8V7ZpnRZrpTaEEiCX0XST6nqG/e
 H633w6zMvYADemr63gQJRn7Gv6pBNQ2AFmxMT3M5NlGL6qw5oDJV
X-Google-Smtp-Source: AGHT+IHrZvctrzM/jInwhNH/Aq+sNdzHuCM7I4ddP9ZpG2HA14xukfye/AOs7ovwLwjRze2BBcvphA==
X-Received: by 2002:a05:6e02:1cad:b0:3d0:fe8:6076 with SMTP id
 e9e14a558f8ab-3d13df1be70mr71920305ab.21.1739034777703; 
 Sat, 08 Feb 2025 09:12:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v2 22/29] efi: arm: Drop startup code from the app
Date: Sat,  8 Feb 2025 10:11:42 -0700
Message-ID: <20250208171154.1305761-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

The EFI app uses different startup and relocation code and the existing
code uses symbols not present in the app. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 arch/arm/cpu/armv8/Makefile | 2 ++
 arch/arm/lib/Makefile       | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 7bd6cf21b19..a8f5de58cc4 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -3,7 +3,9 @@
 # (C) Copyright 2000-2003
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+ifndef CONFIG_EFI_APP
 extra-y	:= start.o
+endif
 
 obj-y	+= cpu.o
 ifndef CONFIG_$(PHASE_)TIMER
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 9500ba6fddc..a41566c816d 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -24,11 +24,13 @@ endif  # ARM64
 endif  # CONFIG_EFI_APP
 
 ifndef CONFIG_XPL_BUILD
+ifndef CONFIG_EFI_APP
 ifdef CONFIG_ARM64
 obj-y	+= relocate_64.o
 else
 obj-y	+= relocate.o
-endif
+endif  # ARM64
+endif  # EFI_APP
 
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
-- 
2.43.0

