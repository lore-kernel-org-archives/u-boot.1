Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459ADC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A817184A0F;
	Tue,  7 Jul 2026 20:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="gn5SuS6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F221D84A35; Tue,  7 Jul 2026 20:35:59 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2792B849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=sjGy252h10ZLZ+C18aCr3sQJVG5P77/Vyuga9KpxuEE=; b=gn5SuS6f2fQ3A4XKJ76OZcdWMQ
 Ws1uK6TGyyqfUsSWrsUjcvKElkzHZdd4G2J/di+CLz9EUChLk2z9XjUEwlEG5Ncwnb9jFn5JkztTu
 UNaadTy6Zw4baqtK2mVhIQwA1FjDfcJly1zVw/uARouylwTNCR4bvtxOHljBUmLOQmeNWvWd1wQuo
 BVRQZJTsGxKjdYGmhYxyGdWCCqNapt1i+N2Dny8kXCA1GeSl3dlOjPuhWQFhz1X7G+SPv8h9N6piz
 AoGDcl9SoSS1oHPLubXI7GdKMcU8fS007gavGosjW2IKxmJEGnCBvfmgEixl10YrKWFmoBz/s4pwD
 426ZUWfQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, Quentin Schulz <u-boot@0leil.net>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz <u-boot@0leil.net>
Subject: Re: [PATCH 08/12] MAINTAINERS: add N: rkmtd regex to ARM ROCKCHIP
Date: Tue, 07 Jul 2026 20:35:56 +0200
Message-ID: <2064040.usQuhbGJ8B@phil>
In-Reply-To: <20260707-rk-custodian-v1-8-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-8-dbc9c696e613@0leil.net>
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

Am Dienstag, 7. Juli 2026, 18:09:22 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> rkmtd is a Rockchip feature, so let's match *anything* with that in the
> path.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49b35945f820..1c94356dc4b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -582,6 +582,7 @@ N:	px5
>  N:	rk3
>  # RK8xx PMIC/regulator family
>  N:	rk8
> +N:	rkmtd

Is that the raw-nand driver?
I guess it could also use a comment maybe?

Anyway
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>  N:	rockchip
>  # RV11xx SoC family
>  N:	rv11
>=20
>=20




