Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81D606A32C
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XkQP+SbN;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=SZy4LX1i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFD1D80CED;
	Sun,  1 Nov 2026 06:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NoEUdogXCZlG; Sun,  1 Nov 2026 06:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9721780C8B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793513919;
	b=hqkcsTotjwglEckV+am9UEh/ePFcyVOVTWxAMdaNUTqtoqjyeZ76bBz+sSXSLhqsyidd
	 meLm0WGkH+DtfqBt1ELqMINJRAGWklb2dhTQW4qaCYKYftSiugWQFwzYBdZ8MZHieQaWG
	 GJ7JT0qtr5UiUFMWPCjNfc3Ud9rNN3D9zcFKvi0Ts/2FFmYwPGHm1oKOLkhtd+judDArk
	 rugD7yAx+Lwcsn8339iPLeS7yOA8YSTuGEHCRg5SmQ3GFaLQcYe4PxwTn0SibW1DBh6JG
	 3Nu8/+F8iWNDQxdMvF+6Br96USAKfZjJFHCojpNdEUE4/sHbA6XO0LyX3wdsAx85wgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793513919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZGH6cSGgxO3MPxOYPZdtMgb69cVzx8PCCW/php+o7bs=;
	b=HVpBOyKSuN8NTF6V0YIgMkMaGEWYHNMuC/hOOkimeokaBCetdO3afkSzbBBIIjdE4ok0
	 2tvJxB2kFbK4IF9zc5ScBdaTYtvOr9qxI/AlzliZ9eAYcmCN1D96kUZhBB2EaibCpz5t4
	 1p54zGF6S1v8l7VYRMYGWm2PnUqiSpRp67aOWoNXvMJGkdYzWzeneWKdCRf5vDP3SQ7ue
	 Ofp2vX6Hn0ZfmGb9gkF/llD2ZNYTlCcNl2WodsRrYKa1De5dyfU2jHm1lugTa8iPX50BM
	 /lfEiOKUt+2OYEoa5RiXlGoLrut2OQ5xSsjyziZ11UoxfFbj48IfrPkniqWVZVj/U4Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793513919;
	bh=ZGH6cSGgxO3MPxOYPZdtMgb69cVzx8PCCW/php+o7bs=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XkQP+SbNRXj+ULia7JnJ/KAnHfduW+TgjR1HYv04/UQc/XgMxbCUuBYJCL50b1uiX
	 R222fp04akZzpfy7NoASlwyQrRl7atjCghe8fu6lY1gmVi9plXUSwG4KT5hNP1H6WO
	 DUgiJueQphLSG8ZT0htgBykrvUy3o2KcnEj6EqhGqczh1zlNuujWejl7iP3O0g1rug
	 vvZRLIJe6wRb0LfrlHs5/9rDDVgnnUPJkmxecTTEdANHhqgSINhfIrcs1Pn9GUIjom
	 uVsOq5j8U1lhETXiG9lE/yBUizghE2iS25q9PFj3BX2EaXuiXlqV77HLdi3LTiZcQy
	 WN/LR20Pf3aJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9721780C8B;
	Sun,  1 Nov 2026 06:18:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A3C3380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 06:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF864400AF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 06:18:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYcpjADG4Qjk for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 06:18:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 549814004D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793513916;
 b=DtofLkZ+uZ+9L947UTOI68Waaw2pYGrobcqyCPnO0iSfN1PnohVL/52QPfGrxlWwMSNe
 sB0WNjvOd5w7u7aHYb7LE+P0JmMDUuDmuH9bEMcDN34aNPfSR4Jpo2pATWkZ2JM2izVCa
 JrkBCyDuF80/Te8ZPXsJ140Wbjd7Fk/5l6efaFXxOY02w888VhWPChbLK1xPgbxTwq77S
 PEN2LiPIP69wpvn6JbSU7yJprEklxoBD2jqfeC5zSr4fZXkR8+3N6cd+Fhw8WFcGQJ8br
 7zX6wxIrwoJPb+Y0+YctiiqdJmiZ2YKdciAQ6ojTn6LIZfK78Oz0ySACW3yYO0bqMEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793513916;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=ZGH6cSGgxO3MPxOYPZdtMgb69cVzx8PCCW/php+o7bs=;
 b=P9yITqCTBwohzvV9XyRL/rnM+UsPJIZxTHkFsIY5Rb93n3otya4mo4mjqzRTKAMKwv7U
 n4LjesvuhsF57RE1eLM/HXolqjA4/maDYUOfkIk10i1BEj3HAfDMTJIjiK3oxcGjQyiLO
 lKIhMFd4/vp8oswOCzn1zJ2tEibY+nREc1HfTmow7Fbm8pGn12X43QJ47sulT0Gd73qUP
 +gA2oHBDVY4Q3y6QiVLP4fFpYDdhEVEqOJOjBvNkkheRbAjFhb38P9H/lsmazxxJiliOp
 IZoPHNz++0CwpTmgeTyRzkSA8cIXlyDPp9iVH1G2DiJ+3NOLZgeGSfbIk5o7sFs/pyQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=SZy4LX1i; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=SZy4LX1i
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 549814004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 06:18:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6459B10C32C; Sun, 01 Nov 2026 07:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793513909;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ZGH6cSGgxO3MPxOYPZdtMgb69cVzx8PCCW/php+o7bs=;
 b=SZy4LX1iXnY0DRKeqjYZdBROdJ2x4Vi0sDxC4GewVgeS7gbvKRHo/EJbDoLex/dPBzxC3Z
 yrDny9Js+/PrVt7a4euj+AYHvrJ5vfygsMEyNr+gPD8o0dhpDfXnMpLKg/1b5YFhiOcCYv
 23Y5eLfw9Tlnr2psKHetobaAhxRQ81aBzJDFs/z72hm6L0lF6u/9bVU8SvcdeArGke6gvT
 MJYwoffKhwwpwHB8NbAoCZ2xXMMIlwkXIusOcTygtyOM8mGCezFooeLi7ylTm/vGS6szCq
 rnVhigCR+0ViKsuKtHVBKITdOUgD0zQGNBPziDCRX24P7pS7JVsGfs27U5GqjQ==
Message-ID: <d3b2f30c-d9c5-6566-5048-3e82f8c46ff1@nabladev.com>
Date: Sun, 1 Nov 2026 07:18:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Bradley Morgan <brads@mainlining.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
References: <20261021160145.10430-1-brads@mainlining.org>
 <179305815837.10976.380221911015278933.b4-ty@mainlining.org>
 <7502C221-FFFA-47DC-B3AE-4269C4C6465F@mainlining.org>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v3 00/26] powerpc: drop unmaintained boards and SoCs, take
 over maintenance
In-Reply-To: <7502C221-FFFA-47DC-B3AE-4269C4C6465F@mainlining.org>
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

Hi Bradley,

On 27.10.26 00:50, Bradley Morgan wrote:
> On 26 October 2026 23:47:58 GMT, Bradley Morgan <brads@mainlining.org>
> wrote:
>> On Wed, 21 Oct 2026 16:00:56 +0000, Bradley Morgan wrote:
>>> PowerPC in U-Boot has been orphaned since October 2022. Several boards
>>> and SoC targets in arch/powerpc appear to have had no active community
>>> maintenance or testing for some time.
>>>
>>> This series proposes removing the targets that are currently
>> unmaintained,
>>> to help reduce maintenance overhead and ease treewide work. If any board
>>> maintainers or users are still actively testing or relying on a specific
>>> board, those removals can easily be skipped.
>>>
>>> [...]
>>
>> Applied to next at u-boot-ppc, Thanks!
>>
>> [01/25] board: powerpc: Remove MPC8548CDS support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/91332bbfa36c
>> [02/25] board: powerpc: Remove P2020RDB-PC support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/74f4118d5607
>> [03/25] board: powerpc: Remove P3041DS support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/f345ae08fa06
>> [04/25] board: powerpc: Remove P4080DS support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/c7492940bf9a
>> [05/25] board: powerpc: Remove P5040DS support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/23f32a1d1eac
>> [06/25] board: powerpc: Remove T1042D4RDB support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/bdad411ca572
>> [07/25] powerpc: mpc85xx: Remove P3041 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/d63e5fc8303c
>> [08/25] powerpc: mpc85xx: Remove P4080 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/353f7e2edaa1
>> [09/25] powerpc: mpc85xx: Remove P5040 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e85e4e0e26b0
>> [10/25] powerpc: mpc83xx: Remove MPC837x support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/286b4f95a2ca
>> [11/25] powerpc: mpc85xx: Remove C29x support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/ab46013e050e
>> [12/25] powerpc: mpc85xx: Remove P1011 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/244d495b2d72
>> [13/25] powerpc: mpc85xx: Remove P1023 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/07b36f2f63be
>> [14/25] powerpc: mpc85xx: Remove P1025 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/2bf43c8d082d
>> [15/25] powerpc: mpc85xx: Remove MPC8536 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/9ba511b59ce5
>> [16/25] powerpc: mpc85xx: Remove MPC8540 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/4e2d7d590196
>> [17/25] powerpc: mpc85xx: Remove MPC8560 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b75b1e387d83
>> [18/25] powerpc: mpc85xx: Remove BSC9132 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/2bc1536a913d
>> [19/25] powerpc: mpc83xx: Remove MPC831x support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/d7f92247c56a
>> [20/25] powerpc: mpc83xx: Remove MPC834x support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/64c720ccc8d3
>> [21/25] powerpc: mpc85xx: Remove P1024 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/97ab3bbd4979
>> [22/25] powerpc: mpc85xx: Remove BSC9131 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/afc835c3312b
>> [23/25] powerpc: mpc83xx: Remove MPC8309 support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/6e2405d54e5d
>> [24/25] powerpc: Remove MPC86xx support
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/dbb43f735a5b
>> [25/25] MAINTAINERS: powerpc: Add me as PowerPC maintainer
>>         https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/86b1f677e263
>> --- Thanks!
> 
> Pretty confusing, hmm? Sorry for the confusion, B4 stuff. Heh.
> 
> So I would be more than gracious to rebase if anyone was to NAK any patch
> in this series, I'll wait about one more week then send the PR, maybe two.
> :)

Thanks!

Please give people time to react, as most of powerpc hardware is old, and main
business is not anymore powerpc...

I can speak only for the socrates mpc85xx board and it is still in production use.
(Luckily not in this series!)

I try to convince customer to give me some time for updating to mainline and may to
setup gitlab CI (I have a setup for this including a BDI2000 for recovering board,
but need some time to get it up and running... hope I get some).

BTW: Do you have any powerpc hardware (as you volunteer for custodian of *all* powerpc?
I do not see much commits from your side in tree...

Also, just finished work on mpc855 board (port to 2026.10, linux 6.18 and yocto wrynose)

Here too, trying to convince customer to get some time for pushing this board to mainline
(base dts is already in mainline ./dts/upstream/src/powerpc/tqm8xx.dts u-boot and linux)

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
