Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB61CC6B20
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 08:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C8C6839DF;
	Thu,  2 Apr 2026 10:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="whFo1J1Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXSvuZdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1C083CF5; Thu,  2 Apr 2026 10:06:14 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10CC80212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 10:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
Date: Thu, 2 Apr 2026 10:06:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1775117171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2i453U9FtFdArbGUNQFDw+ljY707QrCo8bvJkIZzqEs=;
 b=whFo1J1Yr916dZ1OVE49TTuh/WUR2fpsNPr+lvFwVRmrAxNrXPmID03Jyw883ABi7SSUB8
 mylmtcjC64MWYP6zZqsMP/7U6L7VqWZHsQZUeOU2gKxYCUs6LzHauFRBbAg12v909x3ZnI
 wtcb0sPHbdjVjKF/zuyKWHKwzgh8PuKIF8DBOruL6wcaj6WIOg7X4gJEpZVCJxmOSX6jvP
 mxziBGqhLB0KE1b49EM9QDmAFO1sIzURQZHE1vaOdS6ii4FVa+ZK75njZu+e9kABm1cgo0
 rt8G71TQ+3zgiluEHGTiBJg+SlZlpLUwu7XXjaM2aDhDmCoOY3gqQ+uo6MxkFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1775117171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2i453U9FtFdArbGUNQFDw+ljY707QrCo8bvJkIZzqEs=;
 b=qXSvuZdNN+iZkWBFgl45+4MwP0GzFr04IqWwxqTH2YBKXOKIIZ46HQcYWyF4WRoq2Gaa1w
 rhYT2HTUUfEnlKAw==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [v2,2/2] cli: flush stdin before enabling cli
Message-ID: <ac4jcb5rmFG3qDz-@gregor-framework>
References: <20260401124128.178799-2-gregor.herburger@linutronix.de>
 <20260401124128.178799-3-gregor.herburger@linutronix.de>
 <CAFLszTg_LiyHPYhQh+MTV5skuY0ORrPotOFQWkQSQvsBzjHTYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTg_LiyHPYhQh+MTV5skuY0ORrPotOFQWkQSQvsBzjHTYw@mail.gmail.com>
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

Hi Simon,
> Just to check, does this option also need 'depends on !SANDBOX' like
> AUTOBOOT_FLUSH_STDIN does? That option notes that flushing stdin
> breaks autoboot unit tests. I suspect the CLI entry path might not be
> exercised by those tests, but it would be good to confirm.

I now tested a bit with the sandbox and I couldn't find any issues. I
ran some unit tests with/without this patch series and with
CMDLINE_FLUSH_STDIN enabled/disabled and couldn't find any issues. I
also ran `u-boot -c bdinfo` which seems to be executed after the
cli_init and therefore after the flush but I could't see any issues
here. 

But this is the first time for me using the sandbox so I don't know what
I could test further. If anybody has an idea what tests could be run let
me know. Otherwise I will send a v3 with an updated help text.

Best regards
Gregor
