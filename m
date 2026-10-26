Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048B606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pK/c4dMQ;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=EF4PZ4Kj;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=+kYCHaa1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EA48407A3;
	Mon, 26 Oct 2026 17:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYC-xRflsDxD; Mon, 26 Oct 2026 17:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FA1340786
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793035636;
	b=mhUvsNz1o1VCLI4OVV6fCEN/yM83B1qFSIr85CqFEMqxx/f8LcU1Z/jxL1gUFfcR668F
	 M13/CT5BFz/lkskJ4z4xSHqNDC1pG5FTzYI2TiOO/oEgWHSBc3APaf4AUVcC3emyQW9Sh
	 5UMbHDS6I58TCcryD/dHtOYdyIunAPAn75GLkb629sEVDHcDoRKKlm998/LWwFYIOQsdx
	 HeUl0oiNfErKGsJNx3TdOZkD5wKzf9fx1K6ro7wYreIOllTFrAL2mZqASQLY84vjbWwjE
	 mT9YIcCeIdFFR60dIgyyflEhhvBN9d6Gp+AAFWtLBtOX6o4KDSxFsnQXKVavyEU15Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793035636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CYyhFHbURolcTnPD+23Gt1AkJjVr5hwgyaroex3Eq3I=;
	b=oqtxrnlx2GyVRVTF4IC0BcqoRme882PmVjHIPmAZk5aGuJDILriqWvRL5BT0FkKWuiSh
	 NdBNuB+e8EMlI+CCt7DcAwWNTx6U062LxiJk3HOwThgttSn+IheZhkd8vYgdECVyTsSBI
	 tZ7zH8O1rEObRAGQVrHwvr77zzI1qtniRZRr2LfDcpptUGpfrMdJVdIJ/baDpY5MhyAs7
	 cVfG/nEpdlAWc07Vg21hczLAwLI7c6aJfTUb8Qi5HnYC8n5ePOggV8twM8bMMjhMq+ker
	 etNf54Jh3LtuoYTsLdGMOZXg6gBKkOD0iTOAF0axcLP5GLUvlviKrcvfT2j5xyF8Cfg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793035636;
	bh=CYyhFHbURolcTnPD+23Gt1AkJjVr5hwgyaroex3Eq3I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pK/c4dMQrMGBYG6dVkTNWP3/x66CeBZwYAJqET/Yc2fSlUPzMAuYZkBBPih3bXdWr
	 P1zK7Hu3jX1FW4tuvMt68CVuviOZQRieqnRJBdvgDaNYtz2kDL4Guw3zmKTFOOGeHE
	 f9iFdfQbp8w4EoiqaSt60l+eCxCPiuntL9v0NkzUTkS10isZWByK8rgU5qgmmRy7Vz
	 IWoH6hS4oEbGsl8Dp3bhytwCCPPx8VK7z55aDAzPrXf0ZEFQnPFZOBot6tQP0PigT/
	 L4QgAtpFoxmUpbesjyzSo2GlmGYPCziDjm94TShtRCSNvxsFUefGII96OJR1DNZznM
	 u6GjlalDciN8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FA1340786;
	Mon, 26 Oct 2026 17:27:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FD60356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85E9E40075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id agrXbXqq4rUf for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:27:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2EC1140062
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793035633;
 b=h4lCZ7LXbRH3Ddv36LXyIgmA+8OWgAaAtovT8yz4pnyyxh2yHqoCnW3hZCVS2E42FtoK
 5mYAl4iXMF6hRnaXr/bpiGpyMRT02+7z6Bw5ZuhvVPY0mzNfBKrqhPqZwDqJKR5zFDz4a
 /9MTwVbGHNs0UAoCNHB/iCvAiXCdmr9G0lg5bGbUbn+FqpLLEC1X1Z2zec9neoTAXrkpH
 SR/Zboi8yrgE+HAaojsVKjB6TFqjvP4MgrH7iVYP2GS1wYPbQOOBg5CdWxQth8GTdjUMQ
 GLWI9cleicCNDi8+yyB9JkBh0BB61ctSnBtIpLIEShF2h4ZqlbrSslqznmDxypT0i8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793035633;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=CYyhFHbURolcTnPD+23Gt1AkJjVr5hwgyaroex3Eq3I=;
 b=R6RjxJC8T+PlWt5D4RWBkt7HfH7YMNwSAgYYqOQH0/bB8ltNI9pFj4xBn4FX9LoFoO1q
 07Gb/ykkQUo8lrVyidKx5NY9RkKOqHdea4BDDxIRWfs68Zh16tqUcEGAsf1LUX6KKaHsa
 1cJ7PNlTMyk5MGF2MiWPqEzUL304oeCWfy4Hn8RWFiMPznsKdNGOTfdE7NC9RdjgIBvJJ
 Gogx67ZxasEymGhX3lu5qvePaacWM/uKV6mBO6ppBwdJ3/5/ls0Qcz5QsJyOnTNc3L9Zb
 sTjrs4d/Vn6Uxq6UMJ+nL/XL4tTqpBqV3+JQ4NR/gm4tLecAKQh8YdcABpKK/oNGSfQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=EF4PZ4Kj; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=+kYCHaa1; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=EF4PZ4Kj; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=+kYCHaa1
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EC1140062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793035624; bh=CYyhFHbURolcTnPD+23Gt1A
 kJjVr5hwgyaroex3Eq3I=; b=EF4PZ4KjIvjw8VUgOBXG9IZDoF7qrVeFPHO9Pw7T+BUhM+o0Yj
 AwDPMMbAgUKQdcViXnaWpjKKCWfYgoIfPD9j4s74tnhNcKlQ49MxJkMDeIy7+KOMa9MKJFkdl1i
 zrLSqHqzvQmNd4xyPtIBQFg3R3+HFxU1Aap7uTOhSTF+TZ4rMXQL8P2LFxlQIqkqKVrmNDvi9mh
 TUFw3EL9zIDt1A3rm1WpCzVxyiMnb9J3DmSRTz0KGlAU7JuA6YdnEBRhBDVzAw7Nb15hPxbl3Wn
 wbMf6sVIclf7DkhF/JAC7k6DtGD+Vo6fCBEPyD39aJ7VmQ2XrTn+OGUjwWOKQCffOHw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793035624; bh=CYyhFHbURolcTnPD+23Gt1A
 kJjVr5hwgyaroex3Eq3I=; b=+kYCHaa1m78fkA2jDLjrjFWVshQ+qPelSl6riDc2mHnTH7jhgL
 E61EaJcWpiSFmZSG1SenYwhvElJhl1drxrAA==;
Date: Mon, 26 Oct 2026 17:27:05 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>
CC: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <20261026172332.GE646438@bill-the-cat>
References: <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
 <20261026172332.GE646438@bill-the-cat>
Message-ID: <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
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

On 26 October 2026 17:23:32 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
>> On 26 October 2026 16:58:47 GMT, Bradley Morgan <brads@mainlining.org>
>> wrote:
>> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
>> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
>> >>>>
>> >>>>Hi all,
>> >>>>
>> >>>>Just a data point from a user: we are using U-Boot on a T1040 (QorIQ
>/
>> >>>>mpc85xx) in a product, and we intend to keep up with mainline as
>much
>> >as
>> >>>>we can. We'd appreciate PowerPC support staying in tree, and we're
>> >happy
>> >>>>to test patches on T1040 hardware and report back.
>> >>>>We run u-boot in 32-bit mode (not sure if it is possible to use
>64-bit)
>> >>>>and
>> >>>>linux in 64-bit.
>> >>>>I am in the process of bringing it up to our 2025.07 branch and
>> >>>>potentially
>> >>>>mainlining as much as possible. We have some remnants of it under
>> >>>>`board/keymile/kmcent2`.
>> >>>
>> >>>Would T1042D4RDB affect you?
>> >>
>> >>Not directly from what I see in the code, as long as the shared code
>with
>> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to report
>that
>> >>there are dozens of us using powerpc :)
>> >
>> >What you could do if you would like is to test the whole series to see
>if
>> >it unaffected you.
>> >
>> >
>> >Btw tom I had a idea: you merge Vincent's bug fix and my maintainers
>> >patch,you make a PowerPC custodian tree, and I handle the series and
>the
>> >naks and stuff and the comments.
>> 
>> and btw yes I'll make the pr with the finished patches so you can merge
>> them cleanly
>
>Trees are relatively cheap, but I'm not sure we need another one either
>for the subset of formerly-Freescale and not-QorIQ PowerPC parts. Since
>I added you to the fsl-qoriq tree, you can also just pick up the
>outstanding fixes and your maintainer patches (and leave dropping stuff
>for now, as this series shows today we're just getting people having a
>chance to see and reply to this stuff) and send me a PR. Thanks.

Hi, sorry, I didn't clarify enough, so I had a chat for some people from
the open src firmware slack, yes?

And here is their answer 

"Ah, Peng Fan maintains the FSL QoriQ tree:
https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq

That is the vendor one though.
So yea, I'd go with a general PowerPC tree.

Also because QoriQ is both Arm and PPC series. :sweat_smile:"

And even my slopper suggests the tree, for sanity purposes :D



>
>

--- Thanks!
