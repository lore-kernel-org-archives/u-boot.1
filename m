Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F6C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 06:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2DD809D4;
	Thu, 20 Mar 2025 07:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742453729;
	bh=zqW462bVV5gTsieEGB9Lh2ygjTiSRZybghUtQNo4zhE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g2sjVdUpHY4MLQa0ZYuv/4NnG/xPxv9sSwf693Hr1A6rk12NTUag1+ASZUVxjmkbA
	 jom56oCpzp7NdD8Oe63MxwXBCpuqx4nMFSJBr1nfToF/9YJuRpf0N/+ump1vW0Ps1j
	 iEBUaoRnpDLQjgvKjclQpuMuB7J9Cbg1lVPKSIfdzqQRSbixzTT5j6Ewty0n0F9rmI
	 6MMF6ZgGYJgLZ03BqhnxZVAaCPB5PUYgnFgAZAj0ter8KfxnYJPwt1qll9MvNq7IEb
	 3dUdIZZwi1WUbWCg3Kar9szNvauxDPVSk7sCW5QXepwlV5O9vLM0ubZWaI/zHCa5mz
	 7uMYqgXrzdu8Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E60EC8129F; Thu, 20 Mar 2025 07:55:28 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7EE8083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZJGYR3p1xz9tRl;
 Thu, 20 Mar 2025 07:55:23 +0100 (CET)
Message-ID: <9d9d3196-2e59-45bd-b388-72b75ee645e5@denx.de>
Date: Thu, 20 Mar 2025 07:55:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] configs: mvebu_espressobin_ultra-88f3720_defconfig:
 disable SATA
To: Benjamin Schneider <bschnei@gmail.com>
Cc: Benjamin Schneider <ben@bens.haus>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 u-boot@lists.denx.de
References: <20250228192240.129406-1-ben@bens.haus>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250228192240.129406-1-ben@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4ZJGYR3p1xz9tRl
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

On 28.02.25 20:22, Benjamin Schneider wrote:
> This device uses the SCSI subsystem to interface with SATA devices.
> Trying to use the sata command results in an unhandled exception.
> This has the side effect of also causing bootflow scan to raise
> an unhandled exception when it attempts to probe the SATA
> subsystem. Disabling the sata command fixes this issue and does
> not remove support for any boot devices.
> 
> Signed-off-by: Benjamin Schneider <ben@bens.haus>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/mvebu_espressobin_ultra-88f3720_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> index 6f1a66f5f1..1cbeee8fcb 100644
> --- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
> +++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> @@ -34,7 +34,6 @@ CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_PCI=y
> -CONFIG_CMD_SATA=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_WDT=y

