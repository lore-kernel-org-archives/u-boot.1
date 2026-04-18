Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D31F99C7F
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 13:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4395F83BC8;
	Sat, 18 Apr 2026 15:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="QQZC6WOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7087783FF5; Sat, 18 Apr 2026 09:01:39 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F016880086
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 09:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ssrane_b23@ee.vjti.ac.in
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so250977366b.0
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 00:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776495696; cv=none;
 d=google.com; s=arc-20240605;
 b=XlnLYZIf37XW7x4SsO3pxaZRLioa/yXeKcVlUfoU5TfrM0EXY5xsCh0Ok8Eo/dG7N1
 vJVZhwaMX85U5nAYN6xsis1ezNwkPk4fEtTA7I5Phw9HPJGxU6sKFH6mgBY15jhCWArl
 qoJaz1DMBtvenEpwtt6LFfYLAsXDKInM1VwiJL3ENW5amLVjAxXQ0GMVAPOXz6Kq0hit
 BZujUyUuAMb+1T4JZh1o4JjTc0787Ni1YLsPvtGj4FnFSWXNjcXkFdYVhxxxmpUYLjxl
 WnzooZ8QBseUqZWDokLZ2m0F31pbG/29U9tm2nO6KueAdhGksZcYqYlaJFuTXKQ48vOo
 Fj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EEuxY4uxT1vrcA5v1HrKqsRPOZgL3IrZD7d6e6L6vj8=;
 fh=pRwEMyC5y8czXLmH1HBxkBMwOGE0anBAHYC7Rp+rx/E=;
 b=EgAhcyNjfMnqAn+/QJhthTTjx4EAh7Kx+AhribCjfacty5l4OFjRvGhLsjSFumLH/i
 HtPfkdlmfGcLQbszUap90zUuwrTNfw4qiZobljk83fMJ7LzERvAyPrz2/C+85eKRaNiZ
 8XflV/U5cy1fI8hO7k4Ehb/eVDBDbmo18alGP4qz9ZMZjRSerguUWN3hY6Qnhw1srZAC
 LvhqL3E41poAFdFvhBk6U9qqeFVdYqtEY108cDpbvwWf3tCRP0IhtBwxTciq8K6qqsb8
 E7nYaNnu5R/HiotTkSlfZURLauocVhoyZCifrkrLz22H+LnfI6trcAnDjMpx58FC9GLf
 7niA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vjti.ac.in; s=google; t=1776495696; x=1777100496; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEuxY4uxT1vrcA5v1HrKqsRPOZgL3IrZD7d6e6L6vj8=;
 b=QQZC6WOGjzeurNrCtq27GYXODD5NUn262a9N7TOlVYhsv+2GoTwxfyqvErOR3W2ySW
 Wu/vvEbHv0UJ2GEUyHMDV872ytL89Byp4O7Dag9ETDjmipBvrEUv5P/wKWoa/JJQlqQi
 JA9orM7OGAOfAq3OVRatd99jWuVuOXpC4HE4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776495696; x=1777100496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EEuxY4uxT1vrcA5v1HrKqsRPOZgL3IrZD7d6e6L6vj8=;
 b=Wewfy5i964RuMZXBlc+tnoc7r97i8MFJ6Jw6k6qnq9ExM4GDDPiMzV8sYlOxI+q4Xw
 SNmeMjsdzYetvV+e5uProiKWssI+s+/AbRQ63gU1tmIB2q4SMEydaHIPQRrfNLM2SUZ1
 yb0LTxwk9xKPSxo6tm1wya2MqqkWe7xZMXdAhS1oF8HM6BFH16YOIa07f7Nb6yf2AEwY
 2WEam6ODBgWn+Uy273d419korrM4tITTE+P5D0xKUefaH/3BixEuPiVTJorih0qLPY4M
 kHa/mrn4CLOhRlwYIA9PEH2qOn2XTI7KWQ4zufMGV+3niVwgAQ6D48i3/1lNvJv7/zGO
 Gakw==
X-Gm-Message-State: AOJu0YxEl6zn+PlS3oS4ytNevJCcPYqcuF9BuxBcdZS3ABGzcmyJk35N
 CRx+ZgeON5c5V8N+lSb0gY0QR/jxscS5pOSj9cVAES95j8qhUUBQUJSrOS3vGXGBn52bvfdEVE+
 AF7JHmB16+8P3rxKOwy9IOATyCMwSX8Y8UPVfa1OxIg==
X-Gm-Gg: AeBDieuDqEpqDUCyWbOYZPwTnmcLHsh8F/bUlgEiHB4sWYh4E3VwExwu1JXhmcBdbKT
 QJgZlvRtEjpZ3A2Uo+SGJ23JtcuW5/9Qc8D6pNR+YQ9ahs88oJg7XLO/y+D8G/QhhxHsfePL5Mv
 jlT5TR4riAO8VMccw7XEiluJpsX/CT/tbp/gC/tXy7D3JhC8IwiRo0BO23/KwrwKCkjgarTjZHe
 OKnosRPOLR279ePLNgeW71pHJjnDDsvdFdt6nrGdtxtMVvqmOkkbFwOXrTv86RVqoWVzKSEEXrk
 4h+Rs7Cu14iixSB5ohDxEFCDgUbfmmSMk0AWB40SFrr6tYbrOg==
X-Received: by 2002:a17:907:1c98:b0:ba5:7cce:9794 with SMTP id
 a640c23a62f3a-ba57cce9990mr61339366b.30.1776495696128; Sat, 18 Apr 2026
 00:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260415190321.120706-1-ssrane_b23@ee.vjti.ac.in>
 <CAFLszTi-s_XZgoFN4avxDn2sjo8MPGyLmC=stLC1ZGbsgkWOng@mail.gmail.com>
In-Reply-To: <CAFLszTi-s_XZgoFN4avxDn2sjo8MPGyLmC=stLC1ZGbsgkWOng@mail.gmail.com>
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Sat, 18 Apr 2026 12:31:24 +0530
X-Gm-Features: AQROBzC6JFxMFZon2EoHrZp29RzZdr8-_5X75-4g6cZtewqdJRLuQ-1bBJYbfAg
Message-ID: <CANNWa04cAXG43oWnWW9UJSyXHXzY6UcYAd+pLdtNVBVBAYEoPg@mail.gmail.com>
Subject: Re: [PATCH] video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, jd@denx.de, tl@denx.de, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 18 Apr 2026 15:14:09 +0200
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

On Fri, Apr 17, 2026 at 12:24=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:

> Please can you add named defines for these bit fields (0x90, 0x89,
> 0x80, 0x10, 0x09, etc.) so it is clear what each AFE setting does. A
> brief comment referencing the programming guide section would also
> help.
>
yes will update that in V2
> > +     /* Preferred DTD pixel clock: bytes 54-55, units of 10 kHz. */
> > +     pclk_khz =3D ((unsigned long)priv->edid[55] << 8 |
> > +                  priv->edid[54]) * 10;
>
> Please can you use EDID_DETAILED_TIMING_PIXEL_CLOCK() from edid.h (or
> edid_get_timing()) rather than open-coding the EDID parsing.
>
yeah I should have done it is the same approach the anx6345 bridge uses
> > +static int it66121_attach(struct udevice *dev)
> > +{
> > +     struct it66121_priv *priv =3D dev_get_priv(dev);
> > +     unsigned long pclk_khz;
> > +     u8 status;
> > +     int ret;
> > +
> > +     ret =3D video_bridge_set_active(dev, true);
> > +     if (ret) {
> > +             debug("IT66121: set_active failed: %d\n", ret);
> > +             return ret;
> > +     }
>
> Just to check: video_bridge_set_active() returns 0 if the GPIOs are
> not specified in DT. If BeaglePlay does not define reset-gpios, this
> returns 0 but does not reset the chip. Is this intentional?
>
Yes, intentional. BeaglePlay doesn't route a reset GPIO to the IT66121
 the chip relies on its internal power-on reset, and we follow up with
the software reset sequence in it66121_hw_init() (writing
IT66121_SW_RST with AREF/VID/AUD/HDCP held in reset, then releasing
them after the AFE is programmed). will add a comment to make this
explicit:
> > +     if (pclk_khz > 0) {
> > +             debug("IT66121: configuring video for %lu kHz pclk\n",
> > +                   pclk_khz);
> > +             ret =3D it66121_setup_video(dev, pclk_khz);
> > +             if (ret)
> > +                     debug("IT66121: setup_video failed: %d\n", ret);
> > +     }
> > +
> > +     return 0;
>
> If it66121_setup_video() fails you log it but return 0. Should this
> return ret instead? If the failure is intentionally non-fatal, please
> add a comment.
>
Swallowing the error there was wrong. Changed it to return ret on
failure; if video setup fails the bridge isn't usable, so the caller
should see it.
  V2 coming shortly.
  Regards,
  Shaurya
