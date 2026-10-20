Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E775606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z891iKnk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GurO4nr/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04E9580BE8;
	Tue, 20 Oct 2026 11:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uUqKC4jPoWRu; Tue, 20 Oct 2026 11:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52A1080BF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792496628;
	b=B+lBTi2BN5hUAFOuTaZZRwAy4YujofN96sqY3E3p8WcMqiFjMWejXBjk68u0zlP5+qM4
	 RAgz/s7ZfIDd4cRssk0WT0PNoBWkrAyxIOrEog2d0zB900PCzuefe/a0NIS9u6S5bA5mr
	 yr8afoH284JFJ1rEKztES9F+4xuhkxIv7aO/r/X0Pazs7JGiwSwqmw+aGWkeuwG35/jvS
	 dsvDrAgN5z2RqFAggBY+eCWfHIhw9z7kiLaGIfJc+/3nb5Xh9cxBocOVx30k+IM088Md3
	 81m1+gq1Kl+rF81JZjx+S86zla0echjCn9hH4nJM1uF7GKdfkJHcR1mhzNi2gUznl2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792496628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1mNcc9iKs43gkQXICnPGpfr+HLBFDtzDb6M+oObHYpo=;
	b=YSEpB7Jl1TCbh/2Bq0HOn5RvPSwkatQZw5pNGekejtVEeFnzuFTSc5FXGCc5Nh59npJ/
	 L07RxNDp5kt11xPwBSMhKJ4VXotZYCarqvm9mI9ir/QuXimt7Cm6+3WsMo+Rb02MinXjr
	 BtP0YzGwtNCmH3SqhfZ06PRxWzt44Na7c4SdhWYmUUHAu7+P+BvU4vXiGVbSr9mTOtoKe
	 AiKFVlfC64wr3kTZSfpnZiWUgn7+KysrWIJD+UYrBv/9qdu1Yv6Mz09u6K//S7CVHuaep
	 STKH57JUWfolT8c8toPHtYJmHl6047tqX5C3XVE6ytDdj2oO7YXrYWP52vGB0c6q4Sw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792496628;
	bh=1mNcc9iKs43gkQXICnPGpfr+HLBFDtzDb6M+oObHYpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z891iKnkspXRL7aZ3lfr5quUSL0wfqaBpRMshjqN5chlinYgmAVtnVfUYedwiPHFL
	 sXY2hdjyS+r8SAJHTyeynvPUKZokwU13OSNKdfQMrqGa6S5vFZ4jAWwcBPDQnmIkdI
	 GcfaDc7t5RRIuO40fYntMnBeXbiiuj0VFjiPf3dSsgtFLyJ98Nv0YScVoKoPUdbBAx
	 tQuFd6YasbX9ZE9htfUYRHX3PFvKl5jqx1JQbi27+pzIbi8ZJqAECYXTj1A9I54w+6
	 XPP+nI15Gnw1vFmbyuu6xDSOkZWvYhcsW7WULL/kaFDRbbUZPGgTPzprmuHixIwy1R
	 EAvOV6lGJaXdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52A1080BF5;
	Tue, 20 Oct 2026 11:43:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EA071DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C868400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:43:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6j2bsyn0dJP for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 11:43:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EDF224008E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792496626;
 b=jBYcdcK98hI10fzuy9JPoo8hGq1+c5lSAnREcr58pXaIk0z4pz2zsB2v3/4f8WxlzxQd
 jgOEgPoYpZp8J0joGig50nmvhULWzImtf0sjiRbUILbBH5CBUEvetVO38eeOfZP21ScJY
 tMTG5yQB+WUuoNfSRXv1hv7gI/DM4F79x6do0zqKwSebdPDUO+x8TzdyYqfNU9m1wfpzY
 qaKzFoj4EYoWxR/p8zRL9PAGAwhuIwdsyDKy2ZOjmlgrsKpOEvnNZuRknOu9a3RzqXu7R
 5nKk/H9z0SZMmc1pqM5ry7LjKB8gJMdIgFnTE0on4h0ENSF78Jre3uGeAy2NxWdeO4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792496626;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=1mNcc9iKs43gkQXICnPGpfr+HLBFDtzDb6M+oObHYpo=;
 b=hVSpuV+iu4BMtV8fSGXkkiTZYuNJVvy3bsShqKwFe5ML1cDqex+SdA+7tNEJNqx1Qwwh
 UotyNjG6d1qvFHvIqYYjA1BZZU9NcoRo/HKSnm6rRv67h+J9Ucp7KvMLViyHY5LzceayW
 oJcLrNfqJF8Xj8VN02S/XbeANTZhFaIAYv/+8SqEKWWs0e0m6BcDFGlpFG3J49P8LTzDq
 QoW/EhXSLX7ybYbh3m462Lhhxl+ISfiMtEz5pLu/erZKeqhkxOS4tjuKvLXmgWlYXhVCW
 q8DejkOSZLYoDMKJSLdW1OBrMHbXsNC+VWYTPRGQ9AyuwLLzO1JgL2KQ5KqLwcZKYEQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="GurO4nr/"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=GurO4nr/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDF224008E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:43:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 624E360220;
 Tue, 20 Oct 2026 11:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869DA1F000C4;
 Tue, 20 Oct 2026 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792496624;
 bh=1mNcc9iKs43gkQXICnPGpfr+HLBFDtzDb6M+oObHYpo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=GurO4nr/QfijNkW5yxpg5mzlSr+Dh7BpY1fplJZEjdTFN7kDscr0UQY8bjkYR2B+C
 HJUJW6VuviaSAkZt4DF6qYYTiO9igZns/uh9DzVRjhqz/W7Mw48hrHTcvKnU/hO6x/
 4Ih1hsBg0J9PANImmfJL9/Y2YyoEezCuwypVO59kq56u55+pq16xXrpVgk54F28usi
 38+sESqx8eL7KWmJFgOw1aEpYopYjwAYrt6pOheHh8sOMYmR9fXF1l/W1rvhHy8hgu
 3ctA6CmOoPt9iPqba+ljy7Om1UC1T4rQKr1GgiDJumehX+R6qEPYuKMSwkdQg9vfSz
 CUPm1cgV58BfQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org
Cc: igor.opaniuk@oss.qualcomm.com, glaroque@baylibre.com, sjg@chromium.org,
 trini@konsulko.com, Jan Kehren <jan.kehren@emteria.com>
Subject: Re: [PATCH v3 3/3] avb: Take a storage interface in the AVB operations
In-Reply-To: <20261016072640.772964-4-jan.kehren@emteria.com>
References: <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261016072640.772964-1-jan.kehren@emteria.com>
 <20261016072640.772964-4-jan.kehren@emteria.com>
Date: Tue, 20 Oct 2026 13:43:41 +0200
Message-ID: <xhkdb8q3s4mxe.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jan,

Thank you for the patch.

On Fri, Oct 16, 2026 at 09:26, Jan Kehren <jan.kehren@emteria.com> wrote:

> AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare device
> number and get_partition() called find_mmc_device(), which rules out
> verified boot from anything else.
>
> The user that benefits is "avb init", where boards already expect to name
> an interface: board/armltd/total_compute/total_compute.env picks between
> virtio and mmc at runtime and then runs "avb init ${blk_dev} 0", which no
> release has ever accepted. bootmeth_android gains nothing yet, since
> android_check() rejects non-mmc bootdevs through bootflow_iter_check_mmc().
>
> Carry a uclass id alongside the device number and resolve the block device
> with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
> partition switch on the mmc path only. "avb init <dev>" still means mmc,
> "avb init <interface> <dev>" selects another bus, and neither touches the
> device: it is still resolved on the first partition access.
>
> Only mmc is started by AVB itself, so say that in Kconfig and avb2.rst.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
