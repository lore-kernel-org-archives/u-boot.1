Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992E5C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 17:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF73880F56;
	Sat, 22 Feb 2025 18:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZUi2Of7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEAF800B6; Sat, 22 Feb 2025 18:29:49 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86B05808B6
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 18:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220d132f16dso49139255ad.0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740245385; x=1740850185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KzVuLgakVLlO1qXqZ6onMCNbd/l8lJA19Dzb9NBnGs=;
 b=ZUi2Of7q09y4oqH/D6Ebr85cKGGrc/Z+G0M7SeIbJneYCgW37bhGazS29f6p7gxU1O
 7TcB8nlZSsD55JBaXskkuPbRqyJi+4LmcPgV7uyScwQPIdRdz002TGg+AMj7jTN4N6Cb
 J4Gyh8qsstkXQHbGHk6FT627VxCT9dRF1sXjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740245385; x=1740850185;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KzVuLgakVLlO1qXqZ6onMCNbd/l8lJA19Dzb9NBnGs=;
 b=GYwwSzS4jkqXM1fgQzuKPBLcemOsaUNR5ABraW4A5/HdFBlGgdfQpTVWgEJhLCJOYv
 Xy6wKLWgs+a+9OUBDyg1PBabzUBCJ6lyNfHNye77QsKpaGSTcfcKAJiMdhndqnMuHGTe
 D7iZU7yPT7hitW9KkoJf23J3Hh4FI/QtiAxmzWJQIxFa3kZUowwXtcf13S21F503shFe
 noNRTdWQyNyoBXei4Wl1uFqRNYUnSN8SiM+P/+Gs+Ke4srH4xfsfwu5b85DToKB5GqJZ
 aweHzsiUW26ZrwcqJVu5qzBMHgcVKZanT9awyBZC9Uwe/9qUJe4za9ADBL23ed+Mun4N
 TAfw==
X-Gm-Message-State: AOJu0YwvJ+IKnWThMdhwoK6O2CLg6aBE8ZgUAZXtXMr1EUbS86QtrUE/
 uHfz4LBjhGj2m3/i+e2e1Qiz6GPZM5M+OW2Jjg95fjcKy9Xh2Kg3+AgBOl2LNhuciVDeuoI/RvA
 Z1VQ=
X-Gm-Gg: ASbGnctC6kDnll+48/XzOtqlYdcCA4OVzK5JAM/Q2PtXz+P/eiygSNLTOJRIQ5tj8Rv
 MueWJPRLg19b2uV1A94O67ymArELHzutxKxDR2YVsK0B79XnBWii8r9flhDDQ8DFcdyqrFcsI3Q
 HlVKPsRtwF2A6kI33YHfbuusm7JyXb5VM9Qa6dOAM/0ViNmC5jvTQ9B82GdWhmNBzgj7rPUpwAT
 VusAUBWh+HS8hWXXhylFnw4uFcZhEXo2x6JBDHVxKDYHJ7oo88e1NI+NcNlFBFNIPksfbRMSx52
 1heCViDimR7KwIK8Qvgpoog=
X-Google-Smtp-Source: AGHT+IHUBJDZkTuh0t5xLzZQHC/Nn3a1W9X7yUFFRDrpCKaPTxFYQO6YJ0j0ULB0zpY1U11CYfJIxQ==
X-Received: by 2002:a05:6a00:3d0a:b0:730:87cf:a7cd with SMTP id
 d2e1a72fcca58-73426cb12bbmr15115801b3a.8.1740245385065; 
 Sat, 22 Feb 2025 09:29:45 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324273e34bsm18116662b3a.108.2025.02.22.09.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 09:29:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250222073941.7963-1-clamor95@gmail.com>
References: <20250222073941.7963-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra picasso
Message-Id: <174024538413.3721828.17894961534238757091.b4-ty@konsulko.com>
Date: Sat, 22 Feb 2025 11:29:44 -0600
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

On Sat, 22 Feb 2025 09:39:41 +0200, Svyatoslav Ryhel wrote:

> The following changes since commit 274dc5291cfbcb54cf54c337d2123adea075e299:
> 
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-02-15 15:29:20 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git picasso
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


