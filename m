Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65D7EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 11:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA3C8904A;
	Tue, 10 Sep 2024 13:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mHKFmBtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3858904B; Tue, 10 Sep 2024 13:36:15 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2CA89049
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 13:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48ABa8tt105299;
 Tue, 10 Sep 2024 06:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725968168;
 bh=tSk0e20wUWdJNXGaSL563x1kpPwGLG23uegYl8qeslg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mHKFmBtk8Nrh8Oo4t6SbHDWWmoOZgvYPrZgCefPf1VNvLka57ENFT9On+lcNA2Ojo
 mptthnRTKqy4aYY859WseKTa3TQbKMwCwHUt3AOAwYNln47FCmwH4EHyELP8/28reA
 zIQp/gKFAbOfloVVMyRk9SGD0CsePNS4UKsETFxU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48ABa8hS011111
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Sep 2024 06:36:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 06:36:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 06:36:08 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48ABa63k071003;
 Tue, 10 Sep 2024 06:36:07 -0500
Message-ID: <2f7f1274-bcc6-4f05-86b3-4be74f48cd73@ti.com>
Date: Tue, 10 Sep 2024 17:06:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] ufs: core: remove link_startup_again logic
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <20240910-topic-ufs-enhancements-v1-12-3ee0bffacc64@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-12-3ee0bffacc64@linaro.org>
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

Hi Neil

On 10/09/24 14:50, Neil Armstrong wrote:
> The link_startup_again logic was added in Linux to handle device
> that were set in LinkDown state, which should not be the case since U-boot
> doesn't set LinkDown state are init, and Linux sets the device active
> in ufshcd_init() for the first link startup.
> 
> While it worked to far, it breaks link startup for Qualcomm Controllers v5,
> let's just remove the logic.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I had sent a review comment here 
https://patchwork.ozlabs.org/project/uboot/patch/20240528-topic-sm8x50-ufs-core-link-startup-again-v1-1-146ca43e80b6@linaro.org/

Would like Bhupesh to also have a look at this.

> ---
>   drivers/ufs/ufs.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index d2df5c26f76..e34e4586224 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -462,9 +462,7 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>   {
>   	int ret;
>   	int retries = DME_LINKSTARTUP_RETRIES;
> -	bool link_startup_again = true;
>   
> -link_startup:
>   	do {
>   		ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
>   
> @@ -490,12 +488,6 @@ link_startup:
>   		/* failed to get the link up... retire */
>   		goto out;
>   
> -	if (link_startup_again) {
> -		link_startup_again = false;
> -		retries = DME_LINKSTARTUP_RETRIES;
> -		goto link_startup;
> -	}
> -
>   	/* Mark that link is up in PWM-G1, 1-lane, SLOW-AUTO mode */
>   	ufshcd_init_pwr_info(hba);
>   
> 

-- 
Thanking You
Neha Malcom Francis
