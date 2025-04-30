Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A885CC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4EC82BA7;
	Wed, 30 Apr 2025 17:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lSmt/pld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3418D82BAA; Wed, 30 Apr 2025 17:00:52 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288598215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so224074066b.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746025249; x=1746630049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sUpmowZwqD+OJLfvyS1kEg8OBOCre/lNIKWnkmzFWxI=;
 b=lSmt/pldMWfsSVEPV9vScVxuZ481G6o4hl2GFqebYlWjfM7cr7AvUST9U6uS4DuMV9
 ODDSjfYXjmo7CnvhdIJBzVsr4igMLQMJAVTPYRYdEwKJ8CndQ3hW/QClFzAff7qaEYbO
 WpnhnOMylbtNolU4YqvH4+eenqXx8eMJW6dbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025249; x=1746630049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sUpmowZwqD+OJLfvyS1kEg8OBOCre/lNIKWnkmzFWxI=;
 b=NkSqU3TpCb1BYGylkSDivTBoxpZ2bn+pBjoteSAs37GQc4n0mkmGTqvloM3nRwCTsP
 lGI8sxAYZVsvLld1l+2C3yhRMvZoNusLH1F3yVKh9zicaP2dy/AqoPXcIZktiebnFY4v
 djnDwfIjsmRnQEC7dGbtLaCZ8BW5xFOttLvN5GTi7R8hIlvNHYMohoH3qgNj2sCvaT9n
 XK9jzqE2HvMvAveMPS6ZS6CmCcNt3LZYbSOQZUMN/91Izl90IfIi+gvF7+7kDlwcN681
 gBQmmmEhMIpX1EhBK41Zb6hd4svg93QZ97aPEYqTx5272Qr13rSlCQ6V3h7cUAZ5PPX0
 E1zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdVlwSBFFbnc625OTs5mFWIbBe48xcX4OW//1Gyq9R9i0xooewvEey6KmKdqnSUB5lj6R1Qkc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9RdMxEHhe5vRdHIoBruovBzi1HKfTLAjoWONRfjAiMOibZZo7
 L4LHSQKDjnyOqj5UI56T7vw7AKmDKIAxwNmymWQcXgvTyGUFgyQS0pkD5f4hLMvMbVN8aCiu6a0
 ledeMYuP4q2mNmAc+c2y9ewZwHfjYUi8MnhhG
X-Gm-Gg: ASbGncuL5pTHVjgz3bjLSvWyGkUmGhmBRTTHlqEMdCYdnx7gkCRWJgDR9Se/Pq2QLcB
 nLiyKdRObE5bl7rJtK0T7vwFLdvuJFLtX/qPeGpVNt5p0Ef6Jf4z9Uq+UKl4/eabbsNFvxhG5M0
 z7nQoxCDp/X0JvPkCRUUzCTW0=
X-Google-Smtp-Source: AGHT+IFw+LvTmQKP68eRmq58kawIaW9aZ3Hn/QADSz7AJ/bnOcBw870SZW44jn8CSS4DoICpj5jmOrXm1Zw8Wm1Fa70=
X-Received: by 2002:a17:907:869f:b0:acb:124e:81fa with SMTP id
 a640c23a62f3a-acedf65b311mr348351366b.5.1746025249435; Wed, 30 Apr 2025
 08:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250430071613.13508-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgoo=_0WK+ks8nccOUX4X8CqTryQnUQZuP8EwwLy0SEgA@mail.gmail.com>
 <e7d6597b-609f-4b52-ad92-4c37fd60ea22@canonical.com>
In-Reply-To: <e7d6597b-609f-4b52-ad92-4c37fd60ea22@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 09:00:35 -0600
X-Gm-Features: ATxdqUE-RAwCjPh6g05b5FdR4xUxwaTajQ7psGZR6q7xAjC9Qvjm_vaoqA1j7Bc
Message-ID: <CAFLszThAzofiU46U+Ph0USQyyPsJggk9grmqMOj25w6xbDhgRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot/image-fit: improve 'No Image' message
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 30 Apr 2025 at 08:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 30.04.25 15:54, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 30 Apr 2025 at 01:16, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> If an initrd is invalid, we see output like
> >>
> >>      No Unknown OS RISC-V RAMDisk Image Image
> >>      Ramdisk image is corrupt or invalid
> >>
> >> As most image type descriptions end on Image, we should not repeat that
> >> word.
> >
> > Instead of that, remove the 'Image' from all the types and reduce the
> > size of U-Boot by 200+ bytes.
>
> There are more places where genimg_get_type_name() is called. We would
> have to consider all of these.

We just don't need the word 'Image' at the end

>
> >
> >> Instead of misleading 'No' we should write 'Invalid' here.
> >>
> >>      Invalid Unknown OS RISC-V RAMDisk Image
> >>      Ramdisk image is corrupt or invalid
> >
> > What this is actually saying is that the image is not of the requested
> > type. It may be a valid image but it doesn't match the requested
> > image_type. So calling it invalid is going to be very confusing.
> > People might then start trying to figure out whether the image was
> > created incorrectly, etc.
>
> "No foo image" means there is no image of type "foo image" at all.

Yes and that is the situation we have, isn't it?

>
> "Invalid foo image" clearly expresses that it is not an image that can
> be interpreted as "foo image".
>
> No clue what confuses you here.

'Invalid' means the image is invalid, not that it cannot be
interpreted in some way.

Perhaps x is not of type y ?


>
> Best regards
>
> Heinrich
>
> >
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   boot/image-fit.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/boot/image-fit.c b/boot/image-fit.c
> >> index 41ab1f552b0..856de6b731a 100644
> >> --- a/boot/image-fit.c
> >> +++ b/boot/image-fit.c
> >> @@ -2196,7 +2196,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> >>           */
> >>          if ((!type_ok || !os_ok) && image_type != IH_TYPE_LOADABLE) {
> >>                  fit_image_get_os(fit, noffset, &os);
> >> -               printf("No %s %s %s Image\n",
> >> +               printf("Invalid %s %s %s\n",
> >>                         genimg_get_os_name(os),
> >>                         genimg_get_arch_name(arch),
> >>                         genimg_get_type_name(image_type));
> >> --
> >> 2.48.1
> >>

Regards,
Simon
