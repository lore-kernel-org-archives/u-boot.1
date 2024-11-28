Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D29FD690FC
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 11:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9990389882;
	Thu, 28 Nov 2024 12:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Y5OQEDYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB9189885; Thu, 28 Nov 2024 12:25:56 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DFB89883
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 12:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 8763694a-ad7b-11ef-8d51-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8763694a-ad7b-11ef-8d51-005056999439;
 Thu, 28 Nov 2024 12:25:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=ntEadxXnaap6HgX0DUC358ZucHcHJF+Al6pJ9OcGEVw=;
 b=Y5OQEDYQLAho0yb3ny7g16rl6gKV9zK5Xr6R+g7m2tHNbED4KPRoKpiWXFoOkmCXGKmQnx2xdqNNn
 /nqwD+8C8A1//OZ7TLC2+lnkdVlw/TL50cljqtxMdin9Y5kkPXqFGkUbN8BoEVuk26dMAy8331F/i4
 cOgZw3wmZxBk5K6vETQMnlY1Yh590wqRkl+ff/2MfLOe6CcWPY05AzlMR7RshbKSfXqVRBJMm/tIhi
 tREyRwsAk6/6BAUwzulfnlBII4Zjivre5//tviu+Zp6Eej7gq7eztqii212L8A+TMPbtPekQmQlSn7
 QHoe+YF/SpaebTyYjhKl6NP35Vg1CYg==
X-KPN-MID: 33|u/gNtou5psQyD9E5KWjASAcKa3Na/riC3ujyyVvAMKWGsvmUG1UlB25cGebBbe8
 1ar/p0uLgE9oOcePA7n0ToHeuqmm9gBzs0/PxeURqLZU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|smeiEmX689Db5sNej7Q1GffY6u+Oz2Y6GCGsFAwT5yikG4fBP4LR7EZ4XgeDSJC
 dLqiK7oK3aQT4+BIeNKc9Dg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 86fa73f3-ad7b-11ef-976d-005056998788;
 Thu, 28 Nov 2024 12:25:53 +0100 (CET)
Date: Thu, 28 Nov 2024 12:25:52 +0100
Message-Id: <87bjxzzjjz.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, marex@denx.de
In-Reply-To: <7a713b05-030c-48ae-af3d-e7fb02b2f7c5@cherry.de> (message from
 Quentin Schulz on Wed, 27 Nov 2024 13:42:50 +0100)
Subject: Re: [PATCH] Makefile: avoid non-standard sed expressions
References: <20241126191214.21709-1-kettenis@openbsd.org>
 <7a713b05-030c-48ae-af3d-e7fb02b2f7c5@cherry.de>
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

> Date: Wed, 27 Nov 2024 13:42:50 +0100
> From: Quentin Schulz <quentin.schulz@cherry.de>

Hi Quentin,

> Hi Mark,
> 
> On 11/26/24 8:12 PM, Mark Kettenis wrote:
> > The '?' that is used in the sed expression that determines MK_ARCH
> > is part of the extended regular expression syntax, but the default
> > behaviour of sed as specified by POSIX is to use only basic regular
> > expression syntax.  Use the equivalent '\{0,1\}' instead as
> > suggested by the OpenBSD re_format(7) man page.
> > 
> > Fixes: 04b1d84221d5 ("Makefile: fix empty MK_ARCH when using ccache")
> 
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Considering that it's not the first time someone breaks this by making 
> it non-POSIX, can you add a comment just above with a link to the 
> re_format(7) man page so people are at least more aware than they are 
> right now?

It is unfortunate that GNU sed has these extensions that are enabled
by default.  Just mentioning the OpenBSD man page is probably not
going to help, but I guess I could put in a link to

  https://man.openbsd.org/re_format

with a comment that only BREs should be used.

Cheers,

Mark

> 
> Thanks!
> Quentin
> 
