Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839ADC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 21:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC5B809A4;
	Sat, 15 Feb 2025 22:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DpTGLgMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D90809A4; Sat, 15 Feb 2025 22:28:59 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125CC80C83
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 22:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220d39a5627so46967445ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739654935; x=1740259735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=adsyOtPHTVT3XIfj1nF+26KaZGGy6/NHtIHii3agn7g=;
 b=DpTGLgMkcKnlNNzywA9EM4lSslpuzh2LMf6/77qh2sMWpNlT7Lzvz4WdZaMWQLNQX7
 pbFSVX/bX9ONRVTcPjz1ZFuAFvspqxT4FjxICnnNSizeYs7p9n6f0gVeDfYHB711kBta
 jUf3Zwk3OOeJhhhis/w8v2CE4E3pgCiGxYixo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739654935; x=1740259735;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adsyOtPHTVT3XIfj1nF+26KaZGGy6/NHtIHii3agn7g=;
 b=w3rQUbBnb6MEWmWGiZpv7vTlSK2l9f0hoA5Dfvzwh9GueXSc9P8OORzYX3yI9Fr/XV
 J5bbWLHnhi3wHQFdiZP0r//kg7AEzwenFbZDJ9UxToSr+ARU7g6AjVfLdc5vtiGNz30e
 Au4SJxosZjAjNuzFJ3ipxoNNJUhi+R9PH6nr2BEGewQCRNaWv+W11s4EzgHLeVxTuIDT
 3umVDQc+J6dOBBfNC2ATl3tPlUQ2R6A0ehryJxpNsDWnTapytdvtuy+KSnCT/OHPwwjL
 gluoGNAhlFeDS5KhSufAc5RsbyiABTLrabchoRGQYoJEYgTIJRpHo8YZ0b6QuyZCsUga
 k91A==
X-Gm-Message-State: AOJu0YzuDWfwk5/9D9a3vwhPcNGLGDZmWD9JFh0XZnU8cWdm5VHZqgy2
 dZ3UWwVu1c+1p5Ko2WRTSigp6kZUo2BfybiDqNuQwS4Z8f9UMSTKuBMmzF0nVoOdFxE++DrebOw
 A
X-Gm-Gg: ASbGncv0DX0Ur7BxHcpDExsM/1laY0ysA3ekzYrT8EI5Nbn5cu4lMR3qRyZ+3IylYse
 1qAqUi2PwUgXw0Jx+26+Scb7MgcceKgHodTND+BMvCQHfpScky3IeEtfRelOlJZ5bHxGLrBHvSQ
 ZqmgMc9MOZFsuFwAvjQhgRMDwn9aKL9BdsGLX7kYYNe7rL1P7rFIAsu8QG+CBz/H1aV+81QlkZw
 yIeSRYf0MCZGlaipgr3Z0LJ7T88/OMOdpY2rK3PPdE84czknJtLgV5qVcsDzau60U0Ygxd6Bsfb
 6G40IpMtNAxf
X-Google-Smtp-Source: AGHT+IEco8NZKT6q+gS6PmFNUHrrTG8P97n4IPAdVPELtmW5WCvqb/tp9ByiBeycozooNr9HI5A32g==
X-Received: by 2002:a05:6a21:33a7:b0:1ee:8894:cc74 with SMTP id
 adf61e73a8af0-1ee8cb4f75cmr7461982637.18.1739654935572; 
 Sat, 15 Feb 2025 13:28:55 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732521b82b3sm3532985b3a.92.2025.02.15.13.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 13:28:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250205000743.949790-1-trini@konsulko.com>
References: <20250205000743.949790-1-trini@konsulko.com>
Subject: Re: [PATCH 0/6] Rework requirements.txt files
Message-Id: <173965493465.125355.9281936284185013964.b4-ty@konsulko.com>
Date: Sat, 15 Feb 2025 15:28:54 -0600
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

On Tue, 04 Feb 2025 17:12:03 -0600, Tom Rini wrote:

> Hey all,
> 
> A challenge we've run in to is making it easier for more people to use
> various python tools that we include in the tree. Part of the problem is
> that when we have a requirements.txt file, aside from the doc one we
> share with the kernel, I created it using "pip freeze". And while this
> might have been a best (or at least OK) practice at the time, that's no
> longer the case and is why our files have so many things in them. What
> this series does is create multiple files, one per project/tool and then
> has CI install them as needed. There's a few places here where this
> means that we update the requirements as well, but we keep a few big
> things where they are currently. This is because updating them
> introduces problems of their own and delaing with that would best be a
> follow up series. I've put this through GitLab and Azure to make sure
> everything is still going fine on both platforms.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


