Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BCCC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 21:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D5A8277D;
	Tue, 27 May 2025 23:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CLQuYEX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4173582998; Tue, 27 May 2025 23:04:55 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1AD482145
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 23:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4766cb762b6so3023061cf.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748379891; x=1748984691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ToB6Av9bK3IicMoFWzBG1e1Xh+73yzcM4hZWVcxkjUw=;
 b=CLQuYEX7M+QMkBYuYGuKBxuECHqJTO+qHFRgvPHINhKkswTh0nCvMfQXF67FLrhSH/
 niiHbr2dUwZrhvf7RbV+d2hFnT1jY+9qweo/Gxlhqpf+Vc2ptk6isr0kuHpbQS51htzx
 L3Av3iQkDbuKjC8nElewjH1fuow3cKzslKsXIznyqsRysm0lX44DOMkBhVCH0uJIwKsr
 8ZAwKE1JXgxtyVHGc9Xs0q94qDK7keW3Q80wk9HbGElPm9VNid8cPoamsYcDhlKoq9H8
 4nx6w9l4Cx9mfedykU2fQ2TgXeh/iofVUYgiPYOik93cfVgsoEt+oCr0yOCFoM4dLmPW
 0VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748379891; x=1748984691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ToB6Av9bK3IicMoFWzBG1e1Xh+73yzcM4hZWVcxkjUw=;
 b=dPKXeRlumLaCIYT2IQTlqFzFQEnQ/gYj488PJUU6JQQnDTzy4B8kkh62zZoI5JA+gc
 O7IIsbJZctG9Lnot/seAwdiA55gGBNuCMMvdRq/RRmMW7rla/bioy6YJHxKvkBmh1LoE
 +4MNy+y1yixQDydnhTIvt2Xr9Cm2sVOG/cpgmnDL3igQ4Xvqz/aT1obGJuQWJXGzVPiM
 xBXbTsHW/xEvX+BIwFzr3zs5TD1Q/9WR0MLWzIr/Wd6R4Grir4cjO9HLcUD7v/a2o7fb
 IJ32ygwxkhmZ5s1XrZ6B0byKw2qCMvVQuJJSOVPChz77DkV8zbRJHxsV/IvBeklTHQFS
 1ceg==
X-Gm-Message-State: AOJu0Yx3dgioeXeqHLL7Gp5buQyntV4iUp6sxXejWUf2kaeUtrK2DuLv
 rkux8CuneO9SDglZLgKyJ5LiW3ODuNGV7qXCAk52ipaeBlgCC3HHI20mk4gUpNEzYXiqr3/q/E6
 UFxkK
X-Gm-Gg: ASbGncva8k5A8fDfZDQX8Oo6msFJKNXv34+a6k/MNtA++9dG6hhjuvg86QrJTYwTikn
 ZVtX7Lj+fLMQ2zSrxDMcxMSqJQ+BNZ78eiQJCSUqUuYLMzUtpTk7fDQxsUVu4Zzk0xvQPPld6aA
 jHqk+ynxHaGgC7OwQdGOm78tznxkX4fomBcLFHgHA0GrRGLDFXij+G24jV9Wtzc9VM2nG516tIl
 tzpfevyJd/pQyLpBbHgB8F81CkGRXmRnPAnEb5nb4NT0FVXm97L5ZjaMT27aH/6obBNIJzntFfr
 5F5fgsFPyvRRKW6A93bKvLJc/SUURX3cHOQcOC6OwzFI4sc0GLJHtQXLsHQ77ORgH5Yi8/U+yL2
 9
X-Google-Smtp-Source: AGHT+IG+drh1ZqhijDiqNsABM8xD9cgPkQy663FQHMTgRXYtY1fR5iTxzrdALuTZyZDttCSqkSFJjA==
X-Received: by 2002:a05:622a:261a:b0:49c:d64b:3d5f with SMTP id
 d75a77b69052e-4a2f51c2d0dmr30355491cf.9.1748379891208; 
 Tue, 27 May 2025 14:04:51 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.128.158])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f92a1a07sm1097501cf.38.2025.05.27.14.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:04:50 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] armv8: fix Clang warning on writing 32-bit variable to a
 64-bit register
Date: Tue, 27 May 2025 14:04:31 -0700
Message-Id: <20250527210436.1488428-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Clang is stricter than GCC when it comes to inline assembly and expects the
register to be written with explicitly same type of variable.

Fixes: c0e1775a867c ("armv8: Add arch-specific sysinfo platform driver")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 arch/arm/cpu/armv8/sysinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
index 850142da37d..ff0abee4c6b 100644
--- a/arch/arm/cpu/armv8/sysinfo.c
+++ b/arch/arm/cpu/armv8/sysinfo.c
@@ -134,7 +134,7 @@ int sysinfo_get_cache_info(u8 level, struct cache_info *cinfo)
 
 	/* Select cache level */
 	csselr_el1 = (level << 1);
-	asm volatile("msr csselr_el1, %0" : : "r" (csselr_el1));
+	asm volatile("msr csselr_el1, %0" : : "r" ((u64)csselr_el1));
 
 	/* Read CCSIDR_EL1 */
 	asm volatile("mrs %0, ccsidr_el1" : "=r" (creg.data));
-- 
2.25.1

