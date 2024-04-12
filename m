Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADD2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 19:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D5587E62;
	Fri, 12 Apr 2024 21:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="mccGG0x+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U9cKTSty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932668802D; Fri, 12 Apr 2024 21:27:53 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC3F87DA7
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 21:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
Date: Fri, 12 Apr 2024 21:27:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1712950070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DahBK8HZYm/poSHHvYuLy2mxwRUo7AclNQ4iUalUHoo=;
 b=mccGG0x+u5igi92TdzRbhYq6ccs/yhLKaEY9nSuDNQJKDiYIM21YNaT+iS/9Qh5v2K2xYL
 Te+ELT5ENqQYAvcty4niyJSbsrQy7pr6ZTxBDvL0mu08YfN8xajHI/b7fi+/zbeCk38pj3
 /WIyKolmzCWcZ+bqxUx0hjFdCzBsffHylmM2w4zROFFwv0bnt2rmhls5wsCaslSsrfe1O/
 06CcWgzx4BOLgA071nt5CkhglFN33XqJRVz2qKrcD08L2+nXmwMVL5XUhLdWqkEP5t4Fue
 C16Iv3CHTGzSoIxdG7qtY9B3+A7r7Kg5UIYxd4C4bhR11O3sBXGGF82rMg/Fgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1712950070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DahBK8HZYm/poSHHvYuLy2mxwRUo7AclNQ4iUalUHoo=;
 b=U9cKTStymcpaseCiw4N5KK/0mNXR8irjHLDUhiwxaoLlaaBmyqkP2iMBjI49QQBHvFnN69
 L+kEJUN5v0t2E7CA==
From: Nam Cao <namcao@linutronix.de>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Bin Meng
 <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] bootflow: always initialize bootflow_iter_set_dev
 parameters
Message-ID: <20240412212746.6c2fd483@namcao>
In-Reply-To: <20240411085225.0b36a0e0@namcao>
References: <20240410221206.22782-1-heinrich.schuchardt@canonical.com>
 <20240411085225.0b36a0e0@namcao>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On 2024-04-11 Nam Cao wrote:
> On 11/Apr/2024 Heinrich Schuchardt wrote:
> > method_flags may be passed uninitialized to bootflow_iter_set_dev()
> > if dev is not NULL.
> > 
> > Always initialize method_flags.
> > 
> > Addresses-Coverity-ID: 467057 Uninitialized scalar variable
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Reviewed-by: Nam Cao <namcao@linutronix.de>

Wait hold up.

I was curious about the Addresses-Coverity-ID thing at looked it up.
And I discovered that this patch was sent a few months a ago already [1].

What's the story here? Why is this patch resent? There was a test
failure report the last time this patch was sent, has that been
resolved yet?

Best regards,
Nam

[1] https://lore.kernel.org/u-boot/20240118173802.GA2695740@bill-the-cat/T/

> > ---
> >  boot/bootflow.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > index 68bf99329ab..f659a414c79 100644
> > --- a/boot/bootflow.c
> > +++ b/boot/bootflow.c
> > @@ -244,7 +244,7 @@ static int iter_incr(struct bootflow_iter *iter)
> >  	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
> >  		ret = -ENOENT;
> >  	} else {
> > -		int method_flags;
> > +		int method_flags = 0;
> >  
> >  		ret = 0;
> >  		dev = iter->dev;
> > @@ -263,7 +263,6 @@ static int iter_incr(struct bootflow_iter *iter)
> >  		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
> >  			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
> >  			log_debug("next in single\n");
> > -			method_flags = 0;
> >  			do {
> >  				/*
> >  				 * Move to the next bootdev child of this media
> > @@ -305,7 +304,6 @@ static int iter_incr(struct bootflow_iter *iter)
> >  				}
> >  			} else {
> >  				ret = bootdev_next_prio(iter, &dev);
> > -				method_flags = 0;
> >  			}
> >  		}
> >  		log_debug("ret=%d, dev=%p %s\n", ret, dev,
> 

