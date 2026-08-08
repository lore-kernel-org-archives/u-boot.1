Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0864C5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51D0D40597;
	Sun,  9 Aug 2026 01:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZzJYQI275rn; Sun,  9 Aug 2026 01:14:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 789B940582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786238059;
	bh=SCg/MtdFNcBXoCmUvrrgbKY/H6+vAiPrH4EtcoIfLCk=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=s7lMmw7OSZAbLl7MuQg5Tu1zLzPkYhJnbIFXOlg/i6YiUQi7028gCcXcur4FJstf/
	 3dlV7kA0sBgjzr61H8LU1Aq1KBXaR8q8wI9lB6bjwWr/4AYZ4q9ZSQW5mJB0CR9+hp
	 vlpGz8MRIdbngOgIXKxH58W0q7MkP/3kxWhCMP2jeIkTHh+08IsSMdzdnetBT/oBbK
	 8OngT0hNF3wx4vX8Z8PoYPDbIEqVufkRPDHG1RodK4nYW3EIYUmaDqMWuBvVsxz3/0
	 sYAS36tLAc+TfFqIQnBO39QKDs9c8Hc52Qbfz8z556qJFNje/Aljl8OWGY826KmZvg
	 g9KZfxy9tA7/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 789B940582;
	Sun,  9 Aug 2026 01:14:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 773032B6
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6966B400D3
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cTdSgqoRnr60 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:14:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9E8FF40068
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E8FF40068
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E8FF40068
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:14:15 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hHfzn3yKMzMlCF;
 Sun, 09 Aug 2026 03:14:13 +0200 (CEST)
Message-ID: <2eb8a15b-c9d1-47d2-b8b6-da27d711ddb4@mailbox.org>
Date: Sat, 8 Aug 2026 22:01:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] board_f: Call initf_malloc() before fdtdec_setup()
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
 <CAFLszThbzKZWctdWh8B1j2cqACr+9dNVaX_FMkvbHtXkMDnsTg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszThbzKZWctdWh8B1j2cqACr+9dNVaX_FMkvbHtXkMDnsTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 7uhxdkpj8aghi8bd44qk1hxwht6wu3ht
X-MBO-RS-ID: 9e02e2f3b2f5f6e3add
X-Rspamd-Queue-Id: 4hHfzn3yKMzMlCF
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786238053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCg/MtdFNcBXoCmUvrrgbKY/H6+vAiPrH4EtcoIfLCk=;
 b=pgwoRSam3Y1wGf7sYehKmjVWQrg2C9Ki/2vySpQKGZ24mRYyy9fO5b1KokGln4W8lXhhwX
 vOQjMc0+8og4TtpkUoR/qnotqscZV2M+/lH7acCv+hm7G53bwwhUz2PiB7JIFN3F1eYLLm
 0LSADd7OWOTqIF3MDTlPW0+kXvkZWDA1knllt2c2fo10tGZpgIEYR3bKFuEZ9CpZPO9XS3
 +ig4bS4KJavkB1aJx8fjjo93uYGeSrsB5wix25VANo8LMTLAYt5ATQe+Ovfqngqwrc7b8C
 jL/ePZnY3ANHLOL47gnueFsk+gCuRvCJZeWOq25+dYp4ahR9qnbkRlcZST8oig==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786238052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCg/MtdFNcBXoCmUvrrgbKY/H6+vAiPrH4EtcoIfLCk=;
 b=hX9Y8nSqnJUOYA4dYUGA+uAk98vPojMP5e8P+WNMUtFsMM7Rm7+dV1p0KFu4zDLKhhxYCW
 SZCYQoSSbh0W9v6o7IraR2MbA9wlcHtLQ76vqjwNpCYBwGOZnibesJ4btoTSnIwLN3ADm2
 TduWWkekZvAwiiC+y/l0jgLefLMGQwHVN3Xbia8fzM67mY/nZv/oO/pM5FvcUi60rrQbqq
 NEA4NRkthFyA6QOYc708MASCl6r1BAc2ewwTrFGVg0dU0gF4/4hJrJpPu7NV1loo+Sq67N
 eV0mRdalaofqRXKnIJeP23gsxM9WHQqbwyeAoOBkpFHWuFVeSsXWdudhSVldHQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=pgwoRSam; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=hX9Y8nSq
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=hX9Y8nSq;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/8/26 8:17 PM, Simon Glass wrote:

Hello Simon,

> On Tue, 21 Jul 2026 at 13:48, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> In case MULTI_DTB_FIT_GZIP is enabled, fdtdec_setup() does uncompress
>> the compressed DTs in uncompress_blob() using gunzip(), which invokes
>> malloc() internally. The early simple malloc is initialized in board_f
>> initf_malloc() call, which sets up the early simple malloc limit and
>> offset pointer in global data. Currently, the initf_malloc() is called
>> after fdtdec_setup(), which leads to malloc failure in fdtdec_setup()
>> during the gzip decompression, because the early simple malloc is not
>> initialized yet.
>>
>> Call initf_malloc() before fdtdec_setup() to assure fdtdec_setup() can
>> use malloc() during gzip decompression of the DTs.
>>
>> The impact of this change on boot time is negligible, because the
>> initf_malloc() only assigns two fields in global data.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.u-boot-project.org
>> ---
>>   common/board_f.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I'm not keen on reordering this list...
> 
> The offending call is inside uncompress_blob(), which already has a
> non-malloc path - MULTI_DTB_FIT_USER_DEFINED_AREA with
> MULTI_DTB_FIT_USER_DEF_ADDR.

It isn't the allocation of the decompress target that is the problem, it 
is the gunzip() call which internally calls malloc(), cf. commit message 
and lib/gunzip.c gzalloc() usage.

> That is the pattern most boards using
> compressed multi-DTB FIT already use, and it avoids early malloc
> altogether. Could the BTT config not just switch to that and drop the
> board-local initf_malloc() workaround at the same time?

This is unrelated to BTT config.

> Failing that, the per-board workaround in board/liebherr/btt/btt.c is
> ugly but localised. If we really want a generic fix, I would rather
> see uncompress_blob() call initf_malloc() itself when it needs the
> heap, so the ordering constraint stays local to the code that needs
> it. We would need to ensure that malloc() isn't then inited a second
> time. We could always add a flag to gd->boardf, I suppose.
> 
> The reordering also means that malloc cannot be traced - the idea with
> trace is that it is enabled as early as possible. Finally (that I can
> think of), it means that early malloc can never be configured by the
> devicetree (although that is not something we have needed yet).
[...]
