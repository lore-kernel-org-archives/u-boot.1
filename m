Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD58F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E0D844AE;
	Mon, 20 Apr 2026 22:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lCffw19o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24E7843C0; Mon, 20 Apr 2026 21:43:20 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E210D843AF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b936331786dso439370366b.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714198; cv=none;
 d=google.com; s=arc-20240605;
 b=OExGLKACh75ykWAHXqlPl8E6dpHNtTi5oKJTkXPFPNlU3DwIbFMtg4lJ7NI50yUK6A
 p/ddEIeONabJkfjkf0mvE9XnYJ5S/tzYD1Hw4Ua8X+oeRpj8MAR1DV4rNYmoqMiqsPXY
 gRgWzag18YYyg4uzeouNMAx1lD3fi0uDho0hc61QDW2gxRk30oqrGIM71XFujvcyse4o
 oiAEsJtrJtmnicMWchT9N9tsKmt83tBJ03lzy3P6oaVZRxxb26BFHY8G1GnSciFfa0Na
 E4ezVA3rDamOmoP8gWnclA8LXMB9RMW3bZMlxrAu01wQ9ZOlT/WgInPLOZejtDfhCASM
 VAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0COehEj8osMi6SeSmatnPDaUACn0wAtDxKO5rh4YTV0=;
 fh=B11T/ZyKvSxF0qhOl4M7rr4wqKWwkB2JbP3jqmHnKhk=;
 b=bGQ4ZaAVwVvB6WB4ff1ARfCJk0d1azfbB1F74/V2R1oohyNpK/nD8y6ZdaKUtWcgx3
 lOBq0rjUJmuuWPVmMxhnDZ34YyLCBwpmh8+VQVEzM1KdyF0HdMazjeTwLJyhN1ZDeOBu
 xGyx9GHe6O3rXCDFupK39aoJXOnoPcWMpJPWCj6fEIr7BC3VF9QwTQ3nUmXS8F2QOwam
 56h0/HzRc9QoY5j/LzlSL2slk6hYLF1kOBTcK2/bRZ4TSeHPMP0s/R1kiHTgzhQmD1N2
 iejluptV8DDcAoTBLfxC68F92U5Y4CxPy/B4+71jLGiIzA5HKNaAkLLXXGAeJEqQQbrs
 kLxg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776714198; x=1777318998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0COehEj8osMi6SeSmatnPDaUACn0wAtDxKO5rh4YTV0=;
 b=lCffw19olli8EkuatYurj8bkAUESC432CoZrnVhQd0e2qVszD1bY9gY61qnbZ5Bk7Q
 e+iXm27LrGH2dxHA4zvjVR/N169CVLiLhsk58SrEb5q0zDAhbPDG99z0ALRQiKS/do+r
 6Fk82X+iFt6niDhagC8T4VRhE2hopt/2Ybh+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714198; x=1777318998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0COehEj8osMi6SeSmatnPDaUACn0wAtDxKO5rh4YTV0=;
 b=rf9I4SBhyTlz+SqCVCtHoHZbE9BPs2wQo1Sup+yCMZpYUgcGRD4suCK2IdhiW/dJzT
 5ZI1lig1pkFUA1LvQbQIxOu1xfxbYAJbOSvNpnxcRa/HhVgOBUUBGZXYnjuAJ+fDZDM5
 uFzKRQ0BLRSsBPo0PAAie0CqmhUOBkGsZiGPtzsax9RSc5FnVTyEA799Xis4e4rTwgQA
 lHNPfSDuUpmzVOx01GvdTZExwVn/ObaYL3axZLc7zgxX5mlQ1MkMD+ESFdayxzBLgqFz
 flt56xmRMQjgBQKgZB2Gm/MNYRtxY0nccVLuYD8xPjLJzXhl0tMfbRaZY/UxQ/khmJ0C
 B5oQ==
X-Gm-Message-State: AOJu0Yzmx+mYnQLtAhfwLPuCVFhtl4krXS4aMeQD9wLhqlgfMm8YkrFO
 kvqdditegpK5Cy8HQT72ZOT//QDweyAN698M0Jtx6C8z0rSHvqxNnH/CV/MGtfO79Nwy43XViME
 CgsofKQDA8omOHj9YPInG9uocZJ2vbrZZLPkSGCi4
X-Gm-Gg: AeBDies4DXLWEDANZ9PZvw+AwDJ421U5YBp25Q3GAdgciXuNnH394z3uaXauhlLxciV
 R0DCQCqFFAGsXAKZeeG9r4M0BQq76wZtFfGs8fK4IiPoGvbWmmATE2PgSy48vxgZlwG01LENQj3
 safXnRKmmTuYBhahhJkUaU3ZnSIcB5GzRbHzRZO9z9fcN8Qv+GaD9CKnyCrUbkAeAs9eLv9Jo39
 ae7Wmrkv+SKbeWedG808b+R6U+OGZap/kUC/LwR7S9DQ7Noslvoyo7e/d/7qT62UmFbYyjChe6e
 ayK1c0Xh5P/aq/VntjFu
X-Received: by 2002:a17:907:c9a2:b0:ba2:3f1b:1314 with SMTP id
 a640c23a62f3a-ba41ac0279cmr452040966b.33.1776714198180; Mon, 20 Apr 2026
 12:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-4-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-4-9900002d8e72@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:42:47 +1200
X-Gm-Features: AQROBzBYvgPmnQbd5S_FDsDhIFwEmbBXHNgkjUcnROJW46_PSae9JRvSy3giUNc
Message-ID: <CAFLszTgnOb+QYAu4bgVC8pQJq6po-noDnrxNVxLX1126m-D=oQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] simplify NET_LEGACY || NET_LWIP condition with NET
 condition
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
> simplify NET_LEGACY || NET_LWIP condition with NET condition
>
> Since the move to make NET a menuconfig and NO_NET a synonym of NET=n,
> when NET is enabled, NET_LEGACY || NET_LWIP is necessarily true, so
> let's simplify the various checks across the codebase.
>
> SPL_NET_LWIP doesn't exist but SPL_NET_LEGACY is an alias for SPL_NET so
> the proper symbol is still defined in SPL whenever needed.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Makefile                                                  |  2 +-
>  board/engicam/imx8mp/icore_mx8mp.c                        |  2 +-
>  board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c |  2 +-
>  board/ti/am335x/board.c                                   |  2 +-
>  board/xilinx/common/board.c                               |  3 +--
>  cmd/Kconfig                                               |  4 ++--
>  cmd/bdinfo.c                                              |  7 +++----
>  common/Kconfig                                            |  2 +-
>  common/board_r.c                                          |  4 ++--
>  doc/usage/cmd/bdinfo.rst                                  |  7 +++----
>  drivers/net/Kconfig                                       |  2 +-
>  drivers/net/phy/Kconfig                                   |  2 +-
>  drivers/usb/gadget/Kconfig                                |  2 +-
>  env/flags.c                                               | 10 +++++-----
>  include/env_callback.h                                    |  2 +-
>  include/env_flags.h                                       |  6 +++---
>  include/net-common.h                                      |  2 +-
>  lib/efi_loader/Kconfig                                    |  4 ++--
>  net/Makefile                                              |  2 +-
>  test/cmd/bdinfo.c                                         |  6 +++---
>  test/py/tests/test_efi_loader.py                          |  2 +-
>  test/py/tests/test_fpga.py                                |  4 ++--
>  test/py/tests/test_net.py                                 |  2 +-
>  23 files changed, 39 insertions(+), 42 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
