Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58334C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755AF87FFD;
	Mon,  4 Mar 2024 17:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=georgemail.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=georgemail.eu header.i=@georgemail.eu header.b="GmGTVQuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105B387F9F; Mon,  4 Mar 2024 16:57:57 +0100 (CET)
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDEE87FCE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=georgemail.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon@georgemail.eu
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 9B2FF240A31;
 Mon,  4 Mar 2024 16:57:53 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id F0DC0240D20;
 Mon,  4 Mar 2024 16:57:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.eu;
 s=DKIM001; t=1709567872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLEOBn34bb0Sqvp0Rn+VAquAwHFgZr9Pan+Dwr8GEzY=;
 b=GmGTVQuCOMUjukNgCjLNG3P/itzUa09DImFAIHFigkgy/kpcXtFne/DdJZwK/wnQe1ixHl
 y+OWq8Nt0OyInWZXwBEv4O3SVV6oOmdwve56VHVM29bXaTylBcZwzh9mhz0TITcd9Y8jqJ
 /bLK0ii3nuI7O+PSmtyNZE56F9xAuK6BVoMKN9V04mKPTtwofv3R/Byyqcca8Ok+/jur1R
 Q3srK8y5pU1xb3hgN+3xO/0QwPxw2kxf+iEZbxOxOAc9P3zWELAFUsR3FdJxOslTTqYGSY
 juPXky6h25z/yqhP+2SGHdoQLvHqmMe0mJb3OatbiBnXoTsyG2sE3Eb9W98Xjw==
Received: from couch-potassium (unknown
 [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id BCB70240CCF;
 Mon,  4 Mar 2024 16:57:51 +0100 (CET)
Date: Mon, 4 Mar 2024 16:57:50 +0100
From: Leon Busch-George <leon@georgemail.eu>
To: u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] Makefile: use shell to calculate map_size
Message-ID: <20240304165750.162db44c@couch-potassium>
In-Reply-To: <20240304154007.67df1822@couch-potassium>
References: <20240302131728.148251-1-leon@georgemail.de>
 <f27f49c04e7c4dca0112003e44bd9814@manjaro.org>
 <20240304154007.67df1822@couch-potassium>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: 4d0c95
X-Rspamd-UID: 15d55d
X-Mailman-Approved-At: Mon, 04 Mar 2024 17:30:21 +0100
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

Oops!
That should have went to the list as well...

On Mon, 4 Mar 2024 15:40:07 +0100
Leon Busch-George <leon@georgemail.eu> wrote:

> Hi Dragan :-)
> 
> Thanks for your reply!
> 
> On Sat, 02 Mar 2024 22:13:08 +0100
> Dragan Simic <dsimic@manjaro.org> wrote:
> 
> > > +		awk '/_image_copy_start/ {start = $$1}
> > > /_image_binary_end/ {end = $$1} END {if (start != "" && end != "")
> > > print "echo $$((0x" toupper(end) " - 0x" toupper(start) "))"}' \
> > >  		| sed 's/0X//g' \
> > > -		| bc); \
> > > +		| sh); \
> > 
> > Maybe "sh -s" could be used instead, just for some additional
> > strictness.
> 
> -s is the default already but I see no reason against adding it.
> Allow me to offer another idea to improve strictness (I'll send a v2):
> 
>     awk '.. print end " " start ..' | sh -c 'read end start; echo
> $((end - start))'
> 
> That gets rid off sed and the interface between awk and sh is much
> cleaner (only the two numbers on one line rather than shell code).
> Sadly, the sed 's/0X//g' was introduced without an explanation in
> 3ce7a4fefa and but, looking at it more, I'm farly confident it was
> only for bc.
> 
> kind regards,
> Leon
