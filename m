Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2039AC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A550684A0F;
	Tue,  7 Jul 2026 20:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="w5vzJ7fl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4167B84A3E; Tue,  7 Jul 2026 20:36:37 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7077A849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=yz7o48TswsE8lN7jMxh83GFB/3PcqqzAI1Kfu5WtHzs=; b=w5vzJ7fl+Pmdcc05UcWbtos9kE
 YSqGIcy/tHIjCHpSAHmgBvKfcsv+6MufMyfKdP9Oc5/vGjzakdRCI3U05Q+om+qWaLwKibrcyZBIv
 sgPc0tecWvSJHvRxXWXvrs1o1xaC6HCktiA9+ft1kiHQ1LSuEHQDVz0mYTnIpV2s5XxL/g8u3Sv7M
 W1Zg/zf9/I5CdBaw7KAS8H7GLPc2q287A1F5SeE8vh/MWxZTCYsEIjFfjcyC1HpNDJt1gn9Wu7qfQ
 AB3Ml0HwCZfWY5w/Dzr9pMwoXcV9p2P5W3WbeJ/munO+bpdLnG2GZ5IP4lwLkPGwx5x+tYY97/MQT
 q0sTZQ/g==;
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
Subject: Re: [PATCH 09/12] MAINTAINERS: add more Rockchip drivers to ARM
 ROCKCHIP
Date: Tue, 07 Jul 2026 20:36:33 +0200
Message-ID: <1964239.CQOukoFCf9@phil>
In-Reply-To: <20260707-rk-custodian-v1-9-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-9-dbc9c696e613@0leil.net>
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

Am Dienstag, 7. Juli 2026, 18:09:23 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> A few drivers are not using "rockchip" in their path so they aren't
> currently detected by get_maintainer.pl as belonging to the ARM ROCKCHIP
> entry, so let's fix that oversight by adding them individually. We could
> use N: rk_ but I feel this isn't distinctive enough to avoid too many
> false positive and I don't want to be keeping a list of things to not
> match against.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


