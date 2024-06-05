Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA20C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAEA688191;
	Wed,  5 Jun 2024 05:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LnwgiYno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B051A882DA; Wed,  5 Jun 2024 05:47:57 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F74F87C40
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4553lp48128793;
 Tue, 4 Jun 2024 22:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717559271;
 bh=4bEY6MKi6dNAdEIkKv2+3ibqRZC1ZIDAIgKS/xwP1jU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=LnwgiYnovPDd6eBbxsKG7pOmk80T+v3yey7e6IldMv1d9CvfsPaVp4gzEHc7RGs+7
 4GQhfJdaduDPcAD8odb5Iq6fkvwSOG8Hw5chCxeH+aEeoZKVDrnkV6KkMXAFlA1ihU
 39DnyhxSgcrG9TMes0/j9KaVDFzTFg1yDBjqkgW0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4553lpJB109282
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 22:47:51 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 22:47:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 22:47:50 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4553lnnE110697;
 Tue, 4 Jun 2024 22:47:49 -0500
Message-ID: <567f8d4e-982c-41ad-94bd-594baba7784c@ti.com>
Date: Wed, 5 Jun 2024 09:17:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: core: remove link_startup_again logic
To: Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240528-topic-sm8x50-ufs-core-link-startup-again-v1-1-146ca43e80b6@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240528-topic-sm8x50-ufs-core-link-startup-again-v1-1-146ca43e80b6@linaro.org>
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

Hi Neil,

On 28/05/24 14:06, Neil Armstrong wrote:
> The link_startup_again logic was added in Linux to handle device
> that were set in LinkDown state, which should not be the case since U-boot
> doesn't set LinkDown state are init, and Linux sets the device active

s/are/at ?

> in ufshcd_init() for the first link startup.
> 
> While it worked to far, it breaks link startup for Qualcomm Controllers v5,
> let's just remove the logic.
> 

I don't see any repercussions ATM, but will need to get a wider opinion with 
different controllers before acking.

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index be64bf971f1..28c244b70e5 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -456,9 +456,7 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>   {
>   	int ret;
>   	int retries = DME_LINKSTARTUP_RETRIES;
> -	bool link_startup_again = true;
>   
> -link_startup:
>   	do {
>   		ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
>   
> @@ -484,12 +482,6 @@ link_startup:
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
> ---
> base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf
> change-id: 20240528-topic-sm8x50-ufs-core-link-startup-again-bc2cf907c164
> 
> Best regards,

-- 
Thanking You
Neha Malcom Francis
