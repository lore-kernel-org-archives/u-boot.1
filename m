Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D128606A327
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e5/b+Utt;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=W2uCrraT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A8CD810DD;
	Sun,  1 Nov 2026 07:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QMuLQnFmSXQI; Sun,  1 Nov 2026 07:45:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2E0C810C2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793519128;
	b=MR/WyddfD34xakqtbHrPUhLhmD3FIBHaE9E4sKpbnB/GOiAGkXsMctLiiTESEgw4DdzY
	 f7ti+Ogkx2w0GeIx95Y74idGOKC38NrmMt+B1tQ2MOqK/4JMJfH4DOm2EAdN7RC77+aYn
	 Y9T0TrRuQ/iqOgNm+PAz/4kO/qio4SwYFKQtYHXD+VlVHjAhKIieMFWf2Iw5Peq0eGkmX
	 iUq8yqW13aKihCuci+ArZvSAFTZR3EHqWAxh/cQgn6Ada2eOieIk/zkSNCjkF4io7rZEg
	 rlTCOASFoQ9ZeOS3fpZU61Vn7pyirv/9GKI+86zBGIW/44x/g8SiVKoY53bFOqdVW5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793519128;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dI4V6Q25+kcivGjgZCvpvwg6OybxSUDpnryOXl3P25w=;
	b=o/als84G4NZrncnzXiFNfJMuonpgOHGCjiFGeV4xJFrqWCis/tvcbBg38GEqePf09QPb
	 +GkiyVX9euKOy0VjTPYJx8KLtlljzsx0opJcyNuOhE6/lEAI640CHxxTb+l+nIxFuPkhO
	 38c1RFrsRCb6JeBXChsOZuhHMAeuk4DjnmiOLyjJrqkAls04UJwe8PTEI6xBpKcJ5Bwre
	 jqufT++8CnN5QD1Ko58Gvyho4kwaVIgiSY8POqSUGtNcPnyY+2RMmj7lzmueovvRPX/zo
	 EA7d8B7nt2hs92tI6dt2w3RgozX7VGYwTnqOt7W9y2W5uDW6o7rQ067lw+nFL107ipA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793519128;
	bh=dI4V6Q25+kcivGjgZCvpvwg6OybxSUDpnryOXl3P25w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e5/b+UttVr1nmEVB2IxRoEh4LIqzUYtYj+UY9X27P+xk7Qg7HGnk7kSvqFdace8m4
	 IAZsNMYzWZTOM77UJcmiu2N//m0zs3DS8sUj6nLkjYHlqlZJti3X35br+O44XOaDhv
	 pYKvnKA/qKK2VTpzkSSriJXt6b/6AViL+WyHaqz72FEuG6j1L9t4vKi0lu0il44B00
	 1VGJmOGn5+1PbDpjSx/3uA97uOrVbnCga7Bf8hxwNmtpupKpW+Rf283JZoXjujkG5N
	 gH2sy4Z32bZdkf43St+7DPKBdNyS+kPcdKllJvvsrXzWYge393F800VlwjGafWxNTH
	 C13JUNLmjkvgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2E0C810C2;
	Sun,  1 Nov 2026 07:45:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D12BE4B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B684C4060E
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MaVbUmf6vu5W for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58EBD4071D
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793519124;
 b=KrkK2GKFcuswdMHRgASuYFEaxsdNIzyGnewNfG+zv2xAUYorvzbMAwILfN1P2GY1zxmg
 kmgyCU4KNf5OqiH266M4tROm1dPK1oAdafD52NWRBlWHSs09mpMaq/jyV7iDKlUrP+KYh
 munUvxtuQzmg0RX96P+7K5Tp2qOA/4N3XPGKBiCKbBVlfKcfwdX05dLReunVuJnlmuKAd
 kb/7onSMwR6bt3vvaOVk7yItlxQtuG4Vimp9sibEtD6v4MKbYXp1mgpJ/ty0HHr6Eo3Tb
 lIVls78djiNuFTJL+kpnvQvZklHk6g7G4xrsf6fpfHuAf6JE6KY5GxFCw5S498q8Ieg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793519124;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:From:To:Cc:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=dI4V6Q25+kcivGjgZCvpvwg6OybxSUDpnryOXl3P25w=;
 b=NmYqAjConV5e/oFIWBdFvbrI4TRuNzbAGN7oX8GkPrQfW+3Gx3iycFFmatUQbjayxMtk
 yf5Z47H9KKyLBykTEr+p0Tji56zuL1pIQccAZ0UpAyj3KrJwt7nyEWeF5CmYY70q2Q2CN
 akRe++kNTS5B76dFXnZ33+Afn3srC7EvfgPb/4KCxO5MSNiV56Nf3TKpGKg7XBvPes4LA
 Pu7euSfsYMc2nog0/J2FQdbiJPXXFXshWVwSf/AhbGwPKApmhnKfgUrf6HaCR5b+Tuqe9
 HyMZfYOiKkAJpvXbL2ErfdGGdJVzJdHBtIfW4+ZuRRumNhqypXGDoxCAp+S8Iobjw/A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=W2uCrraT; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=W2uCrraT
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58EBD4071D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:45:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E719010B7CA; Sun, 01 Nov 2026 08:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793519114;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=dI4V6Q25+kcivGjgZCvpvwg6OybxSUDpnryOXl3P25w=;
 b=W2uCrraThoQh3unM2cXb+0Nec3DS1zSHfny3gwDmjys4yFg2d+vHtnJ/RHP4EZlZc9hMY3
 BYGONwViYt8fu0XM6kgLtGxMN+0psMMaGtgzlgq5pn5YMhHOHoHvl0DPJnRd37WcwPp1yV
 0Lz6NJzRz/t1CAGT+cF1/mtkGYrRmmSyOR2T7IhR6+Q5bbCPwpGC1Vr24+cyO5hpPeC+5X
 aGUkzAr/m2X/Z/jaHupPHY562/jxyzCdAN0AxSZhifPTsqnDauTOHdSbP/hSHmHZzAMJAs
 T7Oh+XpLzJKYnNeTGdQ5aGT1ue9/gxnTNkhKpQuYjNYZlUDXNjS0Lxn9qFqaGw==
Message-ID: <b6c02b95-5a96-d1c5-c516-1e515a7a2878@nabladev.com>
Date: Sun, 1 Nov 2026 08:45:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/4] doc: arch/powerpc: add architecture documentation
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Bradley Morgan <brads@mainlining.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261030020832.26572-1-brads@mainlining.org>
 <179332641005.29622.13964170083166836926.b4-ty@mainlining.org>
 <20261030142436.GK3011578@bill-the-cat>
 <17235E63-E2CD-4B0C-873C-79418E350EE9@mainlining.org>
 <3e11589e-bf81-4172-9bda-e079a1ada057@cherry.de>
 <8e16ca5f-3133-0f0b-fae6-479cb9f00ad0@nabladev.com>
In-Reply-To: <8e16ca5f-3133-0f0b-fae6-479cb9f00ad0@nabladev.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 01.11.26 08:22, Heiko Schocher wrote:
> Hi Quentin,
> 
> On 30.10.26 17:03, Quentin Schulz wrote:
>> Hi Bradley,
>>
>> On 10/30/26 3:40 PM, Bradley Morgan wrote:
>>> On 30 October 2026 14:24:36 GMT, Tom Rini <trini@konsulko.com> wrote:
>>>> On Fri, Oct 30, 2026 at 02:14:08AM +0000, Bradley Morgan wrote:
>>>>> On Fri, 30 Oct 2026 02:08:27 +0000, Bradley Morgan wrote:
>>>>>> There is almost nothing in doc/arch/ for powerpc, so this adds a
>>>> folder
>>>>>> like the x86 one, with four pages:
>>>>>>
>>>>>> - an overview: what the port is, the cpu families, the boards, how to
>>>>>>    build it, the config options people ask about
>>>>>>
>>>>>> - the mpc85xx boot images: the NOR, RAMBOOT and NAND layouts, and the
>>>>>>    CONFIG_SYS_MPC85XX_NO_RESETVEC and SPL/TPL knobs
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Applied to next at u-boot-ppc, Thanks!
>>>>>
>>>>> [1/4] doc: arch/powerpc: add an overview
>>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e6a37f4dfeea
>>>>> [2/4] doc: arch/powerpc: document the mpc85xx boot images
>>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/3287ff140823
>>>>> [3/4] doc: arch/powerpc: add a PBL guide
>>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b74d2c1efaac
>>>>> [4/4] doc: arch/powerpc: add a booting and porting guide
>>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/0851db824add
>>>>
>>>> For non-critical changes, please wait at least a few days. I'm hoping
>>>> that for the documentation stuff you're doing that Heinrich will have a
>>>> chance to look at them, for example.
>>>
>>> Hi, don't panic, I'll drop them if there is issues.
>>>
>>
>> I do not review patches that were already merged, so you guarantee yourself at least one fewer 
>> pair of eyes on your patches. Dropping commits you've said you've merged should really be last 
>> resort, and should be explicitly and publicly communicated, with changes made to their state in 
>> patchwork as well, otherwise we are going to lose patches and people think some patches they found 
>> on the mailing list were merged.
> 
> +1
> 
>> There is almost nothing that requires merging that fast, *especially without reviews*. And if 
>> something requires merging that fast, a lot of eyes should be on it. We've had a case like that a 
>> few months ago with the critical vulnerability for FIT image verification for example and we still 
>> didn't merge that fast.
> 
> +1 !
> 
>> Merging without reviews could be seen as a way to introduce vulnerabilities in the project. The 
>> contributor rules still apply when sending patches even if you are a custodian. There's some grey 
>> area when you're contributing to some area where nobody reviews or maintains, but usually Tom 
>> eventually gets to those I believe. PPC is one of those grey areas because there are so few 
>> contributors and until now no active custodian as far as I understood, so I'm not sure what we are 
>> expecting as a workflow here to be honest. We'll figure something out on the way I guess.
> 
> +1
> 
>> You also sent a v1 at 1:49pm UTC today, then a v2 about an hour later, and merged a few minutes 
>> after. Please wait a few days between versions so people can review the latest version and the ML 
>> doesn't get spammed. If you found issues in your v1 and don't want people to waste time on some 
>> parts you're going to modify anyway in a v2, you can answer to your own mail and specify what 
>> you're going to replace (i.e. doing a review of your own code).
> 
> Thats a no go from my side!
> 
> You can't send your patches after you've already sent them an hour ago.

Sorry, typo. I meant: You can't merge your own patches that fast.

bye,
Heiko
> 
> No human can review your patches within an hour!
> 
> Give people time!
> 
> Most of them are not paid for this!
> 
>>
>>> Also, remind me, is Heinrich the Hitachi guy? I don't remember.
>>>
>>
>> $ grep Heinrich MAINTAINERS
>> M:    Heinrich Schuchardt <xypron.glpk@gmx.de>
>> M:    Heinrich Schuchardt <xypron.glpk@gmx.de>
>> R:    Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>> Cheers,
>> Quentin
> 
> bye,
> Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
