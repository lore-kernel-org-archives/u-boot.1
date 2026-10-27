Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECADE606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wq7uaQN1;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=bOjcfgqS;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=ge0fwdai
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEB2C40572;
	Tue, 27 Oct 2026 00:26:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 71L_CoYg9wWD; Tue, 27 Oct 2026 00:25:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DC524056C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793060759;
	b=V/syrEJr41GrcLW1q/v7V4Lhbdzc3jKVjTB1UtZAgA8Ao+Y9dPyP6yIo2CFCtBMZLE54
	 1NaHWrCG0q6IEf9OPdrgEHXoUhMqvuYN0JI+eENw24JWLVka271GovLPqoIPJQTSpub1g
	 83Xuw21vLUBz6o3Zx3ECgMFZswMJtIybdNkjbzjbI+rjCoFsVLrZvAnPcI3kpD8wbiGiy
	 sAX27+gjuJWbsBrZLBZn1CPKgios6NJcnGx5fvul8fau0zhST7nPQK8dd+r4Axk0tyF1W
	 4mHm4J3WY5OFPdzr5r3G4x4VdGT5wtaakpUqRghc3TWQfa2JOdZTTMG0NrDlEur5h9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793060759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0pR0INajTOqgCE/OAl0EqIXMJQqWzUQpenXQJ72vlF4=;
	b=Fips865bxSk3/8FW/8Z6gYe6Sg97avXdPle1HRdeU4kdArUuJ4y0sUcALUJ+LhNz50rR
	 5ufX2OGYOCp0PqPbJWHySdk6PycExxFzcfajde3874RwrINiYLu6mIcQ3yaqnjuJ9BgSX
	 g29kmrcuyRbIxhSAT0JX9VTl0GpCICfAPhI0O5gJjgGRq3ECiz5L7Rf4rXq1yO4bCRPzK
	 jdb5KGAiCyQTDia5wAYKC+e9nb/XhUSPMM4LElDcJMth9e+1sA/F3h1QDY2pFd01AHMbv
	 Uos0lERNNsoeVSuH/LS3JhhqZG37obucRXn/WZEneAS8/8nAyhGqndhn4cxeJVvDftg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793060759;
	bh=0pR0INajTOqgCE/OAl0EqIXMJQqWzUQpenXQJ72vlF4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wq7uaQN1kwVzp7+6he8sJxJwNNA7yJQKbDgB69EhXM+l0o//ts5aXLTiwOkJzgEGF
	 SmlvtlULOFPHpolxvabtkQpwA1ojJIa5o7JhOgf/qNRDQfABnpn2fKAXeLLkVFyVY4
	 8alesWTJw0P+LPL5ZUeybCJoHcNQcSBAwjPw1xsTeVJJPMyCgocdecSsA3u5j568zi
	 aL+sdbQNOO7MOoCyk14G5R6n8SM2z1wX/KWfDDdJ8yITwXmuWctQA/6Zs1RAQZ6DpM
	 A6xAjLWTGR0wwOcDs507FUyDX0svboWGe94+qthO3C6U+jZ/LrFAY+0srmEhu5A9J+
	 QOqeXvzqvDEjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DC524056C;
	Tue, 27 Oct 2026 00:25:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C986FB91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF36F60607
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BNBAuwVgbgnj for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 00:25:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 751B8605EA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793060757;
 b=DQTpHVwv3uZdjC77hL9uJ1Cido5bhAy1d/Fo4sRrLqqBRBcSA6101N6qUdwDXRO1I2ng
 Myhg/iv6KpmwlDqESWG2VTouD1O066SIdN9BJLOfLBcfSo1byQdpAxM3psAJn2SF/1O5g
 NsGJ4gweIbcYRXELbPFHBFS3RxlG7aufOlvbqrljju2MtLrTccgLFhBmTm2Y8ZULvq4YN
 J8twc0v5RkG2PHSBeogDSSljJS6hDsImr4LHkToEjmF9lRaEMbLkQpXykjxWQ9pSqXtK8
 pvvmeQGSRLz/NA0s5NElZrEdKD7Y+qVL/Fz1W8+HlVmVHTvhSSkPuL7jLDgsk0H4NtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793060757;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=0pR0INajTOqgCE/OAl0EqIXMJQqWzUQpenXQJ72vlF4=;
 b=Zz+agG0iK0XqcT2xzRk54QdzwjBNRITVs9WIHLwMQip73UJ4Xfkugeiz3sV4DyssPwJJ
 I6O8InyHH+ZeWHqx5tF0Mq9Bi6Kpd6wdJ83CqOtFG/t/VhxRRFNA604Gg33yPN/z5BCKP
 8zMw5kp8ON9PNMVYfzgFQbtRCYEGxSm7cRlf4HwyZWl388J0VIpKR9kQG0rWMdltbU2Bs
 or4uda5HBoDRXuZqeEvRTSd22HWIXw9fw3vfI2yI1r7Wr41LB/ztMro90vOCnoZUmRE19
 5JL8dcNGJLw6LJgILwev0zWIX/rh9z/SUFZ42+XIKUapIo5HvU5bdkKM6vIWdaQpvmw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=bOjcfgqS; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=ge0fwdai; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=bOjcfgqS; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=ge0fwdai
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 751B8605EA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793060749; bh=0pR0INajTOqgCE/OAl0EqIX
 MJQqWzUQpenXQJ72vlF4=; b=bOjcfgqSi1Oym0Ofqif8owor7B/fcSjzeXLZOehi80q6syrc4K
 oOQp9pLc28uXz9ZIQ4nc1DmsiC6Az9y3q0To5xl9dqwgGood+hTzunMhs1yJZcToII7RLv1tAA5
 rS3ch46VJwx+xYIefLFpNlVBrCKfOGkH2+b+SM0Ttrr5WXzwmFh1dDBZFhiM0b3z2uVdC10+qgI
 KfIspfH1uVttCr6p40sLrYYsKxKF/05P/bIjkkXcVscWxx8P2g1/2sKqpa9n8yL2qxZ0VV45jrk
 swwRGw0QxSpKBnS2fx1cEdqHlZW0GUFqk8lr3InA6k4NbfJd8T2nbAE58Rd9A0inZug==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793060749; bh=0pR0INajTOqgCE/OAl0EqIX
 MJQqWzUQpenXQJ72vlF4=; b=ge0fwdaiki5A/uTXZRlgng9aZ2FBg28dUdPJzBf8Tl+F/0rbvo
 W2TlO8o5hmcBFTfXzH8Vv8KguXfVKf6n4iBQ==;
Date: Tue, 27 Oct 2026 00:25:48 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>
CC: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <20261027001923.GM646438@bill-the-cat>
References: <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
 <20261026172332.GE646438@bill-the-cat>
 <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
 <20261026183010.GI646438@bill-the-cat>
 <04F0CE3A-448A-450E-A49D-CA01BE76CF04@mainlining.org>
 <20261026211952.GL646438@bill-the-cat>
 <49FFC097-8DAD-4424-BAED-823C55BA3524@mainlining.org>
 <20261027001923.GM646438@bill-the-cat>
Message-ID: <B40E19A5-99C4-49F6-AF13-D0BE0D682404@mainlining.org>
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

On 27 October 2026 00:19:23 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Mon, Oct 26, 2026 at 09:27:05PM +0000, Bradley Morgan wrote:
>> On 26 October 2026 21:19:52 GMT, Tom Rini <trini@konsulko.com> wrote:
>> >On Mon, Oct 26, 2026 at 09:14:37PM +0000, Bradley Morgan wrote:
>> >> On 26 October 2026 18:30:10 GMT, Tom Rini <trini@konsulko.com> wrote:
>> >> >On Mon, Oct 26, 2026 at 05:27:05PM +0000, Bradley Morgan wrote:
>> >> >> On 26 October 2026 17:23:32 GMT, Tom Rini <trini@konsulko.com>
>wrote:
>> >> >> >On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
>> >> >> >> On 26 October 2026 16:58:47 GMT, Bradley Morgan
>> >> ><brads@mainlining.org>
>> >> >> >> wrote:
>> >> >> >> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
>> >> >> >> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
>> >> >> >> >>>>
>> >> >> >> >>>>Hi all,
>> >> >> >> >>>>
>> >> >> >> >>>>Just a data point from a user: we are using U-Boot on a
>T1040
>> >> >(QorIQ
>> >> >> >/
>> >> >> >> >>>>mpc85xx) in a product, and we intend to keep up with
>mainline
>> >as
>> >> >> >much
>> >> >> >> >as
>> >> >> >> >>>>we can. We'd appreciate PowerPC support staying in tree,
>and
>> >> >we're
>> >> >> >> >happy
>> >> >> >> >>>>to test patches on T1040 hardware and report back.
>> >> >> >> >>>>We run u-boot in 32-bit mode (not sure if it is possible to
>> >use
>> >> >> >64-bit)
>> >> >> >> >>>>and
>> >> >> >> >>>>linux in 64-bit.
>> >> >> >> >>>>I am in the process of bringing it up to our 2025.07 branch
>> >and
>> >> >> >> >>>>potentially
>> >> >> >> >>>>mainlining as much as possible. We have some remnants of it
>> >under
>> >> >> >> >>>>`board/keymile/kmcent2`.
>> >> >> >> >>>
>> >> >> >> >>>Would T1042D4RDB affect you?
>> >> >> >> >>
>> >> >> >> >>Not directly from what I see in the code, as long as the
>shared
>> >> >code
>> >> >> >with
>> >> >> >> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to
>> >> >report
>> >> >> >that
>> >> >> >> >>there are dozens of us using powerpc :)
>> >> >> >> >
>> >> >> >> >What you could do if you would like is to test the whole
>series
>> >to
>> >> >see
>> >> >> >if
>> >> >> >> >it unaffected you.
>> >> >> >> >
>> >> >> >> >
>> >> >> >> >Btw tom I had a idea: you merge Vincent's bug fix and my
>> >maintainers
>> >> >> >> >patch,you make a PowerPC custodian tree, and I handle the
>series
>> >and
>> >> >> >the
>> >> >> >> >naks and stuff and the comments.
>> >> >> >> 
>> >> >> >> and btw yes I'll make the pr with the finished patches so you
>can
>> >> >merge
>> >> >> >> them cleanly
>> >> >> >
>> >> >> >Trees are relatively cheap, but I'm not sure we need another one
>> >either
>> >> >> >for the subset of formerly-Freescale and not-QorIQ PowerPC parts.
>> >Since
>> >> >> >I added you to the fsl-qoriq tree, you can also just pick up the
>> >> >> >outstanding fixes and your maintainer patches (and leave dropping
>> >stuff
>> >> >> >for now, as this series shows today we're just getting people
>having
>> >a
>> >> >> >chance to see and reply to this stuff) and send me a PR. Thanks.
>> >> >> 
>> >> >> Hi, sorry, I didn't clarify enough, so I had a chat for some
>people
>> >from
>> >> >> the open src firmware slack, yes?
>> >> >> 
>> >> >> And here is their answer 
>> >> >> 
>> >> >> "Ah, Peng Fan maintains the FSL QoriQ tree:
>> >> >> https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq
>> >> >> 
>> >> >> That is the vendor one though.
>> >> >> So yea, I'd go with a general PowerPC tree.
>> >> >> 
>> >> >> Also because QoriQ is both Arm and PPC series. :sweat_smile:"
>> >> >> 
>> >> >> And even my slopper suggests the tree, for sanity purposes :D
>> >> >
>> >> >Fine, trees are still cheap. There's u-boot-ppc now. But please keep
>in
>> >> >mind everything else I said, thanks.
>> >> 
>> >> Thx. 
>> >> 
>> >> Question: will you merge the maintainers patch on this PR, so I can
>> >focus on my add-on maintainers patch and the removals?
>> >
>> >Lets hold off on the removals a bit more, as I was saying.
>> 
>> That's not what I meant
>> 
>> I meant, you'd merge ONLY the maintainers patch in this PR
>> 
>> Then, I'll go and take up the removals, and give it say, a couple weeks
>to
>> let it marinade, and give it responses THEN submit a PR with the
>removals
>> in it. Then happy days.
>> 
>> 
>> Or I could also take the maintainers patch with me too...
>
>Yes, please pick up the maintainers patches and if I follow what's in
>Peng's queue right, there are a few other powerpc fixes out there.
>

Not in this PR, maybe any on lore that stands out?

lx2160a is ARM

nbxv3 is arm too.

I'll look harder (maybe I'm wrong) soon

>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
