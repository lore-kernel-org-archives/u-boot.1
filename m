Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CA5C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 04:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5D5874A1;
	Thu, 23 Nov 2023 05:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MNrykC6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D8F875AF; Thu, 23 Nov 2023 05:45:12 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CEFC86DAF
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4j6Il090063;
 Wed, 22 Nov 2023 22:45:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700714706;
 bh=y9pV6UD/ttAEip989EXIGs5Yb8833z0MZmi3pEQ9yks=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=MNrykC6U5qjaWY2xo0CNEPTjd4TU3ZgZY26YwGzWpX9V+RLObvzT5jnbPcnYZ+KOw
 KwjGzVgs0oI1Pn1hLrwSEn5z3sP64Z65qDsHyVG4Pwv/j7DZaoASgAzeBO/l2z3Yc/
 2rMCreCAnX0B9LO9lGWqkn78cv1WsfcJR9Ak3gLQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN4j6n6103898
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 22:45:06 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 22:45:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 22:45:06 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4j3SU018899;
 Wed, 22 Nov 2023 22:45:04 -0600
Message-ID: <56ea71f6-a088-4213-b7ad-3fdac1acef5e@ti.com>
Date: Thu, 23 Nov 2023 10:15:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] ufs: Allow mmio registers on the PCI bus
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-7-bmeng@tinylab.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231011131552.14665-7-bmeng@tinylab.org>
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

Hi Bin,

On 11/10/23 18:45, Bin Meng wrote:
> Check if the UFS controller is on the PCI bus, and get its register
> base address accordingly.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   drivers/ufs/ufs.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 96801866d3..fb2a607ef1 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1914,6 +1914,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   	struct ufs_hba *hba = dev_get_uclass_priv(ufs_dev);
>   	struct scsi_plat *scsi_plat;
>   	struct udevice *scsi_dev;
> +	void __iomem *mmio_base;
>   	int err;
>   
>   	device_find_first_child(ufs_dev, &scsi_dev);
> @@ -1927,7 +1928,14 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   
>   	hba->dev = ufs_dev;
>   	hba->ops = hba_ops;
> -	hba->mmio_base = dev_read_addr_ptr(ufs_dev);
> +
> +	if (device_is_on_pci_bus(ufs_dev)) {
> +		mmio_base = dm_pci_map_bar(ufs_dev, PCI_BASE_ADDRESS_0, 0, 0,
> +					   PCI_REGION_TYPE, PCI_REGION_MEM);
> +	} else {
> +		mmio_base = dev_read_addr_ptr(ufs_dev);
> +	}
> +	hba->mmio_base = mmio_base;
>   
>   	/* Set descriptor lengths to specification defaults */
>   	ufshcd_def_desc_sizes(hba);

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
