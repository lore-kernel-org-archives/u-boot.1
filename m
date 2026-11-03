Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA07606A335
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hqRPnntC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0CnFgIv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5026680D0B;
	Tue,  3 Nov 2026 07:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CbPr13ypOTXW; Tue,  3 Nov 2026 07:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 65C6F80DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793690152;
	b=NTduIGyi0CrJ1xVKLh85ittcTh5tZJwk9ebemlGRqoSi5aaG6aLOVcjVNO4wdvOh2aLR
	 LVRpLJxh/wvclq7827mW4d5pZvj0RF8e0TtrFBaKC7Gn7pB+B2AgQAFRYpfjNH9UagCwQ
	 t3nOLHZUfaOptkm9+2VwV7DmfgMof7buG70c5H1ssNkFkVR/jXS/o0jn3phti0J5i3DX8
	 j//EgFkTksbfGCLKIPoMV/1ONI1TKaBKj35b7L1WjYzG2WM9wHYRBYglce5cgHZW9yMlZ
	 32pvu8xtJSjcY4unRK9w/h4ZnOKCALHdzPoF07sOB68+58Yzn5nc/n5++NmAcUp+Crw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793690152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mFM17CR5qVdJz4YeKaZnG94zq06DgFKrPpEs0xkHFmU=;
	b=mb4uZDbjBxqpDmzXUGkjjE/nRFZWCA/ylRbzclSZ31aDJlSeGVGRE6ZK3emSm8s9ympk
	 P5JjFcLu/41Y673RlUYPXPd6CYdGFMcGoMY8no9K0yidm8iZsXKFw2CmRg3fGRHgIS1V2
	 gV4eY/Y7Zw77PoB8tIV3TG/4mnwdJDxzdPQkxk4czO+0nrqMOc7uZCva90pAWAqohliF5
	 N3CnLea92PR4N0VZ7h+YJcXOXc07DECtK+WrbC5SIkGjB+JVYGXIreDG5tgKON0Vw4UIv
	 DlY4TbiLgjSkyoAtcq3Vakxc8i+4Nh2x0myiH8yZjusFUwInxUUH8N/7PiZG3eQKHrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793690152;
	bh=mFM17CR5qVdJz4YeKaZnG94zq06DgFKrPpEs0xkHFmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hqRPnntC/cPlhjhESjsyvH/kiZeTNiRckElq8JgZ8XngNsm5P06x+WW21Kl2ZaB5Y
	 IT4W3AAJHxFYOYVkwxTu51GmwJfRslgXyEs9CaMcubYczY2baXrfpr0d9vfaTMLZuW
	 tS9wDoSyoK1KhUJLy+av/0pd+/V4hyHys23QzVW8LzsIUQ7vmgcZQmyjsE8IWScuUs
	 Du3hlYC5dhdxQzPsyKICRofdw9oikC9MR22iTC3Jec4CkuhD74ll4v70UNopTvUmzK
	 Pngnw2ZMBH0wI63QdYGmrtX5xgz99UfK4eyKMcaW2Xu28V973Vi7jbJbY0mIrO5i4+
	 FJuyrUc2QRsCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65C6F80DB0;
	Tue,  3 Nov 2026 07:15:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ABB24BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1C2E40589
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:15:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 60LuUZSsA7hn for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:15:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E5D1440564
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793690150;
 b=UZSKcFsja+x6afXk5VXv0fHJncl7f3MEHKuipz/HZVoDgB2rIagtTXoolYH3APBEOKWP
 QdP20MygsLvbbxNazQ+TSOeeUZLbY6rEJoSOdZww0Y+BX1UClYyIBwkXF5vFE+IyZb0u8
 m9D3zIqL+QOXgcPx16oLKPdrquZsAzJupBYmsDMX3XWwed5d9elirz5ROauk4y39BCvS1
 pVpqzQ/e9skdXW1olzj60oUwtkAI0oM7vs2NN8yYeXLomAjkjp6jFbxIgqok0KJzr8Us3
 hZSau/3x11MNw2WauRgKo3yWPJ9bkPVh/VMovrj1GCroQu7wr8fgdFN1YSnz1zpR0CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793690150;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=mFM17CR5qVdJz4YeKaZnG94zq06DgFKrPpEs0xkHFmU=;
 b=KfFmAAUkkcriCN/V8Lf/zL/A08qTi43LXY3xARY7pYu22jAqzWuoliGiZpdWTEh2HCzp
 NSNSrgCt5Z0uXuCoktHZatpUQI75ldnQou0uWxEqB16ScZkasjhQ1m3zzpKiF8Gi7YF9i
 CrjlpjPKFs4ZNau/mUwzmyD+rM/DLvMd83oPH+oAG/H9ILBjqeJTDNIGX3oTzbeg3eVuk
 61ApNfis4c1qt+eNVxm9gCVmyIgtQIjjLKXwNoJeKHJJJQWEjJ3wj5OXZwYJJXZRYY83+
 C5s3LQ6gcgXuSivvHma/HnA5V/dd/Y8Z5Rx3FkSv48EL/XB2peD2ptAusKmWV7uDN0g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n0CnFgIv; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n0CnFgIv
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5D1440564
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:15:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D0D643B22;
 Tue,  3 Nov 2026 07:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB67A1F000C1;
 Tue,  3 Nov 2026 07:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793690148;
 bh=mFM17CR5qVdJz4YeKaZnG94zq06DgFKrPpEs0xkHFmU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=n0CnFgIvF7c15XnxumYQMRbdUcjzF6CimlvW0JEWPdPgdZmiMBpp5G4TfFMSf0IXw
 nyYfx7YgfN11cGg0Yu8hnbrUy8zBAd+aogUNs/sHoHaxvt7ozxAY0aDippiR/K68aH
 piGXkPa5klGfoLkcA7FY2nT4Hl8+oBaPN0pVCLY9E5wMcVeXQZ4EnuptuYLHiZS/q7
 1aTsw46NzeeAp3ORz+45RrCdCLrb8m/jWvorRSRri3khejgkpUXgzELp4zrD5Bwh3f
 mrvzSyREwLrr5h/Cf5AxHzBJlxzWJgUkZK6r1d7plNzmjwnCry9o2ctVn8eYz/mSAf
 XQWt70jlPFGNQ==
Message-ID: <811302be-3815-48de-b5c0-141be2ec3bd6@kernel.org>
Date: Tue, 3 Nov 2026 08:15:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/26] powerpc: drop unmaintained boards and SoCs, take
 over maintenance
To: Heiko Schocher <hs@nabladev.com>, Bradley Morgan <brads@mainlining.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
References: <20261021160145.10430-1-brads@mainlining.org>
 <179305815837.10976.380221911015278933.b4-ty@mainlining.org>
 <7502C221-FFFA-47DC-B3AE-4269C4C6465F@mainlining.org>
 <d3b2f30c-d9c5-6566-5048-3e82f8c46ff1@nabladev.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <d3b2f30c-d9c5-6566-5048-3e82f8c46ff1@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko,

Le 01/11/2026 à 07:18, Heiko Schocher a écrit :
> [Vous ne recevez pas souvent de courriers de hs@nabladev.com. Découvrez 
> pourquoi ceci est important à https://aka.ms/ 
> LearnAboutSenderIdentification ]
> 
> Hi Bradley,
> 
> On 27.10.26 00:50, Bradley Morgan wrote:
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
>>>> board
>>>> maintainers or users are still actively testing or relying on a 
>>>> specific
>>>> board, those removals can easily be skipped.
>>>>
>>>> [...]
>>>
>>> Applied to next at u-boot-ppc, Thanks!
>>>
>>
>> Pretty confusing, hmm? Sorry for the confusion, B4 stuff. Heh.
>>
>> So I would be more than gracious to rebase if anyone was to NAK any patch
>> in this series, I'll wait about one more week then send the PR, maybe 
>> two.
>> :)
> 
> Thanks!
> 
> Please give people time to react, as most of powerpc hardware is old, 
> and main
> business is not anymore powerpc...
> 
> I can speak only for the socrates mpc85xx board and it is still in 
> production use.
> (Luckily not in this series!)
> 
> I try to convince customer to give me some time for updating to mainline 
> and may to
> setup gitlab CI (I have a setup for this including a BDI2000 for 
> recovering board,
> but need some time to get it up and running... hope I get some).
> 
> BTW: Do you have any powerpc hardware (as you volunteer for custodian of 
> *all* powerpc?
> I do not see much commits from your side in tree...
> 
> Also, just finished work on mpc855 board (port to 2026.10, linux 6.18 
> and yocto wrynose)

Don't worry about this one, I'm still maintaining mpc8xx.

Being a bit surprised however. You dropped 8xx support in 2017 without 
notice with commit 5b8e76c35ec3 ("powerpc, 8xx: remove support for 8xx") 
and I had a hard time bringing it back.

By the way I only partially brought 8xx back, only for last generation 
8xx like 866 and 885 which are the ones we have on our boards. See 
commit 907208c45299 ("powerpc: Partialy restore core of mpc8xx") for 
details.

I don't think 855 is supported anymore, at least register PLPRCR comes 
into my mind.

Christophe

