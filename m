Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE64C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 18:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E1948334D;
	Fri, 23 May 2025 20:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dO0Uzqmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022038338C; Fri, 23 May 2025 20:46:02 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B863C83340
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 20:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54NIjvuJ1034224;
 Fri, 23 May 2025 13:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748025958;
 bh=T5GOQUIJ1GtSfC/ohFOtPRWmnD7f2N1a9puU7ea5Hhk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dO0UzqmdGuMi4goM9BEzpoa/1GUF5wZnoEWaLmamDK4B+UACQGDqmO9dJ0F5+VxSQ
 wk3TUV0OtNt7sOLoGpfWTEkryRT4vvJ7d0ltWPG6KY7XSMyg2zPnFQO7XSjBhsRlUc
 qsjXJ9AFF4QU2pWsc5QPjNK6INK087iW8B/ZKHpc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54NIjvId278110
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 23 May 2025 13:45:57 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 May 2025 13:45:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 May 2025 13:45:57 -0500
Received: from [10.249.34.250] ([10.249.34.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54NIjvXD1359039;
 Fri, 23 May 2025 13:45:57 -0500
Message-ID: <2a897ac4-282f-45f8-a7eb-47b9d724adf6@ti.com>
Date: Fri, 23 May 2025 13:45:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: am62ax: env: Use default MMC related args
To: Andrew Davis <afd@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Chirag
 Shilwant <c-shilwant@ti.com>, Neha Malcom Francis <n-francis@ti.com>
References: <20250522164013.125496-1-afd@ti.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20250522164013.125496-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Andrew,

On 5/22/2025 11:40 AM, Andrew Davis wrote:
> There are common MMC args for TI plats in include/environment/ti/mmc.env.
> Since we already include this, there is no need to redefine these
> MMC vars. Use the defaults.
> 
> This seems like something that could have been done while refactoring
> these vars in the first place as it happened after this AM62A file
> was available hence the fixes tag.
> 
> Reported-by: Chirag Shilwant <c-shilwant@ti.com>
> Fixes: 3709b529156e ("env: ti: mmc.env: Move mmc related args to common place")
> Signed-off-by: Andrew Davis <afd@ti.com>

Thanks for the patch.

Reviewed-by: Judith Mendez <jm@ti.com>



