Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DC606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oFEKGVec;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=mkeu1Pkh;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=gfCiTUbs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39354406E8;
	Mon, 26 Oct 2026 16:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHk2Keg0NLr0; Mon, 26 Oct 2026 16:27:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67DE04063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032023;
	b=GGizfan7A48go39ih7lRdLR2Nk9p8/2kgjzqSq6qzCidWXsivLv56rNKqbtOVKv89HvC
	 opHtDMqUCSvgVRW/NOf6VKGWzhxy5wK5zv5A9WsvNM+VhEH/2hga0WAVnu/q/wM3Be3QP
	 SdgfEhdiy6nMefmcJwUhIaJe/DMKv3kVQ9DxeNqlpLiErqIwAlr5DeXdnV9V+R144iFaV
	 P862BJiLHu1VDifVCBYH0fXMT892wnGYw72cPQdvFftjOJRBaAmuLdNZagts6gR+x3C3g
	 /W6iGAlsf11/+HfTpOrPC5z8e42ROxm5WdzzfdalsC+NwPUVBNvPFiMBZ9nBD6qVwfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EWapwJ+U4sQ/MVEb1+1/+uJ87i1VsTxqIxid5hvNebg=;
	b=FzbcXsl7uJHwm0BsIM3Fwvca8bmJPCea6hxK7ZiRoDX/cztSxwW48yt4uA0nT+Ntyqdf
	 xm6FXm+bWu94D4seVVexEASDZA/jq/MW/6DGa1HYj/wmn4Q0GTNyA2LKuAd33FZHGu35A
	 pLO0BhSkEQuGfN8/jafAEg+OqHJDQ/7w/27f0wFwBdHriGyuab+jYYXe/H4yGHIBvi/Dt
	 iM722WGNYjfUOfrNgXsd+1iU3Bc9iDE6owSmnlto1ADAIb1Gpqlj+SXkHo1/s3mxftSiW
	 rdSHDpXm+l4ai+8NwlrkZ8MRj4K0v6oZ+V/ztOV8nhU3WbgXWFi/li3uus55/w1DTzA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=mkeu1Pkh;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=gfCiTUbs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793032023;
	bh=EWapwJ+U4sQ/MVEb1+1/+uJ87i1VsTxqIxid5hvNebg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oFEKGVecnXImZykB4De7NB6Cg9EUYTajPUZw4FUE5eazD5lOZP7rpd+A1a5nVnIg5
	 L8LkYXaqiblHJgih9sZiy6FE/uZMJfzf/5pYGKPrbKEN5huvmE2e4kCVy0RNs8xH1E
	 V2WlEwcX48ig9q792TuXG3WuVB9KavJeT2nfHEfmsNBSmgAaMFZA+tZULcpEx+1zTa
	 suJGCIJwWZcRjijo7xQc+Pi9eVhwcvNMulxDdEneOP2ov8EtuX2g2DzEIm6pH/yi2H
	 n1HqPIZnynyCytyugLYRP3hp3fgt+dZm39VTNMmKUe+ZWujqOFT93eOORfB+Z01D+m
	 OmaCq9fxOy0Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67DE04063A;
	Mon, 26 Oct 2026 16:27:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FCA72AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 366C44063A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DcUcwJUJu52t for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15860405CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032021;
 b=MLQYrZC95UlJvGtG1Yl2ejNCjLo6s2nn8dWAuZZEHui0AUVx24qcW/0c4RBy9+4RFJuH
 VQK9QmkgCZdliXjekUIwoGC66YgfYS54HSIwhh0S5Zc4unNmyot80FSay0oOVdU1qJndM
 uZd3yRXmQZsbRlTCQIP+3qTVod0/sqqX6RrfvGAwbHxFPLVZe2dlAsCQ/hmzicfUNHTBR
 4+1YAxUz70lDNa+FbQKYNOpKPMkDp8HyGGo9EYGmFDRLZcsPsraQv41YIurrOXYm9+0e/
 PE/22kmknFVriVpHFZybnGRA1M461er7Plf7FGNLHg6tdYMa1Zk0Wwe48UGlyZ3gY4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032021;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=EWapwJ+U4sQ/MVEb1+1/+uJ87i1VsTxqIxid5hvNebg=;
 b=j58ZFQ74dtnHoFfQy37Nf18Rbeo/Q/XpLmp2BCv/ZVURHx/SwxaOm3cIPzNvGvVkSd0s
 kzxmrfQzvj7eqVMyAMzZVTz2unEoubnkBsP+DVfQdC4SvgMUw5siHDr2bTswTgA7BhlcT
 QdhWWHpfNuOtKGZLGtIHUEXAg6HmwLFeDjGhdNMuI9qE70aKd6yyXpMNSauj9HmWix12p
 kv+6RXxmKGFeRYBBQChB2Yi1mK4d6mlw1DnV1gF5URo9MoZA0n6Kupjp/eofw4FNi1gcI
 WYzyfRaeScerHzIrE8nPS77R7LMyOs/PnP4b1HWiPKd42IZJZqBvo7NEsBHetjZIZMw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=mkeu1Pkh; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=gfCiTUbs; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=mkeu1Pkh; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=gfCiTUbs
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15860405CE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793032009; bh=EWapwJ+U4sQ/MVEb1+1/+uJ
 87i1VsTxqIxid5hvNebg=; b=mkeu1PkhuQnQWMN4rt/l5182PEYgPfiGv5F7EVxNoW6Xa1D5JA
 5MqeYvx80chHmyCEA5Qoe8J6rmDYjRtzZKecs7JvUnOfezhodu1XIYG5EEu+8woXuRpboObZvnM
 PmmIeyUkonxHTLscnSaFHL9/zgBdS62AnsbTiUVGQHQk12h6sXQ1fyilQZflU+7bceNUe7prrnx
 MMAD4ky0lGSHY1XBBC2ZftqZAIybEOOv1VMikaExRDor064euNfJHhB5nyZ14FYY1/11WWJGE42
 xABoPaRJ0xMr9JufR2Nlc4neATslrURAH3fc6yHieDaIm9wOei3B6T7ePUPjfcjA1TA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793032009; bh=EWapwJ+U4sQ/MVEb1+1/+uJ
 87i1VsTxqIxid5hvNebg=; b=gfCiTUbsgrsnc8Muaycpm2fAYORUcXS3cAWt+R6tJ5N8E6vzqW
 ssudrruieL5VvpJmrLZddeqH6Og0Yei4UDBA==;
Date: Mon, 26 Oct 2026 16:26:50 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Vincent Jardin <vjardin@free.fr>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>,
 u-boot@lists.u-boot-project.org, Sinan Akman <sinan@writeme.com>,
 Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <at99iCtY7_bTF85U@l3017728.home>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
Message-ID: <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
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

On 26 October 2026 16:19:20 GMT, Vincent Jardin <vjardin@free.fr> wrote:
>Hi,
>
>> Isn't that a double edged sword?
>> 
>> I mean, since PowerPC is SO inactive that like nobody will respond, and
>> it'll be limbo limbo limbo, just to merge say 24 removals and a
>>  maintainers patch, especially the maintainers patch, that has nothing
>to do with the removals and that'll get all stuck up with the removals I
>think unless you have other plans, which is annoyance, because it is "oh
>so inactive"
>> 
>> And I also made a additional maintainers patch that IDK where it will
>go!!
>> Either to my custodian tree (p,s: maintainers patch isn't merged yet!!)
>> 
>> Or to another tree, yeah, odd, hm?
>> 
>> (Sorry, I had a small vent, :c)
>
>I would not drop PPCs so quickly ; there are still many systems running
>PPCs
>even if folks are more in "don't touch things that work", I feel it'll
>change
>withint the upcoming months because of the scale of CVEs of those old
>systems
>and some new regulations in EU. Let's wait/watch, maybe one more year,
>before dropping.
>
>It seems long, but looking backward EU regulations will start to be
>effective only
>by end of 2027 and LLM -> explode of new CVEs are just starting...
>so the mindset of "don't touch, it works", it'll have to change.

Yeah, I removed so many systems because it was 1: EOL, 2: Old, unmaintained
rubbish (well, some of them)

But my concern is the one patch that has nothing to do with it.

26/26, the maintainers patch, I already got a tree and stuff, but I
wouldn't know if like it'll 

A: get merged when they merge your fixes

Or 

B: Merge when the removals get merged :(

I'd prefer A personally, because of the fact that the patch has nothing to
do with it. If that makes sense.

Id personally think a cleanup is more than due for this, I have millads
more cleanups to do when my maintainers patch gets merged, PowerPC as I
see it at the moment is in a slight disarray, well, it works, but it needs
to be cleaned and organised a bit.

Id say 19+ more patches would be required in order to make this actually
clean ISH.

Because for 1: power(8,9,10) isn't even implemented yet! What!?

Well, I'm not sure about that being a priority because for 1: it can be
booted thru LPAR. Which, is odd. (Thanks IBM! :c)

Personally, PowerPC needs a nice dustpan and brush across before it could
be classed as an actually clean architecture subsystem!

And god forbid the bugs. Somebody with a AI will be having a field day 
covering their ears going "la la la la bugs", because I can see bugs all
over the place!

But thank god people still use ppc on u-boot, and for anybody reading this
using u-boot on their PowerPC as we speak, thank you so much for using it,
and me, as a maintainer(tm) and the whole community sends our unreserved
thanks for your use of it.



>
>my 2 cents,
>  Vincent

--- Thanks!
