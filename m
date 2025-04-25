Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F18C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 06:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58F7809D4;
	Fri, 25 Apr 2025 08:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="leXMFk3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38448810EB; Fri, 25 Apr 2025 08:49:34 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A038059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 08:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53P6nTYj2859498
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 01:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745563769;
 bh=1ZC6oaQTDhbY4HkC2Dtatwyjpc6joqZWsI5lfU+hchg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=leXMFk3Su3IiE8nrIrq4tpYDnLSNr0j/2UOes9elIHuCtpw0EHGz7XKuleenWMBQ1
 09Mc2fT//reyBwAVNn/C6TeVMVC/q5KyEnqapvu0dWzZm9vlSRNk81t+xQrK6tIQIH
 +KCG9Bw3kRb5iOFa9rbPXdO5d9OQ6QZMBO9Yfoz0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53P6nTn7065983
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 01:49:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 01:49:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 01:49:29 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53P6nRU1021798;
 Fri, 25 Apr 2025 01:49:27 -0500
Message-ID: <01ad9412-f1de-4628-aa1d-9fe391872fa5@ti.com>
Date: Fri, 25 Apr 2025 12:19:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include: env: ti: mmc.h: Find DTB files in dtb
 directory for AM57xx
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>
References: <20250425053431.1622267-1-a-dutta@ti.com>
 <20250425053431.1622267-2-a-dutta@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250425053431.1622267-2-a-dutta@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Anurag

On 25/04/25 11:04, Anurag Dutta wrote:
> Add dtb/ to the DTB search path.
> 
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>  include/env/ti/mmc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/env/ti/mmc.h b/include/env/ti/mmc.h
> index dbb0e3559ea..968d6ec03dc 100644
> --- a/include/env/ti/mmc.h
> +++ b/include/env/ti/mmc.h
> @@ -24,7 +24,7 @@
>  		"env import -t ${loadaddr} ${filesize}\0" \
>  	"loadbootenv=fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}\0" \
>  	"loadimage=load ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${bootfile}\0" \
> -	"loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/${fdtfile}\0" \
> +	"loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}\0" \
>  	"envboot=mmc dev ${mmcdev}; " \
>  		"if mmc rescan; then " \
>  			"echo SD/MMC found on device ${mmcdev};" \

Are there any other boards that use .h instead of .env other than AM57x?
Would they break with this change?

-- 
Thanking You
Neha Malcom Francis
