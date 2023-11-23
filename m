Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18B3C61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 04:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF56987663;
	Thu, 23 Nov 2023 05:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GACbNrkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35FF8767A; Thu, 23 Nov 2023 05:30:42 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1064D86D94
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4UbYo078866;
 Wed, 22 Nov 2023 22:30:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700713837;
 bh=hM96sa975uxOAAPYNIdAME4mg4CJ2Po7QLCWknADVL0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GACbNrkWzAvvUKFOEXwLG8LNJs68m5NwkLEDIQxMpHT6gH9aBI9SR407BMxTJJH6i
 VP+VwI01eBRPDkh7PaH4eqGpayDNEaJZq1PnaUTzLs+yM1NVCCMgjukSJAPmBsBqou
 sTXgPeW0U4PY5DgTaJ8PCOYIvXHKsNgJzGxDJ7eM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN4Ub9v039786
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 22:30:37 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 22:30:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 22:30:37 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4UZpc006606;
 Wed, 22 Nov 2023 22:30:36 -0600
Message-ID: <35f2b6c1-dd90-4d06-87ed-ac553fcdaaed@ti.com>
Date: Thu, 23 Nov 2023 10:00:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] pci_ids: Add Red Hat vendor and device IDs
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-6-bmeng@tinylab.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231011131552.14665-6-bmeng@tinylab.org>
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

Hi Bin

On 11/10/23 18:45, Bin Meng wrote:
> Red Hat, Inc. donates a part of its device ID range [1] to QEMU,
> to be used for virtual devices. This commit adds several typical
> devices that are useful in U-Boot.
> 
> [1] https://www.qemu.org/docs/master/specs/pci-ids.html
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   include/pci_ids.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/pci_ids.h b/include/pci_ids.h
> index 88b0a64045..b63bf45168 100644
> --- a/include/pci_ids.h
> +++ b/include/pci_ids.h
> @@ -1363,6 +1363,13 @@
>   #define PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP 0x3fc5
>   #define PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP_MADI 0x3fc6
>   
> +/* Per https://www.qemu.org/docs/master/specs/pci-ids.html */
> +#define PCI_VENDOR_ID_REDHAT            0x1b36
> +#define PCI_DEVICE_ID_REDHAT_SDHCI      0x0007
> +#define PCI_DEVICE_ID_REDHAT_XHCI       0x000d
> +#define PCI_DEVICE_ID_REDHAT_NVME       0x0010
> +#define PCI_DEVICE_ID_REDHAT_UFS        0x0013
> +
>   #define PCI_VENDOR_ID_INIT		0x1101
>   
>   #define PCI_VENDOR_ID_CREATIVE		0x1102 /* duplicate: ECTIVA */

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
