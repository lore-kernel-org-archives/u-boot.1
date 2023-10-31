Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D8BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECE287CCC;
	Tue, 31 Oct 2023 14:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VPD7tRth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 909D387CC4; Tue, 31 Oct 2023 14:12:48 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED5C87B26
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDCel6086681;
 Tue, 31 Oct 2023 08:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698757960;
 bh=V1m7Vo4IoUvTFUo4yrCsoqBI+qzlzfeyuiBC0QmTOEg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=VPD7tRthb8XlHcM75m9fbM6gA4gYOUXm7XV7gIc1M3wTrh957ty+FGWm/+1GpAvyC
 tOZ6iczvPXDZlXzff9x0jauURPpVxTSTuk+doMd87oOjN+tgFDGs55eNNeCvC1Z7qK
 36sQihmCLj1hqj0eLR+ss3xFcG3srYa1pUsgV/5M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDCe2w102052
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:12:40 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:12:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:12:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDCdlo067343;
 Tue, 31 Oct 2023 08:12:40 -0500
Date: Tue, 31 Oct 2023 18:42:39 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/4] doc: ti: Add AM62x LP SK Board information
Message-ID: <20231031131239.thto32cvlox6fhzg@dhruva>
References: <20231030110138.1347603-1-n-yadav@ti.com>
 <20231030110138.1347603-5-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231030110138.1347603-5-n-yadav@ti.com>
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

Hi,

On Oct 30, 2023 at 16:31:38 +0530, Nitin Yadav wrote:
> Add link for AM62x LP SK in platform information. AM62x LP SK
> has config fragments to build U-boot, Adding information to
> update UBOOT_CFG_CORTEXR with lpsk fragments over am62x defconfig.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  doc/board/ti/am62x_sk.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index d7437c6d22..9d7ce1fd54 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -41,6 +41,7 @@ https://www.ti.com/lit/pdf/spruiv7
>  Platform information:
>  
>  * https://www.ti.com/tool/SK-AM62B
> +* https://www.ti.com/tool/SK-AM62-LP
>  
>  Boot Flow:
>  ----------
> @@ -86,6 +87,13 @@ Set the variables corresponding to this platform:
>   $ export OPTEE_PLATFORM=k3-am62x
>   $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
>  
> +For SK-AM62x-LP, set the UBOOT_CFG_CORTEXR variable as shown below:
> +
> +.. code-block:: bash
> +
> + $ export UBOOT_CFG_CORTEXR=am62x_evm_r5_defconfig am62x_lpsk_r5.config
> + $ export UBOOT_CFG_CORTEXA=am62x_evm_a53_defconfig am62x_lpsk_a53.config
> +

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  .. am62x_evm_rst_include_start_build_steps
>  
>  1. Trusted Firmware-A:
> -- 
> 2.25.1
> 
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
