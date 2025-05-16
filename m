Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FD2C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 20:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82FE982A8B;
	Fri, 16 May 2025 22:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQyBjNWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DF4782B18; Fri, 16 May 2025 22:05:03 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F738059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 22:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70c8e1927acso26427977b3.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747425899; x=1748030699; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ThKBs/48WUOAfWsSZ7cP2nbwr2OGD2xkFRU0Ql6PdGg=;
 b=fQyBjNWCchqdkSBOi/KcmYc3BXXU4d8vXMmw3hOqdxuRowoypy7+JEacjusknTKUmQ
 MfEdQbO7nywia/K2ReQ/O3wQH4hmPk0qt9/2HdclKefjZZn0U5iNgYm8KVWa2uEmIb5h
 4echj+EXPOqbojb6Eyfl3HBYJE5aok6jnxEEmHhPxkq101xx0G026oVxpPvnYbxZNBKS
 i3AuQei4Rcgq7yHplBjmcGNvUpLpJMW1ZkwVkJUKT2qymTzn/9LsYsk9yfuH2sxcH9wI
 js+iX6K2lQAN20tTgVccgfRZjZunJL0Ukh3jxXwsyRnqbG4x869De/dNbufvEaMUoh9G
 8Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747425899; x=1748030699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ThKBs/48WUOAfWsSZ7cP2nbwr2OGD2xkFRU0Ql6PdGg=;
 b=cKhg9Dhf5KkC+OdRnD8FVr0IUETqrrBfMRa96pVPOD5kkIJeu24uuyCwFTDZmpRHK+
 y0e+CM17Jsb7qimVxym333VqpWnzPJjL1TCnrSZHckAaZ9bhrk0g5o1AGhakNS0I8YnI
 9uJc514SSSmONyTwKt99DAe2KFzyKvSJb1wKMwJ/OFMzwv7ExGp4qEKc1MzUx4ic86Rj
 eQqgVuXODwJiy5O8u2ogjtLQOHyxmyZWFp59DhOVDvVNfCcjp6pXojPFztaQjnR5ngl6
 taytqmQkyiu1P1xtC0C7/gItP7Bww1ZIXmOPQJ+SJGzVQWIYDvJ6hCXgQtwnveCdO//V
 xzxg==
X-Gm-Message-State: AOJu0YytYNl62jYWNHX9FWXPt46MCCCf42PTMXsDTnyGuLBw8rd1wwJZ
 lyBF8GKXl7w/9Qq5cYj7xNj4wf5R49n1VV/LtYJUGB0ltNg9JT3RGK+HqDy1FuWYUfbkRHGiYAm
 i7RK8P2U/lx9OGSdphKurbRdGA8xLb5nAv4mgC84=
X-Gm-Gg: ASbGncsaAiGc9aIe7y7GG6aenJikhGDcCYKC9htyo0OVuH9mpR8eTZ4jvULgShDLArS
 5Xmf/6YtnWgm5QcYc2kxyvXwh8hUxkMWEowS7opxBVASNaGeUSoCrvlod2gX6p/2bnf7B6TLXmb
 5Fm0iCbJ6xTrEBeBM/K3spsmjMhUXXNX1aCjD7nCwhrIY=
X-Google-Smtp-Source: AGHT+IFv9mEKNsrMosWl0UoM+bbDBhZ3fepV3aejn5d21BFRirUB0g698ywNXPuV1TLCxDy30h1GNIdUNlGyGrqRIP4=
X-Received: by 2002:a05:690c:708c:b0:702:52fb:4629 with SMTP id
 00721157ae682-70cab0bb15bmr55437687b3.23.1747425899592; Fri, 16 May 2025
 13:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250516193618.153618-1-ant.v.moryakov@gmail.com>
 <CAOMZO5CG345_+wN81ADcBXMnHj2u309=dLDR-a-frMY9asZq4Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CG345_+wN81ADcBXMnHj2u309=dLDR-a-frMY9asZq4Q@mail.gmail.com>
From: Anton Moryakov <ant.v.moryakov@gmail.com>
Date: Fri, 16 May 2025 23:04:48 +0300
X-Gm-Features: AX0GCFtyp9CUueHfFcLLyuPRN-WZBhs-y3U0RzIdBkUZHeYBg8lIcaeSYVCX_4M
Message-ID: <CAHb2+K42QPR5+7jqpux5S6kJAn8gFuP_BaMiwXUomVbp=zZ7Tg@mail.gmail.com>
Subject: Re: [PATCH] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Fabio,

Thanks for the review. Yes, this is v2 =E2=80=94 the issue Tom pointed out
(unreachable `goto` after `return`) was fixed by replacing it with `result
=3D -EINVAL; goto err;`.

In v3 I=E2=80=99ve now removed the leftover comment. No other functional ch=
anges.

Best regards,
Anton

=D0=BF=D1=82, 16 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 22:59, Fabi=
o Estevam <festevam@gmail.com>:

> On Fri, May 16, 2025 at 4:43=E2=80=AFPM <ant.v.moryakov@gmail.com> wrote:
>
> > @@ -1557,6 +1557,7 @@ static int _ehci_submit_int_msg(struct usb_device
> *dev, unsigned long pipe,
> >                 debug("got wrong buffer back (%p instead of %p)\n",
> >                       backbuffer, buffer);
> >                 result =3D -EINVAL;
> > +               goto err;
>
> Was this supposed to be a v2? The error Tim pointed out is still here.
>
>      ret =3D _ehci_destroy_int_queue(dev, queue);
> > @@ -1565,6 +1566,10 @@ static int _ehci_submit_int_msg(struct usb_devic=
e
> *dev, unsigned long pipe,
> >
> >         /* everything worked out fine */
> >         return result;
> > +
> > +err:
> > +    _ehci_destroy_int_queue(dev, queue);  // =D0=9E=D1=81=D0=B2=D0=BE=
=D0=B1=D0=BE=D0=B6=D0=B4=D0=B0=D0=B5=D0=BC =D0=BE=D1=87=D0=B5=D1=80=D0=B5=
=D0=B4=D1=8C =D0=BF=D0=B5=D1=80=D0=B5=D0=B4
> =D0=B2=D1=8B=D1=85=D0=BE=D0=B4=D0=BE=D0=BC
>
> Please remove the comment.
>
