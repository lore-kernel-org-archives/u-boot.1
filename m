Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F754C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 06:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCBFD885EE;
	Mon, 15 Jul 2024 08:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721026671;
	bh=Oi7fHFwLlJ1juiF/1fPLWD7YSDLMuOC3btku/AvA+mY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SxyHbuUhtS3AvcdQKF0v7nCYv0iqaPLY7ZaH0lf5WBfeutHbhZWnpm1wlWvqeUlQD
	 OPdO+EaJz99CBniDKDgRqElPjGYfpNWp3Zdbi2Gu6i+x6ger5c2QsbKEB7dtYfEQpL
	 4qBSxxk+iM7/Ggzr4Pu7QN34EZwyMp7GFXFMJF21R7QyBG9uzambw6THeAJXUqIA3A
	 yQeO+CBqzHHm6lDfNRaUvcpI44fDWzYo4i+QN4iIt//K1LXYz8KZ05MBlUdNLuzuWg
	 ZIs4egqbJUewMAliUe7A5Kgku8JCvZ6wuSvzz4gq29Xwh6+GnSUVcPtp5RtZUPslMB
	 8XkpsRu/9Hc7w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30AC188614; Mon, 15 Jul 2024 08:57:50 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09357885D7
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 08:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WMtLd4nLNz9sSP;
 Mon, 15 Jul 2024 08:57:45 +0200 (CEST)
Message-ID: <0586321e-b2b0-40f6-87cd-6da74b79fc40@denx.de>
Date: Mon, 15 Jul 2024 08:57:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] a little RPi watchdog cleanup
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

@Tom,

I can't find these patches (and v1) in patchworks. Do you have an
idea, why this is the case?

Thanks,
Stefan

On 7/12/24 11:07, Rasmus Villemoes wrote:
> Two related leftovers I found while looking at remaining
> hw_watchdog/CONFIG_HW_WATCHDOG items.
> 
> v2: Add Stefan's R-bs. Trim commit log in patch 1. No code changes.
> 
> CI: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=8910&view=results
> 
> I'm pretty sure the only failures are the false positive 'cyclic ...' ones.
> 
> Rasmus Villemoes (2):
>    arm: bcm283x: remove unused empty hw_watchdog_disable
>    board: rpi: remove leftover CONFIG_HW_WATCHDOG block
> 
>   arch/arm/mach-bcm283x/reset.c | 7 ++-----
>   board/raspberrypi/rpi/rpi.c   | 4 ----
>   2 files changed, 2 insertions(+), 9 deletions(-)
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
