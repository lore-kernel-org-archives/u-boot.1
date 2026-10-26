Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDE606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iWKnatd3;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=aPwu/s17;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=IQjAaPNp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B30D60613;
	Mon, 26 Oct 2026 15:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9oAFfk66yjh; Mon, 26 Oct 2026 15:02:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 934B160607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793026978;
	b=IB9S3u+cmxLHnMOIUpc0T3VhGslTZvDhK9PnLDcal2ntR3PWoPo9QsCB6RWl5/fifRGW
	 yqhD/o2/Ka6YyvhFZAK3vqxexsncKjJJg8gP4cnAhTZ8viBHVjA1D6MLXLAs1A/spWSXS
	 gg9ItM/ITAkkToCFTTv9e63rsIgHky9XRKzGVIzU8s9Y4HorVOOac2a5QRfZF+vvevq2k
	 di+NffAS1dl+Us43EtDQDDFgoiXD6oVPA4E/NDHEfj56bOlYUVcTgTMHvm7e9so2bj5WK
	 Aq85YT/W/7qXyP9E9frd6S89msmPNtFGneiqtZyQkQhU7KRBCT/zKxcfvzjnPvhqKYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793026978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YHESGyXKfn09tMUOlQ2E4eP79TuINhPivkgii+vXdFI=;
	b=XAZnRGcRy1Bflw6c2NudUwi9/t//1/qhsiAkb5XuwxWwDr1uz0zlm/U3GQIXNQQdJt7Y
	 6YT+AD+DAp4z3DzKBlUG6inC3w3J88IZw2TW6P75Pc5AaHHAzzVTqQieIlCQQoD3g8rA5
	 3vmyMUVwiZfhk94QLNDzGyB3JKpQ7rLXAPrMITywqQ0JEdI3mIERG+cMPYjTwRldQVOru
	 BfZlYQlWdVYDlrCQ6ZiPvbiSd5smpD4753ojP/jk8IfkgjGSRv9lIwcD/YZ15AzYGv915
	 2MRhnl1M98XE212Odsen6u1HjwxHMbtB8ZVA3Qk6++9g26S6a9uDht7HBGrK9ZdxLLA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b="aPwu/s17";
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=IQjAaPNp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793026978;
	bh=YHESGyXKfn09tMUOlQ2E4eP79TuINhPivkgii+vXdFI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iWKnatd3bN46G1yqJYCxiWGLQBAh6JLawWP+Elm7t05ZaG4DiFqa0f+QZtGZr7Hq4
	 U6xj4dr22spJrC3MKBP578tqe0Do2mJy2QWK2GDkRZtibj85vwZzqD++vV7Uvq+3FP
	 WLWC319Yx9wdb/CUT6XTzGPxz/QtNPGLauuS3InKo/G2RWxDED86sZnEyAXDjmqN8b
	 a0fIfEJSSsXaqlOOkkyG5rQ7l7CxaXrxYT5mlmLblwymaHU5EqPy67c+Gm0Ot3ZsSW
	 Bg8LhUTsZHZ38zzt7TCiRjY0QT0eRdbo3Z81JdVnkGE/0y8rb3+Hp98+fUhP8syF8a
	 GVcUYZkBpOsAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 934B160607;
	Mon, 26 Oct 2026 15:02:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5E502F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7C0E60607
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rI11tf2Cj9dU for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D5AFC605E6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793026975;
 b=Rpj6qehuWGUSpQNwDg0IAtXQxwkPwpCX+TPOCjowYIdpt0vlbRRvxY3mpDQc14mcHvQT
 0YX4ZF74HUaIwiBAGxlAa6y2QhOHKqfmtQAR6+jlRukr1NsYgM8efuxN3W2djRJJihxsq
 n+w3URHxHpIjxQvVz6vEsykb/bP11VNyjgyspfuSVPezZbHg2Cz/tJgOBnRvrw68Me+NY
 gmQkqWHcO5BEBOBmDE3zfu1oMXDs4kglVmUpZq4F8UgdMG8sDku/UcffEntGymUEoE+ll
 +gQ3c2OOMBQZygu/dwNHgHFVxhvhiknkAS2GdehGiYz5UCgGmyl4KbXbepwNCHBTcPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793026975;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=YHESGyXKfn09tMUOlQ2E4eP79TuINhPivkgii+vXdFI=;
 b=MtfvmWt1DLIADDialN1DeoCSEicvt3oQWJ4DL+kx7TR0MMD2ik/FZ8haJwDRGGfmbcWh
 Ymmjje997SLLJtCeue05V32BXmRSpn9BsrbxXD+N06ozHkrvu2uOlRi4ayx84/+6j4L50
 IOGTEamDQGVA3h6vZZU9xj5i9WMImc/aSYMzU+COfL4IQ1NjggHf4g5zHuOqDyXCvw+/Z
 JLm8hB2oYtM3Puo2EtevegUsXf9G6XwXtZeDJrzFcIuuLyWDNGz7uiDnOzDgJp+zBChw8
 w3v2yLnLKrKyH1YeWwCqWsmWF5jzdyPfq/gZDfGeASA7OVIOPmTbNDVyPj/0+wQs6qQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b="aPwu/s17"; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=IQjAaPNp; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=aPwu/s17; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=IQjAaPNp
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5AFC605E6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793026686; bh=YHESGyXKfn09tMUOlQ2E4eP
 79TuINhPivkgii+vXdFI=; b=aPwu/s17Ak9lw7eZInsxCETK+1Htm+QIgtjB7L5Imal9zpXTj0
 RaTSG6UdGInXv+iG67RsYjWUHxx1VSByIfUvFuMzDB5ZNbRiMWBfPZyLMBhlp3pJaiYfBHnEKq5
 Ca9hs+lQdgNRx9mq7z7MyRyv0jQhemNoznQEVL/OM7AAhUOI2ibIl3uP+hPHXTnNoGtrPJUB0hy
 5aqMxJ/I5+kZOEnbOltPtpohKq2UmsPYkjNUHbCoxvV0KrXO0BBe6QJwrCMElOCJMeM2rp3K/t9
 ZnfzTs0Lr7YvtktEGfgZklHlLDOiLWTJTntO+JOHCBl97A3+5c3ctJSEq8MxaeIByvg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793026686; bh=YHESGyXKfn09tMUOlQ2E4eP
 79TuINhPivkgii+vXdFI=; b=IQjAaPNpaXWwpxxJSFyxT8lQPlqzY9r4JMchBl8f7eYL6iMW19
 49qjtk6tGaVJDfb8ahMQus1Gy8RzCAxIMgAA==;
Date: Mon, 26 Oct 2026 14:58:05 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>
CC: Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 u-boot@lists.u-boot-project.org, Sinan Akman <sinan@writeme.com>,
 Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <20261026142023.GA624796@bill-the-cat>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
Message-ID: <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
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

On 26 October 2026 14:20:23 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Mon, Oct 26, 2026 at 09:25:25AM +0000, Bradley Morgan wrote:
>> On 26 October 2026 08:43:32 GMT, Vincent Jardin <vjardin@free.fr> wrote:
>> >Hi Peng,
>> >
>> >Thank you for applying the the lx2160a series and the other patches.
>> >
>> >If the powerpc removals need more time after Sinan's remark and Tom's
>> >request to wait for the board maintainers:
>> >  https://lore.kernel.org/u-boot/20261022014554.GN3275858@bill-the-cat/
>> >would a pull limited to the first 20 commits be an option for rc1 ?
>> >They are below Bradley's series, up to the commit
>> >e7fbf8d2233 ("board: nbxv3: apply sd1 hwconfig before MC starts")
>> >so the SCMI, fsl_espi, pmbus, ICID and SerDes patches would not change.
>
>We can always take fixes now and dropping platforms a little later, the
>merge window isn't as strict here as the linux kernel.

Fair enough 

>
>> Tom reckoned that today would be his merge day on IRC, but things could
>> change, I feel these board maintainers are deliberately not responding
>> tho.:(
>
>PowerPC just isn't a very active area and hasn't been for a long while.
>The general rule of thumb for non-urgent changes is two weeks between
>posting and merging.

Isn't that a double edged sword?

I mean, since PowerPC is SO inactive that like nobody will respond, and
it'll be limbo limbo limbo, just to merge say 24 removals and a
 maintainers patch, especially the maintainers patch, that has nothing to do with the removals and that'll get all stuck up with the removals I think unless you have other plans, which is annoyance, because it is "oh so inactive"

And I also made a additional maintainers patch that IDK where it will go!!
Either to my custodian tree (p,s: maintainers patch isn't merged yet!!)

Or to another tree, yeah, odd, hm?

(Sorry, I had a small vent, :c)


Hm, I will probably submit the maintainers patch separately, since that
should have very minimal to no conflict, idk what to do here, tom, any
advice?

>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
