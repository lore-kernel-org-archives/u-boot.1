Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8B3C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7617288BC9;
	Wed,  7 Aug 2024 15:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RATUWO8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6088588BDD; Wed,  7 Aug 2024 15:59:55 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E394488BB5
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 15:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b7b23793c1so10140056d6.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723039191; x=1723643991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BnRpCIhZGa4SZlUViP7tIcq+rjTfdyqKw2odswnyF2Q=;
 b=RATUWO8OSokHedE2woAnWQPeaLEwjcORZbbZr3EoGQ+bxCft+u127iDMUaAnwVEgxX
 KvC5rFO6E1Tq9QlO5B6xI6p+LR3RzO48xR24QwksZy8JiWKPfCNaqcNGut4Nny8zI7RH
 e/e0m0VNHydWLC4+kCiWTko6CLj9G2lLabax8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723039191; x=1723643991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BnRpCIhZGa4SZlUViP7tIcq+rjTfdyqKw2odswnyF2Q=;
 b=ES0bBkZDcCZ/4Jlqlia3Mc3zv/Apw3OAbSGxdecfZeMoytJ4VC/3JZ/lh2lRtfo6MV
 gBQGlVr2SiTR1sCVis5TNRm7ltoKM0qXAGpZTtdj4PDyZrsPBxqEvRfecR0edCUc40Yj
 OISNO8MF6nFYJL/ofPw1CM2idwfjICYWptU6Io9SLh2f+MmWUhXd+aFaPMAtMcHNXAs+
 Q5tkCUXm2f/W3jAKvb9DtRaaAtT/LJU+qw/bb5kgW87z/cGbwROkygWOIux34gHncPdC
 dntdAytmdM9xnCfAeSBTGOYECmMTrLrrsl1PvWR6r4nity0MTvo+fVixAZJcZwTC6AcK
 xnMw==
X-Gm-Message-State: AOJu0Yx3B+p8cPKMz2513weHGKllY103gU2SvYxe/MpI7k89i1Bplmbu
 +oJZlTPLLae2mW+ucTKVx5g4FooJ5luroRzT4XJKqSOdi8Q0bHWXqY+leWa3jGBUKQ+UeCbXXQT
 csOfZVowyVO9IEc0NML10WQOw5XFWTTqABYHJRqvOO7T5xgD7MQ==
X-Google-Smtp-Source: AGHT+IH+7AiE26E+WKSOmBZZNHXBQArsH3RQu877kTn6RWRH2ZysmNhK01nOWPz4YSUtqZurG1/FIaJmzoF8X7SWw9c=
X-Received: by 2002:a05:6214:5247:b0:6b7:a356:1358 with SMTP id
 6a1803df08f44-6bb984467fbmr199250206d6.51.1723039190724; Wed, 07 Aug 2024
 06:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <LO0P123MB3929703FEE3D03E962D7E6E193BF2@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
 <CAFLszTimGrXLOMOheanvJaJFZZd6QujZCf7fKmG7zcEKBV3nGg@mail.gmail.com>
 <LO0P123MB3929FC2417E806A1B8F1867193B82@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
In-Reply-To: <LO0P123MB3929FC2417E806A1B8F1867193B82@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 07:59:39 -0600
Message-ID: <CAFLszThQ5HL7iDYoeVBBZd5aCuFGUDH3zs7+o370gBHcY2RNLQ@mail.gmail.com>
Subject: Re: Fw: ECDSA for FIT Files in U-Boot
To: eden.hamilton@bt.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Eden,

I don't see it on the mailing list yet[1].

Regards,
Simon

[1] https://lists.denx.de/listinfo/u-boot

On Wed, 7 Aug 2024 at 02:21, <eden.hamilton@bt.com> wrote:
>
> Hi Simon,
>
> I have forwarded these emails as requested.
>
> Cheers,
> Eden
>
> ________________________________
> From: Simon Glass <sjg@chromium.org>
> Sent: 06 August 2024 22:47
> To: Eden Hamilton VRC7 C <eden.hamilton@bt.com>
> Subject: Re: ECDSA for FIT Files in U-Boot
>
> Hi Eden,
>
> Would you mind sending this to the U-Boot mailing list and cc me?
> There are quite a few people involved in the security side.
>
> Regards,
> Simon
>
> On Tue, 6 Aug 2024 at 08:24, <eden.hamilton@bt.com> wrote:
> >
> > Hi there Simon!
> >
> > I am Eden, currently at BT trying to get ECDSA verified boot for FIT files working on U-Boot.
> >
> > I have observed that you have reviewed many patches/updates surrounding ECDSA in U-Boot.
> >
> > I have been trying to get this working, but it is appearing difficult due to no examples online.
> >
> > I was wondering, if you have any examples where you have managed to get this working? Perhaps examples of FIT files, DTBs etc - that you would not mind sharing with me.
> >
> > If you do not, then no worries.
> >
> > Kind regards,
> > Eden
> >
