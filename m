Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348D5C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 16:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659DC800C2;
	Mon, 20 Jan 2025 17:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKJQajH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C129801CF; Mon, 20 Jan 2025 17:42:07 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53381800B6
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 17:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso32625385e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737391324; x=1737996124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVPp2o15ya5nLXWtzz/e9q/lKwTJqeEhK0+mxLZJB4c=;
 b=DKJQajH+QAA3rEW9UUrMh/Y/lDQGzpSLxv8oInVkwlpR+LyeuPjbr8LmudJ1m3X+4/
 ykjUmZ9H2u7LimQllkdUVmcorBiCRK2tvw/guADQ4XLdUXXjia5dKxQmF3VOk2kE5HgR
 U81/ZyG2G3Noch0L5oH2/CH1GxSwvm5/kRsa8h4RXZM40LabJgqCdfq0iAtTaOt1W7lw
 jEnNY6ZlNL2DLBTtvs+aEoY3P9G4vK6OznU8G5XgqY1v2GeYqu1QosRFy2sJcj6I+wCg
 rHlNnWBPFQr5nuf5vFj07IAjNOGiTOvmqPhTlLOLVThyyF0fT9vyQ8ET+dKZUre7f5zQ
 Emvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737391324; x=1737996124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVPp2o15ya5nLXWtzz/e9q/lKwTJqeEhK0+mxLZJB4c=;
 b=ASZ66qbDMndVYQsrmXUkaiuvkyTiBDWULUw8J7kw60Mb2iJamoZl0S7bLo6mIuLWwf
 zZN8xF7bzqWcV3ufLlcKqANsNWYDfGeq1+WzfzeRD8dKNfHXJ5e263TS3jO57qJ10iY3
 HJ1C4FVJSbHwg26+RnT5gzxT+DcWxNI0BGteetPwXvTGg7xTHhGbiVIKDbZegdZUyomo
 ty4YIWDc2uJGgW5OkcqWBdkLe62EpId5uBsb9y+S+c8AQWmCmXK+76COHYEXNt/vs626
 6vub2VYl6a1k2nI8zWLbOX7ejphesdXxuuSLSGZUcNZ3KuySHyehc34+/h22n8Yn3X7q
 +xpA==
X-Gm-Message-State: AOJu0Yx7CBSM6O7LYeXg6FGHgDAd4+GVhIkB9nqqhY00RjjXnvrp2HIZ
 IpUBgj8etneqAyfEv7pCFIMVg9vO5Vypum5zMEX/xQ8pQaLTBI4W
X-Gm-Gg: ASbGncv1OmWIqu75gwqoV4qY23YZhDGnrfAYxiUFQhhVGGQJx+XaYccnMqH9lS2+1yA
 DbK11Rzs1PIYZCMcp36ZEGx/QEfVr0Cza7DnUEFasdhi08qDyqc/yLaO1xk74pkvvqimcr2dYxJ
 HnSns+f4i8BfbNK4bByyIBa/Oi4XigzItIlurmNKBGOF2hOpSEtT+Iws0Cvgy8682KupiLvHHu3
 JkYjQXKmmXSB/bPXgkZIKtXV9Dube2cJSg38NhNFqybtcnp+isF/syySo2O6BUlB/j56jkKyPM2
 cZF6Q5JbASEcTochtoGj9Ozyib2znHk7JZZpoAe7cBdigw==
X-Google-Smtp-Source: AGHT+IFHP7otWNbgEg2It8KWJWZdnxatAWrDP5T4lXoq8OUr9c2R8TiIBVFTqLbF8tjClAYFN3XleQ==
X-Received: by 2002:a05:600c:4e89:b0:434:f739:7ce3 with SMTP id
 5b1f17b1804b1-438913cb518mr126509645e9.8.1737391323563; 
 Mon, 20 Jan 2025 08:42:03 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890412f7csm144213735e9.9.2025.01.20.08.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 08:42:03 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 2/8] sunxi: pmic_bus: support alternative I2C address
Date: Mon, 20 Jan 2025 17:42:02 +0100
Message-ID: <4622391.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20250119222530.1fd97018@minigeek.lan>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <2352334.ElGaqSPkdT@jernej-laptop> <20250119222530.1fd97018@minigeek.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 19. januar 2025 ob 23:25:30 Srednjeevropski standardni =C4=8Da=
s je Andre Przywara napisal(a):
> On Sat, 18 Jan 2025 08:21:31 +0100
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> many thanks for the review and your opinion.
>=20
> > Dne petek, 17. januar 2025 ob 02:45:31 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> > > Some of the X-Power AXP PMICs can be ordered with an alternative I2C
> > > address, for instance an AXP717 could be shipped with address 0x34 or
> > > with address 0x35.
> > > The datasheets for the AXP717 and AXP803 list two possible addresses,
> > > and they are always consecutive. For DM (DT) based drivers this is no
> > > problem, but the Allwinner SPL code relies on a hardcoded address.
> > >=20
> > > Add a Kconfig variable that will add "1" to the existing address if it
> > > is set.
> > > This enables to use the AXP717 as used on boards with the new Allwinn=
er
> > > A523 chip.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
> >=20
> > This works until some board vendor start mixing one or another address
> > PMIC. Note that BSP boot0 does address autodetection, so it's not entir=
ely
> > out of the question. Anyway, let's hope we don't see anything like that.
>=20
> I looked at the datasheets for all supported PMICs, and they either
> state one or two supported addresses, in the latter case both
> consecutive. Autodetection sounds nice, but also unnecessary: we surely
> know what address it is for a certain board? And with those A523 boards
> having two PMICs, autodetection might become sketchy, as we don't know
> for sure which PMIC we got?

Speaking for T527 BSP boot0 - they check version register to make sure that
correct PMIC is installed.

>=20
> But that got me thinking: what about putting the I2C address in Kconfig
> directly, with defaults depending on the PMIC type?
>=20
> config AXP_I2C_ADDR
> 	hex "AXP PMIC I2C address"
> 	depends on ARCH_SUNXI && !SUNXI_NO_PMIC
> 	default 0x36 if AXP305_POWER
> 	....
>=20
> That's should work seamlessly for all supported PMICs, and we just need
> one line for the Avaota, same as with this patch here.
>=20
> What do you think?

Yeah, looks more universal and avoids code changes in pmic_bus.c when
adding support for new AXP PMIC, which is very nice indeed.

Best regards,
Jernej

>=20
> Cheers,
> Andre
>=20
>=20
>=20
> >=20
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > Best regards,
> > Jernej
> >=20
> >=20
> >=20
>=20
>=20




