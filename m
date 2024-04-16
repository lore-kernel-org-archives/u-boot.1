Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7082C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 14:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECF988404;
	Tue, 16 Apr 2024 16:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="EWBdQOro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8971A88408; Tue, 16 Apr 2024 16:51:37 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7E888403
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 16:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0B9C71F90C;
 Tue, 16 Apr 2024 16:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1713279093;
 bh=a5uT8FH4wPpRfcEibMsuRy3s/jynoHPAh+jZm51Vqh0=;
 h=Received:From:To:Subject;
 b=EWBdQOroWfSQeWB6fF1RGsTk8fPfFknmsFz6LgcI0cyuDvdqAskvPKDwSGtDmS2Vj
 khB+JzMhsrrcEViVQjr1yxMtEQscTZCIrkRm7cf3H00SIX6jayCPoOZY/MQ9ARuG8m
 e0k2FVv0+OtNIpAfIjGejhxKnC+yqDAbB3VwYlvedLA7jllLLn1kyVnfJPVKmY576D
 xoTxneDC37TpZIeIn5fA5Ga0zC+6BkEOD5YaZDTx8b74ShzTAukcJpY8rgkl4iinoh
 BWAtQnYwjviNjHyQcmL+N5xlI2fyB230pK1vyAfye0Qy23nqdrMcuCFN6MM1fROWHZ
 puV9dLHO7bZog==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 909027F989; Tue, 16 Apr 2024 16:51:32 +0200 (CEST)
Date: Tue, 16 Apr 2024 16:51:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Lunn <tim@feathertop.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
Message-ID: <Zh6QdKukLuPV2CE2@gaggiata.pivistrello.it>
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
 <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
 <20240416003612.GJ1054907@bill-the-cat>
 <20240416065946.GC4165@francesco-nb>
 <e4705933ee9b8cfd0da415e9e1b66f1c@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4705933ee9b8cfd0da415e9e1b66f1c@manjaro.org>
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

On Tue, Apr 16, 2024 at 03:18:08PM +0200, Dragan Simic wrote:
> On 2024-04-16 08:59, Francesco Dolcini wrote:
> > On Tue, Apr 16, 2024 at 02:36:12AM +0200, Tom Rini wrote:
> > > On Mon, Apr 15, 2024 at 02:22:02PM +0200, Heinrich Schuchardt wrote:
> > > > C is the sign for coulomb which is the unit of electric charge. How
> > > > about 'deg C'?
> > > 
> > > I'll note that in Linux there's seemingly nothing consistent, and I'm
> > > fine with any of "deg C" or "degrees C" or "temperature range (-40 C to
> > > +85 C)" as all of those should be clear in context.
> > 
> > My 2 cents ... while I agree with Tom that the context will make it
> > clear, it is not making it correct nor nice. Using just "C" for Celsius
> > degrees is horrible ...
> 
> FWIW, I usually use "oC", which is far from perfect, but IMHO also
> far from horrible. :)

"oC" is also horrible, "deg C" or "degrees C" that Heinrich proposed are the
way to go if you need something 7-bit ascii :-).


Francesco

