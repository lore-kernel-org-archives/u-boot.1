Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F60606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zg47k/L4;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=l2N+tbHn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8933440819;
	Tue, 27 Oct 2026 17:42:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elxjNmIdSMKS; Tue, 27 Oct 2026 17:42:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 954664065B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793122961;
	b=P7A3cn8k6LmvrIh2E1fgj34J5RPq9SegVikCm0hjoAzadrR3GJWB5bHr7ypOijSV/hmD
	 DasZYQ+Xpye7/78iCxzF81YMRVBhyPzms+vyQ9r8KCIo6qpsI1uum0zxsTO+yqtKFIn9E
	 MTHiW+OH9heSlxZGkYrSppd7SXtc7EyWfnYgjwmsYR6gW2DITH1Oo9fWpAUZLcWrL3F0A
	 J483knlYqeyrYJNlr/Wl7iIXeJM9r5MOnyJ9TABmZsRscF0LY7RixzXNbd/RV6f2vHgMo
	 uwX/ACRpiFyCgKinapRf2On/ldNMyqx+T2ATm8gsTJY8MFOBB5IwVyGeThKDKiK2ehQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793122961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bK5Fn6NzEKeI3G7T7vVzoJPcmkosv/tt18J4cu0Nf6Y=;
	b=FTH28ya80EldSGptanSAluIo7igPJI97UtOfJYT+ZFha5JNj6JvuJomlMlrTbT+mdJr4
	 0hNAV7G7sijX/hNSpX86BV9sIBKIU8G+HBAkeakH1M6j7P03cq5/BIXL9ZAX5YQY2q1Ya
	 +Q476I6bMLESPghH1wXnd3KcSMaQHA6I3XlzEnbYnSuOoV2Qh/LYq/sXExBqA/GHNx78O
	 wo+fKs4fWBY/sWd4Oo2SKjO7U3dzEw9W+P7snGHA8qc3dtFhmL4v3MkmPyEMUHMiyOXaK
	 tXgP8p8+JkAHre9tCd9ZQ0bBqmK5K+y0fqniidbm7ccnBzbbEY4dVjj7lrWSoLdSzfA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793122961;
	bh=bK5Fn6NzEKeI3G7T7vVzoJPcmkosv/tt18J4cu0Nf6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zg47k/L438xl1dJVOeshmCfTVBYt65V//5k4HTvma6wIQ+9nH33xyDlhno4jZjlLS
	 qsbEpNScaBRdOfXtAPb7CkP2k75/auymIas38mNZ4EW9//1wYsOEjEDJFnZQE0HISt
	 rHAuHKAZpIbGKBQFV6Xs8NnO01XYTaEGnqG7kccN2S0DQU8YvjHFqiR7/BizMiCuIU
	 8RY0JUzt+LZnPN4ZUTYv1iM61c9qmMhDicCR+jE0zvJ8uJVuYHBrImJyG+HQk+nnDe
	 em5pke/8mq12ciKNLRTWfjVV5g1qGYB3n/ZGzx3NprAVJORYy81bqixny82v/sIlX0
	 bjcaDXSj+QwcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 954664065B;
	Tue, 27 Oct 2026 17:42:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F1C5473
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 352B080F7F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:42:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhsvli4M9msA for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:42:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F120980EB3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:38e0::190a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793122957;
 b=rHDuebMfQQGsISNHG3y8CoEiFEB6cK6NhOAbkUt8t1m9iEJc8Gn/p1OBZ2adBH3IQ6hv
 qpdvDON/hICN3UXxGJVvtp1AEVS7DETna+EEYFnukvS67X3OEkWCj14uYVB2GX7u8mfI2
 o3KHahkUl2JhTS5ach0ZjaYQcRb2QgogpV5XO0I0IOSuKU0FwA+Oa8FzpJfSEgk6ZYTaQ
 a4DFNtnfuZMzt34sGQNtdDRUQCUG+hzMbVn8keqmlg5N+mOJc0WRPi77kuxY+OMR1Tpn9
 Lq2+VTQYHg690z5LobL3UlEkSn+lIs+CaBewPDss+ymzR0b/n/27fVyu4ADrQhmkHsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793122957;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=bK5Fn6NzEKeI3G7T7vVzoJPcmkosv/tt18J4cu0Nf6Y=;
 b=F5X6ZfaUev1UfMFzQgQruIP6L+YxkB7SipZmjhyY/TmafbK0063eckd1QkB2yTyLE+x5
 mCeujANmQp50qFLxEDEPS26/7cc0jA+ZkLaWeAqQnyfgmMweVYPOtZ3cScR5iyGn+GP7T
 nJ4dOXxbLQXMPH10+tlr+Pb7/4ayqSSrR0qgpszcTmMJZIrba9Ox6/IJaP2q6gzFxbYNp
 77fxWYlKffRNB4sxpUkZjHZp0F9vSP7AkmMoyJggmZ9Lw70gs0GFTM+uQQ+ISVdnQesAs
 hilgGv1v34JBVqLXtwg9zGvB/t5P+zcAnwEftKFzdHmubIHMygCRfq38Ui9qtXjITbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=l2N+tbHn; 
 arc=none smtp.remote-ip="2001:1600:19:38e0::190a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::190a; helo=smtp-190a.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=l2N+tbHn
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::190a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F120980EB3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:42:35 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jDd9j0HPdz1l8N;
 Tue, 27 Oct 2026 18:42:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793122952;
 bh=bK5Fn6NzEKeI3G7T7vVzoJPcmkosv/tt18J4cu0Nf6Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l2N+tbHnQlEPm0dPXFf0KadR+T5X19EBfRM9Rqkts+aC/cerS/GJVOcq/gsfD2096
 upYIleuARrBI5hxb0vRmdtcydHVF2eGG9wB2P/bhVMfqzNJDXZCJeh9lv41n7KXsAR
 nWXz6iN/eqFc0fhnuDjatU2du4KD4yqWVR4zmGR56u7ZniMXKWWkW5sKeEpF8OfNkL
 R+NxQLdajawQGD7NYSr/p4DfxA1olrTfWhNPu0827HFsaz/GORt9hamRUecQJfj0sl
 98NRetJHns4gTcWFzG0ioH6BdTuI2iFQZcrK2hi0hjbdI8qW10DAmGEOxTDJ63UUZ5
 qJO01KlILRhIA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jDd9h10wJzvjc; Tue, 27 Oct 2026 18:42:32 +0100 (CET)
Message-ID: <d3ec0007-47bc-4e0b-b652-1bc1ba160003@0leil.net>
Date: Tue, 27 Oct 2026 18:42:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: mkimage: Update init code size limit for
 RK3328
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <20261004195853.59863-3-jonas@kwiboo.se>
 <dc849a75-9166-41af-9ba5-abe8a63be884@0leil.net>
 <c59af0e7-a265-4521-8258-01296de5fcf1@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <c59af0e7-a265-4521-8258-01296de5fcf1@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/16/26 11:25 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/16/2026 12:31 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/4/26 9:58 PM, Jonas Karlman wrote:
>>> The RK3328 has 36 KiB SRAM at [0xff090000, 0xff099000). With 4 KiB of
>>> the initial SRAM typically reserved for BootROM during early boot.
>>>
>>> BootROM will load init code of up to 32 KiB (0x8000 bytes) to address
>>> 0xff091000 in SRAM, before jumping to it.
>>>
>>> BootROM typically jumps to init code with following registers:
>>>
>>>     x0: 00000000 ff091004
>>>     x1: 00000000 32334b52
>>>     x2: 00000000 ff520000
>>>     x3: 00000000 ff500000
>>>
>>>     sp: 00000000 ff090f50
>>>
>>> mkimage is enforcing a 30 KiB init code size limit for RK3328.
>>> However, the BootRAM can load up to 32 KiB of init code.
> 
> s/BootRAM/BootROM/
> 
>>>
>>> Change the init code size limit to 32 KiB using the <size> - <reserved>
>>> pattern to closer match the actual limit of BootROM on RK3328.
>>>
>>
>> Downstream still uses 0x8000 - 0x800 so unless someone from Rockchip
>> confirms this is safe, I would rather not modify what we have today.
> 
> Maybe my commit message was unclear, but I have runtime confirmed that
> BootROM is capable of loading binary code up to 32 KiB from SD-card and
> eMMC and the code was fully functional even when padded so _reset was
> placed at the very end of binary, in the last and lost 2 KiB.
> 
> Most likely the mkimage size limit was used to impose limitations for
> stack and malloc area, very similar to the issue with PX30/RK3326.
> 
> Runtime test consisted of running a minimal <2 KiB TPL binary that only
> initialized DEBUG UART and dumped passed x0-x6/r0-r6 and stack pointer.
> The binary used no malloc area, its stack was pointed to PMU SRAM or at
> half of BootROM reserved stack area, and the binary was .space padded to
> push code to very end of the loaded binary.
> 

How can you be sure that we aren't corrupting the BootROM stack? Between 
TPL and SPL we actually go back to BootROM so code from there run for 
sure after TPL has run.

> I did similar runtime tests on all rk3288/rk33xx/rk35xx/rv11xx SoCs I
> have access to and all current limits in rkcommon.c beside PX30 and
> RK3328 matches the runtime limitations.
> 
> On RK3288 (96 KiB SRAM) we can even load a binary up to full 96 KiB,
> however from SD-card, only current limit of 32 KiB worked.
> 
> Please reconsider and/or hopefully Kever is able to confirm my findings.
> 

I'm not sure we'll get to see Kever much anymore and I don't know who 
exactly we should be asking. I've been told Chaoyi Chen might be a good 
point of contact now, so trying this here.

@Chaoyi, can you confirm we can use 32KiB of SRAM on RK3328? See 
https://lore.kernel.org/u-boot/20261004195853.59863-3-jonas@kwiboo.se/t/#u 
for the whole context.

Cheers,
Quentin
