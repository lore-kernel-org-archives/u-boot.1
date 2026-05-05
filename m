Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C00CD3430
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 09:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBE9846B1;
	Tue,  5 May 2026 11:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RzZbM0cp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BDD84676; Tue,  5 May 2026 11:00:58 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4A4846DB;
 Tue,  5 May 2026 11:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B95D060125;
 Tue,  5 May 2026 09:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01A5C2BCB4;
 Tue,  5 May 2026 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777971653;
 bh=1y87stCpce3haJdD1D3ePEdaKJSptkSGchAHmbb82Wk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RzZbM0cpxueryRsvjh3UN0oImXt8OkhGj6VT1yASJchLr/zTHijx4dGzSWUOyVtO6
 bGs8IEA2zm8NRq9JeNl0cnxSlaCun2Sulh+flsy2wUXOmRLRfJvDKYK2YKVNRKsEDD
 9iIIxllafOmstcfr/ptmBWTIxEHzKztJp+6CkAvxfUUNUOZVywb5xgLo0wythk9Lrl
 //cH5hCjB8+r9xXYRVee7AjjzT4ph/cV09zb7KfcABEOLGylyNfaNhkS7yIXhYcYpX
 Rx4UEm8qcdnCyO4Z2D2pKBdoTS0+arWssUA+AF3DQEwd44vy+UiqUMcW4U3AUOp5sh
 AgOP33ciWa/rA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, U-Boot Custodians
 <u-boot-custodians@lists.denx.de>
Subject: Re: In-tree Python tools (patman, buildman, binman, etc.)
In-Reply-To: <20260504160645.GF1614990@bill-the-cat>
References: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
 <20260504160645.GF1614990@bill-the-cat>
Date: Tue, 05 May 2026 11:00:50 +0200
Message-ID: <87qznqcjst.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, May 04, 2026 at 10:06, Tom Rini <trini@konsulko.com> wrote:

> On Mon, May 04, 2026 at 06:16:58AM -0600, Simon Glass wrote:
>> Hi,
>> 
>> As you know, I maintain several tools which are part of the U-Boot tree.
>> 
>> Tom has previously suggested that it would be better to move patman
>> out of the U-Boot tree, e.g. to its own Github project. It is a
>> general tool which can be used with Linux and other
>> mailing-list/patchwork-based projects. I have never been keen on
>> taking on the extra effort required, but I've recently added more
>> features and am wondering whether now might be a good time to do this.
>> 
>> Buildman is quite obviously designed specifically for U-Boot. I have
>> made some improvements recently (a large code refactor and distributed
>> builds). I would like to push those changes to mainline. Do people
>> think it should be in a separate tree somewhere?
>> 
>> Binman was written with U-Boot in mind but supports other projects
>> (such as Zephyr). It is generic enough that it could be separated. The
>> impact would be harder code review.
>> 
>> We also have smaller things like qconfig (which I have substantially
>> rewritten to make it fast) and dtoc, which is very tailored to U-Boot.
>> 
>> What do people think? Of all of these, patman would be the easiest to
>> move, with the least impact on existing workflows.

First, thanks for maintaining those tools. I'm not an user of all of
them but I think they are great. Especially binman and buildman.

>
> Given that as a project we've been encouraging people to switch to using
> "b4" as it's now widely used and covers many of the problems patman was
> designed to solve, I think that's an easy one to say that you should
> move to your own personal hosting somewhere and it be untied from the
> project. The rest of the tools are something we as a community can
> figure out how to address once some of our general infrastructure issues
> are unblocked and moving forward.

I agree with Tom here. I think that moving patman out of the U-Boot tree
is a good choice. Personally, I'm a happy b4 user so I've never tried
patman.
Let's start ("small") with moving patman and see how things go from there?

>
> -- 
> Tom
