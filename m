Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA8DC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DAC386FBE;
	Mon,  6 Nov 2023 17:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yO/TsMwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F5586F88; Mon,  6 Nov 2023 17:45:43 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A0E86FF4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6GjWXY004133;
 Mon, 6 Nov 2023 10:45:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699289132;
 bh=02VLLdIGkwyd3OCVguCzQ8wTI62r8A0ML3DlFPcYsdY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=yO/TsMwCKSFaF3el6WdAaG2wsGCvL7rUCXoR2oH5nnKSix4XeazYPwrMECc48PjuZ
 GHfRwffRTDybe//e2fiHwKooSLCKbfR8J7rhOMx5tXWMSS3e9U+wcUTB0RSo7earAD
 Sr47kGpaw0KQZp2R21TJevgYuh3ruG2VcePATiNM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6GjWSj091608
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 10:45:32 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 10:45:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 10:45:32 -0600
Received: from [10.250.34.172] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6GjVfU060777;
 Mon, 6 Nov 2023 10:45:31 -0600
Message-ID: <8b80a570-d558-4f5a-9390-f4c8c8d8210f@ti.com>
Date: Mon, 6 Nov 2023 10:45:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/12] arm: mach-k3: Kconfig: Introduce a symbol to
 indicate J7200
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Robert Nelson <robertcnelson@gmail.com>, Jason Kridner
 <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231104072150.3339-1-nm@ti.com> <20231104072150.3339-7-nm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231104072150.3339-7-nm@ti.com>
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

On 11/4/23 2:21 AM, Nishanth Menon wrote:
> J7200 shares quite a few characteristics with J721E. However a few sets
> are different. Introduce a Kconfig to differentiate the two to allow for
> new boards to be introduced in a seamless manner.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm/mach-k3/Kconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 9168bf842dca..57e2dd966eb8 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -24,6 +24,11 @@ config SOC_K3_AM62A7
>   
>   endchoice
>   
> +if SOC_K3_J721E
> +config SOC_K3_J721E_J7200

I'm sure you know how messy this is :(

We wanted to treat J7200 as a proper subset device of J721e but we
also know that didn't happen. These two SoCs ended up more different
than expected and although still very similar I believe continuing
to try to support both under one name is not the right solution.

We will split out J7200 from J721e in TF-A[0] for similar reasons,
might be time to do the same in u-boot.

Andrew

[0] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23970

> +	bool "TI's K3 based J7200 SoC variant Family Support"
> +endif
> +
>   config SYS_SOC
>   	default "k3"
>   
