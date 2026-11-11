Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EB60A260C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DeD4B6kk;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=BZQUqI8H
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C5D0408CD;
	Wed, 11 Nov 2026 09:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPZAUdrRh8Aa; Wed, 11 Nov 2026 09:38:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FCC6408D2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794389907;
	b=K882DW49hjSKpcfLcTaJB06ZyVcd1O71Yj0ZkdU7Cj/0ui7R6CxENDrR3LP0x5tyLc9K
	 aX7viRdKTJlgEQZhRVDbX38C5eiswNP42InPPfSU3hNXLAxoczQJt7boT73hBnn6ZLw9t
	 cNoWwYOMETCzyAiRRwsF5Vyp+38JmIuZoIfURYsmEa/RU2dM/xW+IgzV+EshkSChCoNgP
	 rbQYtVHjuHJSm+7RMRQkf0w0yM9ifwWW4vLYry6W4JM7OfaAr+ApQMRKeGrbi2cu2D194
	 JdQul+Awuq+ZY/tsaSOJcDMlW0YoJMc9hyuPfTLIHcuXHJePgvoxS3C0X8oJBHcydUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794389907;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LF553jiMCi6ce0uE3NWf61bG3Bh0dC0FKDFN3/JO6Oo=;
	b=tQvpK9+3py2LvL1gQ6ivfUxV6dFimQduwKwbRBbixQEJrA9m85kKfBSIQrH1eyeaoxSo
	 huPG7Oq2SKXp5qNRuWebwJu3RhSBdXXKlpkAqvolsRYVv+Ujm0pZgCY7KUiFxNgA6k9Mu
	 F79Y+34f/RhnUXQfKMKsojdouX7WinreDTKzyNQQFv254EbZuH5D6eGtXJixPvWD3QYVk
	 0Ep5Pu07JYd6VhqideKZlhOMel37oWVrhYumil7AA9D3G9xUjbgVFTS4iU04C+eV3Ga8s
	 JiYRyqFlrGjaL3V3P41ko7awpl6xSgAaze/SIs0SR7UV1Cdl8XfH550w88O9w6Sk2rg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794389907;
	bh=LF553jiMCi6ce0uE3NWf61bG3Bh0dC0FKDFN3/JO6Oo=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DeD4B6kkR50ucl+FDcBNmIwLl1StPzVwFtN91g5uu18aUFS1OK2QN9fgJ81MHcU6S
	 JzmYehUpRe5RZVyyU4iK697z0E+5Teb35izPWmsVXWnHFfKc8uBvePh3F8VlmdYy8B
	 /5yPWi34tK9ByheH7VFhnzthoJ60+lgAWV3dZvMQ6/nB2aaVZmZDOt2msyKcGw4hWs
	 +v4b0M0oVfv0J25szUNa8D6xLmxKiE7DcpNVhM4t3ndprbL7MIso2n3A+WRv0kvLpy
	 ipm6pQIVd9w2MnApy+p3uzN4N/LOaUDiy2JDQmkHsbgkJ5Sz3dhdQm0aNpEe2byYCD
	 w2ANRC/xqyyCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FCC6408D2;
	Wed, 11 Nov 2026 09:38:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 251D417CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B58260793
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 34btr07otfel for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D4FB606ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=BZQUqI8H
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D4FB606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:38:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7813910DF7D; Wed, 11 Nov 2026 10:38:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794389898;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=LF553jiMCi6ce0uE3NWf61bG3Bh0dC0FKDFN3/JO6Oo=;
 b=BZQUqI8H6v8dvfO3DikZcgyw+IPBVpeu1urMTwg52aht4uTzG0+RWMqi2BZaFnF5cwV7Wm
 W93pViHKNISrsdbHX3vFzTk6LoFrPta0eDlM95fQxcAgE2EFykMJ0q5Y7v1bt+quDCx1iz
 vRrOIhnINpnmlB4NMF+Fuv8YTmAxYHY6hm41DFcLlbA7/cd4nouP33SJMjXl77El423fum
 W//OsklUsG3FT1l6hcLC2HU18iG4WfZmtphPtE8lI3q81L3FOfMDHi84fXd78wLmqYJpmE
 ZMTeUhEzdU4FWPI3Sn/CKfVofWSKucRkDaq902ixG6jAi8qRKyvdrH9q/KMjgQ==
Message-ID: <a327392b-f77a-7f7e-32a5-ea2ca58ed6d7@nabladev.com>
Date: Wed, 11 Nov 2026 10:38:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Ana Bobillo <anabobillo3@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
 <ff585b11-bca3-419e-aef3-08db9d292200@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH 4/6] mtd: ubi: fastmap: check PEB numbers read from the
 fastmap
In-Reply-To: <ff585b11-bca3-419e-aef3-08db9d292200@gmail.com>
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Ana,

On 03.11.26 08:13, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
> 
> The fastmap lists the PEBs of the device with their erase counters, and
> ubi_attach_fastmap() passes the numbers in its free, used, scrub and
> erase lists to add_aeb() as they are on flash. ubi_wl_init() then uses
> each of them as an index into ubi->lookuptbl, which has room for
> ubi->peb_count entries, and stores a pointer there. So a fastmap with a
> PEB number outside the device makes UBI write past the end of the
> table, or before its start for a negative number. The CRC over the
> fastmap doesn't protect against a fastmap that was written that way.
> 
> Check every PEB number taken from the fastmap with one helper that
> accepts only 0 to peb_count - 1, and treat the fastmap as bad otherwise,
> so UBI falls back to a full scan. Besides the four lists, this covers
> the pools and the locations of the fastmap blocks. An out-of-range
> number there is otherwise first passed to ubi_io_is_bad(), whose range
> assert is compiled out unless DEBUG is defined: on NAND it reaches the
> driver's bad block check through mtd_block_isbad(), which lets an offset
> equal to the device size through, and on flash without bad blocks, such
> as NOR, it returns 0 without looking at it. Where that lets it through,
> the read that follows fails the attach instead of falling back to a
> scan. Also, ubi_scan_fastmap() takes the block locations it keeps for
> wear leveling from the copy of the fastmap superblock at the start of
> the fastmap data, not from the anchor's copy checked first, and
> ubi_wl_init() indexes ubi->lookuptbl with them too, so check that copy
> as well. The EBA table needs no check of its own, as its PEB numbers are
> only looked up in the used list.
> 
> Linux has the same code, and the same check of the four lists has been
> proposed there.
> 
> Fixes: ff94bc40af34 ("mtd, ubi, ubifs: resync with Linux-3.14")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   drivers/mtd/ubi/fastmap.c | 73 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 60 insertions(+), 13 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
