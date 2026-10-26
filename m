Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9163606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZEAvTS+Y;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=a053IHC/;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=qID5EQue
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 993F880CBC;
	Mon, 26 Oct 2026 21:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fLn9FM6fIV8Q; Mon, 26 Oct 2026 21:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8ADF880CA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793049287;
	b=LbdNqXjQeN2DyYAEpxHNzVfszSMtmgsKD6PSxXse8q4lmAQZer7OQghsJIHEjeYRmUms
	 ApDt8s242Zf/s1swgQO38rUvYX97+sqIabxY6p4ueBuZJRhV3IGXzY7gf8vP8gOLbmYgP
	 jVoRZrHLXgpQdkzNyryIIB3/vtHfkqyWAmtOET379Xel49Xz8od+u7e3ey4ipZ0Hcv80A
	 2eLSKg/Y+JUlyWEgybFMKZ9i/0y8LIB3juX8Jsg2+QvkX4YnHM9/QJbGY6aSOCkdonBzV
	 o38NJl/b5M6rFqaJ84vxSYqK2wXN+pyVU6ntPhKtnDaAeQOAidlZeh8gOtWiX63cBNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793049287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g4ERWc8nuAPyA+3YSm9Q+1I6fK6a+3y5KlD/qPURJOY=;
	b=okPC2qSmHV+zgaLKhb7mlS6YObxrU9Acvx0ClqQ6gdivuH6kSKszM4nuol/bWXRbnsYI
	 4WWCwufmu+VZM5G3DazfuiD8Yi7aryWMUZPNtsm2wgXkOy26y0gRKmlcDRmE3TiwIJjDq
	 D3Et2MwhurY+eCAaD0O/q9KE1rPTwEpvo9KI9TSvkfjgCqeWmmHJftCpNwB/EM0wc/fVf
	 VG1H7q7O47yK0ASs80t141vOsZUjN1mhdwGYP4x/KlJtnCkp6Pj0D1o9/7sEf0Hbm2HI9
	 8iB7Vge5qQhk/eM+J4BVWKmGcQj8livfJWHcijeZEsu89PtquZlCVeccTT/HlirUm7Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b="a053IHC/";
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=qID5EQue;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793049287;
	bh=g4ERWc8nuAPyA+3YSm9Q+1I6fK6a+3y5KlD/qPURJOY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZEAvTS+YoZg1BpcUG+e9Czy9WAguUQ6fgbchW4UwvX1IRSKIO1I7uwryMEcP5oKEo
	 GonJ/Wowkdxd/cASk9aUjlCnsN0ZRpX+f2xk8tuwBV1lzaf7m+wX+IU/PGeTbPuXyR
	 Q/6Z7go7Z9xzwt+rxtBVPPtlGqTUieZ6UAdOoMCLbv2t9BJT+TzJK+RS6OapgsSHcc
	 zbhI60TOXqXIzET1FqyZ4+8YXAfGTXqyRKTAegZYkaysIwa0Wnx2GU2As4vVVSwk0q
	 t9Kgkwey8NI7aWHqVGbfAs/Iw36kwUrZWomP5uJeNaLNRh0L71ugGl1JvXhEP0UN2n
	 /na/Sw/vJrvqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ADF880CA6;
	Mon, 26 Oct 2026 21:14:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C4DF235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5299880C92
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXaKpY7OqTc7 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFBA480CA6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793049285;
 b=J5uxsLfNr5EDkaWcOX7+NoY4zTRNiHMuIrR4KWADjqg2/L2it23WCsyaN4UsMkwWBVch
 0xGM0UbnwhasfaKU7LSz+jofJ4IkGKjfMnqf/jP/qlNXGnkY/f4w7mtZypB2y2B3oi7pq
 WsAsZcVbr2uy3a9fag+ZFzceS9TzWuTlZuIM+dHzPFcMvD1YkAlQumAXZ5xjUkV52riQr
 bHcyklS8iTV1eRvM7Jl5mzqyLOUE0Cw3W/3P+Hf1BySdQ6o6wHAwwB1X1nk5AYgkySY30
 0XD7CWgXwDTk57g/MGgQGUBUhry84btXd73U0lfd6AIIPsfxpRj1LJmdf8v/HkQu2Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793049285;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=g4ERWc8nuAPyA+3YSm9Q+1I6fK6a+3y5KlD/qPURJOY=;
 b=r0ttfQqbHsTaMz8KzyKhy0BySCJ6pFvwqZdHbXbqaDEFzZ1hcHcXPGJq+hMdJ+RCIVfu
 m5PWB4Se26UYcCzsDcc5Gzn2yD07gVwtwkHMchYe4u+ctmPWo5hGqt37MQ27+UFzKRoF8
 Q0ycT48hStPj4a5YWCqhRkX2Qsyy62ST3AfFEMZ/NO4M7HUz3htx1UdLSHmxmFSVKMcIW
 eqhbmalTZCFGFTzm+14dtnYv4ywz03cGyz9930NJRZjU7Ocw9UagDqcFe1sueu1JOar2t
 o6P6Q8FmFULPwGXr1YEaIcEot204ArO0q6UdwNjrcsJ5SEUQnu13Xvjr0pu6/35kOUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b="a053IHC/"; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=qID5EQue; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=a053IHC/; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=qID5EQue
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFBA480CA6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793049276; bh=g4ERWc8nuAPyA+3YSm9Q+1I
 6fK6a+3y5KlD/qPURJOY=; b=a053IHC/qVaXoS1fnGxXQsfkLE4vIDF86bMyFQvrKLypka9C9N
 MKl/smM/jqVKVd6hduJ+8hu4LmLgOjmhqOO5ZqKt/K1eAc2LDfPaGS02mk3xkgY3peKabal165d
 fRB6FB5z8o2IutGMPdUqB9rqrXhKUwQGFVX+ZOOo0hDjZNsPTW9lQplGbyqOjEUqMuPdA5qyuDl
 JWagnSqvb5CvoXErJPZ0q30FiQq9HYeqSmbWKDJiyu+2790da7wZsSOW98qnpXDsYe4vcG58m9W
 ArZTdnuNR6G9nRzD6szi2NL0CnjQb3zEF6ZWaI9F4yZ//cBcpHDYVIqdLJ1vmp2o4rg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793049276; bh=g4ERWc8nuAPyA+3YSm9Q+1I
 6fK6a+3y5KlD/qPURJOY=; b=qID5EQuec7vJyfG5V1VvLLUjtZ45N3TTCQVT7IJP1AKp1nkHvw
 lg3cBt6cx6+w3/s4alg6VctEtRLMgPEBGSBQ==;
Date: Mon, 26 Oct 2026 21:14:37 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>
CC: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <20261026183010.GI646438@bill-the-cat>
References: <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
 <20261026172332.GE646438@bill-the-cat>
 <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
 <20261026183010.GI646438@bill-the-cat>
Message-ID: <04F0CE3A-448A-450E-A49D-CA01BE76CF04@mainlining.org>
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

On 26 October 2026 18:30:10 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Mon, Oct 26, 2026 at 05:27:05PM +0000, Bradley Morgan wrote:
>> On 26 October 2026 17:23:32 GMT, Tom Rini <trini@konsulko.com> wrote:
>> >On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
>> >> On 26 October 2026 16:58:47 GMT, Bradley Morgan
><brads@mainlining.org>
>> >> wrote:
>> >> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
>> >> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
>> >> >>>>
>> >> >>>>Hi all,
>> >> >>>>
>> >> >>>>Just a data point from a user: we are using U-Boot on a T1040
>(QorIQ
>> >/
>> >> >>>>mpc85xx) in a product, and we intend to keep up with mainline as
>> >much
>> >> >as
>> >> >>>>we can. We'd appreciate PowerPC support staying in tree, and
>we're
>> >> >happy
>> >> >>>>to test patches on T1040 hardware and report back.
>> >> >>>>We run u-boot in 32-bit mode (not sure if it is possible to use
>> >64-bit)
>> >> >>>>and
>> >> >>>>linux in 64-bit.
>> >> >>>>I am in the process of bringing it up to our 2025.07 branch and
>> >> >>>>potentially
>> >> >>>>mainlining as much as possible. We have some remnants of it under
>> >> >>>>`board/keymile/kmcent2`.
>> >> >>>
>> >> >>>Would T1042D4RDB affect you?
>> >> >>
>> >> >>Not directly from what I see in the code, as long as the shared
>code
>> >with
>> >> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to
>report
>> >that
>> >> >>there are dozens of us using powerpc :)
>> >> >
>> >> >What you could do if you would like is to test the whole series to
>see
>> >if
>> >> >it unaffected you.
>> >> >
>> >> >
>> >> >Btw tom I had a idea: you merge Vincent's bug fix and my maintainers
>> >> >patch,you make a PowerPC custodian tree, and I handle the series and
>> >the
>> >> >naks and stuff and the comments.
>> >> 
>> >> and btw yes I'll make the pr with the finished patches so you can
>merge
>> >> them cleanly
>> >
>> >Trees are relatively cheap, but I'm not sure we need another one either
>> >for the subset of formerly-Freescale and not-QorIQ PowerPC parts. Since
>> >I added you to the fsl-qoriq tree, you can also just pick up the
>> >outstanding fixes and your maintainer patches (and leave dropping stuff
>> >for now, as this series shows today we're just getting people having a
>> >chance to see and reply to this stuff) and send me a PR. Thanks.
>> 
>> Hi, sorry, I didn't clarify enough, so I had a chat for some people from
>> the open src firmware slack, yes?
>> 
>> And here is their answer 
>> 
>> "Ah, Peng Fan maintains the FSL QoriQ tree:
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq
>> 
>> That is the vendor one though.
>> So yea, I'd go with a general PowerPC tree.
>> 
>> Also because QoriQ is both Arm and PPC series. :sweat_smile:"
>> 
>> And even my slopper suggests the tree, for sanity purposes :D
>
>Fine, trees are still cheap. There's u-boot-ppc now. But please keep in
>mind everything else I said, thanks.

Thx. 

Question: will you merge the maintainers patch on this PR, so I can focus on my add-on maintainers patch and the removals?

>
>

--- Thanks!
