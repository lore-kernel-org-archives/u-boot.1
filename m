Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B145CC5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 04:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9AC28765C;
	Thu, 23 Nov 2023 05:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sQm+tiiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D9C87663; Thu, 23 Nov 2023 05:28:39 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BBCE86D94
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4SZ4Q078573;
 Wed, 22 Nov 2023 22:28:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700713715;
 bh=qm+d8ZBvVOOMK/qhkHwsHkdmSTJEq7ZxfdAIyI+31mc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sQm+tiiJteps+J0802/gNnkoa/MgfxkgwdY48p96TwHQqAK8u8oLh3yhE9362cxG5
 SfoOJn/MjzaAYVPLAjj1qz5SFi2LQz2dQ8x1pGwGs5FoZD+DDLZissDf2/mWxxAPHX
 fvYIK1BYl579+yBjGB8fjHvqzhJCcrePohoEKDJM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN4SZ0E094684
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 22:28:35 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 22:28:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 22:28:34 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4SWEl065029;
 Wed, 22 Nov 2023 22:28:33 -0600
Message-ID: <b9c9b4d7-6e36-461e-9ecb-fda0eb023a8a@ti.com>
Date: Thu, 23 Nov 2023 09:58:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] cmd: ufs: Correct the help text
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-5-bmeng@tinylab.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231011131552.14665-5-bmeng@tinylab.org>
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
> Remove the additional space and use "sub-system" for consistency
> with other commands like "scsi" and "usb".
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   cmd/ufs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/ufs.c b/cmd/ufs.c
> index 143e946370..2c8d88df18 100644
> --- a/cmd/ufs.c
> +++ b/cmd/ufs.c
> @@ -32,6 +32,6 @@ static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   }
>   
>   U_BOOT_CMD(ufs, 3, 1, do_ufs,
> -	   "UFS  sub system",
> +	   "UFS sub-system",
>   	   "init [dev] - init UFS subsystem\n"
>   );

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
