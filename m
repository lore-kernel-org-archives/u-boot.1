Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A22C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E1186672;
	Thu, 24 Aug 2023 18:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E318669B; Thu, 24 Aug 2023 18:10:04 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C479865AF
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 264E020395;
 Thu, 24 Aug 2023 18:09:56 +0200 (CEST)
Date: Thu, 24 Aug 2023 18:09:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "nm@ti.com" <nm@ti.com>, "francesco@dolcini.it" <francesco@dolcini.it>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "afd@ti.com" <afd@ti.com>, "sjg@google.com" <sjg@google.com>,
 "bb@ti.com" <bb@ti.com>,
 "robertcnelson@gmail.com" <robertcnelson@gmail.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "praneeth@ti.com" <praneeth@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH V5 02/17] include: configs: am62x_evm: Drop unused SDRAM
 address
Message-ID: <ZOeA0vxJs4iQXLFL@francesco-nb.int.toradex.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-3-nm@ti.com> <87il94rh6x.fsf@baylibre.com>
 <20230824120509.72xvy5n2hpl5uh4q@landside>
 <715c5ae929964f51a3c3fec91cb8c9cb4f65eaa0.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <715c5ae929964f51a3c3fec91cb8c9cb4f65eaa0.camel@toradex.com>
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

On Thu, Aug 24, 2023 at 01:02:21PM +0000, Marcel Ziswiler wrote:
> On Thu, 2023-08-24 at 07:05 -0500, Nishanth Menon wrote:
> > On 10:13-20230824, Mattijs Korpershoek wrote:
> > > Hi Nishanth,
> > > 
> > > On mer., août 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:
> > > 
> > > > Drop unused macro. This was meant for a second region of DDR which we
> > > > do not need for AM62x evm configurations.
> > > > 
> > > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > > ---
> > > > New patch (part of bootstd transition)
> > > > 
> > > >  include/configs/am62x_evm.h | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > 
> > > What about include/configs/verdin-am62.h ?
> > > 
> > > It seems that that board, which is am62x based, also has the un-needed
> > > include.
> > > 
> > > Since i'm not 100% sure, I have added Marcel (who posted the verdin am62
> > > support) here.
> > 
> > Toradex team, Can you handle that cleanup? I stayed focussed on am62x_evm side
> > of things.
> 
> Yes, of course.

I believe that this is used on verdin-am62, please double check marcel.


