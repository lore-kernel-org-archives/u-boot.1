Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC0606A332
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DxRsoRD/;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=n3vq9Vzd;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=kBqdqe4s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F361D405B6;
	Tue,  3 Nov 2026 11:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3cJrvmTw84Gb; Tue,  3 Nov 2026 11:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0FF240509
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793706348;
	b=ZdOr+yL5QACrVOmlYarAbw3fPP+KKbBVDfdemG36rAXLAvaO+bNFQvf7yH9dBXg5CM6y
	 sbgaHTDXIzoyOlTWaERRl6tsutb7hdVzt6vvxKBavpfSXgpSSuSld07u5YbYKLH0Xrcp3
	 EinlkTohMVAWsyZ9CGrkr9QtsMELkumi9VTT1GRe9MpTr7LTK4vbnydWFJ//awWOXEBix
	 U96oJm0VYr0NxndWb84qSD61YH/CiAOoYyVHWBbnnOp93WDWqoizjIgLZTYS5wICTeNLJ
	 QED6lkNjZ3D+x7s7vwghnyhO6VA0vLJu7Voiekwv+6Xg+/xikfrzAR/4jD7bLvWfAZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793706348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rfjLPlAgBbsiKJ3rfRzq4brNJfBDzslIaH7oziHAW2U=;
	b=tHicWbJ8GnWmVHB+IIX3HUgirlCafotP2RZN0hT9P9jDvdUbjhozQV4zaxnRtN+E2Pim
	 PsKamUg2U9NJvbzXLvLS7W0FereucYDMYMHh/zDeL4Pi0HSgbCjrHaEaAgptH0WLszv2V
	 thooALWxxKr+vzuO3StT4J7CUiVOEHI0Mgm2hG3yzoHpZFT6CmvwALeZGSIgAY64Vo4vw
	 xjNGzhTS+owgYT/apGwtOigpMGjnImaWFvUALgO6/k/DZrJ2eMHjgOcLVIrfIf4l1kAkT
	 ih2otB+wg8WUF2j4Za5+vLR0nccHo1LMXbICJGmJoWzpLK+p9DJkJsqX2S3FTC/bzpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=n3vq9Vzd;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=kBqdqe4s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793706348;
	bh=rfjLPlAgBbsiKJ3rfRzq4brNJfBDzslIaH7oziHAW2U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DxRsoRD/whmPa2bF+6ZTr8CiRVfU+qLZYkR7c5brcq5YKvPtvjvIvQYKYt6Vsf0qX
	 qjErebA9pz3FSUBE047OVEiQX3Xmwi3Grv2bbvyWs+VcXyVtHSQglUlnsi90g4ejhV
	 NLQ80TuZYcEBgXxit/bVZTj5sHB9RaOcCGtrz9/WNxO7DIKbaC6bJP2w9WDtekLiPA
	 UtgoldYtajqNSUIPwILOo/xFuP21AlVgNNP0OCDqtjshGkrboiXM3gcdrHfUP1Z7Fs
	 Qmt4N7ni3K3paDkjhr/06Tw8s9kfVHtCWOrU7UMwc//6LbjgJNL24h7CrTHq5vO2a6
	 g+DmXteoqHEKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0FF240509;
	Tue,  3 Nov 2026 11:45:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D081C2A8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B63440509
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJ3a2ITJLIzF for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 11:45:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0EAE40507
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793706345;
 b=cUy613etgub6gk8e18wk5inY3D6ughjsde6RCALkmMKIPhPhU2h+0EERI2SDsKBHw4Lc
 57kJdUOBWyoI+qnsld8CoTQuI/2PAfRCD0PVMAWRMkxTjaI1v9z3iP1/0o++Z5TsyCFYy
 gxUOFgw+fEVwAeqXZ4eOu9uxiIickc7QEkJ1pbJcHdSlPuBIpqFpru8M2L43u1NbVbVq/
 Z6N/7vvIuOgEoN3AHCm7xaYjwK5u2OnqQLQiAMqU6jQwxuFbxGPiMyAa6n0LfLuAXQSAy
 spczG3lIxgnFfTn26ukFa5wE9fnQd17ay/zKd8+3lVoiRvxbkbvDz4NxUGqIGONKi2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793706345;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=rfjLPlAgBbsiKJ3rfRzq4brNJfBDzslIaH7oziHAW2U=;
 b=VCPKeh4zmrDI9KO+OlkbOA06W+JsOx43HIxT6xfU8pSdfnjyc9L2WVb5tFi6V0TyPILr
 d4nvsi8IB6OxnMdgv+PcwxuPv2qtVptE3YeUm0qqL/v8X+98jJYcUXwiFB9KfFmWRxNSr
 FL+dhTvIMU8F9wNEj81wYrVQTiDfMfa1iPVl0H+8/oz8g35iSow5+oc7gHWb8tz2IOjdv
 AYaZbFuZSvPxKOF6LoyXSI5fQDfQSoJGlKA6TugYOG6kzwB/UDRXLGLqqdj2xu0T9e+J7
 Rluvo7wpJMERhtmMF1jk6L6MIwwZjGPiAq/DKrgqpasy04jftTXzdZ9ORH/bMw4/StQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=n3vq9Vzd; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=kBqdqe4s; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=n3vq9Vzd; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=kBqdqe4s
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0EAE40507
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793706341; bh=rfjLPlAgBbsiKJ3rfRzq4br
 NJfBDzslIaH7oziHAW2U=; b=n3vq9VzdZN6i2vhq943hujYsUwqvTvnCbQA/T/pBQgfEQUhrJa
 aUlr/jVASq0Rx965M+XDoByynB7TGoKWFQUTZ0G2AA5WcD9HCCKC229H2GbhQYTUVfNfDPfZe4W
 kgE0zbid1DcKXdGVuW+hzZBGGoaC8nKyzLwoEbrHr2RdMlGqHUnoGVlnn6u9S0KXc0m1e2zF38Z
 70jNxLcOrERzkQ+0LK51mfopfuVM6STgITAcz2mE6liONBwyh5OwMTAcYEe7oYSuXIQ69T/1F9G
 /OwLSN/BF0YyFN70CJBIPs6N+mfo9e4H68gq4AWG60p32g7PknoK8xldmJGWix/InFA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793706341; bh=rfjLPlAgBbsiKJ3rfRzq4br
 NJfBDzslIaH7oziHAW2U=; b=kBqdqe4sEzodFsHYTurmjeM4w62zvuLYQZ8twQOPczbW8RrwV5
 2VsGHvzO1RiU3bQUJ/4fDzpyiz9G/r+nQCAg==;
Date: Tue, 03 Nov 2026 11:45:42 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
CC: Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_00/26=5D_powerpc=3A_drop_unmainta?=
 =?US-ASCII?Q?ined_boards_and_SoCs=2C_take_over_maintenance?=
In-Reply-To: <d3b2f30c-d9c5-6566-5048-3e82f8c46ff1@nabladev.com>
References: <20261021160145.10430-1-brads@mainlining.org>
 <179305815837.10976.380221911015278933.b4-ty@mainlining.org>
 <7502C221-FFFA-47DC-B3AE-4269C4C6465F@mainlining.org>
 <d3b2f30c-d9c5-6566-5048-3e82f8c46ff1@nabladev.com>
Message-ID: <84E9EB3A-E281-454A-B3A5-95FEE3A2434B@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 1 November 2026 06:18:26 GMT, Heiko Schocher <hs@nabladev.com> wrote:
>Hi Bradley,
>
>On 27.10.26 00:50, Bradley Morgan wrote:
>> On 26 October 2026 23:47:58 GMT, Bradley Morgan <brads@mainlining.org>
>> wrote:
>>> On Wed, 21 Oct 2026 16:00:56 +0000, Bradley Morgan wrote:
>>>> PowerPC in U-Boot has been orphaned since October 2022. Several boards
>>>> and SoC targets in arch/powerpc appear to have had no active community
>>>> maintenance or testing for some time.
>>>> 
>>>> This series proposes removing the targets that are currently
>>> unmaintained,
>>>> to help reduce maintenance overhead and ease treewide work. If any
>board
>>>> maintainers or users are still actively testing or relying on a
>specific
>>>> board, those removals can easily be skipped.
>>>> 
>>>> [...]
>>> 
>>> Applied to next at u-boot-ppc, Thanks!
>>> 
>>> [01/25] board: powerpc: Remove MPC8548CDS support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/91332bbfa36c
>>> [02/25] board: powerpc: Remove P2020RDB-PC support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/74f4118d5607
>>> [03/25] board: powerpc: Remove P3041DS support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/f345ae08fa06
>>> [04/25] board: powerpc: Remove P4080DS support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/c7492940bf9a
>>> [05/25] board: powerpc: Remove P5040DS support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/23f32a1d1eac
>>> [06/25] board: powerpc: Remove T1042D4RDB support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/bdad411ca572
>>> [07/25] powerpc: mpc85xx: Remove P3041 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/d63e5fc8303c
>>> [08/25] powerpc: mpc85xx: Remove P4080 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/353f7e2edaa1
>>> [09/25] powerpc: mpc85xx: Remove P5040 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e85e4e0e26b0
>>> [10/25] powerpc: mpc83xx: Remove MPC837x support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/286b4f95a2ca
>>> [11/25] powerpc: mpc85xx: Remove C29x support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/ab46013e050e
>>> [12/25] powerpc: mpc85xx: Remove P1011 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/244d495b2d72
>>> [13/25] powerpc: mpc85xx: Remove P1023 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/07b36f2f63be
>>> [14/25] powerpc: mpc85xx: Remove P1025 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/2bf43c8d082d
>>> [15/25] powerpc: mpc85xx: Remove MPC8536 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/9ba511b59ce5
>>> [16/25] powerpc: mpc85xx: Remove MPC8540 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/4e2d7d590196
>>> [17/25] powerpc: mpc85xx: Remove MPC8560 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b75b1e387d83
>>> [18/25] powerpc: mpc85xx: Remove BSC9132 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/2bc1536a913d
>>> [19/25] powerpc: mpc83xx: Remove MPC831x support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/d7f92247c56a
>>> [20/25] powerpc: mpc83xx: Remove MPC834x support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/64c720ccc8d3
>>> [21/25] powerpc: mpc85xx: Remove P1024 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/97ab3bbd4979
>>> [22/25] powerpc: mpc85xx: Remove BSC9131 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/afc835c3312b
>>> [23/25] powerpc: mpc83xx: Remove MPC8309 support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/6e2405d54e5d
>>> [24/25] powerpc: Remove MPC86xx support
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/dbb43f735a5b
>>> [25/25] MAINTAINERS: powerpc: Add me as PowerPC maintainer
>>>        
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/86b1f677e263
>>> --- Thanks!
>> 
>> Pretty confusing, hmm? Sorry for the confusion, B4 stuff. Heh.
>> 
>> So I would be more than gracious to rebase if anyone was to NAK any
>patch
>> in this series, I'll wait about one more week then send the PR, maybe
>two.
>> :)
>
>Thanks!
>
>Please give people time to react, as most of powerpc hardware is old, and
>main
>business is not anymore powerpc...

Apologies for late respond, lets have a look.

>
>I can speak only for the socrates mpc85xx board and it is still in
>production use.
>(Luckily not in this series!)

Thanks for showing your interest.

>
>I try to convince customer to give me some time for updating to mainline
>and may to
>setup gitlab CI (I have a setup for this including a BDI2000 for
>recovering board,
>but need some time to get it up and running... hope I get some).
>

Makes sense.

>BTW: Do you have any powerpc hardware (as you volunteer for custodian of *all* powerpc?
>I do not see much commits from your side in tree...

yes. Power10 board from osuosl (not ported to u-boot), and I have some nxp
one somewhere in my room of which
ill find it :)

>
>Also, just finished work on mpc855 board (port to 2026.10, linux 6.18 and
>yocto wrynose)

Again, thank you very much for your interest 

>
>Here too, trying to convince customer to get some time for pushing this
>board to mainline
>(base dts is already in mainline ./dts/upstream/src/powerpc/tqm8xx.dts
>u-boot and linux)

Ok.

>
>bye,
>Heiko
>

--- Thanks!
