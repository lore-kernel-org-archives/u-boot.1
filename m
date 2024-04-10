Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3180CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 09:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277EC881A6;
	Wed, 10 Apr 2024 11:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Bw4VAP7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE106881A7; Wed, 10 Apr 2024 11:22:19 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67A287666
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 11:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712740937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7zzWnVGf85ncLndrAy6+m5R40QyEacaA2q2t/Rrw7o=;
 b=Bw4VAP7ou1pfNo9xtjx/lvtne2B2CksWHHAF9GnslYcyrhFarIBlLvZz8tKknbgtcNdlqt
 HYFsAFWVEEuiph9nXVsLbGEeVXSVb3ot8KdsMAQGJZ1/rkIykF1b9raNbiTAs6TyqqRePV
 8/D0gqXTxzt/LxZHa9LO+dJ2RUJAA0wt0tKUBTwF0FQzyjDEblN0bITtX3oXhW4ipYohLd
 f3mSsySTEbUtpLzeRUVjFYIpmajjJjHKHuQTBQkflmJVJwoCyZGobpWbaFbEuEYdFwIafj
 84LcCe5DfxxpfpBCMum6bq1QGsXOsrwHU/M977LsvQYqbxdGulAY8x5QL1tj0g==
Date: Wed, 10 Apr 2024 11:22:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
In-Reply-To: <8fec34b8-8d04-40ba-baca-5394762a4d27@theobroma-systems.com>
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
 <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
 <9b62bbedf2c6d52b76a8ce1ce57dd35d@manjaro.org>
 <8fec34b8-8d04-40ba-baca-5394762a4d27@theobroma-systems.com>
Message-ID: <b847b86547419cb9d04afa7bf982b272@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Quentin,

On 2024-04-10 10:56, Quentin Schulz wrote:
> On 4/9/24 21:28, Dragan Simic wrote:
> 
>> Let's keep in mind that the troublesome DT properties describe the
>> capabilities of the MMC controller and the board, not the capabilities
>> of the MMC storage device.  As we know, eMMC devices provide automatic
>> detection capabilities, to allow the host to determine its supported
>> modes, and match them with the ones the host is configured to support.
>> It's all described in the JEDEC standards.
> 
> So why do we have those properties specified in board DTSes instead of
> in the SoC DTSI? Logic would want us to have this defined in one place
> only. I assume the issue is that even if the eMMC chip itself says it
> supports HS400 but the HW routing or some other issue make it
> impossible to use, we need a way to disable it from the DT for that
> board?

Yes, we're having that defined in board DTs because some boards
aren't made well enough to provide the required signal integrity
for HS400, for example, so only HS200 may work well, despite the
fact that the SoC the board is based on supports HS400.

Some boards, such as the Pine64 RockPro64, are miswired so the
Data Strobe signal doesn't even reach the eMMC chip, rendering
HS400 impossible.  Other boards, such as the one found inside
the Pine64 PinePhone, provide wrong voltage to the eMMC, so only
DDR52 can work with no hardware modifications.

>> Having that in mind, I find the approach in the Linux kernel rather
>> reasonable, because I highly doubt that some MMC controllers support,
>> for example, HS400 without supporting DDR52, or HS400 without 
>> supporting
>> DDR52.  A reasonable approach for an MMC IP block is to make it 
>> capable
>> of supporting all the speeds below its highest supported speed, to 
>> make
>> itself capable of supporting more, if not all, MMC storage devices.
> 
> That's true for the IP block which is self-contained in the SoC, but
> it's forgetting about the other part, the eMMC chip/card. It depends
> on the HW routing, where mistakes/limitations can happen. And I don't
> think we have a mechanism today to disable the modes set in the MMC
> controller for a given MMC card from DT (aside from /delete-property/
> in board files).

Sure, but the same "lower speeds work" rule still applies, because
if a board limits the speed to HS200, due to signal integrity issues,
DDR52 is virtually guaranteed to work as well.  If some particular
eMMC chip supports that speed, of course.

Though, there are bugs in the Linux kernel when it comes to limiting
the board to DDR52, for example, using the DT properties.  I've already
spent some time fixing those issues, and I hope I'll have the patches
submitted to the mailing list rather soon.

>> In fact, I'll probably go ahead and submit a Linux kernel patch that
>> updates the descriptions in the binding, to hopefully eliminate any
>> ambiguities like these.  I hope you agree.
> 
> I for sure do not have enough knowledge in MMC to argue more than I
> just did, so having people with more experience/knowledge have a look
> at this would make sense, let's see what they have to say :)

Sure, having more opinions is always good.
