Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB6CEDDB0
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 15:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A03F83E52;
	Tue, 18 Nov 2025 16:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eVjnDBPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B85C83D07; Tue, 18 Nov 2025 16:13:49 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5867883BD2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 16:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64074f01a6eso109310a12.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763478826; x=1764083626;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NqYFga2DWfzorTRj9goTpvbgfX/UPyGs0GhUu4hVI3I=;
 b=eVjnDBPbn5J6odEuH2hk8CpdrTFRtHgXKWpLt8Qkeav/tz3J8Gqu3Q04IguRmJMgsi
 OFXTzptxef6mIighxjPwtvR5JFGqNyVTYb6Uh5t9csvdwBcBOce85blAI5a95G/DqoIV
 5HW36Nc+RuKNjiqDd+4ulW9VrE/VsUdUIZ5dcLns+QmzLDzWS5lGd3OD2qs+/DBNsKYS
 vz02qBzQwh/WYENXUjqMd6Pu3F95E93S1CLcUCP46YDJGbXvK7eU4enznIYz1JVm80pY
 ENjskBhWS0d+69kRRWTpirmmGRzH1BUR1Rljm/6Yj2jjuUjArBWTT9ad9SPO8rPaQb6G
 xArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763478826; x=1764083626;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqYFga2DWfzorTRj9goTpvbgfX/UPyGs0GhUu4hVI3I=;
 b=nKrXd3ik9WZqK/d++MIN9CJ2y4isuwPxwaTz1r+iWiZ0aw21LXX0gSMe+0HQWOwIvY
 C1b60StkWkNwTQql3nstk6h3KL+JT6HLtR34RDBM6u9rNks54sAzwuoqi/5cnXbkvEQC
 dWBJDeDWWu5FbnAI4HfnBA4FZBCi1DywE7l4cs+2+3/SOkX5Nn5CNYFb20eAV3hAjMPt
 qfpe+cfAn8IVULHs3bk1IdP6WeccUUrOjFqS7bFiueBBCaEfBs1o0vv3ccNyLsMSQP1P
 kLElgvZxWgoYNJ07+nP0dXft1MoLHKcMzRnDovdIvqKKgvHz4wyUttklSkTu7W3EXCSW
 jgkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEDJausMJZ4tnpwhlpAaAAzHH45pviLWMwKO0DB9/i0FSOWPvpJTr9VsgNqtMaJOXu0xEOdo8=@lists.denx.de
X-Gm-Message-State: AOJu0YxTydCJrcvqu/w6fQZMllXcyPaJzFEZhZvOG2b6C1aLe1uRo8e4
 xgwBW4JqRcSgixKH8aa1H89498PXBvnpQ6j2UP2U/6iePSNelov5sAN0rjbDgevxkAU=
X-Gm-Gg: ASbGncsgz/7LxJdd6jbu8RaTx4f1rMOU6ZB7bAE3EgOVhOm2AWe8uzQxNFrHyZdVgQ2
 wS82srt2GAru3sts5gCC3fwXhVQNnJpuqaMTVQRzFxT6k6UAxtIlZqffm/6hpdrrcRHlQZlTDj2
 iU5cfjAlhgN+giwGT6ji87eUNhzWjCJZmFLtheCX0YYbU8gh7+Np7hVJ9u/8spL1mzyXPYp+uWP
 Pf4VePg6eTxYImOkUwFA6qYcdIrxBMf3cKfLIk4vGP70dztVkTYJO3lcSIvC55RTEvdSzmTlkJ5
 u+FqqYFy+mgq5UuMmXeQmdC9KEtVnSQ2rSU+7xI697t95IOu6OAFG9nNJ5DywgzAEsSckciKY0T
 hiLcVTPlIZ9XRL1thtCuFOBgd5s7dyivFw634T3wRLT3IH++r3/u6vmh45MSRE10LY/NE1A==
X-Google-Smtp-Source: AGHT+IE2NfhLUbuXhNeGNfzPgBpPt9SrArMd+JQtD+yHKZK2xYGJhxkLdXbU406jniy5zrw1YCF5FA==
X-Received: by 2002:a05:6402:4549:b0:641:8a92:9315 with SMTP id
 4fb4d7f45d1cf-64350ec1631mr12466748a12.36.1763478825700; 
 Tue, 18 Nov 2025 07:13:45 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a3f96e2sm12822338a12.16.2025.11.18.07.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 07:13:44 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bf9dfffefbd63c222f04aba96417a12de6f1dbaa20ae7e0be280d48552be;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 18 Nov 2025 16:13:38 +0100
Message-Id: <DEBX2HALA2IZ.TTWB8DQX8TO1@baylibre.com>
Cc: "Maarten Brock" <Maarten.Brock@sttls.nl>, <u-boot@lists.denx.de>, "Tom
 Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>, "Rayagonda
 Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
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
Subject: Re: [PATCH 15/15] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-15-91ce13c661e2@baylibre.com>
 <20251118120356.15234bba@kmaincent-XPS-13-7390>
In-Reply-To: <20251118120356.15234bba@kmaincent-XPS-13-7390>
X-Mailman-Approved-At: Tue, 18 Nov 2025 16:24:05 +0100
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

--bf9dfffefbd63c222f04aba96417a12de6f1dbaa20ae7e0be280d48552be
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 18, 2025 at 12:03 PM CET, Kory Maincent wrote:
> On Tue, 18 Nov 2025 11:40:35 +0100
> "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:
>
>> The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
>> required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
>> power domain driver is requierd as well now.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  configs/am335x_evm_defconfig | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
>> index
>> bd188c252780fb541afbbe61a243bddaab79be93..994be4307b81d25a4a8ade4d25feb4=
4651cd43ee
>> 100644 --- a/configs/am335x_evm_defconfig +++ b/configs/am335x_evm_defco=
nfig
>> @@ -3,7 +3,11 @@ CONFIG_ARCH_CPU_INIT=3Dy
>>  CONFIG_ARCH_OMAP2PLUS=3Dy
>>  CONFIG_TI_COMMON_CMD_OPTIONS=3Dy
>>  CONFIG_SF_DEFAULT_SPEED=3D24000000
>> -CONFIG_DEFAULT_DEVICE_TREE=3D"am335x-evm"
>> +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/am335x-evm"
>> +CONFIG_OF_UPSTREAM=3Dy
>> +CONFIG_POWER_DOMAIN=3Dy
>> +CONFIG_TI_OMAP_PRM_POWER_DOMAIN=3Dy
>> +CONFIG_SIMPLE_PM_BUS=3Dy
>>  CONFIG_AM33XX=3Dy
>>  CONFIG_CLOCK_SYNTHESIZER=3Dy
>>  CONFIG_AM335X_USB0=3Dy
>> @@ -50,7 +54,6 @@ CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dnand.0"
>>  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dnand.0:128k(NAND.SPL),128k(NAND.S=
PL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-=
spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1)=
,8m(NAND.kernel),-(NAND.file-system)"
>>  # CONFIG_SPL_EFI_PARTITION is not set
>>  CONFIG_OF_CONTROL=3Dy
>> -CONFIG_OF_LIST=3D"am335x-evm am335x-bone am335x-sancloud-bbe
>> am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-bonebl=
ack
>> am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle
>> am335x-bonegreen-eco" CONFIG_ENV_OVERWRITE=3Dy CONFIG_ENV_RELOC_GD_ENV_A=
DDR=3Dy
>
> Why did you remove the OF_LIST? Without it the am335x_evm_defconfig won't=
 work
> anymore for these boards causing a regression.
> I don't know if OF_LIST works with OF_UPSTREAM, maybe you will have to us=
e
> OF_UPSTREAM_BUILD_VENDOR instead.

Yes, indeed, this is wrong. Thank you! I will fix this for the next version=
.

Best
Markus

--bf9dfffefbd63c222f04aba96417a12de6f1dbaa20ae7e0be280d48552be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaRyNIhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPS
4wEApzARHE4wnXxWbo03ffYHTpQqDD47V9UzgdeiHIfMWlwBAJhCdy3LChzH1z5M
FQUh9sD6wOyUgXBLDqPxKtCGpHkO
=85Hf
-----END PGP SIGNATURE-----

--bf9dfffefbd63c222f04aba96417a12de6f1dbaa20ae7e0be280d48552be--
