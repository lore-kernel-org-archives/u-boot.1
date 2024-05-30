Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E967C25B75
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 02:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4B388683;
	Thu, 30 May 2024 04:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xwcLxe0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5BC88673; Thu, 30 May 2024 04:21:19 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A5C883F6
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 04:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U2LA7I047166;
 Wed, 29 May 2024 21:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717035670;
 bh=Et/G15ivx/sJ3ve3Aqj1ChJX52MR5hW1iip8hGVnjJk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xwcLxe0q1RkpZKBnjJdGac3xz+Hjw0uTVvbzBQZ9zsYWiiHWSurLXnLok00y0966j
 O2ASsk8MDse/J075GhBXVGpe80hvWIF+Ohafe3mvIpsAknsaTiFCWQ0LwnXwx5zlaj
 5E5o8GG+Xm43qlHZCYr9+JvSa0e5JWcbQVQi9Ynk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U2LAQY111223
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 21:21:10 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 21:21:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 21:21:10 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U2L5BE050094;
 Wed, 29 May 2024 21:21:06 -0500
Message-ID: <5a7a7614-66c8-45b4-971d-12debf09e49a@ti.com>
Date: Thu, 30 May 2024 07:51:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] soc: ti: k3-socinfo: Fix SOC JTAG entry order
To: Jayesh Choudhary <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>, <afd@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
References: <20240529132448.459330-1-j-choudhary@ti.com>
 <20240529132448.459330-3-j-choudhary@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240529132448.459330-3-j-choudhary@ti.com>
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

On 29/05/24 18:54, Jayesh Choudhary wrote:
> Add JTAG_ID_PARTNO_* in alphabetical order.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   drivers/soc/soc_ti_k3.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> index b585e47d46..0838808515 100644
> --- a/drivers/soc/soc_ti_k3.c
> +++ b/drivers/soc/soc_ti_k3.c
> @@ -23,33 +23,33 @@ static const char *get_family_string(u32 idreg)
>   	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
>   
>   	switch (soc) {
> +	case JTAG_ID_PARTNO_AM62X:
> +		family = "AM62X";
> +		break;
> +	case JTAG_ID_PARTNO_AM62AX:
> +		family = "AM62AX";
> +		break;
> +	case JTAG_ID_PARTNO_AM62PX:
> +		family = "AM62PX";
> +		break;
> +	case JTAG_ID_PARTNO_AM64X:
> +		family = "AM64X";
> +		break;
>   	case JTAG_ID_PARTNO_AM65X:
>   		family = "AM65X";
>   		break;
> -	case JTAG_ID_PARTNO_J721E:
> -		family = "J721E";
> -		break;
>   	case JTAG_ID_PARTNO_J7200:
>   		family = "J7200";
>   		break;
> -	case JTAG_ID_PARTNO_AM64X:
> -		family = "AM64X";
> +	case JTAG_ID_PARTNO_J721E:
> +		family = "J721E";
>   		break;
>   	case JTAG_ID_PARTNO_J721S2:
>   		family = "J721S2";
>   		break;
> -	case JTAG_ID_PARTNO_AM62X:
> -		family = "AM62X";
> -		break;
> -	case JTAG_ID_PARTNO_AM62AX:
> -		family = "AM62AX";
> -		break;
>   	case JTAG_ID_PARTNO_J784S4:
>   		family = "J784S4";
>   		break;
> -	case JTAG_ID_PARTNO_AM62PX:
> -		family = "AM62PX";
> -		break;
>   	default:
>   		family = "Unknown Silicon";
>   	};

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
