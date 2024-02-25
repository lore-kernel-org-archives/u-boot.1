Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B571AC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 04:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88E487D7C;
	Sun, 25 Feb 2024 05:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m1QP8Hnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B3287D7C; Sun, 25 Feb 2024 05:47:15 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B2D87D73
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 05:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41P4l9CH051414;
 Sat, 24 Feb 2024 22:47:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708836429;
 bh=Jkco9/kkSmY0cmsqihlC8nVKvTK2lQw/7WC1cOc+FdA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=m1QP8HnzLd+KgnQMXw58ekqFgvGuimx9jcE79BaFJ5yqQFFwiEBjir25AWSrvjmF7
 Vg7CMUoTqtf+LeZ77VR8X6JhNc4bqfLMXx0m5kAoOnL15thH/Q+JH6Nh8usxBtVAmA
 5iU1cyqrOkifLagC8wW06ytYdqgftIL9jzKAAAWY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41P4l9X4013074
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 24 Feb 2024 22:47:09 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Feb 2024 22:47:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Feb 2024 22:47:09 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41P4l72F004013;
 Sat, 24 Feb 2024 22:47:07 -0600
Message-ID: <90c45918-e0eb-4d09-9e0f-06aea0d4ccb5@ti.com>
Date: Sun, 25 Feb 2024 10:17:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm: dts: k3-j721e-sk: Remove OSPI phypattern
 partition
To: Jonathan Humphreys <j-humphreys@ti.com>, <trini@konsulko.com>,
 <vaishnav.a@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>
References: <20240224002307.2284386-1-j-humphreys@ti.com>
 <20240224002307.2284386-4-j-humphreys@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240224002307.2284386-4-j-humphreys@ti.com>
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

Thanks Jon

On 2/24/2024 5:53 AM, Jonathan Humphreys wrote:
> The phy calibration pattern partition isn't needed as the Cadence driver isn't
> calibrating the phys.


Please do mention Fixes tag here

58d61fb5a77e ("arm: dts: k3-j721e-sk: Add initial A72 specific dts support")


> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   arch/arm/dts/k3-j721e-sk-u-boot.dtsi | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> index 479b7bcd6f..20b76a84ff 100644
> --- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> @@ -157,9 +157,5 @@
>   
>   	flash@0 {
>   		bootph-all;
> -
> -		partition@3fc0000 {
> -			bootph-all;
> -		};
>   	};


This Patch LTGM,


+ Neha

For further cleanup, we should not have these ospi nodes in u-boot dts file.

should be in board dts (k3-j721e-sk.dts) with right bootph properties ,

and comes via kernel DT.



>   };
