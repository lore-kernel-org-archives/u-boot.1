Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC51CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 17:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F0983D1A;
	Mon,  6 Oct 2025 19:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bj7FJFW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2053F83D52; Mon,  6 Oct 2025 19:25:09 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A85983CCA
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 19:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596HP3d54105651;
 Mon, 6 Oct 2025 12:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759771504;
 bh=2TZh8lYcsHxQlEF33TBbSfsY8n1w3z8VvDlFYci+HaI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Bj7FJFW2rTJZI8Ldy+aOuVo6fTqHaJWLb0KKd+niUGFGnypOjyVfUwZYWSFmxEb8p
 Ksx8ERnT2Rd+cxhCYSqmRaWjhUFd0ZzgnX6kZQPGmdS5IOzHqWbE0XI/pzwpNuX6JO
 DsHDd85fSZ4NfUq+p8ze0mkQI7y3CQQtu8Ef6p5I=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596HP3sK3465605
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 6 Oct 2025 12:25:03 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 12:25:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 12:25:02 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596HOxxf4027508;
 Mon, 6 Oct 2025 12:25:00 -0500
Message-ID: <27f03840-1849-49d5-8088-22377b61f54b@ti.com>
Date: Mon, 6 Oct 2025 22:54:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ti_sci: Pointer is never assigned to
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Dhruva
 Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, <u-kumar1@ti.com>
References: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
 <20251006-ti_sci-v1-3-9cef92e1022d@linaro.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251006-ti_sci-v1-3-9cef92e1022d@linaro.org>
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


On 10/6/2025 8:50 PM, Andrew Goodbody wrote:
> The pointer resp is declared but never assigned a value but is then
> dereferenced. Fix this by assigning the pointer to the message buffer.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/firmware/ti_sci.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index bd8a8f6c6b35e9038f5fb9927927d5b664ae5a3a..6def152f00a9442fcd0037c8f4032235d8c7fdab 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1365,6 +1365,8 @@ static int ti_sci_cmd_clk_get_parent(const struct ti_sci_handle *handle,
>   	if (ret)
>   		return ret;
>   
> +	resp = xfer->tx_message.buf;
> +

Thanks for catching this. buf is u32*, consider to do typecasting

resp = (struct ti_sci_msg_resp_get_clock_parent *) xfer->tx_message.buf;


>   	*parent_id = resp->parent_id;
>   
>   	return ret;
>
