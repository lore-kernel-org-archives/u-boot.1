Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5532D3EE67
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DD9183B03;
	Thu, 22 Jan 2026 14:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G1VdP2el";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703B7839DF; Thu, 22 Jan 2026 09:30:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29FA080077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769070566; x=1769675366; i=xypron.glpk@gmx.de;
 bh=6FBA3kb9HXwLJnWu3IspkBZxnwrvRVpNQNmNePU62ic=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=G1VdP2elg3mmDc4qmoEljkF21kkW2fIbW+UQcH8jEDBkIRmDFy+yNe6cqrJJvFdL
 W5OLvu5rv3yBnzP6bhnTEy1Zcd7fB5Y105HE2xxok+KoWgv8eAGAgCv783cG5LLo2
 bpBZ2ayh64lnHqpUHfjEgWTmc3vBh0vgS3oO98RV4EZOXT1tBP4wyzWc+GIAEiO32
 iw0U1d45RA/+RONnSM7eVlrnys/nGTqP5+4x3/SYnIQY+q+uQcavl3/B1L5xh0RMi
 NIoXNk7GvK/mcQe08X0XCx69AVM7FFxIgpNFl9FMs/nb90UFO/vC7WFc0fqnRqcVB
 p2sCRa+S4hUVP937Hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.127] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1veh4Y3HzX-007Jnd; Thu, 22
 Jan 2026 09:29:26 +0100
Message-ID: <ab43d859-ab6d-4a1a-9f7f-0afd61545e17@gmx.de>
Date: Thu, 22 Jan 2026 09:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] Add board support for Spacemit K1 SoC in SPL
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Henrik Grimler <henrik@grimler.se>, Quentin Schulz
 <quentin.schulz@cherry.de>, Kory Maincent <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AOAGMulvNtsFjD3oZjHh0LiIC6nlxsA8CQmUnl0dhNw0lyQFk2A
 AfvCYE+WCsMP5athZ3jVPo0wOUDFKaM04bwX6+d/txWi1XG2Wa4ZOJxxRUqrGyT7n2WBMQH
 oygs0iVN3Q9r4WObuj4eT3xAoEN9BK9xuZ+A7D1/exLnAeeT/HRLW5F/igzLHl1pYkcOlOG
 M9c/k4tZ0PBD2sdlPqAag==
UI-OutboundReport: notjunk:1;M01:P0:gxooYf4uTWc=;S/l3SSPo43bt/xI6yswR9zkHFyI
 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
 vHlPyXXtuXW76ihkJpgZn5XEERKzy
X-Mailman-Approved-At: Thu, 22 Jan 2026 14:41:52 +0100
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

On 1/17/26 20:01, Raymond Mao wrote:
> From: Raymond Mao<raymond.mao@riscstar.com>
>=20
> This patch series introduces full support for the k1 SoC in SPL for
> multiple boards.
>=20
> The series enables the board by:
> 1. Adding the base board definition with device tree.
> 2. Bringing up essential clock sources and tree.
> 3. Initializing I2C buses for peripheral communication.
> 4. Integrating the PMIC driver for power management.
> 5. Adding regulator drivers for voltage domain control.
>=20
> Junhui Liu (1):
>    clk: spacemit: Add support for K1 SoC


Hello Raymond,

Is a downstream OpenSBI still needed for testing this? The documentation=
=20
in doc/board/spacemit/bananapi-f3.rst refers to

git clone https://github.com/cyyself/opensbi -b k1-opensbi

which is based on OpenSBI v1.6-32-g02c7a9bb.

Or is the necessary code already upstream? Upstream OpenSBI seems to=20
have some support in platform/generic/spacemit/k1.c.

Should doc/board/spacemit/bananapi-f3.rst be renamed or do you plan on=20
different docs for different boards?

Best regards

Heinrich
