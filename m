Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7766C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3668F84A27;
	Tue,  7 Jul 2026 20:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="z1xpmTS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DCD84A29; Tue,  7 Jul 2026 20:35:00 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83639849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=ZYJuwkgWt25gOYXWHqOrsMAn2G7TztlWLZ7MpJKG0uw=; b=z1xpmTS07D0ROs8GQEbZnQFl9X
 J3/OlGMy/xGs9kjNxx95ca8+TkfwU8tQoOO0+ihHQL5L0U81tNFsv6w7uZhpTNxCqCPAzKkMO3La0
 YHZhTv/NsS62M5+eYCSG/GPXUXecFBYEaDs1xPQaUsXIvL0Gv+4K91Wp/BmAmvJ3elV64S7KCGTaQ
 DkvW/0gvE5IJMCANLhI5YHh0lTUoMJyQ9qZ6VZE7sV/me0CUNehSz/DPuuwCSqHp97kNTZRcMGmY/
 5TT4PkwpWaaAuWAYIKyY0obh9iMdaHTJORUNmUJLsxnRCfy17RvLFdzMuMn+1SoHidHIUuzOp4mno
 Hy8/1kCw==;
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
Subject: Re: [PATCH 07/12] MAINTAINERS: add N: rv11 regex to ARM ROCKCHIP
Date: Tue, 07 Jul 2026 20:34:56 +0200
Message-ID: <1861945.VLH7GnMWUR@phil>
In-Reply-To: <20260707-rk-custodian-v1-7-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-7-dbc9c696e613@0leil.net>
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

Am Dienstag, 7. Juli 2026, 18:09:21 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> Rockchip has an RV11xx SoC series (RV1103, RV1106, RV1126) so let's
> match *anything* in U-Boot which contains this string in the path and
> not only the U-Boot Device Trees.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


