Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538BDC02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 06:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A67801BE;
	Mon,  3 Feb 2025 07:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W4QGRJ2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEDAA80214; Mon,  3 Feb 2025 07:08:42 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BC780087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 07:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51368aJo2083933
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2025 00:08:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738562916;
 bh=4Qo8wZlakpk7nPsn9uXXREEnl75mmLwzI1tjskQG3Y4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=W4QGRJ2tjKC1fdEXANQHgP4n+nLYNQFEPYOq3ON2C627feWo73VKYhZBn7/2dv2jW
 CWrDaA0il3Grb/3LjfmdnIgEJIFBnbBlz7Mz8kKb/MyDM8fGySt+vnpE3BXigHnuMQ
 HwiPExM/2YClRRGdJqywn6T0Es13beeYA3V++4Es=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51368aJW049409
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Feb 2025 00:08:36 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Feb 2025 00:08:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Feb 2025 00:08:35 -0600
Received: from [172.24.18.203] (ltpw0bk3wf.dhcp.ti.com [172.24.18.203])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51368W3E118425;
 Mon, 3 Feb 2025 00:08:32 -0600
Message-ID: <f7012bac-eae8-443e-bd18-0c9d9524b3d9@ti.com>
Date: Mon, 3 Feb 2025 11:38:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] configs: j7200_evm_a72_defconfig: Re-enable
 MUX_MMIO at U-Boot proper
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <a-limaye@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <vaishnav.a@ti.com>, <j-humphreys@ti.com>, <p-mantena@ti.com>,
 <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20250201091809.1894892-1-s-vadapalli@ti.com>
 <20250201091809.1894892-3-s-vadapalli@ti.com>
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <20250201091809.1894892-3-s-vadapalli@ti.com>
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


On 01-02-2025 14:48, Siddharth Vadapalli wrote:
> Commit under Fixes introduced support for Hyperflash boot but also disabled
> MUX_MMIO support at U-Boot proper. MUX_MMIO is required at U-Boot proper
> to setup the SERDES Lane Mapping as described by the device-tree. On J7200
> SoC, PCIe functionality is broken since commit under fixes.
>
> Fix this regression by re-enabling MUX_MMIO.
>
> Fixes: 038f6faea9f0 ("configs: j7200_evm_*_defconfig: Add configs for Hyperflash boot")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Anurag Dutta <a-dutta@ti.com>
> ---
>
> v1:
> https://patchwork.ozlabs.org/project/uboot/patch/20250127162509.965644-1-s-vadapalli@ti.com/
> Changes since v1:
> - Rephrased commit message.
>
>   configs/j7200_evm_a72_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
> index e1ef6e86d4..ac5b10ba14 100644
> --- a/configs/j7200_evm_a72_defconfig
> +++ b/configs/j7200_evm_a72_defconfig
> @@ -144,6 +144,7 @@ CONFIG_SPI_FLASH_S28HX_T=y
>   # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>   CONFIG_SPI_FLASH_MTD=y
>   CONFIG_MULTIPLEXER=y
> +CONFIG_MUX_MMIO=y
>   CONFIG_PHY_TI_DP83869=y
>   CONFIG_PHY_FIXED=y
>   CONFIG_TI_AM65_CPSW_NUSS=y
