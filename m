Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E4606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BSKwBzRb;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=AQRHYWf5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1C3960697;
	Wed, 11 Nov 2026 09:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4Wd2H0Zmxqs; Wed, 11 Nov 2026 09:46:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EBF86607A8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794390377;
	b=J3gRvsbrzHSi9cuh7albxVhqAznoam9bCX1UsK/w7aegY2t9twI8vPVBU3bwzX8LnV1V
	 +8LijKhD/BJPU+5CsYkPpJI/xg94wZ6MwFUuUd58/bYnll79etLVTMe+uhSKM90wU+yfK
	 0sOVUVZyhlCAVHQBPXYPHp7uKMXnnMbGuLmDYDHYus+69GvfpbfowXF9j10Ym7Hi975Kj
	 z9vA71QJL+lWxvyQ/Oi0xcYBjmvvih1eGBXl0UGGCgjHCAoZOKLUgPG71z0WkxXbewH8h
	 fxIypgfrAyobiZNURwzq/5e0tiqdHIRF0UPgDIRXlMOwbOfla8pMtGbldgr1S7LEZPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794390377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PnRybSmTJxA2PqNJ3Mc3GOHBaAZrTfOMTuF+0VJrPR8=;
	b=opMTXg6QcUmwFq6/7AcdoOVpOxtrJNF4Gbwr+0sRpdQVEFPzSkMo3Tlgf8PpC67kL2lJ
	 W7vN5rn0sGe2vEgTCNKWVcG/U8XSw8DmY8zI9jiHPW0Vysc8Jon+gKqFWWz9tCZg6UBzW
	 tqR3gWdqMwtgiw+FUl8Ihu7YpzwfuYaxkvCt3/eIEQ8g3mf91hdtpz081+QOJO8E7Uvph
	 tcUmFfv9LUluf09DeV4luqLQlGQ4gCluIozeFyFyEzE0moLnohL+zcpqj1Pc4/WfYgd0b
	 Kinqwetwc4hY+iBaaJXU8l0jzjInRjCBfSsk6mQqFbn2RIeVOw3miHBxz5g0U9p3V1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794390377;
	bh=PnRybSmTJxA2PqNJ3Mc3GOHBaAZrTfOMTuF+0VJrPR8=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BSKwBzRbt87ut6QBN1Ux3EEslaxblVn9p94UOmY4IWDgm+2JH5jKmfDCKvn6iAR5H
	 k7BQuajNZp/WcNCXoSY3mLeidbNhzi4nHueHS7GH1RQa1zbhlX6XqKt6jDrAL64xZG
	 xWpWQY5sSBE0iknpF8sYjDVfGva0ynZtcJ+kM93TIODqpdhF58DC6vM1tW5W3yDK2J
	 DAA7TMljsxBGajusoVuO9mZSzoNVWy43oQntkCZQ1arEKEpvGbOUPCHcGePpTsMCeZ
	 eSxO8TOtlZThjzwR+Zt2maxVa4gfSQ09xDwbYlIC3FzuqyufD+jBBk18ZP77K9k8ce
	 Bv4yC/VdOA55Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBF86607A8;
	Wed, 11 Nov 2026 09:46:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AAB817CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CA1140318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANxy2SIRxlWB for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:46:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A6A2340070
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=AQRHYWf5
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6A2340070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:46:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 59E5A10DDEC; Wed, 11 Nov 2026 10:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794390368;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=PnRybSmTJxA2PqNJ3Mc3GOHBaAZrTfOMTuF+0VJrPR8=;
 b=AQRHYWf5p+vL0GmV/GNBiZoEEkCpsvgatauOKzfIuw6FjHCduMxbslhVkK314Ka7DbA5HS
 IJV4VHXeNCvHO1e5OdiFPqOPoipWl5gNCywG9XxQzPJ1fMcrx5swRIH2QOMi0g9fmvkOG+
 aS4W96UZc3Tm4dq/RHmabQKwnQwQTq1Qgl2bDJYgoiVtaFvKBETr8G1P2cF6ZSP8/+7maf
 CoJO5PRpSw+lk2u6nR7qRLeucun1fdKF/4dgsSlf7q4QcVGreLF8OHxaW9t5gwkfpe6YON
 PnOBfiZfXTZa/OBFwS/fh1qSUeqboEq1rxpecA4P9NT9cggRnryTXAhRLOoknQ==
Message-ID: <38afbaf5-eeb5-a4c1-c027-361f841aeb4a@nabladev.com>
Date: Wed, 11 Nov 2026 10:46:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Ana Bobillo <anabobillo3@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
 <5d9e42d6-506b-4046-8df1-a1ccc11721da@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH 5/6] mtd: ubi: fastmap: bound the size of a volume's EBA
 table
In-Reply-To: <5d9e42d6-506b-4046-8df1-a1ccc11721da@gmail.com>
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

On 03.11.26 08:13, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
> 
> ubi_attach_fastmap() reads each volume's EBA table header, then advances
> fm_pos by four bytes for each of its reserved_pebs entries and checks
> that the result is still within the fastmap. Two things are missing:
> 
> - The header itself is read without checking that it fits into the
>    fastmap first.
> - On 32-bit builds, fm_pos is 32 bits wide, so a large enough
>    reserved_pebs makes the multiplication wrap around and the check
>    pass. The loop that follows then reads up to reserved_pebs entries
>    past the end of the fastmap buffer.
> 
> Check fm_pos after the header, and reject a volume that reserves more
> PEBs than the device has before using the count, which also keeps the
> multiplication from wrapping.
> 
> The SPL loader's ubi_attach_fastmap() in drivers/mtd/ubispl parses the
> EBA tables the same way, and most boards that use it are 32-bit, so
> make the same change there.
> 
> Fixes: ff94bc40af34 ("mtd, ubi, ubifs: resync with Linux-3.14")
> Fixes: 6f4e7d3c75a8 ("spl: Lightweight UBI and UBI fastmap support")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   drivers/mtd/ubi/fastmap.c   | 14 ++++++++++++++
>   drivers/mtd/ubispl/ubispl.c | 17 +++++++++++++++--
>   2 files changed, 29 insertions(+), 2 deletions(-)

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
