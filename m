Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B60C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 10:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F3683015;
	Thu, 29 May 2025 12:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e20EucIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526368301F; Thu, 29 May 2025 12:43:23 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A9C82FD6
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 12:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-604bde84d0fso1066367a12.3
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748515400; x=1749120200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g/uURSBBBWdEBqsLEqR0qhVYGcG7CqntyWj0JcxgV6g=;
 b=e20EucIzJwi9ZxftA3iqMStws9sv1d434+7XLjdu+brt9bn0bVTZKxcNHGY7hdElLa
 2g47fLEb6J1ESDHokAbX9e+vbW/ZFNpGA46kMqhJB5WbWriXm5R3PBpi6sz3tWKZRw96
 B/JXmGlbN5Qnh9iMCU5hDAuYIg4ZzNBm+zXKKS/VAw5wsbce71V5QojPMJlX4H9DNivH
 KD/VC02G1ouzs0mgnxsYORrl+YasOX95XkxJ0bsnoNe0YSO7yX5G63jDyAFLnw5fQlfK
 5+/T8Inwbz/7XXy9kKqpq7pKfBuMWKK33gxjGtlqHV9colmMB3GmLysgolZJv9GvKN8p
 L7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748515400; x=1749120200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/uURSBBBWdEBqsLEqR0qhVYGcG7CqntyWj0JcxgV6g=;
 b=gNyFzG81hHc9UkDfQiHiAchQKGDy7a8Dcza3fFwLA4pKMv5Z5oOWOMU0Dlo0dwElcr
 Bf9f49JJ4niVKAvEOXZSYTicmgY7/QBvksD2lxU6CowZzJuwXxQZzAh6FxLcw2Xrs10Q
 ZbyuY86BVMYJsgU7NkEYA9uy+GY5PFmpX/eWi+x1OcOAJv6VGSzyEWaKDG/9kx9iBZ5E
 hb4xMjzFf78JA/TJ0jhCqOlc4+ImCs71VGnrEq3FF0mu7sCCa2C4YCaM+4xMkT2oED1A
 SEvMmdTMxHzHJ8XunqnLWK/ycQ1RGWfFS//Q/DtFKSGHnJl3mFt2Bc06NIzQQyEEZK+z
 ojng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB+hlPxtxuOggo8+n5xovG+WmUCi9OIRUhyTnFmjpV+eTl4paNcG4mSaHt4TOydetBbeAdJ1o=@lists.denx.de
X-Gm-Message-State: AOJu0Yxn6jjOTTwxoWmX5tKaul/ZfmSyXoyTdaVHVaGFZSV0I/9hZnWX
 IhaNsr6VOor7XTHiWwnLdqJGJ9iB+H2hFB2RRO8YDjdat9Mavv16q33vtVZEWNHRomHNLKTOknG
 fnc60N0IIRenITTCHUNLBCMiW1ngv5m0=
X-Gm-Gg: ASbGnct2hWCsvk1WrFm922jArtiXRjJlJvJUptvRR1WBVpvSHC9MthLRDjZcNcJawG9
 gR37lpTN4xmNbai0DqsAw1SXQ33EGNcFgUIUKOGvn2t/+1YhN9YBlUZXAW2O0KRZpU/tuSJIgzW
 F+gYM8+mPlpUmdvnw66+NA598I8ZFaEoFcbCV/AYplNgSbf73XQoX6HSjFRhz6lB0tL4vDKUfJ3
 XUL
X-Google-Smtp-Source: AGHT+IG0w1TOvAFoJymA4FYetALeNlX2pmOuGY17AB2bCdcPjjhva/D+lsF0okNeI8UcIDUq4zleUpHBTd1SoyKV8uY=
X-Received: by 2002:a05:6402:1eca:b0:5fa:8277:3d5c with SMTP id
 4fb4d7f45d1cf-60546621da4mr1074308a12.30.1748515400223; Thu, 29 May 2025
 03:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250525121102.415770-1-pbrobinson@gmail.com>
 <20250527150004.bniix33re7os2lqj@lcpd911>
In-Reply-To: <20250527150004.bniix33re7os2lqj@lcpd911>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 May 2025 11:43:09 +0100
X-Gm-Features: AX0GCFvIZaC-3esFUHcb253KtomTPC4oWogOXT2R-WpOifEroNRyyTbCRpZASh4
Message-ID: <CALeDE9MC8it9HEABvW58Gspyh+d2ods=5bQhjKdoN52um8ViOA@mail.gmail.com>
Subject: Re: [PATCH] doc: board: ti: Add missing firmware for BB-AI64
To: Dhruva Gole <d-gole@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, 27 May 2025 at 16:00, Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Peter,
>
> On May 25, 2025 at 13:10:58 +0100, Peter Robinson wrote:
> > The details of the sysfw.itb from the R5 build that
> > also needs to be copied as part of the target images
> > is missing, but is included in the image formats a
> > little further down, so add it to the instructions.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  doc/board/beagle/j721e_beagleboneai64.rst | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/doc/board/beagle/j721e_beagleboneai64.rst b/doc/board/beagle/j721e_beagleboneai64.rst
> > index 090b2b3b86a..a57bc743569 100644
> > --- a/doc/board/beagle/j721e_beagleboneai64.rst
> > +++ b/doc/board/beagle/j721e_beagleboneai64.rst
> > @@ -83,6 +83,7 @@ Target Images
> >  Copy the below images to an SD card and boot:
> >
> >  * tiboot3-j721e-gp-evm.bin from R5 build as tiboot3.bin
> > +* sysfw-j721e-gp-evm.itb from R5 build as sysfw.itb
>
> Thanks for adding this, and I am okay with the changes.
>
> But also, does it make sense to make all of this inherit from a label that
> we can add inside [1] and include that here directly?
> I am okay if you just wanna label the gp part and include it here as
> well.

I'm guessing you're referring to doing something with markdown in this
context, I apologise but I am far from a markdown expert here, I think
possibly including it may make it less readable for those using a
terminal but I may have also completely missed your point here, maybe
that could be done as a follow up :)

> Either way,
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>
> [1] https://docs.u-boot.org/en/latest/board/ti/j721e_evm.html#target-images
>
>
>
> --
> Best regards,
> Dhruva Gole
> Texas Instruments Incorporated
