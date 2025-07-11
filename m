Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA6C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A603E83043;
	Fri, 11 Jul 2025 22:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IeUjBOnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA8682F8E; Fri, 11 Jul 2025 22:00:53 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E45826AA
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73afbe149afso1281319a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264050; x=1752868850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAwdfbfKSApuSRvYf5VAxgQNQ03VF2UWUCwHtX61/bc=;
 b=IeUjBOnmmdqqNkNpGGPVJXctAsKHnud6xZXG9KYjY+Bx1GtynQ3v5p9bzDPAEYKEZW
 wsN7Wovzc7dDe4BcSbwUSRQT7narRzqiYLVoagaKW9/wtCEJ3EfB18QrVygcL0i7yDnz
 6BCqK+yLLWrug+96MVC9OSi4+0fqMYo/9yt1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264050; x=1752868850;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAwdfbfKSApuSRvYf5VAxgQNQ03VF2UWUCwHtX61/bc=;
 b=odqsEcl8DGPdLm0AJxKkjsuKX483ApkQVkGV6zmK1tgjCZfuNXVfuk//7qO+UWLIov
 hWJV6N+qTHazE90sZ0T3gXTAmxerLHXnRmp85s8HjnO5zer4cpmPHGSyLLb8VoweOzcM
 zT0/1kFf5WAqgkOQeiXL0z9UGbLIT519zbxSZA2QSBYW1TkMznEO4+BDR1cute2KqGCj
 hZyoP2Kexe6LF1E03gIf7XAgGc6IGvQBjtfnbDKg9hg6Dxpe4FR3KPfST1Ary0mPQdxx
 nnoQeGnKq8mWw7dPSnpZ9R56vh1xh/JUjeJsXCrrvyHmvzvEKGIHZMnSd6z714Z0BtEF
 Ji2w==
X-Gm-Message-State: AOJu0YyEn0DhJhrW1SLFCNay+VJK40XGETRFqhZ/LSo9bWErPMCYFBeQ
 yqYqs3LDZL5COIlio5TZPcO0uA2dNeECDeXpCKZFzbn1TfqkdyweGV+N/riYJFMK87BMk6On5b2
 xCe+rnqU=
X-Gm-Gg: ASbGnct2WZS7sXPdBaz5Rlg0F2TI6IbSiNqm2zmrx34y1rnzRl2GryER20EUrU53AR9
 JyLkTBsW2hW7iWHAeARlDsQCgb1wDU8jF/8sj5+p5AD493kqdud93nZEh4XKSyTgG3K2uqVMP6C
 sKJKwYeNLwjpaORU0GUCxG6WAVbayctb43k0yTbofyNxGo+eJP35Q7+12CEBab/Ln44HyO8unA1
 YXIMXE9GA/3v4g99SzoXSVBvZd52Sm+AXt4tV9B9p/OEdv3XWjeejLk7vazVm4p4S+fIxqz1kYe
 q08teeLY/KIGlQrekH01Vca5Lur7VDJ0Tkc4v0/mZHoyYCNW0uTgv26W4efY+GgnPOsjJAVOjZ4
 AkwbaSiNoRgzZAYiRmnPXHomYhJlLvmurit2R8N7PPkqicHIkdUUAMtE=
X-Google-Smtp-Source: AGHT+IGKMcqkl0I0T2NOi6rWc5GCxRBAkwsGbk3aalKDggdZugQbCLfo6JRqQGb9zG9ETRFCV6IE9w==
X-Received: by 2002:a05:6808:2016:b0:40a:52f5:f2ad with SMTP id
 5614622812f47-4153737a03cmr3306995b6e.8.1752264050274; 
 Fri, 11 Jul 2025 13:00:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:00:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20250704214542.3418805-1-trini@konsulko.com>
References: <20250704214542.3418805-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] toradex: Switch from ARCH_MISC_INIT to MISC_INIT_R
 in some cases
Message-Id: <175226404944.2365211.2655877557197327046.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:49 -0600
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

On Fri, 04 Jul 2025 15:45:41 -0600, Tom Rini wrote:

> The hook arch_misc_init was not intended to be used for per-board hooks.
> This can be done with misc_init_r instead, which is what follows
> immediately after arch_misc_init. Switch a few platforms.
> 
> 

Applied to u-boot/master, thanks!

[1/2] toradex: Switch from ARCH_MISC_INIT to MISC_INIT_R in some cases
      commit: 0d50d5fc52f0fe54f5d80bb9543f92f362c8b80a
[2/2] global: Make ARCH_MISC_INIT a selected symbol
      commit: d0ed9636902bc5c0d7ea5f73926441241acb6051
-- 
Tom


