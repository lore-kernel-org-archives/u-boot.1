Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEE7C2BA18
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E59088271;
	Mon, 17 Jun 2024 15:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="xGXmNl2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AF3882DA; Mon, 17 Jun 2024 15:42:57 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A90CE87DC7
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-62a2424ed00so49799707b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1718631774; x=1719236574;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTViHcwy6BA6SCagk5F56BNMcN1f1lkGp2l6eZqagko=;
 b=xGXmNl2wlqPZ3dx6tjbKQ9aAjt++bvVmeiTEZ/BR551j6UciKBDQ4UBiRkl+l01K2X
 KuJLoU+FKfRTOlqaC7YoR0wOZivu09nGQ+kZtpjeSSwySlFQh1racULACpDvTkC6MXja
 zVAb1T8wDWCyhcZxWpPdS+DZY60vEb6vpfzuosehK7fXOMvTL1D6G1XO4hBdk0uGAaCt
 P8LhvN1c/WVBCxJ3xwpfocYxGMzgdIHQR/AcFjFlNOjTOT3kcxYH9RCnmlz/GaqjA1dk
 DbDPmMMcjIInIUVeTo7x1LgB5FF/H2Hs7YmtPD7HudMdaC62F50s8MFIBAkHHkANN3jZ
 ny5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718631774; x=1719236574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTViHcwy6BA6SCagk5F56BNMcN1f1lkGp2l6eZqagko=;
 b=J1ePJkQ6xKKlwP+AN6sKYdmvesT5/CF/l9Cj5VO5iZ6B3dsA2ooKxJnQg/rFh1DWPR
 2s2dtHro0JjMF4cM++J5VM5cfJJ3noAi6HRVEDM/XLG5FhAPioAjAaSag/cztW2EPRtZ
 QcOG7XSktJ3e6yYr8v3jc5BnLUmZa2yMrR948gD4E72QBQ+a0Fr0DRHYczS06dmrCPdj
 EQxMY/SUkKyIRciWaoN+REsZC+PQc82BWSA1xS57Fy8eACJqB7Cul/mnLbmZPXOPiUJP
 LabmOJ7RyTbii8SqnzrfgDUmW9oUsfm+ZMvx0C+R8k/CVG5ZwRtkAzf/IDW2EuNI9veL
 K8nQ==
X-Gm-Message-State: AOJu0Ywk8N2BqF3G74pu9tQyR5ViBwZYQ0JSsAXLiIWimzZm8bTOsLWs
 BV6UpAzbvjZMlCVx5OYo9kqyIZCq2qX3kGuQK58ZukloRRLhtpExXS+dm5PtdJCGAsWWqUG0jSm
 oRH3tGMCK0FepGx6lDt2WtXmZqcnnor4RQS8D
X-Google-Smtp-Source: AGHT+IHxPK6a7w6M5mqJSFbiZh3b+jQ3N7PiWDOL5n+CxOeq6Entf65M4tZqGylctyZYgcO7SAgGbjHvbWOW80SVKHU=
X-Received: by 2002:a25:ae0f:0:b0:dfd:bd4d:c0d3 with SMTP id
 3f1490d57ef6-dff154cb4d9mr8621674276.58.1718631774467; Mon, 17 Jun 2024
 06:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <5a850b1558fad0f05c61de82110abe4c0e7fd2e4.1718104009.git.michal.simek@amd.com>
In-Reply-To: <5a850b1558fad0f05c61de82110abe4c0e7fd2e4.1718104009.git.michal.simek@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 17 Jun 2024 15:42:42 +0200
Message-ID: <CAHTX3dJimxxWZFgf979TYxnQjba5yL9QvTcUPXrC9KjuUr_LFA@mail.gmail.com>
Subject: Re: [PATCH] xilinx: Enable FF-A for all our arm64 SoCs
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Simon Glass <sjg@chromium.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=C3=BAt 11. 6. 2024 v 13:07 odes=C3=ADlatel Michal Simek <michal.simek@amd.=
com> napsal:
>
> Enable FFA_TRANSPORT which also enable FFA command.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  configs/amd_versal2_virt_defconfig       | 1 +
>  configs/xilinx_versal_net_virt_defconfig | 1 +
>  configs/xilinx_versal_virt_defconfig     | 1 +
>  configs/xilinx_zynqmp_kria_defconfig     | 1 +
>  configs/xilinx_zynqmp_virt_defconfig     | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_vir=
t_defconfig
> index 6e4adddf2c02..2d611f84cd93 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -73,6 +73,7 @@ CONFIG_TFTP_BLOCKSIZE=3D4096
>  CONFIG_CLK_CCF=3Dy
>  CONFIG_CLK_SCMI=3Dy
>  CONFIG_DFU_RAM=3Dy
> +CONFIG_ARM_FFA_TRANSPORT=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_CADENCE=3Dy
>  CONFIG_I2C_MUX=3Dy
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_ve=
rsal_net_virt_defconfig
> index d9e2e050ceb6..c869450e119f 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -72,6 +72,7 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=3Dy
>  CONFIG_TFTP_BLOCKSIZE=3D4096
>  CONFIG_CLK_VERSAL=3Dy
>  CONFIG_DFU_RAM=3Dy
> +CONFIG_ARM_FFA_TRANSPORT=3Dy
>  CONFIG_ZYNQ_GPIO=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_CADENCE=3Dy
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal=
_virt_defconfig
> index 95a671db363e..5dd5fb1c5477 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -74,6 +74,7 @@ CONFIG_CLK_VERSAL=3Dy
>  CONFIG_DFU_TIMEOUT=3Dy
>  CONFIG_DFU_RAM=3Dy
>  CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x1800000
> +CONFIG_ARM_FFA_TRANSPORT=3Dy
>  CONFIG_FPGA_XILINX=3Dy
>  CONFIG_FPGA_VERSALPL=3Dy
>  CONFIG_DM_I2C=3Dy
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp=
_kria_defconfig
> index ba42f0c78485..69a5468f6fb0 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -134,6 +134,7 @@ CONFIG_USB_FUNCTION_FASTBOOT=3Dy
>  CONFIG_FASTBOOT_FLASH=3Dy
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=3D0
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
> +CONFIG_ARM_FFA_TRANSPORT=3Dy
>  CONFIG_FPGA_XILINX=3Dy
>  CONFIG_FPGA_ZYNQMPPL=3Dy
>  CONFIG_GPIO_HOG=3Dy
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp=
_virt_defconfig
> index 9a71fce4c3c4..396bff927dd4 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -134,6 +134,7 @@ CONFIG_USB_FUNCTION_FASTBOOT=3Dy
>  CONFIG_FASTBOOT_FLASH=3Dy
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=3D0
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
> +CONFIG_ARM_FFA_TRANSPORT=3Dy
>  CONFIG_FPGA_XILINX=3Dy
>  CONFIG_FPGA_ZYNQMPPL=3Dy
>  CONFIG_GPIO_HOG=3Dy
> --
> 2.40.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
