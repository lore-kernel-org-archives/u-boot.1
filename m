Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C3DCD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 13:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70FD48341A;
	Tue, 12 May 2026 15:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="4iGDtYfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40891838BB; Tue, 12 May 2026 15:18:55 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DFB0803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bcc9fdc959cso439269466b.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 06:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778591932; cv=none;
 d=google.com; s=arc-20240605;
 b=bim/5+7GCkVQ02wLKphrCXYnlsuBhrms0QwYqlWi4rTeXedmkhk0HpCB/xrLSgMFc8
 tsnJTY8hmivWw9Rld7tGolGYVZh/BpmFfTIOowjgGRPjCC1knbyKD7aGaJpwZscwYESs
 UhxM62dhtd0gFW1EWtUk0jNp/hSCvNp5fdRvWrPWMorFy5txZYZ2uND76p2SX+ZfmFNk
 nYCouQzrbeW+bX5feYJRnDxO70KwJioY4ijqiBC3Xkd9qV/768gAuhpqMKLqw+PUmOrU
 lrZVibpytNAILqpW9lqbdQ672A/ZaGRvpki/nHWQ15EWL/r10anRwbX648f3zO3H8f0n
 sQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s3jONyPBNYTaei0NKuJvEiN4I28T/1gszQgWyaZhaQs=;
 fh=kECiEVbGN5ZNL5uU9e+czpkcCbea+NVKkKY/05tCq/Y=;
 b=RBC/qYrhETmC1rAh3AThfrwey872mJVNYAy9dlDhVcgnuq7QuPU7uqtXNqp/7soATx
 xk6K2z2gRdseGp4u7rKSNLHOIzaUdXEKfAPiRfZHQcCRYchGYybbe383VriqjZTB+3aZ
 FizR8uhmkKnwpusOgPSRyaeO2lDCHVHzNzrVf2ky6cuUd49iAQjQgWIBEFjzBIiMl3Co
 Te1aIrPXqDZsZQTAfuJPB30U10Qru6ROr63C4w0NRE/e0A0wURvGTiz5bdLG/Xny+1hx
 +3X6uf9mrCJ9cXm8GFu8eoOaSoARrmE/UYk+0cXb6tGoOJsd/4+/dqkJ2FyfiQ2QF++D
 HDhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778591932; x=1779196732; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3jONyPBNYTaei0NKuJvEiN4I28T/1gszQgWyaZhaQs=;
 b=4iGDtYfbniEzjLIPt2K6o6IgV+yYXD+JeN7HyR4ZoFnR/ZSGcxU/wf1QS1N5ON/Hbf
 u06hV50bgc4SsfHQ5wL+MntvyTG1GDf4GDP5UrAFHUbp1/bNvok7REKmm17x8lgGn8x1
 OdB5R1UhGSUPkxVwE/lhtcCVeSC9l6ltL8sMgvYz8nxrg4Ofu/HN8SLtwuvenUrQhjYp
 JZvLGbp/kr312CCfnZviYNbIijm1l972GQpJmPYoxZQiEc/xLpKtWK+P8OXVIEgndTLD
 OXybmWzJ0wMlJr++psoKMEKbYtj0luhPP8heO0bNJOSIeL8VkdAGOpFbVPQ9xKhmC9lC
 5Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778591932; x=1779196732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s3jONyPBNYTaei0NKuJvEiN4I28T/1gszQgWyaZhaQs=;
 b=DG0OV+Lx3AY754j6Nzdb3p5Uhfo6XO+ctNOg7gv9J8I/PGKnzr5lObSuS1cgfctbSb
 KAhMNMtR55GG50wi7ek0KaIuFkyxsGkTwxSMJwycM57znyPFJxL/hmhxcwQNCtSzuoHa
 qVLD+tJeoN97ZmQhLEHjMt/zToU4MMR1Pzxek0V/xOiXWb4D1QDFsaowMWeWj42/CO1G
 0vjY1Ulf03nIQ019jqZxy910oesDsGUlI4D+dAGbGwoa3gYuV9uSFST1DT9NJclfBj9z
 t2fkEq1333VCWNbAYGDy8m7DcxdPZ80AGDx8A8WoOrO6jDlALsFZ1AdQmRgt/lOcUBp6
 7PhQ==
X-Gm-Message-State: AOJu0Yy+LYaKB44erZfJqScDVJ6vx4qHUvE/vuRmyRNXKAbyH2vlF+Sr
 oxkH9d1Y56IsSJth/pD3D/i7YN1WATY95/jfXD5jzkXGIdgq+lV/lU636Cjk0+ysIg6H4LndlpS
 p+27T5HwgXzmU0HgFUnVW24j4DnCsR1gUmp87TKiddA==
X-Gm-Gg: Acq92OFaSZW/6BS9k4GQBvrO2aTmJbjVqLL2aTrkLc0Bx3SoLu2ukSGL7IkN6a0f67H
 iuiozmXnc+SuUcIb7dcFnRt2YdXpDb82AAgKLAPyYVYTUGbS5GS+ThIPwzosdbr64xioM3LINYB
 HO31s5ZEb7tkPE14fkY6MWjY1h+fOmOCPsIf3wUNIDPSByric6ISpYJmONOioGX2eHsfq+3P9YL
 1ySRklBUk++A89z7REevnMFcQ4S0zbz5jaMd3NtFgSTaP8gu6qzY+2f5avrDSPs8fxNYW4KzaUf
 0Mo7Iqba4fNJnoxIXzxeUW9MG4sXiMr2txf2i6aB
X-Received: by 2002:a17:906:9c82:b0:ba4:f501:cb8b with SMTP id
 a640c23a62f3a-bd28e60b0e1mr194173266b.16.1778591932435; Tue, 12 May 2026
 06:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-sl6341-v1-1-2819ac19e050@flipper.net>
 <8b38020c-4d92-4d46-9c47-eb70dda757a7@mailbox.org>
In-Reply-To: <8b38020c-4d92-4d46-9c47-eb70dda757a7@mailbox.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 12 May 2026 17:18:42 +0400
X-Gm-Features: AVHnY4IaPxwTmcUkrR70LygUCFjP1m-wIZUNXP0AdEUcwHFPS7CizDIgMzk-8oE
Message-ID: <CAKTNdwEdgqmDOqqW5v1xmrixDKSvnPe8aDUiDbYQyeAoSKV_cQ@mail.gmail.com>
Subject: Re: [PATCH] usb: onboard-hub: Add support for CoreChips SL6341
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@st.com>, 
 Patrice CHOTARD <patrice.chotard@st.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>
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

On Tue, May 12, 2026 at 5:12=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 5/12/26 11:41 AM, Alexey Charkov wrote:
> > CoreChips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
> > requires external 1v1
>
> 1V1 (V in caps), fix globally.

Ack

> > power and can optionally use external 3v3 power
> > (or alternatively it has a 5v->3v3 LDO built in to derive 3v3 power fro=
m
> > VBUS). It also exposes a reset pin.
> >
> > Device tree bindings are queued up for upstream release with Linux 7.1
> >
> > Link: https://github.com/torvalds/linux/blob/master/Documentation/devic=
etree/bindings/usb/corechips%2Csl6341.yaml
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   common/usb_onboard_hub.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> > index 6fc34489a98f..d15d7bbff87d 100644
> > --- a/common/usb_onboard_hub.c
> > +++ b/common/usb_onboard_hub.c
> > @@ -262,6 +262,12 @@ static int usb_onboard_hub_remove(struct udevice *=
dev)
> >       return ret;
> >   }
> >
> > +static const struct onboard_hub_data corechips_sl6341_data =3D {
> > +     .reset_us =3D 10000,
> > +     .num_supplies =3D 2,
> > +     .supply_names =3D { "vdd1v1-supply", "vdd3v3-supply" },
>
> Is there a YAML binding document patch which describes these supplies
> already , maybe a patch posted to devicetree@ ?

Yes, the link is in the commit message :) Merged for 7.1 as commit
bfcb86e58f3a ("dt-bindings: usb: Add Corechips SL6341 USB2.0/3.0 hub
controller")

> > +};
> > +
> >   static const struct onboard_hub_data usb2514_data =3D {
> >       .power_on_delay_us =3D 500,
> >       .reset_us =3D 1,
> > @@ -299,6 +305,12 @@ static const struct udevice_id usb_onboard_hub_ids=
[] =3D {
> >       }, {
> >               .compatible =3D "usb4b4,6506",    /* Cypress HX3 USB 2.0 =
*/
> >               .data =3D (ulong)&usbhx3_data,
> > +     }, {
> > +             .compatible =3D "usb3431,6241",   /* Corechips SL6341 USB=
 2.0 */
> Keep the list sorted, 3 goes before 4 .

Alright. My thinking was that 0x04b4 goes before 0x3431. Will move further =
up.

Best regards,
Alexey
