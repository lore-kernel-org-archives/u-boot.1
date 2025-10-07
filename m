Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261B0CCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 14:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6714E83F6D;
	Tue,  7 Oct 2025 16:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="psrWzCGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B9283FBF; Tue,  7 Oct 2025 16:14:42 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A13883D9F
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 16:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 597EEcFm3838456;
 Tue, 7 Oct 2025 09:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759846478;
 bh=SEHVoLuxb/xQO8s/koHpQsrySKNoquolcGDWbrebpRY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=psrWzCGoVi2zJc4IpEgSTSfMWBv3gCF93KcBtlPIc9SXrrb5Bpvw+U0NuC/6PsQEO
 XI0Y5G2gM5TOJ117h2JEnXo5PZwp3kkPoY1bsBG/P7QVq2mX7XbKc/OEC75707kEAu
 N4diEpnNpWMNV7IuPw31zYuO3qVxNtJrLvWuMwL0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 597EEc3Y3029418
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 7 Oct 2025 09:14:38 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 09:14:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 09:14:37 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 597EEYku1231178;
 Tue, 7 Oct 2025 09:14:35 -0500
Message-ID: <9b824819-bce3-449a-8aef-8ef050dee267@ti.com>
Date: Tue, 7 Oct 2025 19:44:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ti_sci: Pointer is never assigned to
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Dhruva
 Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
References: <20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org>
 <20251007-ti_sci-v2-3-7561d7ea07b2@linaro.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251007-ti_sci-v2-3-7561d7ea07b2@linaro.org>
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

Hello Andrew,

On 10/7/2025 5:34 PM, Andrew Goodbody wrote:
> The pointer resp is declared but never assigned a value but is then
> dereferenced. Fix this by assigning the pointer to the message buffer.

Tom, may comment, if need Fixes tag for this

> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/firmware/ti_sci.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index afe1ae13834d236015a3d5e4d8d4f9955ba8c822..91edbc7898132bc10fcf4bd6a71c1e7aebd5147d 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1365,6 +1365,8 @@ static int ti_sci_cmd_clk_get_parent(const struct ti_sci_handle *handle,
>   	if (ret)
>   		return ret;
>   
> +	resp = (struct ti_sci_msg_resp_get_clock_parent *)xfer->tx_message.buf;
> +

Sorry but subject (ti_sci: Pointer is never assigned to) does not 
complete story,

Please update subject to (ti_sci: Pointer is never assigned to valid value)

with subject change , Please use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   	*parent_id = resp->parent_id;
>   
>   	return ret;
>
