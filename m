Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0658CCDDE66
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 10:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 877C689266;
	Wed, 23 Oct 2024 12:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729680811;
	bh=YAZZ+xZL8E7Ly1NtpMRjsh1PjSsh7KrmrNnjXH7gotE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MOMdDSPFENEvsIfPAeDQEm0dqGchP4gKNyXO/9DLj/Kd0//PGagBx5/osijJcr+eh
	 +7yzl1R7e4d/7uOKBHVA3pqtwLlMdPPi7naVS2elgQ2pBO7aixYopjLI/CNVxW+jVL
	 4zMuHXsO0LXrRN0ZnHXc8zuoDd+1Pr6HnQrZ1DlGJCxQctMA0o7Ht+3y5/JiIpLtWW
	 J2JhImsF+aRaimT6RbBPjXA2cctiQBz2KqbAw3U9qO7jpQOVyjsVa06RXhbKYpR+vF
	 gfQ9hb58ert7V3+fonxIKfkC522JgBpKK2tnl9skWbFEDSvkRs5gAJHEhtuc3AGwcr
	 p8k2nbkwzs9gA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8F589266; Wed, 23 Oct 2024 12:53:30 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94B088A9D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 12:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XYQrG40vSz9smr;
 Wed, 23 Oct 2024 12:53:18 +0200 (CEST)
Message-ID: <90a67c40-29a3-4371-9a55-8daa505f28e1@denx.de>
Date: Wed, 23 Oct 2024 12:53:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/13] disentangling cyclic API from schedule()
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/3/24 23:27, Rasmus Villemoes wrote:
> These patches are part of a longer-term plan to properly deal with the
> HW_WATCHDOG vs WATCHDOG dichotomy, and getting rid of the legacy
> HW_WATCHDOG concept completely. As part of that, clean up which
> headers include other headers.
> 
> While schedule(), the artist formerly known as WATCHDOG_RESET(), is
> obviously called all over the tree, very few TUs make use of the
> cyclic API (cyclic_register etc.). And there's really no reason at all
> for global_data.h to include cyclic.h - except that some places
> implicitly rely on getting their declaration of schedule() through
> that include.
> 
> So this introduces a separate mostly trivial header that just serves
> to declare schedule(). Then we can get rid of things that include
> cyclic.h just to get that declaration.
> 
> A next, mostly mechanical step, could be to change almost all includes
> of watchdog.h (which most TUs that used to have a WATCHDOG_RESET()
> invocation has) to u-boot/schedule.h, because again, most of those TUs
> are not really concerned with implementing init_func_watchdog_init or
> need to call it. But that is for later.
> 
> CI seems happy: https://github.com/u-boot/u-boot/pull/673
> 
> Rasmus Villemoes (13):
>    doc: cyclic: remove reference to WATCHDOG_RESET
>    cyclic: introduce u-boot/schedule.h
>    led: include cyclic.h in led_sw_blink.c
>    m68k: asm/ptrace.h: include linux/types.h
>    fs/cramfs: use schedule instead of cyclic_run as callback
>    test: dm: wdt: replace cyclic_run() by schedule()
>    cyclic: make cyclic_run static
>    watchdog.h: change include of cyclic.h to u-boot/schedule.h
>    lib/sha*: include u-boot/schedule.h instead of cyclic.h
>    i2c: rzg2l: include u-boot/schedule.h
>    ddr: altera: include u-boot/schedule.h
>    boot: cedit: include u-boot/schedule.h
>    global_data.h: remove unnecesary include of cyclic.h
> 
>   arch/m68k/include/asm/ptrace.h    |  2 ++
>   boot/cedit.c                      |  1 +
>   common/cyclic.c                   |  3 ++-
>   doc/develop/cyclic.rst            | 10 +++++-----
>   drivers/ddr/altera/sdram_n5x.c    |  1 +
>   drivers/ddr/altera/sdram_soc64.c  |  1 +
>   drivers/i2c/rz_riic.c             |  1 +
>   drivers/led/led_sw_blink.c        |  1 +
>   fs/cramfs/uncompress.c            |  4 ++--
>   include/asm-generic/global_data.h |  1 -
>   include/cyclic.h                  | 24 +-----------------------
>   include/u-boot/schedule.h         | 24 ++++++++++++++++++++++++
>   include/watchdog.h                |  2 +-
>   lib/sha1.c                        |  2 +-
>   lib/sha256.c                      |  2 +-
>   lib/sha512.c                      |  2 +-
>   test/dm/wdt.c                     | 10 +++++-----
>   17 files changed, 50 insertions(+), 41 deletions(-)
>   create mode 100644 include/u-boot/schedule.h
> 

Applied to u-boot-watchdog/master

Thanks,
Stefan
