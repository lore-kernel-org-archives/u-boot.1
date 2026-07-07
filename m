Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6AAC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D75849D2;
	Tue,  7 Jul 2026 20:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="QrL38/91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B266C849F0; Tue,  7 Jul 2026 20:30:21 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D953484942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=yCTDtwqlreeiNESPa8IxsouXPfkf2YQJMKJZi4bafP4=; b=QrL38/91ZzlaTUo1IdFgz/5PAU
 DD1vHpz0zxA/EDtoOVferce7dGXFfHlILwKo4/swZfgTG0U24kTZct7a7pCDJzM1smC8quCcdjgZC
 MMxyGg7nw9B15M+CJh6zhF1yPvzEFjmZ28walxi3ZodAq8pJDg7f6FPROvHi6qREKfbYb26qsZlG0
 QSdVEIFdFNj7PyoMOrvcMNbnqcy937zOLMzbbkrvtGDAh9gD2JKTSIM5PXrRue8abnZ6X6Sc6Onj8
 60kp1EZZN1YyL2+4TZs45tzYICmKuv9h61zCuQp9j7j9bnSj5/mBEYit5KUXcjZT/LXCdM/v1bfh5
 EM0pn/Fg==;
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
Subject: Re: [PATCH 02/12] MAINTAINERS: add rkmux.py to ARM ROCKCHIP
Date: Tue, 07 Jul 2026 20:30:18 +0200
Message-ID: <10876938.nUPlyArG6x@phil>
In-Reply-To: <20260707-rk-custodian-v1-2-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-2-dbc9c696e613@0leil.net>
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

Am Dienstag, 7. Juli 2026, 18:09:16 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> It is a tool to be used with Rockchip SoCs so let's add it to the
> MAINTAINERS entry for ARM ROCKCHIP.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2c78ce39161..6f52fb76fede 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -594,6 +594,7 @@ F:	drivers/gpio/rk_gpio.c
>  F:	tools/rkcommon.c
>  F:	tools/rkcommon.h
>  F:	tools/rkimage.c
> +F:	tools/rkmux.py
>  F:	tools/rksd.c
>  F:	tools/rkspi.c
> =20
>=20
>=20




