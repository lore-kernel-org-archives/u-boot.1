Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF615C5AC82
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 04:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3B5180C7C;
	Mon, 10 Aug 2026 04:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlMUHs8DyIZi; Mon, 10 Aug 2026 04:42:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDD7080C79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786336958;
	bh=gi/3+IlhipD97R/JbwyOGT/RBcZWc+xRaLQhtoRLj6U=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gpEnGy2VMHobaAfRaTF1GulRR6TJM3qxoX9R20TPGI+X0qA6P9lmf0KeRpRjtzijn
	 em2rzXNaPxaO2o/Hi0ySELKJCTIZsSzyICyWKjDLDePupu4Xhm2xitLmBDk4A9Iz5c
	 GW3qesA/4X0rmYj09yuwGr3f5y9ZbGVAraw1gWx86DShhhMDWgW17R0P3dXzLgSCic
	 W3kUDW66GgFansM9/GGaiI/k7HUYCdPNouZqnZkxpdvOBHNTcSNmProorKIWkJNCcV
	 3YqxeW/2xM/1ZbRdnjLxRzLnvkwKQiRDpJH9pc/M8ZpwlalZ/XBP1frItCPz4dYP3e
	 FRSH1wjiUgegA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDD7080C79;
	Mon, 10 Aug 2026 04:42:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC4BF28A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 04:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B254040097
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 04:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWRKTzyyYjDc for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 04:42:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 81DD340094
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81DD340094
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81DD340094
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 04:42:36 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hJMYj1HW0zKvvh;
 Mon, 10 Aug 2026 06:42:33 +0200 (CEST)
Message-ID: <58052961-ee1b-4ace-809e-e15378bab54b@mailbox.org>
Date: Sun, 9 Aug 2026 20:59:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] board_f: Call initf_malloc() before fdtdec_setup()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
 <CAFLszThbzKZWctdWh8B1j2cqACr+9dNVaX_FMkvbHtXkMDnsTg@mail.gmail.com>
 <2eb8a15b-c9d1-47d2-b8b6-da27d711ddb4@mailbox.org>
 <CAFLszTjUGsM99ffVV+YryDGjB5+YV+T9pnegmbko7vpRySaD2w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszTjUGsM99ffVV+YryDGjB5+YV+T9pnegmbko7vpRySaD2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7ca3c741ce6f0542c29
X-MBO-RS-META: ty3cgtf1i7coyznbczyb7eisk5opghuu
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786336953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gi/3+IlhipD97R/JbwyOGT/RBcZWc+xRaLQhtoRLj6U=;
 b=AOk3tWSw9HWjjmKe56iCDRZO8LaUSlunebpfoqwyTaRoPwPrmokp1uon10f62xH+A1NmuS
 xZlQQSyu5Z9mfQsbPEIntJr/IBLhO3NvVTpKpQiiYRo03Ca9Egj3EI3HTa/nesCRKM0Zks
 /h42LfIXdXLkVJD9q073gsOXiv/fK0fBoxOXuN/4VLPnOe7aNCjcxwERTVutBll5y82/gO
 HWPAapZLDe2tiVhe7Y6XktIZ29My4FW6QUJSqJ4WA8O5Ku8Yyd6XfN47h5Gm/GyNHqnyVC
 LUYz5Wi516CLb4jN6ouSvTRmdl8pdCc3kc2rD+hfWZMLMnmuMmWxD3QmbODe7g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=AOk3tWSw
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

On 8/9/26 6:33 PM, Simon Glass wrote:

Hello Simon,

>>> On Tue, 21 Jul 2026 at 13:48, Marek Vasut
>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>
>>>> In case MULTI_DTB_FIT_GZIP is enabled, fdtdec_setup() does uncompress
>>>> the compressed DTs in uncompress_blob() using gunzip(), which invokes
>>>> malloc() internally. The early simple malloc is initialized in board_f
>>>> initf_malloc() call, which sets up the early simple malloc limit and
>>>> offset pointer in global data. Currently, the initf_malloc() is called
>>>> after fdtdec_setup(), which leads to malloc failure in fdtdec_setup()
>>>> during the gzip decompression, because the early simple malloc is not
>>>> initialized yet.
>>>>
>>>> Call initf_malloc() before fdtdec_setup() to assure fdtdec_setup() can
>>>> use malloc() during gzip decompression of the DTs.
>>>>
>>>> The impact of this change on boot time is negligible, because the
>>>> initf_malloc() only assigns two fields in global data.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Cc: Simon Glass <sjg@chromium.org>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> Cc: u-boot@lists.u-boot-project.org
>>>> ---
>>>>    common/board_f.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> I'm not keen on reordering this list...
>>>
>>> The offending call is inside uncompress_blob(), which already has a
>>> non-malloc path - MULTI_DTB_FIT_USER_DEFINED_AREA with
>>> MULTI_DTB_FIT_USER_DEF_ADDR.
>>
>> It isn't the allocation of the decompress target that is the problem, it
>> is the gunzip() call which internally calls malloc(), cf. commit message
>> and lib/gunzip.c gzalloc() usage.
>>
>>> That is the pattern most boards using
>>> compressed multi-DTB FIT already use, and it avoids early malloc
>>> altogether. Could the BTT config not just switch to that and drop the
>>> board-local initf_malloc() workaround at the same time?
>>
>> This is unrelated to BTT config.
>>
>>> Failing that, the per-board workaround in board/liebherr/btt/btt.c is
>>> ugly but localised. If we really want a generic fix, I would rather
>>> see uncompress_blob() call initf_malloc() itself when it needs the
>>> heap, so the ordering constraint stays local to the code that needs
>>> it. We would need to ensure that malloc() isn't then inited a second
>>> time. We could always add a flag to gd->boardf, I suppose.
>>>
>>> The reordering also means that malloc cannot be traced - the idea with
>>> trace is that it is enabled as early as possible. Finally (that I can
>>> think of), it means that early malloc can never be configured by the
>>> devicetree (although that is not something we have needed yet).
>> [...]
> 
> Ah OK, I see. So in U-Boot proper, before relocation, you have a FIT
> containing multiple gzip-compressed DTBs and you want to select the
> correct one (presumably with a compatible string), then decompress and
> use it.
> 
> Is it possible to do this in SPL instead?

No, there is no SPL on the device I have here.

> If not, it looks like there are two allocations in gzip. One is just
> its state (fixed size so we could pass it in or pass a pointer to a
> local var). The other is its context buffer, which might be 64K or
> more. Did you see my suggested workaround above (call initf_malloc()
> itself)?
I believe there are more than 2 mallocs in the gzip code. Search for 
ZALLOC() macro, that is invoked during decompression, that invokes the 
gzalloc() function from lib/gunzip.c which invokes malloc() too.
