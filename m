Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBA5C5516A
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1141783E36;
	Fri, 20 Feb 2026 10:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nOjuHCGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3EC83E40; Fri, 20 Feb 2026 10:09:53 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8089683E21
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ECD4643BCE;
 Fri, 20 Feb 2026 09:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF998C116C6;
 Fri, 20 Feb 2026 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771578589;
 bh=AssqNMHov0wtI7rWOKdSRuDpwhnxCCKpqsvLmazzk9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nOjuHCGcbsFDLVljwnIR4HCPQPM4usXg8F5klM92Q6lVMVguO4DVnphjBrRe5NL1w
 rV1ZdgpPILk2XHAmIn2NV9ipYdVkIJwTZjavdVw4MrFiFQpgjqBXKKNMeL6ZaICWRp
 5cEz7+q5WkV0m8Gt1eA0lxLvwqJoCJ7U5ceesyyDrKWs4vxdcYLc1QgKYICvqo+NjS
 +cqTzLis8+FA74keX/bmmQjRnOe0eiBh+3SLHOMG+wzbdDbY2Z5YQjWgXdhJxrJf+N
 JCAToGVr44tXsyUlWuKq1ppATFDQlcJ6YWAlFeBFIHQiYxFkjA2f4bUEAkmdHsVj2P
 lno+wVOXI8FJg==
Date: Fri, 20 Feb 2026 14:39:42 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH] qcom_defconfig: Switch Qualcomm fastboot flash from MMC
 to block
Message-ID: <aZgk1rZKhCW_7A2F@sumit-xelite>
References: <20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com>
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

Hi Balaji,

On Mon, Feb 16, 2026 at 09:45:49PM +0530, Balaji Selvanathan wrote:
> Replace MMC-specific fastboot flash configuration with generic
> block device support for Qualcomm platforms. This change switches
> from MMC device 0 to SCSI interface with device ID 4, enabling
> fastboot operations on UFS storage instead of eMMC.

I don't think if it's right for qcom generic defconfig to hardcode
fastboot flash device. Can you try to see rather if the fastboot flash
device can be determined at runtime? As otherwise it might end up in
target specific defconfig which we should avoid if we can.

-Sumit

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  configs/qcom_defconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index fe5880de1fd..2666adb0569 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -77,8 +77,9 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>  CONFIG_USB_FUNCTION_FASTBOOT=y
>  CONFIG_FASTBOOT_BUF_ADDR=0x0
>  CONFIG_FASTBOOT_FLASH=y
> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> -CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
> +CONFIG_FASTBOOT_FLASH_BLOCK=y
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
>  CONFIG_MSM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_DM_I2C=y
> 
> ---
> base-commit: f9ffeec4bdcf1da655a0ffea482062adde78fee8
> change-id: 20260216-fb_block-6193ec15ccf6
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
