Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F7CCA1005
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 01:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A08F83390;
	Wed,  3 Sep 2025 03:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IbzysIv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 750FB833D0; Wed,  3 Sep 2025 03:15:02 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2743683071
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 03:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ad4f0so8101624a12.0
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 18:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756862099; x=1757466899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u4JNE1gQIn5YrVBRh99tu9O9Z7OiW+/15Ia8PBYBseI=;
 b=IbzysIv61S7Jxemkc1xjrundr04iw67xmBkwxdYKeyg+ykgpyYTq2kP2FoB34tvXrB
 /KoideK8GVexQ9UIn54dIGImSZ2X2BrQ7CFRu6OZGyoXcE1jEj5vzmsR5MQIfg/4NCLE
 FrMpfxx6KzZQxCnPepgtzM0UVdAKHfBQ1B/xb3SedEFJknSgI3FVpzzXXj2EF6c6lHy5
 J2KQGIxOXqnd9Ho/omEgPTu3qDjWfatoZnfrOZO0rm1TkG2b6PY5Au/xgRjL8NmmM9JQ
 jshXNPsIuag3iCR2oGsgz24K9hfju8AIm3To7lF+UC2jJM2i4Qr1SKXm+5oryPQoEW7H
 rw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756862099; x=1757466899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u4JNE1gQIn5YrVBRh99tu9O9Z7OiW+/15Ia8PBYBseI=;
 b=MV2Ac7iqdsD1AMoMYyqDPa/gBgm8kiByjjJmTPu7kVR2+bVMgiD4pqzZNSlBmxW8+3
 4Ll1iD+wVcDDpGQHAK6UKJbyGSA1WRbVSupVKxwKWuRaDHm9ElYzbkz+sjWM2BTQsUdz
 HH9ERzTDXbT0CoKTWmm/I5DjoA/frJNY0+p+vWYw2qju++R8ymAP+imSFkja6M53Mrwl
 LB1V3rxJWXDqJq5CXf7I6cp2P0v/ccaGr2wnZLl4fQvBQGaQGZiMm2GvEtl7LituxW5D
 CbUKECe1OP2vX+zDEhoVezyIbaaK0YS9YjSTcMySAn2+BehBUkiuP7mW6x6H+DwTjn3Q
 7zKA==
X-Gm-Message-State: AOJu0YyaBHG7ES9IdHa+RoQ6iP2KAahbdQGS8TZ5oFui43dTskAJegsh
 SmdsM+DkJacjHlF5NwdmSbRZblXZr4/axk6TuoI4lS7O8ipJf69oIJVgqkS9x0ZqCer0GZM8MrI
 D15+BDBhrTRQxVlGjO0Wp+Xm19g8aL+A=
X-Gm-Gg: ASbGncu2MKNm5OKuoC7g+1AtbRsjFrvJC4aqNRtcMDsWbYdwQkUsOeUar5wPdBwob0Z
 OQLLa6+NtPNKnTj/tnsYi17/nMI8F+wTt5t/vkxIu4EXNKvuNbGhKzN5Enynmr5Y3fHMWSsPPYb
 menjvSEanrOiaNwqrLR+Oxmaq9mOfFyuA9gz4rEFktXVgYrzF1SfX1u4ME+PJzG99G7ghkROwVu
 25tg4Kzb1nwmR453XVN7+/S0x750PStdBYGJhE=
X-Google-Smtp-Source: AGHT+IEmXtkbMd6YVXtVbdKtyT69JO/hL1b+KeevZdRqWmc02zvbpuM9RUru9Q3W6tw2xmyOKEaEcQ80biIHpCb0qFs=
X-Received: by 2002:a05:6402:3594:b0:61e:49dc:171f with SMTP id
 4fb4d7f45d1cf-61e49dc176fmr8174945a12.1.1756862099389; Tue, 02 Sep 2025
 18:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
 <20250827002317.GF124814@bill-the-cat>
 <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
In-Reply-To: <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Wed, 3 Sep 2025 02:14:48 +0100
X-Gm-Features: Ac12FXyifCkIBPWizosQ6q4-YeFSzByLx9VrBMuOcCMR8cq-MnAwFeIQv7wLVGM
Message-ID: <CACAHuLDZzgF1a7wG8fwNZ1YnUruPgyd9MifY2COS1kQFsqXsTw@mail.gmail.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
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

> On Wed, 27 Aug 2025 at 01:23, Tom Rini <trini@konsulko.com> wrote:
> > [...]
> > This is getting closer, yes. Looking at v6.16 in the kernel, it looks
> > like rsvg-convert is a pre-req for pdfdocs there, so we should adopt
> > that (and whatever general updates need to be done) as part of
> > supporting pdfdocs as a target. I was unaware until now just how
> > difficult adding SVG to PDF output was, sorry for the churn here.
> >
> [---]

In Linux, for SVG to PDF conversion they rely on an sphinx-build
extension: Documentation/sphinx/kfigure.py

This extension supports other formats and conversions.

However, for this translation to occur, in *rst files you have to use:

.. kernel-image:: file.svg

Instead of:

.. image:: file.svg

(Also: kernel-figure instead of figure. In U-Boot ".. figure" is never used.)

Funny or not, kfigure.py is present in U-Boot (doc/sphinx/kfigure.py)
and it is already set as a sphinx-build extension.

So, in principle, we "only" need to replace all ".. image" with "..
kernel-image" (65 occurrences / 17 files). However, I did that, and
got:

sphinx.errors.ExtensionError: Handler <bound method
ImageCollector.process_doc of
<sphinx.environment.collectors.asset.ImageCollector object at
0x79380051bbe0>> for event 'doctree-read' threw an exception
(exception: 'uri')

And I still couldn't figure out a solution. I'll keep looking.

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
