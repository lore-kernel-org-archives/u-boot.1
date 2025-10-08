Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F6CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 08:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BD283957;
	Wed,  8 Oct 2025 10:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gKOIy9X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A316839B5; Wed,  8 Oct 2025 10:12:08 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA0783956
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 10:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5988C2og4000475;
 Wed, 8 Oct 2025 03:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759911122;
 bh=wds4wMM1le2C4nyHPcH2p2jp7xM4j/Yl2g9+i4E8TpU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=gKOIy9X4dCts+esGFQc6WQMSsk/qpTzLaDOMOLX2TzmL0wkCMrq0WBAVPyhr178Gt
 Y4joPGFHZHoYj3S7xKgF6JC41sssm2iC9DXrXm/hM3G80yrnF+2JQSqdd8ZnUTD51q
 X5MSj74xbiaNSqaFyQQSvqfh1F8fKUBYJn8K3I0Y=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5988C2M71309595
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 03:12:02 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 03:12:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 03:12:02 -0500
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5988Bxfc2234840;
 Wed, 8 Oct 2025 03:11:59 -0500
Message-ID: <ff186e1d-ec4f-4d10-b6d5-912aade0adc9@ti.com>
Date: Wed, 8 Oct 2025 13:41:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ti_sci: Provide error code on error exit
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Dhruva
 Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
References: <20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org>
 <20251007-ti_sci-v2-2-7561d7ea07b2@linaro.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251007-ti_sci-v2-2-7561d7ea07b2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 10/7/2025 5:34 PM, Andrew Goodbody wrote:
> In ti_sci_get_response the check for message sequence will return ret
> on a fail but ret will be 0 at that point. Instead return -EINVAL.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/firmware/ti_sci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 2042d88583766213e9d74dd17289cfd3562f0acb..afe1ae13834d236015a3d5e4d8d4f9955ba8c822 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -193,7 +193,7 @@ static int ti_sci_get_response(struct ti_sci_info *info,
>   	if (hdr->seq != info->seq) {
>   		dev_dbg(info->dev, "%s: Message for %d is not expected\n",
>   			__func__, hdr->seq);
> -		return ret;
> +		return -EINVAL;

While you are at this,  Please change dev_dbg to dev_err,

with this change, Please use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   	}
>   
>   	if (msg->len > info->desc->max_msg_size) {
>
