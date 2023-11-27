Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7B3C0755A
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 15:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 054E087559;
	Mon, 27 Nov 2023 16:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s9xY5AFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BBDC87559; Mon, 27 Nov 2023 16:37:27 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7917287556
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 16:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ARFbF5g027540;
 Mon, 27 Nov 2023 09:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701099435;
 bh=GK7pf8UHKHFa7JPU6L0Qe7WxH2KNMiYTv7X0KT35I/c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=s9xY5AFTrBcVzneivdxFMZJGiy+6GQF2L2hEGf0ifEfAun2x858mo8MzHBR0n3Cm3
 WBP8byI89v6p393rtiPV3Z79eJ2CN09brVP15ofCij4CdALZzB3YD21DWJpqEYHBsu
 FvpTWdmx2+DH+QaB9sylTEj86/rhPeUAJMAymsyk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ARFbFUt030391
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Nov 2023 09:37:15 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 09:37:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 09:37:14 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ARFbEe7063640;
 Mon, 27 Nov 2023 09:37:14 -0600
Date: Mon, 27 Nov 2023 09:37:14 -0600
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] env: ti: j721s2.env: Remove the processors that
 are in lockstep
Message-ID: <20231127153714.o2qel4l627qw37pe@broiler>
References: <20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com>
 <20231127-b4-upstream-j721e-rproc-support-v2-3-22ee7c8ef53c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231127-b4-upstream-j721e-rproc-support-v2-3-22ee7c8ef53c@ti.com>
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

On 15:59-20231127, Manorit Chawdhry wrote:
> Linux 6.7-rc1 DT have the main R5s in lockstep configuration, since
> U-boot is using the Linux DT files.
> 
> Remove the processors that will be booted in lockstep configuration.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  board/ti/j721s2/j721s2.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
> index 64e3d9da85f0..1802147a9034 100644
> --- a/board/ti/j721s2/j721s2.env
> +++ b/board/ti/j721s2/j721s2.env
> @@ -31,6 +31,6 @@ name_mcur5f0_0fw=/lib/firmware/j7-mcu-r5f0_0-fw
>  #endif
>  rd_spec=-
>  
> -rproc_fw_binaries= 2 /lib/firmware/j721s2-main-r5f0_0-fw 3 /lib/firmware/j721s2-main-r5f0_1-fw 4 /lib/firmware/j721s2-main-r5f1_0-fw 5 /lib/firmware/j721s2-main-r5f1_1-fw 6 /lib/firmware/j721s2-c71_0-fw 7 /lib/firmware/j721s2-c71_1-fw
> +rproc_fw_binaries= 2 /lib/firmware/j721s2-main-r5f0_0-fw 4 /lib/firmware/j721s2-main-r5f1_0-fw 6 /lib/firmware/j721s2-c71_0-fw 7 /lib/firmware/j721s2-c71_1-fw

I really would prefer us to work towards getting stdboot remoteproc
properly handled.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
