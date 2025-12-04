Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97656D2A532
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4478405C;
	Thu,  4 Dec 2025 21:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0aWJtHFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8478405C; Thu,  4 Dec 2025 20:03:38 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA9884051
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b73545723ebso202915266b.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 11:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764875015; x=1765479815;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M09cFstP90rGGsY47tSZPSfvLcgz5YDoWuOHheOm3js=;
 b=0aWJtHFDbdQ1E21FtmpTT9j3970Zq4m5qW3CBT2JUwrdVxRm4Hdgczv/gbOwWD6CbO
 clknNxNL6c7gtTDxs3T89uFxoXFeFd/KTANpgdTvblxK8t6gIgUIUuXySpd3MezYcGtc
 Z4k61Uuww1ERIYuAWZ1XIK9Oc3DgkG861zz0HuFeSsqgFi6XBEuaTrLkGcaPq/GNV2g9
 SfeWtM5XM2kqdonWWPKIvELaT2EAc7F9J+g1ZYFrvT/aCVjSPAchqQ5Q7rDr1dGmPb0i
 hy0vSzLorrrht5VKg2z+toRo658y88roZrlOjNuJZf6XD5FNrFKTvowHSH7PqbCgmiYA
 f2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764875015; x=1765479815;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M09cFstP90rGGsY47tSZPSfvLcgz5YDoWuOHheOm3js=;
 b=NUOu0dvhmifwSTzUJHYW/zTsKI3nUh4NHAV4aHaqpNIRYXa1I81+KVe1sXHmcsCTvm
 l5nJceyaThu2yVIGIxLGjIrEIFo0NFNQPwGTDuBr6n7RahPcx3DTNYUXcwqoSrVa6jqv
 ++Dofh2OZMVxtuxasF5uZMMxMR4nAlN63k3kzy1dsyw0ndiT5osxXP84ChXQ9XdKJY4a
 q/JIh/Gw7nEGrhQqbnotncvHminLlc1lYvmrZv/PEyQSpOCG9ycfTmYsmkquz/+Xbuuk
 jrMv5ax3FgzV489XKgPxhaxfM9Bu1Ln8NHHiOZwTL4c7Sigo6/X3y4cFX5xf/BQxriDH
 0keA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvcm8tmQEYAqAups+UUTUVfoXXXV1HXtrVFAkS8MFSnlQ0ZtBiazweKnVZ3mZKodeEEADfd7g=@lists.denx.de
X-Gm-Message-State: AOJu0Yws5Cf9CrLqwFXsCA0E8/UYKjsPnCa7MeZV8HXO7WOa4x3NN5KK
 oTVQOXAn8N/C4pPke7veUKDH5v6Ywc8AEvh2KmoLwhDdt6PFo1IELxfqvajqFpxxMAg=
X-Gm-Gg: ASbGncvdFfYaxxCXr6UAdtVEmOJxsWyx2B0uCEO0869srgorsYreniWAy3DJXd4Gs8j
 FxzZyMHnGiR+bQMdKLJmh4onQvPwp0kJnIWVdmLCBRBJ35TuiS035ZLvADvyXGpIxq1jsAdtT5S
 rpTjEINuDaSyBjBp8yUv1FtjREgkiXjAa3dU/DugPY2vn4EDtLRY50VPJQ5O9AeG0HqYvF9vvbA
 sM1jgrHR5AacAfjpcz82fUiTQx2DzXBuymuHXCgj/THoMIT9Mx1PNqjZMqLsV1xImFzP9NuhDct
 g78wagctL4kfH+ILuCfWTMwVCjsP+exUT7Mz91CQi68wCOmwikqcvTMk9YUtWn/cLKHv05ImVxa
 GWP2Rmh89GorZAEASE5sOd50PUc8av4f54cXoG2N3J50gKG8KstQzG4erz+G3RPZBT6d3V6a75W
 rL7EA1
X-Google-Smtp-Source: AGHT+IHtlwHpy9MmPmOiAcMlxhAttR1xEdjk4RuhNS+pVwMMhNno0RjjwxJbkROqG9DvvNZuIO867A==
X-Received: by 2002:a17:906:4fcb:b0:b76:3b3f:60e9 with SMTP id
 a640c23a62f3a-b79dc75b301mr708098766b.45.1764875015299; 
 Thu, 04 Dec 2025 11:03:35 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b368dcf8sm1905095a12.19.2025.12.04.11.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:03:34 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1c4d632a17c0a206ee3f0c167a8002f8ff47310955902c96bc4d6e386280;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 04 Dec 2025 20:03:26 +0100
Message-Id: <DEPNZ52FI5M8.3ECX0AF0I9OYR@baylibre.com>
Cc: "Tom Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Kory Maincent" <kory.maincent@bootlin.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>
Subject: Re: [PATCH v3 4/9] configs: am335x_evm: Unify evm board defconfigs
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Andrew Davis" <afd@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, <u-boot@lists.denx.de>, "Marc Murphy"
 <marc.murphy@sancloud.com>
X-Mailer: aerc 0.21.0
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
 <20251204-topic-am33-evm-oftree-v2026-01-v3-4-3d1566ce4dc7@baylibre.com>
 <42e52490-e940-4382-853c-e8f7029b7c91@ti.com>
In-Reply-To: <42e52490-e940-4382-853c-e8f7029b7c91@ti.com>
X-Mailman-Approved-At: Thu, 04 Dec 2025 21:31:27 +0100
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

--1c4d632a17c0a206ee3f0c167a8002f8ff47310955902c96bc4d6e386280
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Dec 4, 2025 at 7:43 PM CET, Andrew Davis wrote:
> On 12/4/25 4:25 AM, Markus Schneider-Pargmann (TI.com) wrote:
>> Much of the config symbols between the evm boards are the same
>> independent of the actual board. This patch creates a hierarchy for the
>> am335x_evm configs:
>>=20
>>    am335x_evm.config
>>    `-> am335x_evm_defconfig
>>    `-> am335x_evm_spiboot_defconfig
>>    `-> am335x_hs_evm.config
>>        `-> am335x_hs_evm_defconfig
>>        `-> am335x_hs_evm_uart_defconfig
>>=20
>
> Idea looks good to me, but why not have am335x_evm_defconfig be the top
> of the hierarchy instead of a new file? Same for HS, so something like th=
is:
>
>      am335x_evm_defconfig
>      `-> am335x_evm_spiboot_defconfig
>      `-> am335x_hs_evm_defconfig
>          `-> am335x_hs_evm_uart_defconfig

Yes, I would like to do that as well (and tried), but there are symbols
set in am335x_evm_defconfig that are not set in am335x_hs_evm_defconfig
for example. If I remove that symbol like this:

  # CONFIG_... is not set

'make am335x_hs_evm_defconfig' will complain:

  generated_defconfig:87:warning: override: reassigning to symbol CONFIG_..=
.

I don't know how to get rid of that warning without the additional files
I introduced.

Best
Markus

--1c4d632a17c0a206ee3f0c167a8002f8ff47310955902c96bc4d6e386280
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaTHa/hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMa
RAEA8NUMGcBLHJ0VmJ1rKiMekA43zvtWxCpnInsBIL3S49IBANYCoWLcndHfkitl
eX6FwQd2JY2J1rPth0/qBBK00jwM
=UrCX
-----END PGP SIGNATURE-----

--1c4d632a17c0a206ee3f0c167a8002f8ff47310955902c96bc4d6e386280--
