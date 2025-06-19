Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2701C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 23:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 564E082CBB;
	Fri, 20 Jun 2025 01:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FCNEwhl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48B282CDF; Fri, 20 Jun 2025 01:04:15 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A86B80C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so2312794a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750374253; x=1750979053; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1+0SY/NgpTNAZ00Dpo3AkJqqkRi1t6lrieilCOLkDA=;
 b=FCNEwhl0Svkf/UqkAqaGFRvt7ggDZZv5y8zvxGkJMXURXkmgmNeuqVWnUdV+6jKMpQ
 HGjoTXDyg/eS2qMxsOu5lcXB7n/7jb6bk1nhfJv5ID3hxRY3fqLvFCvoi2KyBMiC+pmu
 2htQE4JgtzxW+ruNik0NgbGoXLP4UM/pCa1NlWu2hnjLU5zFPnNGBpoM5/g8vR+r1Blf
 /c3r0uzgPJDj4CjJKtPm3aRFOdNY8QINbHvh6R7Ozv08IaMHNcrI3+PDsfDb+LR53f3z
 G54qVVlYMTYxF2BSmCGmSHtOKB2cES4zEctN90kiEKLciUWYVR6I5VQKW2Qxqu3TdR91
 Jn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750374253; x=1750979053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1+0SY/NgpTNAZ00Dpo3AkJqqkRi1t6lrieilCOLkDA=;
 b=PlXvl51gAKu7gGPCs5et0c1wexTSGSPoHS/JVU0aj9g5UXIUPSQI31fkSi2Q+WfqIJ
 VdJYe+/fA+lo4FAFyBaMN0Mj5qRuDhUMJk53dIJla0ZWnHjYwBGG9qkyi7JsQNs64DKP
 q68vyJdVRx6UspZm1yInsersL4Kr4ekA3Lay46DXszs3O3l84OVKcu5nvcDOO5uF4gFQ
 UuCsCZmL53Ap9xW80FvFDsbm8X7U3b1TGlDXP9N+Ipgt9eIsOczFBbDsy4KXaVUeNp7o
 RV09Lkp9IpamTXrUAZiLPHUdMBxZExj4npuC5rE3ml7U48NC48g4aC0JeUm/CqQjD0Qo
 0dfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOUFVZS7xWb5YuISf7BNlNau5y93beNxAuD2Tj4BCa5h2X08IBEUgWSKmXvBg4ZxjhfP4PX2k=@lists.denx.de
X-Gm-Message-State: AOJu0YwHZ851/3xwhfb0KVtY/n9Q7uWxOJNfLeqDjBCMApBIpzbtZU6e
 IW+FYQDLCPu4JOzUyCEluYtiIZIwDogYWGqnO0USzowSoXbXJbNcXYnScaLZnPq8qmo8RrsiH3d
 UtD6tLkOJ0rs4ahHbGNVzdWjpls3YNcI=
X-Gm-Gg: ASbGncv0mX7mykjM9+kcV7P+JXgGulKvvmnpicdTxR2BKvm1EcPCwLqEXafqypzMHWb
 0JRxfcNzMOpOdT1nnZrN/8PHCswmQcEU8cPUFl6TQrM030yIXX5fWrCS+rsZGcGj8E3bhgDzfBJ
 PQmbq59McURmUuNcOcpyMcZ7XrLxMKP6Ai3q1/4tu4TRSw
X-Google-Smtp-Source: AGHT+IEDiNV5AVgx/dOG/q+vXEZdxnixRhZJwHl3RkAsa4dYx6a7/fzLsSMM8O6JnKB7pcRp9xaK3apf9FJT6J+P5sY=
X-Received: by 2002:a05:6402:4316:b0:5f3:f04b:5663 with SMTP id
 4fb4d7f45d1cf-60a1cd31008mr628144a12.24.1750374252657; Thu, 19 Jun 2025
 16:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
 <20250619212714.GD216500@bill-the-cat>
In-Reply-To: <20250619212714.GD216500@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 19 Jun 2025 16:04:00 -0700
X-Gm-Features: AX0GCFvy9SSGzYo-Al1zMU2aOVPXsuCKq3uSenh6RthUpwd9SpGToKtfP2dKwFw
Message-ID: <CAJaLiFwQCT7LLw2rr9p+hviojYgrw166RCsdOOutRKDvye7icQ@mail.gmail.com>
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Thu, Jun 19, 2025 at 2:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Jun 19, 2025 at 01:37:53PM -0700, Tony Dinh wrote:
> > Hi Jerome,
> >
> > While fixing some ext4 file system problems on 2025.07-rc4, I ran into
> > a problem booting a few Kirkwood boards. kwboot loaded the u-boot
> > image,
> > and then u-boot execution was frozen without anything going to the
> > serial console. I did a bisect and found the commit that caused it.
> >
> > https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc02b8=
a75c1940
> >
> > When I tried to reverse this commit, I had a build error like this
> > "{standard input}:24246: Error: selected processor does not support
> > `mrc p15,1,r3,c15,c1,0' in Thumb mode"
> >
> > Currently, the only way to boot Kirkwood boards is to disable either
> > CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
> >
> > I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
> > know if I can help with testing to troubleshoot this regression.
>
> I wonder if the right answer is that CONFIG_SYS_THUMB_BUILD should be
> off? A quick look around and this (and sheevaplug) are ARM926EJ-S which
> is Thumb-1 not Thumb-2 and it looks like the kernel for example only
> supports building itself with thumb2 on armv7/v7m. I know that this was
> working, so we should dig more too, but I'm not sure what the best
> answer here is.

I recalled we added support for Thumb-1 from way back and a few people
have helped porting more changes from the Linux kernel.

U-boot has grown larger and larger over the years, especially with
bootstd enabled (I know you have been watching closely for size
growth). Built without CONFIG_SYS_THUMB_BUILD, the sheevaplug board is
about 107K over the CONFIG_BOARD_SIZE_LIMIT of 512K. And it would be
an unpleasant surprise to see size growth for other downstream
projects still supporting Kirkwood SoCs.

All the best,
Tony

>
> --
> Tom
