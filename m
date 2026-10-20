Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D549606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=maH5oYNc;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=mrHIhi6W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6589810F1;
	Tue, 20 Oct 2026 18:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7t7YtMpqIrmj; Tue, 20 Oct 2026 18:41:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA560810EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792521679;
	b=EIHikxeV3czmvUgXn6Tiw3yn1Kc1V4VcMFIOMtvrPlogSO6kFptJPJxdYTX2fYP2hHtf
	 oPICdU92DUv20Lbvj2YPhbxZW9g7SVJpLEoXmhZmRUbPaFZG/uTbOBde5uTxLXJBFmIjT
	 QvGozJrwRvzfYUNz4LL7LPg/K1WX2V3hnYzkDXfJPsYglpgEWSFLsnSrcdcpkB3PHi9B8
	 ShaTmQCO+3zaR+q7CKdy4HF8pZYhhyWT7dDp6AXqTep7v/HmZ89F7BNUORvxubtR7QMQ0
	 ZenKuQQcL40R6QE82SX+laLPKlqzKNupmS76yFfS8oyuYQywdv9bJipSzcl83oTkI2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792521679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O2lTbzPB5+UDxmQ6hAI2KA0V6E1IXhuUIb325GdKIH8=;
	b=HzDEDtHAwNC7WuV+0KTHR3KZYhYFhnbVRIM4LeAwBIVgE/9El6WJgT0QCAAQWaFqAJI3
	 B5uwquUrMJ5gfmun/Ba7mn4XhcvO9PrR4yDmdyAKPlzD3RtswkHjUmzZs1CfgUzK1L2ep
	 cH5jEEWoyLZ0b8yktIl9Yk9+37HxeOyxGi8708I5HP9FDVYieNpEeIrPkprTScsX4ZOwv
	 W0DTESNT3DJ2K/tSfI+fY2z++M4IZjPWocUOnNLbb6rNjk/L8rKmpiDXY8gtzQEM0p0Lr
	 T1RQoDYCXUOfI/Kb5+is7074dwONPDAZFKt0EhmhG6MbzLPrwF+w1joTdjb8b5uvUDQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792521678;
	bh=O2lTbzPB5+UDxmQ6hAI2KA0V6E1IXhuUIb325GdKIH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=maH5oYNc0lvjro4Th5HL3Gs2N4KLyviTOxzZdYCL6LUh4E1J3LAOlRIIlADYstOxZ
	 JCy8Of/qy/70Sa4A4FJHD7yyDGeRQ161hE7m07Yq80rXBYKOhwKIf5NR5wt9zY9mJx
	 IJmY6ZWtAAFvmlD9LJIm3umr7ke/r+Cbj8xOwzytc7/vQBa4FBc/2chCsCvmHfv++K
	 WKXBG9ojce50qZ3dbbyMUTDO5bX34YCAsfIU2n1p0P5x7m21sSDEr9OV9fbyCS1jHS
	 B/fpynqXmr8m3SETTuWMPZcfsHLRch9uS9AaqWp4kj325u8wgyn52zaic6eqOm5RTx
	 3NuKPnNUlYcuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA560810EA;
	Tue, 20 Oct 2026 18:41:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A37A9255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89FC16078A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sQgWZO11MKVq for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 18:41:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B84876075F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792521676;
 b=OYARpLFMnYGRB+omzkQNM9n2/ofe+p19xTpgr1Xwg+NyL6kf7++Rx8dH3O/FqQG+Zc6i
 dWg5X3ak8MfSMM1GFycFcVkhRqgJb0IWoFhMLS46+wnFRK7zvk95aJC11Oi3jyYhV2Lga
 4FWX7f4EnUthHnq6iktHWnFNS0JHnblEjosjgditVk5TKFp8OS7zbvZPvkZPc5o73HCAR
 0sCULDDLVJr8dpkOLIwCGaPmXMgTf7enimqCw0Hrrlcp4jHu0QcdG/f2LTZxN4cQVdYMC
 UmsmYZgK5RJ7oNMV1InJKlFPu1fOzGMxVN7izZncm+ClFVD235SEzm2zeBZwjvc7oPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792521676;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=O2lTbzPB5+UDxmQ6hAI2KA0V6E1IXhuUIb325GdKIH8=;
 b=BOpR/cnxcDh8/g3tSn9x5+pauRLgSVCJUED23LItIXsMEKI5UDK+4+3XWRWKy8vqdRHk
 SRpNq5EyV3ObKKiHAroFcm1LzOHSzXKf5T67wKcg8rs7e/jMAIlQX0ni0667rcFfCXCy1
 QoIFqPvRlViK+5zHmbHE7kf3jhXcYioduCkej7tghtiZ2TYS21wuWhVIV6RHNfxQUHCOF
 2n8H5+Z7E1sa7KPOY3XwHAFOxFYCPpxW4hZy89ioXzZ21/Oxq8ko2lpGzXIYoa89DA7LI
 vATIrq/zuDe9xfxMRbSd8vGxkq8aqWQbuTvxsg5lDdTzpOyz12Ejo8MALVmBRajjwWw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=mrHIhi6W; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=118b=il=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=mrHIhi6W
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B84876075F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1792521675;
 bh=O2lTbzPB5+UDxmQ6hAI2KA0V6E1IXhuUIb325GdKIH8=;
 b=mrHIhi6W7NI4g6PwZ2EO2fFnQ3S+cXmLr57LA7NK3K0Dz4eTiQed/8w2+9PkXGb6Gg/lbkrq3
 H01mmp/Hbp2wzyEglYUfMzxismsUbsx9oIipXC1Mndc+6H66cy98h2lJOw3FtVYVmKXM1WaJXmy
 JT6PoQmtYW7JlYwnhwfAxGIABWyZfc56FDHHH7gf7/4iwzrQFPpfCTLuhh50orp2u6myJcBiuz9
 Vc1KE+gtVPu5m5r4KgSuec6d5FlhR7VpAYTa3PXA1Jm+FysvLtm+BfcxuzGRGCHqIgVixDk0oV+
 Jxw7sCSinhIybjdIY066yMIzKHGyTGddZQdCuN/mLJjA==
X-Forward-Email-ID: 6ad7b5cadaa2aaaf7e192871
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a451ef1e-abb6-453c-b146-90d64f24f5ab@kwiboo.se>
Date: Tue, 20 Oct 2026 20:41:12 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
 <7a91e605-33b0-4f4f-9789-d10be821d0cc@kwiboo.se>
 <CAKTNdwG22u_51cBLbu3wufBdB9ojSQqGMPMG58x-Nk7u_xC6sg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAKTNdwG22u_51cBLbu3wufBdB9ojSQqGMPMG58x-Nk7u_xC6sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/2026 8:01 PM, Alexey Charkov wrote:
> Hi Jonas,
> 
> On Tue, Oct 20, 2026 at 9:47 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Alexey,
>>
>> On 10/20/2026 6:41 PM, Alexey Charkov wrote:
>>> No in-tree board picks a compression for U-Boot proper, so CI never
>>> builds the compressed path of the Rockchip FIT, nor links zstd into an
>>> arm64 SPL.
>>>
>>> Turn it on for the generic RK3576 image, at the highest level, which
>>> shrinks the payload from 690KB to 296KB. The image is meant to boot from
>>> whatever medium the board has, so this suits it, and its SPL heap and
>>> SYS_LOAD_ADDR already leave the decompressor room to work.
>>>
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>  configs/generic-rk3576_defconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
>>> index 5e25653820c2..dec4364876b6 100644
>>> --- a/configs/generic-rk3576_defconfig
>>> +++ b/configs/generic-rk3576_defconfig
>>> @@ -9,6 +9,8 @@ CONFIG_DEBUG_UART_BASE=0x2AD40000
>>>  CONFIG_DEBUG_UART_CLOCK=24000000
>>>  CONFIG_DEBUG_UART=y
>>>  # CONFIG_BOOTMETH_VBE is not set
>>> +CONFIG_SPL_FIT_UBOOT_COMP_ZSTD=y
>>> +CONFIG_SPL_FIT_UBOOT_COMP_LEVEL=19
>>
>> I do not like this, it breaks consistency with the other RK generic
>> targets, which are meant to be as lean and bare minimum as possible, not
>> a playground for testing features, we have sandbox for that ;-)
>>
>> Please enable this feature on a real target, not a target meant for
>> basic board bring up and recovery.
> 
> It is in fact quite helpful for recovery workflows, because it
> massively reduces the size of the maskrom 0x472 payload, which as you
> are well aware is quite a thorn in the backside, given the boot ROM
> peculiarities. My reasoning is that the generic board build will be
> much more likely used over maskrom than flashed to storage, unlike all
> the other targets, so enabling compression here is pretty much a
> no-regret move. As long as it works, of course, but that's what we
> have tests for (and CI).

The generic targets are likely used written to storage much more than
recovery or loaded from maskrom, they are typically used by Openwrt and
Armbian for new board targets until proper board support has landed in
upstream Linux and U-Boot.

I can understand the idea and may possible have been on-board if all RK
generic targets were changed and tested. The inconsistency among the
targets are my biggest concern, secondary that this adds more code that
potentially can fail during runtime.

I added these generic targets to have safe and proven defaults, because
the evb targets that typically could be used for similar purposes
started to grew in features, and I really do not want the same thing
happen to these targets. Boot speed for the generic targets is also
not a priority.

> FWIW, I'm also using Zstd decompression in SPL on the Flipper One with
> Falcon payloads, but it's not upstream yet.

Maybe you can add one of the rk3576-evb boards as a target in mean time
and test on such target?

Regards,
Jonas

> 
> Best regards,
> Alexey

