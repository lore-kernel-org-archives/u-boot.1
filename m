Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D88CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F9181D6A;
	Tue, 30 Sep 2025 16:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fl0YG/Kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB13802C1; Tue, 30 Sep 2025 16:13:37 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20312802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b3be330b1f5so626270266b.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759241614; x=1759846414; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfMvj05WOYY89FW3lNCXGBqo/QX1zHQD82XEITweOf4=;
 b=fl0YG/KjewGlRBla0ObAXkk5KdGqc+LmFVJUw4H+DN702gpikmFyxT4KrGHFlOEs9U
 YLf8uUBvF0IVbPsI0zz5GCEerLeUYJD07b0qt3c4x3hOgjBJSxTjY+A1UJQidPt3nX9i
 IrADmVEDPAKDgSr0RVmzKS4ZXiFIp2LX53u7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759241614; x=1759846414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfMvj05WOYY89FW3lNCXGBqo/QX1zHQD82XEITweOf4=;
 b=TxlyGWH5rrL+1Ru22t91AzyLMlj/SqL+6LFPlm609x7k16rS2LaxXvy6lmZdbArlt5
 MXZQ1E714RdCCIXKZn+rXtCRmvBbvkRqbUDkECvDlAQvQwERUnprmJDuAQwzexGzGeRi
 on0H3rWY018MX3SYP0AotcrwCKleyagfc5VkgooyJZPbl5Di5RefwSpoIK5ZqzLfj+/3
 gB+mdUZmYlpSEi1/IrUcx3OtFSb7+UL4aAIbSCUV0qnKUgaboDtZCAvGc+voTqlRzoNM
 Bbtod/6bVPs3hy+JQ0dW7Ti94nLLXQcVLZHveShuFrHaGHlqViCKFhOW0qDrziZcWQ02
 AUKA==
X-Gm-Message-State: AOJu0Yw95hE7FmS84o7pie3V0y77n2Y1crFh2zyDf87rjKl/QPxWdl9P
 3XDWraRlKQWw7dL7vwojVkZtKmCfsLHWlAcxkzUYvFccQTdKGJmWLlXWvGnDmbhCboilPL1vG0i
 22muNaLunGy/MuSqgID+i5lHcl057e0R60tmOuLNJ
X-Gm-Gg: ASbGncsvVecvhfJA5XZYK660N65Z34HTil3UmRxSSp9Mp15zSZhHu0rWyRFuN9ZomMH
 EBGpuYrC+Cbh+jwLMCJ1dn1p/KqqSurLS3aQVRT1jertoyRyBsKF0KggcRXmo2Z6/aX6+oFa7v3
 nWtzGe3k1mXzDdwnVn2yoMm7EaUX/z5QVxfLrw24oy4+zqCtNg8N0JLrRWC6AHedPE1hrdlCw8m
 bEd1fJUOSujEIVIc8811stdsLBSOw==
X-Google-Smtp-Source: AGHT+IEeeTicivLNDnKyja/bIIxyBAAOQzqlZttcjfhfMqydL6OtAY1ekm556vhifxpXHNTTgHBPWYznGJ65mDXzM5Q=
X-Received: by 2002:a17:907:edc7:b0:b3d:5088:213d with SMTP id
 a640c23a62f3a-b3d50882582mr913660166b.42.1759241614532; Tue, 30 Sep 2025
 07:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
 <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
In-Reply-To: <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Sep 2025 08:13:23 -0600
X-Gm-Features: AS18NWA1ylIPCWk8niBeB2FypRm5OhvPlmn7sSUNmDlfT3Ucu_kxMgyAIqJ6n-g
Message-ID: <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
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

On Tue, 30 Sept 2025 at 06:35, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
>
> On Tue, Sep 30, 2025 at 12:29=E2=80=AFPM Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
> >
> > Hi all,
> >
> > I added the following LED definition to the am335x-baltos.dts:
> >
> >         leds {
> >                 pinctrl-names =3D "default";
> >                 pinctrl-0 =3D <&user_leds>;
> >
> >                 compatible =3D "gpio-leds";
> >
> >                 led-power {
> >                         label =3D "led-red";
> >                         gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;
> >                         default-state =3D "on";
> >                 };
> >         };
> >         user_leds: user-leds-pins {
> >                 pinctrl-single,pins =3D <
> >                         AM33XX_PADCONF(AM335X_PIN_MII1_COL,
> > PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED */
> >                 >;
> >         };
> >
> > The gpio-leds driver is working and I can toggle the led-red via the
> > led command.
> >
> > Then, I created an am335x-baltos-u-boot.dtsi file with the following co=
ntent:
> >
> > / {
> >     config {
> >         u-boot,activity-led =3D "led-red";
> >     };
> > };
> >
> > I have also tried "led-power" instead of "led-red".
> >
> > In my final DTS files I have the following nodes:
> >
> >         leds {
> >                 pinctrl-names =3D "default";
> >                 pinctrl-0 =3D <0x56>;
> >                 compatible =3D "gpio-leds";
> >
> >                 led-power {
> >                         label =3D "led-red";
> >                         gpios =3D <0x57 0x00 0x01>;
> >                         default-state =3D "on";
> >                 };
> >         };
> >
> >         config {
> >                 u-boot,activity-led =3D "led-red";
> >         };
> >
> > U-Boot cannot find the activity-led node.
> > ofnode_options_get_by_phandle("activity-led", &led_node); returns -22,
> > because ofnode_path("/options/u-boot") fails.
> >
> > When driver debug is enabled, I also see the following messages:
> >
> > bind node config
> > Device 'config' has no compatible string
> >
> > My am335x-baltos-u-boot.dtsi code is similar to what I could find in
> > arch/arm/dts for the boot-led usage.
> >
> > Where should I debug further?

It is a bit confusing as there is still 'legacy' LED stuff in the
tree. For your problem I would suggest checking that the LED device is
configured correctly.

For sandbox in test.dts you can see:

    options {
        u-boot {
            compatible =3D "u-boot,config";
            boot-led =3D <&sandbox_led_green>;
            activity-led =3D <&sandbox_led_red>;
...
        };
    };

Check that led_init() is being called in the LED uclass.

>
> Should activity-led be also mentioned in doc/device-tree-bindings/config.=
txt?

We should be using /options/u-boot for this[1]

Regards,
Simon

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
options/u-boot.yaml
