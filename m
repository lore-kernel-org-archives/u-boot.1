Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0648CC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 17:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281AF88481;
	Mon, 26 Aug 2024 19:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lXaLRJPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D852B8852A; Mon, 26 Aug 2024 19:49:31 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41C688297
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 19:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf84c3d043so23812366d6.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724694568; x=1725299368; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/TVJyoVtNTn1TRfAoFlo+jIP2gpr7iPYBvM6qrLZfM=;
 b=lXaLRJPWOVZvzXepYXZVFu8axmuQN4VOmfMeMxdmRToYeCpyVxdEhfgBOiWpKSUHRs
 hP6NkOSzZnuK2G74ZRaEZ1+dNMaeL+9vy+BLIUr+ABDS8CEc/awGn/1uBgXoKMq+Qzjq
 uQCYHdkOMM4w68RtBZe51LwsMuIjv30OmNnIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724694568; x=1725299368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/TVJyoVtNTn1TRfAoFlo+jIP2gpr7iPYBvM6qrLZfM=;
 b=gxQKBsaH6SzJiZ/W7OScRfHTSpmA5QgK2WPhh67dgWrrHApyKBbHeM72/eJaGB6JCJ
 JWaaDT1/stSWqqKsl5UwGyPyKyoi0SWMC7iTJxYq1s5Ql2cn9MqEHQeOtqAH20buUGMm
 VVsziH8z0bntY9p+fiKq6yQqY7RpMzc6mG+6yKFXryE4Z1nCOVAmqmjSQbQjscERblM4
 Iqu4cHu+2057p/9xfkhIDu8YPAdXhc4oCQO684gaNWRZ2UNkYgRJ1zrZ22qYA3/SBs+p
 ZwgzbpOPCpXCgqWmi+6YrSXWqHtUsOedcrMfbJU9fVgth/mKmfFIqc4mky7R6NPzaz+c
 6MMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW/Lz5Cq5C3IzH32hEGntNjzZaFICbHpwHbO8pIZQcpyM2jT+wjEJ+Qv4WgGfOsVizu/DalT0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz68xCqHeZWXXmGLfGVRdQkR7rBp1Py2+41O4DtDKwgGZWHCLGT
 BK/1h4zujNiAuWSG/nl06a7OuCuIypjwJyeT/4D9a6c4hZvBMPRXovq88MH/lwiVx6C6VzvJrpF
 F/6CbO9LxgkeGkYcrxZDWY4lzvWwQpNB1MqxG
X-Google-Smtp-Source: AGHT+IGUf4KonLEQCMj33ifdCBd1pgkpegu5ySwAxu4cabVflB4epaXnA2xAC23N+N/8vXrmS3cKkvxhsLGFRaamgAA=
X-Received: by 2002:a05:6214:2f90:b0:6bf:7985:f46d with SMTP id
 6a1803df08f44-6c32b6a16f6mr2675066d6.12.1724694568445; Mon, 26 Aug 2024
 10:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <CANV2PTN_+9rZu0=XrNE+AUO3YRPCUjSHZy-Oe8WcXb_M-MiVTw@mail.gmail.com>
In-Reply-To: <CANV2PTN_+9rZu0=XrNE+AUO3YRPCUjSHZy-Oe8WcXb_M-MiVTw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Aug 2024 11:49:17 -0600
Message-ID: <CAFLszTjqKgMmm1kXgPYVCLnWP+SKUYv1Hym4-2sqkXthDVE6iw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootm: adjust the print format
To: E Shattow <lucent@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Eddie James <eajames@linux.ibm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
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

Hi,

On Sun, 25 Aug 2024 at 12:36, E Shattow <lucent@gmail.com> wrote:
>
> On Sun, Aug 25, 2024 at 5:26=E2=80=AFAM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > All three addresses printed are in hexadecimal format, but only the
> > first two have the "0x" prefix. The patch aligns the format of the
> > "end" address with the other two by adding the "0x" prefix.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >  boot/bootm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index 480f8e6a0e6e..951e549f19ff 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -703,7 +703,7 @@ static int bootm_load_os(struct bootm_headers *imag=
es, int boot_progress)
> >
> >                 /* Handle BOOTM_STATE_LOADOS */
> >                 if (relocated_addr !=3D load) {
> > -                       printf("Moving Image from 0x%lx to 0x%lx, end=
=3D%lx\n",
> > +                       printf("Moving Image from 0x%lx to 0x%lx, end=
=3D0x%lx\n",
> >                                load, relocated_addr,
> >                                relocated_addr + image_size);
> >                         memmove((void *)relocated_addr, load_buf, image=
_size);
> > --
> > 2.43.0
> >
>
> From U-Boot documentation, alpha-numeric input is assumed to be
> hexadecimal except when it is not, and generally does not accept "0x"
> prefix on input. So the correct action would be to make this
> consistent over the whole U-Boot code base, or remove the "0x"
> prefixes (not add more of them) ?

Yes, we should avoid these prefixes as they can confuse people into
thinking that hex is not the default.

In other cases where this is needed, for 0x you can use %#x

Regards,
Simon
