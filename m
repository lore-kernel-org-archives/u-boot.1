Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83338C61D97
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 17:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 986CC86FD5;
	Thu, 23 Nov 2023 18:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QUZRhZuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D948871B4; Thu, 23 Nov 2023 18:35:09 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB5286EF1
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 18:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ANHZ2ca037517;
 Thu, 23 Nov 2023 11:35:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700760902;
 bh=AW87YSVqUhqws0UDuLTCUNXkQqy6Xpx8DL5kPpKym+U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QUZRhZuQn0JyZaam8zbSL5gPA1ymT8f0QAww+HhFh/yxme+KA9QIKokN2G28bXqrw
 13gUC1aSj+s/w+Q2x6zFOVIgfPAuDpUO8XmhbRmYzgKAo/BQ98YuUEaeqmKAuioyw4
 cdUWKSBiL8//YCdHWw67SDwsxu30gyDObD+FIkVs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ANHZ2Ji065968
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Nov 2023 11:35:02 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 11:35:02 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 11:35:02 -0600
Received: from [10.249.142.56] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ANHYwUC030114;
 Thu, 23 Nov 2023 11:34:59 -0600
Message-ID: <fdce61c7-6517-4965-94ba-90fc8dbd2bdd@ti.com>
Date: Thu, 23 Nov 2023 23:04:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm: mach-k3: Remove non-cached memory map areas
To: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>
References: <20231123172214.653268-1-afd@ti.com>
 <20231123172214.653268-3-afd@ti.com>
Content-Language: en-US
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20231123172214.653268-3-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
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



On 11/23/2023 10:52 PM, Andrew Davis wrote:
> @@ -219,16 +177,9 @@ struct mm_region am62_mem_map[] = {
>  	}, {
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x1E780000UL,
> -		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -			PTE_BLOCK_INNER_SHARE
> -	}, {
> -		.virt = 0xA0000000UL,
> -		.phys = 0xA0000000UL,
> -		.size = 0x60000000UL,
> +		.size = 0x80000000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>  			 PTE_BLOCK_INNER_SHARE
> -
>  	}, {
>  		.virt = 0x880000000UL,
>  		.phys = 0x880000000UL,


This causes issues when TF-A region @0x9e780000 is firewalled off from
non-secure world. A53 does speculative accesses to this region from EL1
leading to FW exceptions being reported on TIFS log (although A53 itself
doesn't seem to abort)
