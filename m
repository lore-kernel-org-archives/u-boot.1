Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8D1D5D693
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3883288FE5;
	Thu,  7 Nov 2024 22:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EFoOU/q3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783B989072; Thu,  7 Nov 2024 20:34:05 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6FA8885D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 20:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5ceccffadfdso1769442a12.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 11:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731008043; x=1731612843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EiAodyChFL0tXP/vWzaCiE98JOzLepr/iD/RbOGoOF0=;
 b=EFoOU/q3VmDiUo5/NlZIGDWx3zB2RPuAR3DteszGgkMSpyrV34kjD/Pif0a5aWxoiV
 Wun7cKGZYASrGmZeE8hAT4uqF2bGv71ix6tVS2K4g89VxhZCM+DBX+EcVa6oSf257TNi
 AHLy/xKZCzxgJE/19d0QE6U9rNGm/kVglTuPIJCs42Oh6bHMLC8wNRxCWe4g+0sLSkGd
 4wZNUl7ZQj02zmVzM/XDf0vD/N+Patwwg2BSFxm0lTuylY2MptRySGLcQE+WMu2SKN4Y
 lp/veF4xLwjWbAU2x2KOaw6wyH623Y6f/7p24ji7bKR8LRPJoCRQUWHL29TOar7aBUyr
 5KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731008043; x=1731612843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EiAodyChFL0tXP/vWzaCiE98JOzLepr/iD/RbOGoOF0=;
 b=Td+05jYaP+31s7NYEuSEbZYHbjqlWoyxrFk1kvLiSQ26ueWYxFlDtCccTWgLKxkZNo
 VME7Z1VOuVK370RkdATWjKxCrV8zqoU2ZOuhZNqD7xE2+h5WzFf62z3l420slav/AjQ/
 JaqQNKS7pm6LqPNSw+NKQ2pSsmkrnKU9YhBblG63hleT1gDyyqsBsf5JweQ7cKDEfru3
 BzG4u7gu7brJcdGvhjLi4bcifG3ieESVfowqvMu9gdXb7g0vKQPB7VJUj4fmJk0aele4
 g7NNGXwgsatcl4FMjqHnbCLKWBw2ilIeuSfcLaqPRfl25nBG5UYHSWg4SYNiUFEY6kjA
 vFiA==
X-Gm-Message-State: AOJu0YziIl9CyFXqa5RDGi6QN/m8UghrSJpFu9bWO9GR/cc+tNe8MPk6
 xYnxZBhoigqndjjQr4BWJu2Iw1jdF3RdfUwbJ6tK04l7b/qO+2SRBRNMGaJbbpd2KEkcMn4xEMU
 B3+WKgwOFfRnGqzrI0fFXvdeXmWQ=
X-Google-Smtp-Source: AGHT+IFenJ3f2ne1pM3ufhCiRhvTedE3Q1cIkaLpTq+ZlW7vhDBi0Wypawkqm1DuLUaPchqM1dOtDXbwUXuGKs+d9i4=
X-Received: by 2002:a05:6402:2549:b0:5cb:ad37:4f60 with SMTP id
 4fb4d7f45d1cf-5cf0a44426bmr23615a12.26.1731008042752; Thu, 07 Nov 2024
 11:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
 <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
In-Reply-To: <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 7 Nov 2024 19:33:51 +0000
Message-ID: <CALeDE9MORdUY440JAgHNXdoqWfJy5V9bC=TK5U242QG4Lc1Ptg@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, 
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 07 Nov 2024 22:53:17 +0100
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

Hi Simon,

> On Tue, 5 Nov 2024 at 07:18, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > There has been an LED framework in U-Boot which uses driver model for
> > > about 9 years now. Recent work is underway to improve it and provide
> > > more features. It is probably a good time to drop the old code, which
> > > is only used by 5 boards:
> >
> > I don't believe, from what I can tell, they are feature comparable, at
> > the very least I have not been able to get the Pinephone working with
> > this so as it stands I still don't think this patch set is ready yet.
>
> I don't have that hardware, nor the other 4, so cannot do anything
> with this feedback.

Don't you have any HW that has a LED on it that you can substitute to
see what it does?

> Can you please be clear what you are asking me to do?

Either produce patches that work on the the pinephone, or docs I, or
other developers, can use to implement the functionality.

Currently on the Pinephone the green LED lights up in the TPL/SPL
(very early before ATF) stage and is lit up right through the the
various FW stages, with your patch set I get no LED what so ever.

Peter
