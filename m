Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BA1C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 02:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 380DE86409;
	Mon, 28 Aug 2023 04:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dOcnklbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B51863FF; Mon, 28 Aug 2023 04:05:37 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A62846D2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 04:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37S25VTh096817;
 Sun, 27 Aug 2023 21:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693188331;
 bh=eWWL07HwX7jfthRpp0WbeDHPCFAKaQpJTIl08vJBmY8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dOcnklbSy1dLBW4qK3FjrIU/Qt5Q7lWZKMDvUZZ4AIfjhLbRVpHoO+u+O4I1JsSeB
 ibrpjwaEMrjYx7KvCcDf/75wk9Mx/uCA7SOA4wT5reereHqFF0LuPAIt6to8W8wSfT
 HJD/9mgxOtZaEbU0dFoK2HukGKQjDrEyyGHAXXj8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37S25VSO011466
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Aug 2023 21:05:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Aug 2023 21:05:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Aug 2023 21:05:30 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37S25R3M016295;
 Sun, 27 Aug 2023 21:05:28 -0500
Message-ID: <b6efc57c-627f-9b17-2740-390ee0b3bfde@ti.com>
Date: Mon, 28 Aug 2023 07:35:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/6] arm: mach-k3: j721s2: Add mcu_timer0 id to the dev
 list
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Reid Tonking <reidt@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-2-a5f141be40bc@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-2-a5f141be40bc@ti.com>
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

Hi Manorit

On 25/08/23 16:47, Manorit Chawdhry wrote:
> mcu_timer0 is used by u-boot as the tick-timer. Add it to the soc
> devices lsit so it an be enabled via the k3 power controller.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/mach-k3/j721s2/dev-data.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-k3/j721s2/dev-data.c b/arch/arm/mach-k3/j721s2/dev-data.c
> index 8c999a3c5a8b..df70c5e5d7c0 100644
> --- a/arch/arm/mach-k3/j721s2/dev-data.c
> +++ b/arch/arm/mach-k3/j721s2/dev-data.c
> @@ -47,6 +47,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
>   };
>   
>   static struct ti_dev soc_dev_list[] = {
> +	PSC_DEV(35, &soc_lpsc_list[0]),
>   	PSC_DEV(108, &soc_lpsc_list[0]),
>   	PSC_DEV(109, &soc_lpsc_list[0]),
>   	PSC_DEV(110, &soc_lpsc_list[0]),
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
