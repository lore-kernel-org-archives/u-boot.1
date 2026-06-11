Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9400FCD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64920846A7;
	Thu, 11 Jun 2026 16:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4321E83FEC; Thu, 11 Jun 2026 16:18:27 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 648128407D
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id 3F9C168C4E; Thu, 11 Jun 2026 16:18:24 +0200 (CEST)
Received: from localhost (dynamic-095-117-075-192.95.117.pool.telefonica.de
 [95.117.75.192])
 by verein.lst.de (Postfix) with ESMTPSA id 303E067328;
 Thu, 11 Jun 2026 16:18:00 +0200 (CEST)
Date: Thu, 11 Jun 2026 16:17:55 +0200
From: Torsten Duwe <duwe@lst.de>
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de, Daniele Briguglio
 <hello@superkali.me>, Lukasz Majewski <lukma@denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, Peter Korsgaard
 <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] clk: enhance clk-gpio to also handle gated-fixed-clock
Message-ID: <20260611161755.447cabc8@lst.de>
In-Reply-To: <20260611140105.GI382693@bill-the-cat>
References: <20260528132206.2fe9f474@lst.de>
 <178118570728.472730.15075222884813417231.b4-ty@konsulko.com>
 <f706f118-b698-4ab4-8b19-9f3de0d10c31@kwiboo.se>
 <20260611140105.GI382693@bill-the-cat>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 11 Jun 2026 08:01:05 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Thu, Jun 11, 2026 at 03:58:04PM +0200, Jonas Karlman wrote:
> > Hi Tom,
> > 
> > On 6/11/2026 3:48 PM, Tom Rini wrote:
> > > On Thu, 28 May 2026 13:22:06 +0200, Torsten Duwe wrote:
> > > 
> > >> Devicetree commit a198185b9b5 introduced a new type of clock,
> > >> "gated-fixed-clock", for which Das U-Boot does not have
> > >> a driver yet. The required code is similar to gpio-gate-clock,
> > >> and can be added using little extra text space.
> > >>
> > >> Use this code e.g. to boot a Rock5 ITX from NVMe
> > >>
> > >> [...]
> > > 
> > > Applied to u-boot/next, thanks!
> > 
> > Any reason this was applied without my review concerns being
> > addressed?
> > 
> > Please revert, or address the issues this patch have :-)
> 
> Yes, I missed them, sorry about that. I'll go push a revert along
> shortly.
> 

IIRC it was not a big thing, I can also follow up with the change
suggested by Jonas, if that's easier for you.

	Torsten
