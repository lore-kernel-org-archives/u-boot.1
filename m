Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22469C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77D087D64;
	Wed,  6 Mar 2024 14:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wuVDLBvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E2E387E03; Wed,  6 Mar 2024 14:18:08 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D731B879E2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426DI27K113642
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 07:18:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709731082;
 bh=XCHXypcKsLz9zuwT4ZiXi8klVSUs56//WG7pqMXqdHs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wuVDLBvjqCPw3ENzGusDX+tO8/X72Iu9jbVva2dPCajBjsS6akzSckjijsPEd+RXh
 +ZHLixce15cvchMigCWTg9XPe3NYql/+UkfIrN0GQ2nu7Bg+5U95L4PK6QfNTL9rdR
 aTgawn8d68xS7E2I4k0WuRNN9uG6OJ8+Y/ZeU/vg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426DI2Ab007051
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 07:18:02 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 07:18:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 07:18:02 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426DHxFW006528;
 Wed, 6 Mar 2024 07:18:00 -0600
Message-ID: <29c3a2b5-22a9-435d-a6fc-52fb062a132c@ti.com>
Date: Wed, 6 Mar 2024 18:47:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: dts: k3-j7200-r5-common: fix the mcu_timer0
 clock frequency
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>
CC: <vaishnav.a@ti.com>, <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
 <u-kumar1@ti.com>
References: <20240306063749.1411176-1-a-limaye@ti.com>
 <20240306063749.1411176-4-a-limaye@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240306063749.1411176-4-a-limaye@ti.com>
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


On 3/6/2024 12:07 PM, Aniket Limaye wrote:
> Correcting the clock-frequency property of the mcu_timer0 node
>
> Fixes: df73e791ce09 ("arm: dts: j7200: dts sync with Linux 6.6-rc1")
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index 195637a836..c4ca09b1e0 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -52,7 +52,7 @@
>   };
>   
>   &mcu_timer0 {
> -	clock-frequency = <25000000>;
> +	clock-frequency = <250000000>;
>   	bootph-pre-ram;

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   };
>   
