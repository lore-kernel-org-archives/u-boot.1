Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70AACD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 11:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B50984843;
	Tue,  2 Jun 2026 13:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="HHTtjFiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACB784852; Tue,  2 Jun 2026 13:21:05 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C34840ED
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 13:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 82866116F71; Tue,  2 Jun 2026 13:20:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780399261;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=hMdOLefdG75nV5Vnu/hMTTXCmayTZwG0Krg56MSScyY=;
 b=HHTtjFiE9dRi4QndW3OelFFXUISoDhsJ/8rYeCmZhmVOzcsyr9ob9WfYsDFjntN0N6FS7n
 nzPrGSni9j7AqpoxXtOBItiwc6sNaT1MibUei7z+C/wMMzb5RpqkzeWD1Ud08em5CP9VqR
 /kPWyrGugyJFc5eIiHjRCS7LgPD7BAgCJyycGGE9gEm2aHH4SnYH7ON3YcuE8Wdv+dRraU
 ooATNihCGKZoIxMWy/TnBAb6fWT27luZiQj1fRTCc931ID3ryeOK/0E877K/33XQKRmSan
 GtIfsHlxCXZ4Bkut7nUWU17MjRSSjFYVFoINCpbuG9MjlPgceEWhrHLss/JEqQ==
Message-ID: <acfe5311-2ec4-48fb-80bd-55c11931b377@nabladev.com>
Date: Tue, 2 Jun 2026 13:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, joao.goncalves@toradex.com,
 ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com, qijian.guo@nxp.com,
 "Ross, Fedor" <fedor.ross@ifm.com>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/30/26 10:33 AM, Simona Toaca (OSS) wrote:

[...]

> +static int imx_qb_spi(bool save)
> +{
> +	struct udevice *flash;
> +	u64 offset;
> +	int ret;
> +
> +	if (!CONFIG_IS_ENABLED(SPI)) {
> +		printf("SPI not enabled\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = uclass_first_device_err(UCLASS_SPI_FLASH, &flash);
> +	if (ret) {
> +		printf("SPI flash not found.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = imx_qb_get_qbdata_offset(flash, SPI_DEV, &offset);
> +	if (ret) {
> +		printf("get_qbdata_offset failed, ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = spi_flash_erase_dm(flash, offset, QB_STATE_LOAD_SIZE);
Can you please double-check whether "offset" here is always aligned to 
64 kiB (SPI NOR erase block size) ? If not, this erase here will fail.

Thank you
