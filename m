Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE8ACCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 14:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 314B18006D;
	Thu, 23 Oct 2025 16:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IxhXHVDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B31480422; Thu, 23 Oct 2025 16:22:38 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E098003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 16:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NEMT1k1697840;
 Thu, 23 Oct 2025 09:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761229349;
 bh=tjv4ShLHchPVeKaQY+Tp2YT/H+jNGze+HY3mHuG9oHc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IxhXHVDxP3thfjozpaILm/eRVzyby3tPpavxEHus4X3TXEOXorM53Fjfq5YRXmdJ6
 hzDxBQKP6n+/CG6N82fT4SoD4lMYjBuMHU23OPprrMe9WA2FeN+0pB+8/ThSJogXbh
 Shh6tPxmdBQuCsbtnkNvamWLjmFO49p7qdYxYsis=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NEMTYw2871770
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Oct 2025 09:22:29 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 09:22:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 09:22:28 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NEMS9e2980013;
 Thu, 23 Oct 2025 09:22:28 -0500
Message-ID: <826bae86-9a2a-432b-a8d5-0ef9026f4b51@ti.com>
Date: Thu, 23 Oct 2025 09:22:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] remoteproc: k3-r5: cast size to size_t
To: Philippe Schenker <dev@pschenker.ch>, <u-boot@lists.denx.de>
CC: <stefan@embear.ch>, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Beleswar Padhi
 <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>, Hari Nagalla
 <hnagalla@ti.com>, Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
References: <20251023094631.16742-1-dev@pschenker.ch>
 <20251023094631.16742-3-dev@pschenker.ch>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251023094631.16742-3-dev@pschenker.ch>
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

On 10/23/25 4:46 AM, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> When compiling for R5 core with CONFIG_REMOTEPROC_TI_K3_R5F,
> passing 'size' (ulong) to ti_secure_image_post_process() caused
> a type mismatch compiler error.
> 

size_t and ulong should both be 32bit on any reasonable 32bit machine,
odd the compiler would complain here.

Casting pointers always worries me anyway, if the var being cast is
smaller then you will read out of bounds, if the var is larger than
what it is cast to then you run into endianness issues. Always safer
to dereference into a temp variable of the correct type and pass a
pointer to that.

For this, probably fine either way,

Acked-by: Andrew Davis <afd@ti.com>

> Cast 'size' to (size_t *) to fix it.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> ---
> 
>   drivers/remoteproc/ti_k3_r5f_rproc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
> index 48401bc6eb67..9d591aada276 100644
> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
> @@ -341,7 +341,7 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
>   
>   	k3_r5f_init_tcm_memories(core, mem_auto_init);
>   
> -	ti_secure_image_post_process(&image_addr, &size);
> +	ti_secure_image_post_process(&image_addr, (size_t *)&size);
>   
>   	ret = rproc_elf_load_image(dev, addr, size);
>   	if (ret < 0) {

