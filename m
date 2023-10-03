Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA90E7AD58
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 14:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2FB87227;
	Tue,  3 Oct 2023 16:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aD2cwiX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A05487468; Tue,  3 Oct 2023 16:27:13 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A9587224
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 16:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393ER7MN112771;
 Tue, 3 Oct 2023 09:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696343227;
 bh=uGKPed+KpYx6GzgVd9rZOHEj1JuM3f7WC1FiPDKS5lA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=aD2cwiX/to+scIgYlIg/+7p/NgHMDQyjWpCJGANuVUOfFzi3tXex8HnR6+MMQaBqt
 YonqrumBmYnZk55/SjgNbQncASG5Ol2FiYT/FvF2l0RjtetICP+YmF8l1JMz5YEW5C
 w+m6J1VB7rOimCNa7Gaqd+e/al7cQX4KnKuRvSEE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393ER7Ft127645
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 09:27:07 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 09:27:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 09:27:06 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393ER4Mx088450;
 Tue, 3 Oct 2023 09:27:05 -0500
Message-ID: <838b07a0-8490-c05b-b08f-3ab6d3e1737a@ti.com>
Date: Tue, 3 Oct 2023 19:57:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 10/10] board: ti: j721e: Enable ESM initialization for
 J7200
To: Keerthy <j-keerthy@ti.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <trini@konsulko.com>, <vigneshr@ti.com>
References: <20231003081038.24299-1-j-keerthy@ti.com>
 <20231003081038.24299-11-j-keerthy@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231003081038.24299-11-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 10/3/2023 1:40 PM, Keerthy wrote:
> Enable ESM initialization for J7200
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   board/ti/j721e/evm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 42fa94b7a5..070b28326f 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -543,7 +543,8 @@ void spl_board_init(void)
>   	}
>   
>   #ifdef CONFIG_ESM_K3
> -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
> +	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
> +	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {


Could we align on one kind of check,  For J721E check is done against 
board-id, whereas for J7200 checking

for config option.

>   		ret = uclass_get_device_by_driver(UCLASS_MISC,
>   						  DM_DRIVER_GET(k3_esm), &dev);
>   		if (ret)
> @@ -557,7 +558,8 @@ void spl_board_init(void)
>   #endif
>   
>   #ifdef CONFIG_ESM_PMIC
> -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
> +	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
> +	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {
>   		ret = uclass_get_device_by_driver(UCLASS_MISC,
>   						  DM_DRIVER_GET(pmic_esm),
>   						  &dev);
