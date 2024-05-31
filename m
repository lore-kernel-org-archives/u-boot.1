Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2969CC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B2B887C2;
	Fri, 31 May 2024 15:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JCDHfbfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C658887C8; Fri, 31 May 2024 15:58:35 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2642E88126
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VDwVrs124921;
 Fri, 31 May 2024 08:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717163911;
 bh=p6Mb8ANmFkY1TR34HJwHjMlUQA3anC9Wx5mb+X/OLdA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=JCDHfbfCPnXh+V0qkQE04BYQgCW7GNUzlbIUGyoBbf285UqttB3zvy+LyZtXVDDa7
 pBY8/RzdiA8R4tcxt7vGc5SLMlFs+jxfJxoRLeDHXWYwy+hAVrsmIPqjcfaYuCxxCm
 23A0d9ReGWuwUSNP6PsKKhssYOuylOGrmDq5yeX4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VDwV6U081824
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 08:58:31 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 08:58:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 08:58:30 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VDwSI6003339;
 Fri, 31 May 2024 08:58:28 -0500
Message-ID: <ca0de5cc-6f4d-400f-ac8e-74d2cbbbaba3@ti.com>
Date: Fri, 31 May 2024 19:28:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm: dts: k3-j7200-r5-common: Hook buckb1 to vtm
 supply
To: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <n-francis@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>, Gowtham Tammana
 <g-tammana@ti.com>
References: <20240531130823.646311-1-a-limaye@ti.com>
 <20240531130823.646311-4-a-limaye@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240531130823.646311-4-a-limaye@ti.com>
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
> From: Gowtham Tammana <g-tammana@ti.com>
>
> Hook buckb1 to vtm avs supply.
>
> Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index c7086791ef8..176cc0a0fbb 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -81,6 +81,7 @@
>   };
>   
>   &wkup_vtm0 {
> +	vdd-supply-2 = <&buckb1>;


Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   	bootph-pre-ram;
>   };
>   
