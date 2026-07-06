Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8327C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 10:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435D7846F8;
	Mon,  6 Jul 2026 12:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="G8tjl2gg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AD68488D; Mon,  6 Jul 2026 12:28:09 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C5D84105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 12:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 9D85D78034E;
 Mon,  6 Jul 2026 12:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783333686;
 bh=1ZIO69DNuKG5Nj7SaOcxae+pS1m9hBcPB1wrP1gzPL4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G8tjl2ggXrYk/V/UZpbRrWm+L6MYbFKP3QpXPs+a5fOp4rWssl3OXdrZKU9Iu6r+r
 c92+i4V8oYzyM4aInepmBN1dEtjMimqAevpKX8tIBDzfBcnETmtBdYdXuo6sD/RMJz
 EbjSOmlmBCL6daZx2v3G4sQvJbb4VtnCoxe9Iko8XPTHp0KLCbS9CBntqhRfjNk86z
 ci6rpnU4N65OmSPmZjwx45QCEwvgM1NLezeJXO7499ccqpB6eMbRJwa4zeVhvI5L/d
 UypZuL2ReMT6/FGuNlhuxEJY7vlgiIgH9hPKpHzMW3pLbXMOomXY+yM+wVCjTEFl1N
 ElVcVHr4TL93Q==
Date: Mon, 6 Jul 2026 12:27:34 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Alexey Charkov <alchark@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heiko Schocher <hs@nabladev.com>, Heiko Stuebner <heiko@sntech.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/7] pmbus: add PMBus 1.x framework, CLI, and binding
Message-ID: <akuDFra441oqsoQM@L30177.local>
References: <20260702171618.1773206-1-vjardin@free.fr>
 <20260702195619.1857591-1-vjardin@free.fr>
 <20260702195619.1857591-2-vjardin@free.fr>
 <aksi3r4myOt-Meqh@nxa18884-linux-1.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aksi3r4myOt-Meqh@nxa18884-linux-1.ap.freescale.net>
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

Hi Peng,

Below some feedbacks on you reviews. More will be provided into
a v3.

> >+			if (pmbus_read_string(chip, reg, s, sizeof(s),
> >+					      act->info ? false : false) >= 0)
> 
> Should be true : false or false: true?

hmm ;) it is a leftover, I'll clean it.

> >+	ret = dm_i2c_read(dev, cmd, raw, len + 1);
> 
> When len is 16, len + 1 bytes are read, so corrupt u8 raw[].

right, I'll improve it for v3, thanks for detecting it.

best regards,
  Vincent
