Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8D9E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F47803F0;
	Fri, 20 Dec 2024 18:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gji7rB3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5266280462; Fri, 20 Dec 2024 18:38:02 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E557680381
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so312761366b.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716279; x=1735321079; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e+qJ+qgsAZ3bk2RRoftmXtOqmwFivHjjBNVUIjB35Rw=;
 b=gji7rB3D6LPKCBkr5lHXKpAiPQL4sSR9RTXYm2hfzSUQ55kEeNrTFId9pTrX0c5hxC
 tPMHmEtj3IIrvSXeukwjd4vg2VJuagNbbgFBD9VRF1wtLvuVCi5pSI7nnzkm62sWXpAD
 SkNJGxvMbxTg+fZQdA9hyF+LO5jGqGYNY7544=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716279; x=1735321079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+qJ+qgsAZ3bk2RRoftmXtOqmwFivHjjBNVUIjB35Rw=;
 b=dDhRVGM4LmAswSiWcOFvbCSwCRqnGyF7+loSjO2wd7TCqvn+cALsPyP3NTwCnBUypN
 lu9Flhi4oH6hX4FSLX8RvB1gt3uBXILnSgCRDbqrr4IL4ZLZW9OqYpqMZi3uS6yRbxTI
 mS9Wfuk1nlMfY9GzhTQfCt0JArpmT21ms80B/79Yl0VbUAcDcVl0iqB8cQ0pCinlEkGX
 CUX4OD6fXPMLNGAYt3e/CdxV6dfiLu89Vxi5zvrg1XBIs/TJoH5NYCUEjeBAnezgq/Xf
 OApxvlv2Zk6NvGw7H45iyEWjuuRQ5rIU8ib5/stqWlCiCnYlJAeLpcBg+AHawuxLNOyT
 8Htg==
X-Gm-Message-State: AOJu0YwIl4fS9VXDrUOyvrimbRLfBfAbYDTaGdrLSNQWFKsi7D4cmE2F
 4rHKp7hogGafi6wuH1iUwPfOUavBgiWNcCE1DObleHDLlnwBUOkQJGIHPkAOeE33KDXlezEDtQS
 kwuakD5MzArCOBWAd7yvdFl5r8gBN2P3C/j+9
X-Gm-Gg: ASbGncudNJ9EMDwO7IGw5pcfdwdffHrb8Bi/R2ScFGXqL1piFUa0pwRcA88SIsbbejZ
 Q29Gb1/dL/XB9mmYKlLUtu4Dq9QQlS9i90RELqWs=
X-Google-Smtp-Source: AGHT+IFCvPK4e6h1bWe/tzRJKBLWEu3V+1UimXMqv1bPHrwpB4aAKsGOl6zMa+ASf0zJKc3ZWdeEmjf0FDwKapBqP+c=
X-Received: by 2002:a17:907:c2a:b0:aa6:79fa:b480 with SMTP id
 a640c23a62f3a-aac2713135bmr339914766b.10.1734716266970; Fri, 20 Dec 2024
 09:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-5-sjg@chromium.org>
 <20241220145609.GD1505244@bill-the-cat>
 <CAFLszTjzP+vm1YoUX_avNq4_4qnUtNzzjLyFocEhJYrCA7cGOA@mail.gmail.com>
 <20241220172348.GJ1505244@bill-the-cat>
In-Reply-To: <20241220172348.GJ1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:37:34 -0700
Message-ID: <CAFLszTjMWU7f_Db+qp6hFecx=mv+54ojX+zSZcrV-2CxT5dcxw@mail.gmail.com>
Subject: Re: [PATCH 4/5] pxe_utils: Support a backup for localboot
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Fri, 20 Dec 2024 at 10:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 20, 2024 at 10:18:17AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 20 Dec 2024 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 19, 2024 at 09:01:19PM -0700, Simon Glass wrote:
> > >
> > > > The current localboot implementation assumes that a 'localcmd'
> > > > environment variable is provided, with the instructions to follow. This
> > > > may not be included, so provide a fallback in that case.
> > > >
> > > > Add a test image and test as well.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > This is a pretty niche feature, I had to dig around a bit to see how
> > > it's specified elsewhere (not really) and how it's used. And I think
> > > that based on how it's used, making up a bootcmd when localcmd is
> > > undefined is the wrong approach. It's the hook for "run what I defined
> > > in the environment", so if not set erroring back out seems appropriate.
> >
> > Yes, but unfortunately it seems to be used and we should support it.
> > The problem with scripts is that we don't know the boot device, etc,
> > so it needs to be integrated into PXE. I did consider putting
> > something in bootstd, but we only find out that it is requesting a
> > localboot when actually running the extlinux bootmeth, so this is what
> > I came up with.
> >
> > It will be interesting to see if any other cases come up.
>
> It would be helpful at this point I think if you can point to how the
> code for handling this case (the LOCALBOOT keyword followed by an
> integer) in other projects so that we can be compliant with what's
> expected, even if it's poorly documented.

Yes, it seems very hard to find anything at all.

The implementation in syslinux uses the BIOS to jump to a boot sector:

https://repo.or.cz/syslinux.git/blob/HEAD:/core/bios/localboot.c

I'm really not sure how it is supposed to work with a filesystem.

[1] is a usage of it for rpi

But other than that, even Gemini doesn't seems to have much idea.

Regards,
Simon

[1] https://github.com/ppisa/rpi-utils/blob/master/u-boot-setup/boot/extlinux/extlinux.conf
