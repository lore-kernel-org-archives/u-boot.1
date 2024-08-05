Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461EDC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 06:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA18D87DEA;
	Mon,  5 Aug 2024 08:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="kjxo5VES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE4287E96; Mon,  5 Aug 2024 08:13:07 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E0DE87B30
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 08:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3A4E21FBFF;
 Mon,  5 Aug 2024 08:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1722838384;
 bh=g3yPA0RwKt89RjwuQpKU+fA+fMmTDGbRf72O2V3xVQ0=; h=From:To:Subject;
 b=kjxo5VES+BJ6ZzvwSUegVp9nKFpDq4C32/ZV4wUJmxNRPlRYP5DAyA5da6XrHBKGm
 W+FV4kf34MFpoZvikqbQMUanRRlgDR1Xx5mPql0+iYqbdH2EFupLHLfUj8qCa1sVYw
 U3SQ4wEuZ48S6gXdWMB8EMgn2GaMOcphh42gImxttnVopzMVc2luFSKzGjebhqNCFv
 q74LrZjcdbmdUN1tQ7Dz9h+jWUzePCRG8NjAlAGORApvhCTHin32oG5Y8sLbt1NkPP
 A30M+YuDh5FAJhN5zzAqEBXh5JanE5pSvp8JDUKzJNmeeRoSi3Dp0N+lu4MbututtC
 AgIApTQ4bmyUQ==
Date: Mon, 5 Aug 2024 08:12:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] board: tegra: convert boards to text env
Message-ID: <20240805061259.GA12978@francesco-nb>
References: <20240801055738.7601-1-clamor95@gmail.com>
 <20240805053343.GB7516@francesco-nb>
 <CAPVz0n0vn7yTiEBdwJUmGogH8AZUL+YgmNobBzGzgcomiRP_sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0vn7yTiEBdwJUmGogH8AZUL+YgmNobBzGzgcomiRP_sg@mail.gmail.com>
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

Hello Svyatoslav,

On Mon, Aug 05, 2024 at 09:03:01AM +0300, Svyatoslav Ryhel wrote:
> пн, 5 серп. 2024 р. о 08:33 Francesco Dolcini <francesco@dolcini.it> пише:
> > On Thu, Aug 01, 2024 at 08:57:37AM +0300, Svyatoslav Ryhel wrote:
> > > Move env stuff into dedicated files in boards (1st stage).
> >
> > Is there any plan or expectation to move existing boards to text env file?
> > And what about newly added boards?
> 
> If Toradex developers want to deal with this on their own, I have no
> objections and I will load v2 without Toradex boards.

I am fine with you doing the change, I asked this to Tom to know
what's the plan, not to push back on your change :-)

Francesco

