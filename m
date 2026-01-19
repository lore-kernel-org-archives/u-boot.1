Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E8DD29C4D
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 20:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D83A8397D;
	Mon, 19 Jan 2026 21:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2wk9xGmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248E683981; Mon, 19 Jan 2026 21:18:36 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8B88389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 21:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64b5ed53d0aso6591853a12.3
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768853913; x=1769458713;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8HQqUvau5LNN+3txNmZIBfbNc/2zhBpm1eGcD8J09d0=;
 b=2wk9xGmiTZTz43J0Irtl7Bm0d5N2U9VI7U2+t7yAEVn7krXxUzhW7uKa7ZENAAJ8/q
 EuiUQBfZxDc/kF157NQbYbUUEkXh4vscSf05i8BJIyvoRkXBMWLho4+CYs2zBL1rapFi
 xgDjE/B5dPe1gIsdEUTZDQHCJpvF5UWypdpN+3HvJaZeApPhK0eemCPhQMHGV/SG0s8z
 1HP/kPfSo4xl/OyZwx+4JxG4ACdB35iYuhUrMTRQA7HXPpezDwNfbd3Lz/0N06o/j4sm
 ssuv8YTsCBD56vBox5PF8SXnGhU5YrC8p7OVjJdiEPXKiCnrE0sgPiKD7NfSbnn0Kcxc
 1m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768853913; x=1769458713;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HQqUvau5LNN+3txNmZIBfbNc/2zhBpm1eGcD8J09d0=;
 b=wAwfqY5v5DOpcmb47VStqFZEVtHGRnaPpj50lArCh/FDpgRyofd53DR/xntAU87kNg
 QQctj2Qjn3y4B6JOIEpGPqnDfo3lj8GkBnp5wa9OL+Ui5WctTWUROPpEePFx2wi9+OdZ
 /+/JMpEMGlj6RdCshk6nvBLWUkDOSkt9tjMO1KRomAG4GHAEkalaVP04HTNjcfhJo26h
 I7PpdSoRm923NNW2GW0KPw5f5Uk/mgoJ8RILC8Jp6UZI6YaR3kR095cq48/ZAro4/l3A
 sG3R9kz6D1WFsr7uPOMnbAfrGRgHLRzE+eg8VEN7pmXBeeDqwW0RklxQ54Ui6xaTfOfc
 nszg==
X-Gm-Message-State: AOJu0Yz+bWTTusan38QzM7YEJQYFOKxRrjPDz4TGLpUtIMJHjR2A849d
 jsKwZ0JN9+z9Ux898VK/A+2n/I9BtXa0Nis54mos9d9eRiXWX1bvRp5eEVGxde2rYos=
X-Gm-Gg: AZuq6aJL5pS20mcOXaRBE/Khgb6oZ6oFcmFPvQDZ+9CJSuX6Gtv94YHkoLWC5WqyrXF
 i8bjtbOHfi/eRBTzOuJN4lpG+ZFI2f2RjfLD6OS3M+fU4OhFDf2bjRVfL4Sbdk3MaNNQJuWi0p9
 Otvk2JIaz/bGDY0R1M+Xnlv+v5zsLdk42qEcFLJ335eqZN9UAz3MEKoZByfrzKAZqeC5rJTKKxJ
 QnUvKqA/dsPZAy87eL/bcuGxZG5T7BPrs8axJPvIgE1Apa9WV6Sl8yJvyKkXI4+7LAS08cx74ps
 YbP7QlG4DVdegpDTWxo6wEUvEK9F2f3pE3OYsQ6dtd5fLUe7eRmGYvVUlFrMs6eXcx6IFOUyOkL
 91ZDUEEuAIZGDEIufDrpm2bZSalQZzb3NF40SPzvzZYb1+Cuj+Od5kMymg7Dx7lzC4StobW4PMv
 r9JQ9sOeBlmyG1yg==
X-Received: by 2002:a05:6402:40d4:b0:64c:69e6:ad3a with SMTP id
 4fb4d7f45d1cf-65452bcc007mr8781264a12.27.1768853912578; 
 Mon, 19 Jan 2026 12:18:32 -0800 (PST)
Received: from localhost ([195.52.31.202]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4b8csm11387498a12.35.2026.01.19.12.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 12:18:31 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ed712b458932e33743c2bf7886d1ea936feef459c8fbb02fd58c1d7bd28c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 19 Jan 2026 21:18:23 +0100
Message-Id: <DFSUDL3M20M9.106GFGSL1U8V5@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>,
 "Rasmus Villemoes" <ravi@prevas.dk>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 0/9] arm: am335x: Switch to upstream devicetree
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
 <20260116184517.GA4105729@bill-the-cat>
In-Reply-To: <20260116184517.GA4105729@bill-the-cat>
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

--ed712b458932e33743c2bf7886d1ea936feef459c8fbb02fd58c1d7bd28c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tom,

On Fri Jan 16, 2026 at 7:45 PM CET, Tom Rini wrote:
> On Thu, Dec 04, 2025 at 11:25:36AM +0100, Markus Schneider-Pargmann (TI.c=
om) wrote:
>
>> The series is split into two logical groups:
>>=20
>> - Patches 1-4: Fixes for am335x-evm to boot and support the LCD panel
>>   with the current u-boot devicetree.
>> - Patches 5-8: Make upstream devicetree working with uboot. This
>>   adds tick-timer, adds compatibility of the board code for different
>>   USB probing and updates the defconfig.
>>=20
>> The series has been tested on am335x-evm. Note that I don't have all
>> other boards built with the am335x_*evm_*defconfig, so tests are
>> appreciated. buildman reports builds are working.
>>=20
>> Dependencies:
>>   - clk: ti: Cleanup common functions and omap-cm
>>       https://lore.kernel.org/r/20251128-topic-am33-clk-regmap-dep-v2026=
-01-v2-0-451b4f4e7e85@baylibre.com
>>   - dm: core: Support same compatible in host/gadget musb drivers
>>       https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-=
0-ff8d8c487130@baylibre.com
>>   - simple-pm-bus: Make clocks optional
>>       https://lore.kernel.org/r/20251128-topic-simple-pm-bus-optional-cl=
ocks-v2026-01-v1-1-e38040c88b6d@baylibre.com
>>   - video: simple_panel support for am335x evm panel
>>       https://lore.kernel.org/r/20251204-topic-am33-evm-lcd-v2026-01-v3-=
0-ca74853bd5f0@baylibre.com
>>   - power: domain: Add ti-omap-prm stub
>>       https://lore.kernel.org/r/20251128-topic-omap-prm-v2026-01-v1-1-72=
c5cc4c7728@baylibre.com
>
> All of the deps are now merged. Unfortunately, this now overflows SRAM
> by 80 bytes, when using the gcc-14.2.0 toolchain from kernel.org that CI
> uses. You might need to look at enabling LTO here, which I haven't tried
> in a long time but recall had its own problem unfortunately when I did.
> But that was years ago, and perhaps is no longer a problem.

I wasn't able to reproduce the issue so I reproduced it in the same CI
container, as mentioned on IRC.

LTO indeed helped in the container with gcc-14.2. But it failed for me
on gcc-15.2 where it produced code that is too large.

SPL_OPTIMIZE_INLINING is currently not set for am335x_evm and I think
this is a safe option. It helps both for gcc-14.2 and gcc-15.2. Are
there any pitfalls with this option that I am not aware of?

Thanks!

Best
Markus

--ed712b458932e33743c2bf7886d1ea936feef459c8fbb02fd58c1d7bd28c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaW6RjxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOA
LAEAhHc3vVan9GV7fhXVjoRZtQ/N9b6/mXUBdT/rDFPFqzwBAMhL9XIuILPPM+2Z
JQRPa2veQIXcSvEW21YFJNM/8VEI
=7mAn
-----END PGP SIGNATURE-----

--ed712b458932e33743c2bf7886d1ea936feef459c8fbb02fd58c1d7bd28c--
