Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF31FCA9EC3
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6FC660A3D;
	Sat, 10 Oct 2026 13:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uSXBTzcfxIAl; Sat, 10 Oct 2026 13:14:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97F7860A45
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638095;
	b=reFiPv+onNBQCobrl97orz4HKdy6XShJA9ipT5iQzxpTMsDJHtrDfvDM9xrEYGW28+oe
	 zO8t8oa5avEpNe7rOYDHahg/3d3y/cwW33IrOQIKwLi/1VSvjkOqBPpFsLfU0jQOq+Ybi
	 kB4QJU4TrDBAO4Lh4kqNrWpHwht3Px5LUIbjDM2Lq31ZRYFQ8UkTeK2XCMPbw+XGGaCCF
	 0CjC9/VEHnej8TLx3eAZP9/+eAYbU5svxlABO7qTB6qYQ0YF0fvOnGLiA6M3o2Z7iFkip
	 Ws14lZcji97zOl4O4eHdM96MXI57GF4MHmrNkoFXjRbVgzltvokRKJJXx2/LhWsLwLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BHZLZA0ELqGtcFsLFhhFiBqfM1nH/kyq/71Vt50G8f8=;
	b=ml6qw8wARy6csSbXMsboVFep7Ak04Y8HYzzhrrp3ZStkP7YQmT287wlsxpC4vZ88roeg
	 D0Y5Y6SAFXnXB2VzpWp4CDiSSpZCjpEwFn1AN2KEmIJhMmLgcYB0EfQ1HsI+eCmYcMyS4
	 N6RCouPBqRPqhN6x+525DplzSYSyvg/F01o6RNjcCsS6qrqC0h1z8aXhQs7JaRNpYGNOo
	 5CzbP0c6kdSb6LOdOs0dH8p+CpBgh5Cgz6I1XO6ZL5diSkzehtaRmHJrOkgOeuTvjJUFr
	 VugfnrdwY6Exh6fNneLjZdUvpAIp3EuEUYmcRJe6zUwLRGZtczOpJYsD5ZdH3xWiVWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=AGvGmXbs;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Bp43Vl1m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638095;
	bh=BHZLZA0ELqGtcFsLFhhFiBqfM1nH/kyq/71Vt50G8f8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yybyt1TnjuF0MUSVnbTQoYGiydBXhr+3W5iG0kCIavfU3qtIqa57EJilr4YDKQ1yB
	 M0YcVCpIGUl0r6O97X5qYoiTJy+wBsrEV2VRNczWLQ8sCwRjzBjECY1WPlX8vC/hrX
	 20z8xyv5+DQgalpbm6W1cwVUzCPokzMGvJTRniTQnb9kyfF2c82MvOEJT0ivWalvdn
	 W0kElC1rmYhdmITcfTxidEWcEenSBRyZtwDNtAXiYVtMz0jgflHByE27ovinxi3Ioc
	 IryZm5psrAJ6MxNK9/j39AuWd8eEvSAseSxN2grWD6ifhBmnATFb6TvUwh0tL3ZgCq
	 8BGap2X1kIe8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97F7860A45;
	Sat, 10 Oct 2026 13:14:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37D8C2E0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 11:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D24860672
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 11:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cf2jCeF8NXT7 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 11:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCEB460670
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791630013;
 b=EE+roM4DbYV5F2KNBYcPFLzHeufhYaZ2dCnncJrTYyiNrLCWX0meShMopMkO5PQtKDIm
 nlfUjWQiiGd7AN2NjPXAgVeR80FgO2iHwZlYCVO3fBSXW8L5tEdRQso8YVSUe/Znx+Vkw
 TAK3yz+//X1P7n7T+MeRWZz9NLRGY3OjGNBKsLL5yqABgEDzuyazLGMuZ7dEzV1ceqD2K
 cNiBiPI2w9+yGzHRiGCK51MxduUHVeED7ZkUkYVbYNgZjGUP2TeSNg46nrxgd+Y4UJ/c4
 JU757stZ8DircLKXBT0Mm2rPmO4jtBPgd6RyrQHhsZpo7izEm8Py3EmlzXPIiYh8RRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791630013;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=BHZLZA0ELqGtcFsLFhhFiBqfM1nH/kyq/71Vt50G8f8=;
 b=hfbzbpUqspmY1QuZr5okREIfFIbRXIfBWZGrNr0F/65gH653/68vgLAOxjxR00HUQ2Kg
 2FCtC4yy+lzR91U24YM+/GsFIPN5HcIg7tort6H2QG9oYK2Qa1PJJdE60jvGzbU72EejM
 5rIJ6YY0MB4dGDxKsR7KJ1Lb3XzBFUW8R24OBwjqjUI1EewTA6RZSJPct0fjGIe26Fc4G
 NH/i+TIlYH2g1NrUVmCl60l9eZYO4f2aP089Zj21t3PZ92ejKhxZ5+HShHKe4y6UUAB75
 UkFWTYbpqOj5jsXtwR8uNcgQBISzcsPg4k3uBiX8gD5jVoEMn6Re0H9CZ9MGqBj4Cnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=AGvGmXbs; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Bp43Vl1m; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=AGvGmXbs; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Bp43Vl1m
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCEB460670
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1791629938; bh=BHZLZA0ELqGtcFsLFhhFiBq
 fM1nH/kyq/71Vt50G8f8=; b=AGvGmXbsXEwbYyEbcBsxpvgHeFIPABIUscZNxJE76zC53pg5M6
 xEwdlcKaeFSVybGmdLar81IvEyUzlOl1c8WgTSPX7aWrbA8rWXHrC0rqxkDKytxqHFE6INWuWzb
 VCbt1yfCvWt8MXodzJplsco4T60Co//Qcyq209CXDPejIBE1ODk0PHwxTpi13Xd6YNTspdbL7y0
 /JcOgA5CBxN3tOaXM8a3XRksEFPW7mXEn34iBmAgWOmh+U/u9MeEO4eS/KuC/h7NI+I38LSAwXJ
 y4dpHdNaBm/lOGThKsJdVO3gsqc749/tiggMCOfPe4MqA9Jlvl7jCc5IdtYxY9ketvQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1791629938; bh=BHZLZA0ELqGtcFsLFhhFiBq
 fM1nH/kyq/71Vt50G8f8=; b=Bp43Vl1mnWwmsoajbBP9vcyAf0nvwOeX2aODazReZz9srCwjOx
 xmlL6SgokTkZK6yQx5V+KVl1xspPrRhhbiDQ==;
Date: Sat, 10 Oct 2026 11:58:59 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.u-boot-project.org,
 =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 =?ISO-8859-1?Q?Marek_Moj=EDk?= <marek.mojik@nic.cz>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Pengpeng Hou <hppiscas@163.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>, Vincent Jardin <vjardin@free.fr>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH 01/26] board: powerpc: Remove MPC8548CDS support
In-Reply-To: <20261010125149.5b2ec50b@wsk>
References: <20261009193704.13061-1-brads@mainlining.org>
 <20261009193704.13061-2-brads@mainlining.org>
 <20261009215538.GG769217@bill-the-cat> <20261010125149.5b2ec50b@wsk>
Message-ID: <BE25EA10-9C90-42CA-9305-52B37782A0B1@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10 October 2026 11:51:49 BST, "Łukasz Majewski" <lukma@nabladev.com>
wrote:
>Hi Tom, Bradley,
>
>> On Fri, Oct 09, 2026 at 07:36:39PM +0000, Bradley Morgan wrote:
>> 
>> > MPC8548 silicon is no longer manufactured, and the MPC8548CDS board
>> > is obsolete. Remove the board and its SoC support.
>> > 
>> > Signed-off-by: Bradley Morgan <brads@mainlining.org>  
>> 
>> So, globally. As has been discussed on IRC already, please take a more
>> neutral removal message in v2. The problem isn't that the boards
>> aren't manufactured, it's that (likely) they aren't being actively
>> tested and maintained in the community. We're fine with "obsolete"
>> hardware if someone is maintaining it. Also, please rework the CC
>> list (outside the cover letter) to include the listed board
>> maintainers, and then only people that have touched the relevant code
>> recently, perhaps with a manual audit or exclude some global or
>> common files, when looking for who else to CC. Thanks.
>> 
>
>Maybe I would add my 2 cents...
>
>There are a lot of MPC85xx systems out there - and probably (my guess)
>is that at some point some customers would be "forced" to refurbish
>them.
>
>Some companies need very long time to realize that their crucial legacy
>products may be removed from u-boot. I would opt for longer and more
>"broadcast" obsolence process.
>
>
>I had similar situation in the past when some Samsung SoCs were removed
>from u-boot - nobody was willing to pay for re-adding them upstrem -
>this means that they were kept out of tree.

This opinion was basically said in IRC, that devices that weren't on Linux
AND eol should go.

The V2 series is submitted, with a pick structure, so every "EOL" board
gets deleted. You wouldn't have to merge them all.



>
>
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
