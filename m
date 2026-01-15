Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60680D4116C
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 11:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3BAD83015;
	Thu, 15 Jan 2026 12:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CbW4LHV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C414B836AC; Thu, 15 Jan 2026 12:21:49 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A90C980325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 12:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F36BD41B45;
 Thu, 15 Jan 2026 11:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598EBC116D0;
 Thu, 15 Jan 2026 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768476105;
 bh=ZXHExSODdResVCXq8J5JyLQLtdG+3H3ix1j5AxTn1R4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CbW4LHV7vledoqJvDYc7l5OBhG99f6PDI3GlOC7ovcU/z3sr3Zaa/kl6aEB8KEe5g
 aznXh5Mu0VsD6LNSgLuURx8Sm1qiTvfTUodXB4ug+EWu2urM0ylrzcAEe9mDQoJalj
 HGMqROF2tUHx0Kopq6BmJGfEUd2ikBS1CXSp1TUCkld5t6VUEQj2o8RbZE8CyONr08
 c5XdWHg4qIy0DW1YsDgMmuOqH7AbkvId1KioXoOgameXBXM0RHEahXU9CkghMOi26K
 FanTB3SeXkulSTaFp8Y3e9bbfZXhP20WPvESxmDFbAK9pvblYbvNiRyh9uNJlkfUYw
 yXQbKMOtj23Gw==
Date: Thu, 15 Jan 2026 16:51:36 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 joe.hershberger@ni.com, ilias.apalodimas@linaro.org, ravi@prevas.dk,
 quic_varada@quicinc.com, quentin.schulz@cherry.de,
 javier.tia@linaro.org, simon.glass@canonical.com,
 marek.vasut+renesas@mailbox.org, ansuelsmth@gmail.com,
 michal.simek@amd.com, mwalle@kernel.org, jan.kiszka@siemens.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/4] configs: Enable partition type GUID for QCM6490
 and QCS615 boards
Message-ID: <aWjNwE9LwHfTljNM@sumit-xelite>
References: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
 <20260109070912.4106466-5-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109070912.4106466-5-balaji.selvanathan@oss.qualcomm.com>
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

On Fri, Jan 09, 2026 at 12:39:12PM +0530, Balaji Selvanathan wrote:
> Enable CONFIG_PARTITION_TYPE_GUID and configure SCSI environment
> partition type GUID for QCM6490 and QCS615 board configurations.
> This allows these platforms to locate the environment partition
> using GPT type GUID instead of unique UUID.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
> 
>  configs/qcm6490_defconfig     | 5 +++++
>  configs/qcom_qcs615_defconfig | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index 54eb5dedaec..e9932abbcd6 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -13,3 +13,8 @@ CONFIG_TEXT_BASE=0x9fc00000
>  CONFIG_REMAKE_ELF=y
>  
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> +
> +CONFIG_ENV_IS_IN_SCSI=y
> +CONFIG_PARTITION_TYPE_GUID=y
> +CONFIG_SCSI_ENV_PART_USE_TYPE_GUID=y
> +CONFIG_SCSI_ENV_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"

This GUID belongs to the "logfs" partition. I suppose it's being
repurposed for U-Boot environment here. Do you know it's intended
usecase as well?

-Sumit

> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index 2468267b955..94efa46815b 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -20,3 +20,8 @@ CONFIG_REMAKE_ELF=y
>  
>  # Address where U-Boot will be loaded
>  CONFIG_TEXT_BASE=0x9fc00000
> +
> +CONFIG_ENV_IS_IN_SCSI=y
> +CONFIG_PARTITION_TYPE_GUID=y
> +CONFIG_SCSI_ENV_PART_USE_TYPE_GUID=y
> +CONFIG_SCSI_ENV_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
> -- 
> 2.34.1
> 
