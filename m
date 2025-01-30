Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A932C0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E850C80805;
	Thu, 30 Jan 2025 14:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qkx6kiRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D077B820B0; Thu, 30 Jan 2025 14:26:33 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086A3807D9
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125fc93c8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCf03L009110;
 Thu, 30 Jan 2025 14:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 BP/ADTPoL6uYMx5mmwlc/0QFrAzrOXEvXlOycrh9zuE=; b=qkx6kiRWAGuNRZbE
 OAHV/uCQvZiOPa31WevssW2pNm0gycrYHf16iRJnyFxrNTLdF5xaOK/xGsBqFKwG
 T4faTkdWaS1+IY+SAkdbwlNGoIt+EKSzsJmHrhHCcBTtwuvewoX+Yoy6UIM3AMPq
 sLGN8uWFoIg/EEdvWEX/UBP31X5VkPO2qGLCuPkuTIJZV2fkI2iyH1+MiWFeGOOw
 BjEUCXLsqJf39FqapYRdL4ZPnliOD9q/sb+A7I+c1B8WEIGc358njQ4/g3EuCP5a
 f2lwDnOJ/JA1EThLtukqdgpBi3gN97xr4l6b2zhgOZy/5palqGVrKGR0uOochz2J
 kVCXkg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44g5jxsj4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 14:26:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EF49B40048;
 Thu, 30 Jan 2025 14:25:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 822113B3725;
 Thu, 30 Jan 2025 14:25:17 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 14:25:17 +0100
Message-ID: <26ecfad5-b3fa-43a6-bc6d-cb83b5197dc8@foss.st.com>
Date: Thu, 30 Jan 2025 14:25:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] configs: stih410-b2260: Enable USB_DWC3_GENERIC
 and USB_DWC3_STI flags
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
References: <20250123144718.1139824-1-patrice.chotard@foss.st.com>
 <20250123144718.1139824-6-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250123144718.1139824-6-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
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

Hi,

On 1/23/25 15:47, Patrice Chotard wrote:
> Enable USB_DWC3_GENERIC and USB_DWC3_STI flags.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
>
> (no changes since v1)
>
>   configs/stih410-b2260_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/stih410-b2260_defconfig b/configs/stih410-b2260_defconfig
> index e312ca492d2..4fcbf75548b 100644
> --- a/configs/stih410-b2260_defconfig
> +++ b/configs/stih410-b2260_defconfig
> @@ -61,6 +61,8 @@ CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_DWC3_STI=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_MCS7830=y


with CONFIG_USB_XHCI_STI = y (default in Kconfig)
you have 2 drvier for the same compatible now  = "st,stih407-dwc3"

can be solve with adding temporarily (up to next patch)

# CONFIG_USB_XHCI_STI is not set


Patrick


