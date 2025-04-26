Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3B2C369C2
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 02:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B06482A31;
	Sat, 26 Apr 2025 04:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="huLYqFp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3113882A31; Sat, 26 Apr 2025 04:26:22 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA30828BC
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 04:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53Q2QFEc2325998
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 21:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745634375;
 bh=LRLDE8oeYuEQrbAMblon52AV3g+QV/0Qm6mPd+YN7HY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=huLYqFp5mqSYZjPimQpDNs51M/4ggqJ7msIYGETCKeR9qYM8l+gMh/ayhko3Uo2Lo
 PuihavN3R6lQ5cWAkOfL6/S4leX8SjNmJiD1d7HL4907p++hJxIwlcpqLbNdkOBb1G
 yrMkc4pTKfhrTkEONMeUK7RsBZ5QHMN/CmYUTu1s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53Q2QFY9012387
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 21:26:15 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 21:26:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 21:26:15 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53Q2QAip039827;
 Fri, 25 Apr 2025 21:26:11 -0500
Message-ID: <6e81e4f6-40fc-495a-9889-54b58a42b35c@ti.com>
Date: Sat, 26 Apr 2025 07:56:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] beagle: beagley-ai: env: Enable DFU env options
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>
References: <20250425173120.141503-1-nm@ti.com>
 <20250425173120.141503-6-nm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250425173120.141503-6-nm@ti.com>
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


On 4/25/2025 11:01 PM, Nishanth Menon wrote:
> Just enable dfu options, We have MMC and RAM as options here.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes Since v2:
> - Dropped the dfu_alt_info override option, let the users select it
> - Updated commit message to the effect.
>
> V2: https://lore.kernel.org/r/20250418193943.953952-6-nm@ti.com
>
>   board/beagle/beagley-ai/beagley-ai.env | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/board/beagle/beagley-ai/beagley-ai.env b/board/beagle/beagley-ai/beagley-ai.env
> index 16a03acfca3c..70afbf9763f9 100644
> --- a/board/beagle/beagley-ai/beagley-ai.env
> +++ b/board/beagle/beagley-ai/beagley-ai.env
> @@ -1,5 +1,6 @@
>   #include <env/ti/ti_common.env>
>   #include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   
>   #if CONFIG_CMD_REMOTEPROC
>   #include <env/ti/k3_rproc.env>
