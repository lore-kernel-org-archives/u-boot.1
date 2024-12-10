Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A91E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 15:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BC0800C1;
	Tue, 10 Dec 2024 16:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="csl0HJLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CA9800C2; Tue, 10 Dec 2024 16:31:18 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFAC1800B5
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 16:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAFVCGW2689820
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 10 Dec 2024 09:31:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733844672;
 bh=pfFIFMJD6ec8B15awL3ZmyeqnnqxTVVnjQbuc6Z6dcQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=csl0HJLpvTiTsIeA6sS4sV2vQ3mart5L+iQhhbm1uvfKH260tRXn41/hU2cFqdWY+
 uGSIkWSM1m096TUOFD4kvxQjCebDWoCZn9Mte2PFyV96+wByqjgjd7TY/l6/ea0QeD
 K9XqOKUAxb5XYPdI7miBdzQ1U/VGr0kKO3mHfchk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAFVCV9112442;
 Tue, 10 Dec 2024 09:31:12 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 09:31:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 09:31:12 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAFV7wd043758;
 Tue, 10 Dec 2024 09:31:08 -0600
Message-ID: <c5514e5e-e86b-4360-8600-7e1dc94cd453@ti.com>
Date: Tue, 10 Dec 2024 21:01:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mailbox: k3-sec-proxy: Add DM to DMSC communication
 thread for J722S
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>, <u-kumar1@ti.com>
References: <20241210135731.1043269-1-p-mantena@ti.com>
 <20241210135731.1043269-2-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241210135731.1043269-2-p-mantena@ti.com>
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


On 12/10/2024 7:27 PM, Prasanth Babu Mantena wrote:
> From: Vaishnav Achath <vaishnav.a@ti.com>
>
> J722S R5 SPL uses sec-proxy threads 28 and 29 for communication with
> TIFS. Mark these as valid threads in the driver.

Please mention doc link also,

Also is this only for R5 SPL


> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   drivers/mailbox/k3-sec-proxy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
> index 5eafe46fd4d..6f5ad37919f 100644
> --- a/drivers/mailbox/k3-sec-proxy.c
> +++ b/drivers/mailbox/k3-sec-proxy.c
> @@ -408,7 +408,7 @@ static int k3_sec_proxy_remove(struct udevice *dev)
>   	return 0;
>   }
>   
> -static const u32 am6x_valid_threads[] = { 0, 1, 4, 5, 6, 7, 8, 9, 11, 12, 13, 20, 21, 22, 23 };
> +static const u32 am6x_valid_threads[] = { 0, 1, 4, 5, 6, 7, 8, 9, 11, 12, 13, 20, 21, 22, 23, 28, 29 };
>   
>   static const struct k3_sec_proxy_desc am654_desc = {
>   	.thread_count = 90,
