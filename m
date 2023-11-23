Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605EBC61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 04:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CB3875CA;
	Thu, 23 Nov 2023 05:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tRMMH0D8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CAE3875F5; Thu, 23 Nov 2023 05:26:02 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947A786D94
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4PvWd024152;
 Wed, 22 Nov 2023 22:25:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700713557;
 bh=vXsX529Dd4YNm4gG/Sb94eyT0ZXRgrwzRYKdEHJzkUY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tRMMH0D8fiBMGjU5zrMbipzNhYRd05eBP/00VyzJkZgwGFHC55Nagmxbjz10GZdFN
 vmC4ouWp0DdhHTfRb0gwK5etybmgnVc6FQEQAMam7wP520Ds2IJGzn24zd41zQ81EI
 I2BhK7KRmFcw6Yozi37SNzWQx4EA/l4bCFT08B1M=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN4Pv7Z093421
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 22:25:57 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 22:25:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 22:25:56 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4OdrB070851;
 Wed, 22 Nov 2023 22:25:55 -0600
Message-ID: <e0753506-3373-40d4-bae2-d2abdcb30020@ti.com>
Date: Thu, 23 Nov 2023 09:55:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] cmd: kconfig: Make ufs prompt look similar to
 other commands
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-4-bmeng@tinylab.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231011131552.14665-4-bmeng@tinylab.org>
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
> At present the 'ufs' command prompt does not look similar like other
> commands. Update it.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   cmd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a59c67e333..0b4e76c262 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1536,7 +1536,7 @@ config CMD_TSI148
>   	  Turndra tsi148 device. See the command help for full details.
>   
>   config CMD_UFS
> -	bool "Enable UFS - Universal Flash Storage commands"
> +	bool "ufs - Universal Flash Storage commands"
>   	depends on UFS
>   	help
>   	  "This provides commands to initialise and configure universal flash

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
