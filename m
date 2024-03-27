Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFF5C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 17:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D9308803F;
	Wed, 27 Mar 2024 18:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sm8rKWan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C15D8808F; Wed, 27 Mar 2024 18:15:43 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FD687BD6
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 18:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d46dd8b0b8so88352381fa.2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711559739; x=1712164539; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3vSDCSg6COoGx7jNus6UD+RGj3oBBoFp29X/evJlA8=;
 b=Sm8rKWanpuhW7++QpUA8BDnUupXUydOdQ20Dg4ZMyuBma6zB/FKR4gedVS2xNidG6f
 9pE0D/KNGuFhV7NtoOACE1BFPkUimP+hMjAKfsQJ2oOVgwkqKsFonRqDlsElq02m+QIZ
 4QWmn5QIMUcSdKfZjspcwMenAysdf36v8MgX/7PHfzIfpZ4qsI/gVHcIcQgPiFxTdWu3
 VUeNyO8issCM3L+oRHvLnOi5QA4OIX9S/2c5RpZNyS5xH/IJn5SN7fB3IXcDtGyUU6/4
 8g3hg52roE5yOn99z0S2avB2Jjz/Esp9kFNghwJX2wZk8LZNIkTeZ4S6AUedrDVH/wqc
 yI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711559739; x=1712164539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3vSDCSg6COoGx7jNus6UD+RGj3oBBoFp29X/evJlA8=;
 b=ky3G+nEIv5wmJQG3WV3iZZQRQwNd6GxJgGyamxq2uCqKevrVdjX8uE7WzothBxZWrP
 3PHFYZbTqz7XEg4fXvTIp4awD0uXk2ZWThLf6HgMf1VBcDTgtFrtfD3dqxarrgOy3oNX
 TqJLt6efb5QpmpS5HGmkZxxzXfZ1SjxrCHjnCLKWWnXW6LaVqWRPphO0Jr+m2S18Eg/O
 qHtA9Sy6el1GQp4e0WbS8u2fs9GooaUiXbdQIXdKm4jY0kV9fW7DVsGZ3om8/R+uv/W7
 HHsfY1W13yTp6KAzdZMQM7akrV2KMvxtTnfz5c/JtKiDjifxoY9YTodKAmMXpWCnxyJv
 Tkfw==
X-Gm-Message-State: AOJu0YzoKli06xo0rWgicFr/4IibSF3XRjk50YjvDZCmaatBKkn6V9wF
 R2QnGIHgQXb1Tm/nOMzbVn4o4Q5LVPXTTJ6Zkdjik39At4Iz3nftLX+iqYhMC9IlGBJYMW+Amx3
 yUKj1d4J6db2nviAqWEcNhb/TAH4lVoaXT+Mtkw==
X-Google-Smtp-Source: AGHT+IGhorBvBmpN9mNBNhCt7zAIH+mJi7kEitjpPgUrWJ0vj4ngNNNwOgI0AdRN+y8RuZFIgluR9hSLKekesQhf5LM=
X-Received: by 2002:a2e:9bd7:0:b0:2d4:3e82:117e with SMTP id
 w23-20020a2e9bd7000000b002d43e82117emr107764ljj.32.1711559739336; Wed, 27 Mar
 2024 10:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240321180219.1039622-1-tharvey@gateworks.com>
 <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
 <CAJ+vNU0aSj5RgCUxz74hg059Qtmco4HSBCiAHA_hhw+jzxo5Dw@mail.gmail.com>
 <CAC_iWjJ4s1ZS8X64vjV_xiOSzKf7fPBryw6eGp6tW7Vqxv2_gw@mail.gmail.com>
 <CAJ+vNU1m=joe0mAC2ss-QmBN17Jht4d+fpba4iM0tTScy0Zngg@mail.gmail.com>
In-Reply-To: <CAJ+vNU1m=joe0mAC2ss-QmBN17Jht4d+fpba4iM0tTScy0Zngg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Mar 2024 19:15:03 +0200
Message-ID: <CAC_iWjL6CtZ5WgASepcUZOXnF=G4uDTeVq3WnOkz+jDL+cLZzw@mail.gmail.com>
Subject: Re: [PATCH] tpm: display message when using gpio-reset instead of
 when missing it
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Samuel Lee <slee@gateworks.com>
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

On Wed, 27 Mar 2024 at 18:49, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Wed, Mar 27, 2024 at 9:16=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tim,
> >
> > On Wed, 27 Mar 2024 at 17:29, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 7:44=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Tim,
> > > >
> > > > On Thu, 21 Mar 2024 at 20:02, Tim Harvey <tharvey@gateworks.com> wr=
ote:
> > > > >
> > > > > Instead of displaying what looks like an error message if a
> > > > > gpio-reset dt prop is missing for a TPM dipslay a more
> > > > > informative message about resetting the TPM if the gpio is found:
> > > > >
> > > > > before:
> > > > > tpm_tis_spi_probe: missing reset GPIO
> > > > >
> > > > > after:
> > > > > tpm@0: performing 1ms reset on gpio@30210000:12
> > > > >
> > > > > Note that the reset dt binding prop used in this driver is not
> > > > > dt-compliant; it does not exist in the Linux dt-bindings document=
ation
> > > > > and the reset is not done by the Linux driver.
> > > >
> > > > Probably for a good reason. You aren't supposed to be able to reset=
 a
> > > > TPM without resetting the CPUI as well no?
> > >
> > > Hi Ilias,
> > >
> > > Could you clarify what you know about TPM reset? We use the ATTPM20P
> > > [1] which states in the datasheet under the reset pin: "To be
> > > compliant with TCG requirements, this pin needs to be tied to system
> > > reset. TPM_Init is indicated by asserting this pin."
> >
> > In short, you shouldn't be able to toggle a GPIO and reset the TPM
> > without resetting the CPU as well.
> > An attacker could boot -> log into the OS -> reset the TPM -> replay
> > measurements and unseal keys that he shouldn't.
>
> I suppose that makes sense. So consider someone gets into your OS and
> also has access to your board and electrically isolates the TPM reset
> from POR# (cut the trace) then with a probe resets the TPM? At least
> in that case they have to have physical presence as well so we should
> connect TPM RST# to POR# to not make it easier on them.

Yes, physical attacks are completely different (and we also have TPM
interposer attacks, which can sniff secrets).

>
> I'm always wanting to allow GPIO access to various chip resets to deal
> with issues discovered down the line that require a full chip level
> reset - probably not the right thing to do in the case of a security
> device!
>
> Thanks for explaining.

You're welcome and yes being able to reset the TPM without bringing
the CPU down as well is not a good idea

>
> I'm still learning about the TPM capabilities. If using the TPM to
> store a key that is used for FDE you can use 'tpm2_unseal -c $OBJECT
> -p pcr:sha1:0,1 -o fs.key' to get your key. There must be a concept of
> re-sealing this object so that it can only be unsealed again with a
> power cycle or something?

You don't need to reseal it. The spec defines separator events that
can be used to protect the key leaking.

Once you unseal the key and decrypt your rootfs, you can do something
along the lines of
for i in {0..7}; do
     tpm2_pcrextend
$i:sha256=3D000000000000000000000000000000000000000000000000000000000000000=
0;
done

Any attempts to read the key after the separator event will fail since
PCRs won't match the sealing policy anymore.

>
> >
> > >
> > > Our boards have a resistor loading option which routes the TPM RST# t=
o
> > > an SoC GPIO or alternately to a POR# (hardware power on reset provide=
d
> > > by power supply and/or PMIC). Could you point me to where in the spec
> > > it explains what the TPM reset should be connected to?
> >
> > I am aware of the the TCG TIS spec [0] which says
> > "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the platfo=
rm CPU
> > Reset signal such that it complies with the requirements specified in
> > section 1.2.7 HOST
> > Platform Reset in the PC Client Implementation Specification for
> > Conventional BIOS."
> > There might be other TCG specs defining this as well.
> >
> > [0] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTP=
MInterfaceSpecification_TIS__1-3_27_03212013.pdf
> >
>
> Thanks!
>
> > >
> > > > That being said, printing that the TPM was reset is pointless imho.
> > > > OTOH the existing error message at least points out a potential
> > > > problem in the DT.
> > > >
> > >
> > > I'm not sure if you are NAK'ing this patch or asking me to change it.
> > >
> > > Displaying a 'missing GPIO' message is not helpful when there is no
> > > GPIO in the dt bindings to begin with.
> >
> > I am not NAKing it. But isn't that message more useful than printing
> > the TPM did a reset? At least you get a hint of something that's
> > missing from your DT
>
> missing an invalid property?
>
> I deal with users all the time that think things like that are
> 'errors' and contact tech support. In this case its not an error
> because there is no gpio reset in the official dt-bindings for the tpm
> and its generally considered bad form to add non official properties.
>
> And from what your explaining we shouldn't have a GPIO connected to
> the TPM so perhaps we should remove the reset completely and perhaps
> even spit out a warning if present:
> ignore Invalid DT property gpio reset to conform with the TCG specificati=
on

We should, but those changes predate me being appointed as a TPM
maintainer. If I had to guess, I would say that was added for TPM that
are connected on an external SPI bus (e.g the RPI).
So what about not printing the error message, keeping the code so we
won't break 'test' devices, and print a warning message like "This
shouldn't be used on secure production devices"?

Regards
/Ilias
>
> Best regards,
>
> Tim
>
> >
> > Thanks
> > /Ilias
> > >
> > > Best Regards,
> > >
> > > Tim
> > > [1] https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted=
-Platform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
> > >
> > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > ---
> > > > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_sp=
i.c
> > > > > index de9cf8f21e07..944540f7a711 100644
> > > > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > > > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice=
 *dev)
> > > > >                         /* legacy reset */
> > > > >                         ret =3D gpio_request_by_name(dev, "gpio-r=
eset", 0,
> > > > >                                                    &reset_gpio, G=
PIOD_IS_OUT);
> > > > > -                       if (ret) {
> > > > > -                               log(LOGC_NONE, LOGL_NOTICE,
> > > > > -                                   "%s: missing reset GPIO\n", _=
_func__);
> > > > > +                       if (ret)
> > > > >                                 goto init;
> > > > > -                       }
> > > > >                         log(LOGC_NONE, LOGL_NOTICE,
> > > > >                             "%s: gpio-reset is deprecated\n", __f=
unc__);
> > > > >                 }
> > > > > +               log(LOGC_NONE, LOGL_NOTICE,
> > > > > +                   "%s: performing 1ms reset on %s:%d\n", dev->n=
ame,
> > > > > +                   reset_gpio.dev->name, reset_gpio.offset);
> > > > >                 dm_gpio_set_value(&reset_gpio, 1);
> > > > >                 mdelay(1);
> > > > >                 dm_gpio_set_value(&reset_gpio, 0);
> > > > > --
> > > > > 2.25.1
> > > > >
