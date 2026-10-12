Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DB7CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAD0940547;
	Mon, 12 Oct 2026 21:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1tSg0ecFfRz; Mon, 12 Oct 2026 21:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03ED240538
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791840010;
	b=Ld9diB1XqipeKs8eZFYbydxKC0GN4deJ30wHUoDwgyQzLcqAMpYy/RY8oFovYli1yLbD
	 dFxmpQS4sXZpchM35iLfG7cfyLiSzNOsJvbFCHpLL9LZNsWf/xuC+9JHjxHi9otWnI7nr
	 28/tQC1YDHAIlyU+hYXALd3Om+wcyh3mwC2jLltCObwfoWlIIiHvLmtewfSPbW3ntWdDn
	 9EFP3sf8c3xtxITPY8u3tMNbKEjog17zcea3KS3FMZDreEshRO2pmJ1QFZMJDyVXS8ChG
	 Eb3B/ZWy/IpD/xwfYgWy6CsN/NzpsruXMs5dHSYihPmEQwunjdrTb7LtYBhk14dtnCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791840010;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZnoJZky9i93ZHbNCvKozMSqvJyWEUGt39h3WqM4YxUU=;
	b=JSuw2p1y6ChP73LrkXoxXJ4MQjpydq4Qajz93L3Z7j415BkCsoHgSKVZUnoxIPHC2mh/
	 ak1Xm7SwUw2O5/7AIszU3xpojREaNPSHTqoGNFg0ix1Zx05UIATvLmmmuwzz6ytg4LxqX
	 BhXJcfIfd0egkwmpQeHs9o+rGvxq0oeYXGRIas8QR3kAdhUAjvXPLzjRFbTiTEozcC1oj
	 3SJmNAiktnq7QyzbEr8vB/lrzLEPiPppqtZ1PySagzzCiepgleMehFk+DOiZmr7LdYpR/
	 I7cASJlJmMYu0ZsvoBWzBabCXRCIl8X5glCvytwn0iqwxvif5UubIXOGr00a5Ca1q3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791840010;
	bh=ZnoJZky9i93ZHbNCvKozMSqvJyWEUGt39h3WqM4YxUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dh40jacWwv1jmHLi653k5NtWnr8C546YQH/OT5fWkpqe/r3bkViBwz45wM2ipu7v1
	 Hynuryo/7h2ycaeKFKirqidgYoB2k84NwlEEMvFfb92JmlrtqFNex4WievbUpYJ+NW
	 nN1zTzSCfO4JeBl1cezJ3K/O2WUdDD4BPUkee8ntNngbHtF52StrWtwErFBzR0utC/
	 JYfc/7DsSTmmlrZBcHk7EbC6FtLjC4WbJE2ovQ04aZrDs7rELjmJ5YPibRjP3uP5OF
	 Z36iQnEQQzA3/aefAIlDffhRZfpTddk94CSO+5oNcHW9ouo+eehmlqmn9apZLvFlL/
	 seW+iKzBTnE7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03ED240538;
	Mon, 12 Oct 2026 21:20:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DB834DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33B1280AAB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qdm96So9WRzS for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E5C580AAA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791840007;
 b=YswIycWaY72QQ8ew055fLeBp9sKjJiqwBaTlpJtBAYx6euIVVPTc9QXdnSVM5NxspXwf
 pP5atMXn3D11MMfzKTStAG/W3+rHbI7y2LI2oEYaDmt1dGSnd3gURTfDqljhY+2uIwKRF
 /eXeI2xvn+h6W0YtdJgw2zVO8LeCj0CX2PFevJE57d8tr6geE+QPAl5x4+wKG/npfwq+F
 GTIprYikevoXB9XOwvD3aJvtUWejZO6J9I18/1tVeXkafiR+6/AbBePX9TU2bYZu3QWM3
 oelrIkKie+2d0luXkT7dS+kDG52ft03AL/q8fcAoEU9UNuh9c6abBRwhzH+s67Oo4Lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791840007;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ZnoJZky9i93ZHbNCvKozMSqvJyWEUGt39h3WqM4YxUU=;
 b=lZNy0Zh9qs/9f+33SoAmVNfERsuq+VqescWRVVatAjZQCsjXJwHkVhwGN/QJutqEVxz3
 BBmLhQtC79rENc+A1zm11IoBcOtZeOlrJUmCbw5DzXWIUCyT+fK3f8IR8H7crHny7av+8
 Yb3e+zn0ojxRYE775d0/MnXaN4wNBSWAtfCNjgoiydZkUYP9CWJSYogoz62NQMqskc7+K
 fqsAKA8t1UQW6WbJJOOqi+I9onRTvGUiTCSCI/RtQoVc+WwO59y1sYeOwVBxKsnsmCw80
 CmE7Dk1AwoalavWOfCODkjp1ulTeET3zaUVfMrzShBI7B+srRGRMZcfJSwDYkf45qrg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linux.microsoft.com;
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=K0ysc6jt; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=K0ysc6jt
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E5C580AAA
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:20:06 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 6482420B7166; Mon, 12 Oct 2026 14:20:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6482420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791840002;
 bh=ZnoJZky9i93ZHbNCvKozMSqvJyWEUGt39h3WqM4YxUU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K0ysc6jt1LRu4dqQ4o+1jxqHVop3t+y1vITxHrz34l2vh0Ys7UVwrfBx+jKLOhTrz
 s2hjqtjFlngMWxzhT9+xAPVtJYhH0SabzFRwC9x7jvxq2/6luJuuDe0yhrVdARNHGi
 Ct7wemQBcwynB5/I0TLpk92DNPGbM/GolCpSlsA8=
Date: Mon, 12 Oct 2026 14:20:02 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tom Rini <trini@konsulko.com>, jerome.forissier@arm.com
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>
Subject: Re: (subset) [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Message-ID: <as1PAnqpeFKZddk2@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
 <ar6Ag0tw4KYUrgev@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <as0zB9XpmfOK7CtP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20261012200131.GH3722450@bill-the-cat>
 <as1Llpz//mM2B8Gc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as1Llpz//mM2B8Gc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Oct 12, 2026 at 02:05:26PM -0700, Sriram Sriram wrote:
> On Mon, Oct 12, 2026 at 02:01:31PM -0600, Tom Rini wrote:
> > On Mon, Oct 12, 2026 at 12:20:39PM -0700, Sriram Sriram wrote:
> > > On Thu, Oct 01, 2026 at 08:47:15AM -0700, Sriram Sriram wrote:
> > > > On Wed, Sep 30, 2026 at 07:20:11PM -0600, Tom Rini wrote:
> > > > > On Tue, 15 Sep 2026 13:52:07 -0700, Sriram Sriram wrote:
> > > > > 
> > > > > > Three independent hardening fixes found by internal static analysis and
> > > > > > code review. They do not depend on each other.
> > > > > > 
> > > > > > Changes in v2:
> > > > > >  - Dropped "boot: image-fit: add overflow guard for FIT decompression
> > > > > >    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
> > > > > >    as the allocation size and as the unc_len bound handed to
> > > > > >    image_decomp(), so a wrapped multiply cannot leave the bound larger
> > > > > >    than the buffer, and image_decomp() already fails cleanly on a bound
> > > > > >    that is too small. The claim in that commit message was wrong, so the
> > > > > >    patch is withdrawn rather than reworded.
> > > > > >  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
> > > > > >    single check that the packet ends in a NUL, per Tom's review. It is
> > > > > >    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
> > > > > >    and it also covers the dectoul() calls, which v1 left unbounded.
> > > > > >    Retitled to match.
> > > > > >  - Rebased onto current master (a44f46af0aa).
> > > > > >  - No change to the NFS and ext4 patches.
> > > > > > 
> > > > > > [...]
> > > > > 
> > > > > Applied to u-boot/next, thanks!
> > > > > 
> > > > > [3/3] fs: ext4: widen ext4fs_update() block-group loop counter
> > > > >       commit: 1c1b6c2b2ae03912007ed2ffd361f43b7c2e5401
> > > > > -- 
> > > > > Tom
> > > > >
> > > > Great! Thank you.
> > > > 
> > > > Regards,
> > > > Sriram
> > > >
> > > Hi Tom,
> > > 
> > > Just following up on the other two patches. I see that Jerome reviewed
> > > them on Sep 17th, but they haven't been applied yet. Is anything else
> > > needed for those patches?
> > 
> > Since they're both networking ones, I'm expecting Jerome to pick them
> > up.
> > 
> > -- 
> > Tom
> Thanks Tom.
> 
> Hi Jerome,
> 
> Anything else needed for these patches?
> 
> Regards,
> Sriram
Hi Jerome,

Sorry, there was a typo in the previous email. Anything else needed for
these patches?

Regards,
Sriram
