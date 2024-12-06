Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801E6E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 07:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79C28918C;
	Fri,  6 Dec 2024 08:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MJvdufFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D3DC8918C; Fri,  6 Dec 2024 08:52:12 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36CF89512
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 08:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B67q5Tr2327512
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 01:52:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733471525;
 bh=4Q4oWu54M2lnHSYD/su7e28EBaYjxRukd/y3mo0wmME=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=MJvdufFLzHO2sULNUkw1vqAmFXcJkjy0axxoByVZIo65Aj6mFtTaRPfQ7r1c89LUr
 bT0JaccW6CNanU1cWOdoLGBt+q+cZrbZL+MqsK+AbW4pugGlWtyHCkKk8m5nIuyk8B
 1xXNTAxRoDp7BYWQWs4nANgAwiFnhubEshxSkpaE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B67q5qw100189
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Dec 2024 01:52:05 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 01:52:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 01:52:05 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B67q2da118279;
 Fri, 6 Dec 2024 01:52:03 -0600
Message-ID: <428ccfd0-c16a-457c-a822-249899193107@ti.com>
Date: Fri, 6 Dec 2024 13:22:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ufs: core: include missing include/ufs.h
To: Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <bmeng.cn@gmail.com>, <venkatesh.abbarapu@amd.com>, <u-boot@lists.denx.de>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <20241120-topic-ufs-cleanup-v1-1-a5cef54b1cdc@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-1-a5cef54b1cdc@linaro.org>
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

On 20/11/24 14:52, Neil Armstrong wrote:
> Add missing ufs.h causing build warning on some symbols.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index f7d8c40c448c6865b7c04e03bab6f3f93a44a591..31c2959aeb12931b2bbdf26b3c676ae1a7b0fd1a 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -19,6 +19,7 @@
>   #include <malloc.h>
>   #include <hexdump.h>
>   #include <scsi.h>
> +#include <ufs.h>
>   #include <asm/io.h>
>   #include <asm/dma-mapping.h>
>   #include <linux/bitops.h>
> 

Reviewed-by: Neha Malcom Francis

-- 
Thanking You
Neha Malcom Francis
