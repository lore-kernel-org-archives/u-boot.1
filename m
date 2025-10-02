Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713F0CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF947828A2;
	Thu,  2 Oct 2025 13:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="LJate/lF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4FE8328F; Thu,  2 Oct 2025 13:28:20 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3519B81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-58afb2f42e3so1071357e87.2
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759404497; x=1760009297; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCeX4x49mfa//fnCP/cqRsGwVmoxyBM9DFmTyhEKxN8=;
 b=LJate/lFrpOEiyENoy5ak/mR8OQ+KrA7g2H/rHx4c4yNmH7o0GWlBt+fjMskAL8zPM
 CE3ld0SEIBwt8H6Qob36cTPh249myUIG+vbkdkicC1RJS1q5PawBnU4aAuXX/Us+HvGP
 VFE2arFe2WmBfQ/gww6MaCnPOrYBAjax0K3123Zn28HSSJ8GzfWTuIbkxM7vb+b6Xnim
 ASQtr9QCx6049dPBjhrgmtB/9541YxL3/3Z9nqD2eFbCTWDFnwdBNclOJjJWGCdmEsBs
 /5N3RloNL8BVJEC/NbQSTIq1ktPXvqhIheqKd+bX6RhnRDZ2y4uMJzPyRRla3UORRK4X
 JL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404497; x=1760009297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCeX4x49mfa//fnCP/cqRsGwVmoxyBM9DFmTyhEKxN8=;
 b=DEq0vNJarjLRk296HdxVeENhAho48/rKWzjl6IxVe3xs6k1SLNOzC/zTkf2xQDzelq
 RwQvARW6aa04DYfQJnR3yrtLG8iwli/puLu0MtVLjZJozW+JIyaBWc+9y29Rf2xsMFv6
 z2hTD8gBd8H69xXaAK4nP9PLuy5/gHH19WE+SUIlWbOS07kJVppOo9Zfpgh6uQpW7rVC
 PCf4YUwWhxlwPelKnQlasQsY0ka9DmUTJNB2tcVzY+QQECDiu9x1eNKOjRR2NyUyul5y
 RZpBqItKz/wHYWtA2wRPr09CJiuayb3oG7OCgrxTBJTBnS4eO/HqXg9KqYV0bwBFQVST
 NH5A==
X-Gm-Message-State: AOJu0YyTm4vIRjAAh2NbVhdcYtO04+U3EQcBAiBJOvloww04Q8OVBzJV
 UMNSe9MUjet7oTAmU1OAH8IFTU14e7TB4PexqfN2k8/uhWrEcwXaL1jVgT3HIKgHsy1hsMV7g+e
 SIwBLD9os7DPZeV714EnGiM+UrKO+4V4=
X-Gm-Gg: ASbGnctSeZYGG7TZOriFy+tO148VuGoPQE3L8316rNaxpuhNWjXviogXkKmWOn7gqIf
 1NfTy2UNAyhsbzm05HsX3T44Rw8Q2rIyhEgLLCgMWz+SMSZpDrM46KZePsmCdTl/nEYZSd1hcSR
 kUkCU29x58PHuLbbOsCtDLg6d7zCqHTp+0Ixc2+7gkymiSR63SzVjGLldASAFp9//mHB1e//NH7
 mfortOUYiZAVvB07ux3s8cvqXalcVho
X-Google-Smtp-Source: AGHT+IGk+dMdsQE9w1p1YkcC7PY5+9qRuTM/EAy3hgf1RiLjYsaPNY2us6vNCF8xbNIDEmq9ZwPA8jSoLxiKEzHNH3o=
X-Received: by 2002:a05:6512:10d4:b0:568:af14:8a59 with SMTP id
 2adb3069b0e04-58af9f6af3cmr2185858e87.28.1759404497125; Thu, 02 Oct 2025
 04:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
 <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
 <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
 <CAGm1_kvnxrAHMRwffYki6Zr8g11G2Bmr1GKRPcFfFL1T7xa8-Q@mail.gmail.com>
 <CAFLszTjxyRknzscS1cG-=0jOnpzrTmn7LkHZsXknk5X+4v23gw@mail.gmail.com>
 <CAGm1_ksvdRh+9uEBiYDYKUzYmJUSdwhsMnG_GLHaAMrbET_CGw@mail.gmail.com>
 <afc99b8a-b50f-95ac-a763-8487e68f8c73@nabladev.com>
In-Reply-To: <afc99b8a-b50f-95ac-a763-8487e68f8c73@nabladev.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Thu, 2 Oct 2025 13:28:05 +0200
X-Gm-Features: AS18NWDZCpfMdnzdxf7pDsY1nqupMZxv7N0XR3B8dxdwT1soA7Q8nyrbmX9QmwY
Message-ID: <CAGm1_ksBZn6s27crrvNfuEcAjCNWyZfmm8h8uPyc0LXkiYLKkg@mail.gmail.com>
Subject: Re: activity-led usage
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
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

Hi Heiko,

On Thu, Oct 2, 2025 at 10:26=E2=80=AFAM Heiko Schocher <hs@nabladev.com> wr=
ote:
>
> Hello Yegor,
>
> On 02.10.25 10:22, Yegor Yefremov wrote:
> > Hi Simon and Marek,
> >
> > On Wed, Oct 1, 2025 at 1:09=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >>
> >> Hi Yegor,
> >>
> >> On Tue, 30 Sept 2025 at 08:48, Yegor Yefremov
> >> <yegorslists@googlemail.com> wrote:
> >>>
> >>> Hi Simon,
> >>>
> >>> On Tue, Sep 30, 2025 at 4:13=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> >>>>
> >>>> Hi Yegor,
> >>>>
> >>>> On Tue, 30 Sept 2025 at 06:35, Yegor Yefremov
> >>>> <yegorslists@googlemail.com> wrote:
> >>>>>
> >>>>> On Tue, Sep 30, 2025 at 12:29=E2=80=AFPM Yegor Yefremov
> >>>>> <yegorslists@googlemail.com> wrote:
> >>>>>>
> >>>>>> Hi all,
> >>>>>>
> >>>>>> I added the following LED definition to the am335x-baltos.dts:
> >>>>>>
> >>>>>>          leds {
> >>>>>>                  pinctrl-names =3D "default";
> >>>>>>                  pinctrl-0 =3D <&user_leds>;
> >>>>>>
> >>>>>>                  compatible =3D "gpio-leds";
> >>>>>>
> >>>>>>                  led-power {
> >>>>>>                          label =3D "led-red";
> >>>>>>                          gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;
> >>>>>>                          default-state =3D "on";
> >>>>>>                  };
> >>>>>>          };
> >>>>>>          user_leds: user-leds-pins {
> >>>>>>                  pinctrl-single,pins =3D <
> >>>>>>                          AM33XX_PADCONF(AM335X_PIN_MII1_COL,
> >>>>>> PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED */
> >>>>>>                  >;
> >>>>>>          };
> >>>>>>
> >>>>>> The gpio-leds driver is working and I can toggle the led-red via t=
he
> >>>>>> led command.
> >>>>>>
> >>>>>> Then, I created an am335x-baltos-u-boot.dtsi file with the followi=
ng content:
> >>>>>>
> >>>>>> / {
> >>>>>>      config {
> >>>>>>          u-boot,activity-led =3D "led-red";
> >>>>>>      };
> >>>>>> };
> >>>>>>
> >>>>>> I have also tried "led-power" instead of "led-red".
> >>>>>>
> >>>>>> In my final DTS files I have the following nodes:
> >>>>>>
> >>>>>>          leds {
> >>>>>>                  pinctrl-names =3D "default";
> >>>>>>                  pinctrl-0 =3D <0x56>;
> >>>>>>                  compatible =3D "gpio-leds";
> >>>>>>
> >>>>>>                  led-power {
> >>>>>>                          label =3D "led-red";
> >>>>>>                          gpios =3D <0x57 0x00 0x01>;
> >>>>>>                          default-state =3D "on";
> >>>>>>                  };
> >>>>>>          };
> >>>>>>
> >>>>>>          config {
> >>>>>>                  u-boot,activity-led =3D "led-red";
> >>>>>>          };
> >>>>>>
> >>>>>> U-Boot cannot find the activity-led node.
> >>>>>> ofnode_options_get_by_phandle("activity-led", &led_node); returns =
-22,
> >>>>>> because ofnode_path("/options/u-boot") fails.
> >>>>>>
> >>>>>> When driver debug is enabled, I also see the following messages:
> >>>>>>
> >>>>>> bind node config
> >>>>>> Device 'config' has no compatible string
> >>>>>>
> >>>>>> My am335x-baltos-u-boot.dtsi code is similar to what I could find =
in
> >>>>>> arch/arm/dts for the boot-led usage.
> >>>>>>
> >>>>>> Where should I debug further?
> >>>>
> >>>> It is a bit confusing as there is still 'legacy' LED stuff in the
> >>>> tree. For your problem I would suggest checking that the LED device =
is
> >>>> configured correctly.
> >>>>
> >>>> For sandbox in test.dts you can see:
> >>>>
> >>>>      options {
> >>>>          u-boot {
> >>>>              compatible =3D "u-boot,config";
> >>>>              boot-led =3D <&sandbox_led_green>;
> >>>>              activity-led =3D <&sandbox_led_red>;
> >>>> ...
> >>>>          };
> >>>>      };
> >>>>
> >>>> Check that led_init() is being called in the LED uclass.
> >>>
> >>> It is working now using your suggestion. Thanks.
> >>>
> >>>>>
> >>>>> Should activity-led be also mentioned in doc/device-tree-bindings/c=
onfig.txt?
> >>>>
> >>>> We should be using /options/u-boot for this[1]
> >>>
> >>> This means, everything that can be found via the following command
> >>> won't work and should be removed?
> >>>
> >>> grep -r --include=3D'*.dts[i]' boot-led arch/arm/dts
> >>
> >> Yes. I did a series to remove the legacy LED stuff last year but it
> >> wasn't applied because people wanted me to do more, probably what you
> >> are looking at doing now :-)
> >
> > This would be great if this patch series could be merged. Marek has a
> > board (arch/arm/dts/stm32mp157a-dhcor-avenger96-u-boot.dtsi) that can
> > be reworked too.
> >
> > AFAIK, led_activity_blink() is used very seldom. For example, in
> > cmd/ubi.c it is only used for writing [1]. mmc is omitted completely.
> > Is this intentional or is this functionality just missing?
> >
> > [1] https://github.com/u-boot/u-boot/blob/master/cmd/ubi.c#L494
>
> The commit which introduced this says:
> """
> commit 990f726ce797c040adda6d1e1bc6a21bd2b28657
> Author: Christian Marangi <ansuelsmth@gmail.com>
> Date:   Tue Oct 1 14:24:41 2024 +0200
>
>      ubi: implement support for LED activity
>
>      Implement support for LED activity. If the feature is enabled,
>      make the defined ACTIVITY LED to signal ubi write operation.
>
>      Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>      Reviewed-by: Simon Glass <sjg@chromium.org>
> """
>
> So, at that time it was intentional ... yes ... but I ask me, why
> we do not use this LED also on read operations...

So, in other words, patches are welcome :-)

Regards,
Yegor
