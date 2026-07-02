Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8689EC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 23:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C7784994;
	Fri,  3 Jul 2026 01:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="ocNOEdCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54DB84A7D; Fri,  3 Jul 2026 01:07:29 +0200 (CEST)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E839584994
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 01:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:5c40:2381:574f:e2cd])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id B8A3F20040F;
 Fri,  3 Jul 2026 01:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783033647;
 bh=58UKbQwP+i7BEFSobRRIXrRWh7EQ7W56xH1lY9wlFgQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ocNOEdCl+i/FglnP9yaMEo763nTzmMVDKBbFaX/biyN1+Xy2vEUanxvbVX3yRVIRr
 FRKSKdiUn3OHA2XxRje4uqQc9ObggizFyFxmU6j/MgwD14nmA4p64fGOM5Ag0ftvel
 6Ly7v91nJ15/GTCfi47/dU488dpysMsiUrjsTTYEZzzvlwlbhOEhs4tO0SwDWKlP1i
 vyf8yPLmSfo1DpqOjqk+rAxMvH1FOoarRK09zUn0s7KHvOPu353Gf5arkcQldVVGwL
 /tIramoF0Rc1lLfpwDsaPsXpIGsIRYJ/dcwaWSbwvYBA1BKx+bnoN3j4hu3QOFaGa0
 OUHHGTUvzaWmw==
Date: Fri, 3 Jul 2026 01:06:36 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alexey Charkov <alchark@gmail.com>,
 Alice Guo <alice.guo@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Brian Sune <briansune@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Heiko Stuebner <heiko@sntech.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Julien Masson <jmasson@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v1 0/7] pmbus: PMBus 1.x framework, CLI, regulator and
 thermal support
Message-ID: <akbu_JyHalGwmInn@L30177.local>
References: <20260702171618.1773206-1-vjardin@free.fr>
 <20260702172656.GB749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702172656.GB749385@bill-the-cat>
X-Mailman-Approved-At: Fri, 03 Jul 2026 01:12:00 +0200
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

Hi Tom,

> [snip]
> >  .../regulator/lltc,ltc3882.yaml               |  91 ++
> >  .../regulator/mps,mpq8785.yaml                | 105 +++
> >  doc/device-tree-bindings/regulator/pmbus.yaml |  65 ++
> >  .../regulator/renesas,isl68233.yaml           | 105 +++
> 
> We should be using, and referencing, the unmodified versions of these
> files in dts/upstream instead, thanks.

thanks for this feedback, I did miss it.

I sent a v2 using the upstream yaml files.

Best regards,
  Vincent

PS: the v2 was sent thru 2 waves since I had some smtp issues.

