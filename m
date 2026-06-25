Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96ABCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D36E84975;
	Thu, 25 Jun 2026 19:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="D8+30Trc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7178B847C8; Thu, 25 Jun 2026 15:01:14 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2229F84996
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4E28C117E50; Thu, 25 Jun 2026 15:00:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782392465;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=iBN3p3oV6p8B8VxWuZOChaUrZ/MS+9QNW4z95J+FmU4=;
 b=D8+30TrcF7yhGtGVpYixFs0vlz3IuRNwD0PrrlcMCoR/UwkP0OGG9nYHdLf/Wy3QzsFHOk
 cJKTL143NH8tfUbly+H08OaKCzI1R7kzwI1nnhMr0RpVZKAV/gIshugCmkH0qEmeSEuoAI
 FMpAzXHEAlDmOi+pjIMp1qwOamu+Z0BXRUq/ca8q1r0P6C4MKtwbHFy50amIkj+qIU59/r
 CA+XLmjUvTe6Ej4svNM+W4zQUMMS7BeZgqrM875B4TxDB54gtBGl/kedijCzAGJlmY3BYa
 wYxPKduExn6Iv0Ourf4ob85ezibSWgoqXVtaOSxf/tSxFN5Y6Qs2XutTjK8xAg==
Message-ID: <55cf3846-702e-f0d0-5534-ef76acc8dd29@nabladev.com>
Date: Thu, 25 Jun 2026 15:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] treewide: Kconfig: use bool instead of tristate
Content-Language: en-US
To: Anshul Dalal <anshuld@ti.com>, uboot-stm32@st-md-mailman.stormreply.com,
 u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Dinesh <dinesh.maniyam@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Marek Vasut <marex@denx.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Nick Hu <nick.hu@sifive.com>,
 Jimmy Ho <jimmy.ho@sifive.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Jonathan Stroud <jonathan.stroud@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Daniel Palmer
 <daniel@thingy.jp>, Angelo Dureghello <angelo@kernel-space.org>,
 Peter Robinson <pbrobinson@gmail.com>, "Lucien.Jheng"
 <lucienzx159@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Beiyan Yun <root@infi.wang>, Weijie Gao <weijie.gao@mediatek.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>, Alice Guo <alice.guo@nxp.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Shawn Lin
 <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Alexey Charkov <alchark@gmail.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
References: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:25 +0200
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

Hello Anshul,

On 25.06.26 05:17, Anshul Dalal wrote:
> U-Boot does not support modules, so having tristate options is useless.
> 
> Therefore this patch does a blind replace of all tristate options to
> bool tree-wide.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> CI: https://github.com/u-boot/u-boot/pull/998
> ---
>   board/st/common/Kconfig      | 2 +-
>   cmd/Kconfig                  | 4 ++--
>   drivers/cache/Kconfig        | 2 +-
>   drivers/clk/Kconfig          | 2 +-
>   drivers/firmware/Kconfig     | 2 +-
>   drivers/i2c/Kconfig          | 6 +++---
>   drivers/i2c/muxes/Kconfig    | 6 +++---
>   drivers/i3c/Kconfig          | 2 +-
>   drivers/i3c/master/Kconfig   | 2 +-
>   drivers/memory/Kconfig       | 2 +-
>   drivers/misc/Kconfig         | 2 +-
>   drivers/mmc/Kconfig          | 4 ++--
>   drivers/mtd/nand/Kconfig     | 2 +-
>   drivers/net/phy/Kconfig      | 4 ++--
>   drivers/spi/Kconfig          | 2 +-
>   drivers/ufs/Kconfig          | 2 +-
>   drivers/usb/cdns3/Kconfig    | 6 +++---
>   drivers/usb/musb-new/Kconfig | 2 +-
>   drivers/usb/tcpm/Kconfig     | 4 ++--
>   19 files changed, 29 insertions(+), 29 deletions(-)

Thanks!

for the i2c parts:

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
