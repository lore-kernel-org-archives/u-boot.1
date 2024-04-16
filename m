Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7A6C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 07:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89553882E7;
	Tue, 16 Apr 2024 09:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="QPelYHpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF7E882FD; Tue, 16 Apr 2024 09:00:00 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87BB3882CB
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 08:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 230462202D;
 Tue, 16 Apr 2024 08:59:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1713250788;
 bh=IuaBrnJHdm5puud+NZC9EOxoi9e3X6HHpPFwkO+HzFg=; h=From:To:Subject;
 b=QPelYHpJ5Ql7sHpW/oAWUbGmbqmcvBoC+NfGfoTn/eeKc90fXq+ttucQUES771//B
 VxlvJh1lZWaC0gZuqwZzHQRzoShi4Wb+g3Wfvt/N/BEfaM+Togkx5rO+72xIolO5ke
 2/xRdy2777jxN10ne8h8ude5UsQIcPauHeoNSYF9U0VfaAYiU9UPfqo/IY4kVufC4Q
 IUSnAOT5fF8+16T5Wi4zZ54wM9VYbXf//1s1W+4aSVwyWayYpDNG4ntzSy+AUsSZ+3
 lVHwnW3KlVBHpzcazVcVw9epX39ssDZ4BXM2oGw2o6BjNnFQ9gviJi/Ec7O36B8Ht/
 Koszyam3OcJrQ==
Date: Tue, 16 Apr 2024 08:59:46 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
Message-ID: <20240416065946.GC4165@francesco-nb>
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
 <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
 <20240416003612.GJ1054907@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416003612.GJ1054907@bill-the-cat>
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

On Tue, Apr 16, 2024 at 02:36:12AM +0200, Tom Rini wrote:
> On Mon, Apr 15, 2024 at 02:22:02PM +0200, Heinrich Schuchardt wrote:
> > On 15.04.24 13:35, Michal Simek wrote:
> > > Some of Kconfigs are using utf-8 encoding because of used chars. Convert
> > > all of them to ascii enconging.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> [snip]
> > > diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
> > > index ae323ee91235..64a70f61f894 100644
> > > --- a/arch/arm/mach-rockchip/rv1126/Kconfig
> > > +++ b/arch/arm/mach-rockchip/rv1126/Kconfig
> > > @@ -6,8 +6,8 @@ config TARGET_RV1126_NEU2
> > >   	  Neu2:
> > >   	  Neural Compute Module 2(Neu2) is a 96boards SoM-CB compute module
> > >   	  based on Rockchip RV1126 from Edgeble AI.
> > > -	  Neu2 powered with Consumer grade (0 to +80 °C) RV1126 SoC.
> > > -	  Neu2k powered with Industrial grade (-40 °C to +85 °C) RV1126K SoC.
> > > +	  Neu2 powered with Consumer grade (0 to +80 C) RV1126 SoC.
> > > +	  Neu2k powered with Industrial grade (-40 C to +85 C) RV1126K SoC.
> > 
> > C is the sign for coulomb which is the unit of electric charge. How
> > about 'deg C'?
> 
> I'll note that in Linux there's seemingly nothing consistent, and I'm
> fine with any of "deg C" or "degrees C" or "temperature range (-40 C to
> +85 C)" as all of those should be clear in context.

My 2 cents ... while I agree with Tom that the context will make it
clear, it is not making it correct nor nice. Using just "C" for Celsius
degrees is horrible ...

Francesco


