Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D77C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 12:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFAC88577;
	Fri, 10 May 2024 14:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JacKGz9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3568860C; Fri, 10 May 2024 14:22:57 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB37E880A8
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 14:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ACMsd9053613;
 Fri, 10 May 2024 07:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715343774;
 bh=2wh3SwJ0oLfyqdQpZhT2+/anVkf2GAufbjJ6D8U2j8M=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=JacKGz9WN1OJNj0I4qWbQ9u4CmtT7aAW1aY+GLmlWaeEKYsR5HAs1R65QEigSKRzo
 9vIoEuzir5FgcQSpdB9Omr1JOXLZFzOz7N9EeUx9GatP5YHQ7J2t/Zu0um8MtphAVB
 h1S7HZ2tcUgRusnlcEy97fZV2WcJ27uBfIygKUs8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ACMsKn020494
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 07:22:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 07:22:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 07:22:53 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ACMoii091351;
 Fri, 10 May 2024 07:22:51 -0500
Message-ID: <a0683e99-5b1f-aed1-fc96-1ee781482d9b@ti.com>
Date: Fri, 10 May 2024 17:52:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] board: ti: am62ax: Add support for remote proc load
Content-Language: en-US
To: Hari Nagalla <hnagalla@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <afd@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
References: <20240509142037.32064-1-hnagalla@ti.com>
 <20240509142037.32064-5-hnagalla@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240509142037.32064-5-hnagalla@ti.com>
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

On 09/05/24 19:50, Hari Nagalla wrote:
> Add AM62a remote proc firmware names to environment variables for
> loading of C7x DSP and R5F processors.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>  board/ti/am62ax/am62ax.env | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
> index 334374abb7..97122fb57b 100644
> --- a/board/ti/am62ax/am62ax.env
> +++ b/board/ti/am62ax/am62ax.env
> @@ -1,5 +1,8 @@
>  #include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
> +#if CONFIG_CMD_REMOTEPROC
> +#include <env/ti/k3_rproc.env>
> +#endif
>  
>  name_kern=Image
>  console=ttyS2,115200n8
> @@ -27,3 +30,4 @@ get_kern_mmc=load mmc ${bootpart} ${loadaddr}
>  get_fit_mmc=load mmc ${bootpart} ${addr_fit}
>  	${bootdir}/${name_fit}
>  partitions=name=rootfs,start=0,size=-,uuid=${uuid_gpt_rootfs}
> +rproc_fw_binaries= 0 /lib/firmware/am62a-mcu-r5f0_0-fw 1 /lib/firmware/am62a-c71_0-fw
