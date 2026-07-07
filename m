Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A7AC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8FA384A0B;
	Tue,  7 Jul 2026 20:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="OUtQBfHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABAC884A4C; Tue,  7 Jul 2026 20:37:32 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D777F849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=shfxTM1d+Mm7b3j1PB8tGBcvtl3WUH25NKh1mpt7+bM=; b=OUtQBfHEtrQwsAD0tc9SrRLPWK
 mw928P8p+giWFRgqg4QvMvrKa3X0hM4AeYtDG/uzhmK5L/IdZtV1lKC8u2HnTb3RoZvlQFWN9TtY1
 iTVlwZJf+OixXOGYTkbxySE4HVCmVmIHpYHNoQBDy86pqQ+Z2fUOVPN3GSqvUWGAZjOjCILs5P8ic
 F+vTDs+MNFpzbX3L7HAJzeWyhxtoNyNfvTNiVyyUEabsaQupQ17TP+PvwImBtynsy4xJl8Npa1q6d
 3QMY0GwLv65EkayD+X/KkpARjee/cnTso+9WN0RyR/RVDxDOr6hTbYDurijc7rWnjvI/eJCxO/r3G
 /fOT5ZZQ==;
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
Subject: Re: [PATCH 12/12] MAINTAINERS: add myself as ARM ROCKCHIP maintainer
Date: Tue, 07 Jul 2026 20:37:29 +0200
Message-ID: <2277056.Mh6RI2rZIc@phil>
In-Reply-To: <20260707-rk-custodian-v1-12-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-12-dbc9c696e613@0leil.net>
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

Am Dienstag, 7. Juli 2026, 18:09:26 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> Kever has been pulled into different responsibilities at Rockchip and
> this means he has less to no time for his maintainership in U-Boot as
> has been seen for about a year now. Let's try to improve the situation
> and have Rockchip-related things merged again by adding myself as
> another maintainer.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


