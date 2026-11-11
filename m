Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB160A261F
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CgOzYJ9K;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=W9E0/Fl3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 290D840A5D;
	Wed, 11 Nov 2026 09:24:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gNK-Si3D0QJ; Wed, 11 Nov 2026 09:24:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 784DA408E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794389067;
	b=MoRJkOzX1cfWmX0K1nV3NZo9L/QcOEAU8cqJM0UUfLf6PKsdpBkI+RG+qLHiijAVMW5R
	 z2Ace0TQTSra+wWgJfhJusymdJxd3YYnbZM1Ncso2HPVztpO9Mo286Pjzki9CssRZYH8U
	 lROajUh2XjFp4HGsKUVgD0tJolLB8tdik6ZTgGdgKezMZy6//vlX7P/isDSMNvToT8Hom
	 OUCBvaU8B8ZRIHTzzucYYlVeDjB4iGIWjeE3T9lN2Xg7h2wO3laft/4fR0jp2dTIFK+Q9
	 LJAcy6NRKreqfHYEVyLNwj5yJNCpXhs0xolFZKFuMK/HSfuaBtitOswZxn0C3XOvi7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794389067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6kF5E0wwJTu4l4woRgS2MQYt8zH1NUx7fReEBqfpxq8=;
	b=LMHSxQrCHJzY0LUAmD6tP2aFPGv8VT9N6TNZnv8j7qrtBA7R0GyYzsGx571RGOxa8aVn
	 3UoPe43xIztTXk3IQHf/SyeFFi4BKzzn11n4h0NLQIRMQQxJ5R7nnUri9FziPgp5GbT9J
	 XMUoeNP7slCLmzIXxUM86BEheAzMDrcy+MWvzHwtqy9I1+09okRw0kDPoILr/Ov+ssBWw
	 RGR+1fxwYyO8rod9YY+0qDuTyZ5Z55dRVDWlhLO+VXP//l5+ra4wnEJirY2C+Cn9EK/Hq
	 wdY+6M19vKhZj8KJX2MqLh0fF8UWO9L9Z2W7qR8k0AP8PjW+djN9JTrwJ4JtafiBL9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794389067;
	bh=6kF5E0wwJTu4l4woRgS2MQYt8zH1NUx7fReEBqfpxq8=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CgOzYJ9Kv9rf7Q7QGbO6D1+nQdFubzffCGh3Waw7319Q+n/Qto/rbov1hXMqk5RtP
	 pAokhu5pXi+KcM5MkWtIO2v5fJkrT7TBEWUbrcCW4mh0ebyHBQBoulz9ph+/C7Ws20
	 mhnHZqhNQgUv1vlU1EB33OLQGjzU/ZoiuITXgXYEu6xJ8/i00r5yqH1DOfk8nPSrL0
	 GIgfhu2lqxo2tOxi2V7cXcgyjQm+dCs5XyofYvysZtc3YibV+xv0yFg1apDa2AD3tw
	 lRAjvQxLoNdkfpxPP/2EPsnBR57Hj9DuzKKIrIUQhj8w0fAdMRdtFYskcoYDhk0xFE
	 lgUji8zv9sn2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 784DA408E4;
	Wed, 11 Nov 2026 09:24:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3A4A731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE8FC40318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:24:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qFpRruSMPAtR for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:24:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DF76340070
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=W9E0/Fl3
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF76340070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:24:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CADD10DB3D; Wed, 11 Nov 2026 10:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794389057;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=6kF5E0wwJTu4l4woRgS2MQYt8zH1NUx7fReEBqfpxq8=;
 b=W9E0/Fl36nbByh0qvdD3MprWaK9LPxoD/TbFz9P8Ac3mZv5hwpj7Gadjc1yPFk6M45nDMM
 XxCi63CwGR8nNpiVCEnlYB+xuBEz8wqnk5ObmaSsk7dPt8d8Ew19ZlhK7+oTHFFXnrX5Wm
 p9vF9ewTrwYwC8u4ZU14BwnujyYQTu4/9tQWMfy+xVZeOuGaypyD5X01f9PT5RwlOR5XMP
 jwdRCuwtwDgqrf6cxKLJj7cWs51LXOCFdEFGfYRiIjQAUpyZ4DoKRLCmofm+PYkSuPwUJC
 DxT3UqEvIajp86PX/48znOly9yYpJ1RZp6Rte9eIBAfI3iYQVO4QdC8U0xQ5AQ==
Message-ID: <5a2e6108-0613-4d80-b351-5a212d99b771@nabladev.com>
Date: Wed, 11 Nov 2026 10:24:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Ana Bobillo <anabobillo3@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
 <be19d210-ddde-4cbc-b991-a299db0e58dc@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH 3/6] mtd: ubispl: check the PEB numbers read from the
 fastmap
In-Reply-To: <be19d210-ddde-4cbc-b991-a299db0e58dc@gmail.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Ana,

On 03.11.26 08:12, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
> 
> ubi_attach_fastmap() sets a bit in the fm_used bitmap for each PEB of
> the fastmap's used list and tests and clears one for each PEB of a
> volume's EBA table, using the PEB numbers as read from the fastmap.
> fm_used has room for CONFIG_SPL_UBI_MAX_PEBS bits: a larger PEB number
> in either list reaches past its end, and a used-list entry of 2^31 or
> more becomes a negative index before its start.
> 
> Check both against the PEB count with ubi_io_is_bad(), as scan_pool(),
> assign_aeb_to_av() and ubi_scan_fastmap() already do for the PEBs they
> take from the fastmap, and reject the fastmap if one is out of range:
> the loader then falls back to a full scan.
> 
> Fixes: 6f4e7d3c75a8 ("spl: Lightweight UBI and UBI fastmap support")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   drivers/mtd/ubispl/ubispl.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

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
