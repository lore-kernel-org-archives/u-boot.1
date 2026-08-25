Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8CEC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 13:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54C58405A2;
	Tue, 25 Aug 2026 13:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tiZv3oSpGrwd; Tue, 25 Aug 2026 13:16:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787663785;
	bh=dWQab07VlJGesHyLJQMZVMfl3l5UUQAzf/jx/p+xU6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6EbnZ79GQFyO1klXFbqEhJIk7kju21Cq/cmGWX5BraYIA+wi1b2Y4LZkzPE5/sSV
	 RAWpYQvTnQFNrjymFT0xEBtgR14dLHyXJoO8e6MRYiQBV8atF2JY2rd3etCI1vG1yG
	 jJ0qnZH5C2YGdohDAvwDZu+eK8jc+OKRSrxDu/080eO4vuPiputQEaO6PNKv0KhhKV
	 Z6ZaqokCocS1Eg6TICwS3R16owbEOQMwnyZQo0CsprLiZISnO9kk4npqb/jaYDFqm3
	 slpJ3OZgjzh19hVwESUBGptxpP2DoYWrkXmeFMFb1nDpF1wwAPB8f77+Ovq2YKWz2z
	 FhZktloKFihag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 411E84056B;
	Tue, 25 Aug 2026 13:16:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CEEB118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 431C0606B8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRBb_ouYMbaT for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 13:16:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lLlxr5Vu
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2173A606A2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:16:19 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c20fb91ed0fso735580866b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787663777; cv=none;
 d=google.com; s=arc-20260327;
 b=gUeEn4+hvm9nsNg14gET23FGU0MHPEapn4WY5BbzWuhbfOX2OgiGWyVpTapcZj4lta
 8/WILBOx/6tWfN9ATp70R6yPGH6ERKLpMIfxgzNATd6rlS8qKshsexVnhVakydpnuc4K
 9Jt8xF1F3xsp84VutXxh0ASnWqAQGllh3ZGhxNGoYwXMaApUWSXYgAkNym9KRxde+R81
 w/Bbx4IaLedc0G5jL2KIvPoMTD9oaXmHtaMLvWsxUjUjH/9Yoej6mJWJ1rjogZogeBPP
 tdklJAd2O8h7f2GGqbD94Z/P4Et4C872OTizoaQUmxDRIPoSgvIzFejSMYuTdC2ktMXY
 NgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dWQab07VlJGesHyLJQMZVMfl3l5UUQAzf/jx/p+xU6M=;
 fh=jR5CQO4rrHowKfqoPKFf2wURUV1OW6x+JuwzSSkiih0=;
 b=BCvQIilmhplIcnOy2qjORdMliRNkLmdvuFmPb22x8hAhL3iQUcBYBIYGtN4W0pPGFj
 H+QCoYDLKMBl1PFLGP8UUfa+m6vclzUEGEjOiR6GzdjtNlx6vtUqX1PSUggd0d4b1T66
 532ig0dxn80lEzREg/KhlHRYCds53ITNPQuyAYZt+9xHf7r2WaWLCb1YI74HEO2AOVXw
 39HyR9K30ezpRz+jogTSeBsB3/KZdJ4NRqKBpzVjaMessNJx2NWMVo6gaaT25ICpfL6Q
 668NnCoPLGukQ5VSKy28yRSNXh+gobg/LUONG79UxC7s2f5G8C+oc39IdfLeQzJPfE45
 RS3A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787663777; x=1788268577;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dWQab07VlJGesHyLJQMZVMfl3l5UUQAzf/jx/p+xU6M=;
 b=lLlxr5VutPgnsL0q9yvTclkVmoYRCd7GSNkkULl7YPBVAEZPGD/Ozau0fD2zQvBYVJ
 +y2lFofutS2drWBDcin8KUT3q3veFcjaKljF1CnwxnwYQzssdttkCpFPTHcFHSN6Mpwg
 MSk/Y+20DAp33ifrOD22iu1cst76z8caDSOHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787663777; x=1788268577;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dWQab07VlJGesHyLJQMZVMfl3l5UUQAzf/jx/p+xU6M=;
 b=q6h/ECioqsDKKdECBuwbolzwcrzP23qiae4YmYPWpGj1W+vrY9c95Xme2D8a12LaOn
 5JKGt8R/ICG1Z1YpIyd0u7ZVw7ZH6XCjGYxV9DJiUISRDoeinPB+4Y+2Crsqoy+qLdeE
 RnyfQpjSVx4xHNPIsfPJrHcBcS9oXEeXQI4EQT5rY/6pEVNX9yEc5fVaQTU28k1s96qR
 o94wnMqi8SyGBnBFAP1QZe4Jx7V0FOEWGVxDFn0cc3N5inXrbDWu/1twfFPSQtDC2RXO
 KSNvB/nI1ConKp5UgRQLgAyS+sSM7Hnf5wNjk4sewrTXPeaThkdbaRbeHMCx/s3PaFC1
 jJKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSjuzhGAPvWih7sW8Pz66HgQaKsyaInoCUqQ31y1NtRlIFUi+41QuE1A7DLWLWxZhwNAiyLIw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++liuAGDoXOd51b1bE/As1cngI6TEoQnyaWqREXAYNCjagXBRUE5
 3s0mOxgRu8DSZpluqvp+9lYeHD51SVuwtdHcU1VYZxVW74qjCQh9LuxXJ0ZzrEIV01f5PAgUWD+
 5qGMv2YHJ/2rzdkNVUD68vfgajBWRuCkL6gymbRgb
X-Gm-Gg: AR+sD122n0RAJIOfNFg7DIqEVDCd+qSkwxSOKbycrbuBQs5+A9UgdN+FMwz9vKqWELT
 /NJWuLfjToIErvu5t2tY2IWlsGP7Gp3w3lgC+B5XDYNVSQ6x8ZTwomYDu4miKDejCHY7WZZGcBK
 ZoVceDYGjm6QXyoDJNsszrEYGSAj6xJmxVgXokiJKCXaljEGmL1DeEAWdjWAHnzsIcJAZNvLY0H
 wDbmH68PRVJCYL1zz3wizk13rzgjHm7KZVJx77d9lMdqPzsm0CiGMZrabcuElA+VmT4uWcdXjkR
 XdGbr7Jffe2NaL2oLPwfm3SyYW7Kk16Xo75Xy81dDdg=
X-Received: by 2002:a17:907:1907:b0:c25:5a7:87f with SMTP id
 a640c23a62f3a-c2505a72573mr121252666b.0.1787663777464; Tue, 25 Aug 2026
 06:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
 <20260820151021.GI523975@bill-the-cat>
In-Reply-To: <20260820151021.GI523975@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 07:16:04 -0600
X-Gm-Features: AcwNN1UlsPbnjTv3FJcMxyadeuZhJI1iORBCfmuOqQ0r7-aS-_IXgFhYXqKeZ9A
Message-ID: <CAFLszTg=e3-bpWB7_Q8UFcB-pL=DJvPXji3yTtF2DFWkzPz0gQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] boot: android: Add Android 13+ bootflow support to
 bootmeth.
To: Tom Rini <trini@konsulko.com>
Cc: valentinliu@icloud.com, u-boot@lists.u-boot-project.org, 
 mkorpershoek@kernel.org, igor.opaniuk@gmail.com, alchark@flipper.net, 
 quentin.schulz@cherry.de, marek.vasut+renesas@mailbox.org, 
 daniel@makrotopia.org, rs@ti.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

On Thu, 20 Aug 2026 at 09:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 20, 2026 at 06:31:18AM -0600, Simon Glass wrote:
> > Hi Valentin,
> >
> > On 2026-08-18T17:53:00, Valentin Liu <valentinliu@icloud.com> wrote:
> > > boot: android: Add Android 13+ bootflow support to bootmeth.
> >
> > Please drop the trailing period and keep the subject under 60 characters.
> >
> > >
> > > The devices launching Android 13+ were using a new partition
> > > named init_boot to store generic ramdisk.
> >
> > >
> > > In the new bootflow, kernel still be stored in boot image,
> > > however, the First Stage files in ramdisk were moved to
> > > init_boot image. We should load it to memory and verify it
> > > so that the kernel can execute init program to continue booting.
> > >
> > > Currently, we have supported loading the init_boot image by
> > > abootimg command, but we still need bring this ability to
> > > bootmeth, so that booting Android 13+ will be more easily.
> >
> > Please use present/imperative tense throughout: 'were using' -> 'use',
> > 'kernel still be stored' -> 'the kernel is still stored', 'were moved'
> > -> 'are moved', 'we still need bring' -> 'we still need to bring',
> > 'more easily' -> 'easier'.
>
> We do not have any sort of grammar rules and requirements like that in
> the project, please stop giving people feedback like this.

As far as I am aware, as a project, we have followed these guidelines
for a long time:

https://www.kernel.org/doc/html/v7.0/process/submitting-patches.html#describe-your-changes

Regards,
Simon
