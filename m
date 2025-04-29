Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0ACC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 957BB82B17;
	Tue, 29 Apr 2025 19:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CQCWZlEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09F882A39; Tue, 29 Apr 2025 18:51:29 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A90E82958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 18:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c12b7af278so32842fac.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745945486; x=1746550286; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QSOfZ+4Q4UloZl0zkBU5Nx+n/ajQpgw4UxFbpDRjkaM=;
 b=CQCWZlEHdTEtlls++6q/cYhqi0WjrtHgGHZj2beyGGtNYHuAYUNZ2SoCUhpfoC9wEn
 JUL8oMHLzWpMEqmW6ncZ6F9DVgtvJIe8W1D+Nq87uHHnhqPK6kKAi8DGT/YSERNkEIiE
 MXaNBHH3ndcCV9kS5Y9IwnSA7Pl+aZZrDgcJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745945486; x=1746550286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSOfZ+4Q4UloZl0zkBU5Nx+n/ajQpgw4UxFbpDRjkaM=;
 b=ERNdfXA+a0o8mxkvI+bFkc4IgiQ8VNWni0r2SAJdf314pgV4YpstIVMCbQJYOYNudN
 sx7nlgMBT1qdEZMJweFJN/obhV3sIZu4LUlFXUJYTa5MmRu+BtbLZM9F++o/EIhUdc4U
 cHXEfAtTaqSsSFVH9pZwoogOEBmCLmYqfV7IVyp1hbknVp1j6ExAA67wyyinJc2CBKLR
 Y4DZmwO+lGWWcZLPCiRTQyiwjRXtELqcb1/PdMp7RbN0cEBfsMegp3qrBTPHMkz1sAKJ
 2UA04xQtN+Pihdjn00o4OoUvMc8/wm6xl33elzK85smSiaw/ysMuvikrz2GX1b90dZYM
 zeOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmvXZnyTjc1+fnNzbckFjVzmDrEDFKshyZwCRf0SPLVtNOZ9bE9Et4+kJs+sksfDcnP+dHoqY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/go2jfiY5/jr6Mt5Ra+y3xhwFs+jLaWRrLTtmSpr5pfn069db
 FZLkV8welbhXou8sOmpt+sA0WfvuoTW/JWky1Kug4jdtML3epdAEFbcfXXluzBs=
X-Gm-Gg: ASbGncuCP/AHab2VBX7XB+UrqIcxsRnioa07C0+Q5++AWKC9yQip7INkrwHO9ShE+H0
 vSsCTqE2VmDSxBm4EWNnbJlQ0thABEdu2wYTGCEf8u2KRZWaPLvyXActLvW0vwI5P/RNPJnlbUB
 yj0Gf1uHRHcoufW2YL3IuLjpnqW3et8MLIA3Tl2aCqnzapNKH4anyhOxftH+BgJ/vHHAFaKcyU0
 /g/AWZsddj9Ogb1wE6HeFlIb5Kcq7zH3FvOJQ1K0aig7zZNNPSrbaBaM7WA4zrMQTMoSwZP7lTk
 oKuGUe8DFMNlw0K/jItbOgMVtc8DHBu882CbINpolYaAOj2Xb9LfqK+UFk//DOd6VlRDFVrsr+F
 3nw==
X-Google-Smtp-Source: AGHT+IG332iXajgv8Dzi7kRZ3JKFALt2StmUaztLokra7HH6ntRdS8lP0292SN+zBczdQbyAmJDMNQ==
X-Received: by 2002:a05:6871:2b23:b0:2b7:5726:c931 with SMTP id
 586e51a60fabf-2da462df370mr2452610fac.5.1745945485900; 
 Tue, 29 Apr 2025 09:51:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d9737f1051sm2881743fac.28.2025.04.29.09.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 09:51:25 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:51:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de,
 Chen-Yu Tsai <wens@csie.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Andy Yan <andyshrk@163.com>, Banglang Huang <banglang.huang@foxmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 David Bauer <mail@david-bauer.net>, Deepak Das <deepakdas.linux@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jacobe Zang <jacobe.zang@wesion.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>,
 Loic Devulder <ldevulder@suse.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nick Xie <nick@khadas.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ricardo Pardini <ricardo@pardini.net>,
 Sam Edwards <cfsworks@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tianling Shen <cnsztl@gmail.com>, Tim Lunn <tim@feathertop.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Wadim Egorov <w.egorov@phytec.de>,
 Xiaobo Tian <peterwillcn@gmail.com>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH 1/2] mmc: rockchip_dw_mmc: Enable by default for all
 supported SoCs
Message-ID: <20250429165119.GI1261075@bill-the-cat>
References: <20250429154453.2155923-1-wens@kernel.org>
 <e4607f73-2d94-41c7-af35-bb94dcc5c336@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="49FiXIZ1FC8G48Ii"
Content-Disposition: inline
In-Reply-To: <e4607f73-2d94-41c7-af35-bb94dcc5c336@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:00:39 +0200
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


--49FiXIZ1FC8G48Ii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 06:30:42PM +0200, Quentin Schulz wrote:
> Hi Chen-Yu,
>=20
> On 4/29/25 5:44 PM, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >=20
> > The rockchip_dw_mmc driver supports the MMC controller found in Rockchip
> > SoCs. This controller is used for the SD card on all SoCs and eMMC on
> > older SoCs. Almost all defconfigs for Rockchip platforms have this
> > enabled.
> >=20
> > Enable it by default for all supported Rockchip SoCs. Disable it
> > explicitly in defconfigs that previously didn't have it enabled.
> >=20
>=20
> I'll let Tom confirm (or not), but I think it'd make sense to make this
> patch lighter by not including the defconfig changes that would be simply
> done automatically when doing a defconfig sync, e.g. like
> bdf41fb7b386bdf60303b7a92431467c12779c86 did? This would be nice because =
it
> would make your patch much easier to apply if they take long to be applied
> (e.g. someone else changes the defconfig and now we have conflicts all ov=
er
> the place). This also would remove unrelated changes from the diff,
> specifically the ones for the PX30 boards which are just noise at this
> point.

Yeah, if we have to v2 this, or just it's too hard to apply later, the
automated parts of the defconfig changes can be omitted as it obscures
any review needed on the defconfigs for manual changes.

--=20
Tom

--49FiXIZ1FC8G48Ii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgRA4QACgkQFHw5/5Y0
tyxzcQwAlt71A8e6NLQAIulf2grrLnLH/EC4hsoYd6YQ7xmQPjjbNju1u24I/bKf
blFbpOTw/pPMQVjz4hJeMSn5nV66OVdigqbYm+L2XWIy16GRI8YiOQRlXgidCuXw
a+nAPEqc8HDecx9sGbOQ1lPy77IjfMVtdTrfB9cSsWk0biDcIJTnpr7B7RA0dx2b
ZKUo7OtDzFF6N7/ew+jbPI8xB0BfsPC7aMvQ4TveifNNHQBSbid1Xps98VOmgX8L
cTq1bDQYU6nlf5sumk26ODT9xBhVdUqh8+t5dW+HB6hGsSYffvt7hIggNIytKb6/
t/Qn+FpLnfwfcs5GI3pY77ejO01kadUOGs7AkxvtcZCNS9KUKxirVqiOFjcBll45
O+WQu2nKxnqToXeiJxUNuaJzeLXj5ASwMUUEOz29y4kMxdb8J8FCUlIoZyLr3HcE
hOjMWVOAlz/yoBJM64Jrnnc1DCsj7cu61VgJUBQzygvgldfHwoi3+tORHj6Y00kT
9X3bsYM6
=su4s
-----END PGP SIGNATURE-----

--49FiXIZ1FC8G48Ii--
