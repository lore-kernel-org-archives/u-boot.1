Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6383E8FDA5
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 10:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E436783D1A;
	Fri, 26 Dec 2025 11:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uJuaR3AV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE1983B95; Fri, 26 Dec 2025 11:18:09 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F80684150
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 11:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B3D5844087;
 Fri, 26 Dec 2025 10:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CA7C4CEF7;
 Fri, 26 Dec 2025 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766744284;
 bh=yOZ89cpMCOdSxUauJFENF6fMXh95CmyW0/YXSg5ngIo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uJuaR3AVl2+40fvhQ/TeT7Sh3KijnM13Xy9mibElqqbczpEkL+VL7tx27/jixti1t
 QoXm2R3Lv8tdHVlV00Z5BU5kDARYV2auLnUHnl1594iMt4z/SaU1Pas+CpkK5RrXLt
 DESLjP9DpHWo0CrcUkurSCiwvQ3R7o+ShDDOlCPdT/DBziBmNlCj1Ct9OoeOpvME7C
 TyXOl2dk6U2KawxyobrhiniFz/kOP24WOXoFkfb5mWEGMeKlpdcJEt3Y81hWE36/lc
 VAUR9cpkVzWrhrgZtgnPASGPqBAQShgyWcjW3bfO2+bMioz73X9ZBx5502yivhF3wr
 nOgJUqm0raSgA==
Date: Fri, 26 Dec 2025 15:47:58 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v1] dts: qcs6490-rb3gen2: Switch USB controller to
 peripheral mode
Message-ID: <aU5g1v7sjJBe9MVX@sumit-xelite>
References: <20251114064042.3835312-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114064042.3835312-1-balaji.selvanathan@oss.qualcomm.com>
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

On Fri, Nov 14, 2025 at 12:10:42PM +0530, Balaji Selvanathan wrote:
> Change USB controller dr_mode from "host" to "peripheral" to enable
> fastboot support on the QCS6490 RB3Gen2 board.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> index fbe72595f5a..50674b692ed 100644
> --- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> +++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> @@ -18,7 +18,7 @@
>  };
>  
>  &usb_1_dwc3 {
> -	dr_mode = "host";
> +	dr_mode = "peripheral";
>  	/delete-property/ usb-role-switch;
>  };

I would rather suggest to try and drop this override "&usb_1_dwc3"
completely since the peripheral mode should be the default when dr_mode
is set as "otg".

-Sumit

>  
> -- 
> 2.34.1
> 
