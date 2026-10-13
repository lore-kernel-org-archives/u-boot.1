Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD203CA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 00:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8289480854;
	Tue, 13 Oct 2026 00:49:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_wpMcQ8uj1O; Tue, 13 Oct 2026 00:49:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C28D380ABD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791852584;
	b=o9kDjxkU77IKZIkInNTanTO/K4Q/KXUi9xKhbe+I3xVTOYgKkF7klLd0glP6/nGAT9LT
	 dCJwvSkYWiNpjQSv7IsPNlBs/9aim6UsUtFBU8tAbJmEzvoNdVpKHM/LEoopZBlOKWWHI
	 xbW/CGAlLXPdDF8pexFRhwKbBb+mSrJrKcSeWf/osppEwDXmfL8gNWHgT0xQfgsQdvHTs
	 cVn88/3lu4K5NFxYrHEKXTzAysKsqJNYdZqOOFwus6A03bOXLlBOfxWyByHqfe2CfUqWE
	 IMLBACLIW7axivwn49U/swyfBWtltPtL7FwX/pBKV0wbgs54lB+LyR4aCS2P3PBllaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791852584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GweCLGMiIJMfrWWrNsQ4AcCFianLKS/rnKTY3Ifae4g=;
	b=VQXaMovRd70o3/nH2uzOg4f9L5WZrTaKJ1tO1eSJfwFJwB3I3+I3DVCovd731/hI2u/G
	 zDecZ5MDwZJFZNV60L+RqgmgtX4eTfsgwtqwY7REfVdR9nk6uswnhCKdUTrNkyweUr5Kz
	 QD107FWEHgyWTdvnw+/mCdFYv3EuxNBxLXeLFm32102UwOZPlXLhk3UAvaa2WK2OlDMb8
	 KQSlE8IVFXm4YqzQxj5Dy6iRP756v9NrrU3eZqFxZjy55PFXzvmiOHarDH+DNtfCB1/2T
	 OCJlZ4IXVInhy9VdF/Mx1sQisW8zMQA6wpavE3e+eUrZfIfsWk3CuRf+B62oauaRBhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791852584;
	bh=GweCLGMiIJMfrWWrNsQ4AcCFianLKS/rnKTY3Ifae4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=whPTh1F8blFz30M3pjjz6oknOBN+Z9VSaBsH62uQreeUdBoBpJBdgE0LlbFEJCiZE
	 VAJsRasreLquetaP5ySP9SqQvaqffKCwIn46KbXxGm7tLmHBDiGL5c4ypHDf2U3TDt
	 HQjy4qjyyv6L9z+paNXn9DMr+ZAmtGlmNHccnrV72NxbGLFevp8IvE1XCXzjuLiaK4
	 50NucJbenstD4wQURFtqnNryEm/M5VzX7dW+AVPvjuVcJ2Ldsa3jXOBW1+dDssQZRl
	 RNFDmJmMlLI2dUMS9o073aGvm5YgELfGhbrnlhQjiPXP8EBYY+tPSZaGlpV6R1j2Dv
	 me5GWiPbso1Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C28D380ABD;
	Tue, 13 Oct 2026 00:49:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89A174DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B1004052B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93CPO5Cn-3st for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 00:49:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5F274052A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791852583;
 b=EoZe96BhYw7s3MeqON+v+a+BX41OrCD0fcP1WPsJsKdIMtVyUPeDhCj6vijITJJgSIFY
 Pu+l4G9u4p8TAP1TqX6gd5ClEr4LbutDRBzeLVH4g3L/pBa10/fDoVFFbUXQQjpt32U4U
 ITWx5BHljn40KBc9i+hqXQwoDDFoEiGTRDJpjKoRewH6u2Nqbh1BbgO9nZMIytnscJKDU
 SCEH6hlNCWaIUo8ZphSGxojF16ipWmHilO/+MPHsGrAmv+IfyCRosKqq1THrYPGdDF/cd
 9YINGJPDcWsrCuSoInbvgp1ObwvWBPQb6GF4FwRe0dpndOLv3ctlgR6OiufF3JJEodw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791852583;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=GweCLGMiIJMfrWWrNsQ4AcCFianLKS/rnKTY3Ifae4g=;
 b=DLvzUbjZXMiDksI/rCJgwwVOd/MlMAYhG756410Xm568vbPpZOSnz7Dqkh+czocu8GFg
 Ou512CRXRsiAxtmPOcyWuE5UbLba+atJOF8r/NvMcPpFZUIb7EnHZvkbhJ9EE5OjLK3yy
 x523kHdEEbmtNYyBTtfZ5KSc1P8i3tUatqOLTKOmbUfkknnGzNR4Xf/wPx35/8zL6CcpB
 0bxUe/uVoXVMPUhY+EBwua6JwPRfc0KdtEGToXlvRWcb3vqWLZenUXd8dEV2jScgxFb93
 Lh9qg5L0by9euPEIMcZCV2FeA0bj0pSws0KoYVQB43szMXiWQtkuHw+8vAVWOTECqhw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=g+fCoTMd; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=g+fCoTMd
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5F274052A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:49:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE6EC108C8B; Tue, 13 Oct 2026 02:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791852576;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=GweCLGMiIJMfrWWrNsQ4AcCFianLKS/rnKTY3Ifae4g=;
 b=g+fCoTMdDXdC/FRxhQ0SivXWvuHXYjLspMjEL0Au2NAdUlbzmfWh7HEhh7LHvuhV3JGxGP
 t4BZ7sin1yTfTZf0D436R/aw5cghWgJTh9nsrqUKhdiLFJBDV19Zg73vjZYB2hceNq6laJ
 +s71G1/39586ZK78qgzXCEiHMcZf4cv5JleJqstrXZANBgxokA3+51IEAVzQar9qS0Oi9L
 xJKWV83iGBYEaiPeeNb/GQk1cn6S3sQ2oCppUC4wslamUJb8BayYFuIo84OR9KDySG2TEf
 AwjDWWSYv0chyNht8rZPMeDW7oSuVQQPLq+VEOx18N4Z49NEawRgOJ/WS+xd+Q==
Message-ID: <a25a4df3-30c5-ede3-d941-f43c93c6abb8@nabladev.com>
Date: Tue, 13 Oct 2026 02:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/5] mtd: align a partition on the write size if the
 device cannot erase
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini <trini@konsulko.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-3-hs@nabladev.com>
 <CAFLszTgUh-EdnBYGeRvGh2pkRLc7jyauGHXB1XoZSNSF2f-aWQ@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAFLszTgUh-EdnBYGeRvGh2pkRLc7jyauGHXB1XoZSNSF2f-aWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Simon,

On 09.10.26 09:02, Simon Glass wrote:
> Hi Heiko,
> 
> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>> mtd: align a partition on the write size if the device cannot erase
>>
>> allocate_partition() aligns a partition on the erase size of its master
>> and checks the offset and the size against it with mtd_mod_by_eb(). A
>> device which cannot erase has no erase size, so that check divides by
>> zero, "mtd list" shows
>>
>>          ### ERROR ### Please RESET the board ###
>>
>> Linux aligns the partition of such a device on the write size instead,
>> see wr_alignment in allocate_partition() in drivers/mtd/mtdpart.c. Do
>> the same here, and take the alignment for the MTDPART_OFS_NXTBLK
>> rounding from the same place, which divided by the erase size as well.
> 
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>
>> drivers/mtd/mtdpart.c | 35 ++++++++++++++++++++++++++---------
>>   1 file changed, 26 insertions(+), 9 deletions(-)
> 
>> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
>> @@ -563,8 +563,12 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
>> +     u32 wr_alignment = (master->flags & MTD_NO_ERASE) ? master->writesize :
>> +                                                         master->erasesize;
> 
> Patch 1 decides that a device cannot erase with !mtd->erasesize ||
> !mtd->_erase, but this patch checks MTD_NO_ERASE, and the two don't
> always agree. A driver that leaves erasesize at 0 without setting
> MTD_NO_ERASE still divides by zero here, as does an MTD_NO_ERASE
> driver that leaves writesize at 0. Since the point is to stop 'mtd
> list' crashing, I suggest skipping the alignment checks, or adding a
> WARN_ON(), when wr_alignment is 0, rather than relying on every driver
> setting the flags correctly. What do you think?

Makes sense, I think I remove the alignment checks and add a WARN_ON()

> 
>> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
>> @@ -731,19 +737,30 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
>> +     tmp = slave->offset;
>> +     remainder = do_div(tmp, wr_alignment);
>> +     if ((slave->flags & MTD_WRITEABLE) && remainder) {
>>                /* Doesn't start on a boundary of major erase size */
> 
> This comment is now out of date.

Will fix this in v3.

> 
> In any case:
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks!

bye,
HEiko
> 
> Regards,
> Simon
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
