Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEC5C44503
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 10:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A7C8496E;
	Wed,  8 Jul 2026 12:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="jA1WJ/Ui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD91B84979; Wed,  8 Jul 2026 12:16:05 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69C6838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 12:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=oqHCBmG9v7D4IAGkR3oM67LdacJP1VzA2rNFffM8+ek=; b=jA1WJ/UiyN77hcjADshZGNacJL
 d+tVqICU8sKCtGHOUfJioP9NORGOsBt9e0RCdj9M0XpJCT1XiyBsuc0Xc5TM0T1FFFtGCTPHmPvKh
 IRvQBG3O2sS8MR47bAlaaJE/72NSzSDRKJNTiKaTi2STwnsKhE+SRCJC2g2+9x/4dKLRbqSg9+7TD
 UzspQmgJCmB3Wpvol0xwJzrfFL2C7zULrELkDqlgZQl+lNWrdATh8OUhtBu2taG6NEQNEC5pFhfu8
 Cqni/MKP8GyKQpzoySq5xioHe9HqbuaEBDP4O4uyoVE4COKvR+9aD7MFcjrGNSfKBAqc6bhvD57X3
 RDFmCfvg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: u-boot@lists.denx.de, Quentin Schulz <u-boot@0leil.net>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH 08/12] MAINTAINERS: add N: rkmtd regex to ARM ROCKCHIP
Date: Wed, 08 Jul 2026 12:16:00 +0200
Message-ID: <2267054.KiezcSG77Q@diego>
In-Reply-To: <22d87b10-cb65-4a51-a1ae-8197c9ead601@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <2064040.usQuhbGJ8B@phil>
 <22d87b10-cb65-4a51-a1ae-8197c9ead601@0leil.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Mittwoch, 8. Juli 2026, 12:12:38 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> Hi Heiko,
>=20
> On 7/7/26 8:35 PM, Heiko Stuebner wrote:
> > Am Dienstag, 7. Juli 2026, 18:09:22 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Quentin Schulz:
> >> rkmtd is a Rockchip feature, so let's match *anything* with that in the
> >> path.
> >>
> >> Signed-off-by: Quentin Schulz <u-boot@0leil.net>
> >> ---
> >>   MAINTAINERS | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 49b35945f820..1c94356dc4b8 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -582,6 +582,7 @@ N:	px5
> >>   N:	rk3
> >>   # RK8xx PMIC/regulator family
> >>   N:	rk8
> >> +N:	rkmtd
> > Is that the raw-nand driver?
> > I guess it could also use a comment maybe?
>=20
> My thought process for the ones with comments was that it isn't obvious=20
> what it should be matching and why. There's not rk3 product, neither=20
> rk8. However, for rkmtd, you can simply search for it in the tree and=20
> it'll return only what's applicable and it's rather clear what it refers=
=20
> to (only few matches). Same for rockusb for example.

makes sense :-)
R-b still stands of course


