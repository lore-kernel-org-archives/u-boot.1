Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C6EC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 16:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3AC683890;
	Tue,  5 Aug 2025 18:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="udG1lHwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79CD83893; Tue,  5 Aug 2025 18:05:43 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 775DA8388B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 18:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575G5c0w320348;
 Tue, 5 Aug 2025 11:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754409938;
 bh=Ghw+Ta156nylZYyK/zKU9swg5v4hzuUBnmY3IuuRXmU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=udG1lHwdL+HkZSuOs+kxLUVoUof+0heo34YTThgrgY9m6xH1/KVi4d5Q2HMVUWdP4
 FgKbqLq7f/Bvrbf8fsJehOe4Q+57ZW/cffwXkZRtLDY++kUGty79eOq0mt8fggBjgN
 Nsc7eMiBz7gvAebQRdifzK6Kl75DREfg3VQUnveU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575G5cx53563429
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 5 Aug 2025 11:05:38 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 11:05:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 11:05:38 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575G5cv12397356;
 Tue, 5 Aug 2025 11:05:38 -0500
Message-ID: <20abb931-125c-4769-b1a5-4cc770ccc303@ti.com>
Date: Tue, 5 Aug 2025 11:05:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: soc_ti_k3: Add support for AM62P variants
To: Tom Rini <trini@konsulko.com>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
References: <20250804233718.1471877-1-jm@ti.com>
 <20250804233718.1471877-2-jm@ti.com> <20250805015005.GG124814@bill-the-cat>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250805015005.GG124814@bill-the-cat>
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

Hi Tom,

On 8/4/25 8:50 PM, Tom Rini wrote:
> On Mon, Aug 04, 2025 at 06:37:17PM -0500, Judith Mendez wrote:
>> This adds a support for detecting AM62P SR1.0, SR1.1, SR1.2.
>>
>> On AM62P, silicon revision is discovered with GP_SW1 register instead
>> of JTAGID register, so introduce GP_SW register range to determine SoC
>> revision.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/soc/soc_ti_k3.c | 66 +++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 61 insertions(+), 5 deletions(-)
> 
> This is fine for what it is. But is there any clean way to guard some of
> this data / tests with IS_ENABLED() checks so we don't grow every K3
> platform?
> 

Sure, I can wrap the functions with IS_ENABLED() and respin, thanks (:

~ Judith

