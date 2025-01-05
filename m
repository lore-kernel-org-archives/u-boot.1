Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2148CE77198
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C067805D6;
	Sun,  5 Jan 2025 23:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115143;
	bh=zybS/Ja+SPeZ+UiMPUoMMlt4iYEwc+jGefpgQ4ymM8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IJSTHXiOcWPxWs2gsYk4pvGm4uCkW0GQf4Dr8NTZJ7xXCDQrKwxiGgKkqyFuQ7XnV
	 plOFvklx0+FcH/83Jcv5jNcmHtLy+GBHq3C74jHSBtF5fKsZeAwLQ8mI5Ff21DObEq
	 +bTd1+gboZf3FhCg2hCphPl79DVxvw5f9gMsMQtuSqq8I9C76yxcKhlLTxyrx/6v21
	 /VxsNUrIkcvunfmbXPiN3vK+s5XAeNAINxPbNxkWNVB7Sj0/PQ0BfrJbEfmasCQ3zV
	 x0AIrVLL0eefNnCdKqKJhr0XoKZm7/CRmy37VOveXIYD9j36H9xQVUxKnXXd1Z8eJ7
	 MEwSHCtPIBgjA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB58801E8; Sun,  5 Jan 2025 23:12:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E369D801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="a3AZ3C/U"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48981101D23BB; Sun,  5 Jan 2025 23:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zybS/Ja+SPeZ+UiMPUoMMlt4iYEwc+jGefpgQ4ymM8k=;
 b=a3AZ3C/UxRlJuf0wtotGPF7EHOpPutKpzztrvW29vRLUZSrDVbE9aRbNpjGn5QMpW7JUbY
 KmywAOpthKoL+N9cUbLSFENUNKKQOokGwOVcdaNEC/tGh15vtuj1BLoMAjmxJ42fxAAPZB
 cm+6mz09vFbLaYb0vVWcLajomlaT5wvy2+9S/mi9sIEIMhjKwCBT/yp2RELh6Rf4oESeXK
 RPBoDQ3GV2GFDq62RJhUGA3SkqnzDJHSUO1a4XlYCpV6H9fcNAGebwISZveEiqoZsVnQaj
 htgDVN4syu1KKa7/jjqlUYri+648wLWec8MKMm359HMrgSsvMzt48Zpmv7gNxw==
Message-ID: <9dae98e4-e471-4f37-a810-dc6ac4a190da@denx.de>
Date: Sun, 5 Jan 2025 22:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/17] imx9: add i.MX95 Kconfig and Makefile
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-10-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-10-6744df5dc020@oss.nxp.com>
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm/mach-imx/imx9/Kconfig  |  6 ++++++
>   arch/arm/mach-imx/imx9/Makefile | 11 ++++++++---
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index 54c6b117fcff21be5c3800ebd1dc30f8ea12ac42..596e753f2897c11d7ca3bcc9211af786d005bfd9 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -21,6 +21,12 @@ config IMX91
>   	select IMX9
>   	select ARMV8_SPL_EXCEPTION_VECTORS
>   
> +config IMX95
> +	bool
> +	select IMX9
> +	select ARMV8_SPL_EXCEPTION_VECTORS
> +	select SCMI_FIRMWARE
> +	select DM_MAILBOX
>   
>   config SYS_SOC
>   	default "imx9"
> diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
> index 45a9105a75a558dada3c328ed0878050da2a41e1..8d43ea2b267e2608df2e8f140c91b626dd969842 100644
> --- a/arch/arm/mach-imx/imx9/Makefile
> +++ b/arch/arm/mach-imx/imx9/Makefile
> @@ -1,10 +1,15 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
> -# Copyright 2022 NXP
> +# Copyright 2024 NXP
2022-2024
