Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0DDE909C0
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 15:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F39283AC5;
	Tue, 17 Feb 2026 16:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kw1ZlAeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1054B83B99; Tue, 17 Feb 2026 16:08:28 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB4783981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 16:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d4bc9e48bbso1722315a34.2
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771340904; x=1771945704; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V38UYHBnhuwjzgkZ0vlfS5N46imgKUgQ9w451y2XcUo=;
 b=kw1ZlAeG/pNk545VLjlL4jrC8Dm3J+uO845wMS4Ged8UggneNdszHl2sNNmCrs4le6
 HYk+l7How0w+7hmtElZU8cwZHeNzPqcd++ZzkdWQfRfCy4QdCiJvJROqMf5o8BYHT6dc
 4k5uAVanSHGelm/Enw546tGPHM/UUM6H+zmbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340904; x=1771945704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V38UYHBnhuwjzgkZ0vlfS5N46imgKUgQ9w451y2XcUo=;
 b=JtqawkzZ8syiOV3KN+I0X16i1AcOy9t066ee5unZbX+F6M/akfaODt6Z3L+RJKpnRD
 e0RDWhe0O4KOZCKeswqo+3JfD+gJCyxULyyqsRSQs6aa2PdidPaCKmcUokW49XV9eL9l
 4J3qu+0hpOX54M9VLA1iFb7Pms4G1pC2ZBUlnC2ZRJLTiAYc8pVfEPHGDOH4NIhYiIK8
 pYPBYYGH/y+wLT8spbnYTUqOuKGK9gEm1yRYYYq9EfiWRS9NhJVdTA15TWpIT7qPIMVN
 VkGimTYGrA6oaKaLu9TSxoYDKAhBw44CrNdRrdDGqwuIy9fD/H9Iqf/3hIFy+PNOApsS
 MNhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnragymrQL0swBzKI93g4BVZFqtIdkBPrw3YJSXZwItzQRjdRpUoupSfOAdWYZ580VNzMOkus=@lists.denx.de
X-Gm-Message-State: AOJu0YxWGrSQzYWSrOpf05asixOjIWDa783N+wFipJVMVN6abslAkw1N
 zogOr3IyrHIHFVmpIFXkcA2AtufA1x4hRBz0XJuDWpvpbBZU9nZDJhpSyt7WPLkGSBg=
X-Gm-Gg: AZuq6aJ4lhEi8ssvfO5vR1hN1pp1G4U7/r1434YiLkGWfQpgRficVxvxnfMmtBAwY5w
 gUkmO2uzX6FLt9fx+80e9o6jd4+VEQJsyttjzNkeRQ1A+Pnue/rL9qmrRo8dKGaS53fGq7YEv17
 TAxtKOUqWnQAB6i04vBVsIXV68tQ/8IF5u5qTyoKIEl8zgI4L1226Ij/C22A/brU0hoTVg1X9mV
 zJDsUt2iIp7n0PCS1xW1NlGy8ZI8OUuTRp0+Lr42G3aZSdxj/sdZLrLsmJQV6jlWpOdW4h85ejj
 bCTrR84mmdT/L6x8gCDtIOfVeT8AGljtaLIuEWgMmkVsj0IuNrIgUVsuozbMP7w2X770+5mirTV
 ZtpvaI7LHrT1T3Gkbukurqh/sJzQ7BQeAG5p8ZNt0vRZqUnLzKeUZqvRd7qRKDxU+qxJKyMLVvi
 q4di5S3edc7lvG0bQmePMgraSU8zEV2iUe3TpVp/rGlwdKEC1ta5fNs9EnMj1IuUe9EOeb3JXC9
 D1ZUQQQmN+cnMOswNaj55FtKOQ7ToR3kSZrI812xQaB+yYWuh8=
X-Received: by 2002:a05:6830:dc7:b0:7c7:2d7d:5d0f with SMTP id
 46e09a7af769-7d4d0bc0a86mr6434917a34.20.1771340904295; 
 Tue, 17 Feb 2026 07:08:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a7547ac1sm14949610a34.7.2026.02.17.07.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:08:23 -0800 (PST)
Date: Tue, 17 Feb 2026 09:08:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260217150820.GB2747538@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="delasvvEZ5vV1mbs"
Content-Disposition: inline
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--delasvvEZ5vV1mbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:

> Hi all,
>=20
> This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> embedded rootfs" firmware model, along with the underlying infrastructure
> to load FIT images on-demand directly from storage devices without copying
> them entirely to RAM first.

Setting aside specifics, which I need to get in to later today, please
make sure this passes CI
(https://docs.u-boot.org/en/latest/develop/ci_testing.html) (I saw an
rst error CI would fail over) and do some size comparison before/after
on this series, both when it is and is not enabled. Using
https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-b=
oot-size-test.sh?ref_type=3Dheads
can be a handy wrapper around buildman's built-in functionality for
that. Thanks.

--=20
Tom

--delasvvEZ5vV1mbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZSEZAAKCRAr4qD1Cr/k
Cmv5AQClB291e1p42/pK1mdHYYH9qF6H/BEuSB2YxnwigjyPTQD5ASY8669StA9z
PsxF72WLyfprS9zjw0Zd5oFUAzeKugc=
=DNZd
-----END PGP SIGNATURE-----

--delasvvEZ5vV1mbs--
