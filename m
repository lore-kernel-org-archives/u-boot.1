Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB2CC5B572
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 17:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B21B40697;
	Tue, 11 Aug 2026 17:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H20zqaGPebBQ; Tue, 11 Aug 2026 17:04:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D10940661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786467863;
	bh=2EKGPimx7RX7TUFgft9rwmSLIKxjoEdcEc6tJMk3NjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z7FdTdGmfqUBJOXpQNfgnc8lqjXOsbmFCmqx1PYwEIneXTpOziHEUMKhov+boFkHk
	 lTMHlMLNsj6kDRe7MXF/dcagLQc1JvQw8jJBaxiYBiBcPxCIShqrcoE5G8ZjmO79Xi
	 ntRNlsy1DQfvom9w66JTrz91uv1Mb2zA6ZPuI00BumGid+MfBzz2/YsH54EKnq786C
	 CM/Bqp7voWdGrjBxv0oNLO3pZltvLZngwKKfdsTISDsxovwmAI7BOPWDKtf3ecy4Qs
	 ej+aa3GiRzg/evuPkClv2D5LR9rbqYUQCOtSKd2AF6biinzgyd2R0k2NYzY8rRdJ2B
	 ng059SbPQ76wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D10940661;
	Tue, 11 Aug 2026 17:04:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D91C218
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 17:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F5A940074
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 17:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWv9OcgmfNmX for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 17:04:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7f0c=gf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 11ED4401A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11ED4401A1
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11ED4401A1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 17:04:19 +0000 (UTC)
X-Forward-Email-ID: 6a7b55b797e981d4a30745d2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <efaf0f4f-9c9f-4798-9ecd-52b45443e64b@kwiboo.se>
Date: Tue, 11 Aug 2026 19:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: image-fdt: suppress spurious error on expected
 reservation failures
To: Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp
 <rs@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
References: <20260810-suppress-fdt-res-error-v1-1-e9641eb0aadb@oss.qualcomm.com>
 <20260810181637.GC1160436@bill-the-cat>
 <129bccc0-d5fc-42b6-bcaa-ba3a34ad9afe@oss.qualcomm.com>
 <20260811164342.GJ1160436@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260811164342.GJ1160436@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786467859;
 bh=2EKGPimx7RX7TUFgft9rwmSLIKxjoEdcEc6tJMk3NjQ=;
 b=ysl6DoYjPZ1iIcws3Ba/4VMU2JNCTK4rP/js9yNVxAWBwR4MazH/+XWm3cgxTrQ18MpeJqaKU
 /oq852S1/H73o4pp89VCEVZJOfgjvHFTu4O8d3vqy/6zzllVed65JwODe5magexFs9Bprz3yIWX
 0BBJcWxvqBkjiz98h7VRmnoC7hfc9JPu/G+X3PFHxwOzx2cxnLVjq2Yx90ES2v7i08D3U22L600
 sJJCiJXZE4ngDqSnmrsV89nK8H3xHTzllQnTIgpxjS/6GDZzKdwxFp8tzEdDslav/em5Qyke7hI
 UWQUDVLWxCUkFkkk/aYDHxdKCGVILYjFsOvlAat49djg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=ysl6DoYj
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On 8/11/2026 6:43 PM, Tom Rini wrote:
> On Tue, Aug 11, 2026 at 09:57:52AM +0530, Balaji Selvanathan wrote:
>> Hi Tom,
>>
>> On 8/10/2026 11:46 PM, Tom Rini wrote:
>>> On Mon, Aug 10, 2026 at 03:04:53PM +0530, Balaji Selvanathan wrote:
>>>
>>>> Before commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb
>>>> reservations"), boot_fdt_handle_region() filtered out -EEXIST and
>>>> -EINVAL when reserving an FDT memory region, treating both as benign.
>>>> That commit added the free/reserve toggle but dropped the filter, so
>>>> these now print as errors.
>>>>
>>>> -EINVAL in particular is expected: when a reserved-memory region falls
>>>> outside the available memory LMB knows about, _lmb_alloc_addr() returns
>>>> -EINVAL. This happens when a carve-out described in the kernel DT lies
>>>> in a range the platform does not report as usable RAM, so its
>>>> reservation fails with -EINVAL and prints:
>>>>
>>>>    ERROR: reserving fdt memory region failed (addr=91a80000 size=80000 flags=2): -22
>>>>
>>>> on an otherwise clean boot. The region is still described in the
>>>> kernel DT and Linux reserves it itself, so U-Boot failing to track it
>>>> in LMB is harmless.
>>>>
>>>> Restore the old filter, scoped to the reserve path: print the error
>>>> only when freeing, or when a reservation fails with something other
>>>> than -EEXIST or -EINVAL. The "free ||" guard keeps free-path failures
>>>> always visible.
>>>>
>>>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> This is the same as:
>>> https://patchwork.ozlabs.org/project/uboot/patch/20260627204851.1151419-1-jonas@kwiboo.se/
>>> So I've added people from that thread to this one.
>>>
>>> It seems to me like the last message there wasn't quite everyone being
>>> in agreement on the next step, so, what is required next at this point?
>>> This is clearly a problem in some cases, in terms of "scary" message to
>>> the user which isn't meaningful.
>>
>> AFAIK, lmb_alloc_mem returns -EINVAL for 2 reasons: a NULL addr pointer, and
>> "the region isn't part of the available LMB map" (_lmb_alloc_addr()).
>>
>> In boot_fdt_handle_region, I think we always pass a valid &addr and bail
>> early on size 0, so the NULL-pointer -EINVAL can't be hit from here. So
>> -EINVAL could only mean "the region isn't part of the available LMB map" in
>> boot_fdt_handle_region.
>>
>> Maybe we can give "region outside the LMB map" its own return value
>> (-EFAULT) as Rudolph suggested and have boot_fdt_handle_region() ignore that
>> specific case (to make it more clean). That seems like a middle ground.
> 
> OK. I think a patch doing that might help move the discussion forward,
> can you please do so? Thanks.

I have a v2 prepared that changes the return value for both alloc and
free in my outgoing queue, used a different return value but will change
it to EFAULT before I send it out.

Regards,
Jonas

> 

