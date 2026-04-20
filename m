Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A502F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C22684462;
	Mon, 20 Apr 2026 22:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PtJsSMUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0738C84431; Mon, 20 Apr 2026 21:40:40 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01117843C0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so487474566b.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714037; cv=none;
 d=google.com; s=arc-20240605;
 b=NfrHQBTxy7Pn/4xEJPE/az3xKJu81YfZkd9CuQDE0YY0QQYDds95P5icHWUu9RD6ar
 VC6RR6UGcIDi+OpGqDJQtphr9D0ZGlyexWSQCQe/oMyeweDkWXl87Rfdfnq5v8JWZEpS
 g4zgfWG8umRn6KJCo3A6xeTgRxyyiURWpQKezEmJ4jNJ+mAWpSn92rdiIYhCSanK2AB9
 ozJ+MyihtTQWI+uLbiOnHt/yMYHUd6tcRcVE2gKd68ofoocKeHYINq0vqEfS2sjc0JAp
 GK1/1vBeLVCbMtPhvayEraLJdTNFGDAo+sxGU5PqKGm0EoxJoBEJXI4hZQAE9+yvua9t
 27Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QJwjcDEyqhG1S/OzWjzm3dFd7n+vldv03RfUC4xxhKc=;
 fh=B11T/ZyKvSxF0qhOl4M7rr4wqKWwkB2JbP3jqmHnKhk=;
 b=CXTS58qKh+Lr6Jaothh/sB+1dl1u5J8a4PATbiHqS3X0S7FmtF6llzjlXR6Heaau7x
 pSFoNeOT3LXeuKkhgh5nd7euGnnckBEItuHzTEG4O8OxNZ6tJKHq0u4R/SbAqErefKAU
 rkXLtxXfScoFkmfGug6dkhdGw6wa2bMQUCrTqc5aQahngpUbIXN5+/tlnPW4BoiVrgMx
 guk3ZYr+iYvHdwd11gBPWxfIZZr2JPsiMurfXYKZvapNL0sSjZA2S/89rdHZA6EE2MgZ
 ErSNC2iRyjgCKznOLtk5wfV0rbuQeytE/9oXoXmfLZ3uwQ5u2zpGxNzlzCqN2yW79pvH
 /fxg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776714037; x=1777318837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QJwjcDEyqhG1S/OzWjzm3dFd7n+vldv03RfUC4xxhKc=;
 b=PtJsSMUCfC5TzVUmZDg443PzPLKt17JtleXbdGPdxmRyRmoeSGKzebVTNbKgnlgqYz
 Rkg/R3eHbjfh0So6MMgbpH+BvDRdX9VEI5DgmBMCmTaftJdRd+LFpF0IfUqcN3n7vkcS
 F8oHS0/raqDrt877tkG81o0TQVYPcLVHNW40c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714037; x=1777318837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJwjcDEyqhG1S/OzWjzm3dFd7n+vldv03RfUC4xxhKc=;
 b=WGnDesaf7ANRrNCnhvstz6N/MkUg1RTrFUVgzoicOV1ixyYonCMRzqin3a/zSknRic
 p8EyBEDY02yl9R/Y6hIMxYhwVlT+R+1R4+2QZ2IOD0bAX3mur2PyB6K6Hhv5oe3/5hsL
 4VomVvMqWeEXip131hWkjxlMWZFMpROBxX7fHtjz/CdqHNe7Fbygo5Oy+08a15/dMy2a
 EIgw7bQCpgcerfMQjTz0u5gbgPCiyw6z66pqaU7YMGranPV6NjkWQ+wQ1PGJa3x28xf5
 1KeYiTfzmzsNs1nznI35AuFd5rhzibs1Ll3JA+UutOV9KjXmCoZTxqwBPWmNQLVtbg2f
 dmIQ==
X-Gm-Message-State: AOJu0YyxtNeVlYZKxkbzQ2K0rmSh8PJCj59Zx63yddrTH+9imPW8TZqS
 PIiVcP1Hgj+XwtNby8LvePxJ2P1RjAayEK+5VLqwHEx/9ExmdWa/pwgtc4KJcwGRhvzvjTSRorM
 YOcpaYJjfHBC46lFSsxzIb0Y/O9+ylkv5z3Fh+9+v
X-Gm-Gg: AeBDietwBQvh97nzJvvicTKHZYVVWWfdN3+3R1yReJSCGb4nBKcUcLDzfHobuNLjpC1
 GY/9RdofJo9jwzCSavpl2XyosAIYLOfsKi0+1MM6Oh9+D+D13Iml2aqsd2ZN+h6EPYSBnx+6iai
 eG9GTu8030+OuVumSOsbWiuPXkQmJRKKxlxR3HNaJuELeOaALs3aeEs1yY5lQTGswAy8JR5PIVJ
 fZBzYFlBBKPG6TjKwd8Egqyx9U87vJz6ZAQcJ3XusieHk+4A76EclVKlUtkgiFMTUU9uL8uHI8N
 YUushapGO/GBVZcS2YeCTo213uGGG+U=
X-Received: by 2002:a17:907:a0c9:b0:ba6:22e8:69d2 with SMTP id
 a640c23a62f3a-ba622e8756emr459285866b.34.1776714037247; Mon, 20 Apr 2026
 12:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-1-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-1-9900002d8e72@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:40:24 +1200
X-Gm-Features: AQROBzDUeSZ552s_5UcnC26YGPQFwsBXLfN8KgMOXexznubb8hQQvhSyobCeg4I
Message-ID: <CAFLszTio+y35wxBcDTpmERV1Xg+cY895QESUWdu8+vg+P61STA@mail.gmail.com>
Subject: Re: [PATCH 1/6] move networking menu in net/Kconfig
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
> move networking menu in net/Kconfig
>
> In the main Kconfig, there are only two more menus, General Setup and
> Expert, in addition to the net menu. Since the part in the main Kconfig
> is mostly about selecting the network stack (legacy or lwIP), and that
> we already have a net/Kconfig, let's move those to net/Kconfig to have
> everything in the same place.
>
> No intended change in behavior.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Kconfig     | 34 ----------------------------------
>  net/Kconfig | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
