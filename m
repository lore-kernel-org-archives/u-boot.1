Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC47AC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 859AC406B2;
	Thu, 27 Aug 2026 07:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id el4uhKfneA9x; Thu, 27 Aug 2026 07:25:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787815548;
	bh=lzE/QH/mmYI/H58DcbYKdE4ClhkKgMkh2/kYzJr1vf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XsxqjRHwjY8F0oyiDf6gi24lbQc4dTalnVHjlfSbwWbLIWYs6JL3VM6JIlGj04pDg
	 ycXum/Vt6VwXx3Sd0vkOdJi2hT5l1ERWYxebW3CJ62r3HCdHORS1zkdIC3oc7Tbb7d
	 MBQVU0/AZDoAWtTHslsRsmtbiWsy0A8Hu0kW3i0eybJAopuWFQo4Jhc/xWJMK7qYsA
	 /Sf0tUsN7j09/YFAMZbpzNcNBHg30zlbf/2lta2oxV84Endrvzs6/wPD+A+1KZq+HJ
	 59NYp1Gvf9LD4rfskB2LEg4AGiFMgpeRsxSxMLXtjhsG0jH1k+berWnYE27PCjVW+u
	 3K8ygOKYbLJdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0AB0406A0;
	Thu, 27 Aug 2026 07:25:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BA9B334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AC9F406A0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tUEzWO2-qgKi for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:25:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=PN5PlAws
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D63D4069C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:25:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DBEA34E413DA;
 Thu, 27 Aug 2026 07:25:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AF4E0602B8;
 Thu, 27 Aug 2026 07:25:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 18D7211C78051; 
 Thu, 27 Aug 2026 09:25:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787815542; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=lzE/QH/mmYI/H58DcbYKdE4ClhkKgMkh2/kYzJr1vf8=;
 b=PN5PlAwsyPzBoEHEzbjhdE4pAM6a19FGxZQoYEHW3pEHq9FKmAQKtTC4x4qUOaDEBEoIc7
 d5WHYFYkHmY2xzIspaCuPeh/uPqVadTbo8bbrm5Lt9BsarWLrkq4MGmj0v677QhuSLmj6f
 LcAK5Lk8zgvftbxQwgQG86Pi4rjULGNJlZYC7J+OlYkAB5n7RVERyx09Zs7TVSHKdLnIOL
 XVmqcoLLTXDfUiA3rGhcx1f8eLcthbH9V/kuKNkunGbX6KhS+TJtElAZj6QQTh4IbOarRG
 0PHhxsn1uzemHoblZrIylnehaBWaHd4f2ZTlsOpsskMeRXRol90gkgfAR9WEQg==
Message-ID: <02a195fd-3dcb-4709-aaf5-606e8c91213b@bootlin.com>
Date: Thu, 27 Aug 2026 09:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fs/squashfs: fix directory table integer overflow
To: Tom Rini <trini@konsulko.com>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: u-boot@lists.u-boot-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, u-boot@lists.denx.de,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>
References: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
 <20260826223236.GA3986474@bill-the-cat>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260826223236.GA3986474@bill-the-cat>
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

Le 27/08/2026 à 00:32, Tom Rini a écrit :
> On Tue, Jul 28, 2026 at 08:55:38AM +0200, Shahriyar Jalayeri wrote:
> 
>> This fixes an integer overflow in the SquashFS directory-table reader
>> that leads to a heap out-of-bounds write, and adds a regression test.
>>
>> sqfs_read_directory_table() sizes the directory table with an int
>> multiply (metablks_count * SQFS_METADATA_BLOCK_SIZE) that wraps for a
>> crafted image, under-allocating the buffer that the fill loop then
>> overruns. It is reached by listing or reading the image (sqfsls /
>> sqfsload). Patch 1 guards the allocation with __builtin_mul_overflow();
>> patch 2 adds a test that a crafted image is rejected.
>>
>> Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.
>>
>> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
>> ---
>> Changes in v2:
>> - Use my real name in the From and Signed-off-by
> 
> Any feedback from the squashfs custodians? Thanks!
> 
Nice patch, looks great!

Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>

