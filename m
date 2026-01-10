Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A70CD277C9
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 03:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09EE8436C;
	Sat, 10 Jan 2026 04:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rJEPcUWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6674684371; Sat, 10 Jan 2026 04:20:43 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 875E5841FF
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 04:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so52824725e9.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 19:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768015240; x=1768620040; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S+2gXt3a+sF0Jfzdi35vkAvFNe6R+weKAWJiyBPZyZg=;
 b=rJEPcUWt9r0AIBHgxJr3x2eE5A5Dj959HGx4w1Gw55r/VWawi5vRwWUTSnb91Sribo
 j0xF39r+MkhYo5sGGjgFmbsYO41qPmNDlQ4e5JzGr+U7JORV9ykIntFDeObrrHCmljVN
 rNR9u1Z7bui9CM1ZVMkADNtb5uI4quUWi8/tW2VAUSVsug6PdJB/zvpz80q5jT4GfUu/
 QcARTD0L1OXZ9vlFMIIl+dlq97SBJO91gB3NfcKm9S936DfsAy2vD8h1zFJCB5Qd9wdd
 XOgmaU7fXL5MdUE4nyq91KhR0CqBIN702xA7QQsYRVgKmurVh51Hut4vAfHVgv78iGUd
 wPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768015240; x=1768620040;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S+2gXt3a+sF0Jfzdi35vkAvFNe6R+weKAWJiyBPZyZg=;
 b=Ltlp/rg10hL481LY7qN9byKmlJeiV4oQr5d4yvz1O3fNLZ5HdT5F5KZXKmWjaSG1Ho
 AI1AyC/R/y39Qdb5Yg+snpzQK6yzE+eNyZ1F80HpD1ArkOBI+1q0S39S4ik6C+0DjxxM
 DlU6ghy2G2lNOl6B34ZD2PIF/Tg/q0AB8WjV34j/CR/JZuzhSLizwSRjgoR4Pqk+8cCu
 XcSsy1u73b1rupy0p7XSRD8LA6Kbb62HHYENsouJgDaNn8WrdjkQDFej/i9Fhay9LXAC
 4lyFIc7zAcNCfSlmd/NzX+g9Ddeq/GEdrvedU9k1EmS3JEmSIdGHtFD4gsyfyumCUyMf
 vklA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgplDy/XMQxFDLXr9Sk/uiJAYkpSopMzVJNiueMu8k0rJxxcYFstJI8PZI1iiacpmIxD0VEEQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwyhqXhSx54ayko4l1EiTL8ywPlmxTNoXOFelh8MV2/q8HbLOSt
 ZeyWDQ2lc5koEyjKdcjKntskwOHzYFNNA4QoPKYp8+Wp00w3VojCtuiK0rK5cyeP5OI=
X-Gm-Gg: AY/fxX55Irk0prKZXJKb+Oj7g0hlEXtiBm3C3uAxGDzgx/gfGSiRxty1Db2o2jSZe5o
 WmiSs5+5O6rtL57iobPtEvqgbplnDQjQlzlE/A6Yb5zrV0WqNVlEjZxfeh/IykXIoaoVfIRfcWn
 mwW+rODnHj9GxdhdLqGqQeA/8nLpz9oa4+/1L+UEYxx3ckTJmQefOUWS0o/k3tGQC1zG7f5ONcV
 7ruHiUweyVOv+/DTUCj3EqKP+VfuCOOgs2ObJ/9dnAzY2u3zWDKPDTtmMveHHt3Ak6vKMtR6EGD
 Wy+4yhmIhf+ZNa0K59hqy4ULGbQ/C3SDfNZLrl/crvrO+WhP2E2s3DRNoF+Uc11ab2rs7L72xxQ
 p8Uk+xV7RgE7w9e7Sylbejsd4cGOsFZcro+8XCraeOPA/Sw9RxgmxzoYqAF8/s03cPCtQuJ3F5m
 +AhnsQu0kAkH2sjRt15Tjq8/d1ZmSwah9WawGwEqW6ATa/keeuoQ0msXD16XbigUUfWK2+FcoZW
 Fkgqs8XXFO41A==
X-Google-Smtp-Source: AGHT+IFI2kQG/DUqgSAY4fMDzWOHyfl27EcsaraDgZzEUHkjp+APVcJ1AVXOtM4AU9LFmv1w8xPFvw==
X-Received: by 2002:a05:600c:4e49:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-47d84b172bcmr133993565e9.11.1768015239850; 
 Fri, 09 Jan 2026 19:20:39 -0800 (PST)
Received: from [192.168.16.154]
 (host109-150-127-3.range109-150.btcentralplus.com. [109.150.127.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8715b5f7sm79699285e9.4.2026.01.09.19.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 19:20:39 -0800 (PST)
Message-ID: <879112a0bf19df9d79bee3dc33557bf382e0d839.camel@linaro.org>
Subject: Re: RV1103B: Attempt to upstream
From: Christopher Obbard <christopher.obbard@linaro.org>
To: Fabio Estevam <festevam@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman
 <jonas@kwiboo.se>,  U-Boot-Denx <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, xuhui.lin@rock-chips.com
Date: Sat, 10 Jan 2026 03:20:39 +0000
In-Reply-To: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
References: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
MIME-Version: 1.0
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

Hi Fabio,

On Thu, 2025-12-18 at 23:45 -0300, Fabio Estevam wrote:
> Hi,
>=20
> I have a custom board based on the Rockchip evb-rv1103 (RV1103B silicon),
> booting from SPI-NAND.
>=20
> I can successfully boot the vendor Rockchip U-Boot v2017.09 on this board=
,
> from SPI-NAND
>=20
> I am currently working on upstreaming U-Boot support for the RV1103B SoC.
> My first RFC attempt is available here:
>=20
>   https://github.com/fabioestevam/u-boot/commits/rv1103/
>=20
> Build steps:
>=20
>   make evb-rv1103_defconfig
>   make
>=20
> However, I am not yet able to boot U-Boot on the board. At the moment,
> the board does not boot and only prints "RKUART".
>=20
> My initial plan was to avoid SPL, similar to the evb-rv1108 approach
> (described in board/rockchip/evb_rv1108/README).
>=20
> Before going further, I would like to ask:
>=20
> Is the evb-rv1108 =E2=80=9Cno SPL=E2=80=9D boot flow a valid reference fo=
r RV1103B?
>=20

Great to see the RV1103 being upstreamed!


I have a Rockchip RV1106 based board, the CoolPi 1B=C2=A0https://www.cool-p=
i.com/product-category/gateway/cp1b/ which I'd also like to get in upstream=
 linux/u-boot.

The downstream kernel/devicetree is at https://github.com/coolpi-george/coo=
lpi-kernel/blob/linux-5.10-gen-rkr8/arch/arm/boot/dts/rv1106-cp1b.dts with =
defconfig
https://github.com/coolpi-george/coolpi-kernel/blob/linux-5.10-gen-rkr8/arc=
h/arm/configs/rv1106_cp1b_defconfig

The downstream u-boot is https://github.com/coolpi-george/coolpi-loader/blo=
b/develop/configs/rv1106_coolpicp1b_defconfig

I wonder how similar the RV1106 SoC is to the RV1103 you're working on ?

I only ask since the RV1106 SoC has a similar prefix to the RV1103. I don't=
 have any other information about the SoC.


Cheers!

Chris
