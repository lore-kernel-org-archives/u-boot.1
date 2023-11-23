Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CB5C61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 04:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D4587670;
	Thu, 23 Nov 2023 05:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RybK6/CX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8C687674; Thu, 23 Nov 2023 05:48:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D423C86DB1
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4mdqb081935;
 Wed, 22 Nov 2023 22:48:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700714919;
 bh=YMaL0xWTUacDbqv/Z2g6abQq0rWgNVLvcVhWQ5Z/eZc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RybK6/CXuGmrGfpHYOVjPyCelcInVM9BejcvJ6PMuwZaAdXG6lGuAEfMpvEI5w1ik
 FXLVPkoeqquzR1RtyZ8tynCz36CtV66A8TXKGj88JAfvbf9ez22hGTimHW7x8SHeZA
 yKWctjRtqiAGrk4ujqgTR2fJGkspsXOnvWJyGvfU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN4mdDx048798
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 22:48:39 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 22:48:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 22:48:39 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4m3Ye116955;
 Wed, 22 Nov 2023 22:48:38 -0600
Message-ID: <6d4ba590-d458-4257-bc53-1806a576b462@ti.com>
Date: Thu, 23 Nov 2023 10:18:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] ufs: Handle UFS 3.1 controllers
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-9-bmeng@tinylab.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231011131552.14665-9-bmeng@tinylab.org>
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
> Extend the version check to handle UFS 3.1 controllers as well.
> Tested on QEMU emulated UFS 3.1 controller.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   drivers/ufs/ufs.c | 3 ++-
>   drivers/ufs/ufs.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index fb2a607ef1..6287ce91a3 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1953,7 +1953,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   	    hba->version != UFSHCI_VERSION_11 &&
>   	    hba->version != UFSHCI_VERSION_20 &&
>   	    hba->version != UFSHCI_VERSION_21 &&
> -	    hba->version != UFSHCI_VERSION_30)
> +	    hba->version != UFSHCI_VERSION_30 &&
> +	    hba->version != UFSHCI_VERSION_31)
>   		dev_err(hba->dev, "invalid UFS version 0x%x\n",
>   			hba->version);
>   
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 9daaf03d22..816a5ce0ca 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -782,6 +782,7 @@ enum {
>   	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
>   	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
>   	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
> +	UFSHCI_VERSION_31 = 0x00000310, /* 3.1 */
>   };
>   
>   /* Interrupt disable masks */

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
