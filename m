Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CA606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AikaAeEQ;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DMOccvw8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E52F80CB9;
	Wed, 28 Oct 2026 06:33:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eCwaNlyUXXgg; Wed, 28 Oct 2026 06:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5E8180CBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793169206;
	b=B0Sn+ngmZfcnYjU9opb45ALhQdzvfd0diJAIvDbZmW+OwnWE1K0SFx68Yx2UYM5l2/CM
	 sZca9y7ldnbWL1/0auTnzI/6tzMKew+Wjsr28DPvB1ngHTYAiBRDYudWzFQmQRmAtfNkN
	 HMiNURtlR9U4nOUbyxaWQGiImp6EqNGQiKSOtDXtabKYAvZbyUACXloX2nVkK5EKgobr0
	 pXgwkYjbRVFB4TSEsrRjGhXgk31cWd98mfb0LoXiXGa7bYP4hSItyKzDmGrHCeEaV5M1U
	 nOo5S5X90vf4L0y4FwjpOMD+EYs0Hgc4joWCXg2doLlobWMx/MZU44B0mdTYJ7XZowA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793169206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7vnAPFOdtU9w4qV27R3icRiWDGJ1kOu/tpKkUr3rbnY=;
	b=HLKdG4BjBxaauLOw9A7xuABw/W4WwaWDzNjYGz6+VDLXStUzOJ4j6K85DUh9KGanzZo0
	 qIaIuoSiVKj8o2LrplNP4ayj4f6x6O82jHkPKA6pmDApCsZhhGVp+qNkM1NhwzWXpVxF8
	 Ht5M3BbjXDFmiPw0q6HjHmLJVNu6tuKgRmPfSV2xVz/3h2NDa/ejTAFqb7nhq5sx13n0m
	 sATAboAcU7pfjmXVZlCU4qc0PTd4gi3fR9Uuv4+E4cP0hJSm1rpP7kz1XRppj5Kazh167
	 fE8YF9SFuFv/AroDCdPOncFyLxzdUTZegUwluEO/g6MtLEzQh7ZZJmnjk0LLtZvqaNA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DMOccvw8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793169206;
	bh=7vnAPFOdtU9w4qV27R3icRiWDGJ1kOu/tpKkUr3rbnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AikaAeEQIUGX8ravqlkNixPNiiW2BoAPRoKGlYmYX68XfbXKvM/2nLxmUhm2VjaUn
	 KmZ1Ut64qvYKP/ll+NRmezLKaCfgTCU+OweycDxxgA1ZIbTjJMkseQ1UumNQSC3EVQ
	 JkhzkypQPPuPmpLcavmsr8YKSwjyZ5WxNdIP22UBahKVTtmIdqr4hlY9osJktWiOjY
	 As3XskGkEaXVF85TGN7xOv5V21A1aOn3pEqf/sVC36SfG8zcwAQrnANzqvz8Gw3vAE
	 9J82/KbUUo6sG65mczsMDkQ/tmozxWPr2qiCdG+I0SLpZFHxMEUn6jXzUFtsvzB0mf
	 z4MXqPsZTeTYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5E8180CBA;
	Wed, 28 Oct 2026 06:33:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C036473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5909080CBA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 405fjwobsvX2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A80B80CB9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793169204;
 b=qIPZTRyyEY1P1aC+Hvhb8g1cRA4x2bhHqvDEkc0bw9P0kX/GfFQHQUjkSuShFoEPeLzt
 PmTCKCXAfRYuoRZcvBUkO+3W6y+fZqdFBTQd2hXc83mg7YqAsJ6W7aBA63yj+DN0+IzxV
 sCzuJEIvzB/TVQrSHToR/Y4bCtj0eW7v9DcKAuA6Ygv+Xpe+1Kh/jAlMBxAVZcdyOWcAG
 O/GZklox8UZJ6Jk75PgaR3kx/98hlhFVL3wahwWfG3bPEg5JCIvMHJj/p8pm6V7A2Bd35
 9v/CJuk7TNnba7RmNYQl8y0oVTcOtwFeRAogKt1bjl/UxkCytnxoDS5z6x5eLkkqL7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793169204;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=7vnAPFOdtU9w4qV27R3icRiWDGJ1kOu/tpKkUr3rbnY=;
 b=RAQT/hmUgfn/pl4hN9z8crYnKgMo5qKP9lMz/MrbybI7nPzD53n6jkgHwthoZb9hygkL
 j305VumfL6x/Lj4g7gvFPws0RbDSeUSOen6xymCILFPIFGhU5Xk48AR3tB7/4Kwggz3o8
 6wsMx1QbsJIZGxRL6+p4p/B2bgPjQwUo1aCRaqYV2/mIFhwBQHmXkb87oRKi3zGnlsOED
 pmv07QtmMr2qRngeWneptKNk/Tf532w+hvJ4DE9aG036PjYVDJGcnCdTt0sFX7If7l0gT
 pgcQ2fD08GITkIhEbm5g8fhxOypjkokJUd3nZmS9tlLLWa/nOEPCRsOsbfhuC2hujjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=DMOccvw8; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=DMOccvw8
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A80B80CB9
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:33:22 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jDyH31z88zMlmj;
 Wed, 28 Oct 2026 07:33:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793169199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vnAPFOdtU9w4qV27R3icRiWDGJ1kOu/tpKkUr3rbnY=;
 b=DMOccvw8SM0JUCaSQCGupDM8iIELSOUBvGeFHhim0tY9e2Nqcc6FSOzhZLSbN/wQ3tmQ4Y
 XTw51eHnPupjgD8tB5/Droq6fltw9cfA6jT+CbMWycCh+8Jqf3y+chf0RHmVLZM+uoEH4j
 ckSk9ILcZoWkc5W9gXhB6O7cZ5Zi6TJklZ7lRXyDbs1FKs7Ml1TXgrUftlc9gKDWKdY/5z
 plF8Ra34Wc+7vY+oa2vtkz0g4Xx7xIpyvZmKzo7oYpjul8AnUBHV33NTLrf4fVqeB3fCQK
 BoIlzCox0DS9oeIsmfk+B1H8GbGGPfOAKDMN+A5kIC/bEhw/2Bhnu3xfEeihcQ==
Message-ID: <c2231bb2-6999-4b58-9ee5-1eb3fb079bc9@mailbox.org>
Date: Wed, 28 Oct 2026 04:59:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: onboard-hub: Add support for VIA Labs VL817
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
 <20261026092432.769146-2-alan.tseng.cs@gmail.com>
 <ac90ab9b-35b8-45ec-a932-3f74ac26d78e@mailbox.org>
 <20261028030708.1608942-1-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261028030708.1608942-1-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a271f9e69edf9bff0e7
X-MBO-RS-META: j8g6qfanpynuozko9e7yzfb1qui9sceo
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 4:07 AM, Hung-Chun Tseng wrote:
> Hi Marek,
> 
> On 10/26/26 14:19, Marek Vasut wrote:
>>>    static const struct udevice_id usb_onboard_hub_ids[] = {
>>>    	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>>> -	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
>>> +	{	.compatible = "usb2109,2817",	/* VIA Labs VL817 USB 2.0 */
>>> +		.data = (ulong)&vialab_vl817_data,
>>> +	}, {
>>> +		.compatible = "usb2109,817",	/* VIA Labs VL817 USB 3.0 */
>>
>> Please keep the list sorted.
> 
> I put the new entries first to keep the list in string order

All right.
