Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B30CD8C82
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 15:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020AE83E3A;
	Thu, 13 Nov 2025 16:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IEIfroAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3606883E40; Thu, 13 Nov 2025 16:07:05 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0FA83B1A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 16:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45076d89e56so445319b6e.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 07:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763046421; x=1763651221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wPMU94a3Qfj19bYulsX6IlO1NTwB17HjP604tWbDHA=;
 b=IEIfroAhoOAmZ2L+atLHibeBDRa0hqNJOjMk3nUaoLVqVbb9RFdk1woDXt04UdxhJ8
 +4ygUmM85kadPmb1xqRJUzyParIheGunNEmmxh72pVQ8c1z1K+U0OzmFJgHFpGVAie0n
 LYDThDpWWybwTqPFvb79K/rgcjwijUgTVBO3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763046421; x=1763651221;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/wPMU94a3Qfj19bYulsX6IlO1NTwB17HjP604tWbDHA=;
 b=No9lNPwsZivEgWikpghzQMHaBp62INsY6ssAh+ZdTNLiWOR5an5fG73DtlSWZtNGTL
 P7GsQNtiFas/H3uL4dQBpGcIpwY5IKOOsYySSE0Lsl2qr1BjF0nt5XjZDFU+qr6sip3l
 xfH7HP4RncwG1lW+jMpeiYvUAONQAaLh4jMgLxh+cUpSJPiY7S0noGDG5sroiuNyvwgx
 WtV3XSaZ2r5hWLv60BzH/zdVZcZsPVWHI+dmFVZNl47gqWZ6FGvUAX+MmZgodKQzzsr2
 zRzfs080TQU7Aa4qbDP0/retLOEosI8jRePJtb7asGlNgwYv9ydGQeeYtDh3fpEAvP5J
 w+NA==
X-Gm-Message-State: AOJu0YwIZQFZhV/PDIYX7ubq4MkGevr3sUZoS24gfH8+geyfS+fNqJG5
 quIkBwDkCTGhq3plogolLNF6Kp2jrJOdVhHSI5mhmbIuPpjee3WXAqtZzTZVlg/9Ff8=
X-Gm-Gg: ASbGncuBA9wGeTw2JG1wTn+aeDyVyjO78VEupm5g+yVen6iTKOOj5CaKXvtYiVkiqMx
 z562Pg0wDbtkSxBF+XogO3pOKdpc4BSNFYC1um9/GndAFnLZqlLPOGHM4RlcQ24vMw8f24Whdgh
 sWKFPLJ1GWj+vBxTuJ0TDEh0yEfCyK5TLpw3GoxDfUZziMgDedk60uq9J+B0wQGuFolX2hbUV7y
 91LEbaabe/+z2snIaPCz+bJ4ZqVux39q5LdkvxmwFO+4khKab3clKM+sRAl7a7B9Ui1edJ9JC3Y
 VKZh3OQlEqkQ1K1YtK/c2e9GvdWhyYpyzCAZ2zlzNHweDyHjZ/K3REZXH04zxS4k2lj3ZkJZ7M0
 FzTl74K7MDQVvhFNXor/hc32IcQwzadLTgIKtEisP0PjLsgVVSUHXuYOWF3/XYk5cvn2VCSYG0T
 NXi58rX/xckNYIImIHxfZqFQR/bC1a7+SB3LBYXA==
X-Google-Smtp-Source: AGHT+IG0s3+7gZeOXAAsGw60W4pkg7FKNOqY9PcZqs5sBhVDK+cpkPgAr32Yp7S8uX+1YeONw73yxg==
X-Received: by 2002:a05:6808:152b:b0:43c:8714:fe3c with SMTP id
 5614622812f47-4507459d904mr3030595b6e.51.1763046421235; 
 Thu, 13 Nov 2025 07:07:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a283a44sm1350677a34.2.2025.11.13.07.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 07:07:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20251113054431.5981-1-marek.vasut+usb@mailbox.org>
References: <20251113054431.5981-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <176304641966.1685428.15564826322539092753.b4-ty@konsulko.com>
Date: Thu, 13 Nov 2025 09:06:59 -0600
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

On Thu, 13 Nov 2025 06:44:23 +0100, Marek Vasut wrote:

> The following changes since commit caa740df9cae5ddc74b18b88a4fea43e27b2fdf6:
> 
>   Gitlab: Optimize the job dependency list more (2025-11-11 11:55:16 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


