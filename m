Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3B6F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45228448F;
	Mon, 20 Apr 2026 22:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QiR9ATuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2D2843C0; Mon, 20 Apr 2026 21:42:51 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1708843AF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ba60d78aff3so290877666b.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714168; cv=none;
 d=google.com; s=arc-20240605;
 b=HLFLrjDEvRLMPLhyacQpo4h3TzNN4IgLFi76OLplJrZ7cjaFF3XtVPfsgCD7wGDf2F
 n76sbPJ+eCzQk5BbuN9S/s3GgkLN+gu6hZ+awPFw3PfWVfqCH+cza3osmJ0mS0Igmhvp
 yfg7QzkfO+qwj2jQha2BPSacXJ4viWWp9CKc6oiBzwfnRUeJ68/YrdMnIDrGwbmb1QCZ
 XOyNPiruE5yEZgv6juWFiPYxzB8VZhwl+CYM9lteFLatcPFY9Q80VC1Yyh4r6I2NPuwB
 XEl3m7s68rbCUXiyt7HuvkWjnrSXmju7zDtkPVh53lg+vnVasTAI4OJggICuxwpmc7fS
 p0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ay8F/BTYwPDSV/SFkypuI/ltVZXRrxcnRaPDPv42+3E=;
 fh=B11T/ZyKvSxF0qhOl4M7rr4wqKWwkB2JbP3jqmHnKhk=;
 b=JZlp2XV0UcfH6E/JX3mtW5uzqA8XDVfLVuelIlgOKLqc/rdySatwa9EZHYrahY3bCM
 I/79clZ14Xj2Il13/uIKQ9x3JowHUfMRxXryMx0MP7I1XVbDVufGKjbG5d+DqgDVX5Hs
 BnOwtGSoaQDE1LxnqfGrAFy8hwTSQyFUl+De51CVszPwSOWbsVqP+Ek/d6GOL0WHRXcM
 noCoIukSW+GKes8mEoyRg1ROvwN6rlxOFYwJ8UUqxzEigGGawijy91TH66Xa0b92FKWx
 Qya17GFf2H16aMFHirVmk55HWSkgrJhE+ZD1AArwqnOYc9llMNg7peeRnFFUGIY9ZrvJ
 sUkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776714168; x=1777318968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ay8F/BTYwPDSV/SFkypuI/ltVZXRrxcnRaPDPv42+3E=;
 b=QiR9ATuAPmN+FGGQupfSeij96tKeFqrFlvLzzH4DfDHoeXG+GHGg6Pd2Fmg8xXNmkt
 Otg1EAsoxT4FJxOHjt5lfgvZB8qs4KcntlH26OokEhDGsNgeJK+Oy+3xgIbMMU4x37fk
 EIXJOW3JjI2iTMfWWCTd/4rdb3WYjqUEoUtRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714168; x=1777318968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ay8F/BTYwPDSV/SFkypuI/ltVZXRrxcnRaPDPv42+3E=;
 b=RS7MlOgoeYphbYSow+UkcwT7jiO+4R5pzJWJgyMeMTkc+taviXXxUv4Vt8r6hVEtOe
 eGGDu1I152EAtmP2NxdqYghH4TnhK2/5KzZTOR5uJC+Grf1nioQwVrVO5zNDV8E6RXEv
 5qvIX4ftzuAk+D+v2SqG3GQfMofzzn2V8Mz3sKgL4+CQlnhzXD6K3F+YE2noOqEfaYhl
 4dDVOAJzTtJvQDaC4hmNIZfZ2uKNoyDTGlc2pfHttcVcOLz05KvTOTR3ToV/aQWQfoKv
 u2gqlZMwzNDvIDSuPDobSfBhzQlR/j8Ewuh4/bhzq6wB5tvKNFVwrPVHMjHCYP7bCAFQ
 m1EQ==
X-Gm-Message-State: AOJu0YwDymV0L0NWXAd1as7ZNjnzo+XVRi93Exg7SxOiTKfk0xwKap3x
 FYtRTb/n/ihgo1xlD06wxxai1xvmi+x6wyeM1wjNn9et3LN38nvFW9bnbaEYilTx16Vxu5fAkqC
 N6HazveXjy2quM1N9FqxrgnRp2prPZkKO1e52dbDL
X-Gm-Gg: AeBDiesjxMp76Yh56XN8QMohwYFJeS7p6TejmhwciYopGa66+jdg7trQOGPPTyo52Pv
 +6LFppedc7YdYlfe5BhxS5SBMrkW5v5X0xGH+fQvwa3BnmuAqvAypgUT+JOUCzjJA7Ku9+davxX
 /XS2epQMgJZDSCpG0vPO5cw+7Oy7fb5q2Lwaf1B+QjXMkJvx5b6KjU3RbnNeAqtlu5FqzlUo2ns
 WGk7V0/frdmXCx09pqByJ8CWP+b5FFVxWvU6gycavC8c22YNz+yMDrJxQgt4kE53LFkYLODp4Sr
 5thyfVphvAbiLnAT0MUu
X-Received: by 2002:a17:907:3f9d:b0:ba5:20b1:c13b with SMTP id
 a640c23a62f3a-ba520b1c177mr549344266b.28.1776714168006; Mon, 20 Apr 2026
 12:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-3-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-3-9900002d8e72@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:42:33 +1200
X-Gm-Features: AQROBzBBD6QWXgHXqsAjqUBUSofUJnydf3AlVzyEs0FPNUlgYAhIX3iqwKpVkiY
Message-ID: <CAFLszTh3hYDBX1LbegMCGqOE4JPyNr2yBTkX87Av_qptXqLLZg@mail.gmail.com>
Subject: Re: [PATCH 3/6] net: make NET a menuconfig (and downgrade NO_NET to a
 simple config)
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
> net: make NET a menuconfig (and downgrade NO_NET to a simple config)
>
> This will allow a bunch of simplifications across the code base.
> Disabling NET is the equivalent of today's NO_NET choice. This means
> that if NET is enabled, either the legacy or lwIP stack is necessarily
> selected, which allows us to simplify if NET_LEGACY || NET_LWIP into
> if NET in a later commit.
>
> Config fragments - or defconfigs including other defconfigs - setting
> the network stack (NET_LEGACY or NET_LWIP) must also set NET (or unset
> NO_NET) if the config they apply to - or the included defconfigs -
> unsets NET (or selects NO_NET) as otherwise the NET_LEGACY and NET_LWIP
> symbols are unreachable. This is the case for the two defconfig modified
> in this commit.
>
> NO_NET is now a convenience symbol which hides NET entirely to avoid
> modifying many defconfigs. If one selected NO_NET to disable the
> networking stack in the past, this will still work for now. Technically,
> we should be using the 'transitional' Kconfig attribute but that is only
> available since Kconfig from Linux kernel v6.18 and we're on 6.1 right
> now.
>
> Note that this moves CONFIG_SYS_RX_ETH_BUFFER from under the Network
> menu back into the main menu as it seems like it needs to be defined
> even when there's no need for NET support at all and menuconfig option
> doesn't work the same way as a menu.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> configs/am62px_evm_r5_ethboot_defconfig |  2 +-
>  configs/j722s_evm_r5_ethboot_defconfig  |  2 +-
>  net/Kconfig                             | 23 ++++++++++++-----------
>  3 files changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
