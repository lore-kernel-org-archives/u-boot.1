Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC5606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K9SYx6rI;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=RqRlpbKI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 330A780E10;
	Wed, 28 Oct 2026 12:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eidOuLxO_vj6; Wed, 28 Oct 2026 12:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CA3280DD2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189102;
	b=OMBCg3xsc8njcL6y3mi4X9U4KsLgeZxY3lUEzFAKlFz3l5D45XReyvOYziDqM3BJH8BP
	 cQTfgLkgWdY4ja374pveffkXKZnUolxJZ5PGUppDpqLJi5+RWNzmSei5sQH+4H/IfkHuY
	 5CwR2mkibzMlNjk65xYSpDL8qJYSwutxbQsutWvXx2teS9JNOSFQptqBDv05wQcJrfVnp
	 DFwjCGG75SvTS7331QBhTcPxcS60h062jMfbKxHNAmJghpDqK/c2Uhqk84qlgOcbEJu1K
	 HrIrqYeTQHtEC2aSz1AswK5rF+VoRxs6larux5kkJOI+oIw4EDOYeDHzaL+1rhDYCHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jGXjStePs8dLIi17uHVa98dzSdLnYJxw6mfLNWhcWJ0=;
	b=YRsbzSZ1r3ik6j1nliV8VCFc/5i1svFpc+sGB4iewr+ViQF3kc89T6m1x9LJuiU8Ruer
	 pJws+sNlruV8IXIYylPgk3YGF16Vj0btj6YToKF96NBABbI9PJTJUbmvAlBN/2EIlNarD
	 877PjIS985yo7WfctBunIrO3WUDmAzdznXfiu9f1VIyVqi7b6ZBbRvRDtTodVD6mQD4z7
	 gQABydK/uIYJuemx4402s7juHe2CfOZ3hM11dv7mBt/0QVnM1gMdfMw114xAjxLSI0+gj
	 OszwB6P+maZeo5FZLtHPXTrOsRC89N5vIlxIUzd1Im4O4q0M1LSHvgZhjLoa96lQYvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189102;
	bh=jGXjStePs8dLIi17uHVa98dzSdLnYJxw6mfLNWhcWJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9SYx6rI7biedj6WTgR6WtvYwxczSXfUN0je/tiqp6XH7k2ON64NXns55NFUTWX7c
	 pPcWGY7RxGrpFCrtgNLTQfNbYD9aW0d8ipZ/bRGV8yhs7ZiwiHz4EhTUYdGWmTj+ep
	 ltT/Qy1sQjmnA6HhE1ZjQ+smLswMwG+r6WQqMkybYc972ufvYP8SVTAqtSslo7OXxa
	 /hbAq/ODPcDgOnn9/RgA03w6ur+J7sAQjAZSQT04SRlJnm17cS/6i2LQOJWqRPCodv
	 EezwtsEg0c2/FbIn8I+Qfi2X9F63tNrGAFYFUxsc/6GvEJaB99J+RZGf4TzIsks2Mq
	 PcCulIaYR3Qjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CA3280DD2;
	Wed, 28 Oct 2026 12:05:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1800B2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03499400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9LGXfoDKMYnA for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A3DAF40087
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::8fad"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189100;
 b=QRnpMD6P3sVmeK6mFRy1ow3GNsTXbMbksTHp1lUQPJ06/kJjpWBpdnrh9QRJyMZXMVxx
 3UmML2bnUlM+UAeiSiNrg9x3K8hBp6G9DIJwF+o2fhXX3stb25od/lqyTijTkpKjN33SP
 Il9JhINUNRIA7dcd6oF3XauTPIEJSVWG6Gf/jTOgcAyxjWUHndZAsmrgsU368Wqpkr0cf
 EAmIwCWurKDWg3tGEC8Jqh+PAuo8zcfRvVPF/j9JDAibLNa+KTOUhGDzChtAcBZ9kAMdT
 2eNTgTX94kUi7FbsBdQv1gBKBh/5dDbc7q6RWfzq/MeaV90ciSOtHT1APcfAC0tymQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189100;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=jGXjStePs8dLIi17uHVa98dzSdLnYJxw6mfLNWhcWJ0=;
 b=cMn22ss4um1lnxvb1RYhIYEdveYm0bTOPH9BRrXh2+8/h56HSKPlDpjhoHEEMHEgtdev
 KSmKHpFn9SUpcQoBcFIrRQIwN6TnpOVFU0WNZ83SNjlCwZPoPzWm50oC4aNFoSctNlCRD
 c3gRaYYiU2VkmpuZuzqHCSLTbvP5OBFzJt1uPTG044hPA2AJ8FmpkzqZzxDmk5yTBVWKy
 dfN9NC3RXX5MnOX78+jo8zGHzDSsCEz7Wv24/DrC7jQeA1z6OkWoFSylAoPRSm8GWZGNM
 pavJPRsEgxncl1iGFQb6X9ccRfWOV05xUxtRvye4JCTimD2QAiTFM6bodz6uzF6UqRA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=RqRlpbKI; 
 arc=none smtp.remote-ip="2001:1600:19:d548::8fad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::8fad; helo=smtp-8fad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=RqRlpbKI
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::8fad])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3DAF40087
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:04:56 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jF5df3fNNz1RbS;
 Wed, 28 Oct 2026 13:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793189094;
 bh=jGXjStePs8dLIi17uHVa98dzSdLnYJxw6mfLNWhcWJ0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RqRlpbKInKXKzj4jwjr8KA36gQUIp83b3vSUN2q68Sl9tfTZ/35CA8dtjMl9chQ8T
 UX1AF7AV6NEoDW1BaqjRGSXTh7jN0YfAoqfuoROi8A0c8//aguUPYqC2gsu7isPGRz
 t1QiytiI+7UrIfmjOtALJIydxPmnG3NRM/yBn8rZQIiHzfjLHh/hVkpzRPxDJprBnE
 3/RLWFTznIRF1gFBOe68XTKxSrsCpCRAWagUC/fU9IZ1DbafGiefWoHJDGi1rWe3Kl
 8pyzCCFiberccoF4/nHzDffH2cOqtQbBlQP7zwqGBV05O9bd33aIraJUU04k5CGkmX
 smWTD3jfAG+zg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jF5dc6fhpzmHb; Wed, 28 Oct 2026 13:04:52 +0100 (CET)
Message-ID: <ede0b6ac-69f3-42f7-afb0-650ac1783671@0leil.net>
Date: Wed, 28 Oct 2026 13:04:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] lib: Let the decompressors use unaligned loads if
 platform allows
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Vincent Jardin
 <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>,
 Cole Munz <Munzzyy1@proton.me>, Kever Yang <kever.yang@rock-chips.com>
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
 <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
 <9e0762c4-57b1-4e61-adb5-32031da77c93@0leil.net>
 <CAKTNdwFVRTjq14Sjn8MdAG4DCWTmDPs-81qfsJGcCNo_Ay+-tw@mail.gmail.com>
 <1c6f6e9c-9bf0-4117-9999-79143ac12281@0leil.net>
 <CAKTNdwFz1okf_8jstBVq7juUWLHwqiUW2L-QHxMzEPJ=CyByHg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAKTNdwFz1okf_8jstBVq7juUWLHwqiUW2L-QHxMzEPJ=CyByHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Alexey,

On 10/22/26 2:46 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Fri, Oct 16, 2026 at 2:16 PM Quentin Schulz <u-boot@0leil.net> wrote:
>>
>> Hi Alexey,
>>
>> On 10/16/26 11:58 AM, Alexey Charkov wrote:
>>> Hi Quentin,
>>>
>>> On Fri, Oct 16, 2026 at 1:06 PM Quentin Schulz <u-boot@0leil.net> wrote:
>>>>
>>>> Hi Alexey,
>>>>
>>>> On 10/2/26 12:04 PM, Alexey Charkov wrote:
[...]
>>>>> +     bool
>>>>> +     help
>>>>> +       Assume that an unaligned access cannot fault by the time U-Boot
>>>>> +       proper unpacks an image, and build the decompression libraries
>>>>> +       without the architecture's strict-alignment flag on that basis.
>>>>> +
>>>>> +       Architectures whose unaligned accesses fault while the MMU is off
>>>>> +       pass such a flag to everything, which makes the compiler assemble
>>>>> +       each wide unaligned load out of single bytes. That is both slower
>>>>> +       and larger, and a decompressor refilling its bit buffer in machine
>>>>> +       words can spend up to four times as long for it.
>>>>> +
>>>>> +       The assumption holds only once the MMU is on, which on most
>>>>> +       platforms has not happened by the time an image is unpacked, and
>>>>> +       nothing checks it. Select it from code which enables the MMU
>>>>
>>>> Crazy idea, but should we add a flag that specifies whether the MMU (and
>>>> dcache?) has been set up, and then read that flag in places where we
>>>> have this assumption? Then we could at least clearly hard fail on this
>>>> flag not being set and tell the user something went wrong before the
>>>> system does a HW fault by itself?
>>>
>>> Do you mean a runtime flag? I'm afraid that will add more global state
>>> affecting all platforms, and some platforms with tight SPL size
>>> requirements will not love it.
>>>
>>
>> gd->flags with a new flag in enum gd_flags?
> 
> I gave it some further thought, and after all I don't think adding a
> global flag with a separate panic adds much. If the processor runs
> into an unaligned load in a context where it cannot work, it will
> loudly fail with a synchronous abort pointing at the unaligned access
> exception. It won't silently skip over it, corrupt data, or do
> anything of that sort. So it is pretty much the same as a panic, and
> it will occur at exactly the offending location, so the program
> counter will point directly at the offending instruction for
> debugging, all with no extra code.
> 

Well, yes but this is assuming that code compiled without -mstrict-align 
will *always* be unaligned, which I don't know is true. For some 
additional context, we've had a number of issues with the Device Tree 
blob not being 8B aligned for example, and it wouldn't always be the 
case which made things "fun" to debug :)

I think there's value in reliably crashing the board if we are in a 
scenario we expect possible failures. Debugging a random unaligned issue 
may prove difficult as adding debug may move code around and have it 
align again.

Cheers,
Quentin
