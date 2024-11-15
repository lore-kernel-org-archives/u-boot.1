Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6730D65C7E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF0F896C4;
	Fri, 15 Nov 2024 15:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MfNcimTE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43023896C0; Fri, 15 Nov 2024 15:22:08 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1707189658
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9e71401844so96516366b.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680525; x=1732285325; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=55+F4JTQWPBjt/s6M6n4HltehFA1N2xlVePzvfn010k=;
 b=MfNcimTEAlc3fw0KfPr8ZZY5/eNa3c+5t03xeGhHbKi+XLZJQKZBHpWj1BLqOmB9oL
 QJDyvtfDVOjzCtjV7fA3TghNK+5KXx8JLAoSc+MXWvm2TkxAZlLYdh0Q+PtDqu0HwK7e
 QKRQDl2TbKm+KXdNjhoiouvxljryRxix5Pg68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680525; x=1732285325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=55+F4JTQWPBjt/s6M6n4HltehFA1N2xlVePzvfn010k=;
 b=HZwEPuLQXmoonwG9gmzjOOeRqXRTf1z6dhyn71iJCIOiyXFma3EpHzj4FwH+Iup4wl
 UhSFdFILAALBhHs5aJWLulfGpiuKTMTXwddd23pnxdbfEyhXXBZBGYW60NJNsteAnDu8
 RWko5o77HT/sZjM56ZBuauMuWMdUbGUZ82S/XlMRv5E0V7+rPAdQVxfMph9Rw1eG/MZK
 LpeXFldTkU1D2eKpLxwHHz2Nb2PYyOS514LQLYMRlXZjP5L0jWuqNaRmTftHBrTB/mtB
 YNwmPDq6kJqeGJ9Zysn6b915fgDaSZ3QoJkHZQaz/KEFA+FpjfXyvMWCcfU/fVM8OhTO
 OqXQ==
X-Gm-Message-State: AOJu0YxX1Y4VoynulxIU+RWitXDgaUu93aVx+FyKDwMpiWJR/z8G468t
 d3ZvE3795geLfHJx+dedOkp93KTPO3RqGhbQUKPYtAQtm89jgiAd+BbbEMTn27e9BlTFBvwc98K
 /0V2GYoyRnsWCwm/AFH0ZWrM7D8k6Nz7ywW0k
X-Google-Smtp-Source: AGHT+IHvhCD7JEovjydHy266TYslXBTdvz+k50neKyOYRb+GAJIREf7g/it/ZgCtXm7B2zHykViHY4fNtYPxddW3hIY=
X-Received: by 2002:a17:907:809:b0:aa4:8af:4911 with SMTP id
 a640c23a62f3a-aa48344d9bcmr222106366b.26.1731680525464; Fri, 15 Nov 2024
 06:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-4-sjg@chromium.org>
 <20241113175017.GS3600562@bill-the-cat>
In-Reply-To: <20241113175017.GS3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:21:53 -0700
Message-ID: <CAFLszTjVgz7HxO8jrvVhGORbccGCN6HHMy7fWz=FJYKrfdyQ+g@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] efi_loader: bootstd: Drop bootmgr for sunxi
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

Hi Tom,

On Wed, 13 Nov 2024 at 10:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 13, 2024 at 08:09:33AM -0700, Simon Glass wrote:
>
> > This causes problems with the boot order, so drop it until we can figure
> > out a better way to know when bootmgr should be used.
> >
> > Link: https://lore.kernel.org/u-boot/20241112171205.4e80548d@donnerap.manchester.arm.com/
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I would really prefer a short summary of the contents of the link in the
> commit message. I'm not NAK'ing the patch as-is, but it would be helpful
> when revisiting this if there was a short explanation of the problem to
> solve here and not just "problems with the boot order". Thanks.

The summary is that sunxi supports FEL (USB boot) but bootmgr is not
aware of it, so boots the OS instead.

Regards,
Simon
