Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B729C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 14:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E94B83CCF;
	Thu, 10 Apr 2025 16:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X5rx6L15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10C1F83CCF; Thu, 10 Apr 2025 16:25:00 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92436836AC
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 16:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AEOqXH1308547
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 09:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744295092;
 bh=qYUHXL2+Qz4C8BfeIGcGmYH2mrhktlJpCmvJxU55fBE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=X5rx6L15ytZ4Ji1YW2qDoS9dxj/mZAqtBkN5A4hAPtjlC4XCxKU8f1brPkK6EqhkI
 UNZNXeScvPCshhwgfi0DYqDjI1KsuCAr8UOKzk3O7i6C2kVJ2V8MiqrdlTuPjulusf
 2dMoPP0Reqxh8AY5fntRBsV8QXh/RtDiy5UoCOZ0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AEOqLE114679
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Apr 2025 09:24:52 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 09:24:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 09:24:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AEOqUv026641;
 Thu, 10 Apr 2025 09:24:52 -0500
Date: Thu, 10 Apr 2025 09:24:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <d-gole@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <mwalle@kernel.org>, <kamlesh@ti.com>, <j-choudhary@ti.com>
Subject: Re: [PATCH] doc: board: ti: Add optee rng support
Message-ID: <20250410142452.5ngxny6w3ykvi4sj@flask>
References: <20250410132746.8168-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410132746.8168-1-u-kumar1@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 18:57-20250410, Udit Kumar wrote:
> J722S has hw rng, which can be used by OPTEE.
> So remove option to use SW TRNG by OPTEE.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> reference discussion 
> https://lore.kernel.org/all/20250313144155.2382316-1-mwalle@kernel.org/
> 
> Bootlogs with optee trng 
> https://gist.github.com/uditkumarti/5f90210b23e67cd4eb6d06a024031ee8#file-gistfile1-txt-L1970
> 
>  doc/board/ti/j722s_evm.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
> index e5a1be50c4f..edc29a4f9e4 100644
> --- a/doc/board/ti/j722s_evm.rst
> +++ b/doc/board/ti/j722s_evm.rst
> @@ -74,7 +74,6 @@ Set the variables corresponding to this platform:
>   $ export UBOOT_CFG_CORTEXA=j722s_evm_a53_defconfig
>   $ export TFA_BOARD=lite
>   $ export OPTEE_PLATFORM=k3-am62x
> - $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
>  
>  .. j722s_evm_rst_include_start_build_steps
>  
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
