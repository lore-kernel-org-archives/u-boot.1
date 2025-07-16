Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FDC83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 13:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CFDA8313B;
	Wed, 16 Jul 2025 15:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="MNWJlgB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F24831E1; Wed, 16 Jul 2025 12:11:59 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D430831AC
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 12:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sputnik@on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 s=protonmail3; t=1752660715; x=1752919915;
 bh=RvLvPBttKBK7gfo1an0lyYi42VBMExSzwAKtRvZTiXQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MNWJlgB6rxLkquKnO3Ym+xGcpqsk65mj98uqivYEfswesmeksrBPMaXh8fEB0Cnt6
 JFMKgGLBQzjzIT6BOHPDbQBcwPvJ/OWmeOBKs7nOlUxQHm6kqkw5PbajtX8JAKJSVn
 APHIfQ0sug9JERNVpYTonBoMMsuQVmI5x9apbU2Z5Q77FMpJxWW+bDEyYS1q10reZr
 Pu9tSE47dNqCz6Z1UonXcUORiK739ZCqQxzHt+sQsm8RFDjmMob1oHiV7CfODYv5Ef
 z54fZrRCM4bQI9zl50j6TKQCGQt/3sN0s11afIFKbs7dE42nPFbM+1EAqOdtVbhguj
 tELjvXHGaPGSA==
Date: Wed, 16 Jul 2025 10:11:47 +0000
To: E Shattow <e@freeshell.de>
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Andreas Schwab <schwab@suse.de>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>, "Chia-Wei,
 Wang" <chiawei_wang@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Green Wan <green.wan@sifive.com>,
 Hal Feng <hal.feng@starfivetech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Rick Chen <rick@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>
Subject: Re: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly
 used value.
Message-ID: <vYg4IlDYamca-5F-VHVhUe0syuQhVE3qrEpgug3uvTZas8gzrXpE4YX-H63dA9ISHVebukojmJUigxf9EaSWx-lmzGGSdeV_SLSMXuNa62Q=@on-the-web.ch>
In-Reply-To: <b3f95ac9-a847-450b-9d5a-64af5e84a47e@freeshell.de>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
 <9529db2f-ff07-448e-99b4-65dde605b0ec@amd.com>
 <b3f95ac9-a847-450b-9d5a-64af5e84a47e@freeshell.de>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 2ce7118ee326eca391e758b88442c3f73683d9e0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------6d5712196c62a753711f570937787b5487e4d653e8862b83990e521df252be85";
 charset=utf-8
X-Mailman-Approved-At: Wed, 16 Jul 2025 15:03:11 +0200
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6d5712196c62a753711f570937787b5487e4d653e8862b83990e521df252be85
Content-Type: multipart/mixed;boundary=---------------------97ab90b2d92f39da3253ec96a851034f

-----------------------97ab90b2d92f39da3253ec96a851034f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hej all,

On Wednesday, July 16th, 2025 at 3:35 AM, E Shattow <e@freeshell.de> wrote=
:
> =


> =


> Is there some reason for the value from documentation about the
> architecture? Or is it arbitrary?
> =


> I don't really see the sense in a default value which is simply popular
> but not founded in an architectural reasoning.
> =


> The values do not change often (ever?) so I miss why there is any
> default at all.
> =


> -E

No, there is no documentation justifying this value. My reasoning was the =
reverse, there is no justification either that this default value should b=
e almost an order of magnitude lower than ARM64 as typically generated RIS=
CV code size is similar and thus the typical kernel size as well.

This is reflected in the most commonly used value in the existing riscv de=
fconfigs as well as other boards not yet mainlined into u-boot.

With a lower value, typical kernels generated from Yocto or others are too=
 big to be able to be booted.

In my idea the default value, when provided, should reflect the most commo=
n use case which can then be overridden if wanted.

I understand it was a very bold move on my side as a first submission to c=
hallenge a default value and touch over 30 boards, so i won't be offended =
if this is not accepted. The learning experience on just submitting a patc=
h here and learning about patman and co is already a success for me.

Still I consider the proposed new default as sane and maybe more future or=
iented for new boards to come.

Cheers,

Martin
-----------------------97ab90b2d92f39da3253ec96a851034f--

--------6d5712196c62a753711f570937787b5487e4d653e8862b83990e521df252be85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmh3etMJkIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcme+0jkvj3NJeibcnespGYg/0b9Hw3/DkHQ1vLBs
YrIKJxYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAAChkgD/RANe9/gr7mB1sYlt
oiYiq411HLrJzWis8VPJv67/pXwA/RqermUrwaVHvjRtB3Q1KPSWCJy4O/m2
YS0UN3YwkL0J
=5dBy
-----END PGP SIGNATURE-----


--------6d5712196c62a753711f570937787b5487e4d653e8862b83990e521df252be85--

