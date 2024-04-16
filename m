Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACBBC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 16:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8BEE88422;
	Tue, 16 Apr 2024 18:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="IrIqw25m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D20E88423; Tue, 16 Apr 2024 18:53:18 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8AF8840D
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 18:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713286394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNsvZSyxwe62FLTRnm1H77oExZxmhzA+DQyzdEfk3PE=;
 b=IrIqw25m8mipud/Wvi7o8FxucfRx75upd7zky91/qSLGBpikGFCGz0ruwEg5r2Rjgyu9pW
 oYdqzRRNefxVPEghCOLWe+VZIyGLDyv6Q1FK9gYJVfWfnLeXeLJTELLAdh2Bhm48KBseHs
 Z7v7zdySLDkK2miKhI9/84Pv1yvv6c2pdP7zcuvU4OR/2ozuNgwDbeqNnTrUU98ddLcUjp
 o6oT8lYdTxmM0qaCD+UwBUrKDm9ZuqJkJhGu8eFnBkloUxa+o1uLham9EaYX35Gn9eO5FJ
 Hk/c3qjWqT6j9TsWyV05ed6QeDjrlxrqYoHrk26vWOxJle2fY5jA0QM8CHOKCA==
Date: Tue, 16 Apr 2024 18:53:10 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Andre Przywara
 <andre.przywara@arm.com>, Angelo Dureghello <angelo@kernel-space.org>, Elon
 Zhang <zhangzj@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>, Kever
 Yang <kever.yang@rock-chips.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Lunn <tim@feathertop.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Vignesh R
 <vigneshr@ti.com>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
In-Reply-To: <Zh6QdKukLuPV2CE2@gaggiata.pivistrello.it>
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
 <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
 <20240416003612.GJ1054907@bill-the-cat> <20240416065946.GC4165@francesco-nb>
 <e4705933ee9b8cfd0da415e9e1b66f1c@manjaro.org>
 <Zh6QdKukLuPV2CE2@gaggiata.pivistrello.it>
Message-ID: <6a60f436d48bfce8ede3635ba0632bd3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-04-16 16:51, Francesco Dolcini wrote:
> On Tue, Apr 16, 2024 at 03:18:08PM +0200, Dragan Simic wrote:
>> On 2024-04-16 08:59, Francesco Dolcini wrote:
>> > On Tue, Apr 16, 2024 at 02:36:12AM +0200, Tom Rini wrote:
>> > > On Mon, Apr 15, 2024 at 02:22:02PM +0200, Heinrich Schuchardt wrote:
>> > > > C is the sign for coulomb which is the unit of electric charge. How
>> > > > about 'deg C'?
>> > >
>> > > I'll note that in Linux there's seemingly nothing consistent, and I'm
>> > > fine with any of "deg C" or "degrees C" or "temperature range (-40 C to
>> > > +85 C)" as all of those should be clear in context.
>> >
>> > My 2 cents ... while I agree with Tom that the context will make it
>> > clear, it is not making it correct nor nice. Using just "C" for Celsius
>> > degrees is horrible ...
>> 
>> FWIW, I usually use "oC", which is far from perfect, but IMHO also
>> far from horrible. :)
> 
> "oC" is also horrible, "deg C" or "degrees C" that Heinrich proposed 
> are the
> way to go if you need something 7-bit ascii :-).

I agree, "deg C" or "degrees C" is the way to go, and my vote goes to
"degrees C".  Just to clarify, I use "oC" as some kind of a shorthand
when having less to type outweighs the correctness. :)
