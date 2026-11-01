Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45017606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e71784Mx;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Xr05I6aN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 173B38102A;
	Sun,  1 Nov 2026 07:22:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fKoMaLYQtFb; Sun,  1 Nov 2026 07:22:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0346B8108B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793517741;
	b=TMJAOvX7JZfNefBzE8mNgPacQCOzc9rzS1hBpVOYBdQAJm6svPwmm16Bwf9JAnqLzEkQ
	 FrcccH/zIJHPi80KKiYJh1EWT0A8+FW9OKzGJrsx9cS4mVSaNgicTl11BKKlVtwCaAbAe
	 l9D4vk63tLO68c9e4DV7njCACQXDTrhAecVSioF/nQODxH7wmHbqr0F4XNc+oWqAw0mgF
	 G11JMRe/Kie/TQSWX+IHvCVBC0ZunwOVt5zksr7yyYWFpMh5M45nnsO1pWbRt4QpIS0T9
	 tWjJev1TYgc0+dZpPB6mDe2DqxKgPVFFEoipKW826OSc7eq1la4S+A9bJjJFTWkBBrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793517741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QKpzTSg/SgAekXQkRy0ymlQHzS5uRJbh82Wb1QKm6wk=;
	b=euVi+0q3UrlAac9g76/qwxB2UaZ1SlNdt9l6CqaZQJ9mHYzO9L3R2ykUlMjmEzDOzIo2
	 VTTBMGVXJKZJpw73MdrFrj4/4GJKm8nLgJdI/kGrf1eyT9fGnGwlOzxzcnvncmeHOoGxh
	 A5q6vHGXwIWW/W5W0vMdxrZVb0fRq/O8oYGyqxuvGsWokhOKSsjGP1i5KHz2hZGXnlKy0
	 fT5UnoielKNXF5VldzlKnT3qJ6/45mn98ogOATIW5qEKdgNZ4q168fC7XJSUvl63Dw6ey
	 du70Vu4/u7XY4SWyGDAJM4Rb/jycTYpCattfkUqekwFKDYdhffAhT8p8iYd/elZ93yQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793517741;
	bh=QKpzTSg/SgAekXQkRy0ymlQHzS5uRJbh82Wb1QKm6wk=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e71784Mxo03FuYp59XHIpKG/Voshwdpw4U/WWh17levXHua7bpbPgckwO0GG5S4H/
	 Ioo0NjnQEP+XTwhhwDUixymuVuFHCJkvZoXxiUBZC5KjjPiRdIBJjAMX1CXURfFDwp
	 r/pLh6uWDnD52fcs10YgZYYYusW2v0kksLbVjZHaBvDBXFAlLtSqXQ2qzLuLqft9KV
	 zFx/jgFO+RBJjFNJW4zmEgR0HSl6qC8I//aSRQzNMzpTH39c7A8SzEUSx8essmprj2
	 s0nJ4LLKjmXb2dfVcVwgF2QCeZzOHy2N4z6d6CmZJmwc4rMpRI1/Z2s4/W87J1F6we
	 F+SaBbD/SSInA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0346B8108B;
	Sun,  1 Nov 2026 07:22:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E57ED380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6A94400AF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhZOwCzIzcqC for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:22:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 730C74004D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793517738;
 b=TsLZlSaBkTYW/1dMUDWmqd7G6mjj+dbf7zfDqjz924GW6j9fyqrC3uIfs2O4av2KJLJ/
 V60HPfpL8mERst+bcPhy9o+58eYB9aVOvA6fWhHfRjB5hkpRsxVfmslPKXYALo6w6I5Ot
 H7trxpfROEWBE7btdK1KL6dTnt7Ib2rBboupiuO0WozrP77509WLe3Wj8IWv0xAGty5rt
 DTpuyGmmVkD060gZTmI7igxeW4xSrbcclh+7vS77XLzYiP1wABZc848dZ6NhLitpxvNZR
 rwySnkhZCMtG3GL18tIgD3zX5gz/OAWtRrP6COsKjPHDyqBjAygh4H4+n65t4uwU/hA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793517738;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=QKpzTSg/SgAekXQkRy0ymlQHzS5uRJbh82Wb1QKm6wk=;
 b=Ha5idrooUZHsumuDJrvv+dlbpjrUIIS9w8iGOXXL1/YXiMTwgDMO9k9DuGCmWgsVALis
 B6ih9sNtZNUGKqhXpwwKXx5w6A7vXx20lH0/qaFixkg3JNSpa6cW2eF8LrXKtpczK7rP6
 IoHp7zOos9IYPWcWZI18VhX4b8oiA85mVee/zF9AlE+kPnAGwnnndJjnJDxcl/wokqWN2
 jAQ2EaiC+fg0DOJX3aIrOzSaAhGHeU4hQRi23y63n5Ey/R9LK+4rHIreVGTUGpi12Qgt8
 3sikk4aH2tVidKeec3poeiTCOd0qOO7Wmh/xYeEwPg55l9egSuorVrYDRQJmIR0w1vw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Xr05I6aN; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Xr05I6aN
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 730C74004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:22:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 61FA4FFABF; Sun, 01 Nov 2026 08:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793517730;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=QKpzTSg/SgAekXQkRy0ymlQHzS5uRJbh82Wb1QKm6wk=;
 b=Xr05I6aNBvZOClU3jH27vK2o6TphpWI5Jxi5y/OydafrpPCQDMpoMm6OUcHrSdXqfwQhBt
 RgpIrj+Fcc8d6gPMiSpTRmRYyvU6rjn2UahI7iy3QgsASlsJvn94qC8kRRg9QZtw2h2ECD
 COqSbHOsM4pcTcz5X2o/v2+66zZW6MQNGqWgsXWFKd9gFC7x0hNENw2PYS1TFZG5d6SKb9
 wi3PMaIX04gYt2xlphMK852B7dDE1zUsmJlQjNTAckpnP2Drp53iaDAKKFikqzboNZ7Tag
 NiwrhSQDf0gpw1AXeqUY1+5WaOuZFGpeKj8W2EeAO3tWOPFUen2DmF97QvP0Tw==
Message-ID: <8e16ca5f-3133-0f0b-fae6-479cb9f00ad0@nabladev.com>
Date: Sun, 1 Nov 2026 08:22:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Bradley Morgan <brads@mainlining.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261030020832.26572-1-brads@mainlining.org>
 <179332641005.29622.13964170083166836926.b4-ty@mainlining.org>
 <20261030142436.GK3011578@bill-the-cat>
 <17235E63-E2CD-4B0C-873C-79418E350EE9@mainlining.org>
 <3e11589e-bf81-4172-9bda-e079a1ada057@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2 0/4] doc: arch/powerpc: add architecture documentation
In-Reply-To: <3e11589e-bf81-4172-9bda-e079a1ada057@cherry.de>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 30.10.26 17:03, Quentin Schulz wrote:
> Hi Bradley,
> 
> On 10/30/26 3:40 PM, Bradley Morgan wrote:
>> On 30 October 2026 14:24:36 GMT, Tom Rini <trini@konsulko.com> wrote:
>>> On Fri, Oct 30, 2026 at 02:14:08AM +0000, Bradley Morgan wrote:
>>>> On Fri, 30 Oct 2026 02:08:27 +0000, Bradley Morgan wrote:
>>>>> There is almost nothing in doc/arch/ for powerpc, so this adds a
>>> folder
>>>>> like the x86 one, with four pages:
>>>>>
>>>>> - an overview: what the port is, the cpu families, the boards, how to
>>>>>    build it, the config options people ask about
>>>>>
>>>>> - the mpc85xx boot images: the NOR, RAMBOOT and NAND layouts, and the
>>>>>    CONFIG_SYS_MPC85XX_NO_RESETVEC and SPL/TPL knobs
>>>>>
>>>>> [...]
>>>>
>>>> Applied to next at u-boot-ppc, Thanks!
>>>>
>>>> [1/4] doc: arch/powerpc: add an overview
>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e6a37f4dfeea
>>>> [2/4] doc: arch/powerpc: document the mpc85xx boot images
>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/3287ff140823
>>>> [3/4] doc: arch/powerpc: add a PBL guide
>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b74d2c1efaac
>>>> [4/4] doc: arch/powerpc: add a booting and porting guide
>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/0851db824add
>>>
>>> For non-critical changes, please wait at least a few days. I'm hoping
>>> that for the documentation stuff you're doing that Heinrich will have a
>>> chance to look at them, for example.
>>
>> Hi, don't panic, I'll drop them if there is issues.
>>
> 
> I do not review patches that were already merged, so you guarantee yourself at least one fewer pair 
> of eyes on your patches. Dropping commits you've said you've merged should really be last resort, 
> and should be explicitly and publicly communicated, with changes made to their state in patchwork as 
> well, otherwise we are going to lose patches and people think some patches they found on the mailing 
> list were merged.

+1

> There is almost nothing that requires merging that fast, *especially without reviews*. And if 
> something requires merging that fast, a lot of eyes should be on it. We've had a case like that a 
> few months ago with the critical vulnerability for FIT image verification for example and we still 
> didn't merge that fast.

+1 !

> Merging without reviews could be seen as a way to introduce vulnerabilities in the project. The 
> contributor rules still apply when sending patches even if you are a custodian. There's some grey 
> area when you're contributing to some area where nobody reviews or maintains, but usually Tom 
> eventually gets to those I believe. PPC is one of those grey areas because there are so few 
> contributors and until now no active custodian as far as I understood, so I'm not sure what we are 
> expecting as a workflow here to be honest. We'll figure something out on the way I guess.

+1

> You also sent a v1 at 1:49pm UTC today, then a v2 about an hour later, and merged a few minutes 
> after. Please wait a few days between versions so people can review the latest version and the ML 
> doesn't get spammed. If you found issues in your v1 and don't want people to waste time on some 
> parts you're going to modify anyway in a v2, you can answer to your own mail and specify what you're 
> going to replace (i.e. doing a review of your own code).

Thats a no go from my side!

You can't send your patches after you've already sent them an hour ago.

No human can review your patches within an hour!

Give people time!

Most of them are not paid for this!

> 
>> Also, remind me, is Heinrich the Hitachi guy? I don't remember.
>>
> 
> $ grep Heinrich MAINTAINERS
> M:    Heinrich Schuchardt <xypron.glpk@gmx.de>
> M:    Heinrich Schuchardt <xypron.glpk@gmx.de>
> R:    Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> Cheers,
> Quentin

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
