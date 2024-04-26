Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65B6C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 17:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C23688322;
	Fri, 26 Apr 2024 19:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714152322;
	bh=bkJCQtCIXTBFTl2Ukkyb2AkifCZpwU7YnuqThk5FYKM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+I1zE0o55BR5U1gHeZ1tbgr7FA0b6hM2icM5bf9JPAgBCx+ZqbkIUtU/fCb1pIjb
	 BJXB19ZVjab/KdBIIlN/ZKal/7DOxscDesCPLCaHnG3eOOwlwSlSzgPTzTf8MqEVzj
	 D4m8b88ZNVMBmkYZZxlRLehwJrZwgDYuw9ezNADX+yjN1hJ8hG+IK8zeKRTu/Kw/69
	 lPfwOw/fuYaOdZlVVPH3pt6EUm0/sk6Z4hMFfyZoWEFSVMLjepgFE2w2eSuCZE2K6F
	 Ua/PzXYKRTvhfcy7dLPg2XAXEVsueWOGoIfFEST5hDhQ7hSujc/S5cnLtPx3p9hzzg
	 oEmu7Fk4dlNng==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E5D1A8826E;
 Fri, 26 Apr 2024 19:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714152320;
 bh=bkJCQtCIXTBFTl2Ukkyb2AkifCZpwU7YnuqThk5FYKM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=iRHINzpvsvdLpCVkCO5U3YqQbnfxCzTYafrzuyy74J4L5s8D9k7cDew9GnrCcjalr
 WoIQFiyXF4fblH5FppSPqcIR38WUvpabhE3DTRlCf8vgmwQemEd3sT8aaCcZB/kYI0
 3vFgjMGsNs6pf799mrnCA8y/l2Ka7qPQi2jeinjhMn2VywHwNYfWts/MdyYe6GM1Z2
 ymd1pX19HoFRpJrMj6dvFkFU+iAplRrHtYnrfPLSw59NzLoVB7u+KuGvQEWFoEMMFj
 0DquiawsceoxlCFwOlkxkkcZwEuqzFhqHpIzySKXFGvOPs8xP5RBlCk5A0xUKK6Wxw
 Q2X3aB8tVJYyw==
Message-ID: <9f5dc653-8252-4da7-81bc-a76280cf4c68@denx.de>
Date: Fri, 26 Apr 2024 19:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: mmc: allow use of hardware partition names for
 mmc partconf
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
References: <20240426171205.1382212-1-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426171205.1382212-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/26/24 7:12 PM, Tim Harvey wrote:
> eMMC devices have hardware partitions such as user, boot0, and boot1.
> Allow these names to be displayed when reading the mmc PARTITION_CONFIG
> field via 'mmc partconf'. Additionally allow a name to be specified when
> setting the PARTITION_CONFIG.
> 
> Before:
> u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x2
> PARTITION_ACCESS: 0x0
> 
> After:
> u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x1 (boot0)
> PARTITION_ACCESS: 0x0
> u-boot=> mmc partconf 2 1 boot1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x2 (boot1)
> PARTITION_ACCESS: 0x0
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2:
>   - fix typo in subject
>   - add names for gp1..gp4
> ---
>   cmd/mmc.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 2d5430a53079..af9a66cc6df4 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -14,6 +14,18 @@
>   #include <part.h>
>   #include <sparse_format.h>
>   #include <image-sparse.h>
> +#include <linux/ctype.h>
> +
> +static const char *mmc_partnames[] = {
> +	"user",
> +	"boot0",
> +	"boot1",
> +	"gp1",
> +	"gp2",
> +	"gp3",
> +	"gp4",

Uh, maybe gp%d are indexed from zero too ?

(sorry for the confusion)
