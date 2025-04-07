Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A3DC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF8782E76;
	Mon,  7 Apr 2025 19:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ewPsstGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFEA782E86; Mon,  7 Apr 2025 18:59:58 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEBAF82E86
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 18:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so6564856a12.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045196; x=1744649996; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5eIlQ/sH388tPT6DFZVOA9zlKo9apJtu116V34ty3Ko=;
 b=ewPsstGCeFtiaWGnI8BucLADtf2ifT/oxVHICT9BxCKZ4ncnSbH2TiTXjHd2hIKWrN
 Zc1yICGrmbmpMRfP50X/IyWUHQ5T/Z852MZh7EtrIEPW0FU+YAc/rZHomA5XE015+1be
 4BXcTzQWhHbUdbWn55KIFnAFwh6qIFRMWYH39UygFYxEYkin/xXbk2shAFlMOSdkngbo
 RozEYF1DquMwaWX8q3rnGrOK97QzCJbLX6bYgKGxU5N2aiMn6ye2SVtAd+fjii1sEsMF
 T1PqiKmrTF8UyLkKaA3yZw7JWCjhTg8uyWqL0Zl4JVYhZLJc1SpXSZ4ZI6XjJBmid7D5
 FPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045196; x=1744649996;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eIlQ/sH388tPT6DFZVOA9zlKo9apJtu116V34ty3Ko=;
 b=F92MUT7GJpMghGqZq/XW9NtDlIjtamag9QEkXjNppkycbKncYwNaEuKL+ctoqcvfMz
 DfKmgJw+t/fLzwoVrMELlafDrnYGRZ78/MT6S91yy7oQSRcNJNM/JHY0Ec5yCpki8cwd
 Mu6RY4vTtXwU2so0Isw1LZyI2hY2QVMaOsNqpI5AAhPJ40xOg3qCilDxAneH1jELqyr4
 QkJ2A+lVqpMWezixA0qRtagpz2S6GH9c37cT71dxJ3uRLKPfuXSf/BVw0pZ3aLB6YgcI
 3w2D2v/iVbISyPN5KfqmhLIrVHkuxXfDokxd20xkH0NmQLpMsYAfe5lwco7OXuJrHr9X
 Sbyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDQkXj9a8Vw1TN+dyicj5fI3luU+OnpCnAioeHxlBUMdt+jxmnqqKqu8HDnTSjjepC1BIcDEg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8+q5/H6/Nz2e+JjQHYoKWfPtpunvs6sM7OH7ujhnCvdgvTwoJ
 E0pdEUIZJ+IBdOhatyDU+m/Dws+XEhP8jjFDHjYOmeTzqk6je3EmzNXedpDgSB0=
X-Gm-Gg: ASbGncuS0tHumyPbpKE/pblsY0It3un2EwF3wd6aoHSUMRH3G576noRe0H9z39TNmrE
 30IEDhWghwlzLZhXeM3IldwaMGmuNxw4oQ5hZCrc/tv56VZ516El1oWD+JgvjMKicCEj5ZDsDk+
 +k7E5IkGns4ZEW3s+KWLKQZO7dm2JrdocJm3J/HBZXafqsZvl/9oou50Ik7upNeylNibbbbJbdo
 2N5JtJFRh9fnGFHcdeZOwGJfJTuXjmZwUXwA7Tefb9KT/hP8L+jIXJtDjCgl6eb/RM/TnK09F9E
 t5M1nXZJuHJV+cZ/sXyL04Vm9ntZHQ1d/zywlJHKyyNJsV/vHkOhAZwF1W0h0nGMEx+r
X-Google-Smtp-Source: AGHT+IGGSNiUylpXLEOGVTnUxcd4LveelvkuHuaAGiahehaYO9Z80dBhUTEpGuaB2Plfh+xi1+MVsQ==
X-Received: by 2002:a17:907:d29:b0:ac3:ec77:27fb with SMTP id
 a640c23a62f3a-ac7d6d5f9demr1218703766b.26.1744045196259; 
 Mon, 07 Apr 2025 09:59:56 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.09.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 09:59:55 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:22 +0200
Subject: [PATCH 01/13] mach-snapdragon: Fix EL2 boot on DragonBoard 410c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-1-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

The workaround for the "PSCI bug" on DragonBoard 410c implemented in
arch/arm/mach-snapdragon/include/mach/boot0.h clobbers the x0 register
by storing the CurrentEL in there. When running in EL1, the mode switch
sequence implemented there later clears the register again, but this is
skipped when U-Boot is booted in EL2.

This causes crashes in the mach-snapdragon board_fdt_blob_setup() later,
because the invalid address stored in x0 gets dereferenced to check if it
points to a valid DTB.

We can't rely on having a valid values in the CPU registers for the first
stage bootloader configuration on DB410c, and nothing would place a DTB
there anyway. Skip selecting the SAVE_PREV_BL_FDT_ADDR option for the boot0
hook case to avoid crashing with the clobbered register value.

Fixes: 059d526af312 ("mach-snapdragon: generalise board support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 63aefeda9575fec8fc57194358df0819397d088e..af3d39196ee4fb201d4aad20a882bbbb39263396 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1115,7 +1115,7 @@ config ARCH_SNAPDRAGON
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
-	select SAVE_PREV_BL_FDT_ADDR
+	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
 	select SYSRESET_PSCI

-- 
2.47.2

