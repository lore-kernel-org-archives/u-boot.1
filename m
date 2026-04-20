Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5AFF5A8BB
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211A3844A9;
	Mon, 20 Apr 2026 22:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HZEpFovV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C151E843C0; Mon, 20 Apr 2026 21:43:16 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67A9843AF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso544389366b.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714194; cv=none;
 d=google.com; s=arc-20240605;
 b=HrVUlQAnS8XtJQXbo22t0/XyTdy+2zqsT+1zzNcJpa+PQf/T2fhvZSe6PTCYisIt8u
 D2eabd304jNHOTDWHYeqaEW/6GIBsYxMX98SE33GbWaBKGAfkQ0FPebdn+e3HQaku/kQ
 ihTLH0wVhOdu1cUySOnZCcmbSJDgrAFTdYyKMh2aE8xkFSWaNiF3cObxLyN+mReK0xFy
 7bIzLnds1V9CcLLPEpwb/rIg8I2gMpIWnjIkVj/aJk4Slu8zR1GYQIrhHt2AXVzRTIvv
 IFyrnBGw+XF1Ps1nBeKZUPI0hmy/kJvE5qcTXgcnDjv8L5KD9VbbyJ3WsDxuaDH0QuPN
 7Mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MPQTnKrw7KOMiwluDMN4lXZLBDL2F6s/U3vxClxzFiw=;
 fh=B11T/ZyKvSxF0qhOl4M7rr4wqKWwkB2JbP3jqmHnKhk=;
 b=bDk1KpvQhqZKAin4L/n3iqbcY+GXxF1Q7M0BiKse5s+N0oRgl1bJdZ3b95qQ/PH4ll
 efb6uV1hPxmkiTCgKM7QOvcQ8C57GoWSyORZjwTIgqx2juCyumUhMcVXqMwLhP1fr2Tj
 KIV2m1hPi5frCYvE3zWlZtUWIvqW2ZV3gGPniwcpW+xtf6nOUh0cgHCKG/2f/ySpLwH2
 64MT+jajf7m6ZwpfS0EHDhIUaiZBDXmRImNdRc0qM7vlXIXDgTFPx3glrd5Jn7U5pLRo
 /oNF2/mjMwriWHJ8gGXEJgG0GZAq2FOub6peVjgAAfe5LXLOPdvqPmhjDZmBX/7SvRTr
 vDAA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776714194; x=1777318994; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MPQTnKrw7KOMiwluDMN4lXZLBDL2F6s/U3vxClxzFiw=;
 b=HZEpFovVJiyMdNBXxhmkfJlI5HLOK4bM4GAoFzihLTWHSPTIqnkRrttyxJ/h7g56JH
 RqRiQQCruVeDFXk5qnmpimP1eGmsptjnrs81QABSupddf3ubrqdDU4PEys5ZSQjrPVLA
 aKCD/DWwSF/VNqcZPaKw5eSQFXppndi16jM38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714194; x=1777318994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPQTnKrw7KOMiwluDMN4lXZLBDL2F6s/U3vxClxzFiw=;
 b=Dqba7NonuOCUoZxqD3Lfg63HP9HfY11iLzh2DLBtT1cLFsNVCSF1Xa/8RZEe+UWiFy
 tJzMZ+aL1bUTQryhUE45zDAqERvCOeY9k6qT8+/5LvRuwsv/YdFZbvoPABihQagJ95BR
 mzJ6gjy7WimiYcOQRfjtiO5A7bUzm/NW0oofdmcUE08qYUcmtfqvCoLv7CfVB7tMGCyn
 z7qqZfQ+832wxXbh10oNfaDp+/TGYDyJ5kPdcKBC0VwN4LAf0GTrBTM9i2Hrf8ciQZAE
 3ARWG2RrC0DDeCYy8oI6qHJ5U+0HHSYboykCKnAzzB59Q8iItQ5fw8ZJNTQDyt4nDT7s
 Ukng==
X-Gm-Message-State: AOJu0YwEz7D0WZN29M+gw9y13JDte+sVppHQ21obZLtfcYCk/QdHR/wQ
 r7KIXAh63GTN+3a5nepmuClKm1G8fHj3WLAtas4IMtzypMZQ95etEiGq705s3zzNf/h1VwJTuVU
 dH+4D8W09BF2uB4Y4xU+in0aRNKCLwb7IsSvmJe6j
X-Gm-Gg: AeBDietvcOWx9/zQKQ6CuM5/ZfZj1Ck1L4iJ9mMmMYcr61x02X5cUrCQTp5D6lANFhI
 Kn/dH2bi3g73t6TkV5aVdcY6hHKwMqsas+WIAP/F+qDbhoM8n7HoRcdzEZ/bdcpa9fennF0AirK
 GrZK/X1CfkDHON4kooIx7UgpkTu9NsyGl7Hg2Dk2E7bIOyHBjORyP5SpkU8MC6UKCIscS4GA6Sy
 5uPaOAVVXrNdHEwXjlMj6G4EuT9lLHe/LlmT3EpdZ3EHNJUmwkgSrQWpwpAvVkT/Tk8Iwg0V8O5
 mLxo8RhHv41WzXSztuIu
X-Received: by 2002:a17:907:74b:b0:b9c:2a5f:41c4 with SMTP id
 a640c23a62f3a-ba41e4fd92fmr726116566b.40.1776714194058; Mon, 20 Apr 2026
 12:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-5-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-5-9900002d8e72@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:42:58 +1200
X-Gm-Features: AQROBzDc_c4NOu8SWKf8MZOUlBGOK6J3WKsf0IZekifA_j1uSCNB-AAv0nKd-G0
Message-ID: <CAFLszTgaU-UpCdnsF5XSZWxiAr5BwT2M6ZgSoFmqv4ExNmoGwQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] doc: remove mention to non-existing TPL_NET
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
> doc: remove mention to non-existing TPL_NET
>
> TPL_NET symbol never existed in the first place, so let's remove this
> misleading piece of documentation.
>
> Fixes: 143c9a7e9d68 ("doc: describe TPL/VPL/SPL boot")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> doc/usage/spl_boot.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
