Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C31D3B98E
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 13:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3005E89C60;
	Tue, 26 Nov 2024 14:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZHWlJmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C5D89C6D; Tue, 26 Nov 2024 13:00:52 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1020489C4E
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 13:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ffc81cee68so16888661fa.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 04:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732622449; x=1733227249; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2SCebXF3Sfj6hPX7SaJAuUL2pLKNvpzPo+W/AN/zrI=;
 b=UZHWlJmQYLU2wMAA4tlPLvPeFOTC18Loas19vGePZYYzhb1PKXhxJvo+ER21Rp4rB5
 lA4tdciqzLq5B9vNmDiItL0nIS7rhltGrXQPZ2xFXY8ZPwro/iXW/amDoKcJK0EvyCxA
 HvLB5PBsFcGjXLK7xyEnGec+/MKapbM/d/3IFT44ndA4q3uN0soYJZjeC7pYUUCvaZl/
 3l6iUkBpIH4SAf2JKLZgIN2V7Uilpq3dZ2E33lffllJlFYOUn37NZlNBRBp/YMmXkqRm
 hpeCRS6lOcVZabVPJD/GpaVnpaQPhWzUMhPFPNa45/VqA5yDFiJmHuX8xN/FlLZ3FB2Y
 gHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732622449; x=1733227249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2SCebXF3Sfj6hPX7SaJAuUL2pLKNvpzPo+W/AN/zrI=;
 b=NjIDOH3LZiimauKRCx33juVyXZ0SLwq0G7sxNE4Mi7UAGZ8ylEONHKjUqd3uCAV5hg
 LZDwcqfQjobL+RwwJpp3NIANCCFhBEq+Tp5xGQMpx4NBpkBrr4icC8CnpaL23hsuFSwb
 he1mjA8ACB9ZjTa0pVZNgy4VpwMPj1FwuOb2tmJh1ujjQyBBlgeJDwCXgDm/u/W9361x
 H29XNKAEKXkEzDRtTDeZ6IvsNYrkYXN6tJ5WVBJOt2k+AwNOqM0aJHX74OJWON/YUure
 vuAP6kJwYRieZlpuMpSMln7ggTDEoKkTLvEuflmFUz4hnBpWZDbIFi67fCdkNh+yqxaO
 bAfg==
X-Gm-Message-State: AOJu0Yxxuz4VUFUj3qqXVy+h2rjQg1nEM9UPWa9B21yJOwcZRtDxuY6V
 iSN+4JeaUrXQseFzc/oERmDNjphe8mgYQYULC4tINP437lL3NVMt020XufZ0ZS+WpUpZniZ8I3/
 G2tq3Tp9vUSaCB9qeh9ra8z+WxUcD5A==
X-Gm-Gg: ASbGnctT4HbHhh1Rg2qH+k3mwwFaAsW+zDBYC33APdwe8opOtoUE/mYsaUO6ZVXzcPH
 gUV1QKNkoTYvVtQIhh2i5uH43NdI1QBj/tu3eGn2CWyQR022/43mlMaBaiVvvn5k=
X-Google-Smtp-Source: AGHT+IFBq1Ba+pvp9DJMmVfssYh28J7IKlNQrvr8FIV11Lxwwv8gkU8WQ2JqykNQ/EGZ9RQhCpZKpONJXnnfUO7CRUw=
X-Received: by 2002:a2e:a5c6:0:b0:2ff:a246:f94e with SMTP id
 38308e7fff4ca-2ffa711baeemr65909731fa.12.1732622449025; Tue, 26 Nov 2024
 04:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20241123165304.100538-1-hs@denx.de>
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Nov 2024 09:00:37 -0300
Message-ID: <CAOMZO5CBzszzyecV1mf=Dv97MJ91xuDVWM+Uv+_30nPcgh_X_A@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] imx8qxp: siemens board: updates / sync with
 mainline
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, 
 Adam Ford <aford173@gmail.com>, Alessandro Zini <alessandro.zini@siemens.com>, 
 Anatolij Gustschin <agust@denx.de>, Andrej Valek <andrej.valek@siemens.com>, 
 Baruch Siach <baruch@tkos.co.il>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 CL Wang <cl634@andestech.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Chanho Park <chanho61.park@samsung.com>, Fabio Estevam <festevam@denx.de>, 
 Francesco Dolcini <francesco@dolcini.it>, Gary Bisson <bisson.gary@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ramon Fried <rfried.dev@gmail.com>, Randolph <randolph@andestech.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, 
 Troy Kisky <troy.kisky@boundarydevices.com>, Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 26 Nov 2024 14:09:03 +0100
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

On Sat, Nov 23, 2024 at 1:53=E2=80=AFPM Heiko Schocher <hs@denx.de> wrote:
>
> Updating the imx8qxp based siemens board. The current
> state of the siemens imx8qxp board is in an old not
> really working state.
>
> This series brings mainline back working on the siemens
> deneb board, the guedi board is dropped as not longer used.
>
> make all runs fine without having all the needed firmware images
> on board, and so CI @azure.
>
> If you want to have a working image you need to copy the
> following images to your build directory $BDIR:
>
> ATF : bl31-imx8dx.bin            -> $BDIR/bl31.bin
> AHAB: mx8qxc0-ahab-container.img -> $BDIR/mx8qxc0-ahab-container.img
> SCFW: deneb-scfw-tcm.bin         -> $BDIR/mx8qx-mek-scfw-tcm.bin
>
> and call make flash.bin
>
> There are also updates for ethernet and USB support, but not
> ready to push upstream currently, hopefully following soon.
>
> Azure build:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D139&view=3Dresul=
ts
>
> series is based on mainline commit:
> 7fe55182d92 ("Merge tag 'xilinx-for-v2025.01-rc3-v2' of https://source.de=
nx.de/u-boot/custodians/u-boot-microblaze")
>
> Ah yes, not to forget, we work at siemens also on a CI setup to
> have a mainline nightly build and test on hardware. We already
> have such a CI for internall U-Boot versions up and running, but
> we do not want again loose sync with mainline.

Applied all for -next, thanks.
