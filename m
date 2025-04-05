Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E23EC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 22:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31E582ABA;
	Sun,  6 Apr 2025 00:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KIoQRx+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35BF982ACF; Sun,  6 Apr 2025 00:07:45 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1BB782991
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 00:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso531365666b.3
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743890862; x=1744495662; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewQYS61yySXXmDszv4wlHR/B6mn9B7OXXDgJ+X5hHmY=;
 b=KIoQRx+6cDOrjhmfAsrJzSV1+v2eceYZ5/2wX2OFK9fU6o+lt8j1F0h127tzJPRQan
 F4lp22kWS6stA5Lxt+pCG3v2wrFrX2pzdsjJw6hQXRQ+oN+xlwV7mNzvx6urGuuuwX4J
 ykuqQ7RvYy/RBjsazWw9YcI3P9+CWjSjWecNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743890862; x=1744495662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewQYS61yySXXmDszv4wlHR/B6mn9B7OXXDgJ+X5hHmY=;
 b=JZHb8+faNEaRXvG94L9q39AkwumCn596UgQcZtCmMN9QeTRodH5ZCgWOg/V/vzFnwq
 M5JQEB5fX6C//IMnW3S5na9bA8dvy00gM/lIbe3pT/npWa3F7sXTI42/GQqb7TXs7aIQ
 omh68HfbdQcSu2PVkunB7rBu7H76GebxeTNq29vWEFAYZkrhyE+cSOFx+vwsbRjpWE6O
 0WWoWYN0/AY9Ufo0E4+n+IeRLHDjvkT6/3zCHQ1ZiZLfiiWLQycLflUU2qrNdn3E5N3T
 3qv5fbNu1C7BEfg9uGiwUKR7RsQEjeI6F5UPEOfj6tz044vztMjSsf3ItGMuMi3yUeBg
 9Czw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqzeiR5dVoeGGlXGsd1hm01iFhim5apYxl9gfw/pTUpIlGIBEMgi87CDQkZUra7OpQsekbH3w=@lists.denx.de
X-Gm-Message-State: AOJu0YywxpM6dXlZJlCOUMcN9t5sFMYiQm4w5q1a39FpWrCCuXqFKXcE
 UWRL+4LCXvLHCd+b363z4mfrllJ8nK8D0oH8NLtJJxJEflMWpg/51Nrb7FPtNQh4T3TMzkLw+en
 5owFjCZG39CKutvVQ3yZctWole6xccZ3OBNcq92DAuM03eMbdHQ==
X-Gm-Gg: ASbGncvHnHb02VgOr0aW4+FNWA1GRP2DHoG71cd150YK+Qydtsju+E4QNF1zmIHJ21q
 gR72JehBWrxzSrW7BYIaf3s4gsXsSGSLGEgA15pV75ZRQBpuBsmLDJJMyTJWAwp9cN1vprGNLuC
 8C4mjnpoZbe+QbXBQNjWIOndwsOwxv
X-Google-Smtp-Source: AGHT+IGrf8G8CNkRc2XLKLXtWR8uOkMxIsrMPey4yfmfKdF/PLWZZiVPPOjnnH7QPzBlpihlQo0K9+iceIZnPu9fpDE=
X-Received: by 2002:a17:907:983:b0:ac1:e332:b1f5 with SMTP id
 a640c23a62f3a-ac7e76510dbmr344394866b.37.1743890861555; Sat, 05 Apr 2025
 15:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
 <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
 <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
 <AED05ACC-AF9D-4A2E-90E3-7BDA597B2DB0@kohlschutter.com>
 <CAFLszTibROtKsE+LZ3cMXvj5MLBf=-6TP98UwxhPfh5eqQK+_g@mail.gmail.com>
 <68D651AB-8E9E-48B4-A062-9E688025F035@kohlschutter.com>
 <CAFLszTiJR3La6dwE6k5QbKMmtVpbq+VK9AYhkmeQSEhgozh1AA@mail.gmail.com>
 <d1bb7301-6006-444f-9586-59ed6f3ca7ee@linaro.org>
 <D94AA922-63CB-416A-8FB0-9CD6BD6785CF@kohlschutter.com>
In-Reply-To: <D94AA922-63CB-416A-8FB0-9CD6BD6785CF@kohlschutter.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 6 Apr 2025 10:07:29 +1200
X-Gm-Features: ATxdqUEAnmjrtmWTb0KkZZ53YMgojhqSqnRDXbnVCQMkASGbOvej1liPR3KRyL8
Message-ID: <CAFLszTiXhm1pZU6Z9O+F=qdRFTzThUTSBQSJd+MvdYO8PcxbZA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_U=2DBoot_interferes_with_initrd_binary_=E2=80=94_Revert_?=
 =?UTF-8?Q?=22efi=3A_Correct_smbios=2Dtable_installation=22_=3F?=
To: =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, 
 Michael Brown <mcb30@ipxe.org>, u-boot@lists.denx.de
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

Hi,

On Sun, 6 Apr 2025 at 08:51, Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> On 4. Apr 2025, at 18:21, neil.armstrong@linaro.org wrote:
> >
> > Hi Christian
> >
> ...
> >
> > could you test:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> > index fde4aabbace..bf9c5e8f349 100644
> > --- a/drivers/net/dwmac_meson8b.c
> > +++ b/drivers/net/dwmac_meson8b.c
> > @@ -145,6 +145,15 @@ static int dwmac_meson8b_probe(struct udevice *dev=
)
> >        return designware_eth_probe(dev);
> > }
> >
> > +static int dwmac_meson8b_remove(struct udevice *dev)
> > +{
> > +       struct dwmac_meson8b_plat *pdata =3D dev_get_plat(dev);
> > +
> > +       designware_eth_stop(dev);
> > +
> > +       return designware_eth_remove(dev);
> > +}
> > +
> > static const struct udevice_id dwmac_meson8b_ids[] =3D {
> >        { .compatible =3D "amlogic,meson-gxbb-dwmac", .data =3D (ulong)d=
wmac_setup_gx },
> >        { .compatible =3D "amlogic,meson-g12a-dwmac", .data =3D (ulong)d=
wmac_setup_axg },
> > @@ -158,6 +167,7 @@ U_BOOT_DRIVER(dwmac_meson8b) =3D {
> >        .of_match       =3D dwmac_meson8b_ids,
> >        .of_to_plat =3D dwmac_meson8b_of_to_plat,
> >        .probe          =3D dwmac_meson8b_probe,
> > +       .remove         =3D dwmac_meson8b_remove,
> >        .ops            =3D &designware_eth_ops,
> >        .priv_auto      =3D sizeof(struct dw_eth_dev),
> >        .plat_auto      =3D sizeof(struct dwmac_meson8b_plat),
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Thanks,
> > Neil
>
> Hi Neil,
>
> I had to make some changes to make it compile (expose "designware_eth_rem=
ove" in designware.c, it was "static").
> Unfortunately, it did not make a difference (I still see ethernet activit=
y impacting initrd).
>
> Is there something missing for "struct dwmac_meson8b_plat *pdata =3D dev_=
get_plat(dev);" (result is currently unused)?
>
> In the meantime, I've tried the patch from here
> https://lore.kernel.org/all/20250405065812.33027-1-heinrich.schuchardt@ca=
nonical.com/
> and it indeed fixes the problem I'm seeing.
>
> The additional benefit is that it doesn't just apply to meson8b dwmac.
>
> Is there perhaps an additional aspect that your fix would address?

I'll send a few patches for this.

Regards,
Simon
