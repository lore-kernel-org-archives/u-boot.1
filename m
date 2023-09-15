Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF83CEE645B
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 12:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF38864D3;
	Fri, 15 Sep 2023 14:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e6j5IQ1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C707B86538; Fri, 15 Sep 2023 14:42:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF95864C7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 14:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FCgMJV024177
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 07:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694781742;
 bh=ylnya38VjZUOHRXZAhvJSW+r3wTTfxSTqFJJIa2NfcQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=e6j5IQ1LMM7JKByGnN4WhVDp3dKuh4HdVqNmJ8uvHI93898iBiFdI6ZUsebIY5LTS
 fwG/ShuKC2tPt6kJKCtx61sONuGFIGSshrrjxACAeOcXP/KYHIwtD6CEBLbA/oSp6q
 La1bSd3EIQyqp6a7CNWlLj3Vnlh57a2OT/IGLK48=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FCgMe1051709
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 07:42:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 07:42:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 07:42:22 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FCgMUx014048;
 Fri, 15 Sep 2023 07:42:22 -0500
Date: Fri, 15 Sep 2023 07:42:21 -0500
From: Nishanth Menon <nm@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
CC: <vigneshr@ti.com>, <afd@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] include: env: ti: mmc: Add 'ti' directory prefix for
 overlays
Message-ID: <20230915124221.ichr4x7wsamegbyz@facial>
References: <20230915101242.20048-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230915101242.20048-1-r-gunasekaran@ti.com>
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

On 15:42-20230915, Ravi Gunasekaran wrote:
> DTSOs are stored in vendor specific directories in Linux.

what is dtso? kernel generates dtbo

> Add the vendor prefix to the path to load the overlay correctly.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  include/env/ti/mmc.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
> index 0256a2d2aa..3e6b0287a3 100644
> --- a/include/env/ti/mmc.env
> +++ b/include/env/ti/mmc.env
> @@ -70,7 +70,7 @@ get_overlay_mmc=
>  	fdt resize 0x100000;
>  	for overlay in $name_overlays;
>  	do;
> -	load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/${overlay} &&
> +	load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/ti/${overlay} &&
>  	fdt apply ${dtboaddr};
>  	done;
>  get_kern_mmc=load mmc ${bootpart} ${loadaddr}
> 
> base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c

we should move to stdboot and simplify this.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
