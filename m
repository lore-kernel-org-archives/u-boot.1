Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87A6CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 22:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B6183447;
	Sat, 13 Sep 2025 00:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pE2imWfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A1583438; Sat, 13 Sep 2025 00:16:32 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1CC3833C0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 00:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-746d3b0f7e5so1948778a34.2
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757715389; x=1758320189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iXSRoX+FlBol3/q9X1dStdmLU+4wmo3l1iJa70Nnzbw=;
 b=pE2imWfGvCfEKdWEtuFiVBWPHxRqkEa1q6S2KrkbPjaeIWIXtDkm438goPJ6/UUt3b
 xSST3tyFqJ+vX32ydm7JF6sIQnR82XT9hnGTlKsvTwWqgExyJCEi9m28jdFOKfy8YtwY
 ibjvAagGLNbNzXfzIYzoqeXCL+TTp4EpXMB8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757715389; x=1758320189;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXSRoX+FlBol3/q9X1dStdmLU+4wmo3l1iJa70Nnzbw=;
 b=l7prSrsfEoDUAvCK/M3r8Gt6nU9d374ErOZdSg1rgWlV86VOhn/Itf8Lv5JMb2ohth
 E0tGW5ScDe5bRh7aCpwm43VQoVuuxaMp1JxqVSbwu4t08nu+V2IzARM2pSBMPicGKjrg
 sqfDOFx0tfTUFy+NKCEXxAWhDqp4TE0gbV3HBM3jcHHPQNT1uJo45mCA3B6N7t788wON
 wakOXdHAFbP9y5m995G/H/bOQgBDGzBUlTaZiBDVvP22vFDP5Ko0agEWWMM81iJTgNLH
 E1yfU09p/tywQycvm8IiFlyvreytTdKkmfKRSoz7zwkliiUTyGO8mUglIYSjIJlBtxaA
 BrMw==
X-Gm-Message-State: AOJu0Yy1gVp3UHkMo5F8Du8EBM4lRmIbCxWWNjtpiQbyKcf3UuqrwImI
 aFTvNAP6spwqqp7WyuPeyloZW5z0hZnFCziEBub803w9HoFuAP/+gvxG4j3Dm8IqyzfZK3UHXMl
 1/Bmc2Ic=
X-Gm-Gg: ASbGncsynAvN01fKtx08XKngexP70c/A8OtY6q9CjNE54S4vXy6J6WbZ8OPS0kvu+dM
 WWYC0mQrZW9bq7eXwgparoBzeT5J58V9hvfpXfhq0gyFWhb3dB4WpsOvTOQyBdyndMYTHCPpvPw
 buzDZ5C+Gcq9/pz+yrFksgbqy/yoEHzLiscUrWW9qJV/+yUFPcqUf3eRq2yZN8FyNgMs7AQnyFa
 gmo2XC2yihzS1pGZLpZ4AhlRaANcH4M9/H3E/3lrVi2r+2CsY4f0UNj5gh1+qkU+r53e+UbLjch
 muDiCyCqmcFfaTq0OBEyj+VavS1dgDZ5JIYnT7FkaNpRObaCTV348sgsVdUGlzlHFkoRxv2c7go
 hFBWjrWKsBmLdfnWo+nZ3KVbxY+t+9/LmGDGP0GSvfv1fIBP8Srrkd8M=
X-Google-Smtp-Source: AGHT+IFZcgLkU0yNBXd9eiCCUjtJ3zO2oxiAkWAO2D3Hn2gPYIYEH5jcD8fywrJqB3cTpjtPsZUq1Q==
X-Received: by 2002:a05:6830:2b0a:b0:74b:5bfc:7b6b with SMTP id
 46e09a7af769-75352e92d91mr2360807a34.13.1757715389380; 
 Fri, 12 Sep 2025 15:16:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524b8a399fsm1268326a34.24.2025.09.12.15.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 15:16:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Steffen Kothe <steffen.kothe@skothe.net>
In-Reply-To: <20250831151706.404373-1-steffen.kothe@skothe.net>
References: <20250831151706.404373-1-steffen.kothe@skothe.net>
Subject: Re: [PATCH 0/2] arm: mach-k3: am64x: Add reset cause for cpuinfo
Message-Id: <175771538822.4138777.6380861735278322239.b4-ty@konsulko.com>
Date: Fri, 12 Sep 2025 16:16:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Sun, 31 Aug 2025 15:17:04 +0000, Steffen Kothe wrote:

> AM64X hereby receives support for reset reason printing during boot.
> 
> Unfortunately does the AM64X register mapping slighlty differ from
> the AM62X. WDT and PORZ are not part of the reset source register, but
> the mapping remains the same for all other causes.
> 
> To prevent ifdef/else constructs, I decided to follow a simple
> copy/paste approach and adjusted the logic accordingly.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] arm: mach-k3: am64_hardware.h: Add CTRLMMR_MCU_RST_SRC reset cause bit mappings
      commit: 49a3ad7a5e6aa9333c2685e98f6280ff4ae3650a
[2/2] arm: mach-k3: am64x: Implement get_reset_reason()
      commit: 3d9bd76b07fa2e3de167f6d8916bcb6cce6484af
-- 
Tom


