Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E939606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V+ShUUuJ;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=S+fZKG0M
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF3DC80D13;
	Mon, 26 Oct 2026 05:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAMeQcDdbL3p; Mon, 26 Oct 2026 05:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E1DF880D45
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792993873;
	b=Lqd+XkI8ySxxc5It95n/jGjb8TmA6hMq63PXcyujU6aSSQEVO3Roka+BjFN2bYU0QFnd
	 mWLHoPi9EWsJtKQGFxvZNcmHqmRZCRV+E0E08ycftlme5iLxRo1Qq8rKIMAVrvPobOS8A
	 9/8YADhg9wFH1U4VDposO7GfYO1oubQ5nXl8/oAFQDKxOauBXCABsOiWfESJa76Q95aDk
	 u6D9f2zito/Yso5emo7Y6U2gN6utrtJobeWvjRGLPTa/zgl820MnhybbpirCUaylJTvSt
	 EhPKncNO4S/CaL9wSTHnwronJcqUsVl5OBlgsbL12MTIV6B+JNLfjVWm6qRLNkiNaVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792993873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1aKK/FaXLdEe/l3F6VQvHfiy0JbRcHSE6vNerQabdj8=;
	b=K4T9k+TGU5ePARXmWbo/dewkjCfHty64WFEGqXvdsoMmc0gzhtIaa7xPMcaa+KPUaT5J
	 X5f7zdFhaMZ9rgCg7WjGfwYsus9qVshj9CFuD3TSZNSERd7qnFrJINDUX+1YpL8Cr18rD
	 6cD+PRcCE7DYMM73V6VxjuvUwigPODW9Mdro0CU89/K5iRZGk9sDYgkNQlkxR9kZ49G76
	 n5J9q/gddnKbnf82lDqVJhXprfMi69bDc6XWi9kHLEAl0QLnqOF7eRqrMLcSk5SQZArxY
	 9MOu+Y8RPKUTaXipCg0X/9zcuGDfuMX/w2rXPfrCvbZMyY8J+FwgCQ6Ddau0/x3D60Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792993873;
	bh=1aKK/FaXLdEe/l3F6VQvHfiy0JbRcHSE6vNerQabdj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+ShUUuJioaS0P4HfmdTRasQZfdxglB/MkeKIYhadoTxlsY02eCzsFG4XAWheC0jC
	 4Ci4FYDbeKQLflCCmGHr+iYJJsRFNdIpbTslm7X0AtWPIqqBXB87xqLSgYue4BKnJe
	 7g8kdv8IHD7MD4+ecYtPNMOZDtFAhcLSm8QJaYh5Vp7UAJ4wpmpvdPPwPRU300Jzzy
	 dEhxZzvAUDeTkrBAptUcLAFbxQzgqnJEXTqGI98sQju53I5ZtjUVsanV7QVqZh/RtW
	 jPaQE3LkO43QBQWzShltbGUZ7fZyqDAHRTc3LSwKwPP5uhs3dbMcmZBKBFUDfjxnCH
	 8Ud5XapXm46Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1DF880D45;
	Mon, 26 Oct 2026 05:51:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2672D279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 101E260601
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZs9FVTookU6 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 05:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3E7F605FD
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792993870;
 b=VGAQ8osbZCURrmui/XiJYP+UJaMTjVkzLGiVojHwEON2Eng0/ihxI+IGSWzU3+c/nXht
 8+J3UwchL99obY9Tn3TQz2H9s1cOfDqgDlGAYF+fY23kJBfZkjPpPbzT9gTQgQXXuyBrG
 kWgcWeOC/BiUbMzTjQNwmT3eI4K1FrJciTg4Qw15lB81TZyfnw24VEFvW4zUztVn5baVl
 LXT5Q3fyPKL6Dr4Xm7C84qHGmn2u5wLGll/RKh/fccY9TaVXvFh/Squ56yNElhpy8Ry2G
 S6LupbIYA+1SPjnCFggInh/4cnYS6eWGrSenTTjzByGiOuZMsxNfJHaC+UyGU6gnnUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792993870;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=1aKK/FaXLdEe/l3F6VQvHfiy0JbRcHSE6vNerQabdj8=;
 b=J0FLz6B4cYBYVYcEvYMMkqD0OmymB/lYBVOa4RLu5ivElTyGeBO5wBxi0albVNBy/ShH
 ZmYWOT96kJ7llTqPYvxm6diiQudms96tAZnaocUL+Lw4vEwIebR8P+WBNLgYCltct3Nm0
 P8vOcZzCRg9iSF9XFXix3Xzz1oMKQCQ6bAJ0y0Md0lIdRsI9YMXngxRXp2kr1MEO8Wm12
 l1JK9RatUybmJ4mr2mZ6wXO5fhIBzY6P5GxL87uAfAS4cns0oKd6jH2wXrFrsbjeLarqt
 B1yCNmT1L+iVtOgFA1xNqh/T8wn0BmKC3hebJYZgNpBw8fdtH7JFxS8lTD35Bh+ERQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=S+fZKG0M; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=S+fZKG0M
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3E7F605FD
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:51:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A1715109960; Mon, 26 Oct 2026 06:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792993862;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=1aKK/FaXLdEe/l3F6VQvHfiy0JbRcHSE6vNerQabdj8=;
 b=S+fZKG0MkvMG9Ns+OIB8H7XzL8luX5Y8RoyuKkFgZVWRZ+1XuOBAiID4CZ4Lz0/1FjTzzL
 eqiO14LSYbdXcfBKHPa27GoQma8K9GPti7KqvECPyL9tmU+jL7BGp0OvBN8JiepMdkj7V2
 hqccfbTy4kG2AitluCQzDdXlF0pNc8t/oRfHrYbelvkgFl41zGgufauqKgZV9KW2gNaJX0
 1HPw8W5PEuCSfBbYo5ONk7j52mMA7DeoqOGd+o/7zAVodL022HEDGukd4M1n/a1sR+m2BY
 +D3vR4Ud/BrsPSasKCC7R2I8QQIionZHW2Z7ab5SkFJTxlFXR3bORK0B+4As4g==
Message-ID: <7b2d57ad-32e2-a45f-736f-2ac78a9757c2@nabladev.com>
Date: Mon, 26 Oct 2026 06:50:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ubi: part: Claim only the block device UBI created
Content-Language: en-US
To: Alexey Charkov <alchark@flipper.net>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Tom Rini <trini@konsulko.com>,
 Daniel Golle <daniel@makrotopia.org>
References: <20260918-ubi-part-test-v1-1-cad4306b45a7@flipper.net>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260918-ubi-part-test-v1-1-cad4306b45a7@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Alexey,

On 18.09.26 13:05, Alexey Charkov wrote:
> part_test_ubi() reports success for any block device whose first block it
> can read, as soon as a UBI device is attached anywhere in the system. It
> never looks at which device it was handed, so any device that has no
> partition table of its own is labelled as holding UBI volumes:
> 
>    => ut imagemap ubiblock
>    => blkmap create x
>    => blkmap map x 0 800 mem 0x1000000
>    => part list blkmap 0
> 
>    Partition Map for blkmap device 0  --   Partition Type: ubi
> 
>    0: vol0
> 
> The blkmap there is blank, and vol0 lives on nand2.
> 
> Check that the descriptor belongs to the block device ubi_bind() created
> before claiming it. cmd/ubi.c and test/boot/imagemap.c already pick that
> device out the same way.
> 
> Fixes: aa5b67ce2262 ("disk: support UBI partitions")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> This was discovered while adding additional tests for the GPT layout using
> blkmap, where it turned out that a stale UBI partition table gets
> recognized on the blkmap where none exists.
> 
> CI for this: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1327
> ---
>   drivers/mtd/ubi/part.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
