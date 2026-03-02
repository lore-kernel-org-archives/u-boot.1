Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120F7EA4E04
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF1683F30;
	Mon,  2 Mar 2026 15:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IytAaCH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1309B83F4C; Mon,  2 Mar 2026 15:24:53 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C977483F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso38589285e9.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 06:24:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772461490; cv=none;
 d=google.com; s=arc-20240605;
 b=BBe0Kwq00q/jp9pU4bF5UNbEPV7foSemSitMZXjoXmowZqyeGRIn4uKaYrPJ0vUXCI
 DbucA/WtDWeS9cqwQi9iFbKyXE6WjbAoLoOnaV9f3hrJfzDkZGMo5W7ggWiBT/3B3I50
 W2qPe9gKBovS+hgl0DGs1sJn52Tkunb+MgczuxqVl5Uh7bMawIDidpFEdRoq3W0O9KxB
 oh2mx7Zw4ZkSdq1y2+rDo1d01pD1a6SUS4Ffpx/0lDdshBVbYEoIs2ff6U0e6skqaWRF
 X8HtMzMB2CKRaHePln4t/N6Iega3Osibq7493P3//fCpg5KGKqaoBR0l2pnFR+AP2lPf
 StYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pzh4z7+aLLoaTMuLv0e7jyp8Mw3bCR9RhE/Z3i6Gs8I=;
 fh=ZEIURf6Y5NawSaMgE/TuY3zsZfPG/++1gnv7iVOhirc=;
 b=JD3FzirSLi3tyB5NrBsP6mT1rP50s0VQUji0AeUKcclH3aYxp5agddJhiErthj/Z2X
 5l+VD1DNHphXBSWE3B1I/tTJYZhu7ar6skv594KPoxEsWgg777MSI3I49xZoGsl+e1Jq
 kEqxnkWVIOrT35I/gSLiI8AhhThgg2zTTNiEMDCtqtQJQ8dIfHKDfbL7N4YMPWMOcgdx
 b8jPoek/KjnKuQducmRMUlxVsL191QuT4722AW3IE6PQEMcH1FEc3XM9w1uoiXX5gnus
 Dld0DVTw+lD6tn3ZmQg4LNuc60eBMcMNBAKUvOcaxIqVDspKLGXBVxeaIZWJQQ3fbT4O
 tfmQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772461490; x=1773066290; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzh4z7+aLLoaTMuLv0e7jyp8Mw3bCR9RhE/Z3i6Gs8I=;
 b=IytAaCH5ao6IxZM0dTWxzh9cqiXH/lTO1UynRAAhfLQvW8wS7StpX/UcqUS3l0k8C2
 7xfuhkK+4LPnWofK65AmeG2eDsj58iSd3DfpPpCjECHrJMA64vCRUHdIT/WLJ4s29De2
 SpTXyfXzzSLxvmz/AeVb5gGf7zibUZ+Rm+d0fo/RgPXMlZ0NcOnYJDvZQR16bTPhn4aD
 qBq/N1G6C9ZuHWRfTGsEFaKYSIHHNMLeupxoltz+mzubU9GQRbcvJhUMHN/WRljQqR+g
 fdgE9SI6ixB53kwcIkimIHXhZFUZwQu646nzHG5yOh44LH4gK3oTRbRPgbO7DVAM7jwE
 9ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772461490; x=1773066290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pzh4z7+aLLoaTMuLv0e7jyp8Mw3bCR9RhE/Z3i6Gs8I=;
 b=asGZPPHGY2mH6Iw/FlPUWfOIifMq6IepB5PNVrqEWMuXCUOVp38fUh0k0/fAxQubJU
 RBOfFHh2cafl0LEikJ5E10yx9jnmeS5lWH+cBqLGWLvesym9ZCyyDH1LHbXnmtO0XwND
 0ZnFbX6hRXczmOvOILCF9DDLRxsLrXlNXxtBW+sLMu/WSNgeMSP+fvgZ8NpYSrX2nvI4
 Ax9BCuTCutTiLn7Z3yOxLuZHFYNjFLZFGtaF03Q/XWhtw9tANxJ2Y36MsdYnoRTYOqt+
 YnOGZ3sOyM4ZyBZchQaWJy1b33TNtB1NQneV/j3btgbMF0g3mfn354NLzerVL8ffXm9E
 UrzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVheldxipG3fg8IvFNB8GU6i5OhtvdN5PI0Dz5f8BpZg6MxZ2sBZ15ZvcK6gVfb/ixDRI0Vk10=@lists.denx.de
X-Gm-Message-State: AOJu0YwARQuvjj54BjCE/DhsX38oN3lUXsJMeu/H7+OHYGRlHaFvD1sW
 gBgpIQGLvudVIY44UEyh5yBWuH24hNud5WSPI76IvMoRhTecWSt2MqJaGttJFdcLkzKdmxfDw07
 06UgExrt/YmVSqd1ih2vu7lgprtasSQM=
X-Gm-Gg: ATEYQzzT/nYoI5EWy7QT3DxUkqLNKrxjdCvUjno/Kra/LL/pujJLDdAttk0h57UQ/EY
 8k9bLyBGGBFgGwbfA/7ZILyYhkALGKDFpA0xldgggJTPcDQbpOBXBxfQ0UNDROq9c1Bee2nddn+
 2xMw3HPG2AcaFonkZhkybDIxHARjGoIFNy6Q2ElfDJScPP23xMZzqpdcyrUDKgqNdtKDYFJFFu9
 zlosuU4bTXC1Ejij3b8VVhFyFX4gyRjtJZLYGI0I05weF5ABRDAIzp7t3VeXtwps1zGrl6gVxZo
 MzJirQoJ
X-Received: by 2002:a05:600c:46cb:b0:483:2c98:435e with SMTP id
 5b1f17b1804b1-483c9c0dd2bmr204201365e9.34.1772461489494; Mon, 02 Mar 2026
 06:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20260209183948.34807-1-clamor95@gmail.com>
 <20260209183948.34807-2-clamor95@gmail.com>
 <564aefbb-f2cc-4409-a9ed-a599f517fe51@cherry.de>
In-Reply-To: <564aefbb-f2cc-4409-a9ed-a599f517fe51@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 2 Mar 2026 16:24:38 +0200
X-Gm-Features: AaiRm52EzZVQ6OzdfJZo8hDQnGsQYHAFTi-RFuJxVKzWSvEM5dMJRbqHyo5spVI
Message-ID: <CAPVz0n1xP_HV70RZaBNXMgNdyo+nEbMc2DcfTeDPoXUweH6Dzg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] power: pmic: enable sysreset function with device
 tree property
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de, 
 Andy Yan <andyshrk@163.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Christian Hewitt <christianshewitt@gmail.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
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

=D0=BF=D0=BD, 2 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 16:13 Quent=
in Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 2/9/26 7:39 PM, Svyatoslav Ryhel wrote:
> > Add a condition to enable the PMIC sysreset function via the
> > system-power-controller device tree property in addition to the existin=
g
> > Kconfig dependency, provided the PMIC supports it.
> >
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de> # RK8xx
>
> I've added in Cc people who have contributed to devices that will lose
> support for sysreset once this gets merged.
>
> Because they are missing a system-power-controller property in the RK8xx
> PMIC Device Tree node, the following device trees will be impacted:
>
> dts/upstream/src/arm64/amlogic/meson-g12b-odroid-go-ultra.dts
> dts/upstream/src/arm64/rockchip/rk3326-anbernic-rg351m.dtsi
> dts/upstream/src/arm64/rockchip/rk3326-odroid-go.dtsi
> dts/upstream/src/arm64/rockchip/rk3399-evb-ind.dts
> dts/upstream/src/arm64/rockchip/rk3566-anbernic-rgxx3.dtsi
> dts/upstream/src/arm64/rockchip/rk3566-powkiddy-rk2023.dtsi
> dts/upstream/src/arm64/rockchip/rk3566-powkiddy-x55.dts
> dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
> dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
> dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
>
> If it's an oversight, you may want to add the property in a -u-boot.dtsi
> and upstream the property to the kernel DTS to avoid carrying it
> forever. From my side, this patch does what's expected based on the
> (lack of) presence of the property so this is a green light for me
> regardless if the above Device Trees are actually wrong.
>
> As far as I could tell, the sysreset driver only implements the poweroff
> functionality which can be called by either the poweroff CLI command or
> the efi_reset_system_boottime function (no clue when/where this is
> called, some EFI thing I guess).
>

I actually expected such an outcome. If you are fine with it, I will
drop the Rockchip PMIC change for now. It would be quite unpleasant if
a bunch of devices suddenly lose their reset function, especially
since updating upstream trees can be a long process. Once the trees
are updated, anyone working with Rockchip can submit a similar patch.

> Thanks!
> Quentin
>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   drivers/power/pmic/max77663.c         | 4 +++-
> >   drivers/power/pmic/max8907.c          | 3 ++-
> >   drivers/power/pmic/palmas.c           | 4 +++-
> >   drivers/power/pmic/pmic_tps65910_dm.c | 4 +++-
> >   drivers/power/pmic/rk8xx.c            | 4 +++-
> >   drivers/power/pmic/tps80031.c         | 4 +++-
> >   6 files changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max7766=
3.c
> > index c2a7cbf7e40..a06042e2918 100644
> > --- a/drivers/power/pmic/max77663.c
> > +++ b/drivers/power/pmic/max77663.c
> > @@ -46,7 +46,9 @@ static int max77663_bind(struct udevice *dev)
> >       ofnode regulators_node;
> >       int children, ret;
> >
> > -     if (IS_ENABLED(CONFIG_SYSRESET_MAX77663)) {
> > +     if (IS_ENABLED(CONFIG_SYSRESET_MAX77663) &&
> > +         (dev_read_bool(dev, "maxim,system-power-controller") ||
> > +          dev_read_bool(dev, "system-power-controller"))) {
> >               ret =3D device_bind_driver_to_node(dev, MAX77663_RST_DRIV=
ER,
> >                                                "sysreset", dev_ofnode(d=
ev),
> >                                                NULL);
> > diff --git a/drivers/power/pmic/max8907.c b/drivers/power/pmic/max8907.=
c
> > index a7ef70177de..34bef0c8cd6 100644
> > --- a/drivers/power/pmic/max8907.c
> > +++ b/drivers/power/pmic/max8907.c
> > @@ -48,7 +48,8 @@ static int max8907_bind(struct udevice *dev)
> >       int children, ret;
> >
> >       if (IS_ENABLED(CONFIG_SYSRESET_MAX8907) &&
> > -         dev_read_bool(dev, "maxim,system-power-controller")) {
> > +         (dev_read_bool(dev, "maxim,system-power-controller") ||
> > +          dev_read_bool(dev, "system-power-controller"))) {
> >               ret =3D device_bind_driver_to_node(dev, MAX8907_RST_DRIVE=
R,
> >                                                "sysreset", dev_ofnode(d=
ev),
> >                                                NULL);
> > diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
> > index 37d4190fabe..e5b497dfc39 100644
> > --- a/drivers/power/pmic/palmas.c
> > +++ b/drivers/power/pmic/palmas.c
> > @@ -48,7 +48,9 @@ static int palmas_bind(struct udevice *dev)
> >       ofnode subnode, gpio_node;
> >       int children, ret;
> >
> > -     if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
> > +     if (IS_ENABLED(CONFIG_SYSRESET_PALMAS) &&
> > +         (dev_read_bool(dev, "ti,system-power-controller") ||
> > +          dev_read_bool(dev, "system-power-controller"))) {
> >               ret =3D device_bind_driver_to_node(dev, PALMAS_RST_DRIVER=
,
> >                                                "sysreset", dev_ofnode(d=
ev),
> >                                                NULL);
> > diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic=
/pmic_tps65910_dm.c
> > index de8d805566a..bce35603275 100644
> > --- a/drivers/power/pmic/pmic_tps65910_dm.c
> > +++ b/drivers/power/pmic/pmic_tps65910_dm.c
> > @@ -61,7 +61,9 @@ static int pmic_tps65910_bind(struct udevice *dev)
> >       ofnode regulators_node;
> >       int children, ret;
> >
> > -     if (IS_ENABLED(CONFIG_SYSRESET_TPS65910)) {
> > +     if (IS_ENABLED(CONFIG_SYSRESET_TPS65910) &&
> > +         (dev_read_bool(dev, "ti,system-power-controller") ||
> > +          dev_read_bool(dev, "system-power-controller"))) {
> >               ret =3D device_bind_driver(dev, TPS65910_RST_DRIVER,
> >                                        "sysreset", NULL);
> >               if (ret) {
> > diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> > index d11f7a7886e..95b71d2fe49 100644
> > --- a/drivers/power/pmic/rk8xx.c
> > +++ b/drivers/power/pmic/rk8xx.c
> > @@ -220,7 +220,9 @@ static int rk8xx_bind(struct udevice *dev)
> >
> >       debug("%s: '%s' - found regulators subnode\n", __func__, dev->nam=
e);
> >
> > -     if (CONFIG_IS_ENABLED(SYSRESET)) {
> > +     if (CONFIG_IS_ENABLED(SYSRESET) &&
> > +         (dev_read_bool(dev, "rockchip,system-power-controller") ||
> > +          dev_read_bool(dev, "system-power-controller"))) {
> >               ret =3D device_bind_driver_to_node(dev, "rk8xx_sysreset",
> >                                                "rk8xx_sysreset",
> >                                                dev_ofnode(dev), NULL);
> > diff --git a/drivers/power/pmic/tps80031.c b/drivers/power/pmic/tps8003=
1.c
> > index a2f935b0c6d..6004a14cd6c 100644
> > --- a/drivers/power/pmic/tps80031.c
> > +++ b/drivers/power/pmic/tps80031.c
> > @@ -46,7 +46,9 @@ static int tps80031_bind(struct udevice *dev)
> >       ofnode regulators_node;
> >       int children, ret;
> >
> > -     if (IS_ENABLED(CONFIG_SYSRESET_TPS80031)) {
> > +     if (IS_ENABLED(CONFIG_SYSRESET_TPS80031) &&
> > +         (dev_read_bool(dev, "ti,system-power-controller") ||
> > +          dev_read_bool(dev, "system-power-controller"))) {
> >               ret =3D device_bind_driver(dev, TPS80031_RST_DRIVER,
> >                                        "sysreset", NULL);
> >               if (ret) {
>
