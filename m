Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D095ACD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 11:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC59848BC;
	Fri,  5 Jun 2026 13:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Jn7GslVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25EBC848DF; Fri,  5 Jun 2026 13:52:22 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3411D848A1
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 13:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=iW/uhVSorebVSA8FFOVX7oq15N3HmWkkiCNxu5Ps/Q0=; b=Jn7GslVHxilHkKrgI2d3zEw5Oa
 Sn9j4jjEPxt0S+V1VnFurWMEE8KPjHqoimE1PM71UBxCsgqXUl3bGleL8naSuEg0AqE5FzD8+51jr
 qaALzd4AEL8GFlIX4V0/l5M1TW7zmtTRii/auR644strjkYZigypxdhzqcKfNrFukrMRSTFg+quca
 JZ9zOaw5ki3liRbTRscc1KzVR/jFQrklDxbSitAKGPAXlwHojnxHvD9vZHgr2xsqrCOBCqfhOJJH9
 e8VVqW3ma1XMgEoeIjLHeW/FWhFN3WzhGD/earUuzUbzPQiWIYMUJ0IH4+pAWnZNM70ZvS0z8usPQ
 iPlCrxKA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wVT63-000AOM-2X; Fri, 05 Jun 2026 13:52:19 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wVT64-000P6p-0b; Fri, 05 Jun 2026 13:52:19 +0200
Message-ID: <34df222b-1ede-480f-8a2f-01d4db607810@ew.tq-group.com>
Date: Fri, 5 Jun 2026 13:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] board: tqma7: update fastboot env
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260522110915.2269457-1-Alexander.Feilke@ew.tq-group.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260522110915.2269457-1-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 22/05/2026 13:09, Alexander Feilke wrote:
> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> Replace magic value with documented variable.
> While at it, restrict fastboot env guard to USB
> as its the only supported fastboot method.
>
> Fixes d000ce5efee3 ("board: tqma7: add code for u-boot with spl")
>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
> ---
>  board/tq/tqma7/tqma7.env | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/board/tq/tqma7/tqma7.env b/board/tq/tqma7/tqma7.env
> index 857f16d11bb..05035078869 100644
> --- a/board/tq/tqma7/tqma7.env
> +++ b/board/tq/tqma7/tqma7.env
> @@ -28,8 +28,15 @@ uboot_spi_sector_size=TQMA7_SPI_FLASH_SECTOR_SIZE
>  uboot_spi_start=TQMA7_SPI_UBOOT_START
>  uboot_spi_size=TQMA7_SPI_UBOOT_SIZE
>  
> -#ifdef CONFIG_FASTBOOT_UUU_SUPPORT
> +#ifdef CONFIG_USB_FUNCTION_FASTBOOT
> +
> +/* 0=user 1=boot1 2=boot2 */
> +fastboot_mmc_boot_partition = 1
> +
>  fastboot_partition_alias_all=CONFIG_FASTBOOT_FLASH_MMC_DEV:0
> -fastboot_raw_partition_bootloader=TQMA7_MMC_UBOOT_SECTOR_START TQMA7_MMC_UBOOT_SECTOR_COUNT mmcpart 1
> +fastboot_raw_partition_bootloader=
> +	TQMA7_MMC_UBOOT_SECTOR_START TQMA7_MMC_UBOOT_SECTOR_COUNT mmcpart
> +	"${fastboot_mmc_boot_partition}"
>  fastbootcmd=fastboot usb 0
> +
>  #endif

Any update on this?
