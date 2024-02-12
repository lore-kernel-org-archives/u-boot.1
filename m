Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841D0C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 15:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8461879F2;
	Mon, 12 Feb 2024 16:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QTMCj5rm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8D287CB5; Mon, 12 Feb 2024 16:21:27 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A303879F2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 16:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CFLNBi031397;
 Mon, 12 Feb 2024 09:21:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707751283;
 bh=KWyF0xJ5I5EYkqx68+6dUNb1h4hhWt2ijvRnRzN+qk4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=QTMCj5rmEQNl+602F28LCvXY34vrtD81NrYFEU4ziKRB7rppHpkYw1wAw6WenW7SY
 ebrP3QVQm6jdjbJpLf+ocmZeoOAQrtFPulbSYJDDnC+F9pmegEDwKi6TeJQI8fZdYq
 /Ri9TkhkexyWvQhtpaIGqXlEZQhG9XMrWUC1YaLg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CFLMAK028565
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Feb 2024 09:21:22 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 09:21:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 09:21:22 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CFLM5b113014;
 Mon, 12 Feb 2024 09:21:22 -0600
Date: Mon, 12 Feb 2024 09:21:22 -0600
From: Bryan Brattlof <bb@ti.com>
To: Aradhya Bhatia <a-bhatia1@ti.com>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Nishanth Menon
 <nm@ti.com>, u-boot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH v2] arm: mach-k3: Refactor QoS settings
Message-ID: <20240212152122.4gsxji44wevoyeor@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240212100635.879272-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240212100635.879272-1-a-bhatia1@ti.com>
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

Hey Aradhya!

On February 12, 2024 thus sayeth Aradhya Bhatia:
> Refactor common QoS code into a new common header file, and the soc
> specific setup_qos functions into a common API.
> 
> Rename $(soc)_qos_count and $(soc)_qos_data variables to qos_count and
> qos_data. When QoS settings of more SoCs are added, only one pair will
> be defined at a time, based on the config SOC_K3_$(soc).
> 
> This refactoring has been done for 2 major purposes.
> 
> - The auto-generated $(soc)_qos_data.c and $(soc)_qos.h files cannot
>   have any code that is specific to any bootloader. Those files have to
>   remain agnostic of different bootloader implementations and their
>   header files.
> 
> - The existing implementation was less than ideal and would have enabled
>   multiple $(soc)_qos_count and $(soc)_qos_data variables for all SoC
>   variants.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
> 
> Change Log:
> 
>  - new in v2:
>    - Move K3_QOS config to the r5/Kconfig.
> 
> Previous versions:
> 
>   - v1: https://lore.kernel.org/all/20240206085610.3226136-1-a-bhatia1@ti.com/
> 

...

> diff --git a/arch/arm/mach-k3/r5/am62ax/Makefile 
> b/arch/arm/mach-k3/r5/am62ax/Makefile
> index 02a941805e9a..e4e55ce5c7dd 100644
> --- a/arch/arm/mach-k3/r5/am62ax/Makefile
> +++ b/arch/arm/mach-k3/r5/am62ax/Makefile
> @@ -4,4 +4,4 @@
>  
>  obj-y += clk-data.o
>  obj-y += dev-data.o
> -obj-y += am62a_qos_data.o
> +obj-y += am62a_qos_uboot.o

No objections from me though I am curious about the name change. Was 
there an issue with using the original am62a_qos_data.c

~Bryan
