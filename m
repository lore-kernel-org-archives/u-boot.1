Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E298D3517B
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 12:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A1F84088;
	Wed,  1 Apr 2026 14:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="jKdS8Az7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SNvhRXCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A2384056; Wed,  1 Apr 2026 07:32:59 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F4383F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 07:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
Date: Wed, 1 Apr 2026 07:32:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1775021576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywN+LVrbw+ievHbvPoPX7Xlx1QL6LS90lRrGEARhYtI=;
 b=jKdS8Az7J/epu5cgGEYp+LZElVroqF+0DjjQVt2jbA6hPBEXuBnyrq7ixj5PJGroqEHp9Z
 K9x17opHng7keZksYuWeScJVZhpwiEkfyuSLlzpufmDYoNtvfxJH63pTxj2161dCYC+wcl
 yFJ3y3bXpXlS0uPwahRa+Ubni3vgLzUZLyaXEzZTfAosWQMb6v1tUMKHUy2sN2ILuNrHJF
 H2zoMuarvl9pn7xmSTFat4gRMCQD/uUKvPqBzkOoK8w3Qqr7zX8XkMJ0btBtqUCv1RXmeq
 fFN+tOJdpG+97S74QcV0PnQKt3BtzKUFA3Tpr6vLMfL7CU8vsdfhMp4wqXAaGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1775021576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywN+LVrbw+ievHbvPoPX7Xlx1QL6LS90lRrGEARhYtI=;
 b=SNvhRXCN4lD5fO4EiCyNiPtdfWQX+TIgEeCHnuWteZybiHKPPLVmkurcLLLQcbFgfXiuwR
 53gZ1PR/cNtX1yAg==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] cli: flush stdin before enabling cli
Message-ID: <acyuBzOBAmAM5uz_@gregor-framework>
References: <20260331110413.1040527-1-gregor.herburger@linutronix.de>
 <20260331181124.GD41863@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331181124.GD41863@bill-the-cat>
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

Hi Tom,

> Conceptually, good idea, thanks for doing it.

> > 
> > ---
> > 
> >  cmd/Kconfig  | 7 +++++++
> >  common/cli.c | 6 ++++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 322ebe600c5..e08fbf27358 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -47,6 +47,13 @@ config HUSH_SELECTABLE
> >  	default y if HUSH_OLD_PARSER && HUSH_MODERN_PARSER
> >  endmenu
> >  
> > +config CMDLINE_FLUSH_STDIN
> > +	bool "Enable flushing input before starting cli"
> > +	default n
> 
> We don't need default n as that's the default.
> > +	if (IS_ENABLED(CONFIG_CMDLINE_FLUSH_STDIN)) {
> > +		while (tstc())
> > +			(void)getchar();
> > +	}
> > +
> >  #if CONFIG_IS_ENABLED(HUSH_PARSER)
> >  	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER)
> >  		parse_and_run_file();
> 
> This is flush_stdin() from common/autoboot.c, but that's a static
> function. We should find a better spot for that perhaps and then call it
> when required.


Thanks for the review. I will send a v2 to change this.
Gregor
