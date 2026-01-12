Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12355C9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1436D83A79;
	Mon, 12 Jan 2026 14:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qSB0ekAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D57AC83D0B; Mon, 12 Jan 2026 10:31:15 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5AA283CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b87108066c3so125228466b.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768210273; x=1768815073;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7/sFnTplQwHu758oZ11YPALPskwGSL3ZXtjVlUOmSk=;
 b=qSB0ekAXYFG3wuCcvl9Mo2fLaeBwN1euwWunPTOBKgS9lmebSy74GDb3LyWK0EGIB0
 +vNR5fYp7JkWHWfmEKTpxZzw0IHulkTqG733yDgSFawYjkoPc5n8+JziuiN1snHB8prd
 KGwFwsKjIYUDMgB3/+lH2yVh7ov047YQjkqCwnzAMTd+c61VwFpEYErN6zKvSjHCTj1h
 tUMPzm/jZFKeBjJSf2uevNcwlx7MyxULsis2qaPXGcnC+wwVeV3LRTYt+Z2NP7ZC1pbn
 ELmmNZCyxjD7RStO3gcSVkDXwsvsnzZATGLHqbj4z9/jpWu5ljfI67z7vqdF/AbgFXPp
 k6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768210273; x=1768815073;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7/sFnTplQwHu758oZ11YPALPskwGSL3ZXtjVlUOmSk=;
 b=PJCpmnL+t9knnpl7ZEZLvvM0uSV4XK5Vmnr4YK5uKfU8A7rtn/nTJqmmKEu1gLLrx2
 504W7xepb7AN7Q61o1oZd80H7g8xUdr45/qZxUmjjOSOf0eHZSRCiZrJ6/D33l/3ElYO
 NPv2kJSS7SbJDTcRqtS5N6UKD9GaqKuiGxr8oWTMwOzbHr/dgOcKAjPavuMVFUi85GG6
 pxncJ24ON7+ALAfFK9t7T5gg1gF4AkSBLGIvqSX22qo17Vkst64MW5y3ngR7lH0EFFtp
 201c6wDNAgTKLvRsV06ItIl/2Tc0JcvnrKv/jIK/RpibOcrWshj1WJAeBvha3KbVLSuw
 Kbsw==
X-Gm-Message-State: AOJu0Ywba+lNzBeTE0lq/N+W1VNfeRzT0VmpQAezEh7zlze04I1vJWRU
 /JUb2YGob92UWcxGXqoNB9SRmv32Ebn7AJSdMIuOnTW41CVuEL/CR1PARtmwiooCQg8=
X-Gm-Gg: AY/fxX77zr/MUhRis39fKpy9/N2smD1YmpZLw91ElAIxkDAYaqn9/8MJH563SYTpDP2
 EeqaxyQBxk033ruOASOJGeAuL7x5tyVxaEVcnNKdCoD4FkZmreUD1P1ewUmkulKBgaI7QuEYPyX
 AH5dPzzF+Ci3VJM1nX87XnmG8DmHY/eFaOa6D6GryWiCNKsvrLEzMv5BDZQPdZ9O82pf6gI8NSE
 pURks+moiDxCX/3ynTeKGENpQWWAHJB6V0Vf1J8/5RlvaXBe1okfZk/37x3LSXIy3Trpt4NfTYX
 +fORj7RlmzsRQM77gTqwEp3UuqUeXdDhaOAVM3qud1SSp1uQU4+ba2JaUaBY7VqBcs3DpQfdYbJ
 ZB7j9G0dtytbvDlCwy9GppnjRaIgycBKP7JUDGv2sW5tf1h5E3w3fnQwUmb92nF3OvR08HKkgu7
 AL/AY=
X-Google-Smtp-Source: AGHT+IG70bOKMuTtPLB2KIGB/XkEQJe9KuryJaxS/HXEoyKHGx1y0cEssU3mQihfhqXamPcTgeibOA==
X-Received: by 2002:a17:907:1b21:b0:b73:6f8c:6127 with SMTP id
 a640c23a62f3a-b8445031bf9mr1800461166b.12.1768210273151; 
 Mon, 12 Jan 2026 01:31:13 -0800 (PST)
Received: from localhost ([195.52.31.202]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c446esm17344143a12.6.2026.01.12.01.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:31:12 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bd4648c25e98f97b475da13f8dfdaa04a148275e35b2296aaeb2a79f2587;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 12 Jan 2026 10:31:03 +0100
Message-Id: <DFMI8576QX69.WDXJM34H19Q6@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Mattijs Korpershoek" <mkorpershoek@kernel.org>,
 "Tom Rini" <trini@konsulko.com>, "Marek Vasut" <marex@denx.de>, "Andrew
 Goodbody" <andrew.goodbody@linaro.org>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Christian Marangi" <ansuelsmth@gmail.com>, "Dinesh Maniyam"
 <dinesh.maniyam@altera.com>, "Heiko Schocher" <hs@nabladev.com>
Subject: Re: [PATCH v2 2/6] dm: core: lists_bind_fdt: Replace found variable
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Simon Glass" <sjg@chromium.org>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
 <20260108-topic-musb-probing-v2026-01-v2-2-2a47c6e0e73a@baylibre.com>
 <CAFLszTiNU=2cJTkB2c8d4NrFZ7K0KR7LQnPYO0TWzX_BuBrUFw@mail.gmail.com>
In-Reply-To: <CAFLszTiNU=2cJTkB2c8d4NrFZ7K0KR7LQnPYO0TWzX_BuBrUFw@mail.gmail.com>
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

--bd4648c25e98f97b475da13f8dfdaa04a148275e35b2296aaeb2a79f2587
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Simon,

On Fri Jan 9, 2026 at 12:32 PM CET, Simon Glass wrote:
> Hi Markus,
>
> On Thu, 8 Jan 2026 at 04:17, Markus Schneider-Pargmann (TI.com)
> <msp@baylibre.com> wrote:
>>
>> 'found' is only used at the end of the function to print a debug
>> message. No need to maintain a variable if we can just return 0
>> immediately when a driver was bound successfully.
>>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  drivers/core/lists.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
>> index 52ba6c7bfa007b660b854de62c97ad3c1761f1a5..9d1ca38212ee7f53b8894f96=
4f096611c8ec20a5 100644
>> --- a/drivers/core/lists.c
>> +++ b/drivers/core/lists.c
>> @@ -204,7 +204,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode no=
de, struct udevice **devp,
>>         const struct udevice_id *id;
>>         struct driver *entry;
>>         struct udevice *dev;
>> -       bool found =3D false;
>>         const char *name, *compat_list, *compat;
>>         int compat_length, i;
>>         int ret =3D 0;
>> @@ -275,14 +274,14 @@ int lists_bind_fdt(struct udevice *parent, ofnode =
node, struct udevice **devp,
>>                                 ret);
>>                         return log_msg_ret("bind", ret);
>>                 } else {
>> -                       found =3D true;
>>                         if (devp)
>>                                 *devp =3D dev;
>> +                       return 0;
>>                 }
>>                 break;
>>         }
>>
>> -       if (!found && ret !=3D -ENODEV)
>> +       if (ret !=3D -ENODEV)
>>                 log_debug("No match for node '%s'\n", name);
>>
>>         return 0;
>>
>> --
>> 2.51.0
>>
>
> I like to have a single successful return at the end of each function
> so that it is easier to follow what is going on. But since you wrote
> this patch:
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>

Thanks for reviewing. If you prefer I can redesign this as well. But
also note that the function already has two early return 0. One if the
device does not have a compatible list and the other for pre_reloc_only
if pre-relocation is skipped.

Best
Markus


--bd4648c25e98f97b475da13f8dfdaa04a148275e35b2296aaeb2a79f2587
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaWS/WBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNU
1gEA/03fpu7AjzzvmxAwyCfC6hVk+ttbwCsnB+4QTS+dXtoA/jbaZyB70QPDZ466
1Tguq8YqsaouNLygXjKp2siJe/MH
=mnOr
-----END PGP SIGNATURE-----

--bd4648c25e98f97b475da13f8dfdaa04a148275e35b2296aaeb2a79f2587--
