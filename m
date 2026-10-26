Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q2KdRta1;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=poG33qz7;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=l7fqhmAi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 546B04077B;
	Mon, 26 Oct 2026 16:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xRYItMDfjVE; Mon, 26 Oct 2026 16:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 90D9E4076E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033956;
	b=kO+PhKVol5Vr8EH0MHf+1J0HH1dNrzPnzyV7e1eVzdnjw4nhGdpj1WTCTuXNXbkK8NKN
	 NIZURhHgRffQh433tS4IghOpsz699Uokt4NZfhiCI1SdVLtItRHgo6u2CZ0K0MctqICQN
	 gVwwJBLlfnQ+I778yrdfIcImxqaUGZvlKZoL2kLqcYYSTYjDiBQ2IVwjMcnViyV5wEWzc
	 gOTL+EJWuKmHniFHUxVBFNEs+qeB1e2pqyc8S0uEz9Ff9DleC+8K8/2RujKT9fTMLtdkE
	 iBTcQKcpK/z17fIg6I8e3f2Z8aCOO0ZjX6rmgGSmZYjbfHqiwIj8UgaDn4iDgE6BcDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793033956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0ZwaNRSP9C7b4vWsUzh5mMK6qMOHVDho+XFiwhapFHQ=;
	b=Qvr7v3BkF0JzKMNuo4IczT9ko9Itwk5U0lYWq/ibd1SkJ+fFriY/Fu1mHm7m02wadwsy
	 1aRBmesa/MsNOM7A+1JvHlnJbsZFhuTj9BsfrV6Ep8ozS108kKhcvNWceXFOizcywGcme
	 6U5U1H/uL9iMbns6y+x/MgGdHXkcPs1R5EC7/jF4Pj28cNmSa68jijda3om7ocTgAbj+C
	 uHJxeoVCInwos3ULoDl/6WQz2qWr0kMA0LtLmXg/+6pmGT+49q+k1EDzCZ07SBU4hEBIu
	 KzZdewGpjrcHWjjq86b5vFPOO/zLtH7S7w3dnuWtU6N4O5N9XkNLhS73auIFG3KXylA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793033956;
	bh=0ZwaNRSP9C7b4vWsUzh5mMK6qMOHVDho+XFiwhapFHQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q2KdRta1tbFpVK4JMciJuL1LKvWLTzr7dPFkOjh4GUGWGAEUm688B77iqsH1pFYuh
	 NVtkBofdJ1MbxfYqR2iKbf+dVhxQkAbihF0a5bdRst3ewZARmCwdqgN6wFA4CH7I/I
	 U3kZfvumrV/Iq8sM31Jf0zt55HXTsJWOSfiMelJJcGX03/Hqrv3fDIi/iMunLLh6uG
	 xuOCyay/47nNdhu4tNah7YNSxdf723slNJE7n5B0GVBt2WFR/+3nDoKKVH8v3FM7Ej
	 tp7hIH41CI/5XmD/3Ij+LsTnqER3aFi9ZP2EUwEmoZKkcJhX0osLnPxo+1T7HwyJ5H
	 0UVov5DjSE1fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90D9E4076E;
	Mon, 26 Oct 2026 16:59:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F23A72F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D86E980BE9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SuskMjN8avaM for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:59:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A841F80C23
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793033954;
 b=iIJ1lqKXp9/2VdxOmIX7EIlG0Bg7zHwrwUq4Z7tGtDh5/zurX8Ol38IVUfvzWrqE0E4b
 zYPPMaPzcsT5eyM4BNY+tjx31pzhWhz61J50l1gdM9BHVHFsN2xXxFSLwpmRxj8AYEVpa
 PPG/7Glxfo77Tuad5jO5jw5piy2fPMNkiSEQ1H6PHpph7/hgpkIQrXQ6gjpZsWrSEG0Nu
 jsDV73xI8Pe3SE+lnApzUyz0blXQ6O8p74usCkYO4s4Lm4y1WZQJ9bXPzzGq8cYLcQer3
 gSa5asmQJHcLUdXxBSTxjy/Ll1ZlvAVbx2zq0KPSLNWkt14QDkIbS32baq5WHEiFpLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033954;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=0ZwaNRSP9C7b4vWsUzh5mMK6qMOHVDho+XFiwhapFHQ=;
 b=Wz98He2oW5/kfpjMIxOlSECDCsiQYBD1HeO/5Fvl35VFkhwqZekuyVgDfPZrxE/sIl0f
 L+ciGX2sklsZwzQSkOg4/7ckOBGQz/Ze71LkkehGUy7kwOoJJY9k3WT3J7/B47eHLEQH/
 SLmjFwIj3YCpOEnyuoXKyHGkZOrg3VUGeajV4h4PlCv3K9AnnFIHpghaceafGJWXsV7jE
 MaLuVmg2L0H6nu4c1YtDGuBWB8O8BgO+iodGw90KrhTSx4fi3uUcXqoZdME26sli+n9+3
 SyPdBDIMmIPPe3u8B5I5EBYM2L6GtUvZaww8vI2toLskwF+AHbr8FE0O+cnTX2Zfjww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=poG33qz7; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=l7fqhmAi; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=poG33qz7; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=l7fqhmAi
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A841F80C23
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793033926; bh=0ZwaNRSP9C7b4vWsUzh5mMK
 6qMOHVDho+XFiwhapFHQ=; b=poG33qz79570UHxkJuz7o0UVRgkyVRms6GSHI8ssrmgkJnF4JU
 8/5JZGL0WKoiYAxm+NQI7b449P1VLZwHSYv7a43R7ypmsRF8W6OJ4jBJodeXrLUfUJH3H59MLh1
 oOGSmJPM+YE4bKqVoS6M1uZLF9y58moAH+jZ8rZk2vrNlofyKSDswwbolaIEhtTVGkCTxIvSVjT
 5vzNHzj5giVr9zMi2ng4IwxQSEJbDT2k9TuL+1bkHOQVFCaqFIdo3b7C82YpI1grrqUhn2NfT2R
 iUAfTJiXhAeuozVmIfc0mr+WvUxusd0TfEMgYysGFEK7bTpmAziNkBvlEHXOzZ2BhCw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793033926; bh=0ZwaNRSP9C7b4vWsUzh5mMK
 6qMOHVDho+XFiwhapFHQ=; b=l7fqhmAiId+aFUU3l3K96kQs5eyPUU0Z14st3/t9uTkKgEKbQE
 4AeMrPNONNUED6k8FBxq5kBqA2v1Hqhar9BA==;
Date: Mon, 26 Oct 2026 16:58:47 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
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
Message-ID: <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
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

On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
<tomas.alvarez-vanoli@hitachienergy.com> wrote:
>>>
>>>Hi all,
>>>
>>>Just a data point from a user: we are using U-Boot on a T1040 (QorIQ /
>>>mpc85xx) in a product, and we intend to keep up with mainline as much as
>>>we can. We'd appreciate PowerPC support staying in tree, and we're happy
>>>to test patches on T1040 hardware and report back.
>>>We run u-boot in 32-bit mode (not sure if it is possible to use 64-bit)
>>>and
>>>linux in 64-bit.
>>>I am in the process of bringing it up to our 2025.07 branch and
>>>potentially
>>>mainlining as much as possible. We have some remnants of it under
>>>`board/keymile/kmcent2`.
>>
>>Would T1042D4RDB affect you?
>
>Not directly from what I see in the code, as long as the shared code with
>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to report that
>there are dozens of us using powerpc :)

What you could do if you would like is to test the whole series to see if
it unaffected you.


Btw tom I had a idea: you merge Vincent's bug fix and my maintainers
patch,you make a PowerPC custodian tree, and I handle the series and the
naks and stuff and the comments. 

>
>>
>>>
>>>If any of the planned removals or cleanups touch T104x/QorIQ code or
>>>boards, please keep me and holger.brunck@hitachienergy.com on Cc.
>>>
>>>Thanks to everyone maintaining this.
>>>
>>>Best regards,
>>>Tomas
>>>
>>
>>--- Thanks!
>
>
>
>
>

--- Thanks!
