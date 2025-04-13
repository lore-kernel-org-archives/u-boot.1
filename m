Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBDCC3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 14:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A6B829A1;
	Sun, 13 Apr 2025 16:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d7ERyfYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D8B829A1; Sun, 13 Apr 2025 16:09:29 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4B682849
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 16:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c2bb447e5eso1930312fac.0
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744553366; x=1745158166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGob3pMOJ+Ku14yQylttDviYYY0sEeWTDvx5eE7wECU=;
 b=d7ERyfYOlhuKuRFpJI+/0mtC6bF71CsY47pYFUk8YPdE5FQ6ya7Ny/pxb+Zjmgz4Qd
 YNYhUCBU/crmgMweTZkSLWBuaG37bLh491IS10MKcAE8M0me5Xw5XarYJDFgwOO5bVe0
 PqFLeY6W5JJoiJVYe6pLCd7uACYQOFo6pm3EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744553366; x=1745158166;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGob3pMOJ+Ku14yQylttDviYYY0sEeWTDvx5eE7wECU=;
 b=RVHL8BpRscBU+pvPVCxca6KfdmcHtJ7cCiJZuc66UdN1jj8kNRsS9B7YqGBVZQWTbj
 UFoXXhu9IGv33sB3p+SPU9vOJ1FYa09whxqYoItQ6+knDEY6Tyd8bzYexhQ6mcuyb13b
 QMOrswzkrMnyoW1Mb9ZGPLbDuJcJOeSh5cGTGnHkYBzo4lrX/MQdtjiUWmAorirXW2nX
 Qg/SuNb7ucmvXVmIsY1Aj0CRUaen3AyXkJf2zFBuuhwUAIoqxSnUjw5lj4ZHNOibWx2c
 MonL6ZJiYEArSxQ7BMLnR1Vs2KF8RCF3p76K7ZZ348grVwFUrBr8JUizoF0aw7O0ON8e
 Jd6g==
X-Gm-Message-State: AOJu0YxsOSo8uzc5UDkFgiFnQoMhE0MXri5CToklwurmV1S4BtA9iiij
 ZR9K23TWxGocqWiCbDy0gFK3sKqGs+3iSuLrJuN0/HfJniDHEmqqL2NOzoaR5sWzxTIovhheVaU
 9
X-Gm-Gg: ASbGnctUQU30yCrwL2CYML1jP+wSmMvlT2WxBmXj9mMPKJ0AZCdgUCTmbYZ0W/IYJ6C
 OSbff6AsIcWmXvw8naeSNmpMnnq6q1jaGpT59uClZyBUCWGxOOT7J984kzQYWvvZYnRlLZ6PVvQ
 dxk3B8ElQPQYQ+wST7aIfuMx61s4fabOdoeMivmGwgEg0T0f4V5lq74YXZhASEw8hVQu4Fvx9gZ
 Z0/yfIdQBhfW0zgI16um9OCD+8hDavB+m7LwIM+xzT1K3tyjxZcluo6KJfrcZrkb8WFTAAATTAS
 /QQVl8Vp6hVr/VkFvGsqhlvGlpUXDM7+wSt54ZR9sdHMUk9Dli4X/oojuzNz9t686i7G+MaMerz
 e
X-Google-Smtp-Source: AGHT+IECK9cbPXL091Cbz7PWJ2Lbq0jXHhxTlPNW0oyZeAvEkYeB2fxndYtaHf4DJZTzeRSe5mfrzQ==
X-Received: by 2002:a05:6870:ad8d:b0:29e:65b3:27f5 with SMTP id
 586e51a60fabf-2d0d5d6f2e7mr4628739fac.19.1744553365804; 
 Sun, 13 Apr 2025 07:09:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096406702sm1989557fac.0.2025.04.13.07.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 07:09:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250412101129.70838-1-clamor95@gmail.com>
References: <20250412101129.70838-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <174455336466.362516.12992220983525385886.b4-ty@konsulko.com>
Date: Sun, 13 Apr 2025 08:09:24 -0600
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

On Sat, 12 Apr 2025 13:11:28 +0300, Svyatoslav Ryhel wrote:

> The following changes since commit 407d68638fe32418d61681407effba2a303bb9ee:
> 
>   Merge patch series "Switch to using $(PHASE_) in Makefiles" (2025-04-11 12:16:49 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


