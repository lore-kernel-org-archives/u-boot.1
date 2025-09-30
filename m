Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A366DCCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 23:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5023807C0;
	Wed,  1 Oct 2025 01:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HFKrrDJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D5B881D6A; Wed,  1 Oct 2025 01:09:05 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEB8802C1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 01:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b3d50882cc2so595418466b.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759273741; x=1759878541; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62QemidKnscJhXl4V/pJGZb0GzZTISCblKt54/R6uQc=;
 b=HFKrrDJUE847MQtQkdBpRmR3LfgI7P6ut9/NxRG8GL+tXNNdcozzdXwagwvbkhGnQr
 VJhQmCZ+r3UFd/XsnCJY1srRvOFLtCh1veYdXAQaW5LJUW42v95VgTk2Uvlkf53XeX9y
 TqtUh4MeZng4OoZ72SIwGHbklWc/3u7Oj/Dnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759273741; x=1759878541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62QemidKnscJhXl4V/pJGZb0GzZTISCblKt54/R6uQc=;
 b=XwOA+hmf9KgQxTZnO6QwcCK/Mh8KIFbLq64gA61+HbvHq3npConEY3IQB2atMdVkM/
 lHDLY5WldB1Y3oL7xNkVpxEQAZiRfNaDwMTrz82ErI/cvEc3jZ/MkHjgA2srMuRP/cDj
 lmYOFdoEacovd5057ssyI2rMx33qcB85IlIwmyat+8G/K9sJ99NLHhOY8HxNUv6b6S3y
 d9e7HKumYRPACMSG9b0jQhOhbPvD+4dZltIj81oD3BYf7+lnB/oIxejVsIUGN1xyf8mn
 po+2PcOBNbl0ILWbpwpZ4Ii4KXZLghbM6tAy4LHNi57VvgnWeHNvkDF+GfZOkPpcqtEw
 ae1A==
X-Gm-Message-State: AOJu0YxOGArfjbSqyOkwApdu4l+7ESvYHaPDVNCslG8xysxZF7QuenmA
 d467GWkcDH4KhWSAWIR1QFYziDjBr8+zgSmBLT4m3rFo3yZGDRpeaVorMr4mqS3OhmT8lKZ1OcJ
 l9BnhuntSkNZXNhnt/hA3BYKVrDyte8Y+04vgaBM3IDLJgrVaEA8=
X-Gm-Gg: ASbGncuhLy6JsbNtt0OEYFQIfdwb4FgBYIlEDI3WETF9IRuErGngduldiZEJN40uI6K
 UZ5FNHdGoL4+QvKYKULq3U+F9vzwYGuWZqcce8CNtJsOYePVWgfZOSDaI66O5OiuwMKsiCzLH5d
 sJDMG1fLafi0pWUQrsggCPQ52S4mNRwKDhKL7+xlAZK/Xa5e6BnvttvOKNGpKDZflQGJq8sOtK+
 8709MjFUO4U62VulORUIebaMC3aIw==
X-Google-Smtp-Source: AGHT+IFeFGKWEG/pgEuw1CC9dsHBhgwjfRH+OU/zXDQ3kmhni5Sm/E5mv6H5BprNENDOLQNAAcVpFzkq792Z6qbS5bs=
X-Received: by 2002:a17:906:6a13:b0:b45:8370:ef10 with SMTP id
 a640c23a62f3a-b46e516a451mr140440066b.22.1759273740853; Tue, 30 Sep 2025
 16:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
 <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
 <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
 <CAGm1_kvnxrAHMRwffYki6Zr8g11G2Bmr1GKRPcFfFL1T7xa8-Q@mail.gmail.com>
In-Reply-To: <CAGm1_kvnxrAHMRwffYki6Zr8g11G2Bmr1GKRPcFfFL1T7xa8-Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Sep 2025 17:08:49 -0600
X-Gm-Features: AS18NWCtdjxI4Lhr5jniOu3hfEpu6e6NZJwrcoOgxuz1PjcS4MEZaOzDl5z970E
Message-ID: <CAFLszTjxyRknzscS1cG-=0jOnpzrTmn7LkHZsXknk5X+4v23gw@mail.gmail.com>
Subject: Re: activity-led usage
To: Yegor Yefremov <yegorslists@googlemail.com>
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

Hi Yegor,

On Tue, 30 Sept 2025 at 08:48, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
>
> Hi Simon,
>
> On Tue, Sep 30, 2025 at 4:13=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Yegor,
> >
> > On Tue, 30 Sept 2025 at 06:35, Yegor Yefremov
> > <yegorslists@googlemail.com> wrote:
> > >
> > > On Tue, Sep 30, 2025 at 12:29=E2=80=AFPM Yegor Yefremov
> > > <yegorslists@googlemail.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I added the following LED definition to the am335x-baltos.dts:
> > > >
> > > >         leds {
> > > >                 pinctrl-names =3D "default";
> > > >                 pinctrl-0 =3D <&user_leds>;
> > > >
> > > >                 compatible =3D "gpio-leds";
> > > >
> > > >                 led-power {
> > > >                         label =3D "led-red";
> > > >                         gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;
> > > >                         default-state =3D "on";
> > > >                 };
> > > >         };
> > > >         user_leds: user-leds-pins {
> > > >                 pinctrl-single,pins =3D <
> > > >                         AM33XX_PADCONF(AM335X_PIN_MII1_COL,
> > > > PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED */
> > > >                 >;
> > > >         };
> > > >
> > > > The gpio-leds driver is working and I can toggle the led-red via th=
e
> > > > led command.
> > > >
> > > > Then, I created an am335x-baltos-u-boot.dtsi file with the followin=
g content:
> > > >
> > > > / {
> > > >     config {
> > > >         u-boot,activity-led =3D "led-red";
> > > >     };
> > > > };
> > > >
> > > > I have also tried "led-power" instead of "led-red".
> > > >
> > > > In my final DTS files I have the following nodes:
> > > >
> > > >         leds {
> > > >                 pinctrl-names =3D "default";
> > > >                 pinctrl-0 =3D <0x56>;
> > > >                 compatible =3D "gpio-leds";
> > > >
> > > >                 led-power {
> > > >                         label =3D "led-red";
> > > >                         gpios =3D <0x57 0x00 0x01>;
> > > >                         default-state =3D "on";
> > > >                 };
> > > >         };
> > > >
> > > >         config {
> > > >                 u-boot,activity-led =3D "led-red";
> > > >         };
> > > >
> > > > U-Boot cannot find the activity-led node.
> > > > ofnode_options_get_by_phandle("activity-led", &led_node); returns -=
22,
> > > > because ofnode_path("/options/u-boot") fails.
> > > >
> > > > When driver debug is enabled, I also see the following messages:
> > > >
> > > > bind node config
> > > > Device 'config' has no compatible string
> > > >
> > > > My am335x-baltos-u-boot.dtsi code is similar to what I could find i=
n
> > > > arch/arm/dts for the boot-led usage.
> > > >
> > > > Where should I debug further?
> >
> > It is a bit confusing as there is still 'legacy' LED stuff in the
> > tree. For your problem I would suggest checking that the LED device is
> > configured correctly.
> >
> > For sandbox in test.dts you can see:
> >
> >     options {
> >         u-boot {
> >             compatible =3D "u-boot,config";
> >             boot-led =3D <&sandbox_led_green>;
> >             activity-led =3D <&sandbox_led_red>;
> > ...
> >         };
> >     };
> >
> > Check that led_init() is being called in the LED uclass.
>
> It is working now using your suggestion. Thanks.
>
> > >
> > > Should activity-led be also mentioned in doc/device-tree-bindings/con=
fig.txt?
> >
> > We should be using /options/u-boot for this[1]
>
> This means, everything that can be found via the following command
> won't work and should be removed?
>
> grep -r --include=3D'*.dts[i]' boot-led arch/arm/dts

Yes. I did a series to remove the legacy LED stuff last year but it
wasn't applied because people wanted me to do more, probably what you
are looking at doing now :-)

Regards,
Simon

[2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D431000&state=
=3D*
