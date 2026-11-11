Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4D606A33F
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x9bmwtyP;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=CcqiA92r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6228740A5A;
	Wed, 11 Nov 2026 10:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEUgzXvqapdg; Wed, 11 Nov 2026 10:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EACC40A50
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794391219;
	b=q50B4Ua7rsiINS7WgwUg7aSOy22o8futC8kuAvPu8RmvGADEqcmi87v4C/VK1sBO8ChD
	 EnJOXcfCL+MTbKQtrl/Qtw2/OnSrTXE6bpK/xt/H8hKDCu/0FvMt/2cI8p1IZiOzDc1vW
	 M05Ac6ucLVWI2PDAFcvgLMFGEEt2WnsxRTXzMBgk98d6t20DpaIiNIzbOJdC/J+ig13Ev
	 anjrtGksQFZVeUnZY53288yNyBdl9oDyLUcm6e/Ed0fwFf59v4y2xAmC1CoYUlMEC0Vnz
	 dBvsS/7FIMx8zr7OvqAp37n/rx5lDTTIb3eehR91oK7wrDY3UE3xPxTiAAV74wKM+IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yZQEieiZtHA30Tac8jFvm7Hl+BTA18iQkFrK70+VHxg=;
	b=M2ZChs8TjfwxqdmZf9bVpKXvOIrxeQ1rPycrsNfxJWQeRYVAUjOABVBlNwTTn1RR7VQU
	 oKp9DLRUHfc1ZQigUDDYAW1HV9iGi/Vr57hpBSLNS+js+n/Au2m5/z063q15p+kIk1Sxy
	 VjgMEysRFJttSUpfkB7CkkiVAGNDtEJOlzY2YvNkgSzezciXe+z2WJtEJYUx2vdqv89FG
	 FkIR+ikUn/fW8LVt7UUm1pBE1KtzWKE9U9q8TvHbC9pG3z0/5TFVO2xvSwP4c3KsrLA9L
	 DbB0GS8+Me50LhtnT1fzZtrd3Njz5A1LqMOV1KR46Hf07m4KGO8m9TMc/eyTmgU4B2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=CcqiA92r;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794391219;
	bh=yZQEieiZtHA30Tac8jFvm7Hl+BTA18iQkFrK70+VHxg=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x9bmwtyP2v/7dH9U/fTWUFxMlvKx9b006gSpYjakCVR5ZWEluNfPp8Xegjfza+UgL
	 TeX5IUwcFZy6smXb4Zt7/q7NWEKexu0PwiZKieAEUBUaw2UV0cfr5G36sFu790SnfU
	 uH3N8ULHIRrF2gwXHp2bMdoux7OkzuIp3kSzLU/+pwmJF5EBwi4CmOX7cZap3Vz+/W
	 KCJA43aT7CJtK+7eE79hPpOFDpbNBlpsTFp3TPd6JMbsPsmVoXqowCiqP9Jg5In2Ks
	 c2yODUg/ter1Kg7XynP73Wn0DZqQZz3h6CcNrwVm4eQmngVuiPr2JRNyd/NoOKM1a7
	 JouWEbPR9yPTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EACC40A50;
	Wed, 11 Nov 2026 10:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B31131F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2650940A49
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6gCRlrgaOt2 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:00:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 259B240A30
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=CcqiA92r
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 259B240A30
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:00:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 159A810DD7F; Wed, 11 Nov 2026 11:00:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794391210;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=yZQEieiZtHA30Tac8jFvm7Hl+BTA18iQkFrK70+VHxg=;
 b=CcqiA92rNJoziRpQQSuAOOZ55H1Xw48UcCIGFzQdYAFwRVD1Dp0VUp1xdXKZG2pBnGyyhJ
 CINVMwTx6onifTpawVZ/gzh0FJsWzLwWli19rJox4V++FMQjYcyR0XprLLlEHpqGo+6AKy
 kRFLTE80ZBw6FFrqH/USpgGtGrtwptB+QzWbT8EqZUoCQj7IC214AgvkBlzCLywRWo0hdd
 JvXYkzRKcP+TfmDEyQGgAXgJQtQ/IFUMpuztAw/W80smFk1/oEgK0Wpn2/BFa8QjIKSco6
 vyknrdaNagPUYXgGqBSFvt7FaC/R1ob6XfpfjUMETrBaRG6+CI37r8XTTBZxGQ==
Message-ID: <c596a092-3eeb-360e-7cdc-ef4262e2feb5@nabladev.com>
Date: Wed, 11 Nov 2026 11:00:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Ana Bobillo <anabobillo3@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
 <7d019247-1a81-4685-a325-dcbb26c87509@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH 6/6] mtd: ubi: vtbl: check the size of a static volume's
 last LEB
In-Reply-To: <7d019247-1a81-4685-a325-dcbb26c87509@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Ana,

On 03.11.26 08:13, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
> 
> check_av() checks what attaching found out about a volume against its
> volume table record, but not how much data the last LEB of a static
> volume holds. That size comes from the VID header of the last LEB when
> UBI scans the device, where it is only checked against the LEB size,
> not against the smaller usable LEB size of a volume with data padding.
> When UBI attaches by fastmap, the size taken from the fastmap's volume
> header is not checked at all.
> 
> init_volumes() adds this size to the volume's used_bytes. 'ubi read'
> and ubi_volume_read(), which the UBI block device also uses, read up to
> used_bytes, map each offset to a LEB and pass it to ubi_eba_read_leb(),
> which looks it up in the volume's EBA table without a bounds check. So,
> for a volume that uses all its reserved LEBs, a last LEB larger than
> the usable LEB size makes the end of the volume map to an entry past
> the end of the table, and a larger size from a fastmap moves that entry
> further out.
> 
> Reject a static volume whose last LEB holds a negative amount of data or
> more than the usable LEB size, the bounds self_check_volume() expects.
> UBI writers, U-Boot's and Linux's as well as ubinize, stay within them.
> 
> Add a test which writes a static volume with data padding, filling its
> one LEB to the usable LEB size, checks that it attaches and reads back,
> then sets the data_size of that LEB one byte larger, which still fits
> in the LEB, and checks that attaching fails.
> 
> Fixes: c91a719daa33 ("UBI: Add basic UBI support to U-Boot (Part 5/8)")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   drivers/mtd/ubi/vtbl.c |  6 ++++
>   test/dm/ubi.c          | 70 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 76 insertions(+)

Thanks (for your whole patchset, nice findings)!

checkpatch is clean on all six, they apply and build fine, and I ran
the sandbox tests, both new ones pass, started a CI run...

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
