Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463DBC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C836881D3;
	Fri, 31 May 2024 15:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ojJk6SKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A248D88126; Fri, 31 May 2024 15:57:23 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A349588126
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VDvJOm117446;
 Fri, 31 May 2024 08:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717163839;
 bh=F+Kh6ibpDqp8Ui9JTmhwbY4g7+0567x05HDnPfnA6qo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ojJk6SKDlTAGOlaHZvBLTjd/Nxqbywc6nk248kjg+gWPrCLUV7O2HqlEn6gpCkuh9
 2YVp7WmUbrYK2FsDF02jP3Gr4uBCSiZnM8toQrYXeB5/D2lvOdHTnvGvVBuIRQv1zO
 rOyndRO2PWsE6CGcqQOuYF2o/8Uo7rF2bHtNAfMs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VDvJI1013275
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 08:57:19 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 08:57:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 08:57:19 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VDvG8f001678;
 Fri, 31 May 2024 08:57:17 -0500
Message-ID: <2a97cdc0-c9b5-4846-8d2f-a37049302085@ti.com>
Date: Fri, 31 May 2024 19:27:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm: dts: k3-j7200-r5: Fix indentation to use tabs
To: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <n-francis@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>
References: <20240531130823.646311-1-a-limaye@ti.com>
 <20240531130823.646311-3-a-limaye@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240531130823.646311-3-a-limaye@ti.com>
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


On 5/31/2024 6:38 PM, Aniket Limaye wrote:
> To avoid whitespace diff, use tabs throughout the file for indent
>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index 78d07ff4e70..c7086791ef8 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -85,16 +85,16 @@
>   };
>   
>   &ospi0 {
> -    reg = <0x0 0x47040000 0x0 0x100>,
> -          <0x0 0x50000000 0x0 0x8000000>;
> +	reg = <0x0 0x47040000 0x0 0x100>,
> +		  <0x0 0x50000000 0x0 0x8000000>;
>   };
>   
>   &mcu_ringacc {
> -    ti,sci = <&dm_tifs>;
> +	ti,sci = <&dm_tifs>;
>   };
>   
>   &mcu_udmap {
> -    ti,sci = <&dm_tifs>;
> +	ti,sci = <&dm_tifs>;
>   };


I think this is unrelated to this series ,

my suggestion will be post these changes in different patch


>   
>   &tps659414 {
