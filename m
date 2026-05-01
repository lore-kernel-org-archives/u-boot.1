Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0180FF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 08:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138D5803C6;
	Fri,  1 May 2026 10:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pZAbCyxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC4680F0E; Fri,  1 May 2026 10:03:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B34F80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 10:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 54E5C406E3;
 Fri,  1 May 2026 08:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D68C2BCB4;
 Fri,  1 May 2026 08:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777622582;
 bh=HezqCioWUNnVRs4730KmMrCPEju2S/hmGKajnOnRE94=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pZAbCyxBzIvR6qvP3YZUYdzgpjXI5Nm/1+ekoVq3jCXZcJGK4aJmqm67Iexmei3Du
 RppyhH43by2XTJCkjK8o6naQorCO7myf/rAM39jgrME3e00JbwioSljj43cGnQyQci
 QbwFT9zIVjYlWuzCOSlUrZW8fl683wWFgssfbTn/LKquHwWw3HLAuyAFINgl7tgJNH
 rG9FtaNYZNVfFIn3tLA53Z+1H+AS1B9zi8hjiEvusOrrRd9PqE0/THoABm0Zy1huGL
 1wd5BzjDIsAPPZ+pXS7Gay00K4OjYHD/3edpilINWbl/2wxcvzDAzdyQzLA5pOKPmW
 WVBTZs/dMdrGA==
Date: Fri, 1 May 2026 13:32:51 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v4 7/8] configs: Enable partition type GUID for
 QCS9100/QCM6490/QCS615 boards
Message-ID: <afReKzicksgelbPI@sumit-xelite>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
 <20260428-type-v4-7-b7051dc45a88@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-type-v4-7-b7051dc45a88@oss.qualcomm.com>
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

On Tue, Apr 28, 2026 at 01:01:49PM +0530, Balaji Selvanathan wrote:
> Enable CONFIG_PARTITION_TYPE_GUID and configure SCSI environment
> partition type GUID for QCS9100, QCM6490 and QCS615 configurations.
> This allows these platforms to locate the environment partition
> using GPT type GUID instead of UUID.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - Add type guid configs to QCS9100 defconfig
> 
> Changes in v3:
> - No changes
> 
> Changes in v2:
> - Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
> ---
>  configs/qcm6490_defconfig      | 4 ++++
>  configs/qcom_qcs615_defconfig  | 4 ++++
>  configs/qcom_qcs9100_defconfig | 3 ++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index b088367f86c..9560886a37a 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -16,3 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
>  
>  CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
>  CONFIG_PHY_QCOM_QMP_COMBO=y
> +
> +CONFIG_ENV_IS_IN_SCSI=y
> +CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
> +CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"

These config options are common among targets, can you rather add an env
related config fragment which can be included in all these defconfigs.

Also, please add the partition name here as a comment to easily locate the
partition.

-Sumit

> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index 27666a8129d..d0ffa567619 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -22,3 +22,7 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_TEXT_BASE=0x9fc00000
>  
>  CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
> +
> +CONFIG_ENV_IS_IN_SCSI=y
> +CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
> +CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
> diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
> index 082106157bb..fbaf21952f2 100644
> --- a/configs/qcom_qcs9100_defconfig
> +++ b/configs/qcom_qcs9100_defconfig
> @@ -11,6 +11,7 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
>  CONFIG_ENV_IS_IN_SCSI=y
> -CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
> +CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
> +CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
>  # CONFIG_ENV_IS_DEFAULT is not set
>  # CONFIG_ENV_IS_NOWHERE is not set
> 
> -- 
> 2.34.1
> 
