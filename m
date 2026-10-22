Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A4606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oGRpgAwZ;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=oLU2UMfy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C90360848;
	Thu, 22 Oct 2026 20:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fk_X4AyXk9ue; Thu, 22 Oct 2026 20:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF8BE607E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792699213;
	b=HHpC12QgbGCVA+w7GZN33upwLsIqCNOnhBtW/BE3yMODNx/6Xs8smELVejJXWxhotZrS
	 OZq0jI3G4s5yi+gGdgCNh4dFNwl7wfSffro0ja10kEnTMYhJxHh3uz0Ti9NgG/LR00l0n
	 DVcD80ubhGS8r89aVIrSb5PzlHZt13b/P/be0Svzx1Nba+LMwzcvzW9I1TaR8rv8jxwiT
	 X9V9qo+XLPsTnciFh5kRSXMyUx+WOArTKlRG0gHaVQNCOzer3iuzTDuDI+zDKDBdoPA8D
	 SFheQ5Qojy/TPVL6VEzmYXWVDTTjmQ/5t8ZIwGnNubfl4ednFTcCLMmONfWgXh8e6sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792699213;
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
	bh=Rsfp2AP75O35UTq4W7syypQrLxE59YCz2KxD1N7PaO0=;
	b=k5qIw1AdbzTjldUrUTL4RMUW1013KCFltCgLDbhiJaZ3GEYgNDhXUUg+QZEOeDq+ASQh
	 tKUVBP+SF3ww8r1g8/OVWaENPfUcEaZZS5bIZclf5f8scvt5rZ5RqGtJx9fF9l12rq55z
	 XuPsQ2NwlU279TjvvFKYmKMUQB9nRYBfUVS8mng4UFKVw7n/LPVfbiDnK7MzRkog7RwOy
	 q+JxmY6QrWmp26zmIiSisQZxcGdofEuibzMQfrxbyHoiiAx98PMQG2YbsoRHYVSSLJ0RX
	 owOUsjq3aWoA12JmxUrA3Fme+1rl1slWtYNZvfrkEL2l3nnXvKmm0/ABGotQnWhma1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792699213;
	bh=Rsfp2AP75O35UTq4W7syypQrLxE59YCz2KxD1N7PaO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oGRpgAwZkNmuuRnRUqEYTw+0tI+kff4SbfgM8BWB+jfSkX4Kve0QSWxSU3JNk+5TP
	 27YoGFXGgU/rIcC8F57TVenMokiQLme6jwx3oWpw5TxUkAcqXeADqp9zMuVqEQpmuB
	 PLF26sEhWmFAzUaUzn3irce20tN0NaDD13VVZIXIy78TZgF7ldSUEBTogd7Aw61J/7
	 k6aL7TDInY5uFE2CC0XHOeSimoxd4uzo02cgIWj7fmaCmwmrytm8JXAUjQSH9a/stA
	 G6VAIw3e1lLX7bitPwGopD3esOja9UBXkwB7ON05mSKbgdZKEzDCbX7HBel2AXfqBc
	 YAlEyoOEgwc5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF8BE607E7;
	Thu, 22 Oct 2026 20:00:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C12E43A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3BD24099B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5n2FfTyj3FuG for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 20:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C1C5D4094E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792699209;
 b=SRCPxq1J9tSrhOAum40ZxMBulOJ4jFi+ipsZ44/PNdFDZoCj6SKw8axDWeJC69yr8yNB
 CK7MUTaRbGA+L15fSqmNz/2OgfHt9+ppLq2vNk5k1s8LC3buX6yB6C51qaL0IGV+i+43O
 ZLW2YdPPVrksdAYZO34WH0rmzxEo1T3CpRfJwAcXhJd5JVGS+FalPwJJwE+Ou05Jiik42
 JfMTSIDark5xsA3jDFmVgVnDkolCIqJVrzof/U/ggmcH0xhVKrP2B4fSUj486Q/9kSwaf
 5ChrQp4L2b3mFqkRUjDE3Sh5yU7m2ni/SdflkKQ5wYri4rJNCvfcZ2KshfAqn3RQ5+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792699209;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=Rsfp2AP75O35UTq4W7syypQrLxE59YCz2KxD1N7PaO0=;
 b=l4ygcsFoDn4dWOUiSMKVId374Y/PO+TAEacfP3ZwdpzgJ6gVuqaa6XnEwSi+5kKvi0dr
 g7WHjfTDpwpeZ90Za/PsT2hX7c0pPoNCRhbqaDnypkDxbCvqB3chCvNklCXaclsJR++qP
 VmVUrbgbuJpEvH1+E4yQNeycbqgrh2V5QnuQzyAfQpQeG4bggza7NEw1bj+N91cDBRAIw
 Pw9KqqxPOWqyxRwM3ay+ShcjURxJQvHLIi289pVaBi5Al7XZTfC7FPBzUA0xEL1LzniDr
 NV+ITFHnkkcySDoY/Q9mGDToPKNe2YALED5fN8vEt4xGZG6EPZHNRCmyxOix9JIaqFw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=oLU2UMfy; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=107d=in=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=oLU2UMfy
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1C5D4094E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1792699207;
 bh=Rsfp2AP75O35UTq4W7syypQrLxE59YCz2KxD1N7PaO0=;
 b=oLU2UMfyyICB5H3JPL1eJBr2XhTEoJxwGf7nL5WaNO2qgmkM1MC/1xldkVyF6tmSgTr1rVoLH
 Wf1gE+QWFOyUaRLtijXUU/av7jAx+cAWtNe6My0qP0uTe9DrRuWYy3IH4zFdieOLShRD9Dc6h1R
 qdKJxGD4blLzipmoIgyCC9/LabXWyTa9Ju7I8fFHTV5Het0ej+EeXjmYXC48EcM5S83AfPXgZHN
 FV9VYYJzLVnFVx/yyvOW8CfbA0w5Q7oL3ZA4covSu5GXaOZconB3MV3bxk5QqAjdD1vFI8/NOMI
 NM3B/xgQL8/pAoljUg2Vrkf/4wQ5AxhFUW6KUiyF/CPg==
X-Forward-Email-ID: 6ada6b43fab43371f369e54e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.9
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <322a4e95-2c3d-4a84-8b57-3b078f9ffcde@kwiboo.se>
Date: Thu, 22 Oct 2026 22:00:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
To: Alexey Charkov <alchark@flipper.net>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
 <7a91e605-33b0-4f4f-9789-d10be821d0cc@kwiboo.se>
 <CAKTNdwG22u_51cBLbu3wufBdB9ojSQqGMPMG58x-Nk7u_xC6sg@mail.gmail.com>
 <a451ef1e-abb6-453c-b146-90d64f24f5ab@kwiboo.se>
 <CAKTNdwHMW4HyfhSWkT241URB4H6JMg1MCt1-VOcUsufgm=So=g@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAKTNdwHMW4HyfhSWkT241URB4H6JMg1MCt1-VOcUsufgm=So=g@mail.gmail.com>
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

On 10/21/2026 6:17 AM, Alexey Charkov wrote:
> On Tue, Oct 20, 2026 at 10:41 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Alexey,
>>
>> On 10/20/2026 8:01 PM, Alexey Charkov wrote:
>>> Hi Jonas,
>>>
>>> On Tue, Oct 20, 2026 at 9:47 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> Hi Alexey,
>>>>
>>>> On 10/20/2026 6:41 PM, Alexey Charkov wrote:
>>>>> No in-tree board picks a compression for U-Boot proper, so CI never
>>>>> builds the compressed path of the Rockchip FIT, nor links zstd into an
>>>>> arm64 SPL.
>>>>>
>>>>> Turn it on for the generic RK3576 image, at the highest level, which
>>>>> shrinks the payload from 690KB to 296KB. The image is meant to boot from
>>>>> whatever medium the board has, so this suits it, and its SPL heap and
>>>>> SYS_LOAD_ADDR already leave the decompressor room to work.
>>>>>
>>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>>>> ---
>>>>>  configs/generic-rk3576_defconfig | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
>>>>> index 5e25653820c2..dec4364876b6 100644
>>>>> --- a/configs/generic-rk3576_defconfig
>>>>> +++ b/configs/generic-rk3576_defconfig
>>>>> @@ -9,6 +9,8 @@ CONFIG_DEBUG_UART_BASE=0x2AD40000
>>>>>  CONFIG_DEBUG_UART_CLOCK=24000000
>>>>>  CONFIG_DEBUG_UART=y
>>>>>  # CONFIG_BOOTMETH_VBE is not set
>>>>> +CONFIG_SPL_FIT_UBOOT_COMP_ZSTD=y
>>>>> +CONFIG_SPL_FIT_UBOOT_COMP_LEVEL=19
>>>>
>>>> I do not like this, it breaks consistency with the other RK generic
>>>> targets, which are meant to be as lean and bare minimum as possible, not
>>>> a playground for testing features, we have sandbox for that ;-)
>>>>
>>>> Please enable this feature on a real target, not a target meant for
>>>> basic board bring up and recovery.
>>>
>>> It is in fact quite helpful for recovery workflows, because it
>>> massively reduces the size of the maskrom 0x472 payload, which as you
>>> are well aware is quite a thorn in the backside, given the boot ROM
>>> peculiarities. My reasoning is that the generic board build will be
>>> much more likely used over maskrom than flashed to storage, unlike all
>>> the other targets, so enabling compression here is pretty much a
>>> no-regret move. As long as it works, of course, but that's what we
>>> have tests for (and CI).
>>
>> The generic targets are likely used written to storage much more than
>> recovery or loaded from maskrom, they are typically used by Openwrt and
>> Armbian for new board targets until proper board support has landed in
>> upstream Linux and U-Boot.
>>
>> I can understand the idea and may possible have been on-board if all RK
>> generic targets were changed and tested. The inconsistency among the
>> targets are my biggest concern, secondary that this adds more code that
>> potentially can fail during runtime.
> 
> I could enable this on other generic targets, too, but my sample only
> includes an embarrassing number of different RK3576 boards and not
> other SoC versions, so testing it directly is a challenge for me.

I would likely NAK any change to enable new Kconfig options on any or
all RK generic targets. Please see the generic RK targets as a superset
of bare minimum required to boot a board, nothing more or less. If your
dedicated board target fails to boot the generic target should continue
to have a high chance of working on same board.

> 
> On the potential failures - true, but see my point above regarding
> tests, which I believe still stands :)
> 
> I'm not particularly attached to enabling the option on the generic
> board specifically; I just thought it could help people since it helps
> my use cases.

Sorry, the generic RK targets are not the correct target for this (or
other) nice to have feature, they should only include the very bare
minimum options required to boot.

If these options where enabled at SoC level I would likely not have
cared as much or at all as I typically value consistency above function.

> 
>> I added these generic targets to have safe and proven defaults, because
>> the evb targets that typically could be used for similar purposes
>> started to grew in features, and I really do not want the same thing
>> happen to these targets. Boot speed for the generic targets is also
>> not a priority.
>>
>>> FWIW, I'm also using Zstd decompression in SPL on the Flipper One with
>>> Falcon payloads, but it's not upstream yet.
>>
>> Maybe you can add one of the rk3576-evb boards as a target in mean time
>> and test on such target?
> 
> I ran this code on a RK3576 EVB1, too. Maybe it's time to upstream its
> defconfig after all. Along with my local patch patch moving the
> SYS_LOAD_ADDR to a less overlapping location across existing RK3576
> boards.

Sounds good, please upstream support for your evaluation board, it
should be a perfect target for testing new Kconfig options due to its
intended purpose. I do not have access to any RK evaluation boards,
otherwise support already would have been upstream ;-)

If SYS_LOAD_ADDR needs to change on RK3576, it likely also should be
changed on other RK SoC targets that use ROCKCHIP_COMMON_STACK_ADDR=y.

Regards,
Jonas

> 
> Best regards,
> Alexey

