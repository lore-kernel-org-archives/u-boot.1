Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18AFC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 21:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126AE87613;
	Wed, 22 Nov 2023 22:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NBkNJAVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA84986E47; Wed, 22 Nov 2023 22:02:56 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E68E87657
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 22:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AML2pup112218;
 Wed, 22 Nov 2023 15:02:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700686971;
 bh=5K6fFqXYpiBrSEiLcnKhFzbNYABt0GPwP5ERYu1hwNU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=NBkNJAVy7Xw0tgnK3Km1VIa8OSs/92VQpZHeSrg5ku/3DCe2uMc4blvRVG6N/GnLl
 ldm1oR1Rhq7JhQyAjfWOrYVniiZYX2QnTn2kEhQDvK3V78BDGuKIKEfQp7xBklKLss
 SK8AHqI/hsJe16ZZtV3+b9bmym+8cTtlnbvwv2YI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AML2p6O021795
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 15:02:51 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 15:02:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 15:02:51 -0600
Received: from [10.250.36.5] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AML2omI026146;
 Wed, 22 Nov 2023 15:02:51 -0600
Message-ID: <6dead440-e27b-4eb8-b04b-c9a0081936dc@ti.com>
Date: Wed, 22 Nov 2023 15:02:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: Let the compiler size the mem_map lists
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
References: <20231106165205.22066-1-afd@ti.com>
 <20231122204859.GX2513409@bill-the-cat>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231122204859.GX2513409@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/22/23 2:48 PM, Tom Rini wrote:
> On Mon, Nov 06, 2023 at 10:52:05AM -0600, Andrew Davis wrote:
> 
>> NR_MMU_REGIONS is a copy/paste from another platform that extends
>> this list later. We do not do that, so let the list be the size
>> of the initializer list.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm/mach-k3/arm64-mmu.c | 34 ++++++----------------------------
>>   1 file changed, 6 insertions(+), 28 deletions(-)
> 
> Please redo this on top of current next as the other series that have
> gone in make this no longer apply, thanks.
> 

Sure, sending v2 now.

Andrew
