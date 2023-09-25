Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC22ECE7AA8
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 17:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DDD86BBC;
	Mon, 25 Sep 2023 19:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E6eNi9Oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C6386BC4; Mon, 25 Sep 2023 19:01:00 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA87086B3F
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 19:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PH0pwJ122204;
 Mon, 25 Sep 2023 12:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695661251;
 bh=5nVBa/n+WS/BB1xB1KwPv9cjqrmstWccnvEl3+obKcU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=E6eNi9OqfRmX/vJcZlssbElky4oFP1WFITfzhXh6+siKc5RHw6YM0D8iNYuvOR4U5
 Soo1UuhZPGVbiDFstc3XfPPWshriewnrWDkJhbkgbexopJKh86FWvcR28/E51wrk1T
 A+NviKRUDb85H7TB+pQGD6Ze8NL6Hezv38GCPtkc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PH0pK2038831
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 12:00:51 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 12:00:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 12:00:51 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PH0mcF127508;
 Mon, 25 Sep 2023 12:00:49 -0500
Message-ID: <ee635678-1248-ace7-e7ed-0f135419fded@ti.com>
Date: Mon, 25 Sep 2023 22:30:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/3] enable power and clock Kconfig conditionally
To: <nm@ti.com>, <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>
References: <20230913043930.1316130-1-u-kumar1@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230913043930.1316130-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tom,

On 9/13/2023 10:09 AM, Udit Kumar wrote:
> This series, updates enabling mutually exclusive power and clock configs
> for TI SOCs.
>
>
> Sorry to push clock and power changes in one series,
> managed by two maintainers. But In my quick grep,
> I am not able to active PR raise from both trees.
> So copying maintainers of clock and power for review.
>
> Change log
> Changes in v3:
> - Patch 1 and 2: Added reviewed by
> - Patch 3: Corrected Fixes in commit message
> link to v2:
> https://lore.kernel.org/all/20230912130645.1202325-1-u-kumar1@ti.com/
>
> Changes in v2:
> - Patch 1 and 2) Added conditional support to enable Kconfig
> - Patch 3 No change
> link to v1:
> https://lore.kernel.org/all/20230911111946.749270-1-u-kumar1@ti.com/
>
> Udit Kumar (3):
>    power: domain: ti: Enable single config for power domain
>    clk: ti: Add support to enable configs conditionally
>    config: j7200: remove not needed power config

NAK,

One of boot mode (OSPI) is not working with this series on J7200,

Please don't merge this series,  Let me fix OSPI boot and re-roll this 
series

Thanks

Udit

>   configs/j7200_evm_r5_defconfig | 1 -
>   drivers/clk/ti/Kconfig         | 8 ++++----
>   drivers/power/domain/Kconfig   | 2 +-
>   3 files changed, 5 insertions(+), 6 deletions(-)
>
