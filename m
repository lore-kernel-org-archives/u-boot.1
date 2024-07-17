Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B8AC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 07:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D04D088599;
	Wed, 17 Jul 2024 09:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="x99YyfVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9A28859C; Wed, 17 Jul 2024 09:33:50 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBE08851E
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 09:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 6029B1F9B1;
 Wed, 17 Jul 2024 09:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1721201627;
 bh=4EcPKTBnydwAIYpbDOhSeoxzoZ7R1f5LuZEyJhbE97M=; h=From:To:Subject;
 b=x99YyfVfPy1STesrIDWn5Yj6myGlBdI3LY/W32Mf9hy7kqnnruN9CMoytETyisWYR
 IqfPkTRXs9A2ZDfcvpMI7xVfWz/pAM4l3tXb/Mt8dinpiDbbEzbOkJ4xMdtq6ivoEI
 G46wCx8FKNpLTJjzRvkq87FHLsIM95Nx7wZvvrHiySjUE3svvlX0fqKsY1lLPvstsL
 b5mMzs9/zYkki0xMct5/6/mrEibDZQHld+3yNtl17TrML7dwosp/cKYLdqNCY599gu
 XFYP7SZVMWV606mvMBbiWNIUHAwOBM3SeC51kBfa9WGe+5lUSajgHT6YEZu9QY65FT
 1pbNxZPXm6Fiw==
Date: Wed, 17 Jul 2024 09:33:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, trini@konsulko.com, nm@ti.com,
 u-boot@lists.denx.de, j-humphreys@ti.com,
 marcel.ziswiler@toradex.com, vigneshr@ti.com, b-padhi@ti.com
Subject: Re: [PATCH] configs: j784s4_evm : Increase Dynamic memory allocation
 size
Message-ID: <20240717073342.GA3312@francesco-nb>
References: <20240715174301.2688466-1-u-kumar1@ti.com>
 <20240716200555.GC85916@francesco-nb>
 <ddef3081-76a2-4985-bc47-9a18bcd7ed93@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddef3081-76a2-4985-bc47-9a18bcd7ed93@ti.com>
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

Hello,

On Wed, Jul 17, 2024 at 09:40:11AM +0530, Kumar, Udit wrote:
> On 7/17/2024 1:35 AM, Francesco Dolcini wrote:
> > On Mon, Jul 15, 2024 at 11:13:01PM +0530, Udit Kumar wrote:
> > > Increase malloc size to 32 MB to align with other J7
> > > family devices.
> > Is this needed for any specific reason? I am asking to understand if
> > other boards using the same SOC should be updated to prevent
> > $random_issue.
> Since DFU is not supported yet in mainline u-boot, so I avoided to mention
> that failure.
> 
> Also this change is generic, so i thought of pushing it now instead of
> waiting for DFU series.

Thanks for the update, on our board DFU works fine on our j784s4 based
board (UUU or UMS are not working, but this is off topic for this
conversation ;-)

Francesco

