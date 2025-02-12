Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38D8C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 14:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6C480BAD;
	Wed, 12 Feb 2025 15:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KjXAt7MJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C427880BAE; Wed, 12 Feb 2025 15:49:40 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47846809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 15:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51CEnYI93817889
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 12 Feb 2025 08:49:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739371774;
 bh=uBJSQz18lVGmYGimhjvTTQCS0Y3Cugah5EkdKHeTEdU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KjXAt7MJy1DEYzf1jAKhOXZM2C0ayaISEsf1xpZ6/EzTlRcPJReAUdoFTYmn7NRfC
 qbfk6wVV2DVUV9q3nDMZ9mMfYVUMdV2qp2GbawO9W2FgugzSBK5hNmbOT1hOuPPPUR
 5WUGrmzjmZoJ1XKh5ONGaadLuPkqasfitYllzDlI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51CEnYeI023899;
 Wed, 12 Feb 2025 08:49:34 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Feb 2025 08:49:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Feb 2025 08:49:33 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51CEnUxd033317;
 Wed, 12 Feb 2025 08:49:31 -0600
Message-ID: <a4115f35-e3b3-4b79-8d65-8d86fb892446@ti.com>
Date: Wed, 12 Feb 2025 20:19:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2 v1] arch: arm: Kconfig: Add config to use
 subnode's bootph property for binding drivers
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <a-chavda@ti.com>, <u-kumar1@ti.com>
References: <20250212091820.213895-1-m-shah@ti.com>
 <20250212091820.213895-2-m-shah@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250212091820.213895-2-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2/12/2025 2:48 PM, Moteen Shah wrote:
> Add a new config when set will traverse through all the subnodes of
> a given node scanning for bootph-all property and propagate it to
> all of its parent node up the hierarchy.
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>   arch/arm/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 314916527c9..51fc952b0db 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -805,6 +805,7 @@ config ARCH_K3
>   	select FIT
>   	select REGEX
>   	select FIT_SIGNATURE if ARM64
> +	imply BIND_FROM_CHILD_BOOTPH

Why config, this fix looks to be valid for all configs ?


>   	imply TI_SECURE_DEVICE
>   
>   config ARCH_OMAP2PLUS
> @@ -2232,6 +2233,16 @@ config SYS_KWD_CONFIG
>   	  Path within the source directory to the kwbimage.cfg file to use
>   	  when packaging the U-Boot image for use.
>   
> +
> +config BIND_FROM_CHILD_BOOTPH
> +	bool "Bind drivers from bootph* in subnode"
> +	depends on ARCH_K3
> +	help
> +	 This config must be set to bind drivers in pre reloc stage whose
> +	 compatible parent nodes are implicitly declared to be bound to
> +	 their respective drivers by having bootph* property in one of
> +	 their subnodes.
> +
>   source "arch/arm/mach-apple/Kconfig"
>   
>   source "arch/arm/mach-aspeed/Kconfig"
