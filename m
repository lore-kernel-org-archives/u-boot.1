Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D368EC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DB080FA1;
	Wed, 30 Jul 2025 14:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753879274;
	bh=HJMCI8zVtN8804uv+GqgNJpWyYTeK2fDTd004Slume8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UT7+CdKK0elUpT7Uu1EnJoW8ksVJUElkW2P1zWlNO0FAMYrqBZryQff5dbt8QLj7l
	 pzNAScqhncqLttgEinb9dRqUXLVDay+ECJt3mDOJQFovABNEyYzWIWtm5YOICrdlte
	 1KdFO3HZaR2so8Ck09Ql3tQUNx9yOllNfmi66uuC7V4gl8hck7So9A8yFJUtI8irri
	 3HI9Q60xliMvd3kQkNpFwK12ioB5y1cuZwlZGKQDHt6fjuu0aD9jVxk88p3QS/XbSZ
	 045zgTWSJYEsAD0kZNqEDbnCiU8jSy+q+um+no9NQEAqfrPdTYr0KmugrsMKVu/UbC
	 15QzsFO4cjdIg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD0A82BA7; Wed, 30 Jul 2025 14:41:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95FD480C93
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AW+LW1np"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 38AE71038C126; 
 Wed, 30 Jul 2025 14:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753879270; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=HJMCI8zVtN8804uv+GqgNJpWyYTeK2fDTd004Slume8=;
 b=AW+LW1np5Lh5Yu+HwwijNrTn+eHb9s1KBB99A21LvS4iQ8O2Cs/JwcEhwq6tD707y27TPm
 eyIVqTUnPv7AlvBGHaw/aiTj1XLmMQXWcVp0j4N8M7AOzd3nLMKolkSkjbaOYOmk8M4sQZ
 1f289fgypjMW0FgLqxSMg91vSmnKnHllSNPHAhnvlqBHUJQBW3l94QzhSyPXJrtfI9OIdH
 Yx8/cny+kNFln7PwAlLZL7/k1KMsxqpzZkIfnRAfqD0AH6OkJCZ5KRosARJ1zZLcrWAbxM
 76GzZVzZxKN+q3Ggbw6GUdpkaMCPSF1G5df/clLVRiF3b7HBbgwD04tcCl6Qqg==
Date: Wed, 30 Jul 2025 14:41:07 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 1/3] Makefile: Add size check for u-boot-with-spl.bin
Message-ID: <aIoS41wCbNrZyLHm@antares>
References: <20250708103959.26129-1-pro@denx.de>
 <20250708103959.26129-2-pro@denx.de>
 <20250728222531.GA1754718@bill-the-cat> <aIi-Rb3C_1i_IQDr@antares>
 <20250729142211.GK1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729142211.GK1807455@bill-the-cat>
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, Jul 29, 2025 at 08:22:11AM -0600, Tom Rini wrote:
> On Tue, Jul 29, 2025 at 02:27:49PM +0200, Philip Oberfichtner wrote:
> > Hi Tom,
> > 
> > On Mon, Jul 28, 2025 at 04:25:31PM -0600, Tom Rini wrote:
> > > On Tue, Jul 08, 2025 at 12:39:57PM +0200, Philip Oberfichtner wrote:
> > > 
> > > > Like other images, u-boot-with-spl.bin may be subject to size
> > > > restrictions. Extend CONFIG_SPL_SIZE_LIMIT to handle this case.
> > > > 
> > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > > ---
> > > > 
> > > > Notes:
> > > >     Changes in v4: none
> > > >     
> > > >     Changes in v3:
> > > >     	Reuse existing SPL_SIZE_LIMIT instead of implementing a new option
> > > >     
> > > >     Changes in v2: none
> > > > 
> > > >  Makefile           | 1 +
> > > >  common/spl/Kconfig | 2 +-
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > This is not quite right enough, sorry. This causes a number of boards
> > > (evb-ast2600 ibm-sbp1 stm32746g-eval_spl stm32f746-disco_spl
> > > stm32f769-disco_spl) which have size checks and are fine to now fail
> > > their size checks, presumably because they're checking the "wrong" file
> > > now or similar.
> > 
> > Thanks for pointing that out. To sum it up: If those boards use
> > SPL_SIZE_LIMIT to restrict the size of an SPL-only image, then
> > u-boot-with-spl.bin, of course, can be too large and the build fails.
> > 
> > Plus in our previous discussion, we figured out why using
> > BOARD_SIZE_LIMIT also isn't suitable:
> > https://lore.kernel.org/u-boot/aD2EflR9DRYG-MY5@antares/
> > 
> > So from here I really don't see any better way than introducing yet
> > another CONFIG_*SIZE_LIMIT option.
> > 
> > 
> > But maybe we can however simplify and deduplicate some of the code. What
> > do you think about something like that (I have not yet tested it, just
> > a rough idea so far):
> 
> That sounds like a good idea, so long as it works :) Thanks!
> 

So I've tested it for multiple board/image combinations. Should be fine
now. v5 is on the way.

Best regards,
Philip


> -- 
> Tom



-- 
=====================================================================
DENX Software Engineering GmbH,
Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
=====================================================================
