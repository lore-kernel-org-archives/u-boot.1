Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5997BCF884B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 12:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8FE83D3C;
	Thu, 20 Nov 2025 13:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iIVYDf4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56589840DE; Thu, 20 Nov 2025 11:43:06 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C24AC840D8
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 11:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso456754a12.1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 02:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763635383; x=1764240183;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PLcJD6Ksacyj5aFbu9kzydGcTTwL+GQLCDE53dkO+8E=;
 b=iIVYDf4cYF2cX6RNXu4ndY5BdVBrSC9a3MfGKkad5VIZeGZIcsIXd3Ud2ASYA/BTOT
 coQagexIjcNbedGj1yf3GFkgEhWC4Ph22MFiPQNKSO6LPlhxfYBgESPZha1H/QWAuHPM
 PxMU/o68GJfwpB40HavggkWBxLuxyrqH/UMLnk2ea2EgoEqQizHCqdKWBaeSdGgFTIEx
 8L5cHcaVwyYQZ8LLrBOUORmJreIO9vACd7EkOAwgABicqAeIJogTWygk6Jt5HfCoyJmW
 QjHBI0fqpG1meZLNpIYAXlIe/vIBOF6Zihn0XTjkWxufxYW8KOarkjhBu4FDrCJlsExI
 mWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763635383; x=1764240183;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLcJD6Ksacyj5aFbu9kzydGcTTwL+GQLCDE53dkO+8E=;
 b=eNsw7aToCaaFcU+5PRX7rqAPh2j/V33NOUqJH15PJLR5Anz12tC3D/R6TrBCz6cjcn
 SMmHmZHNH+5+J/3VJWxOL6oMSzt3/318Ggno7jOftJcAIuveNmpuYLSHETIsOxzMHRMh
 KqgrClgGjUaklNFb+1+RB9Jc6aHLvRtaGX1Ihkh6KTemW66e+q4W/kYI3gOuPomOqmk6
 jGXlvhCcwsE82NxXo9IhRoGUKGsOuqV7+HFIKqM4OukmgF8htw3oe7eSi+v1W7pjhAcc
 0lAvDaOUJCn1ivnrhTrQ5HL+r8yVEu1qwOjlTEH9T5XnaBE2rEmmNbXQds3LUbcer002
 VIrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvFly9FEFBAhK3daqZKf8MH45U89KFjj0nHcfLolEDRdPi9CFQU1UAVj8W7BQDSAIZ8ZXytb4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx12B8kJq1OQoW2C6xJz+HTU9Fz11XWpUILVgMoK0bweUpESE3z
 KW0v4GkrPUJpcS1Cj6oL6NSAX+rcbcBfN50Ru13Hbffuwx6/zzI8HC7dITETdBHZ9YU=
X-Gm-Gg: ASbGncuqFeTf9S+u5FKCvpDe2yidrt0xlEeFZ/d5WTy1l+oZ1VhB6zfYuggn5wcx8ua
 nFAHFAiXfarcmLCbM/Y5WB+1hdyMnouj8FNHW+iYZhhs563bHqHfQaR+OVOby4+/L1FLmwkLYX0
 VsNoi1QgWObOEHoro3r6SrXgGkh1GUfRrsqPVzgDTVRz4MDPMwe3nABOAwicykj0C/Nv8+ns6zZ
 fcGH3jKsGnZmLmvE14syz/XnZj84Cmd1+SLF9uDSryTaw9RBpKNvptZDJpSz1WWo6lLEFHxxxoh
 twfQHwZ2kq2nIxukOIBdjv0J2ty7Dx6FrZDbXBrBEZuesWBPBmcVGw40sqjaQTWNOmOz3opL+fB
 vrn5WdPBw2vOV5cbmBaOwyfWk++4Fuxq2TSkXCJDi8gJwge1VBI3Puj4mrZc9QCxAr2An3Uxo+i
 2i+QvD
X-Google-Smtp-Source: AGHT+IGdAj5Kdk3U6dQbycsi+k6aO6Qj1yBfq/tZSUGOnLhQp//KYXvYALkYPb0z/fDSkwu8f/kUaQ==
X-Received: by 2002:a05:6402:2743:b0:640:cf58:47f9 with SMTP id
 4fb4d7f45d1cf-64539674067mr1788760a12.9.1763635382617; 
 Thu, 20 Nov 2025 02:43:02 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6453642d32csm1779243a12.21.2025.11.20.02.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 02:43:01 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1b1c4d19f16a5607247aaf8ccf806e5bb5f0abe001b4c6c335f7d7bffdc2;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 20 Nov 2025 11:42:53 +0100
Message-Id: <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
Cc: "Maarten Brock" <Maarten.Brock@sttls.nl>, <u-boot@lists.denx.de>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Rayagonda Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
 <tien.fong.chee@altera.com>, "Alif Zakuan Yuslaimi"
 <alif.zakuan.yuslaimi@altera.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Tingting Meng" <tingting.meng@altera.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, "Liya Huang"
 <1425075683@qq.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Romain Gantois" <romain.gantois@bootlin.com>, "Simon Glass"
 <sjg@chromium.org>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Marek Vasut" <marex@denx.de>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Anatolij Gustschin"
 <ag.dev.uboot@gmail.com>, "Sukrut Bellary" <sbellary@baylibre.com>
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
In-Reply-To: <20251118140804.GR2125796@bill-the-cat>
X-Mailman-Approved-At: Thu, 20 Nov 2025 13:33:19 +0100
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

--1b1c4d19f16a5607247aaf8ccf806e5bb5f0abe001b4c6c335f7d7bffdc2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tom,

On Tue Nov 18, 2025 at 3:08 PM CET, Tom Rini wrote:
> On Tue, Nov 18, 2025 at 11:40:28AM +0100, Markus Schneider-Pargmann (TI.c=
om) wrote:
>
>> Currently once a driver matched the compatible string of a device, other
>> drivers are ignored. If the first matching driver returns -ENODEV, no
>> other possibly matching drivers are iterated with that compatible of the
>> device. Instead the next compatible in the list of compatibles is
>> selected, assuming only one driver matches one compatible at a time.
>>=20
>> To be able to use the bind function to return -ENODEV and continue
>> matching other drivers with the same compatible, move the for loop a bit
>> to continue the for loop after -ENODEV was returned.
>>=20
>> This is required for ti-musb-host and ti-musb-peripheral which both
>> match on the same device but differ based on the dr_mode DT property.
>> Depending on this property, the driver is either UCLASS_USB or
>> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
>> function and returning -ENODEV the other driver can probe instead.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  drivers/core/lists.c | 62 +++++++++++++++++++++++++++------------------=
-------
>>  1 file changed, 32 insertions(+), 30 deletions(-)
>
> This seems like a big generic change (with potential performance
> impact?) for a rather specific case. I assume the linux kernel simply
> doesn't have this issue by handling OTG differently. So is there some
> other way we can handle this here?

I didn't find a nice way to do this differently. I did have a different
idea to do this by overriding the compatible of the parent node of the
usb devices. But I didn't like that idea so I proposed this solution.
But I would be happy to hear about other ideas.

For the performance part: I don't think this reduces performance in most
cases. This will only add overhead through additional iterations if a
driver with a matching compatible has a bind function that returns
-ENODEV. In all other cases this should not add any iterations to the
loops. Grepping through the code a bit, I don't think returning -ENODEV
in bind() is widely used at the moment.

Best
Markus

--1b1c4d19f16a5607247aaf8ccf806e5bb5f0abe001b4c6c335f7d7bffdc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaR7wrRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMc
lQEA+E/55bsBcfb62pIgYwEz7uQImyHPf9Kiu9xOlV/zzroA/258F4m0X35EmEKt
cxHp4zwTxfsdBOXbT1CgQ0MrNzII
=ePpJ
-----END PGP SIGNATURE-----

--1b1c4d19f16a5607247aaf8ccf806e5bb5f0abe001b4c6c335f7d7bffdc2--
