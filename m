Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E114EC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 14:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFCE787E77;
	Wed, 28 Feb 2024 15:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LeShNRdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1957587E28; Wed, 28 Feb 2024 15:14:58 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C823A8804F
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 15:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c199237eaeso3422580b6e.0
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 06:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709129693; x=1709734493; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iVylWXYiDpGxzqtN8CxjaNkFAnkDNuTgf9qhzuh1fU=;
 b=LeShNRdgJjamXPGRv66hm1UQDch3VtJ0wJ/3OZOK7io1mH1goev2aNDiQgPJKSCikp
 CExKoPXJ7fn4D33vmR5otnnYgpYpsGxZvA8T23bjJCeYaSHVtjSDwUxckGtZcys5B3Wo
 w4nK00IJbpi2vpawmopZpVlnTCUaD4Y/QUXbRBfZ0lnT8zvziNv+fnlH3070k3zaoq9f
 leMSHGZHOmi0nLyO2q+UXSTn3cFVsi6EwEDiMG9OuU+gUgdfZHXr7M+Bs0CLNnTB0liz
 aIrdwDpNGWXS/Yk7mqdaYdZ38dlB8RTkU3eRBNhGmBCp7UB7Nr1lWKkXCQkAwts+6gh+
 5Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709129693; x=1709734493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iVylWXYiDpGxzqtN8CxjaNkFAnkDNuTgf9qhzuh1fU=;
 b=DuoWcsvAEVgS3eO3dK9vjeD9AsJnx4/pMiSqwwRi6iX9iX4FeNNZrE492MNs5kcenb
 2q67fmO3I+1xZ9NcTMx3nfcUbDWn6uEF8l7Rnvrg4Py0z57mUpqwLpBht95m+mPrX/LA
 PZN+WCDhgPIx5HVSwvmd/pV2nsOhtJWy7rXxzlSQRhSN2fQ42ejT/CG46lGnpHRlTCpI
 hfponAq57r79AgeDl49j4uw2YorqTIHZKMCcrGaZih76YTpvOG7F/BAmY/08Dnivd22P
 lxz8O12dEkWGdeN0KtgsyNz5c734ISb+SsJ8viI/9CLYND7AjjNyCAemjYDVLZdrHZuZ
 yIww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX0YDeaUI7mWVmwIotO97SHy7Xh/4jdzemNMeIQSXcHKB1iG3SBKMshYPtJ8WkxaIFyf7AyTlPTXZOTYENwCEtM+Cddg==
X-Gm-Message-State: AOJu0YzVVLhpNhHfy6jIJg+NLQVJBH6O63kuZnOqba/ZbomKJ+xK1cKO
 93Z3kBXPMnHgLBsgngDxgHxhOQDhboauW+LKe5/oS5R3VB8toRVBA8z5HZ7BCwK0B2zJJgn+udh
 MmgZbkOmC0LqWosgEwbcKU+hPKNFj+TaSsLlkVw==
X-Google-Smtp-Source: AGHT+IEG12NkHzPwCIImMBX2n+dBM29VOt7QROnps0i49LOGg55c1VbSJ0anWqJlcVeaPQEUJH/jGtviWNvpNTsoepE=
X-Received: by 2002:a05:6808:1308:b0:3c1:7012:3505 with SMTP id
 y8-20020a056808130800b003c170123505mr6084562oiv.39.1709129693411; Wed, 28 Feb
 2024 06:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
In-Reply-To: <20240228131029.GM3040305@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 28 Feb 2024 19:44:42 +0530
Message-ID: <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
To: Tom Rini <trini@konsulko.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, shawnguo@kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Rob Herring <robh@kernel.org>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
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

+ Shawn, Krzysztof, Conor

Hi Tom,

On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wrote:
> > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=C3=A9bastien Szymanski wrot=
e:
> > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with
> > > linux") removed the display timings from the board device tree wherea=
s
> > > they are still needed by the mxsfb driver.
> > > Add the timings back (the correct ones) in the
> > > imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> > > opos6uldev.env file.
> > >
> > > Update the opos6uldev_defconfig file so that the LCD turns on at boot=
.
> > >
> > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with l=
inux")
> > > Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus=
.com>
> >
> > Huh.  This is the commit that did that upstream.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> >
> > It's interesting how the timings in linux were always slightly differen=
t
> > from in u-boot.
>
> Thanks for tracking that down, Dan. I'm adding in Sumit and Rob here
> because this is a recent (rather than ancient) example of one of the
> concerns about OF_UPSTREAM.

I rather think about this as an opportunity to improve with
OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
corresponding Linux kernel sub-arch maintainers. Especially once we
move to OF_UPSTREAM and a sub-arch maintainer profile in Linux kernel
to keep them aware that U-Boot should be considered too.

> I think the commit in question can be
> summarized as "remove a bunch of explicit HW information because there's
> now a Linux Kernel driver that determines that dynamically". What do we
> do next? The old information is in a presumably valid binding still, can
> we just put it back and comment that consumers outside of Linux use this
> still so it's not removed again later? Or am I just missing where we can
> instead get this information from the DT still and not need to come up
> with a new driver and subsystems?

I can see following two paths forward:

1) Partially revert the Linux kernel commit to add back the display
timings in DT.
2) Extend drivers/video/simple_panel.c in U-Boot to add support for
compatible: "armadeus,st0700-adapt".

If possible then I would be in favour of (2) rather than the current
patch to do this properly.

-Sumit

>
> --
> Tom
