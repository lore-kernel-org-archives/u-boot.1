Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A56C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 06:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74268887A;
	Tue, 16 Jul 2024 08:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i6E0KcZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9064B8896A; Tue, 16 Jul 2024 08:32:06 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D1A988865
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 08:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f40bso6398773a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721111524; x=1721716324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQfEmu7PSsrXyRVRkZs2Tb/3b7RS8h6uL1RK5pPAPjc=;
 b=i6E0KcZP0BqTaI4OwnhfJDPDv471wiczP6CfQqCJKvCt3kg/dqr1+PBNDuDVL6hgYP
 FKXOGzLacVZN4nmAgSsu9idxFo/LINCD/arXCr7nVrlZqK+5LF5rjwOWM0nnki5P3/Im
 SjQoANhIT+f5qdAjUDDQvJyOu4NnVN010RFyRfpjYmn603B0KW7XlnXESZSVGf4eVs3m
 hgcmR3rCTNbpQ883mCAIWSof7WVt5PxgFK08fAa0bhtBmVxh176XT0sVu59rjtBGWg2Y
 bIVOh/e1rCJLwbfqnQkTQJTs5Z8iX+JEtgaRfTld67rdH0mowJNYIsE0AU3yxjznLiNf
 q1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721111524; x=1721716324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQfEmu7PSsrXyRVRkZs2Tb/3b7RS8h6uL1RK5pPAPjc=;
 b=NY6M0EbaIe1HvfPXSOqyGiAItWkOnYMmSKldTN7PkkGO1YD5ULTCnZqKHd11ufha7r
 mtrZdQHPEejEydFo1mFsfSkWeSroRwX29SYpnbMuON10CHGzqevUM2+MYaH82/SVdk1s
 I0eszs/8D39jjaAxHu7eQbav5dCW+0LGF0codT0Nanfd/5yGti3LC6iiFVvocPHwCr9a
 yEkcq7rqBmHT1VV//DJnHWG6o+VP7EP90EnYb9LB4wj1lmOh4Hhp/S0W2cuoIwTIPLNC
 ArDA/44KYs6T+IiIZZKUC2uxMfQ5QaP2S+Bm3VkGYXGfqWeIaK/mSYFOlVO6Slu7YHnJ
 BcTQ==
X-Gm-Message-State: AOJu0YzmZ2X/Fv8S0EOA7g+IRn1U8rJtzUSghG6AnKyDpz9PdokbfBq9
 UGxGSF7o5byWBJgn0Xr/ny7lirnAcxAL3wLe8rC9Qi+P3r5Ac5jgUt8/6xmmgvv1iovcDW5neC3
 cahXxWBdXhihd8bN4sBryu2Rgw8GBXE+4852PrQ==
X-Google-Smtp-Source: AGHT+IHgVxM1yzaK731SlRUVF6rXmDJbkuhnVBV+UQvBpnakeHbbpLAXyz3HIgIchvTFzXsJ8O07r5lEyVLwZH9Eo80=
X-Received: by 2002:a05:6402:2791:b0:57d:6326:c658 with SMTP id
 4fb4d7f45d1cf-59eebad6eafmr819404a12.0.1721111524091; Mon, 15 Jul 2024
 23:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-47-sughosh.ganu@linaro.org>
 <CAFLszThvVSuUMOavz=MqpE5GSm5Yr2CBBUvMkvV7RbNGQEPDVg@mail.gmail.com>
 <CADg8p96xj1MCKnrhKL5JoyrJfbr3xYqmQ00JJtMLAT_hyNKqQA@mail.gmail.com>
 <CAFLszTis9gZDgpnc-oH5WH7ktt5XHOXfqvYvVEMMAVTv5NoL0Q@mail.gmail.com>
In-Reply-To: <CAFLszTis9gZDgpnc-oH5WH7ktt5XHOXfqvYvVEMMAVTv5NoL0Q@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 16 Jul 2024 12:01:53 +0530
Message-ID: <CADg8p94d-ziGF8aPNZRiW2mA7+tWrcMOUGiiX6Z_qs0qKEJfGA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 46/48] lmb: mark the EFI runtime memory regions as
 reserved
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Mon, 15 Jul 2024 at 17:09, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 15 Jul 2024 at 10:42, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Mark the EFI runtime memory region as reserved memory during board
> > > > init so that it does not get allocated by the LMB module on subsequent
> > > > memory requests.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1: New patch
> > > >
> > > >  lib/lmb.c | 41 ++++++++++++++++++++---------------------
> > > >  1 file changed, 20 insertions(+), 21 deletions(-)
> > >
> > > I see again that this is getting circular. Can you look at what is
> > > actually allocated by EFI on init (i.e. before anything is booted)?
> >
> > This code is simply ensuring that the EFI runtime regions are marked
> > as reserved by the LMB module to prevent that region from being
> > allocated. Do you have any other way by which this can be communicated
> > to the LMB module ?
>
> But this region is within the U-Boot code area, so it should be
> covered by the normal exclusion of that area?

Yes that is the case for all arch's today. Let me check if I can
simply drop this function then.

-sughosh

>
> Regards,
> Simon
