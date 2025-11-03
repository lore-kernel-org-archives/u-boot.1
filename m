Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8407ACCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 14:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA756838CE;
	Mon,  3 Nov 2025 15:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NK3FzHUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A3C1838D7; Mon,  3 Nov 2025 15:52:25 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA9E83700
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 15:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-640aaa89697so2466701a12.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 06:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762181542; x=1762786342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bOBtoNPedl4d5UpzDFD5KEOC+B828zIbrm6EynT7S0Q=;
 b=NK3FzHUzoy853tHSkPt3sQAkC0y/ORz6bdkSNhCz79vOSwURx7JxRGZ/BpXV4c98Aw
 hIXoMSHqpG647y0L6MZBkFIvBAdxTg1bIzKdSHHP8wx+iHuPcatjIvHJficomverOdNs
 wzQDA4/isE3hayivJwVMy2nLmFlE9Fr+05R/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762181542; x=1762786342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bOBtoNPedl4d5UpzDFD5KEOC+B828zIbrm6EynT7S0Q=;
 b=w4/DkBCqW/X3GbxQhHBQJTlU+eMur5I0tJdSzBEs6BaAOPqmRs9jdwizkrFapsQCbW
 lVDnRj25s8gbXuUJI8k2CX0myB1rF/76dOOnzTJ6QHLiUUkrtJUsojflV5FB31/kgP6l
 2JYBT1y6GYSRRFItcXoKRsXp8Atjvyex1BlGOPs6Ep1Kqbw+r/VOVwujtT2fpTWwC8R5
 Q0r9IkyTBd3bU8+fSdaHJ44gNvqQkPKSPsb0PV/Z4Lc3m5GpDEstDB59O2pDabZM2t/4
 7uxtSFPIuae/03TfNs7BkrogB8DDinQmCje6O8ZS5G9goNCapYnB4FfHV7NbwC7c6S8D
 LZAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZhL44Z3vkpNRtDzwr4gqV0YCV4VkxhCPF8QGi2FLPl6DnEs1bSIhVBFhm0gNVU9fL21OvEfM=@lists.denx.de
X-Gm-Message-State: AOJu0YyNvD6DbegigqiNbjGzTRqdipsCrGHhNMwaPJQF54t9QLI+cSAe
 Ygd47sY/ylkHLJ7togjXGeJnB263R5+mWxlilpZlVryRPcQzi69lzi8UI/7Oz++OSFZzz+ck07T
 +kaBuE2FDyWlxnN6uJAMOvoQjf5OWwFPse/2+4Sfy
X-Gm-Gg: ASbGnctJe9NciqSmDFGD9OIvY9nGcOKUcqddRuNGG1XBCeEPZYqa566X47KOA9vwof2
 Vx9BVj2smw0CEUbHfEhok5x10dKzfbheQrIEMOXiUQBVa3pp1QnS9llM+dy8Y3TE/LhVAQq6o5R
 +TMhlFaobFXNbzMYnfIC8Ucy+eRanQVv7tugzaXYJctwZKndZtgwnMQy+64S9NPgI0N2gZjMnOJ
 hDfr05u34NmMGIiSHjTOdBAx6WlXcdqlebZtDqObrOTy6yz99EYR2Jnf106HAkk0i5pIxY=
X-Google-Smtp-Source: AGHT+IEHkbhP+oAG1xSfs/un4TPCALxy0tgSt64SHBLLErC0mHTw+FBkTQD31q3K8NBnS5UcCV2N0D8s3LmYIbJazfE=
X-Received: by 2002:a17:907:7253:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b70705f3602mr1382515566b.31.1762181541869; Mon, 03 Nov 2025
 06:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
 <CAFLszTgKWU7mnFdXAOX7rH8jcGs3QrEVy=49om49=FbdNj1q=w@mail.gmail.com>
 <77d2b661-3416-41ae-9f73-68977a26aa30@cherry.de>
In-Reply-To: <77d2b661-3416-41ae-9f73-68977a26aa30@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Nov 2025 15:52:08 +0100
X-Gm-Features: AWmQ_bmdZiqU2x7PayTgcBSulxGoTaxKEypnJhG5DzDSj1a9i7iQIVwM4Y4ENc8
Message-ID: <CAFLszTjMEt2Ph+K63WM8z3yNiZdOwyo-HeQhNuu-6uULiw+3XA@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools: binman: mkimage: add support for passing the
 engine
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>
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

Hi Quentin,

On Mon, 3 Nov 2025 at 13:13, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 11/2/25 8:53 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Fri, 31 Oct 2025 at 16:23, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >>
> >> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> mkimage has support for OpenSSL engines but binman currently doesn't for
> >> direct callers of mkimage (e.g. the fit etype). This prepares for adding
> >> support for OpenSSL engines for signing elements of a FIT image, which
> >> will done in the next commit.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> ---
> >>   tools/binman/btool/mkimage.py | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > Please make sure this is tested.
> >
>
> That was the anticipated and feared answer. I'll need to figure out how
> to create a dummy OpenSSL engine which doesn't require any hardware so
> it can be part of the CI. I have no experience with OpenSSL, so this
> will take a while.

You can actually just fake it in Binman, or even mock it. You don't
need to do things for real.

For example, see testFetchBintools() which uses mock.patch() to
provide a fake download. There is also command.TEST_RESULT which lets
you fake a command - e.g. testVblock() does this.

If you are worried about how to get real data so that the test will
pass, you can just plumb in some canned data for that purpose.

>
> Just to be sure I'm not sinking time into things U-Boot has no interest
> in, would supporting OpenSSL engines for signing be mergeable? OpenSSL
> has deprecated engines with their 3.0 release in favor of providers (see
> a recent series on the U-Boot ML for their support in U-Boot and
> https://github.com/openssl/openssl/blob/master/README-ENGINES.md for the
> official stance of OpenSSL on this). Porting my employer's engine to
> provider isn't planned (yet?) but I would like to know if U-Boot has no
> interest supporting that use-case, in which case I will "happily" keep
> this downstream only.

It seems very useful and interesting to me.

Regards,
Simon
