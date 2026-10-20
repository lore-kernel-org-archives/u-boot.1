Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A092606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dcxZfaWG;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=SLXjTYiU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57FEB407C4;
	Wed, 21 Oct 2026 02:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8A21DmiCi0BR; Wed, 21 Oct 2026 02:21:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D1BA407AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549300;
	b=g1sKVbdZZk8VddJ9/7rxQKNQkowyi/kVDRsUe9hL2F+PFLGIX6sITzt6gRY2NjcfN+0r
	 yXu+mx1nXNFDkUKYmGgTvCCZwmCm7zHiJY2FdAmk9FKIannSHSqXlxwDr9Z826MK13auT
	 vQx/k5TMBHUu/p1Z7KLqoTArXtuxZi8Gkc0+pbjV5hcsZ3JPT6/hMxAkUg6xwgN3QMNVA
	 mI6WFZNSKZh8smq7oyzfiQHVi7A6f94nbquT0WM6buANIY84oxBO00oXEEgsN+/KAGanI
	 T7XNyRQ56bUt6WpRB4ybqaJA3iaIGlY/mjNM/6GWe+YhGigl/SGTIJBhhPVHnMfoHCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jlVyuMOK7UM/SLo9GjpdwZn7X6nc8eHbT/UT8nLXXpM=;
	b=FmWw8hBzObG0nuXqwPjzr30EytI2O3KVmNgm/pL3JzsCJFcgawso6LyfwO7F2EXAyTCh
	 +2C6GFE1nqEifgm0x8IrORXNyz5n5kDNAdvKm7L4kytp7MKUXLXg6Iro428qFXb0j2Vjn
	 KCm0BavthHCJHPiJci9UY+LQsHr8J/ZWpsJgkBl5wIZRY3wOOWaEZE+ovcxUUXhDpgIwk
	 ie5ox+0Zo+7vn0x0sWqsPxjHi3DvHOEt1ISH29RCglOF4Dmwy3Vmo6YWzNWptkYgswhU4
	 CVY4EsVY03loaxslw0l2IDFVwLGCf/+8FmqgMwOm/zp8Yu04H3D7iyFWkumJ5ZrM3ew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549300;
	bh=jlVyuMOK7UM/SLo9GjpdwZn7X6nc8eHbT/UT8nLXXpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dcxZfaWG6Rd4coTeKLyatBlzTJnV4H0yuGaMjp4xnf1vjK5N5hjEI6bE8TnhhWR+l
	 j/YQUq+l+T1d1GJ97bq5e43D/scPLFdB1gN7coB0PyyCtUdbXQvb7oFAGxSlp4qrXO
	 dtGW+M+WxKRSnHVEjhYQv5IKRJPxHDed5OJt+rTorrU4x4v6NJL5ZCGZMOJVoFBzEz
	 sl34S08BsgrX1g0UOfQoP7DOViWxCqR24hirmnYVgPqd5szNGTqixcOKAOF4KxnJqX
	 vVXLIANqlJ59TlJqnG/DBHzXvcYW4lYbhFuBNMZ1QRomXiRwwYtW5puYMGzkOA0sX5
	 jIagqJ0S8rxfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D1BA407AD;
	Wed, 21 Oct 2026 02:21:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CED4C1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B550881086
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ylm7ziyTYkfK for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:21:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1AC380F90
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792549299;
 b=JDiJI23d2Z+xZMr8Sz+4XFeeNxHTqvEYTnpi9a5bcqPeA/k4qDLeGGAYZswr8gb4ZX1w
 F5IFfgGfz/xsvfkJ6+TvUVM8JHXpVPHEFy1a9/Cuk/xKDw57hzuNg0KaRRKa2GJxoPGZA
 9CCcwugTIf4s7ybxSTAJ/FQQNqlQhw5InkMAiltwu0x2pVg0u/TDQIcw9klyG/edX/FMZ
 v50w4JeurC83McTDbjZrdCb8Gde8cjG2GbT6Mam8/4dvmRo6hybR3ZjLFRU1a+pijPWc6
 4d1R64HUf+2PruK6LJ+vaHXAuMjWFh7jibb+q1EOBlMI5ytuPBwCsfQtsT6lTEWPC/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549299;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=jlVyuMOK7UM/SLo9GjpdwZn7X6nc8eHbT/UT8nLXXpM=;
 b=Q8ZM/AlRArzHtqmhV9SJ+BfmCCMVzyltzC/6TzvslJul2j585UvY+t6346RDQIVJ+HIO
 UGOXVoB9PZ6bsq4RMfQvwUCnDxB03XJ2z5D6Xjj+2kUGCL6H/WHFAdmdygDjhMxiTXSNp
 hWA4Xit5Lj+/bMIhUIAJHoLT146HZ3hf7DYk6VOYHlER6g385/QZnu4pSo0XqeSpBB/WE
 HGcGRMEsQfZyI9rkBbpf92BCJM+6QLCCvTuEXuOXCOB4hnd88eS/Y8zNVxFENl639QQ+7
 neafoZ2vdAQVODWlrZv5xwVKh7Hcc/e3KF9id3I7TkA3HBT2z6qiJg44d2oAahLe9rA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=SLXjTYiU; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=SLXjTYiU
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1AC380F90
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 81FBE10A47B; Wed, 21 Oct 2026 04:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792549296;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=jlVyuMOK7UM/SLo9GjpdwZn7X6nc8eHbT/UT8nLXXpM=;
 b=SLXjTYiUyosVeWLSwEWLhLsjM9tkVRgRUNPhmYJnpcrCvVe6KeJVvF9R8Kgx51WOKlj94S
 a1WCmA4MHJw2TKqtWhNuZwx4gerMD1VoiSLofMqxIlDwBD2N2iZMySQYTQp8N5bDacpvkb
 7oo3l5DxOxHXDNmIqOQ7eRWtt1QXeKlFvKpLdz4goJpk2h0MQhjruMP8Cvm39Y9qjxAImO
 9lrEHY7mBKKDMXXHKzcvSTVeo+OZj1m8/tnJP9F2kv5DGxMxQ4dbKPm3NezdsASnMfW+LX
 ONETL432CJITYXcEQpG5MgcxGZpAt/zn1g2uaDpax9GlAc86+tUPiQ6mYP00EQ==
Message-ID: <c9e9eff7-fcaf-4c98-80d4-b0eb4aa93bb2@nabladev.com>
Date: Tue, 20 Oct 2026 20:16:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Richard Weinberger <richard@sigma-star.at>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>, upstream+uboot@sigma-star.at,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
 <87500fbd-8f56-4d40-bc22-9aa68635f1c1@nabladev.com>
 <qUM3V7UPQe-RED8ASvU1mA@sigma-star.at>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <qUM3V7UPQe-RED8ASvU1mA@sigma-star.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 2:55 PM, Richard Weinberger wrote:
> On Dienstag, 20. Oktober 2026 14:53 Marek Vasut wrote:
>>> What if you have something like this in your bootcmd: "env import -t ${loadaddr} ${filesize}"
>>> to import variables form a file like /boot/extraEnv.txt?
>>
>> How do you authenticate extraEnv.txt in this case ?
>>
>> If you do not authenticate the file, then it is game over.
> 
> Well, since I allow only very few variables who's content can't harm,
> it's okay.

I think there is a bit more to this -- what about "env set" usage in 
U-Boot scripts, should that "env set" invocation be able to set 
non-writeable variables or not ?

If I recall the discussion around the addition of the writeable list 
right, it did originally filter even import of variables into live env 
(what env set / env import does), but that was removed in one of the 
follow up versions, because if attacker has ability to modify the env at 
runtime, it is all lost.

But please don't get me wrong, I see the issue and the wording of the 
ENV_WRITEABLE_LIST symbol is not good. But I am not yet convinced that 
it is not up to the user to secure the U-Boot shell. What would you 
suggest we do to improve the situation here ?

> Of course you need to be very careful, but that's a different story.
Right.
