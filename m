Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05F0C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 19:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E45781F6B;
	Fri,  4 Jul 2025 21:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="xQp5cilg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70A678206E; Fri,  4 Jul 2025 21:26:34 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2E1803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 21:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 098F71FB2D;
 Fri,  4 Jul 2025 21:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1751657191;
 bh=FxuqIIWxBNBDT1WtfbdzDq7SJEi+WeA6u6u/jI++hyU=; h=From:To:Subject;
 b=xQp5cilg7uT27bJaEceBUnIsa1WIEna/WYdyJSexB+5wGaGlX1qosHUtpSrJEvf+y
 1oytcHEuKyY8kF0JFHIslERThJAdXItlPoZiWcuoPSs5bMtBP59J3X5DM0u7NPb3qU
 QQyph3gGQpXoZd6PX/Ryc+yrPRdW8BbeuCZsIySnlnhcfV+Vd+wmTNA8fUbbr9G1S6
 b/M+CnR6oUSXIYG5fBWXeClbYKGpH5sxty6Ckee3P7M/O267aMlsCY6P/rMn1r6UoO
 hXOgeDiyl+KIrA1WUNTyH7rE+fGaC4cyb65VozUDomPWNxSRedVRyoMQBPsTCbaXbs
 0VnJCEF/rJM0g==
Date: Fri, 4 Jul 2025 21:26:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] board: ti: rm-cfg: Update rm-cfg to reflect new resource
 reservation
Message-ID: <20250704192626.GA17727@francesco-nb>
References: <20240220203944.27916-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220203944.27916-1-vishalm@ti.com>
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

Hello Vishal,

On Tue, Feb 20, 2024 at 02:39:44PM -0600, Vishal Mahaveer wrote:
> With the latest TIFS firmware, an additional virtual interrupt and
> event is reserved for TIFS usage on am62x and am62ax devices.
> 
> Update the rm-cfg to reflect this new reservation.
> 
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>

I just noticed this old patch from 2024, and I have a few
questions and one request.

 1. I assume this patch applies to all am62x based board, not just the
    two from TI you did the change for, correct?
 2. Which kind of issue can I expect if I have not updated this file on
    my board?
 3. Which is the version of firmware that requires such a change (you
    mention just "latest")

 ... and one request

 Can you please update all the relevant boards when doing such kind of
 change next time?

Thanks
Francesco


