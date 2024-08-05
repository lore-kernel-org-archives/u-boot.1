Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4E2C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 05:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D9A87DDF;
	Mon,  5 Aug 2024 07:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="OEhPRYtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5270988806; Mon,  5 Aug 2024 07:33:47 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BEBD879C1
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 07:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A5A2B1FBFF;
 Mon,  5 Aug 2024 07:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1722836025;
 bh=wkiPBC6yczbmU+XjDuH4sfSYP7eB6PP0ODQ5R5Ps+p8=; h=From:To:Subject;
 b=OEhPRYtOeeDrL0tUtAES4ofAWKXHqd8I1bOB1365lt6DzOcqSJO9o4B0ViYT+mw2P
 c4dpAHn7ABYiszvoD46H3Vp72ldVzgFbLjYQVawBV8QXvsyHUKcecZpNiPukVaeg/W
 ZN2k6kOYP1GQoVdFlGiez7Ut5lqNO3Z+Yf1wBPLn2adxRxZsPGm6NWwtrtBusIcGVz
 S50pgyRsR+RmVVHwzq8nhuLPVb/8Zt3U+740vfLHtrpRI4qOuK+a32LErriEnuMpDy
 0A4cRxsjzFvzMX9HrXgn6QCHXWs/Jy1K/MUJtH79XqfccqCXm8raBG5qLPA8eNaEtr
 nHLX/6NN+rK8Q==
Date: Mon, 5 Aug 2024 07:33:43 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] board: tegra: convert boards to text env
Message-ID: <20240805053343.GB7516@francesco-nb>
References: <20240801055738.7601-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801055738.7601-1-clamor95@gmail.com>
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

Hello Tom,

On Thu, Aug 01, 2024 at 08:57:37AM +0300, Svyatoslav Ryhel wrote:
> Move env stuff into dedicated files in boards (1st stage).

Is there any plan or expectation to move existing boards to text env file?
And what about newly added boards?

Francesco

