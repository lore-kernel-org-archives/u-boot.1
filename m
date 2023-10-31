Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9E2C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF3A8747A;
	Tue, 31 Oct 2023 13:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="knwJve8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69FB87497; Tue, 31 Oct 2023 13:07:23 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94B687443
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 13:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VC7ISU039302;
 Tue, 31 Oct 2023 07:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698754038;
 bh=o4bFo7FLt+o+hyVeQZb10goJ73/ZGxrVAaTm1yIgTWo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=knwJve8myhIZLQXXKRFgCOaD3mMKoJs1XUWFLrg0+3b6Je5AK43bSykz1chZib5XE
 uhRInPxokVsKkp6/sQ8EXoWSv2SbONsxtXqz/AzUQytTwjEIxA3Fgc8quqOt6TAqsb
 EY7g9iI6ieGi068R5I+bRWJXOKtkyxns/yueWWes=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VC7IVD064351
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 07:07:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 07:07:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 07:07:17 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VC7HgL116485;
 Tue, 31 Oct 2023 07:07:17 -0500
Date: Tue, 31 Oct 2023 07:07:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/4] doc: ti: Add AM62x LP SK Board information
Message-ID: <20231031120717.2x3smou7esgc3lk7@theater>
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

$subject missing am62x_sk

On 16:31-20231030, Nitin Yadav wrote:
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

This will just not render sensibly..

 $ export UBOOT_CFG_CORTEXR=am62x_evm_r5_defconfig
 $ export UBOOT_CFG_CORTEXA=am62x_evm_a53_defconfig
 $ export TFA_BOARD=lite
 $ # we dont use any extra TFA parameters
 $ unset TFA_EXTRA_ARGS
 $ export OPTEE_PLATFORM=k3-am62x
 $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"

For SK-AM62x-LP, set the UBOOT_CFG_CORTEXR variable as shown below:

 $ export UBOOT_CFG_CORTEXR=am62x_evm_r5_defconfig am62x_lpsk_r5.config
 $ export UBOOT_CFG_CORTEXA=am62x_evm_a53_defconfig am62x_lpsk_a53.config

Please refactor to ensure that the document renders completely for SKB
and LP-SK so that one can copy paste instructions cleanly.

>  .. am62x_evm_rst_include_start_build_steps
>  
>  1. Trusted Firmware-A:
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
