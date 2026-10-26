Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72386606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MsnfQJ+e;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=N2/T/rRZ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=0VL1nxO6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B71240782;
	Mon, 26 Oct 2026 17:00:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GsZ6Wm8Goj8f; Mon, 26 Oct 2026 17:00:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 886C740774
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793034026;
	b=EBqg4EO1uIw+W7PMcPiuw6XN/d1HIsBN1hB4xboPYWRA2gkaO9VYBejf68Frc04LQtj1
	 Cp6ydIZTW7TzapMZVhQ6rxGcc2LcZknQeG7AY/gWY6ZIgsuqP7z3zXCpVaGXH9zliOsWM
	 uF+EQVVQ8CKBsdNLdVBiq3RX5SkKfnrmzm3VwFrlp0rmqT/z2BkYJCCEA9nyeb6dAtZzV
	 O7NJ1hEGFu0SWN4jnO1E8/6/+5/0oWxFPO/+BkRmb1hEtPCMRo0VnwTX6Jbzj/0Rq3rYx
	 fPEycse8GjY9VAcn2VxWkNfm3Mxpaa7+jdJlvLPp+6Ouhz+bRvSU8N7nIAe69l6JgnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793034026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZcMir7f2uSbPe/xIZSNH9q4TUnUY8+1twImF51ZcMhI=;
	b=C5Gin7BgoaANXXDneENrsII+3V7uQFiANMWMfaRKsLFwjqXJKJDM3Raz9Q5dWn+lMyWF
	 SWu61GJanI+MpDtwe7VFWGZ35x0hF1A9g5SoPgk8QaOSCrgbq4kqER+UHyGwj5CyudpI9
	 SOKqq80tcRc+tKp1nqJvadt77xy02yudCHCK6tRR/ZsiWx9EjBYgA+fn/y/v/NsPEW3ON
	 5PaHULPo40ufXTtjeggnq92rPu/OdU+5lWDUKnmKnIJ9nfAT6ZO1vWfix6s/MIuwp8l7F
	 EbQgBPa2KiAYjWfXRDtH5ZhBAEzlRjtW+L2Y08gGljz/hLR9VEl61cIMlNvxgD5jazw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793034026;
	bh=ZcMir7f2uSbPe/xIZSNH9q4TUnUY8+1twImF51ZcMhI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MsnfQJ+eXr5yPMvCND0HI70cDLyfl0y09t6FWREqLqHU08ewOl1Td28EyRu9TdG7l
	 1KPUMXBmp0//kAyURalhNhN0gYvCCgQw6R3zATe0yn420wijR3FuTc2+SgMd8pLKly
	 IfUntZ5GeyKIG2bFJ0hHlFviVmE/Ztt5743ABJNdW5O9nW4q93NqZAEbMwgWg73nbd
	 BSb5DkfASis0HedUgtIkoytO7Kk1cG3ZGO+6QmOvRPSSF3uLetsBx4DNW6jLjoDWJU
	 yOhR9GHAy681qIteAQTRSwk1Ky7FMFCpJ2eLiNB2Hg4KO7yJ77lbDn1y5Ah/3lbUhE
	 EXEXKbOJVmIoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 886C740774;
	Mon, 26 Oct 2026 17:00:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E85B1235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BFA360603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FSR8n0KRsotu for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10050605EB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793034023;
 b=E+Z2s5+sLA7pRgcli8jfXCKEnHuJTNNE2Va5oCvcNGExYnRi+/L4QmEE7mLYIFq7ZTSV
 UP/zWy+O2G/K7GdSgo+OoG8pMsPDcMrdGc9pNwz7YOJis7+ce+/7Zk9b7U2IzWduE4l9V
 1Bi5slFIxeb/uux44R0R/Q6HGHHOE90I6V3KY1wz7q4lyEx/02epqmWqgg7p83UO4jd0Q
 GaewNhx1WV0IQjewp4mXFjznB/FyQHcMhXdnbMREoKSJ88xidqeouA2HtZ+jlnvhWLs68
 6DYP4HrLcnACoAz4KoZ5VnpU8HJRDLJved0TlV3XYUCAuHiXuo0wBi4gcVQtjbjoe7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793034023;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=ZcMir7f2uSbPe/xIZSNH9q4TUnUY8+1twImF51ZcMhI=;
 b=KWvi3tYFfrNXYdiQFtd2KXuOJk9mVnmQXAWJIMvzWcjBD+8XsrnMs3inUIiAQnb3Berw
 1gIi8q9DGSjbfJb4UzzaYhlwBHM30ZGubaMtqNHdhfKtob630j13cE9uruKYa8YZAtTeK
 ln2IZS3LPGS9g0jjQbkciZz2bIN6q97/g5xMGEfauZrI62asjv0GeUlCWJP7NUxc5eIc6
 FAoR/Cgz3TjjQ37QuV66eqZxrfG5CORTocxUDOUcbQs6Qaj3mPZMAIUPbg3luPlJ59cER
 Y7l9IQVTf6Q9Cc+0cCc6sZpLiTwWtg48mt/q24uhlNK4N9VrnVNpTvg7YRDkVK8qpFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b="N2/T/rRZ"; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=0VL1nxO6; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=N2/T/rRZ; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=0VL1nxO6
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 10050605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793034018; bh=ZcMir7f2uSbPe/xIZSNH9q4
 TUnUY8+1twImF51ZcMhI=; b=N2/T/rRZSXGl2z4seD3hvUmpixdyuzp7qderXaQmN82lYZ9ovs
 aY7yl7qN6xvCKwvdr6M3Se7d+v94NIxpsyrVxBhRS5J1bKzlGdmh3S1NzzuihW2EVobbiBV8Qls
 2ikiWvdtvBROTIlMNJLDRqj1up9JzwJQK+0CTMZQ5y0NPQdv1SFPGUndX0u/eUPwFQhG78DKmLM
 EPvzVzxiSBeI+2JarH3SXA3Gu2jA+Q8ieg7aLf5XHPhsKeej/Kmfe/kcmFIj+UaNZssYdZEarL1
 Hz7xCWXs+KFc2m1OtC88+QJfst4NQ33QoimMJ8oqxDCJNLdaO/mNWsQhaqhe9GPxOzQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793034018; bh=ZcMir7f2uSbPe/xIZSNH9q4
 TUnUY8+1twImF51ZcMhI=; b=0VL1nxO6zvSq4TRpbJkHoBiSeoFi6YHo1Jsjm6DRxaGT8mXmu4
 Zf47Nqo2UhP/UNFdytv7ppcMSETvDwY4c6AQ==;
Date: Mon, 26 Oct 2026 17:00:19 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
Message-ID: <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26 October 2026 16:58:47 GMT, Bradley Morgan <brads@mainlining.org>
wrote:
>On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
><tomas.alvarez-vanoli@hitachienergy.com> wrote:
>>>>
>>>>Hi all,
>>>>
>>>>Just a data point from a user: we are using U-Boot on a T1040 (QorIQ /
>>>>mpc85xx) in a product, and we intend to keep up with mainline as much
>as
>>>>we can. We'd appreciate PowerPC support staying in tree, and we're
>happy
>>>>to test patches on T1040 hardware and report back.
>>>>We run u-boot in 32-bit mode (not sure if it is possible to use 64-bit)
>>>>and
>>>>linux in 64-bit.
>>>>I am in the process of bringing it up to our 2025.07 branch and
>>>>potentially
>>>>mainlining as much as possible. We have some remnants of it under
>>>>`board/keymile/kmcent2`.
>>>
>>>Would T1042D4RDB affect you?
>>
>>Not directly from what I see in the code, as long as the shared code with
>>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to report that
>>there are dozens of us using powerpc :)
>
>What you could do if you would like is to test the whole series to see if
>it unaffected you.
>
>
>Btw tom I had a idea: you merge Vincent's bug fix and my maintainers
>patch,you make a PowerPC custodian tree, and I handle the series and the
>naks and stuff and the comments.

and btw yes I'll make the pr with the finished patches so you can merge
them cleanly
 
>
>>
>>>
>>>>
>>>>If any of the planned removals or cleanups touch T104x/QorIQ code or
>>>>boards, please keep me and holger.brunck@hitachienergy.com on Cc.
>>>>
>>>>Thanks to everyone maintaining this.
>>>>
>>>>Best regards,
>>>>Tomas
>>>>
>>>
>>>--- Thanks!
>>
>>
>>
>>
>>
>
>--- Thanks!

--- Thanks!
