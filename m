Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9026C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 17:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2316D86F1E;
	Wed,  3 Jan 2024 18:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TBkMO+R4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5243187727; Wed,  3 Jan 2024 18:07:33 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC2481EC8
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 18:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403H7Fs5050307;
 Wed, 3 Jan 2024 11:07:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704301635;
 bh=Uevjs9gCxJ3W9egL0UtYVQmjvCKpLs0YObjg5VtzXmc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TBkMO+R4f2hIvkBu6StJhP6I8JDeoWPmdjeRj4UxZz9rJqj9zHj/sg2NwADgzEzbV
 rrm3jQUxVlNlTFic7qCDT1xDSG5JuMJtL3TJx+EFBo+E3++ZKFQavGNOWg7FrnV4Yx
 J89tV7NHqLoep7WK28HlEJJfbH3o8QPqfu/q0Yew=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403H7FYl012303
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 11:07:15 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 11:07:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 11:07:14 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403H7EiH070611;
 Wed, 3 Jan 2024 11:07:14 -0600
Date: Wed, 3 Jan 2024 11:07:14 -0600
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v7 05/17] soc: ti: k3-socinfo: Add entry for J784S4 SoC
Message-ID: <20240103170714.zouma5aydz4bdrtd@arrest>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-6-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-6-a-nandan@ti.com>
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

On 00:45-20231220, Apurva Nandan wrote:
> Add support for J784S4 SoC Identification.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/mach-k3/include/mach/hardware.h | 1 +
>  drivers/soc/soc_ti_k3.c                  | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index 7e143c6bdc..74692b745a 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -50,6 +50,7 @@
>  #define JTAG_ID_PARTNO_J7200	0xbb6d
>  #define JTAG_ID_PARTNO_J721E	0xbb64
>  #define JTAG_ID_PARTNO_J721S2	0xbb75
> +#define JTAG_ID_PARTNO_J784S4	0xbb80
>  
>  #define K3_SOC_ID(id, ID) \
>  static inline bool soc_is_##id(void) \
> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> index 355a5368dd..d176980915 100644
> --- a/drivers/soc/soc_ti_k3.c
> +++ b/drivers/soc/soc_ti_k3.c
> @@ -45,6 +45,9 @@ static const char *get_family_string(u32 idreg)
>  	case JTAG_ID_PARTNO_AM62AX:
>  		family = "AM62AX";
>  		break;
> +	case JTAG_ID_PARTNO_J784S4:
> +		family = "J784S4";
> +		break;
>  	default:
>  		family = "Unknown Silicon";
>  	};

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
