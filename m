Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6194C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8FB88D0E;
	Wed,  7 Aug 2024 16:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MT4XVjo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97DD388D0E; Wed,  7 Aug 2024 16:37:10 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D67D88718
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db1270da60so1153233b6e.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041427; x=1723646227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2FDLoQC0mmMZmpuBXXCJLzilXoprr8JcRo1CiokZqn4=;
 b=MT4XVjo3LeCamkBDd5WfI8ENWoSKMrE8YWWbq9SvxRL/WjQ5RNrJE4+PhX+P2OOrfS
 r50ZJABqz3Hnr2m9U2YuVPcSmxDQdQHgoTnBlRlOqsQ2mPVVeyYxP4GFVjD/OxYqwzLi
 oUF6FyTsJj64JYlzHwRgJwwTuX3fLdmpklmQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041427; x=1723646227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FDLoQC0mmMZmpuBXXCJLzilXoprr8JcRo1CiokZqn4=;
 b=VP/9tvS7t44ganVXokwX3z/xbz8Xr4SAkn3hRrnEghsma5Ik+wl4xt1Y3utQWXjHCV
 lJVfomG6Afj2SZTNnoSBxbTwglbl76eLBdS/30zWdQAAy5gkJsw4evZGjCCKvjK/jsPz
 r6VO2tkg3C9DshxsgCZ+tOtbESxN4ZjzdjdbjYeGTZ0Osam67aHbu+5EpgtVRIcf8oRd
 5tgoVOvL7wYRpmsLJh/YD5mXmwBkmWaiAgZV/74kYvrba1WsTUQSP1jDBpoFGpXozuah
 XX6eDMfLhyc98UE1o2s0jJ/NgWBEC/Bo0wKY4nP4lErtAYgf9ITNnOOIHodUiHuiAvXQ
 /OSQ==
X-Gm-Message-State: AOJu0YxxzGK0DIOEgVQVF9hLaMhbY7OB81YUpUnl/1PUu3W901veaIiW
 eJi0dv4HteFSwESMyn5rDiqJeyOn+YCP2PoUai5ZJXRtfhw9wmtc9rFVB1XMcbIEzBG9Yn7qVap
 N7RZjGIAQPrxCPlDoM90jvfMNtN/ySu2Nh+Ai7uEu7bc8yEM=
X-Google-Smtp-Source: AGHT+IGgmLp+GCNLVam/ls1sIRgD0yND354sCogNt7hfEpZSyS0Mi567f7upi8flV5Xq3A6iDcW7fdpAedU+TyTH3H4=
X-Received: by 2002:a05:6808:3028:b0:3da:e219:bf with SMTP id
 5614622812f47-3db558400d6mr22336761b6e.43.1723041426896; Wed, 07 Aug 2024
 07:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <LO0P123MB3929703FEE3D03E962D7E6E193BF2@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
 <CAFLszTimGrXLOMOheanvJaJFZZd6QujZCf7fKmG7zcEKBV3nGg@mail.gmail.com>
 <LO0P123MB3929FC2417E806A1B8F1867193B82@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
 <CAFLszThQ5HL7iDYoeVBBZd5aCuFGUDH3zs7+o370gBHcY2RNLQ@mail.gmail.com>
In-Reply-To: <CAFLszThQ5HL7iDYoeVBBZd5aCuFGUDH3zs7+o370gBHcY2RNLQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:56 -0600
Message-ID: <CAFLszTjBR=qKnQEC607rZG_wOWr=FuiTP7AHkzNBRf6HjEfEAg@mail.gmail.com>
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

On Wed, 7 Aug 2024 at 07:59, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Eden,
>
> I don't see it on the mailing list yet[1].
>
> Regards,
> Simon
>
> [1] https://lists.denx.de/listinfo/u-boot
>
> On Wed, 7 Aug 2024 at 02:21, <eden.hamilton@bt.com> wrote:
> >
> > Hi Simon,
> >
> > I have forwarded these emails as requested.
> >
> > Cheers,
> > Eden
> >
> > ________________________________
> > From: Simon Glass <sjg@chromium.org>
> > Sent: 06 August 2024 22:47
> > To: Eden Hamilton VRC7 C <eden.hamilton@bt.com>
> > Subject: Re: ECDSA for FIT Files in U-Boot
> >
> > Hi Eden,
> >
> > Would you mind sending this to the U-Boot mailing list and cc me?
> > There are quite a few people involved in the security side.
> >
> > Regards,
> > Simon
> >
> > On Tue, 6 Aug 2024 at 08:24, <eden.hamilton@bt.com> wrote:
> > >
> > > Hi there Simon!
> > >
> > > I am Eden, currently at BT trying to get ECDSA verified boot for FIT files working on U-Boot.
> > >
> > > I have observed that you have reviewed many patches/updates surrounding ECDSA in U-Boot.
> > >
> > > I have been trying to get this working, but it is appearing difficult due to no examples online.
> > >
> > > I was wondering, if you have any examples where you have managed to get this working? Perhaps examples of FIT files, DTBs etc - that you would not mind sharing with me.
> > >
> > > If you do not, then no worries.

OK, there it is, hidden under my ellipsis, thanks. Here are a few thoughts:

[1] is the general docs which I'm sure you've read
[2] Describes the process for a real board (with RSA, but the idea is similar)
[3] Is a test for ECDSA so you should be able to follow along with the
steps there to get something working

If you have problems, then a console trace is often useful.

Regards,
SImon

[1] https://docs.u-boot.org/en/latest/usage/fit/signature.htm
[2] https://docs.u-boot.org/en/latest/usage/fit/beaglebone_vboot.html
[3] test/py/tests/test_fit_ecdsa.py
