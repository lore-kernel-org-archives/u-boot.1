Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9CFC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 05:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9197E80EB5;
	Wed, 29 Jan 2025 06:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RJkCXDVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B2380EEF; Wed, 29 Jan 2025 06:31:52 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03DE68082A
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 06:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michaelsunn101@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so1639335a91.2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 21:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738128708; x=1738733508; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dR4KYQCHqA1KPlMuBcOVo6odryCVctNPXqvZuL44/58=;
 b=RJkCXDVoFKQT8tRYBlq5Ejh1cQ0rsl4hgQb4/dG0MhfdOVYCBxN1QixCIw1LZgrueR
 FJwZjgG60ytcDYQUuHvuQ1zCoPdH2O9sJmnn+UNNSXVMy2C5WtCtWK2R0T8ajWHdCZMu
 ZgS0jy7gPY4F8wfJJjc2nEUPhsrcA3Eiya+nZmtVeAtT2aPg9W1YLpqqimSmiCd54tmT
 qy6Aa3eHZtZNqLiiUfKp7ntCt08gdG+rQfxMsLmtjBvG3mh3ZzpVabOl+s/OHgM90kXo
 Iro0x9gxU2pEt6OKPS1/TOlbopqoLpGxSiPKGAGEO8qkxxc1n1ViDlxs6sFJN272slGx
 xO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738128708; x=1738733508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dR4KYQCHqA1KPlMuBcOVo6odryCVctNPXqvZuL44/58=;
 b=QT41CKZIDIv6RbA+geFyGwP/nfnqR9lnfQ7+GJUi/XA/82yXOmWmbuyPE6spamge/V
 Y40vOnSYjKoZVPlutdmxBDLCDxV+/r5WXfRGr4Us2xOKjc4N+2FZaaASGJoSFhQQ0hpq
 vK3JdtKO816SoSNqE+XwvTXlIQ1QZ6TPd47+45ZSLfNBblOw11ecKsAi+Y0tbGGcoFay
 bpeepcZzZruadffAeK1ZjvmOHRi1HiWjnEvEcqQqOPiytsD8HuEHWoPnxdE5WZfQRpC1
 vgbRJbk7WqWGTDutuCDXKbWkmgEEvz3JowQBl3EHOAoxMlTC2TwvBDceysKYOL+rmMt5
 TlPw==
X-Gm-Message-State: AOJu0YyVkGdVFYNCcHSyNC64JwbxsKCmEOKKUecEW6d0EnmLPxzVYKa+
 IQ0Rz7OrD12QOIRtiFlqYI2lhVwbOXzPrSnEKxJILh25kZNA4erYuQAgldspKCplAlKWp/d9A6C
 mxGTOb0G6Ww3o3j3cryg4YhuAvw==
X-Gm-Gg: ASbGncvS2k8kyFxTPrVIXESEssnAuRjtzSRPElBtVlePEm0ID7y/QDuKwTZtzGdOu4+
 SI4lPT5WLZLKcQntYlFJL6zN0k1oJSbp+DKYTKSSz09EIFRaMaKYjGtsJj1bEUdKcIRz9OSmwPo
 1dLTXOy/C/EjyhB+1/3ZNq1ekAiiA=
X-Google-Smtp-Source: AGHT+IEcsb8Y+4sCzzCWSfdg1wjZA/pmdJy04owh9mb/G8Qdyoe8PS0DT5TBIcuZpgSz46JRV0/rHbKmDeNdfOCKCcU=
X-Received: by 2002:a05:6a00:3a01:b0:725:9cc4:2354 with SMTP id
 d2e1a72fcca58-72fd0be1847mr2645418b3a.10.1738128708242; Tue, 28 Jan 2025
 21:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20250128030945.1219589-1-michaelsunn101@gmail.com>
 <87o6zrqns9.fsf@baylibre.com>
In-Reply-To: <87o6zrqns9.fsf@baylibre.com>
From: Michael <michaelsunn101@gmail.com>
Date: Tue, 28 Jan 2025 23:31:37 -0600
X-Gm-Features: AWEUYZnYUtz6zuu2TXTCJdyziL1sPLD37LXLGlKO6aGW1pzCf-RqqYSU12AYvCM
Message-ID: <CAH40Y2gE1+EJcDgdny_Ed85pycF-0GaFATCXxRHNww9L2DLeFw@mail.gmail.com>
Subject: Re: [PATCH v4] usb: gadget: g_dnl: Fix NULLPTR dereference when
 serial# is unset
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Heiko Schocher <hs@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
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

Are there any other action items I should take care of?


On Tue, Jan 28, 2025 at 3:40=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Michael,
>
> Thank you for the patch.
>
> On lun., janv. 27, 2025 at 21:09, Michael Ferolito <michaelsunn101@gmail.=
com> wrote:
>
> > The current behaviour of this function will dereference a null pointer
> > if the serial# environment variable is unset. This was discovered on a
> > board where U-Boot did not have access to the first 256MB of ram,
> > resulting in a board crash.
> > In the event that U-Boot has full access to memory, it will still read
> > from address 0, which is probably not optimal.
> > This simple check is enough to fix it
> >
> > Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Heiko Schocher <hs@denx.de>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> > ---
> >  drivers/usb/gadget/g_dnl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
> > index 631969b340..f2540eb6de 100644
> > --- a/drivers/usb/gadget/g_dnl.c
> > +++ b/drivers/usb/gadget/g_dnl.c
> > @@ -207,7 +207,8 @@ void g_dnl_clear_detach(void)
> >  static int on_serialno(const char *name, const char *value, enum env_o=
p op,
> >               int flags)
> >  {
> > -     g_dnl_set_serialnumber((char *)value);
> > +     if (value)
> > +             g_dnl_set_serialnumber((char *)value);
> >       return 0;
> >  }
> >  U_BOOT_ENV_CALLBACK(serialno, on_serialno);
> > --
> > 2.48.1
