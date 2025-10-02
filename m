Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61218CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 08:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF806828A2;
	Thu,  2 Oct 2025 10:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="JOr+E2+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E6D834D4; Thu,  2 Oct 2025 10:22:56 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E97E80107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 10:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-57a292a3a4bso786780e87.3
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759393372; x=1759998172; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JItauYyt26EgKr83lTGCoZIVi7tATn/B2fEcvjemJto=;
 b=JOr+E2+3njEkb4B6SZgFYElbv5jWOCRT7sZExRRKw0WkFnyI8g8iaYPVOZtqCcWtjV
 PkJKAakKrWRZ7PTwVaaj2uyZNKmmjVEAWSTA7/94BeqDzzdjB8evjB9Zy99CJKGDL3CA
 1UUYigoGdCHA2SUEWIdrPxTV4IpUr2Om8Fyt4IXwtH7gNNDmJHmNkM9mRMNxka1hn85Y
 ZClq91p71vo8KGNU1vLnfGIOauJXDwOvQRiduMN0hvZTZdvVJjPNEIIhITt+ejGJxPsw
 dxb7h2kCaToK/4m5HZvGVAiX9OOZmeKM7ZMsjhYd/r5BHmTAoEuTkh08LWTSBs602qv7
 ZAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759393372; x=1759998172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JItauYyt26EgKr83lTGCoZIVi7tATn/B2fEcvjemJto=;
 b=iKri7P0SScQhMVxu1ajZabPaVyN8JXX1JuNsFhN9Omi2Yzc5klWsEeXa/1NfY7nNck
 lf5LE/BjgnktBTyLJIgm3GfRvR8RHyr5tJPgtRlxRvEmRNECJft5aJCi8n1V13uEAmrc
 y7MPTE+5nztcfS2gmVEA3ZzioXnSG4hG2zy5E39gu3GohCTvMzgsTJvWSaO38INmtCof
 kWkSrpoG0+4DICWNoFBHK6p4IKpu3Jkgfa43bGVCE+V1q4gyRDd8AXmqstPAvymZ1vqq
 HhtS0/IMrVHTNi4Bk9G2I+iLY25CzxcaAHrspYl/yA3vuxn7nHW+FV9QuYtPSACBmVQU
 iT9w==
X-Gm-Message-State: AOJu0Ywm7oW3d5RN/Pdu6ho63P/QdAeBjavDGQbJxhHZpFKmSaLodoZy
 n9OcG4Rj8ds5urJlB9Hza+VF9hFtM3qmjJxvEJbFtUkHs7s5WgcpCHB33T7b4VW8Z/co16QFFpu
 82wte/oGYSXdP/qqHd6QFJ01w1bWrdpE=
X-Gm-Gg: ASbGncvmYRz5EOEvD+hIFE4WoWIWk9mm9KwRoC5zAnePzkXY0YdUXhzcPGt+yPR7M7+
 Vn4GsftlpYVv9n1NlHBB1knPaN0/X/svIrIOp6YIsYquhtvf3Axn1fegWW3HSofiMV6+IKjb7+0
 fBZKE/3kVWNoMHHD1kj3yfM6EFS12HLAjLj58u3R+xpC0LoTCK8IIwmrRZ66mfMRZCQEOAWxIYY
 4cihprVe2k9ZqZ4DXhnfMH65a0dfuOy
X-Google-Smtp-Source: AGHT+IFm33oLmoQ09p9bSmGmTf0w7lDMRcDiIYVK1f3eOi4LnkiP2HYcTh5SAKfLLhxF32iwR0Ad+6fMM/iM9GltjGY=
X-Received: by 2002:a05:6512:31d2:b0:58a:f865:d794 with SMTP id
 2adb3069b0e04-58af9ee567dmr2054449e87.14.1759393372188; Thu, 02 Oct 2025
 01:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
 <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
 <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
 <CAGm1_kvnxrAHMRwffYki6Zr8g11G2Bmr1GKRPcFfFL1T7xa8-Q@mail.gmail.com>
 <CAFLszTjxyRknzscS1cG-=0jOnpzrTmn7LkHZsXknk5X+4v23gw@mail.gmail.com>
In-Reply-To: <CAFLszTjxyRknzscS1cG-=0jOnpzrTmn7LkHZsXknk5X+4v23gw@mail.gmail.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Thu, 2 Oct 2025 10:22:39 +0200
X-Gm-Features: AS18NWDLMIcqWQLs2PHDYSp4YBu3HH24qOf9-i34s_Uxl8dadU_Mu-fy8ECWsv0
Message-ID: <CAGm1_ksvdRh+9uEBiYDYKUzYmJUSdwhsMnG_GLHaAMrbET_CGw@mail.gmail.com>
Subject: Re: activity-led usage
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon and Marek,

On Wed, Oct 1, 2025 at 1:09=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Yegor,
>
> On Tue, 30 Sept 2025 at 08:48, Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
> >
> > Hi Simon,
> >
> > On Tue, Sep 30, 2025 at 4:13=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Yegor,
> > >
> > > On Tue, 30 Sept 2025 at 06:35, Yegor Yefremov
> > > <yegorslists@googlemail.com> wrote:
> > > >
> > > > On Tue, Sep 30, 2025 at 12:29=E2=80=AFPM Yegor Yefremov
> > > > <yegorslists@googlemail.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > I added the following LED definition to the am335x-baltos.dts:
> > > > >
> > > > >         leds {
> > > > >                 pinctrl-names =3D "default";
> > > > >                 pinctrl-0 =3D <&user_leds>;
> > > > >
> > > > >                 compatible =3D "gpio-leds";
> > > > >
> > > > >                 led-power {
> > > > >                         label =3D "led-red";
> > > > >                         gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;
> > > > >                         default-state =3D "on";
> > > > >                 };
> > > > >         };
> > > > >         user_leds: user-leds-pins {
> > > > >                 pinctrl-single,pins =3D <
> > > > >                         AM33XX_PADCONF(AM335X_PIN_MII1_COL,
> > > > > PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED *=
/
> > > > >                 >;
> > > > >         };
> > > > >
> > > > > The gpio-leds driver is working and I can toggle the led-red via =
the
> > > > > led command.
> > > > >
> > > > > Then, I created an am335x-baltos-u-boot.dtsi file with the follow=
ing content:
> > > > >
> > > > > / {
> > > > >     config {
> > > > >         u-boot,activity-led =3D "led-red";
> > > > >     };
> > > > > };
> > > > >
> > > > > I have also tried "led-power" instead of "led-red".
> > > > >
> > > > > In my final DTS files I have the following nodes:
> > > > >
> > > > >         leds {
> > > > >                 pinctrl-names =3D "default";
> > > > >                 pinctrl-0 =3D <0x56>;
> > > > >                 compatible =3D "gpio-leds";
> > > > >
> > > > >                 led-power {
> > > > >                         label =3D "led-red";
> > > > >                         gpios =3D <0x57 0x00 0x01>;
> > > > >                         default-state =3D "on";
> > > > >                 };
> > > > >         };
> > > > >
> > > > >         config {
> > > > >                 u-boot,activity-led =3D "led-red";
> > > > >         };
> > > > >
> > > > > U-Boot cannot find the activity-led node.
> > > > > ofnode_options_get_by_phandle("activity-led", &led_node); returns=
 -22,
> > > > > because ofnode_path("/options/u-boot") fails.
> > > > >
> > > > > When driver debug is enabled, I also see the following messages:
> > > > >
> > > > > bind node config
> > > > > Device 'config' has no compatible string
> > > > >
> > > > > My am335x-baltos-u-boot.dtsi code is similar to what I could find=
 in
> > > > > arch/arm/dts for the boot-led usage.
> > > > >
> > > > > Where should I debug further?
> > >
> > > It is a bit confusing as there is still 'legacy' LED stuff in the
> > > tree. For your problem I would suggest checking that the LED device i=
s
> > > configured correctly.
> > >
> > > For sandbox in test.dts you can see:
> > >
> > >     options {
> > >         u-boot {
> > >             compatible =3D "u-boot,config";
> > >             boot-led =3D <&sandbox_led_green>;
> > >             activity-led =3D <&sandbox_led_red>;
> > > ...
> > >         };
> > >     };
> > >
> > > Check that led_init() is being called in the LED uclass.
> >
> > It is working now using your suggestion. Thanks.
> >
> > > >
> > > > Should activity-led be also mentioned in doc/device-tree-bindings/c=
onfig.txt?
> > >
> > > We should be using /options/u-boot for this[1]
> >
> > This means, everything that can be found via the following command
> > won't work and should be removed?
> >
> > grep -r --include=3D'*.dts[i]' boot-led arch/arm/dts
>
> Yes. I did a series to remove the legacy LED stuff last year but it
> wasn't applied because people wanted me to do more, probably what you
> are looking at doing now :-)

This would be great if this patch series could be merged. Marek has a
board (arch/arm/dts/stm32mp157a-dhcor-avenger96-u-boot.dtsi) that can
be reworked too.

AFAIK, led_activity_blink() is used very seldom. For example, in
cmd/ubi.c it is only used for writing [1]. mmc is omitted completely.
Is this intentional or is this functionality just missing?

[1] https://github.com/u-boot/u-boot/blob/master/cmd/ubi.c#L494

Regards,
Yegor
