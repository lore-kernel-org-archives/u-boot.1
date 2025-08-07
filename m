Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E368C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A08B845ED;
	Thu,  7 Aug 2025 17:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SKwTrnzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D328845EF; Thu,  7 Aug 2025 17:19:50 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF214845C5
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-31f02b6cd37so1291017a91.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754579986; x=1755184786;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z+cNLWQ931a1pVKN6P4o2iu2Up1YChnklEZpd/hIm84=;
 b=SKwTrnzmvibJBPxms8KR++up2xuWlMkDePWgNhIRAMKm5QvsDIqNZclIY6FrdxUMXe
 hrK7MIfKdDg3v8QmgvypO9OGTp3esQdM8Su90hWEH0jjQoF1s4LuR3gj1WpQ1mm52J4H
 9GeEHze+FIhB5D4+Mpngw8ISN3uVUbamQag6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579986; x=1755184786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+cNLWQ931a1pVKN6P4o2iu2Up1YChnklEZpd/hIm84=;
 b=FMtc78RY5TsJEUizVfuWPRfqrpP8L88emQ4jFyWrisfsFPQQPV0KNCBtnumTIN0NDi
 k2Vuf6Slhq4cxSb6PzGZe2tF0o2wvAgDK01MFllpjT1KPOSJs12Oag3lKaMPSK48qE/4
 /MOOAoTjk+Gv6nc9aVnfBNHg1oVAL5hxe+yt5epuwIfrQcbR+8wq/H5lsQn/pExhOM5E
 Ry5KvUFFFr/d+SFkWmHQpjcx/eyQYJSuKMQ6Qr9xUgxYLMdkwvPDPiHdG7m7GJuQ1vJo
 esUZ+DrJtyzjRecRLIEKWqDDXA5Cu1xkTceUGglq1VD5HH+RlrJNfKbnSO3HmIHOHfVN
 xX4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJNhAra4WZgFQhKqa7J3GAdUFKNJcKLMMHGVRBokO1Dn+ZTPop4XoVfk75MvatMiANNdjItDk=@lists.denx.de
X-Gm-Message-State: AOJu0YxiL7u0icxxjuYnJgn6I/rxPa0PJyZUkt40DTmmwSz4QzG5zC32
 iZA6ayIKQm6+4cPfgN+fW8Zn6RhUq5CJZraiXpVdoru7TmlcjyTyO+3bE6lh9ZsnZg2+vCUHRiM
 B2qpBtcsK5KrqgQvjn9Akn9pbstGCL2HXIrfd/nCyNw==
X-Gm-Gg: ASbGnctsMF8+80W5EnEQ3ulQdfTuikcABSm2eO6ts11rQw6TvyXnondKSGxio0GJzAn
 +2H3Fa1hPflQS1oDRvVWYOngy2yPp6z/187S1FgoY1ihlDBlxIcrsec/eqnjqLh8bzOt7N98KTD
 J2MG/z4oK2F38ero5GZZH5/Xui2rELlXTEK38BO2kjYnAfnqFon7kUsxJzwsJckdyAQnqnBw15G
 Za7cGwI
X-Google-Smtp-Source: AGHT+IGNfl7icc3RvJ7Vp45aMD0JvB8NLBMnSy1QEdzQQ/Qso72lMsniurkR1OTyhkAeEV09jZFxKGhEGOSHhSiOrD4=
X-Received: by 2002:a17:90b:1d4e:b0:321:3b47:cdc7 with SMTP id
 98e67ed59e1d1-321675924e5mr8890864a91.31.1754579985665; Thu, 07 Aug 2025
 08:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250701-mtd_nand_fixes-v1-1-f31517bdce2e@linaro.org>
 <0877def1-3ba3-4b97-a862-86c6db3f6b6c@linaro.org>
In-Reply-To: <0877def1-3ba3-4b97-a862-86c6db3f6b6c@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 7 Aug 2025 17:19:34 +0200
X-Gm-Features: Ac12FXzl0M05EmWD9RIHKi7eOcehKBMSPkX-Q1ZBD2WX-_3YsacKQCwEkeQwJiw
Message-ID: <CAOf5uwnz0Cj8rdFxs+o-YQE67b_h29YhGiAmjvLWn8V9Nrk-kQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: Prevent dereference of NULL pointer
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi

On Thu, Aug 7, 2025 at 5:01=E2=80=AFPM Andrew Goodbody <andrew.goodbody@lin=
aro.org>
wrote:

> On 01/07/2025 17:12, Andrew Goodbody wrote:
> > In nand_wait_ready there is a loop that includes a NULL check for
> > chip->dev_ready before it is dereferenced. Use a NULL check once the
> > loop is exited as well to cover the case where it exits due to a timeou=
t
> > and it is therefore not known if chip->dev_ready is NULL or not.
> >
> > This issue found by Smatch.
> >
> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> >   drivers/mtd/nand/raw/nand_base.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c
> b/drivers/mtd/nand/raw/nand_base.c
> > index d3d1b93947b..48e3685d995 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -566,7 +566,7 @@ void nand_wait_ready(struct mtd_info *mtd)
> >                               break;
> >       }
> >
> > -     if (!chip->dev_ready(mtd))
> > +     if (!chip->dev_ready || !chip->dev_ready(mtd))
> >               pr_warn("timeout while waiting for chip to become
> ready\n");
> >   }
> >   EXPORT_SYMBOL_GPL(nand_wait_ready);
> >
> > ---
> > base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
> > change-id: 20250701-mtd_nand_fixes-191e5a19932d
>
> Are there any comments about this patch please?
>
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

I will queue end of the week

Michael


> Thanks,
> Andrew
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
