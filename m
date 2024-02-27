Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5563C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 04:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D24C587DFC;
	Tue, 27 Feb 2024 05:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZVW9MuqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBCB487DFC; Tue, 27 Feb 2024 05:18:34 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF88587F69
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 05:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41R4IOuu049839;
 Mon, 26 Feb 2024 22:18:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709007504;
 bh=8Zjqc+Bfh6mpztx3m0MVgOI+eFWxtISMT4pf5MNLeHo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZVW9MuqIXRzH/xKo09NEQe7G1xs0VTLnzjkoYFkTmUNG03XN4n97yrerGr/occX0m
 kmSfRVxyHseRti7b9Y473l8PWjNdWSXmrfkROUbZogTahwDu6w8YcJGvMqk9gjNC7D
 h8YxDzQWnur1+JAKR/DqAWzDGUfRtWwBg20f9NKw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41R4IOiN080593
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Feb 2024 22:18:24 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 22:18:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 22:18:23 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41R4IIH5070324;
 Mon, 26 Feb 2024 22:18:19 -0600
Message-ID: <ca1d8408-8abf-439a-881b-7771e1f1a167@ti.com>
Date: Tue, 27 Feb 2024 09:48:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] soc: add info to identify the am62p SoC family
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Andrew Davis <afd@ti.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, Hari Nagalla <hnagalla@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
 <20240205-am62px-wip-rebasing-v3-1-04cbb42eaa6f@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v3-1-04cbb42eaa6f@ti.com>
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

Hi Bryan,

On 27/02/24 02:49, Bryan Brattlof wrote:
> Include the part number for TI's am62px family of SoCs so we can
> properly identify it during boot
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   arch/arm/mach-k3/include/mach/hardware.h | 2 ++
>   drivers/soc/soc_ti_k3.c                  | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index a1a9dfbde66c8..040288150b12f 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -46,6 +46,7 @@
>   #define JTAG_ID_PARTNO_J721S2	0xbb75
>   #define JTAG_ID_PARTNO_AM62X	0xbb7e
>   #define JTAG_ID_PARTNO_AM62AX   0xbb8d
> +#define JTAG_ID_PARTNO_AM62PX	0xbb9d
>   
>   #define K3_SOC_ID(id, ID) \
>   static inline bool soc_is_##id(void) \
> @@ -61,6 +62,7 @@ K3_SOC_ID(am64x, AM64X)
>   K3_SOC_ID(j721s2, J721S2)
>   K3_SOC_ID(am62x, AM62X)
>   K3_SOC_ID(am62ax, AM62AX)
> +K3_SOC_ID(am62px, AM62PX)
>   
>   #define K3_SEC_MGR_SYS_STATUS		0x44234100
>   #define SYS_STATUS_DEV_TYPE_SHIFT	0
> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> index 355a5368dd45a..d7d0152b115fa 100644
> --- a/drivers/soc/soc_ti_k3.c
> +++ b/drivers/soc/soc_ti_k3.c
> @@ -45,6 +45,9 @@ static const char *get_family_string(u32 idreg)
>   	case JTAG_ID_PARTNO_AM62AX:
>   		family = "AM62AX";
>   		break;
> +	case JTAG_ID_PARTNO_AM62PX:
> +		family = "AM62PX";
> +		break;
>   	default:
>   		family = "Unknown Silicon";
>   	};
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
