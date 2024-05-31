Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8A3C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69A8881D3;
	Fri, 31 May 2024 15:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="I8TKcTQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4547488765; Fri, 31 May 2024 15:56:04 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4094188126
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VDu0l6116580;
 Fri, 31 May 2024 08:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717163760;
 bh=ri1WmplzhhrTOvF7T7etsZcte+dYIwQDIiKqLuXu34g=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=I8TKcTQa1keIxXluv9UZaQni+CPKVtOmop+H5qSYb5zmdqLP5+AN6ux9EXY8B/GgT
 8FWdhVdfmDSWQANo+OvDFqxXh7o+QSlHfH08B3Bpfyx8XWbAl24vmVKUqse2s81qQn
 eEgU6VYJVCnId9uRL6ZHv9YnXdFv70IFBayvppIM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VDu0qe080261
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 08:56:00 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 08:56:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 08:56:00 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VDttLa130421;
 Fri, 31 May 2024 08:55:56 -0500
Message-ID: <ace9596b-4fa6-4eb6-9ef8-35a545a2a022@ti.com>
Date: Fri, 31 May 2024 19:25:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200-r5: Add the pmic node in R5 dt
To: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <n-francis@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>
References: <20240531130823.646311-1-a-limaye@ti.com>
 <20240531130823.646311-2-a-limaye@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240531130823.646311-2-a-limaye@ti.com>
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
> Add bootph-pre-ram property to the buck node in the pmic needed for
> ESM error event handling.
>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index fb7e2e50239..78d07ff4e70 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -96,3 +96,12 @@
>   &mcu_udmap {
>       ti,sci = <&dm_tifs>;
>   };
> +
> +&tps659414 {
> +	regulators {
> +		bucka1: buck1 {
> +			bootph-pre-ram;
> +		};


why not to add this in kernel DT


> +	};
> +};
> +
