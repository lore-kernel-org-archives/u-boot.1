Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D981C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6EC84A67;
	Tue,  7 Jul 2026 18:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p4rs+exF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CBF84A52; Tue,  7 Jul 2026 17:35:30 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D6284A0B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6a347ec19a5so964485eaf.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783438524; x=1784043324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CIUdVeembzKDP/z//yOys+teCMH3USuItFn3FrvrYoM=;
 b=p4rs+exFn/K3R/SCDDm9hyGqiBXmA+XWf80bb/JcabUa6hMalFLuOt5QgFlBD/Msk4
 eyOoKSbvepjYAV4X2ynOIU4c3fJqC7oBFFWAHmCnI45qPRr5MrglHaDzHKoyOc+5kHzN
 BzrFc+TDWNz5tWlUi/fI6lKuwiRREXdHRFO48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438524; x=1784043324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIUdVeembzKDP/z//yOys+teCMH3USuItFn3FrvrYoM=;
 b=BodYPveVf5yFUpDfNlwJiS0HECByBRTn0zMeVufRX4J6lV4w2cZESHyGqJDRYlmMsX
 So2f+0k37C4BQ3tFAtAjPdOUZbcX2afA9ceaBRBeHtsIjYXlS2r73qPmTuxalqpXLFy6
 IGYjdPk0O9Ba52HicUuhOduHtNsaIGPtfeB7s9eqTIMpvpNP2L3yP1zTfKvE9MPm5gk3
 IdmPR2uhczHUsz0/Aa/6onSwPzEndvNBvaVqT6W+SQHMVm27DZLafvDeoU/c38u/RJMM
 7prefGspV2id2tXo7zHimjwp0FiNmLMDr8HXn4V9ogMVwkiFvpb3P/XiY/gevoaE0SWH
 Ueaw==
X-Gm-Message-State: AOJu0Yxh/LnZHx+w0Ve9ibhUv48eDOuiZsbSNadoVbmgvV3DxmtzBxeq
 LDJ9NUMgFpr+EC5LLNUW66m3X6/uegGrDvNrMRxZluasqGa3ToT5uCPB7zON52JE910=
X-Gm-Gg: AfdE7cnuhOq0L/SACM78+IKqLVk/SiUVUHuNAg3EZaeAZMRydktiHwAfkRJVnbYsjZY
 VLwOUmJ5ZFMyZKrAQKo/gy9oUKWu0KJMZGTmeM+ClvVUH2t2RE2W8oQSzvHFVkeDJVkqJXNtn+p
 3FzbFojqgAaojO5jK87o6tZfO2GvDjSihMt4Ckqf+gp/tT/8cfbET8fk0HODBHlSzg6vwQjJce8
 3Bw2AdIrtig90cq1TepD7NiezbSbwa/Qx5Q+ek2PEO8Ip0JiLszNsJwKX8llGpqjtHdP53lmpQk
 bynpyJA9w6Yqf8egbGiH/ZKgpUuS/TvfilqCKOAN8IwpzyBsyvGohYoc44V4513/M/fhaJukTzf
 RIkWxXRNuBVZ/7/CQa8MbvyUv4Zj1dm+rmd45A4Zch+YCm5c0E01u6ou1pv/ESCbpB5kABN2pYa
 xNy2BLL3WamxM8sbiFe6P+1hoEjPfO231zS/8knq4hxESDSAJYKFcehs3/yHUYLuKHrFo52obwV
 4dHhQqUbZyX1ftBrn/GMVFLHBVApkfIZmEnag==
X-Received: by 2002:a05:6820:6ae3:b0:6a1:5864:69f5 with SMTP id
 006d021491bc7-6a355540eaemr3786427eaf.25.1783438524337; 
 Tue, 07 Jul 2026 08:35:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310003927sm10065042eaf.6.2026.07.07.08.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:35:23 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:35:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@nabladev.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Alexey Charkov <alchark@flipper.net>,
 Alexey Charkov <alchark@gmail.com>, Andrew Davis <afd@ti.com>,
 Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Niu Zhihong <zhihong@nzhnb.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Ye Zhang <ye.zhang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH v3 00/15] rockchip: Add support for the RV1103B, RV1103
 and RV1106
Message-ID: <20260707153518.GI749385@bill-the-cat>
References: <20260707153135.2048115-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bK7Bwi6ewj7tuHBi"
Content-Disposition: inline
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 07 Jul 2026 18:37:14 +0200
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


--bK7Bwi6ewj7tuHBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 09:30:58AM -0600, Simon Glass wrote:

> This series adds support for three small Rockchip camera SoCs and two
> boards which use them.
>=20
> The first eight patches are Fabio Estevam's series adding the RV1103B
> and the Onion Omega4 board, updated here to address the review
> comments on v2: the board patch is split into SoC and board patches,
> the devicetree files move into the patches where they belong and the
> pinctrl driver uses regmap_update_bits() throughout. All credit for
> this work goes to Fabio. The devicetree concern raised in the v2
> review is also resolved now: the devicetree files carried here are the
> versions merged in Linux v7.1, verbatim, and can be dropped once the
> next dts/upstream sync brings them in.
>=20
> The remaining patches add the RV1106 and its RV1103 package variant,
> following the same structure as the RV1103B patches, together with
> the Luckfox Pico Mini B board. These SoCs have no mainline Linux
> support yet, so their devicetrees are local for now. The clock and
> pinctrl drivers are ported from the Rockchip vendor tree and are the
> work of Elaine Zhang and Ye Zhang. The final patch makes the
> maskrom-mode RAM-boot images work on 32-bit boards without OP-TEE,
> which both of these boards rely on.
>=20
> Tested on the Luckfox Pico Mini B: U-Boot runs from RAM over the USB
> maskrom path and both the SPI NAND and a microSD card are usable. THe
> board is running in my lab.

I did ask you not to do this, Simon, as your patches aren't being picked
up until we've resolved the status of u-boot.org.

--=20
Tom

--bK7Bwi6ewj7tuHBi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak0csgAKCRAr4qD1Cr/k
Cu30AP9Uch6eyazFcQP9nJFwyJNDwkquuXPaOlncSTpyAe2vpAEA2Hu3fCgCrjTE
kDYwkS11XM0c9u/2CHVHbXO1QqwFRQ8=
=nmp6
-----END PGP SIGNATURE-----

--bK7Bwi6ewj7tuHBi--
