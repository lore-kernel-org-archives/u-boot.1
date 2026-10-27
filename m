Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA4606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tGsEtbVu;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=bLxKcqRV;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=wRS64v1q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F2F040591;
	Tue, 27 Oct 2026 22:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PycFqjiRpI8N; Tue, 27 Oct 2026 22:52:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B08A40593
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793141529;
	b=RLHZNzqUWtE6GtQK/ipv9h8DdTEVE0LnMApMD4lRQQTfS3uQxFiagL3E+3ivHs0mme+B
	 a2rhSVEIYUaQFGJ/D/Do3IdffeCrysOYf0hMcmOXNYUYe0RQ1Oc+wtxkLqOKzSidxW/Px
	 jMcbZIyn1jVLj0aNt3GaOSehFK1/V9AfWQyGcUsC8sdx0IM+FZL/TecoPW9RWFRcymtj1
	 bql5Z0Ir9qOnPb0Ie1yHFU68aDA3kkLr6Jz8shoyPWCBo7MKB0K1tolyl9WMFRyGfxiuK
	 q2GZivEzYHv3HCIpPaDVaJEOtrWeGMVu7ouR6NTmT68uxO2htQquYJBLS76M0GUkZLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793141529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SIb0mebxcGksUyhWJHo3QR0w7u8zMww0zeuvGIpKF2k=;
	b=DV0vxAWwtU8cOXqvASoIf/Bmgo4mxBmT89CYGdeahFl46dRjMLE4G+3361qUWmgXC+IP
	 HH1c8dyOEdS5TO0iY8VYZGk+YYf0BVusKLH/n8d1lbqxbo7mihGqRpE23gkN0YENRvNsF
	 LMnn/CWsxN/V4E1DaUnKVawbcG9ZRBpyfWVf1nAw9PeJo82yYRpX3vKvyY0Psopupijn9
	 EPdMv6T4Kg+x0kF+MnFW1q1bc81Rv3PLTBIXfEyM5phsyBKBUeoutGjt6ak0/PP8Xh8ZU
	 BTCY8uEbTReiNQrNgnbaa8xzDKqWSPcfK+LhyNikRYo6FG4UXC2mtb2HLGZLtE1nBIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793141529;
	bh=SIb0mebxcGksUyhWJHo3QR0w7u8zMww0zeuvGIpKF2k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGsEtbVuwvRO/EU1Avfuo0EC2HE/ajWc+BR9o9H6Bpiv9f/v+h7g2I/8R0uz0fx4g
	 ID/uCSw0F6NDOmjl5m+ADH4PYNOF1ZmlPcFWSkzTkUIPq0STsHvv+X9AEJMjv/Vx/+
	 ITYbDwLsko6UsOZDvCfUzmtwRGtJrg3ArBaxUJSnoT2ZoMSAXBMQZJjk0hpx06CWo1
	 3iSvGmEb15mWEPmVI5DtsHtq45AOoEiLH2nAxWS4IfusWClVhPchWSpHESM2IubegA
	 KBUpiXgK0OlJyFzJ98mQJI1LlExIlVp1MfMslRgp/BDg7GY9GZg5vdQQXEMyYOJFdd
	 RQT7dmIz5m4Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B08A40593;
	Tue, 27 Oct 2026 22:52:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBFD7235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEF5060613
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8H_8GEiCU00 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 22:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8FA1760653
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793141527;
 b=dqmnD8cuq/tTw9IL4EBy2nqlBagkIGAQRcmgDtbrbNIVTq3NuqF0xj14BGcn+6JTkm9w
 y72n1BXkERSzYGcPqAxYNd+4K4i89Tfaw6pUN+Q7fN36tlJYmEYf+2JCvifkfwbn7vuFl
 sQIQc1GqBbM7TQh3ipKs27yaUnnUqDhItpc3wEgr4tjcLx8zPUIz4I3e8eHnD/ITkVqih
 lflny1A/EfjZ0QfClR8J5lzOK04090UnKNkNyLosWACFjezbmZF6EKOsYHxCHX6MXX/0K
 6ndTvVX+xMUPZGhrdFcIo+QMBs3pylBeYyRQQEUk7iSfveGDZ1kJHhM8KVHFikalpZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793141527;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=SIb0mebxcGksUyhWJHo3QR0w7u8zMww0zeuvGIpKF2k=;
 b=mg4NzO1gLvNoqsZq7PJG/BBn8V43/UyCr85ZGtat0r7Cx+UXSF0eviPOAqQwS/HXVDYQ
 6BuC8cM9hNzFmH3Xq1ESlJhFuVytAXks9Q86CZCLYWgzQMt/u15M2IJU6o0U7NMTCcJwP
 BPKFYbA9pSiljfMRrXnKsRNNWto+0kZG+089JcBbrWE+E7g8s/rJUn/xY5PzHWSRzrMtf
 MF8chtK+aA2GKka5jatIH8tVhXoy1gxZ0t2ePzJbPKvGUQMP0PUVVHpOT4+EnShkyvZ10
 oj8nZykq0/YJj+edu1tQeUl7//ZOpN7voQ3a25BpogSS1OkzE++mQnUEf/CRaFvCbNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=bLxKcqRV; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=wRS64v1q; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=bLxKcqRV; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=wRS64v1q
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FA1760653
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793141522; bh=SIb0mebxcGksUyhWJHo3QR0
 w7u8zMww0zeuvGIpKF2k=; b=bLxKcqRVJuGDI7dkd/rf99f0EVOhLmc4G9o7sYRf6cLbbVPp4W
 APCeRZq7lEWAgzbhCvXjuyA4VAbKqCsfnvmujYCA+sj6OdQcWsGhfeF6xDfHYu/4ed+wQ2+rMYD
 ZBTNi7HDLc6TP+ZBKrTzNrUiO45AureDH2MX5lmyYmx5RfByKT1WNvT0wC7Fe8vk6A3RB3xuZYI
 WG4s+19Rnreu7sCUdOTSsQPtmu/FVHK5I2OIvm2DvJOIKxcTZmwWrb0EI/N1aIA1+GEWo85l3Z6
 pV+XgrGtnx+9bRV7vJ0ez78uIdbkdrQGae1jjCQN1Kv47feO9zlopMtU7cbidcAti8g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793141522; bh=SIb0mebxcGksUyhWJHo3QR0
 w7u8zMww0zeuvGIpKF2k=; b=wRS64v1qODp+vPiGbkuUTZLaWvpjSbneAowLObo003he6avcuv
 p86Cj4clld2PL7YYAiDl/zHhYXXbZDpCvGAQ==;
Date: Tue, 27 Oct 2026 22:52:02 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>
CC: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>,
 Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc2
In-Reply-To: <179311694200.2385664.9688315453865404008.b4-ty@konsulko.com>
References: <auAG7y1hk1-bjt6C@nxa18884-linux-1.ap.freescale.net>
 <179311694200.2385664.9688315453865404008.b4-ty@konsulko.com>
Message-ID: <8890F13D-3B63-40C8-8EA8-E9B22E08DA88@mainlining.org>
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

On 27 October 2026 16:02:22 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Tue, 27 Oct 2026 10:05:35 +0800, Peng Fan wrote:
>
>> Please pull fsl-qoriq-for-2027-01-rc2
>> 
>> I dropped the PPC changes which needs more time for response,
>> only kept the change that Bradley as PPC maintainer.
>> 
>> ---------------------------------------------------
>> Add Bradley as PPC maintainer
>> Make BASE_DISCOVER_AGENT it optional following spec
>> Various update for lx2160a serdes from Vincent
>> Check LSB_FIRST for fsl_espi
>> ---------------------------------------------------
>> 
>> [...]
>
>Merged into u-boot/main, thanks!

Right, my maintainers patch got merged, so now

1: I'll drop it from my tree, since it's merged.

2: I have something to say, few shoutouts, etc:

Thanks Tom, Peng, and everyone participating in this conversation for
trusting me with this role and taking on this responsibility.

Honestly,
taking over PowerPC maintainership means way more to me than any of you
will ever think.

I want to provide a few thank yous here,

I would like to thank every single
developer, board maintainer, and user still running PowerPC hardware out
there and keeping this architecture alive in this bootloader. 

Everybody who
offers to test, everybody who does their part, and Peng who reported a
build breakage in v2, thank you unconditionally. It is **you** guys that
keep
this hardware alive.

I would also like to shout out someone more personal to me, since
this is a huge event in my development career. 


I'm very Sorry if this isn't
allowed, I probably won't do such a audacious thing again... :(







====== Start personal shout-out ===
I have to shout out, Tasha, my crush, the one who has helped me
through all of this, and Linux, and everything.

You are seriously the light of my world even if you don't like me or
anything.

You have motivated me seriously to start this development work in the
firstplace, you don't understand how much benefit you have brought to me
from just being present in my life.

Seriously, thank you, from the bottom of my heart..
===== End personal shout out =====

>
>

--- Thanks!
