Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB09CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 09:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F8E80422;
	Tue, 14 Oct 2025 11:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="GIKVVoWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B001E8206E; Tue, 14 Oct 2025 11:35:00 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473C9802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 11:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59093250a7bso3801056e87.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1760434497; x=1761039297; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDm5ryImQc9srJfg7Ldm7Tk3MDRY6XA8GJy+nnyndPA=;
 b=GIKVVoWipIk8A5+OqWCNFOgvquX2CIFcnfNd5Z0xStcaWUzqqp8v9lyPga8LkRxdeb
 71LW881+74Gwo8ouDQ5qkEH7IGaELOpnkOvhiPJcxyiYdpaUxjx/124EbGQyS3J4F8bo
 D9vQyUJuouVVAPvfuA7maNYi3yh9Tzr9AbuVgurAueFOC7vkbhv0EoodtvAlES7mHm9b
 WPAQo3i6eNR7LeOZMD/zR39+MYOs4Ag1QIYnHJRKP5VGiteHPoR9fG25xKHy/iK4p5pK
 y95V+wEO2WV4qO8ACCOAR7+1FLFYWRwtQWka9/i+4/1iE6xpM/s7Bh751T7zJHpdvent
 3nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760434497; x=1761039297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDm5ryImQc9srJfg7Ldm7Tk3MDRY6XA8GJy+nnyndPA=;
 b=ednIs1yClNErPfWWNjwfurznf1lbmstS/wihhy6nJmPIhLmBCTvR5BFyFcVyx7Cwod
 kzIpBJ6bmAWyl+tSJMKpr90ulfTQLdDKtT1JXugFMgLxii9vNlOVAZlp5EXWQbbVGkSP
 qOhH75L9OsgMq12QDlCpQPhv9xv9Yu5gkW3yDOMFs9GUGNuqEgddtQKA5wCrqW1MPFUH
 iY/mR/g8Oz5BBxB2ETUusRYA2BgzCyk/k+A9HZcqrUo/67zSy7jXhVCqNF7BNal8xUtK
 B4fmkLTeGyZmk9cmrgAwBeH5CzlPdg9dkfR5dgn1Y0K3f8oWztj8NFz/uJ2dtofXr10P
 ZCzQ==
X-Gm-Message-State: AOJu0YwNwwuzeFpwgRQ2oP7RfhAeioYPL4pA7z1jV2eNK4D/W2GJfcxt
 732F+Kl400LcjEDeuQ6NG4RrozW9v2uzRetyZocizEqYTlhldUQUjmhDZgmpnEjnl7wc7QYnTWO
 EVoLsbP2NV988JijGNvYpTrFAjPeXvBWf1Iq2
X-Gm-Gg: ASbGncsZ7VbcVTzbZAJ3tz5zlo/OMLQkLu51htVATkAXRdpO9i8qX4uRgAWGJiu3flc
 BJeR9QQmLLjggcQddQE2811tpsOu5H6Wa4Y+LPbH9p53SuVLx5tCedFcGyrXxB1Gv+p8+f3AAwn
 nTBPDmUVbFE40d5orYe1E0WKg/GXg2PWeCre3eAb2j+SCjy3bCMiiGeipVNVwh2NNQEbz8xlts9
 YIf7/o41ESdyEiB5ZmoNUzyvcQ=
X-Google-Smtp-Source: AGHT+IFaUqRlNpU1knLe62xEzCOXW7PD2h7ujuPSN/22MLu3Ip3eiopIUw58O4Wqeu+1juqOT4GJh9e1TP5D1g4/rkQ=
X-Received: by 2002:a05:6512:1315:b0:560:9993:f14d with SMTP id
 2adb3069b0e04-5906db0ce60mr6945732e87.3.1760434497355; Tue, 14 Oct 2025
 02:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251013130902.74719-1-yegorslists@googlemail.com>
 <DDHQS4TT6S6Y.1N61MTMFVTJBP@ti.com>
 <CAGm1_ktEZBu+MRThxW_BMF-S3qqPQ0AErArDoLGjC4qwTse9fw@mail.gmail.com>
In-Reply-To: <CAGm1_ktEZBu+MRThxW_BMF-S3qqPQ0AErArDoLGjC4qwTse9fw@mail.gmail.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Tue, 14 Oct 2025 11:34:42 +0200
X-Gm-Features: AS18NWCE-dlyUynlTseJt7c_NZ1qV2HvdNHuejNUTDZ11-tfGYhvBkUhR2nYbeE
Message-ID: <CAGm1_kv=cUG1JQu=XKOS2bWJao3Qe9m23Aojt-6GT0d_CH=inQ@mail.gmail.com>
Subject: Re: [PATCH] arm: baltos: enable TI_SYSC and CLK drivers
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

On Tue, Oct 14, 2025 at 11:28=E2=80=AFAM Yegor Yefremov
<yegorslists@googlemail.com> wrote:
>
> Hi Anshul, Tom,
>
> On Tue, Oct 14, 2025 at 5:58=E2=80=AFAM Anshul Dalal <anshuld@ti.com> wro=
te:
> >
> > Hi Yegor,
> >
> > On Mon Oct 13, 2025 at 6:39 PM IST, yegorslists wrote:
> > > From: Yegor Yefremov <yegorslists@googlemail.com>
> > >
> >
> > Could you explain a bit more about why this change is needed in the
> > commit description?
>
> Both are required for GPIO drivers to work. At least, for the OF setup.
>
> Should I add this description or can we embed them as dependencies for
> CONFIG_OMAP_GPIO?

This is what I get when TI_SYSC is enabled but CONFIG_CLK_TI_CTRL driver no=
t:

ti_sysc target-module@7000: failed to get fck clock
ti_sysc target-module@4c000: failed to get fck clock
ti_sysc target-module@ac000: failed to get fck clock
ti_sysc target-module@ae000: failed to get fck clock

If only TI_SYSC is missing, then GPIO won't work but without any error outp=
ut.

P.S. I still don't have an answer to this question [1]

[1] https://lists.denx.de/pipermail/u-boot/2025-September/599390.html

> Regards,
> Yegor
>
> > Regards,
> > Anshul
> >
> > > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > ---
> > >  configs/am335x_baltos_defconfig | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_=
defconfig
> > > index 5c43503ff32..93a5fb94adf 100644
> > > --- a/configs/am335x_baltos_defconfig
> > > +++ b/configs/am335x_baltos_defconfig
> > > @@ -53,8 +53,9 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
> > >  CONFIG_VERSION_VARIABLE=3Dy
> > >  CONFIG_NET_RETRY_COUNT=3D10
> > >  CONFIG_BOOTP_SEND_HOSTNAME=3Dy
> > > -# CONFIG_TI_SYSC is not set
> > >  CONFIG_BOOTCOUNT_LIMIT=3Dy
> > > +CONFIG_CLK=3Dy
> > > +CONFIG_CLK_TI_CTRL=3Dy
> > >  CONFIG_DM_I2C=3Dy
> > >  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> > >  CONFIG_SYS_I2C_EEPROM_ADDR=3D0x50
> >
