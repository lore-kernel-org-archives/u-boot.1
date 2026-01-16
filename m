Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806B4D47CCD
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BBE82BF2;
	Fri, 16 Jan 2026 11:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PwlIMpB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C302A80077; Fri, 16 Jan 2026 11:14:51 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 745E582BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so443487566b.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768558489; x=1769163289;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=38huhAlLx5azMD+Fr2Iplc0XTdlV1w9nwL9J9kkZgBY=;
 b=PwlIMpB8khr+X58Zrg2SlQQTArhYZjdAo1Jz6a5S1YJ7QumzsDfL8Vl5I97Vfpvj89
 M0cHxtkvNh0A1IrMllphVJlINBuFBudrpo535j3rBGrNAnSSmu0U9evjjsxAWTvyHoaq
 ZBe61oL9ESxfp5q6jDrIx/qo+sXeR6vur0P2gRM/jAHRnuIcd2vchG6tlIyhaIWmZE9g
 iCE0l0xyyISBI9B6wVUQuWvJYehwVF0oTavKCfiHYolGFNU+pr63I40HTBgGfPALInrV
 4SbMhziYD0deODEOG/L1ucRaflXcL4DipYy0CJK7LMvlwn9ygV8ukuDkNlWVmfGvzyB9
 PUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768558489; x=1769163289;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38huhAlLx5azMD+Fr2Iplc0XTdlV1w9nwL9J9kkZgBY=;
 b=gmNgFfR080hV6fattG+IvJOX268LMbsnT4l7xXlV+GssGKQg3mCtCIKxTNbcxaNrZW
 xxM4E49HQ/lpBXBQhwj6lTVXb+luugqt1FaNT2ucCkml3du1V2CaotHL6FCH+EhmtjIz
 UjHncxF8+OOW2mFoxLju5Bg18D+WLLAG/td60yoDl3weA201EIRJWqGJ9n4jDhyZctZN
 of8iIaZHVXdGddfIj3gxzBwdJcPBM1z5edKSnd5JrSlru8+2l6LoR/qv0z24luIxnrxK
 ht+2SCC41eqq7VpzPV8xHwIK3sAhIZflaC1eVZrvBARA0OVgGmZFJW6cfXtzisEgJvNk
 4LZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLYUp+FQsEDFG2rivGC/F1aYE6HrTi5slXvOqvUfkIdNTa+h9UO3UA0YuCkDSxLokB0ZublJc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl6riik2e8HHot/9YH5IZIbaDO7Ytxwf13bi4m82QwP133O1q1
 w8oYOmX+f80FtvBiIOZDyMMK70meab3SvrxumOHpr2a5natIrtCUVtWJ0UohWSanliHb1iB2kHG
 l5jhj
X-Gm-Gg: AY/fxX7n41gko9/ZH5AS5jwBFy0gCP4e9HGVQMugi2i0iSkEHmwBP/I4ZWdQS4SOMcg
 vToezCS1BQgw4bdDh3cT9z9Nv4X/A7PtNE/0bpbu7K66tvKiEYRe4IivLm+/Kwb14TY5Nnddd9B
 34IUndqDVzqn4iR2MQ39rWdRMHkK4IAPvEzJtVqtt6Wu0y2svEHfT8zoExuh8UG/qFFZw8BdI/m
 SzBWmrJiZ/yQDZeRnjoR8h8ULpbV4QYjdOP9aBMuoRnJuQWWQdWd1h4eWhFQQJ4cP+BqMN4uDU+
 dZs+Vlg+ymCoq9qAD0SBIRwN8V6Sap+RWulItWmk3+3/obZAnQOMq6+Q7G/2VJbRyhuJG7GMepF
 +7pQqRIW6u0qX+WrNWLqxxbqoefzSu9uqeCEZ7aI5+V8jn8P9k6IYGFdcECBQ3pgBKGMiJRTVvN
 LuiBU=
X-Received: by 2002:a17:907:9814:b0:b76:7e0e:4246 with SMTP id
 a640c23a62f3a-b8792d68449mr246733466b.12.1768558488835; 
 Fri, 16 Jan 2026 02:14:48 -0800 (PST)
Received: from localhost ([195.52.31.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fc273sm190619466b.54.2026.01.16.02.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 02:14:48 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=dc70ad8088c8f78ce4d93b5d3e20feae9ba1a21b55ad6cbe2d2032224c5f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 16 Jan 2026 11:14:39 +0100
Message-Id: <DFPXNPI6OKK6.273FVAY2JPQBR@baylibre.com>
Cc: "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Marek Vasut" <marex@denx.de>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Kory Maincent" <kory.maincent@bootlin.com>,
 "Svyatoslav Ryhel" <clamor95@gmail.com>, "Christian Marangi"
 <ansuelsmth@gmail.com>, "Dinesh Maniyam" <dinesh.maniyam@altera.com>,
 "Heiko Schocher" <hs@nabladev.com>
Subject: Re: [PATCH v3 5/6] usb: musb-new: Relative ctrl_mod address parsing
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Markus
 Schneider-Pargmann (TI.com)" <msp@baylibre.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-5-ebb8d990b9df@baylibre.com>
 <87ikd2dk5j.fsf@kernel.org>
In-Reply-To: <87ikd2dk5j.fsf@kernel.org>
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

--dc70ad8088c8f78ce4d93b5d3e20feae9ba1a21b55ad6cbe2d2032224c5f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Mattijs,

On Fri Jan 16, 2026 at 9:41 AM CET, Mattijs Korpershoek wrote:
> Hi Markus,
>
> Thank you for the patch.
>
> On Wed, Jan 14, 2026 at 09:33, "Markus Schneider-Pargmann (TI.com)" <msp@=
baylibre.com> wrote:
>
>> For the upstream DT the ctrl_mod node is using a relative register
>> address which is not translated by the current code.
>>
>> Make address parsing understand relative addresses.
>>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>
> I already reviewed this in v1 and the patch did not change in v3:
> https://lore.kernel.org/all/87v7hdzge3.fsf@kernel.org/#t
>
> Can you please explain why you have dropped my Reviewed-by?

Sorry, it wasn't intentional, it seems I missed adding your Reviewed-by
on v2 and then it is missing on v3 as well.

Thanks for your review!

Best
Markus

--dc70ad8088c8f78ce4d93b5d3e20feae9ba1a21b55ad6cbe2d2032224c5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaWoPkBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMi
kQEAsFzSmi5Ji50SwAPVLsZ/7vFiVb8k/LunFQTls0QqWVwBAJwqPv8Zjh4iBDjo
1Jvu+TabVyKywgWFnYxjWC/7Nk4F
=wwwy
-----END PGP SIGNATURE-----

--dc70ad8088c8f78ce4d93b5d3e20feae9ba1a21b55ad6cbe2d2032224c5f--
