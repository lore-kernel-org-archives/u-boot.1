Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AC9CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 16:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A45847B0;
	Tue, 26 May 2026 18:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pk1qkh2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A890484894; Tue, 26 May 2026 18:51:29 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F22C846D3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ba6485d219so83551045ad.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779814285; x=1780419085; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KrESFgS8meNpyMG3F6G4gEm6N2/DapyOBgoLAJny/7w=;
 b=pk1qkh2xI7OI7OXZRUL1SSmFxNfyQgJxStPy+agzZ3JD3ib5ab/Mr6IGOqPzEqkLoa
 afOGYJ/3DvAC0o1ieSMUphPC565TV0n6gaoMYJsBD6yd/4WEKWE/biymeaj52IGnpsjd
 jH2FxMjeoA3EPqqV5+kh3NYxALNZyAItU80lKCFbellzS72KnwYfMOZZTO+82F6QvKXL
 hZJRFZssudwL8y0K3BLTT85Dbgb88Plu3TPxbWbp2xpJKUG7EXUm7/HLF5U6n+Jg9giY
 XY9BmbYBknDHam6JRGmw5fZj8vzhw1hAg0/n/glZ8q6HBnusmhhBsz1NzJIs6wtxnDKd
 tQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779814285; x=1780419085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrESFgS8meNpyMG3F6G4gEm6N2/DapyOBgoLAJny/7w=;
 b=YmZUOJO4njkvyYNR0ux4A+S2xw7Un1apPz9tc9cE36VcdRMjVJGX330OVK6bAesolt
 l3ryQgvBZxbVTZ1kp0UNCIxWh0d3jaWLBdE323hOcZxhugCl+1XIsazh7CTSkSwI5/aH
 mK1zfGAGMqcFUYeD6SkpVY/qIUEB2PaRcK8GB7KBjfSFGSqLnjntyG3mYKwhNQ7fid0I
 0gcBgQHi7xlauQCi+0VP+OyLOVEAF2FyWGmuIzfEZMqC38BPDBkWl26jFLqiIyH8wO6h
 X9wlD5LhBzDUR9TMru1Bdq1rKpPx7LrAE/7Jc2BuR1zcNaSkKxntqyF9mUGUE8R2qvR/
 /EIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lhwRZm+LAwAWVcgdYtR48iRHinnq5IzxyklCMiGDBYhvAoXeJMb460SvLpz0NVvvjdOla1ks=@lists.denx.de
X-Gm-Message-State: AOJu0Yya88t5gju66734irziJ65IAapK/mzDbZVuF1R2Ks7iy/GnTVBm
 wrlBqMADM1EAbJyZ7JikcX0vlel/SxsQyCCzutYakilhPHeF+hQQvN8+
X-Gm-Gg: Acq92OGeEvdAPyXMcVK6AClyCUZeZJ+zVSY4UdVgYGaaq9hwO05oR4cjUJynvcSrEkt
 JKFoNkqL9sXASUTHgchcxtuzzXFCTJoQJ03fd0xS+dIKDF0w27wb3znaMLuPxxCG4gNvPzF3yNY
 4bBPQu/YRPV+AlpH4zQEQaCxblqV1YBvLxIgzEmnPJDqJC6nfO0KgAa+p+mH0/zQReEU1RUTFlM
 qGxAjHH8r1SgdFeRSZQni0B6VVlIA40iQzk7fksrhRfwyPJpb6ib+UIscWvnUHSxrzpQ+r0t/wN
 62f9023xXoyE79R2PlDQxCQwm4cdsunePemqdAh1OiWYYTds0rJLs6T3tL4CcF16o5a8GkxrhLQ
 IDrDonlDGh83eO2l0Z2QvL1RcTD/hyBoP7RTtjWt9UOwo54biyJPPyeHqK8Sr+wk93+RoT4/8X2
 KUwPihQ4COVBiS/2ZIplxA5SpUWNSNPGvS1fI5
X-Received: by 2002:a17:903:3c28:b0:2bd:3c1a:473e with SMTP id
 d9443c01a7336-2beb038b83amr212634115ad.14.1779814285399; 
 Tue, 26 May 2026 09:51:25 -0700 (PDT)
Received: from google.com ([2402:7500:569:8475:69e1:a564:3471:c6f2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695a29sm123530655ad.11.2026.05.26.09.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:51:24 -0700 (PDT)
Date: Wed, 27 May 2026 00:51:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Javier Viguera <javier.viguera@digi.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/1] libavb: fix avb_replace() OOM handling
Message-ID: <ahXPidpyl-qRMOkH@google.com>
References: <20260521165122.17475-1-josh2@disroot.org>
 <64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.com>
 <87v7cafha2.fsf@kernel.org> <20260526142333.GT1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526142333.GT1858239@bill-the-cat>
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

On Tue, May 26, 2026 at 08:23:33AM -0600, Tom Rini wrote:
> On Tue, May 26, 2026 at 03:10:29PM +0200, Mattijs Korpershoek wrote:
> > Hi Javier,
> > 
> > On Tue, May 26, 2026 at 14:52, Javier Viguera <javier.viguera@digi.com> wrote:
> > 
> > > On 5/21/26 18:51, Josh Law wrote:
> > >> Hi folks,
> > >> 
> > >> Since I am a new contributor, I would like to introduce myself first. I
> > >> am 15...

Claiming to be 15 does deepen my concern, because I clearly remember
seeing Josh claim to be 19 on the lkml about two months ago [1], so
this is clearly a mismatch. If even his age has different versions, it
makes me doubt whether the rest of what he says can be trusted.

I previously had a private conversation with Steven Rostedt regarding
Josh. At the time, Steven felt that Josh was just a young kid that
didn't know any better, but in the end, Steven also gave up and decided
to stop helping him [2].

[1]: https://lore.kernel.org/lkml/043CED5F-7014-4776-824E-07E027B7BDC3@objecting.org/
[2]: https://lore.kernel.org/lkml/20260423083246.4b32a665@gandalf.local.home/

Regards,
Kuan-Wei

> > > Wow, we have a "Benjamin Button" case here. I seem to remember he was 19
> > > in the kernel mailing list ... :shrug:
> > 
> > Thank you for emailing a about this. Your message made me curious so
> > i've found:
> > https://lore.kernel.org/lkml/cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local/
> > 
> > I'm no longer sure now if I should spend time reviewing this patch or
> > not (because of bot suspicion)
> 
> Yes, I've moved to Deferred in patchwork as this is an extremely
> disappointing thing to have happened.
> 
> -- 
> Tom


