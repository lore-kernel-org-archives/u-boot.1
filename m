Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6CAD3517B
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 12:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E13E840D8;
	Wed,  1 Apr 2026 14:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="jVf3Ic+l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+e/FA5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8676384010; Wed,  1 Apr 2026 12:46:35 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF4583CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 12:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
Date: Wed, 1 Apr 2026 12:46:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1775040393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFRSzaE1PZJeG3c9uuuRRgsNLvytHLvSQsdH+8Mb5QA=;
 b=jVf3Ic+lEm5dgz52B+/C8MVbmw9ywTDEUOON5phZW9l2ox2CB8k83/fQno3V48qjv2SUTV
 AWLsjHwPXjUoaPs4oQIVj4cEFOkKDmudi625wfQPvA/sOXqO5MalKoVNKHoMZWGaRltxbU
 LcLTH2xK0ysJbqu7C3JmhdAOyjd5UNWBAklR3cFN5yWH7AN9lh70ejicupbx+e2jD5HLJf
 TBm2GhuB007JkvCYFpe19YsW+lC6q3mjk7MW7ZhPh7ZHkuJgB74vLd3Rk7GpWtU9ZeffA9
 fan0/Vf700u9vp6D+V7jwf7lpVRgxCtnUI+zjlNiXyVMD5EG8kR4JbfbxMvmUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1775040393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFRSzaE1PZJeG3c9uuuRRgsNLvytHLvSQsdH+8Mb5QA=;
 b=T+e/FA5eVTmwzhMxmKHuXKtBkQCmS4bdLuk66Bj8ZNk1wW0Ye1Mq8dG/4GN4im1Pr5n36t
 LKD3XjiQuPBCK9Bw==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] cli: flush stdin before enabling cli
Message-ID: <acz3iNHpmDrcv2gT@gregor-framework>
References: <20260331110413.1040527-1-gregor.herburger@linutronix.de>
 <d65423f2-9dae-4bf6-a1d4-fcaed430ac7d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d65423f2-9dae-4bf6-a1d4-fcaed430ac7d@cherry.de>
X-Mailman-Approved-At: Wed, 01 Apr 2026 14:56:19 +0200
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

> > Currently there is no possibility to flush stdin after autocommands are
> > executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
> > serial, it could happen that junk characters sit in the fifo and appear
> > on the cli.
> > 
> > Add a option to clear stdin before starting the CLI.
> > 
> 
> Why does this need an option? I don't know enough (anything really) about
> the cli in general but the wording seems to indicate this fixes an issue or
> even a bug. Is there a case in which we wouldn't want to flush?

In our case the problem was in efi_console where query_console_serial
sent the escape sequence to stdout and stdin was set to nulldev and
therefore never received. In the bootcmd stdin was set to serial and the
response was seen on the cli. Thats how it was in our case. My first
approach was to check in efi_console to not send if stdin is nulldev.
But after more thoughts I implemented the current approach which flushes
stdin before starting cli. After all efi_console did exactly what was
configured in the environment.

I can think of two cases where stdin shouldn't be flushed:
* User typing commands before cli is reached.
* Some scripts sending commands before cli prompt is reached.

Imho there should be at least an option to let users decide on there
usecase. If the option is default or not I don't have a strong opinion on.

Gregor
