Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F2FCE7D10
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 11:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB57B89179;
	Tue,  1 Oct 2024 13:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lSbvQNxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24B78917A; Tue,  1 Oct 2024 13:19:37 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3689D89152
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 13:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7a99fdf2e1aso699912885a.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727781566; x=1728386366; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxZjLygKaRmNszIROKNe3KIqf1LaGiKJh78Li5/c6q0=;
 b=lSbvQNxYR21gpOvTbzGC1oCefh8hdA6crNqjVE1b7D2HhUyo22xfiNch230Ar/vB8q
 Ve6jy06sAv0EPwEOXbeigLVDj55lGji5nDpJt4Vlj6n8joHJLNBusGgO/k8fP0gkuWat
 jh3Zt4s38EPhRt8Gu+V4Dm9+hELjZ9JIVCcfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727781566; x=1728386366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QxZjLygKaRmNszIROKNe3KIqf1LaGiKJh78Li5/c6q0=;
 b=LMm73pYKHgXfLwvJov6tp7nr5G6v8SOynowCzNgRJtyUyzgvmLip0dt0tsdEl/lhqC
 G56LHsMmhKa3OEeMxz6M/OQhqfj65yDayYMbhV+N47LNNYucqibyrCSp+j4TFU8HbWUv
 B56EBvZx/0JO+QPUEbDwaNRCEUGntVDZtTCTDQPYUrFTvj7v5o1uPoZJg5hONTb8DWJs
 0C+U62omlis7Un9C9KaYX/Kxo7ACWfsM0jmaMR31m2p9fG7IvaYewaYT7cBgTga5zggA
 NUxOCIfPgK0ctO+4TU7YYg2Z/jPi6mB27WQ4FKBFnUuctM7TmfOaIA7vNi0wkLIjSHfo
 Exvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK375A1wuW7b9zS5lwOkliQbOjMXlw4mFAjbmVJV67goe0CFENA8/9W/b8zvDriMkXsSSw3GU=@lists.denx.de
X-Gm-Message-State: AOJu0YxRD/mwyxyTNsOM7IhH9e0BoMk32y8Y4+22oikmToDi31e8pPQ1
 Pvxkn19S69Lb79VmKvhWwTKVJbsO53MWw+wMX10/zQ0dMcDv1hJnvZP3p6Ne+9ICXf06eLAGNK5
 HdrIXpXwdluYiMqQaXjjS+0/E1CVtXF0lns+M
X-Google-Smtp-Source: AGHT+IHoeSibV9GlPKHSeu3hFr3bz0TV8bDAxLiWV7a/WtlC8sE/j2G6KENjnZ7Y+Zh7NCuwTwEC3Z1aGmIKy5C3MUw=
X-Received: by 2002:a05:6214:448c:b0:6c1:8663:e8f0 with SMTP id
 6a1803df08f44-6cb3b61465amr222487716d6.28.1727781566383; Tue, 01 Oct 2024
 04:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-3-paulk@sys-base.io>
 <CALeDE9NkpxES=SRKxH6=xk_94rRK9Y0gwuj=C-d+eddjOd_gkg@mail.gmail.com>
 <CAFLszTgqGGMm3Hxa2FmT9Z6-BFAR8J6cgb2PNBE8FR=S-X8c8A@mail.gmail.com>
 <Zvr29j1cyTNmq-RN@collins>
In-Reply-To: <Zvr29j1cyTNmq-RN@collins>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 1 Oct 2024 05:19:15 -0600
Message-ID: <CAFLszTi5dJejFqYeg2UpqnSjLbWphcZiCW8HUkXyrPH_cKVTKg@mail.gmail.com>
Subject: Re: [PATCH 3/4] rockchip: rk3399-rockpro64: Disable bootstage
 instrumentation config
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Chris Morgan <macromorgan@hotmail.com>, Tim Lunn <tim@feathertop.org>, 
 Paul Kocialkowski <contact@paulk.fr>
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

Hi Paul,

On Mon, 30 Sept 2024 at 13:07, Paul Kocialkowski <paulk@sys-base.io> wrote:
>
> Hi,
>
> Le Mon 30 Sep 24, 12:52, Simon Glass a =C3=A9crit :
> > On Mon, 30 Sept 2024 at 03:03, Peter Robinson <pbrobinson@gmail.com> wr=
ote:
> > > On Thu, 26 Sept 2024 at 19:32, Paul Kocialkowski <paulk@sys-base.io> =
wrote:
> > > > The boot timing and reporting (bootstage) infrastructure is useful =
for
> > > > performance analysis and debug but adds overhead and console noise =
when
> > > > using the device normally. Remove it from the device config.
> > > >
> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> > >
> > > This makes sense, for those that want this information will know how
> > > to build it for testing.
> >
> > Can you just disable the report? There should be no need to disable
> > bootstage itself.
>
> I see bootstage as a debug/development feature, so I don't really see why=
 it
> should be enabled on default builds.
>
> Besides the console noise aspect, my intent here is also to tidy up this =
config.

Well OK.

BTW one day I'd like to see bootstage be on by default, since it
provides a way to monitor boot times for devices. But that would need
some improvements: the current shared-memory approach between SPL and
U-Boot is not great and we could use bloblist instead. Also I'm not
sure how the information could be sent to the OS.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon


>
> Cheers,
>
> Paul
>
> > Regards,
> > Simon
> >
> >
> > > > ---
> > > >  configs/rockpro64-rk3399_defconfig | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > >
> > > > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64=
-rk3399_defconfig
> > > > index fc0804a0b80d..095d27ffaa04 100644
> > > > --- a/configs/rockpro64-rk3399_defconfig
> > > > +++ b/configs/rockpro64-rk3399_defconfig
> > > > @@ -19,8 +19,6 @@ CONFIG_SPL_SPI=3Dy
> > > >  CONFIG_SYS_LOAD_ADDR=3D0x800800
> > > >  CONFIG_PCI=3Dy
> > > >  CONFIG_DEBUG_UART=3Dy
> > > > -CONFIG_BOOTSTAGE=3Dy
> > > > -CONFIG_BOOTSTAGE_REPORT=3Dy
> > > >  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3399-rockpro64.dtb"
> > > >  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > > >  CONFIG_SPL_MAX_SIZE=3D0x40000
> > > > @@ -38,7 +36,6 @@ CONFIG_CMD_POWEROFF=3Dy
> > > >  CONFIG_CMD_USB=3Dy
> > > >  # CONFIG_CMD_SETEXPR is not set
> > > >  CONFIG_CMD_TIME=3Dy
> > > > -CONFIG_CMD_BOOTSTAGE=3Dy
> > > >  CONFIG_SPL_OF_CONTROL=3Dy
> > > >  CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigne=
d-clocks assigned-clock-rates assigned-clock-parents"
> > > >  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> > > > --
> > > > 2.46.2
> > > >
>
> --
> Paul Kocialkowski,
>
> Independent contractor - sys-base - https://www.sys-base.io/
> Free software developer - https://www.paulk.fr/
>
> Specialist in multimedia, graphics and embedded hardware support with Lin=
ux.
