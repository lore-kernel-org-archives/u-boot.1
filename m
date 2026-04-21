Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE59F327B4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D278842D2;
	Tue, 21 Apr 2026 09:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tu+gDehb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3096584119; Tue, 21 Apr 2026 07:17:41 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DADB83C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-651b4d09141so5003339d50.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 22:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776748657; cv=none;
 d=google.com; s=arc-20240605;
 b=kpxIDWa5KqT/jU7qckOD8kzmMcrE+Ja10VoWH66TV6Yl33QCLN8T2WMQbNgFKBvHTT
 nbsMqy0hK51XSBdhAvZiruNfx2OHuQfpdtO2BcUBPoiffIVbY19Z9KOgBFy/VzrqLGOi
 kQzWukzjOixHIho9NwDrE6ldMtnuaTqB9uLFrnk3E7oRdCBr5nafFPHSoOP5nSA73BJf
 uslucpk6THfjlgztkLWF/684ZUxdbrTWVEBJfov3VaEn42zx4nqu/gooM29y2uNZRUsG
 KgAe3UsFJ0M+Rlw1bdEXS/tgOILBNyy+iKhObchA8Z6mEtdyyoitERksmFwGgrsvYqb1
 sHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yk5h6Gzf8QWvSKXTZlPvozGVtAG7c+Aw9YYTpIqN23E=;
 fh=vor+8SMF4v7ubiN9P3R6H+Zw0/9OGjgGN5wypefG4Qk=;
 b=VxNVNaixOginsGjJAHcnd4LiPGJD4jzH93VygSodfWPkPk28fyl61PlW8ulwEFUskm
 W9NxysQKtjY/4PYzmCV9rcb/nwbMX5YXsPvVV+9UnPOuatOuWGw/HwFoBof5XukublWP
 fogy5NseGB463iID7GyZY0cB7sKzQui2ZPy9nCMyeZveZkrf+YgHsO1K+CwjGzQ+phKh
 p7++osP155ML2u2tZeLh7anXnM49XJezxWCIR1wdBeU0RZrcL5LjWFc2Y/v1m2o6sW/+
 PXyQGM7HogBYbEQRPYomPRYsDFrB4GZ5r/Y6MtJvfq4mz8EAtv8lz5xfNASMn7XFGiW8
 8cuw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748657; x=1777353457; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yk5h6Gzf8QWvSKXTZlPvozGVtAG7c+Aw9YYTpIqN23E=;
 b=Tu+gDehbus5DGUlg/HsF235BJQ2UOsF5R9v28bFLeKU1sFxgyDwn9LZzkjObnX7ZZ5
 1TQiULDkdK/Gnz0QUyACpYxebMei/j5061l98hRn6PUGA8fSGzofhVpqDRR7GmMSbTTn
 6QzajqgBsghK5IpCZOYBe54Jo61L7P7kTRjBE8B8w3YhYAVTDscV6YHANPMWp260TLxx
 G0gnvkA6CmNJpJC54pi6XSEdo3uBYChzoAf2RLGT7IwZY2su1XsVQktjwt4H7YRWJDK0
 z/Up60tjl3Fqd0qoXu6l621BtPtrc7ELBwiZrm1vMbinSvRO/OfkkG6xR9F+Nd4NA0GI
 6ZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748657; x=1777353457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yk5h6Gzf8QWvSKXTZlPvozGVtAG7c+Aw9YYTpIqN23E=;
 b=Rf54w9y3Pghq7Lzd+sCqEx4dKmd+K+uWJWntpPOHZSAZ9j4mcEsfcKUfN6h+4hk5Pk
 IwUFzEjgD1dCbrIJv5xv4iYCa1xb/zj9M+iSHAF0smItB6OTTho5Jfi8MDn3Ox23xYV0
 EksCd3t1MM6rWduvQ2WlE3Y68YMF4qSpc0t3yetk+ek8nAxxgxLeX3W9oX3u2hVxMe0O
 Q1HHwCwZo/ZLYY98B5ZPkV3c4oWE4TMkHzihEHw60Xxsx2ir5lwql/K12/nmkRtggK4u
 urtNIYWrgZZyRbPvC5FfS1oBI+yxLIH+Hc4s94taHnef9g+ObrIfWD1xJOzkqNIvLJCM
 4yiA==
X-Gm-Message-State: AOJu0Yw30OyWn87LiPG0+uUXDY1ZoAE8otfsLxpipV829+t+p4YoU/px
 f4SDvLHzjPDSRWeFSSBjMQ2MZbvKx9MRdHpXA4cmHajTrP9IiIV6utnrY+KvbPzipitvFR7nTUq
 K09Rb+czkEsNmtbf29oazUpMSJuovjwul8lT/JmibYA==
X-Gm-Gg: AeBDiesbFMOWRBd2Ax4P+spmd6Bu83cFHkh8jvqUgJIungHhx8TZNxWoF6J169xrr+6
 bX5Zx/3P3Q63wIC18D7JVDtdl9I7DFt+3TY5qkk3YVAxIR2zRVfjdMkR6SQM7EMp1uKeTiQ4f9W
 sihRqny/sPJmcz9XVqrfFujXrnhLNMWGbvCugAPA5TYhzPo2UjYg9CRHrcy8nlGUWkAbvfcByaf
 tTL2BlmNsEy3lgPG1Ks1PlPTVTsuAWKRDmuqbnNbXuEc+72/z8Gm5J4TeAQbEx7ZEc/r59KnB3T
 7S1skAyVrtYXYMsgixjE9CFxG12B27MtQ0Va3Bgq1KSPIKqLETzu1bjWMZ1Go7bXUmvM6sComTZ
 Dg4UezxO3NQB8YAM6zKFCXY/ovPR5wvzHzcqgv46xwCwJthcvWagLawnZi91VlJOrAIOPvhFjxS
 Rj/MZuqEiCdSSgvIPKTUsWGxZIIO1BUL1UgjCelWrjNBjrZSSVarOwJDEtNzOw7hIJW5psxhuPw
 JI4i5CbN4iWXMMSaenvQg9wL2gi1kag9UxlfeYHDiw7vdOQCMGZjcW7+hSrRXqrTjlfnUWdOmec
 u/7XCT5dYwFbn2IcCXXJGJp61sU7J3+2UogP6sXLfh9xs71nYqtCeVk=
X-Received: by 2002:a05:690e:1914:b0:651:c41c:80ce with SMTP id
 956f58d0204a3-653119894a8mr13072501d50.16.1776748656972; Mon, 20 Apr 2026
 22:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-1-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-1-9900002d8e72@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Apr 2026 08:17:00 +0300
X-Gm-Features: AQROBzD8z4Gz2E8G-xiaDkBkb90xxLB-LL5yMQJ0MwU3EgkDyA26WX0jrIPaW8U
Message-ID: <CAC_iWjKaVsyxCuKmO8LqR-sS4DN4DsEnfhf1mNEswT2PtVJhHg@mail.gmail.com>
Subject: Re: [PATCH 1/6] move networking menu in net/Kconfig
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
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
X-Mailman-Approved-At: Tue, 21 Apr 2026 09:28:47 +0200
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

On Mon, 20 Apr 2026 at 14:36, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  Kconfig     | 34 ----------------------------------
>  net/Kconfig | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/Kconfig b/Kconfig
> index 7f00e76ba78..1fa31a4f5a8 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -791,42 +791,8 @@ source "dts/Kconfig"
>
>  source "env/Kconfig"
>
> -menu "Networking"
> -
> -choice
> -       prompt "Networking stack"
> -       default NET
> -
> -config NO_NET
> -       bool "No networking support"
> -       help
> -         Do not include networking support
> -
> -config NET
> -       bool "Legacy U-Boot networking stack"
> -       select NETDEVICES
> -       help
> -         Include networking support with U-Boot's internal implementation of
> -         the TCP/IP protocol stack.
> -
> -config NET_LWIP
> -       bool "Use lwIP for networking stack"
> -       select NETDEVICES
> -       help
> -         Include networking support based on the lwIP (lightweight IP)
> -         TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
> -         the default U-Boot network stack and applications located in net/
> -         and enabled via CONFIG_NET as well as other pieces of code that
> -         depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
> -         Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
> -         exclusive.
> -
> -endchoice
> -
>  source "net/Kconfig"
>
> -endmenu
> -
>  source "drivers/Kconfig"
>
>  source "fs/Kconfig"
> diff --git a/net/Kconfig b/net/Kconfig
> index e45ceb25106..249c27c115d 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -2,6 +2,38 @@
>  # Network configuration
>  #
>
> +menu "Networking"
> +
> +choice
> +       prompt "Networking stack"
> +       default NET
> +
> +config NO_NET
> +       bool "No networking support"
> +       help
> +         Do not include networking support
> +
> +config NET
> +       bool "Legacy U-Boot networking stack"
> +       select NETDEVICES
> +       help
> +         Include networking support with U-Boot's internal implementation of
> +         the TCP/IP protocol stack.
> +
> +config NET_LWIP
> +       bool "Use lwIP for networking stack"
> +       select NETDEVICES
> +       help
> +         Include networking support based on the lwIP (lightweight IP)
> +         TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
> +         the default U-Boot network stack and applications located in net/
> +         and enabled via CONFIG_NET as well as other pieces of code that
> +         depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
> +         Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
> +         exclusive.
> +
> +endchoice
> +
>  if NET
>
>  config ARP_TIMEOUT
> @@ -254,3 +286,5 @@ config SYS_RX_ETH_BUFFER
>            controllers it is recommended to set this value to 8 or even higher,
>            since all buffers can be full shortly after enabling the interface on
>            high Ethernet traffic.
> +
> +endmenu
>
> --
> 2.53.0
>
