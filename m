Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A52FF5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F9A844BD;
	Mon, 20 Apr 2026 22:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hygA7hvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A03A843C0; Mon, 20 Apr 2026 21:43:24 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F56843AF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-671c24f23b1so5129627a12.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714201; cv=none;
 d=google.com; s=arc-20240605;
 b=cPonBq+dlmpdrYZGIwPsVYM9TzljUNBfB+oosdFdewgv3soZP3JeHUSqdXg8YcjhIH
 J5YYlXgU+cFD4yyqsJdRM1zGW2qnbUTD741W5jLadJRWbIjb86KaPWPAEuM797rkhW3v
 noA420OmXPYNp386I+sF3CF4pTHGHH12zttufVhIIQBFqjHJs8okvbsxEbQpwKAxSOhp
 PBLKJS0T4riTT+GaRgQ6lIevyPsSINf4PdKyXShxMwGlkUt1qEy1Mp7QxchmLtCDEBmi
 pVsPs089fbOXv+bIfQ+TNR6r7QaBUGATeGEcEVaf3BmuxLP+y3xNp7wEOXczijhlTyE/
 FrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TvsSZ2iDnrBEthugXTCOcDsVcM/2V40TqAQGMo39+ps=;
 fh=B11T/ZyKvSxF0qhOl4M7rr4wqKWwkB2JbP3jqmHnKhk=;
 b=eiF5WcUhnVfmzGOXpyb0X3oUmJHsKLWvoArAy2zoscS9oT+Psy2Lhngl7lC7TY0U+N
 ZApIw3LwpakJP3SUYwtQfuE045ogFy656e3ZORRKuQ9iuB7RwlWkXh7Yzy1cs8KUii09
 v66LaZhPSffPialskjkM+Isd1MEl4kDky6raSJ07t18SYEWFR0Qq6oNqgjhmt3f7uEA2
 wRRHLCWW2h3HFGp/TyZemQhtn7f37GgTfuqky5JaytaGq0Vkdu0kHZK7hZ+T6MM8XKoH
 TAZlq/EEnc+v5A/ATGNq5CqbnYvkfpY3mkP/jqMG6Q68dgfPYdW1YZthqkQbtXdp2vho
 XYTA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776714201; x=1777319001; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TvsSZ2iDnrBEthugXTCOcDsVcM/2V40TqAQGMo39+ps=;
 b=hygA7hvFmQ84OxtxSjYX4XaU7MNom+T5h1kaOCtUz0IDSNi9adYJFHajWg5xUTyXML
 zirVyA0Sklg8WbCyt332yArSlOdfvmumRbicMgLvJ9dRUE9NO1cy2uQPnaxLH89NyOA3
 X26kpF0qfC/mtebNLXceYE5zrk/IwMN9MqjTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714201; x=1777319001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvsSZ2iDnrBEthugXTCOcDsVcM/2V40TqAQGMo39+ps=;
 b=Eswlu5v4LY2xi/maBlWvQhG0R1i1H1oqsbQ0GOtZlL9Kz53HfWO89IoLLzM7V3WYeB
 wF5imRGvE78R6BjLimDnd4e3S80zSum5FIScWOjddI12/xPWPvXDgAcKJva4QE8tzeTE
 fva8EirJCjdnGOcTNJXcZ8RlpGz8sEIAX2YNDYpEHugoxGfF5BZKYx0BZuQHGHweMcc4
 YdvQll3uInt3FCphe1ZnWFaqKo9sIMadxNDtT3kYlRoYhRmxz98pv4NOtNESYER+SKqV
 VU1aXAMQ5CgOVIMEziAR4rtZiQyoKFPD+qDbb+GDWFBnX/mlaNbxs1YgKjtkGw03LG5N
 16UA==
X-Gm-Message-State: AOJu0Yw/67d6jy05XsHpvXMP1uFgExDcSURZo93/be3eU2erm+agIwSo
 v5BRZZhILjXyav4IUS33b7U7CJ6D/FS370jeDDFqFIluY1SCr27gGwAKsOTEtdW5mjA4hk3i1I7
 brA4MCShu5WVqJfua1bT+EPHDCz1RbJLs1HKC0paW
X-Gm-Gg: AeBDievtKkO+On4DwgENOgOyTIs4H5wMoV25Yh1bVhvPnQgoRZB18U+9t09dwikkSM6
 l0Tr8FIQcMaUgCZdMjGN2PXZd79B1dqpq3Htge/qfoEMwxh8F13INZJPKv3WFY25QW/4A3rm5Ll
 g81d+FUvh71zzXIXFaPCZMaeVmUJTtxBugVMB14VKKZPYS3FsyiL+QIBoCTJ6vEaDqUTpmjycO7
 wNJhmO4FE0+QnO9KUOgZBaBBEK3OBsvIQSuLvR/WWCOMLLO7krY0cMHmBNfpENsXDMhBOLp8Zu3
 vkMeGcvHD7pq10xxC/Q0
X-Received: by 2002:a17:907:2d92:b0:ba7:52f3:4645 with SMTP id
 a640c23a62f3a-ba752f34e9dmr303322966b.33.1776714201422; Mon, 20 Apr 2026
 12:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-6-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-6-9900002d8e72@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:43:03 +1200
X-Gm-Features: AQROBzDRUPTTTr2QItTk6SnoJN7GgO8RiWKG7B5Qfn4quL70I8iLuflwAnbnGfM
Message-ID: <CAFLszThvRZ-OQyx-JS3jOHBT3k3auB3TgdP=g_eyfj1EXqbcCg@mail.gmail.com>
Subject: Re: [PATCH 6/6] boot: remove NO_NET use
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Udit Kumar <u-kumar1@ti.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Adam Ford <aford173@gmail.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Stefan Roese <sr@denx.de>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Anshul Dalal <anshuld@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, David Lechner <dlechner@baylibre.com>, 
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Beiyan Yun <root@infi.wang>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Sean Edmond <seanedmond@microsoft.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shantur Rathore <i@shantur.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 20 Apr 2026 22:33:40 +0200
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

On 2026-04-20T11:36:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
> boot: remove NO_NET use
>
> NO_NET is now a transitional symbol which may eventually be removed. Its
> meaning is the opposite of the new meaning of NET (that is, any
> networking stack).
>
> Update the symbol dependency by using NET instead of !NO_NET.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> boot/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
