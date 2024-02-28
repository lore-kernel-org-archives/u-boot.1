Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34F7C54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 09:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AA9876F3;
	Wed, 28 Feb 2024 10:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WmUtVwMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06A087776; Wed, 28 Feb 2024 10:15:12 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A37876BA
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 10:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S9F4JJ083468;
 Wed, 28 Feb 2024 03:15:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709111704;
 bh=sgS4fRoB/gMw5m7In9zz7x6pgx7x8snsvVMBkyLp22A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=WmUtVwMmUS/LyZ0XgC7lruV0AKA1LXuTM43diTnCOeAVyy+Nu5hi5HNddtFJyXbj2
 it/pSbTfnr2MngbSEl9uUGv2fxG9Pm2uuYUq8YkQSsq7ub3l5ZTl4FbQrNJhXYaVxU
 kwQIAGT1YG3D+fuLE07GLHmr1wDzi4JmqgN6o1YM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S9F3FV025698
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 03:15:03 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 03:15:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 03:15:02 -0600
Received: from [172.24.227.68] (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S9F1gf118866;
 Wed, 28 Feb 2024 03:15:01 -0600
Message-ID: <ca61d995-9872-4685-b768-85db9348cc24@ti.com>
Date: Wed, 28 Feb 2024 14:45:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: phytec: phycore-am62x: Update artifact names
Content-Language: en-US
To: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Tom Rini <trini@konsulko.com>
References: <20240228085848.1230795-1-w.egorov@phytec.de>
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20240228085848.1230795-1-w.egorov@phytec.de>
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

Hi,

+ Tom

On 28/02/24 14:28, Wadim Egorov wrote:
> Use proper binary artifact names for HSFS devices.
> Do not use the *_unsigned binaries.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---


Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   doc/board/phytec/phycore-am62x.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
> index 1d641a78cf..bc6d524669 100644
> --- a/doc/board/phytec/phycore-am62x.rst
> +++ b/doc/board/phytec/phycore-am62x.rst
> @@ -92,9 +92,9 @@ Assuming the uSD card is `/dev/mmcblk0`:
>   To boot from a micro SD card on a HSFS device simply copy the following
>   artifacts to the FAT partition:
>   
> -* tiboot3.bin from R5 build as tiboot3.bin
> -* tispl.bin_unsigned from Cortex-A build as tispl.bin
> -* u-boot.img_unsigned from Cortex-A build as u-boot.img
> +* tiboot3.bin from R5 build
> +* tispl.bin from Cortex-A build
> +* u-boot.img from Cortex-A build

LGTM.


-- 
Thanks and Regards,
Dhruva Gole
