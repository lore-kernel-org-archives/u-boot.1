Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6D606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aecTnRC+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHxcb99x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0424E810B8;
	Thu, 26 Nov 2026 14:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVdEeJGdHNqQ; Thu, 26 Nov 2026 14:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D714380F4E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702625;
	b=kpPnCD+h4k8cw+I3NAzGS4xn19/YVLosE3olBvMInLESik5o5PzzAa4QI16kaVxR5pgs
	 TwcNeRkbUrVXJyCsU2wwBAd11eFWTPWtH6wwddJNgfTSuJ883gsWV7xEzDCvH7p/g6y9w
	 APGUSPnGyLBHAJsu47e8njs7Ac2y7tfBv7pmkbcUtBolabJBJTIfs98SQ0c5b/slKYVOy
	 ZJnW3VTYf4brouj3rjcNZF3v1AdMTHVnYj5ssXNHPGf20fC9byl+KpLI2cKPqqIceIUWj
	 xdEsl2G+ZU+SGF+I1b22LOF3Hg8J+0vAdo2FKWNa+jmqxzcG2WkCOr/nkauaqhbV6RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702625;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ABHCz+2vn/zPBo5HVkZd13WMLymNBLPJeg2GXYD70O4=;
	b=V8i9cy5ZbOW39ln5CF37sl9n1GwuTt4k7fR7A9JjiPFR/yU8z9f6C+KR3jm3T9cIQ5vx
	 3xMAvWB6gnhmU7KlTq08W3eXxCXPDdQAiU0Q0HH/5HeaokTt8a2nYIwHALAWU3DNcZQvn
	 Cb5Y/HbLeqPf2EyPfKnKgFmwEc8akO09/o8n8UuEhX0swnckHUzl7TLuDNJTzf7XfdKBA
	 TmwKgbyeSZnv21vzjPY4my8GDQZMB1/UYF5byuh4EKcUVrMfI4wR81X8FOvJCJRsnLt27
	 l5fV42X2pjY8llwvdXF27Z68qCM+QX6KnvlPKxoJn3injFpsu4CGREysyXMYEsDX/ww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795702625;
	bh=ABHCz+2vn/zPBo5HVkZd13WMLymNBLPJeg2GXYD70O4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aecTnRC+QF3AhNwPa0Ja1xssBZeFwF8XXQ8Tvgvwhm2QP8kllJFkNa1fcrwZ7Wp4q
	 W8UnlFd0bLz+zyitMfKtzoF6KG/xsSDi73/PG7hMn0/5c2t7vidjwfJe00RvapgkXO
	 5Mk9nljmY/LpMy5ViMYx7Z//6gczIiUChwyighYr28uTHoTp8PM1afDrRk1uG7njrS
	 lO8F9EjEyLodD9/QkAuca9xrv+/LwUuXzRCbz76zSjPFv8+mTcdUUMntKTxdnhwqEG
	 mEa1BX0hjoS6WKTEvIm4FaqQ7PIxQMVIA0F83DePbUc13J/Mjj1zM5NBIDF0Vv/ol3
	 pwfAkAgcsBW1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D714380F4E;
	Thu, 26 Nov 2026 14:17:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 97275260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94C9D606F1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44pLpyyk4dDv for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A32C660690
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AHxcb99x
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A32C660690
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:17:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A02846372;
 Thu, 26 Nov 2026 14:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059811F008B2;
 Thu, 26 Nov 2026 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795702622;
 bh=ABHCz+2vn/zPBo5HVkZd13WMLymNBLPJeg2GXYD70O4=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=AHxcb99xcHyvm+2xuoOyH0gt27eD6h1R5gknYkjyNEebvW198HbKL13biop01u/ul
 EY/dZopRp3Py4aqDWUOKWFOjEaFMLhqzOVuLq1iV5mkuurPOwCwUtYEpXUjZH3Nisr
 RaiI8n3tHlC+OXdtDT+OcAohjPtna+jXo3oE7vtPl3LYzgpQmySBrMAsbP1B0yQ7AZ
 1aH6C8HqEELsN5pAqSVoncCrsrOvooO/fnLbF+pYPmv4mwRtRRPGBeohSmaYkduBCd
 HO+kJf4pzA1GMvE+X7ICHG9Ojhki6mrxm15FS/1FHoMj4VsD1NquBH4dkEbTHien8p
 YnQ+7DRHgFeVQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 9/9] configs: add shikra defconfig, MAINTAINERS and
 doc for IQS board
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com, 
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com, 
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de, 
 william.bright@imd-tec.com, nikroks@mainlining.org, 
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com, 
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <20261124164700.1606518-10-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
 <20261124164700.1606518-10-aswin.murugan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 19:46:53 +0530
Message-Id: <179570261352.130558.14753071131629670264.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-24 22:17 +0530, Aswin Murugan wrote:
> Introduce a defconfig for Shikra IQS board, add the corresponding
> MAINTAINERS entry, and document the board in dragonwing.rst, folded
> into a single patch per review feedback.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  board/qualcomm/MAINTAINERS        |  5 +++++
>  configs/qcom_shikra_iqs_defconfig | 31 +++++++++++++++++++++++++++++++
>  doc/board/qualcomm/dragonwing.rst | 16 ++++++++++++----
>  3 files changed, 48 insertions(+), 4 deletions(-)
>  create mode 100644 configs/qcom_shikra_iqs_defconfig
> 
> diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
> index 3767a2a7949..f8cd20ee60a 100644
> --- a/board/qualcomm/MAINTAINERS
> +++ b/board/qualcomm/MAINTAINERS
> @@ -6,6 +6,11 @@ M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>  S:	Maintained
>  N:	qcs615
>  
> +QUALCOMM DRAGONWING SHIKRA
> +M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> +S:	Maintained
> +N:	shikra
> +
>  # RB3 Gen 2 and similar boards
>  QUALCOMM DRAGONWING QCS6490
>  M:	Casey Connolly <casey.connolly@linaro.org>
> diff --git a/configs/qcom_shikra_iqs_defconfig b/configs/qcom_shikra_iqs_defconfig
> new file mode 100644
> index 00000000000..9ae425450a6
> --- /dev/null
> +++ b/configs/qcom_shikra_iqs_defconfig
> @@ -0,0 +1,31 @@
> +# Configuration for building U-Boot in Shikra IQS EVK
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=y
> +
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/shikra-iqs-evk"
> +
> +# Address where U-Boot will be loaded on this board
> +CONFIG_TEXT_BASE=0x9f400000
> +CONFIG_QCOM_GENERATE_MBN=y
> +
> +CONFIG_FASTBOOT_BUF_ADDR=0xc5000000
> +
> +# Shikra has eMMC only, not UFS/SCSI - override qcom_defconfig settings
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
> +
> +# CONFIG_SCSI is not set
> +
> +# Environment stored in eMMC logfs partition
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_MMC_USE_SW_PARTITION=y
> +CONFIG_ENV_MMC_SW_PARTITION="logfs"
> +CONFIG_ENV_OFFSET=0x0
> +CONFIG_ENV_SIZE=0x4000
> +
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
> +CONFIG_OPTEE_LIB=y

Please use the exisiting config fragment for this.

-Sumit

> diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
> index 42828842da5..171600b8db9 100644
> --- a/doc/board/qualcomm/dragonwing.rst
> +++ b/doc/board/qualcomm/dragonwing.rst
> @@ -6,12 +6,14 @@ Qualcomm DragonWing
>  
>  Qualcomm DragonWing boards are industrial-grade platforms targeting factory
>  and edge applications. They span multiple product families, including
> -IQ6, IQ8, IQ9, and Q8, which are based on Qualcomm QCS615, QCS8300 (Monaco),
> -QCS9100, and QCS8550 series SoCs respectively
> +IQ2, IQ6, IQ8, IQ9, and Q8, which are based on Qualcomm Shikra, QCS615,
> +QCS8300 (Monaco), QCS9100, and QCS8550 series SoCs respectively
>  
> -More information can be found on the `Qualcomm's IQ6 product page`_,
> -`Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
> +More information can be found on the `Qualcomm's IQ2 product page`_,
> +`Qualcomm's IQ6 product page`_, `Qualcomm's IQ8 product page`_,
> +`Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
>  
> +.. _Qualcomm's IQ2 product page: https://www.qualcomm.com/internet-of-things/products/iq2-series/iq-2390
>  .. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
>  .. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
>  .. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
> @@ -36,6 +38,12 @@ Configure the build for desired platform. This command creates the required
>  configuration files in the .output directory. Following gives command for each
>  platform (choose based on your platform):
>  
> +Generate the default configuration for the IQ-2 platform:
> +
> +.. code-block:: bash
> +
> +  $ make O=.output qcom_shikra_iqs_defconfig
> +
>  Generate the default configuration for the IQ-615 platform:
>  
>  .. code-block:: bash
> -- 
> 2.34.1
> 
> 
> 


