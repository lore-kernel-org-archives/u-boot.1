Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC09CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9833E834E1;
	Tue, 30 Sep 2025 16:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="Uq4SqoEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3E38349B; Tue, 30 Sep 2025 16:48:37 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A193E83510
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57e03279bfeso8547228e87.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759243715; x=1759848515; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4f44pl84GQP38p4pvpVYrQfKiECtCRboD4lfrbHQIc=;
 b=Uq4SqoEqy+44BOBWzqq9sMWuSgaXegN5vA0gRQPlN+B0ZGSzo5rIwIRaOp/TJzZJBv
 hSaX8MJATVSonrVSdQnFJDTGfFY48VN5+tYwKpkxpiLHihH+vkGh4lUtsMYbtB43eesz
 YIQEhnXAn+EP0cWN50RaymnrXKe/7VLow1xNbAv+nB/enPSI0r1iLsCHt7FiR/kmlkoK
 LsGqpjIv5mTS0J7SFkzqwBrTRrVg2/ht++tkIJWq6HDk1OkwqfENMWHX2BrUx/YsDIJ/
 N7vbX6eY/gTFX/hx4qgIpbXD0k3c6hgnHtmrpBe0poz0LjxYAVL2mGL5klEvxa7ztGMp
 G3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759243715; x=1759848515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4f44pl84GQP38p4pvpVYrQfKiECtCRboD4lfrbHQIc=;
 b=Ldu+Ty+VmX1LMihXMQX/QkuQ8FB/Gn/fwdvDOFVCv+ckg6lIbQEOFewLqNMVEmqlH0
 HwT/LkOVzX+q2QhwTF/DAgyOXwWhUlBVYo7k/1QIutjhEXwbmJzb9sWLV0Ve8vVozbDF
 U5LVZGu9EsEhcR2fJpGPCni88AUQ2aszEFPHMgbmyaPZTmIhQBza4ubW0q8LRsdrjC60
 GUHRDfjWFBAMqrhH5An0UDGAIePFuYhjmN3ezX1AAcJ3TfRXDisL+Is+SpcS+cc1tQne
 zsU48yirTDlZa3ggbyW6eA2jFn0xgeLMsaWY4Self7rrb7/iGC3Is/ZuCc8us6l68b5O
 YW7Q==
X-Gm-Message-State: AOJu0YxCc5T7y3hIRSH1/FwiRZwfuPfxZVCfMyQmKUjQvkeg3GMpILLe
 7eZK0GO90BRu5oKfl3kxdDnEUUcVaAtKlXY9d8/5egrNmWgT/f7kWEMrEzJF4slFTp0vsFnyaxW
 x8h9hezZ4BAA1AGoKJQ3pK/BKgfZDsQNjbPes
X-Gm-Gg: ASbGncvuQiujJGfqHgPJdInsu1hNZUS6873kd5yJuSiz+wPqEC134oloHbEmvwDBgbK
 k7quCpkNkSv+QKg5qeZLlIpskQrsEz3KTzHwX7KZLkO7htxWwpSITtVxd1MJHXG/mJ/8WTsuoQ5
 rJSpgW/H0F/4gH7r3iFYhnAkrM/T0XPDCsdRtwe0nVP+OdWFVonUb+rQQ3mUD3oBWfIdE4hbEqe
 aQX7G841D2lFdh8CYYyOHW/SYF16Nx6
X-Google-Smtp-Source: AGHT+IH8nrCrfOyBAz44XS1FltWetbiQ47MlBCRZPl7GeHayY3lym+DtTaA1zv2uVWa90dHLSZRotXHg9sz4LYZYONI=
X-Received: by 2002:a05:6512:1304:b0:57b:f66e:20ba with SMTP id
 2adb3069b0e04-58af933411emr51312e87.6.1759243714504; Tue, 30 Sep 2025
 07:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
 <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
 <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
In-Reply-To: <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Tue, 30 Sep 2025 16:48:21 +0200
X-Gm-Features: AS18NWACwPwYaxX5N5CxCfjEYlISlA2VnXfvMEqM7p41Ld5ibDKCfzO9z0fDwAI
Message-ID: <CAGm1_kvnxrAHMRwffYki6Zr8g11G2Bmr1GKRPcFfFL1T7xa8-Q@mail.gmail.com>
Subject: Re: activity-led usage
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Tue, Sep 30, 2025 at 4:13=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Yegor,
>
> On Tue, 30 Sept 2025 at 06:35, Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
> >
> > On Tue, Sep 30, 2025 at 12:29=E2=80=AFPM Yegor Yefremov
> > <yegorslists@googlemail.com> wrote:
> > >
> > > Hi all,
> > >
> > > I added the following LED definition to the am335x-baltos.dts:
> > >
> > >         leds {
> > >                 pinctrl-names =3D "default";
> > >                 pinctrl-0 =3D <&user_leds>;
> > >
> > >                 compatible =3D "gpio-leds";
> > >
> > >                 led-power {
> > >                         label =3D "led-red";
> > >                         gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;
> > >                         default-state =3D "on";
> > >                 };
> > >         };
> > >         user_leds: user-leds-pins {
> > >                 pinctrl-single,pins =3D <
> > >                         AM33XX_PADCONF(AM335X_PIN_MII1_COL,
> > > PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED */
> > >                 >;
> > >         };
> > >
> > > The gpio-leds driver is working and I can toggle the led-red via the
> > > led command.
> > >
> > > Then, I created an am335x-baltos-u-boot.dtsi file with the following =
content:
> > >
> > > / {
> > >     config {
> > >         u-boot,activity-led =3D "led-red";
> > >     };
> > > };
> > >
> > > I have also tried "led-power" instead of "led-red".
> > >
> > > In my final DTS files I have the following nodes:
> > >
> > >         leds {
> > >                 pinctrl-names =3D "default";
> > >                 pinctrl-0 =3D <0x56>;
> > >                 compatible =3D "gpio-leds";
> > >
> > >                 led-power {
> > >                         label =3D "led-red";
> > >                         gpios =3D <0x57 0x00 0x01>;
> > >                         default-state =3D "on";
> > >                 };
> > >         };
> > >
> > >         config {
> > >                 u-boot,activity-led =3D "led-red";
> > >         };
> > >
> > > U-Boot cannot find the activity-led node.
> > > ofnode_options_get_by_phandle("activity-led", &led_node); returns -22=
,
> > > because ofnode_path("/options/u-boot") fails.
> > >
> > > When driver debug is enabled, I also see the following messages:
> > >
> > > bind node config
> > > Device 'config' has no compatible string
> > >
> > > My am335x-baltos-u-boot.dtsi code is similar to what I could find in
> > > arch/arm/dts for the boot-led usage.
> > >
> > > Where should I debug further?
>
> It is a bit confusing as there is still 'legacy' LED stuff in the
> tree. For your problem I would suggest checking that the LED device is
> configured correctly.
>
> For sandbox in test.dts you can see:
>
>     options {
>         u-boot {
>             compatible =3D "u-boot,config";
>             boot-led =3D <&sandbox_led_green>;
>             activity-led =3D <&sandbox_led_red>;
> ...
>         };
>     };
>
> Check that led_init() is being called in the LED uclass.

It is working now using your suggestion. Thanks.

> >
> > Should activity-led be also mentioned in doc/device-tree-bindings/confi=
g.txt?
>
> We should be using /options/u-boot for this[1]

This means, everything that can be found via the following command
won't work and should be removed?

grep -r --include=3D'*.dts[i]' boot-led arch/arm/dts

Regards,
Yegor
