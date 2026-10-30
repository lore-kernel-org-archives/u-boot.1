Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F9606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rsKhIjfB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OX4Hjoi7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B016810C3;
	Fri, 30 Oct 2026 16:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GI218g9Td_ns; Fri, 30 Oct 2026 16:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18D8380E13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793376848;
	b=FMJJhx03VPyVjxGF2oWtkCe4ojEoXDC94hSjXIGdYYhsx33gDLFFr9GdQP9ISRrfcaI1
	 W1uD0V8S5EsHtmnSoWpzUNUjqnf9ue7xjC1B8X2E4sVMsoEwqGuApqCK6vNRBLddmZk0w
	 Z49uGOh3DWklOCMcLZa3tnOBRHv6WROhZgaBnSgAndMkhvwp6RXNLufHxdSXrC6QQibLO
	 7HJKRj69yoRHSgX5EcTI0T6tV0uJD1x4DhbhF7LB8oJVe7ayirIAL6jb6NT5u78dVX/mW
	 36CZF99zjSslGOyMb+pM1+BVgalWi92SnZGRdyf33wsbvE3/MnQ2xWDsHZJBQYZA88g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793376848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=d+aQGcaeEQlD6fDFfob1gp9IeVcBGDYwKhw6e+gpVC4=;
	b=M/m1sHlRcxeiC/6RRo0jDL9I/ltYqjT+qKm/DZ58sTHVh3POylT8K9MJxZ63Vy0TPVeN
	 ehfZ2Knabw/vwB2JGU51ZCJmKrxIFetDdL3amfEPohWKBYo2e1eDv9PydrEamlEVYKHqv
	 TXihTzPHRbcYssl+YeUwn3JqjUpaJaQDzkHZ+XuWRVSw3QgsRESa4IwptvG3YaP9/JUjT
	 AB+XtalU6Em1VTqjBRsWsYaWXH6Ww7C0ExKgssymJh2icEJuL8PfCnib+15RkOoFR0U1D
	 gcS9jVhFhe41KnOeK0RxpiN65eg+ebkKdp6fVXoyFJMb7/1gX1krT5vlEZAqyVCLVDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793376848;
	bh=d+aQGcaeEQlD6fDFfob1gp9IeVcBGDYwKhw6e+gpVC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rsKhIjfBAdD9c4AvLVvpYg7ZXWHyGpU1t4tTZHWR4ghNz3Ud+5+NDLnxmDRyXhpYE
	 n4qpP0KQmdQm3TfLxG+sj9YiPs4XgomIyCFs+yG93UyxQJhMeAY3huKkxud1F6KOqo
	 QW5IenhT77ZnByKRd3KACRXDbYJgV84mfcGK1JlTj+pPcG2KlnbQBknavyZ68WDwmd
	 P/rV0mIaIlNxnG794DD00XyexEs0qfbU7EzFRUwzojDw9N/ha6jTzYqdSos+/CmqpR
	 u51gKFt/gP6L+127KmlpKY5vcDJIjPsbkCd0B0sXnKcYCQq46Ujl3io5oiXcd7Euz8
	 0eT+v41CHBphg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18D8380E13;
	Fri, 30 Oct 2026 16:14:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D6581529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC4AD60AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Dn-Syp5bZSn for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0605560A99
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793376845;
 b=D3ErOO+V97PvY0tYINF3pyOmOWhDnn+J3QBx1RmIHgxGXtlJoBl3gfu7oIS1jaBjqFdO
 YnX+qga2rru2ij57D9bnbijIIODTZIitnGt3KNmuMaV9m2xOIjFM0jnvoimtWy+7vzwni
 v+yCL1wRdJYEe1ki6TAASIFml24ADFRp7MeFbwdSzTrRJOWXcwvJUv/XnCYn42fFZ7UDT
 1UQWoqQsKwHx41WHUkpitikVWft4mRBo4fsTgEs0sJNrRSv4BTdd0ez+OjMN7OF1V8hDW
 gBwX8AJ4X+ed5G9oBGfwluGmk+1b0IKbZ86lkoH8+X44mXqMey5ELKvd/nXe443GPUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793376845;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=d+aQGcaeEQlD6fDFfob1gp9IeVcBGDYwKhw6e+gpVC4=;
 b=rRW+Ag2wJojZz2C3en3EuVc+yIx8UJbl/HdgIGE2ZxI2czPxCmrFts7ZZ8s0ouXi5ZaI
 g5uD9Z/x4s7alMFg2PPNtB++al3wMvl/GrF0sUsVHkaS7OGihWeQieeomsOdnZyi0a6d3
 /a68AFuuYKsjEd47igCib0cdiuHSmwOrkt5YRBAR7dT/EWBE34BUvRVN94qGVXrMDsPJl
 WUy0xR80pkeXw76CKBXTOr5SZ4+DS4qbS+H2bt4HuRsSS3EXtzVxEOa/JlNpHAz9jdgFO
 6HxJoI70rM7uMcsoV/VH1iaasJ7qS+hZFHDr47R5lEO6xwllnxNfKjNnv1hrKszeydA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=OX4Hjoi7; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=OX4Hjoi7
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0605560A99
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:14:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8EBE1682;
 Fri, 30 Oct 2026 09:13:59 -0700 (PDT)
Received: from [10.57.11.71] (unknown [10.57.11.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31703F673;
 Fri, 30 Oct 2026 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793376842; bh=EFky/pSm1y3Q4o2St68UeTTtZVKJreRBTsT1PeT0r7k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OX4Hjoi7T6CTLhUY3VNboHaKrMCCFD+kANu7A0RYzg4DsM6Mc62VMFaF0fUt4k7EB
 KVu5s+A6Y6qQ6enJREZXYOTRw1B0GuKDAQTwXUPhC0YElo7eEC/PUifoY7rb8+eljQ
 FzfhaYZqgatBVOEQNyk4YHMGUjhoJ0i4RVO1Tgc0=
Message-ID: <0639556d-dd5f-4f9b-a6df-bad2625275af@arm.com>
Date: Fri, 30 Oct 2026 17:14:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunxi: Fix misspelled NCAT2 config guard in gpio_init
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>,
 =?UTF-8?Q?S=C3=B6ren_Hantel?= <fugininsane@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 =?UTF-8?Q?S=C3=B6ren_Hantel?= <fugininsane@googlemail.com>
References: <20260723105705.3338923-1-fugininsane@googlemail.com>
 <20261030110817.74836-1-vinicius.eduardo.pedrosa@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261030110817.74836-1-vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/30/26 12:08, Vinicius Pedrosa wrote:
> Hi Sören, Andre,
> 
> The Kconfig spelling fix looks correct, but I think enabling that path
> in gpio_init() needs another look. I ran into this while looking at the
> A733, which also selects NCAT2.

Ah yes, I noticed this already back then, but forgot to reply to Soeren: 
my apologies. Thanks to Vinicius for the heads up!
So yes, we need new code to setup the withstand registers.
Patches welcome!

Cheers,
Andre

> The code copies PIO+0x348 to PIO+0x340, using the H6 power-mode offsets.
> That matches the R528/T113 layout, but on the A523 family the power-mode
> registers are at 0x388/0x380 instead. So the fix would make the SPL
> write a different register at 0x340 on boards that are already supported
> upstream.
> 
> I built U-Boot next (ed869863) with and without the patch for avaota-a1,
> radxa-cubie-a5e and mangopi_mq_r. The copy isn't in any of the SPLs
> before the patch and is in all three after it.
> 
> I haven't tested this on A523 hardware, so I can't report a boot
> failure. But the register layout suggests the copy should be limited to
> SoCs where those offsets are valid, rather than enabled for all NCAT2.
> 
> Thanks,
> Vinicius

