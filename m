Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511B9C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 08:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F65281EC0;
	Mon, 24 Mar 2025 09:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="kc5x+L+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1040181ECD; Mon, 24 Mar 2025 09:03:24 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B44ED81EA2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A0DB11F992;
 Mon, 24 Mar 2025 09:03:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1742803400;
 bh=HA36M1fdZ7AuTl34tvcQlIg9GF0sNfxpqatwtfrKEWQ=; h=From:To:Subject;
 b=kc5x+L+oYI7BR8fQMTSon8nTFRe0MvDOVCV/YnORDoDtYQGpFlehZX0R1mVlARXv9
 SFk3lVnr8ZoPdcIyTSlpOCtol+QXb2m4joP3tSuwXnTnLW9ArJXOu2l4Cq7aSe8Jpk
 kWxYiqh1n8tM0sZpH0vJbjBPm/Z/HTvO4+cVnsYbAnmCID9T42dxEg659sV5vSiMze
 QeJIuiD3tibcAkYkRZRqomxdOX4SSk85P9/qPfosx/qmmaktU602Mr0WAiLVQPazzZ
 ctNieatCfOpdbdNnB31YtTRQulvEFhuz40/1tglPnFXWDVZtsI8tkV87lCc9ImqD6a
 IUUIR9Rpq3qTA==
Date: Mon, 24 Mar 2025 09:03:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
Message-ID: <20250324080315.GA6932@francesco-nb>
References: <20250319220805.219001-1-marex@denx.de>
 <87a59gdofd.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a59gdofd.fsf@baylibre.com>
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

Hello Mattijs, Marek

On Thu, Mar 20, 2025 at 10:47:02AM +0100, Mattijs Korpershoek wrote:
> On mer., mars 19, 2025 at 23:07, Marek Vasut <marex@denx.de> wrote:
> 
> > The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
> > it crashes. This is a result of the previous hard-coded EP setup in
> > drivers/usb/gadget/epautoconf.c which did special-case EP allocation
> > for SPL builds, and which was since converted to this callback, but
> > without the special-case EP allocation in SPL part.
> >
> > This reinstates the SPL part in an isolated manner, only for NXP iMX
> > SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.

UUU can (and in our case is) used also on non-NXP i.MX platforms.
What should we do?

Francesco

