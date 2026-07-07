Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F7EC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9883D849A4;
	Tue,  7 Jul 2026 20:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="H1pvi2py";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2E6849F6; Tue,  7 Jul 2026 20:34:09 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B8184942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=LitvQX8iGnkNkAYCUXhLkSDVsRFzii8bALvKARHoDJQ=; b=H1pvi2pyZRYkiRgR8nR6S7ME/f
 vRcjZmcr0d76Nbf06H8/Kv5Tz9YLEyU3JIooj/HPZ1Fmlt/knjjLcIQHvjP8YzFm3TTk+vp/ipnWv
 nPKD+HKKDCmAI59Uyt05+pARhPHTrz6WQnAQh12Aev7j5B+5STTxDA61V6RR+cW0DLgGRspbzRq6Z
 s0HMXtj2s3pOYbWfJ/pex9hbnUpi3CFLWnkCH+0KJbykp/KGjy2qk4+8KNrRJ2DHlLiCIjrepxNDL
 Y1wFHE2sb85UAoNNf4LY/Uju09xnPNDsU/z461HH2lq9raFWYxt8YvmWNCzrRtLP/0OV9i83odrRT
 AyYIi09Q==;
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
Subject: Re: [PATCH 05/12] MAINTAINERS: add N: rk3 regex to ARM ROCKCHIP
Date: Tue, 07 Jul 2026 20:34:05 +0200
Message-ID: <3702351.iIbC2pHGDl@phil>
In-Reply-To: <20260707-rk-custodian-v1-5-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-5-dbc9c696e613@0leil.net>
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

Am Dienstag, 7. Juli 2026, 18:09:19 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> Most Rockchip SoCs have their name start with rk3xxx. Historically, the
> second digit is for the generation of SoC, e.g. rk31xx was before
> rk32xx, itself before rk33xx and now rk35xx (and the expected rk36xx end
> of this year). We won't talk about the rk30xx timeline but it's also
> prefixed the same way. So let's match *anything* in U-Boot which
> contains rk3 in the path to simplify the MAINTAINERS entry and hopefully
> catch as much as possible.
>=20
> board/firefly/ and board/pine64/ only contain subdirectories and each of
> them have rk3 in their name.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>

The predecessor of the RK3066 was the RK2928 :-) .
But that is so old, that I'm 115% sure, nobody will ever add support
for it in the future.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


