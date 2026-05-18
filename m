Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19937CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E8C883FEE;
	Mon, 18 May 2026 12:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tXwiQEUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D73E84119; Mon, 18 May 2026 12:51:35 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC72F83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B78A6001A;
 Mon, 18 May 2026 10:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92006C2BCB7;
 Mon, 18 May 2026 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779101491;
 bh=rOW5Rkwtw0lyjoBQWsVgEGEO88Do5SpU2bLyGOFAqz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tXwiQEUQzRPJZXYAJJWVzkc0SMObkwBOI/wwfgWftnFRo1NZeXVYLG4W6O3ztbP5t
 dPDWmNoryTB0hQycipn/LvDwxLdglv9U1Q7udmDqCA/7CNODBRx6UZZHrz99Z2uAKI
 aLOgo8R7koe0PJbaYAZ0smxmWkr3lXTfIRvll8OLj+VQNFi8KsuWWDWprb9pdbZ7Ub
 UzgzeX3Buck8mWqgFEUaQdhkw+hSm2iENX9i/9fZzJmrw43kXGG6q1OnF26r3ri0sE
 se4Go9rJdX3SsS7hTmlPWII1vYVje++dGCJ3ejp2QsHf6aWkJtoNBgNG2seONFMxMQ
 Bq+ljJaNp+SAQ==
Date: Mon, 18 May 2026 16:21:25 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] qcom: qcs615: disable SCSI and use MMC for fastboot
Message-ID: <agrvLQfkJ4gid6CD@sumit-xelite>
References: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
 <20260502-talos_emmc-v1-1-98fe4a4d6f8d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502-talos_emmc-v1-1-98fe4a4d6f8d@oss.qualcomm.com>
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

On Sat, May 02, 2026 at 07:31:48AM +0530, Balaji Selvanathan wrote:
> QCS615 platforms are equipped with eMMC storage only and do not
> support UFS or other SCSI-backed devices.
> 
> Disable SCSI support and override the inherited qcom_defconfig
> fastboot settings to use the MMC block interface with device 0.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  configs/qcom_qcs615_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>

This patch seems to be dependent on this series [1]. Either mention a
dpendency here or bundle this patch alongside that series.

[1] https://lore.kernel.org/all/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/

-Sumit

> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index 27666a8129d..494e55bb18c 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -22,3 +22,9 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_TEXT_BASE=0x9fc00000
>  
>  CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
> +
> +# CONFIG_SCSI is not set
> +
> +# QCS615 has eMMC only, not UFS/SCSI - override qcom_defconfig settings
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
> 
> -- 
> 2.34.1
> 
