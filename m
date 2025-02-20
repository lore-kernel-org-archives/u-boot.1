Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB044C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 17:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B8780F9C;
	Thu, 20 Feb 2025 18:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZpwYKlJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94EB780F53; Thu, 20 Feb 2025 18:19:29 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07BB780F56
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220f4dd756eso24419875ad.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740071965; x=1740676765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfT8/u+PQsYdgtpnaWC9G3ctBs3ah6L2ii9WFBvrxus=;
 b=ZpwYKlJI50MZHrepwVszUtSovejh3KUiGue6ouvrCotVy+61yb6gTI/HtkClTET1cw
 E5bTPg3GDPVKw+BBdZ6QuRksLKy4JhYHAsksIrC0fsKQ11A3BhHfApzgoGsEzaKwBXUM
 B+RN2yeHa9CPsONtDD7ULeJNSC8BhFuF8h6rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740071965; x=1740676765;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfT8/u+PQsYdgtpnaWC9G3ctBs3ah6L2ii9WFBvrxus=;
 b=JJBQ8bxMPJmlf1wFEYD5Qr6wULr6vjL8hSV0qTe+1IpdhOo2qXSpN1yFarqMztgEo2
 rIAZYY52bOynN3IbwJoKnJ60aGugER1QcvZc5ntQRj/pX/cTKTtMVJqePOceaiWnVuMC
 dHZwSGTCYTgN23Cyb9Hevni4HYP1fZ88PfbPE12dGTUQ8jnNYh9mB6xMM3j9d1x1aU0p
 pp4uCEhA/1EXaMgw5PV58w8XAldGA3mLlQ5ivbMEjikkagHlCVHYHbhiHMCnyADy578f
 foPRWU72G94wYM25pGc8FotFCGh8QwcBYVkhxDGEVwAqKKTUXYWDSrwBNGks5Ih3EOnd
 5s5Q==
X-Gm-Message-State: AOJu0YzNlrxl95/n+CogRUrZHHv+tePZOwJSZE5KFR7GeEZ2YD7WYzSi
 DYLoayxRgNbDLPJtfuID/nz3pCfp3Lk4h/PcdCBD19aRVYCRfyfy36IkJdGROXZORh9MWFZGIYQ
 0
X-Gm-Gg: ASbGncsZb7flr8PMmDvyUr93m6d4mlCyeeuu0ZxmKelW+uJxUoBOXvxhU8ZqNWFw8eX
 /BxU+4V4Mhop+/MM30Gk6owqkOxC2Wr3qw3X2Jas1yo4FomZSzcUS46vh7JYs64PegugTQ6bzoi
 Hxir/uOxVccg1BqwLxEuikXzdsQ+QN+OTxkTJqDWKn/msObGxI8NkfXYNvMH/OLueOXKHUX2OZS
 86nXTfe9Ocq9uKZBLEZUtSL5ZA4bRlFvsx33uqkB9XrVjguXAO0yKImwwjrnZ4Cg+k3HrB8BFMc
 GiW8YzTcicSv
X-Google-Smtp-Source: AGHT+IHUx+jhD59TRpRix5kH9CVYc0nzfRSSNNbMOrdh+NiUNOrwGrUWdX3PxBRmhmTLf8n60/1TmA==
X-Received: by 2002:a17:903:1cc:b0:21f:b6f:3f4b with SMTP id
 d9443c01a7336-22103efec1cmr335885935ad.7.1740071965536; 
 Thu, 20 Feb 2025 09:19:25 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d021sm125324105ad.157.2025.02.20.09.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 09:19:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
In-Reply-To: <Z7a54FnRCYmuPojL@swlinux02>
References: <Z7a54FnRCYmuPojL@swlinux02>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-Id: <174007196473.2923422.8732999904432445858.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 11:19:24 -0600
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

On Thu, 20 Feb 2025 13:13:04 +0800, Leo Liang wrote:

> The following changes since commit 7a45cb4ffeff034304789954bb222ddd7d02104a:
> 
>   fs/erofs: fix an integer overflow in symlink resolution (2025-02-18 12:32:07 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


