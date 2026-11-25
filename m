Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F3606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cdUpS5DX;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZn/QxeE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12FBC80F8C;
	Wed, 25 Nov 2026 18:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMUBGYBpotzv; Wed, 25 Nov 2026 18:22:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BF7180F66
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630952;
	b=FmOoOO5+ppYft6S8qn0ZECqZz/BCM/b/E3QObowBEgjOOv1MHaSOkqB8KW2o9cJ6xDxm
	 FHXQJX3LSyOmp1wB1OfFjKKGkqt7fq2lGy3tUJCDixU6uIvQzfUSQREZwjYZS5WgwpXiX
	 PsGX1EUfV/CRO1WbxMdH+dfkxhUmTVO/rrkDwx7a5ebOc3opV8u4HcOcA+SiitMiDJe4b
	 7/0hZX3UCWIPB5uAMs8s8TtFNzHUeru8dWtOIy/xCLgjFMEpJ3sPGKOc6oC5FgOjeCZk0
	 VHohEPx4BYwawBwFq1eYJeAdhIj+Q6Vqc1NTyaMiqhGhQS2Xd1tUNaNBY4BGZPpbYIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3n0zaE8HdOzffRwhaGLk+0p0/yGlc0n6JnnYXKRqkmg=;
	b=REV6EOEhzCn5zU6I/M4nytrp3xNg441xLIf1dEeFOd6T8d/RqQOc1v9fsIS0O/J8PmLj
	 cUBNggYlOCC52RrgXDJAgssYyFaqC9Nr73qHF6GJ9mcub6CfDqLOUIEjRGREYSXRyVslr
	 EuH1JkBPfpcyedibBfCRGNCI+kBobyul4omnuFkJfTilykRscF8jlGRPWlLPhhNWJYE0+
	 MuW+PDg22G/TopdQ0uUARNSO3+1yFWFtlr+EH/QiiANrHx67SNg1p62nTlNnxvc1OdLuY
	 +60rtq+apKtOyA4opL07OM8DNHjBdt3Wvr87r4uGyhmyrgSFgX0tj8pnamOltYutInw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630952;
	bh=3n0zaE8HdOzffRwhaGLk+0p0/yGlc0n6JnnYXKRqkmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdUpS5DXD3idg3QEJ1JTD7eBGFF5hvk8jzw4+POKdxEtSBBN9xleZfV+LfG3PehMr
	 2qKV7m/VmCBqcMTUIYVSnq+WPFks6pPm6IM+xSW4Mo/Z7zRNaf/gd0HrRwg2p7CVYQ
	 8R/kIbq8p10vbze4mrIPRR2HuWIziBqoqkKfP/+1CIhxwSU2oGaAOACTy+lHOraEh/
	 nyI67sit1v05NO2t46Ptnado5eQnAtlhAHKN8lZlfTeLQbVSt515rwT5j6E9EfYFxS
	 veevBwEQa5cEelobSO+57928LcrlwaVpMwRRXNk+MU4XQN7TMqTujmfIfmfpRIOe1d
	 593hn4sjWVYtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BF7180F66;
	Wed, 25 Nov 2026 18:22:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DB68325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FE0F400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:22:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_luUm6sH2bg for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 18:22:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A167040050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iZn/QxeE
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A167040050
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:22:28 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3adfc004920so58554171fa.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795630947; x=1796235747;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3n0zaE8HdOzffRwhaGLk+0p0/yGlc0n6JnnYXKRqkmg=;
 b=iZn/QxeE/9uE1oRwlUN0TzKWZ2FUIjepY58qWRKGeFB9+8IOtq4i8C7DhJgf1IJEMg
 TCYy7Z8H1wYrXWKRGSliUx43lqRSolObXo3WCG8IAFyBEAwBFgN0R8TrHd11ANP2KVf7
 O64DAwnMr6cy8l1vA7Ljgy/+WG8uxlyOwzKcZ3mcQGLxbS5sGgQwybK/vW5BSrMM4r1E
 uQz7MYovRUXCYzXmwGaG9jTmMi0T3zF5rD9fbJwthxnFHbtGkApl7+oGV9C1K3OjtBV6
 o7HEkHqAKZMPnQ81Zic+ly7387QJ3cLeVP4bSurZwPVFBLDXqqh6aRl7Y5LKLI8KcTZ1
 twNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795630947; x=1796235747;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3n0zaE8HdOzffRwhaGLk+0p0/yGlc0n6JnnYXKRqkmg=;
 b=uNfX7fyMD/NULLHSKKuA+o2e6eOY7D90MZKUQ3foUyG4FD8muT22W99xVU8sw8UFrs
 ZfN+H8vq+Gt4MQFcT4U4IdIXKfeuYHLAY/7YglrRYKTl5Z5Em/VRcKdP4ov6InoyzV1Q
 OPwEnp6vtmafV5RVHtkVTIoD0AjErVq778QwPKdoUKzxG0b+WfdbgSKFh5VsXG8IarX8
 Y8pi4nhCI4Y8oM1JPGHpjKwygq36Yniyn8zCYUUTx4xpGagHf+2inGFrqiuyywsSn45S
 u0CuxEqmLe7bp2SgjOgh5aDX8UZV+6OpMVzZ5mswXNfWxGJJ98w1VNBCF73kjsSxP09K
 ns/w==
X-Forwarded-Encrypted: i=1;
 AL+hErH9VSuLvE9+dhFXG+f4n7Iq7jPTm+87v52zCP0XY+QbAo7UXZKsoqBCZ6jrVDE3VmnngEEQztg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/6abCITdZjGudSP7B2TfDgLz6UHIRdYgkHL2Jvgf6wHid3Rthh
 AaqAYJ+VLVz572/ZeZDfJBAwguQqfmXPoONJbxGU2fPprfGn9jaAJbJrcb9cAEwjqmr0hFN7xJH
 7R0PC6DFjbSsk9Eg6+zA1ZQonNmwRuw2z4Qlf
X-Gm-Gg: AZFdTZcTymqlc0MmjqZUWza0KAM5Le+NCMI7OEux1wCa76kc2Izs5Ii4lNjoU8rX/o6
 kVahFc7sK2I6ogStAmnhuW+ngbiwNj048uRNYrokHnmnCmcaHIqvReZ2pL9trHoefzEx+uQwGVU
 7nQKKkpnoz0w271C1RW6ix0qIy7FoSbVQxz66f3p0C1G8v8bbsCVsOLKr1X5GzfMHe7hIPkaIrv
 yMoGvDtEtg1YW9zv/Sv7grUGLkaWHNg8YkCT0jQmc/doXM2CdLBzNVyK7mI9gEUgULwz2wN6QAP
 uNASVZuf6c5/NNklvry7NDqIDyWjZIJm22gsdh4HN41O8FWDhtHmbgK7AAsDZs0C5wkz6eOboXH
 D+W5hPPxiL/d6RB2rnanjEfylqDAoJmcqKrxy1lAmL+Q+MmeLQBlAo68zDLsCEmSXumUUAMgrDx
 hsCqia0m7e/j0+CC53KrSwDeTp7g==
X-Received: by 2002:a2e:be84:0:b0:3ac:e26b:d9cc with SMTP id
 38308e7fff4ca-3ae7fa3ac7cmr61186071fa.23.1795630946724; Wed, 25 Nov 2026
 10:22:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114-91qsb-v1-0-046293559467@nxp.com>
 <20261114-91qsb-v1-2-046293559467@nxp.com>
 <CAOMZO5Be6ZrFPJJEg=oQeXb-Erh0G=KUsUdnVjptu+36W7PKgA@mail.gmail.com>
 <AS8PR04MB8721165C7000B6521E995163E2452@AS8PR04MB8721.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8721165C7000B6521E995163E2452@AS8PR04MB8721.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Nov 2026 15:22:11 -0300
X-Gm-Features: Aa3M54pEUbvo2_DYwCShqlH7mWvmTwYpKh-KhweJxJoT2CAsAX7iN8f7xFi1dMU
Message-ID: <CAOMZO5C2Hdtk8w+6O6qfa2nWRiT1Pif4fb4a1T_f=65CR-WBSg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 2/3] arm: dts: imx91-9x9-qsb: add U-Boot
 specific dtsi
To: Alice Guo <alice.guo@nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 krzysztof <krzysztof@kd-solutions.pl>, Joy Zou <joy.zou@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Johan Jonker <jbx6244@gmail.com>,
 Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alice,

On Mon, Nov 23, 2026 at 6:19=E2=80=AFAM Alice Guo <alice.guo@nxp.com> wrote=
:

> Below is explanation for each item:
> - wdt-reboot
>         Its compatible "wdt-reboot" exists only in U-Boot.

This one is OK.

> - usbg1
>         Its compatible " fsl,imx27-usb-gadget" exists only in U-Boot.

I grepped for fsl,imx27-usb-gadget and it returned nothing.

> - firmware/optee
>         The current defconfig does not enable OP-TEE support, so I will r=
emove it in the next revision.
> - &A55_0
>         This clock assignment already exists in arch/arm/dts/imx91-u-boot=
.dtsi, so I will remove it in the next revision.
> - EXT1_PWREN
>         This GPIO is used to enable MP2147GD output to provide 3.3V power=
. I will move it to the Linux DTS in the next revision.
> - SD3_nRST
>         Linux uses this signal in the following way:
>                 usdhc3_pwrseq: usdhc3_pwrseq {
>                         compatible =3D "mmc-pwrseq-simple";
>                         reset-gpios =3D <&pcal6524 12 GPIO_ACTIVE_LOW>;
>                 };
>         U-Boot does not support the mmc-pwrseq-simple.

Please add mmc-pwrseq-simple support in U-Boot.

> - u-boot,off-on-delay-us
>         This property is only used in U-Boot.

Is it possible to avoid using it and use whatever solution the kernel adopt=
s?

> - fsl,signal-voltage-switch-extra-delay-ms
>         This property is only used in U-Boot.

Is it possible to avoid using it and use whatever solution the kernel adopt=
s?

> - extcon =3D <&ptn5110>
>         This property is used by the USB gadget driver in NXP downstream =
U-Boot.

If it isn't used in mainline U-Boot, please remove it.

> - &clk
>         The deleted clock properties are U-Boot-specific adjustments.

> Please let me know if you think any of the remaining entries should also =
be moved to the Linux DTS.

Please keep -u-boot.dtsi as minimal as possible.

Thanks
