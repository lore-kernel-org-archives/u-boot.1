Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148C8C27C77
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 05:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A9F88258;
	Mon, 17 Jun 2024 07:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ODGMzVdl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0B788254; Mon, 17 Jun 2024 07:07:58 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AADD088258
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45H57rCi012799;
 Mon, 17 Jun 2024 00:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718600873;
 bh=VlvGNuTXrcoHsODMldBP2vSBP4uWNzNzh8/dgK1Hi3w=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ODGMzVdlMtUa+x9/fmID031qtChFq3BA7WFmqttGEWLb4GRG5m0kyBXbHcLUreqMI
 lPul22oTDyY6YLfZP/faWk7cYjGB35wfZVEI0jqQQrEbgotjGs76cyx6L5TQFbVZ9U
 W7bQUtdbUJeeydtJ/ruxPyClwMLdHta7O5/uA7qk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45H57rPU121201
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 00:07:53 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 00:07:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 00:07:52 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45H57qW0098375;
 Mon, 17 Jun 2024 00:07:52 -0500
Date: Mon, 17 Jun 2024 10:37:51 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Nishant Menon <nm@ti.com>,
 <c-shilwant@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v3] arm: dts: k3-am625-beagleplay: Add symlinks for
 tiboot3 and tispl
Message-ID: <20240617050751.ulfni6qnijs5xqey@uda0497581>
References: <20240614120416.4126896-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240614120416.4126896-1-d-gole@ti.com>
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

Hi Dhruva,

On 17:34-20240614, Dhruva Gole wrote:
> Add symlinks for both tiboot3.bin and tispl.bin because a user has to
> anyway rename these files to get the platform to boot up.
> This just makes it more intuitive and convenient.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> This is just a RESEND of v1, because the changes in v2 were not
> required. Link to previous revision:
> https://lore.kernel.org/u-boot/20240614115340.4091211-1-d-gole@ti.com/

Didn't realise that u-boot.img comes by itself from the core framework
itself. Thanks for re-sending v1.

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> 
> 
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 1 +
>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index fb2032068d1c..bd48af8d186a 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -71,6 +71,7 @@
>  
>  	ti-spl_unsigned {
>  		filename = "tispl.bin_unsigned";
> +		symlink = "tispl.bin";
>  		pad-byte = <0xff>;
>  
>  		fit {
> diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> index 9db58f093c8c..da6746e009d5 100644
> --- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
> +++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> @@ -79,6 +79,7 @@
>  &binman {
>  	tiboot3-am62x-gp-evm.bin {
>  		filename = "tiboot3-am62x-gp-evm.bin";
> +		symlink = "tiboot3.bin";
>  		ti-secure-rom {
>  			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
>  				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
> 
> base-commit: 1ebd659cf020843fd8e8ef90d85a66941cbab6ec
> -- 
> 2.34.1
> 
