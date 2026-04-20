Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460B3F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD0084480;
	Mon, 20 Apr 2026 22:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WJapYNHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA64843C0; Mon, 20 Apr 2026 21:42:45 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B11843AF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso542338766b.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714163; cv=none;
 d=google.com; s=arc-20240605;
 b=F19fC41w/Q3nGlXsEYWdDGl7IW9FGfZtop83teuJTY22s2apiGj7SN5VjE+8QWPUGb
 Ixmx7k2O/GlxVN//y7uN60bH+OKrBprnp2HmxYp2dugfVVxparEGBs7coMssp+iKRYPL
 vcN0fs5k24euic3EOnEG1H+Q0BKPJyVsmKt2CybGxJ0fO6b4CZYiTrcaycVmo1DtW/1w
 cNF6+WOesnl/AnOgqvA2O61YhdUsGwR7Ujzo0f5cPztqXwFnbN50qot+drb487Jn00FZ
 UZDzgtb8L7qEtUuhMfJWUPL2i4x+Zd52nx/LKQWPnomVz49hKuwrIt7XvxVidZnC1tFk
 GLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ypuw9PF5xi/biZOPZRabWKAPeQ6GuFoWbITRVn4TTmI=;
 fh=B11T/ZyKvSxF0qhOl4M7rr4wqKWwkB2JbP3jqmHnKhk=;
 b=je+52nIxlAOtSypDWQ4ozBp2zDF1UAuDSnPXowEXNXQdCB4XmoM5NUfGPhjqRtultt
 /SRX5L6eqNVXkS5RlD/Eb86JJ4Tgk+K1+pdVzPTRhXyMC6eNoNXhTFaptl6Clbd+UGWq
 zzKDfG1341O55sCgb8+bO20DR5v+jOzc81Smr2NLu1zZloybOIsr9Q6kMOZORimjOt4I
 KVPSCq9jhZ3Cqz5BLMsA+hmHxMUhvPyIOZmFvwUaaSJYKhcDY3sx1D28zd8LYljeohys
 wxUhdPKryu+c40VJnj7ivYJ8Bd+Q0tw8Ne3/7nDYzYFooKKGG6CgXj69FFY7iVxTzppg
 tOLw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776714163; x=1777318963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ypuw9PF5xi/biZOPZRabWKAPeQ6GuFoWbITRVn4TTmI=;
 b=WJapYNHjweMwM7NC31wGNxA2QLzeMB0s+OihVBwV6E2rkOC6ivGGIDonKR7fyLi/rL
 NH65nDQRr75vOyoLpnVSGe4OWuJYkZz9u/j8blO2H1rrPK5PnvusVYQD3aSC80Augn54
 gR2SMBeVdDmFl2tg43OeRv37Bu564JZphRnWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714163; x=1777318963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ypuw9PF5xi/biZOPZRabWKAPeQ6GuFoWbITRVn4TTmI=;
 b=p9qoCz42kH1BSjW5Q/20ofi36JI2pGlMduSuFyeF0NEX7msVwsGRGkAoyhsMz18yhF
 lk7igEg0fmIxy9a2g7AyqqRIxQxcOmKbqYfWYdIs8RofcL9r5FfH46hLgZmxDw/ZGFQ8
 B4VgFAipElnf6Xqkc7PSvkvaBvGfy9I9haprci3eyZlrjyQ4JPnUQaYQMpZD9dMx5tr1
 FZUa7WlcqLwWmeSANfyF2f2D/nfUbWlrFBk+CMxhCTiNFyXDlG7G1M9CPCFYyr36doqA
 kb3bYtwkZDTCbwN/peZFdMPph7K0vh46oq4YRRWkEj7vCwwuhj99JhfkmiX7VynxA8zJ
 n9uA==
X-Gm-Message-State: AOJu0YzjETn3QCeqSJlVudq0mjQU4ORqLaFUBjTwxErUP56eeTaQF40+
 HlYIIU6D+dUWpmNhg82upNu3WswTx88VHoYaqAkIid2M67YeuyyZ3jIVJ4YJslchpkicZAkjgm8
 zJ7un66U415DSAqVh1YNToPZMv+ay3VMOFRMINRMqCibg5nW8iuGY6g==
X-Gm-Gg: AeBDievbP4CqoXgN+vJvZl33Sw/Z8kapJ9+dvbYFITvGmrAlOcpOStdkl+uYoYVHSSi
 bGFs+WCrjVIeqoS+dvsGUAWrlJ5m0+qydiawszL68oWeswbLpEPr10SQJOFjeHtqku0Nb16OOrY
 Bquwl506K5B/1cIzTVoolrpN3ziRzY9w6bQZ1tSQ26JUIcfjkoJlgntz1iNseC6K1Zds44AAORk
 j77REUUuk+UZiDSignSi4gRKgMjbcO9cPtI9XSdZB5W8XD4oaDYEe4/0Izvm4ml6z0eLvqkGZOT
 lt6atrQBAoDRsDKDs2IpUviCC/SYR3g=
X-Received: by 2002:a17:906:7946:b0:ba2:7010:c535 with SMTP id
 a640c23a62f3a-ba41c0bb9c2mr677898266b.47.1776714163159; Mon, 20 Apr 2026
 12:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-2-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-2-9900002d8e72@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:42:29 +1200
X-Gm-Features: AQROBzDznf7kDxkVeaGLIG0V-FmjUP2E_ft52nSwIy0O1aD65pjfMq1tnx7ViT8
Message-ID: <CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com>
Subject: Re: [PATCH 2/6] rename NET to NET_LEGACY
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

Hi Quentin,

On 2026-04-20T11:36:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
> rename NET to NET_LEGACY
>
> Highlight that NET really is the legacy networking stack by renaming the
> option to NET_LEGACY.
>
> This requires us to add an SPL_NET_LEGACY alias to SPL_NET as otherwise
> CONFIG_IS_ENABLED(NET_LEGACY) will not work for SPL.
>
> The "depends on !NET_LWIP" for SPL_NET clearly highlights that it is
> using the legacy networking app so this seems fine to do.
>
> This also has the benefit of removing potential confusion on NET being a
> specific networking stack instead of 'any' network stack.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> @@ -422,7 +422,7 @@ includes the full set of commands, more error messages when things go wrong and
> -several filesystem and network features (if CONFIG_NET is enabled) so that
> +several filesystem and network features (if CONFIG_NET_LEGACY is enabled) so that

Shouldn't this be left alone? Or perhaps restored in patch 4?

BOOTSTD_DEFAULTS selects BOOT_DEFAULTS which enables network commands
conditionally on !NO_NET, meaning any network stack.

> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> @@ -159,7 +159,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> -                     if (IS_ENABLED(CONFIG_NET))
> +                     if (IS_ENABLED(CONFIG_NET_LEGACY))
>                               printf('Net');

Similar question here.

> diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
> @@ -232,7 +232,7 @@ void set_board_info_env(void)
> -     if (IS_ENABLED(CONFIG_NET)) {
> +     if (IS_ENABLED(CONFIG_NET_LEGACY)) {

and here

Regards,
Simon
