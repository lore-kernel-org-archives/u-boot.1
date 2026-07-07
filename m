Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B005C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD90849A4;
	Tue,  7 Jul 2026 20:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="lIbrv40Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E93484A06; Tue,  7 Jul 2026 20:31:48 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D5CF84942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=smROyZTsDEljS1lDV50JPhGMZ9d70KdY54v9yeBuvrc=; b=lIbrv40YY/2ANfXQAQ4D22DC9U
 t3DQQcnTA+FzOzc3furUD06bo4dZFUrT8IzR5TfuvcREj/sTpSWol5emDq4aDtITqiCMOL8fMEbNB
 5kBbQL1MSwaBHtwF7T52fi80Ien4AVmMwuUyQYHdRYQskyujW0WfSyhCCXjMm+0YPOS0jb6YJ5B4Z
 ZRntI+MyypEtzZmhUnOpSNEvGcKuz6TCRnrzijzIdOGt4htpNCEJv7lhs8BjPl7ih3bho6LNje+MJ
 CzuoOrfGQGZ6LwAe69+1H//uyAc3JF2SCD95J44WLPx13Fxvi9msA5Xsg2gnTiHa9dcH1Ne74S5qu
 Jws+X2pg==;
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
Subject: Re: [PATCH 04/12] MAINTAINERS: add N: px5 regex to ARM ROCKCHIP
Date: Tue, 07 Jul 2026 20:31:44 +0200
Message-ID: <7964075.EvYhyI6sBW@phil>
In-Reply-To: <20260707-rk-custodian-v1-4-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-4-dbc9c696e613@0leil.net>
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

Am Dienstag, 7. Juli 2026, 18:09:18 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> PX5 is a Rockchip SoC, so let's match *anything* in U-Boot which
> contains this string in the path. However, this matches a bit too much,
> specifically the PPC-based kmsupx5_defconfig so we need to exclude it
> explicitly.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


