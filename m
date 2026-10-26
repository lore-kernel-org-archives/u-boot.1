Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D7606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0jR4YtNG;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=RZtW8jlN;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=LClXxib1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EA4240748;
	Mon, 26 Oct 2026 16:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYxuQCdbJWtS; Mon, 26 Oct 2026 16:43:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A0EAB4073D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032992;
	b=BelfvluYrIKZvnC97/yAUt0F1oqARzUVwfXj2GCa0xFw71PhW4zkMJWmlYFOAElLrb6c
	 A6tsoLC1EiAch5yeLZKLdgoZCUhicg3m4CafEOPBAtF0VqbTMjKb0AbR6kCbHeEoRYIve
	 LKMDZUDwBIi3Fgn6GxMY7YyreY+9B294EkBCUsGu3k/XsFOb7W4vHDAOjqgBnmF/9P4KZ
	 BP3jpJlsKKklaGYGkvPrUyFRPg96GV0s4Z1Q8Dws6nDfm4tt9/OyU6xR7g8PmQxCExPOc
	 DO/zKkt/ZqRjhdpzmj+WHvyf13iZp2efD3E4t3UIFar+vBeDywFrngL8ptQF1U/pGLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=osrSOjqx0nM+16t/5mXR4Z/QzcIij3N3w5maOQNcpaA=;
	b=o4KHhlkcNeQb3M9M6HPOah5xIkYx6eM3cShukpHmtdTkxkkn/NYJboaPyja18/YJhNzK
	 AoG7Vel6eAxlYPckeAcdrXIRrAwyF04ofmon7i5x6FzJFaqPMMSn9PQqoGcClWr/4sK4p
	 xtdRMe4eR0ScL5/g+jJ4okXCk22QijwfT4AVllPPFMCrw31SG5xDfcft8KrpyufqrsD4i
	 C7gY+XCUXmoAIOyBt9Lj2TY8IOAOknO0MXyQJrdLZIkR4DJ5x4uZWrpnC4FjKbkkRkYDt
	 2MmeJb6l6ze6ALpVaB4kbJDC0eKciFJySSJrO4UJ2ek8WygS4K+9UbAyZZX4cl/+5hw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=RZtW8jlN;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=LClXxib1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793032992;
	bh=osrSOjqx0nM+16t/5mXR4Z/QzcIij3N3w5maOQNcpaA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0jR4YtNGJOcfJXKjpkcK1vnVmjbPUQcFpClQXK5TJrnqRIom7p0HYfMsif2gtn2vl
	 MbGJU1Qhc3ZEz/NhvKqNLR8ztDNHyQ6ezVZuBVt63i1ZTtBu5N5cxzCJVcsF54PapN
	 1SUBvdiEMmci2vVKlZ6GiSFIZKaQVzEZ0cDID3t9nIBgjToDvn/aHP25nUpSMG+HeK
	 I+g5+x5PyMyg5NujiNaEGLWO4+1TGh0l2GgZ8XWyRAXGecaoE0aEm3euxq6HaYq/1R
	 Kk5N1xCcY/bAaUrlPYjnlaLBpLGhQLWZ6mTRbwokHB/DOx9r03oyP27svMj+86sKMS
	 9GmLo7dmuyA7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0EAB4073D;
	Mon, 26 Oct 2026 16:43:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 638512AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 552B74073D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tRS3Bcb3hofk for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50CEF4073B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032990;
 b=qojyEUCxQo/THViURqrZoN9OIj6LP+lDNgBTxTPa3HpzMHa0cNwjNzWO0Numjg30P/eR
 05RXqooet4nYO24X29uwngNDGJqtdw9qLGYnsB712+7HGHJMtwyxm3IZOMYS1bhx6Ghus
 Iino4W1c26JBoCi/XpQ00A0OnAMiqEKOkowELEigC8q50RdUe5P01gW/KBHdzmFO/3KV7
 68a7NbzmjmpjP8hNMq7JOM29ot/lcCAUL9PEGJ25HQf09ItrKF/vmTtQk9KASSax2cy1b
 x0AlQon3ywR+dHvframqyrs8aq1OqfX5q0Tw6vek13KjCuS9JageKHZPcuxtQ7Z1j1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032990;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=osrSOjqx0nM+16t/5mXR4Z/QzcIij3N3w5maOQNcpaA=;
 b=KzVqB18SVjr1VW9Yuaeum8qOYkIwZQv21bCOUGXFMGf0lultaABs+XfU3iq+8kCeCj84
 sKIJ6JvP2z9e+YZFeTF8en1IBOblfAsyWNbaz64Illk4ayPN+PBKU1QDSQPsvQ/jIAfze
 yKxdBeiSwmPvjO/0RKL7tFLzgTZTUHyl5bKMsm62e57OJZAkTp12tZfLUUn6G+ZAKCY4E
 MSd4Ni4q3Jw4PGdXHysG+rhdB29U+tWn3Zco1SLP3kP8FRxsl7Z5s/orRyrJux+7usflS
 m0/ZQIE1LDSgaoSlHmx/dQUfxOfgQZSCs+yHitC4X/eKBtlxs7hKr+jCOSeVLM6BTcg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=RZtW8jlN; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=LClXxib1; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=RZtW8jlN; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=LClXxib1
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50CEF4073B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793032967; bh=osrSOjqx0nM+16t/5mXR4Z/
 QzcIij3N3w5maOQNcpaA=; b=RZtW8jlNnrSAtjI9KZX5OwcphsJSetTd+9xi1m1YU6y0UMn6lj
 z7ttQilOZ9DKuRtjF861Zu8FUpMugVMvlMfAt3WtaN0vJxUYdzj1M1FOk9/vsJ0S1SgFPXpAmnN
 gCQcO4j5UHPvsfkhKOgDPPKtPxQj8uTLMCou986J2PJCbVHhBvy7CFjn6JJvf3Uvdw8F16y0ta3
 aTmgbGZrwrjxN9zVnIzTR8V4oMmCzYIah2RXJFl8MhIs3g2em+ogT8y/7WgXpk1DY4q2FxNwUnd
 LX/rhHQntay0cRMgJImuQ+QDgddsOP3qiXi3Vlk17vxMM2ir5rj6/GpFZjKwqQy2b7Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793032967; bh=osrSOjqx0nM+16t/5mXR4Z/
 QzcIij3N3w5maOQNcpaA=; b=LClXxib19/38t+4G7+uIrV/vAwMgsfPSB7IZD2T8ZsuQljNubT
 iQCC7PtbHOmo6qQ09c1MVHU7r3cW9OYxMZCw==;
Date: Mon, 26 Oct 2026 16:42:48 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
Message-ID: <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26 October 2026 16:39:21 GMT, Tomas Alvarez Vanoli
<tomas.alvarez-vanoli@hitachienergy.com> wrote:
>>On 26 October 2026 16:19:20 GMT, Vincent Jardin <vjardin@free.fr> wrote:
>>>Hi,
>>>
>>>> Isn't that a double edged sword?
>>>>
>>>> I mean, since PowerPC is SO inactive that like nobody will respond,
>and
>>>> it'll be limbo limbo limbo, just to merge say 24 removals and a
>>>>  maintainers patch, especially the maintainers patch, that has nothing
>>>to do with the removals and that'll get all stuck up with the removals I
>>>think unless you have other plans, which is annoyance, because it is "oh
>>>so inactive"
>>>>
>>>> And I also made a additional maintainers patch that IDK where it will
>>>go!!
>>>> Either to my custodian tree (p,s: maintainers patch isn't merged
>yet!!)
>>>>
>>>> Or to another tree, yeah, odd, hm?
>>>>
>>>> (Sorry, I had a small vent, :c)
>>>
>>>I would not drop PPCs so quickly ; there are still many systems running
>>>PPCs
>>>even if folks are more in "don't touch things that work", I feel it'll
>>>change
>>>withint the upcoming months because of the scale of CVEs of those old
>>>systems
>>>and some new regulations in EU. Let's wait/watch, maybe one more year,
>>>before dropping.
>>>
>>>It seems long, but looking backward EU regulations will start to be
>>>effective only
>>>by end of 2027 and LLM -> explode of new CVEs are just starting...
>>>so the mindset of "don't touch, it works", it'll have to change.
>>
>>Yeah, I removed so many systems because it was 1: EOL, 2: Old,
>unmaintained
>>rubbish (well, some of them)
>>
>>But my concern is the one patch that has nothing to do with it.
>>
>>26/26, the maintainers patch, I already got a tree and stuff, but I
>>wouldn't know if like it'll
>>
>>A: get merged when they merge your fixes
>>
>>Or
>>
>>B: Merge when the removals get merged :(
>>
>>I'd prefer A personally, because of the fact that the patch has nothing
>to
>>do with it. If that makes sense.
>>
>>Id personally think a cleanup is more than due for this, I have millads
>>more cleanups to do when my maintainers patch gets merged, PowerPC as I
>>see it at the moment is in a slight disarray, well, it works, but it
>needs
>>to be cleaned and organised a bit.
>>
>>Id say 19+ more patches would be required in order to make this actually
>>clean ISH.
>>
>>Because for 1: power(8,9,10) isn't even implemented yet! What!?
>>
>>Well, I'm not sure about that being a priority because for 1: it can be
>>booted thru LPAR. Which, is odd. (Thanks IBM! :c)
>>
>>Personally, PowerPC needs a nice dustpan and brush across before it could
>>be classed as an actually clean architecture subsystem!
>>
>>And god forbid the bugs. Somebody with a AI will be having a field day
>>covering their ears going "la la la la bugs", because I can see bugs all
>>over the place!
>>
>>But thank god people still use ppc on u-boot, and for anybody reading
>this
>>using u-boot on their PowerPC as we speak, thank you so much for using
>it,
>>and me, as a maintainer(tm) and the whole community sends our unreserved
>>thanks for your use of it.
>>
>>
>>
>>>
>>>my 2 cents,
>>>  Vincent
>>
>>--- Thanks!
>
>
>Hi all,
>
>Just a data point from a user: we are using U-Boot on a T1040 (QorIQ /
>mpc85xx) in a product, and we intend to keep up with mainline as much as
>we can. We'd appreciate PowerPC support staying in tree, and we're happy
>to test patches on T1040 hardware and report back.
>We run u-boot in 32-bit mode (not sure if it is possible to use 64-bit)
>and
>linux in 64-bit.
>I am in the process of bringing it up to our 2025.07 branch and
>potentially
>mainlining as much as possible. We have some remnants of it under
>`board/keymile/kmcent2`.

Would T1042D4RDB affect you?

>
>If any of the planned removals or cleanups touch T104x/QorIQ code or
>boards, please keep me and holger.brunck@hitachienergy.com on Cc.
>
>Thanks to everyone maintaining this.
>
>Best regards,
>Tomas
>

--- Thanks!
