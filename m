Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B0606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1HYDHPxz;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qiALqsF0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A60340674;
	Sun,  8 Nov 2026 18:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7JM43X-BO0gi; Sun,  8 Nov 2026 18:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 581EE4066C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794160813;
	b=KwGEXBzOZPZUVuEaz+v3ztoD6wLJHec0WeEDWzTN+p1amOP+Wd9T/A/zqFSooDVh01nB
	 O4k4kqQfMxJUOCBE/8maUAewnH5dElj01B8h5VvF834ARRbXJiOqdyghW/Jy1b8VZrGak
	 1MfRZxhY+BWVQ0hbkkOfDWwuZl+55nMq635xvWfPbtFrAfNpg7uhnkGk/Lq0KIRrkvCow
	 xVv6RWDNNy5BY3v0sw0ZKgCVLoMqGcCq/cWuONyyG0ZuATC9rNoY+Y/CZF2sL8iXV5d1i
	 q1Gy0CAi1+t1Tg8BF5XDtl8qqhu7B00KqNYILRjNnHbWqR7SGQldbGrUmgiRyb50U2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794160813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IBfOVo8SSnLZVLM7pnwfGXstGdQr+8c6MQCwMJpEOD0=;
	b=mN1wfsRHHx9WSzwTZkRwpu6mE+PNAk/NlQ8jfejYo3LJouH2FlLifuvdt0286KesVS3X
	 lWiOdTJBErrUGSBGZnRBjiL7eXVRyDURc3YmELY66fxcX6MnbAjulHEQOiuKmN4uN2mlq
	 liUGKHwS+vwwxKZKVWFskOh8mlAiaxoUX8RrUoJPp8rvqtMJAqT0xBcAjF8K7e1GDdRH4
	 8O3a9Ygd8TURvHi3XN0BdNxXwQ3eZeJy5GdtgW9apjbd3UTBfHI8hnptUxBC8wcxMTi1p
	 e53T6WARRrjWLN2ORoTGHLG6uAZ3zGeqvsPwL3E7dTPrnEColRiHxEO+aWt0ZIV5Ezg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qiALqsF0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794160813;
	bh=IBfOVo8SSnLZVLM7pnwfGXstGdQr+8c6MQCwMJpEOD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1HYDHPxzIBjkP5yRu31E8WK219VPheKSznofgV4IZUy9kD8br6Cniog6sa824nx9h
	 hrX3QgOmiz4Y1G6x2RJkML54D3Z9kU19ZBSd70/eOETrWZ2IY0NzyaMQboFb2hGRUD
	 8vL31sAeCSQmAzYKlaNo+dEYoBo3l1kdoiAAfCLXVj67dyZk+A1baix5UGjTmTEX0h
	 QIK14rkv11BWww+b2+pUZ+gkAB3IjNcNEBdHgn7J0OxC/RairegRt2TrwaPG7OgXfO
	 S22EOS1jwona62KW1VYqBdSqPswPOXk9k1LMKKZ7hKkIohgncHSVOgNkKt/ePTRccU
	 mn6iW40cpmzbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 581EE4066C;
	Sun,  8 Nov 2026 18:00:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF28C362
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 18:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0EE3405F8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 18:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZwncLfTBSBA for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 18:00:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FDE74066C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=qiALqsF0
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FDE74066C
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 18:00:10 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jN10Q22r5zKmcn;
 Sun, 08 Nov 2026 19:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794160806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBfOVo8SSnLZVLM7pnwfGXstGdQr+8c6MQCwMJpEOD0=;
 b=qiALqsF0Y6kDKkBcH2ujyjArxo5PQplgwA4TlnJSHCavhjF3OBsTokh8hBWQ2l54nZlWZK
 vXeFjQP7eSBg8Ii+raLmxhK323b9M5pIx31YGSqNZWFMj5TQaVye3741cGIr/dULFAnYSJ
 F/1X112/u4cxim7wZL2esrr+qxYCt5O6WY7vjEddbb2TbMtUGtVbhU32U+qHphTE+DOt17
 PAY1IRs5zRDF/RhpXY5RT33/BkFc6dN+D/jg3LZiCpbnYz2VXlvNdAatzqS1QNabBC0Rba
 MTicAzWGiC9H73n4lHET/Qwbq/7egYhhgWxta9qDPlThm1tllLn4seswrYenIw==
Message-ID: <fdee1975-8f27-45a7-85a8-2405c29e1dfe@mailbox.org>
Date: Sun, 8 Nov 2026 19:00:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Denis Mukhin
 <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>
References: <20261108155019.1485598-1-vjardin@free.fr>
 <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
 <avC2OzAeGxqVsJ2v@L30177.local>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <avC2OzAeGxqVsJ2v@L30177.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: q9c6nciydbfg3nh8k1jdbp5adpmb6ru6
X-MBO-RS-ID: c64075b80e705550f6d
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 6:49 PM, Vincent Jardin wrote:
> Hi,
> 
>> Upstream your hardware support and you won't need external DTs.
> 
> Even upstream, how does it solve the Yocto's and Buildroot's related
> issues ? Both did try to workaround despite they are all upstream.
Could you apply a patch which contains the custom DT instead ?
(using SRC_URI:append = " file://0001-your-dt.patch" or similar)

What is the use case of custom DT injection like this ?
