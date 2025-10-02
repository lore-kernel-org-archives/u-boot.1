Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEE0CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE824828A2;
	Thu,  2 Oct 2025 13:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="b+B/hcal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3ABB835A2; Thu,  2 Oct 2025 13:37:07 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B0281D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57f1b88354eso849739e87.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759405024; x=1760009824; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pkofvIClT9T9EQDIa1Bbg7c7HPTcUGiaiy10W6n6bM=;
 b=b+B/hcalhH0t0Rzg2zgHqKNfaKel9CFerU8Vb7lcDTJOE7ud4sKzgx4jZ7ryp2EOaB
 sKDbXi4OMZL3Cb5nUVEGRzmyLaOzbFv9uE616TPeunazaTCI3QwtHuexCOYj9jiTg+O4
 MKGY+GQ2AfoeSPDsk9KuAVbGKnEMZKluh3fM/NIXMYiV2NwYImFLzs/rg6NoqZVCYvJf
 tyhLiKBcEPjFC3zpyjVz9r38Bp3A2QWWwCS+TTdVz477x8j8K+XlhdSyzKTFCPZgDk5d
 Sk1NoRxoLuN0GIi2K8FdIWhRK1h4SMiAlad2GRx9FLMaQPAoP8kdrCqocE66E/wA9iUs
 GcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759405024; x=1760009824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pkofvIClT9T9EQDIa1Bbg7c7HPTcUGiaiy10W6n6bM=;
 b=t2UInVoGp+KYHQUbQ8cp5Th+J9yLim7/wy5fGzbDpYkm30YAj3e4WmdKaBA9izQ+cP
 6Win9PMyntgsFumnqhpRcazoVS/aUb4aE4dB5gEHRVl0T08jpXp6qzivzuNh2vVimmCS
 SaYTuuR1J2QiO5c0IpRXOuPv3fwtDMnBrb+Y6P8+h61em8t+1rxCNrbI2/Cc6GXMQFFW
 zdDqQpkGphsexopOHSTzH6LuYC4dpw5T2tjnhi8MG4Cood9YGU8ceRTd0J3Pi0/khsC3
 vNVSkQY9KNPYCQLAZzF785wZAoGF2ej16CB51dmHbjBvtuLKhkhxD0/k1S+HltzQc99k
 5LPQ==
X-Gm-Message-State: AOJu0YzUzRUEiGJpxt7SwuoQJfoj+hmgN409iDR8hBYN/meoWUvRhyGc
 gdHsEaJbYVXzqDzP8doOoVO5Y4BqWBP9ccLiUgaFfiqYsz8QvagBh8sy2/gzaanYh3H80C6CBpI
 gsi9uMhWljHzJaPbIU32LiLS1SVz8RE8=
X-Gm-Gg: ASbGncu5NqXw5tanrKI6Zw11+8kj+A9vvQQGDyNS3UozLajdvCxMIQ1ovsCTlBRwL4n
 /oOvafR+UPhR4m/8fYOF8yo8Jx4BTepOB0YuYqMsY1w1YewV2ngBmG/HDZq/3753XiPxD7uM3v9
 rNk9LcZS5r1+JV+vV8kiomsNllGdW2VTtnevrqhd3Zld+1mHBXKEXaRar+uW3nupbsgH3jIP2+w
 igmJmtMzobv9BZmIVCW2oQVuPmXIHhVmnxgCsHOazw=
X-Google-Smtp-Source: AGHT+IEhah5BwPuMg1trzoygPFrgnXQm0AXcYjhyFTpRjd8BhD+Nf919ko7YKKAP0Erm0dW/kpZqmuJxNnPIUfYjz9M=
X-Received: by 2002:ac2:51c6:0:b0:57f:3f75:9b1d with SMTP id
 2adb3069b0e04-58af9f7a4bdmr2355848e87.56.1759405024133; Thu, 02 Oct 2025
 04:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
 <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
 <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
 <CAGm1_kvnxrAHMRwffYki6Zr8g11G2Bmr1GKRPcFfFL1T7xa8-Q@mail.gmail.com>
 <CAFLszTjxyRknzscS1cG-=0jOnpzrTmn7LkHZsXknk5X+4v23gw@mail.gmail.com>
 <CAGm1_ksvdRh+9uEBiYDYKUzYmJUSdwhsMnG_GLHaAMrbET_CGw@mail.gmail.com>
 <afc99b8a-b50f-95ac-a763-8487e68f8c73@nabladev.com>
 <CAGm1_ksBZn6s27crrvNfuEcAjCNWyZfmm8h8uPyc0LXkiYLKkg@mail.gmail.com>
 <75a1d11d-00d9-e272-85c6-99494d5fab5d@nabladev.com>
In-Reply-To: <75a1d11d-00d9-e272-85c6-99494d5fab5d@nabladev.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Thu, 2 Oct 2025 13:36:52 +0200
X-Gm-Features: AS18NWBKz6hCYch27f5NnKdebwr1OCDGbrZ7zEA4Nswp8qemngmFi61kdcTfLB8
Message-ID: <CAGm1_kuP+o54vPt9DhVEpvcZr++qW2FF1nSW_qx1+Lhmm6wjog@mail.gmail.com>
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

On Thu, Oct 2, 2025 at 1:30=E2=80=AFPM Heiko Schocher <hs@nabladev.com> wro=
te:
>
> Hello Yegor,
>
> On 02.10.25 13:28, Yegor Yefremov wrote:
> > Hi Heiko,
> >
> > On Thu, Oct 2, 2025 at 10:26=E2=80=AFAM Heiko Schocher <hs@nabladev.com=
> wrote:
> >>
> >> Hello Yegor,
> >>
> >> On 02.10.25 10:22, Yegor Yefremov wrote:
> >>> Hi Simon and Marek,
> >>>
> >>> On Wed, Oct 1, 2025 at 1:09=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> >>>>
> >>>> Hi Yegor,
> >>>>
> >>>> On Tue, 30 Sept 2025 at 08:48, Yegor Yefremov
> >>>> <yegorslists@googlemail.com> wrote:
> >>>>>
> >>>>> Hi Simon,
> >>>>>
> >>>>> On Tue, Sep 30, 2025 at 4:13=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> >>>>>>
> >>>>>> Hi Yegor,
> >>>>>>
> >>>>>> On Tue, 30 Sept 2025 at 06:35, Yegor Yefremov
> >>>>>> <yegorslists@googlemail.com> wrote:
> >>>>>>>
> >>>>>>> On Tue, Sep 30, 2025 at 12:29=E2=80=AFPM Yegor Yefremov
> >>>>>>> <yegorslists@googlemail.com> wrote:
> >>>>>>>>
> >>>>>>>> Hi all,
> >>>>>>>>
> >>>>>>>> I added the following LED definition to the am335x-baltos.dts:
> >>>>>>>>
> >>>>>>>>           leds {
> >>>>>>>>                   pinctrl-names =3D "default";
> >>>>>>>>                   pinctrl-0 =3D <&user_leds>;
> >>>>>>>>
> >>>>>>>>                   compatible =3D "gpio-leds";
> >>>>>>>>
> >>>>>>>>                   led-power {
> >>>>>>>>                           label =3D "led-red";
> >>>>>>>>                           gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;
> >>>>>>>>                           default-state =3D "on";
> >>>>>>>>                   };
> >>>>>>>>           };
> >>>>>>>>           user_leds: user-leds-pins {
> >>>>>>>>                   pinctrl-single,pins =3D <
> >>>>>>>>                           AM33XX_PADCONF(AM335X_PIN_MII1_COL,
> >>>>>>>> PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED =
*/
> >>>>>>>>                   >;
> >>>>>>>>           };
> >>>>>>>>
> >>>>>>>> The gpio-leds driver is working and I can toggle the led-red via=
 the
> >>>>>>>> led command.
> >>>>>>>>
> >>>>>>>> Then, I created an am335x-baltos-u-boot.dtsi file with the follo=
wing content:
> >>>>>>>>
> >>>>>>>> / {
> >>>>>>>>       config {
> >>>>>>>>           u-boot,activity-led =3D "led-red";
> >>>>>>>>       };
> >>>>>>>> };
> >>>>>>>>
> >>>>>>>> I have also tried "led-power" instead of "led-red".
> >>>>>>>>
> >>>>>>>> In my final DTS files I have the following nodes:
> >>>>>>>>
> >>>>>>>>           leds {
> >>>>>>>>                   pinctrl-names =3D "default";
> >>>>>>>>                   pinctrl-0 =3D <0x56>;
> >>>>>>>>                   compatible =3D "gpio-leds";
> >>>>>>>>
> >>>>>>>>                   led-power {
> >>>>>>>>                           label =3D "led-red";
> >>>>>>>>                           gpios =3D <0x57 0x00 0x01>;
> >>>>>>>>                           default-state =3D "on";
> >>>>>>>>                   };
> >>>>>>>>           };
> >>>>>>>>
> >>>>>>>>           config {
> >>>>>>>>                   u-boot,activity-led =3D "led-red";
> >>>>>>>>           };
> >>>>>>>>
> >>>>>>>> U-Boot cannot find the activity-led node.
> >>>>>>>> ofnode_options_get_by_phandle("activity-led", &led_node); return=
s -22,
> >>>>>>>> because ofnode_path("/options/u-boot") fails.
> >>>>>>>>
> >>>>>>>> When driver debug is enabled, I also see the following messages:
> >>>>>>>>
> >>>>>>>> bind node config
> >>>>>>>> Device 'config' has no compatible string
> >>>>>>>>
> >>>>>>>> My am335x-baltos-u-boot.dtsi code is similar to what I could fin=
d in
> >>>>>>>> arch/arm/dts for the boot-led usage.
> >>>>>>>>
> >>>>>>>> Where should I debug further?
> >>>>>>
> >>>>>> It is a bit confusing as there is still 'legacy' LED stuff in the
> >>>>>> tree. For your problem I would suggest checking that the LED devic=
e is
> >>>>>> configured correctly.
> >>>>>>
> >>>>>> For sandbox in test.dts you can see:
> >>>>>>
> >>>>>>       options {
> >>>>>>           u-boot {
> >>>>>>               compatible =3D "u-boot,config";
> >>>>>>               boot-led =3D <&sandbox_led_green>;
> >>>>>>               activity-led =3D <&sandbox_led_red>;
> >>>>>> ...
> >>>>>>           };
> >>>>>>       };
> >>>>>>
> >>>>>> Check that led_init() is being called in the LED uclass.
> >>>>>
> >>>>> It is working now using your suggestion. Thanks.
> >>>>>
> >>>>>>>
> >>>>>>> Should activity-led be also mentioned in doc/device-tree-bindings=
/config.txt?
> >>>>>>
> >>>>>> We should be using /options/u-boot for this[1]
> >>>>>
> >>>>> This means, everything that can be found via the following command
> >>>>> won't work and should be removed?
> >>>>>
> >>>>> grep -r --include=3D'*.dts[i]' boot-led arch/arm/dts
> >>>>
> >>>> Yes. I did a series to remove the legacy LED stuff last year but it
> >>>> wasn't applied because people wanted me to do more, probably what yo=
u
> >>>> are looking at doing now :-)
> >>>
> >>> This would be great if this patch series could be merged. Marek has a
> >>> board (arch/arm/dts/stm32mp157a-dhcor-avenger96-u-boot.dtsi) that can
> >>> be reworked too.
> >>>
> >>> AFAIK, led_activity_blink() is used very seldom. For example, in
> >>> cmd/ubi.c it is only used for writing [1]. mmc is omitted completely.
> >>> Is this intentional or is this functionality just missing?
> >>>
> >>> [1] https://github.com/u-boot/u-boot/blob/master/cmd/ubi.c#L494
> >>
> >> The commit which introduced this says:
> >> """
> >> commit 990f726ce797c040adda6d1e1bc6a21bd2b28657
> >> Author: Christian Marangi <ansuelsmth@gmail.com>
> >> Date:   Tue Oct 1 14:24:41 2024 +0200
> >>
> >>       ubi: implement support for LED activity
> >>
> >>       Implement support for LED activity. If the feature is enabled,
> >>       make the defined ACTIVITY LED to signal ubi write operation.
> >>
> >>       Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>       Reviewed-by: Simon Glass <sjg@chromium.org>
> >> """
> >>
> >> So, at that time it was intentional ... yes ... but I ask me, why
> >> we do not use this LED also on read operations...
> >
> > So, in other words, patches are welcome :-)
>
>  From my side: Full Ack.
>
> May we should ask "Christian Marangi <ansuelsmth@gmail.com>"
> if there are some special reasons for only adding it to the write
> command.

I have just sent a patch and  included Christian Marangi in CC.

Yegor
