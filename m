Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27D0C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 10:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 444538801E;
	Fri,  8 Mar 2024 11:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7NQXmeoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DD88800D; Fri,  8 Mar 2024 11:23:34 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F048801E
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 11:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3797bb48b6=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4288iql1022305; Fri, 8 Mar 2024 11:23:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=gn0GYiaINOi35h2Pd8CbX/2hxz+FSVbpx6rr2mvue9o=; b=7N
 QXmeojetjA+ZXfootDfDzCMjrhJYMYW28IhJt6avzJS/JRRCX8q91ifP+18b8Hnk
 SB309XrEgBFmPEreys35bweHvavnqMd6EO5GzbYchjlgpEnoXkqc4GQHHAhXyhP+
 mvmdNxKsYNPu+2cpo2g6Bwb93G2c278Fd5akkg+955WzvUW355kuy35KGZRtZfIa
 XmV5Z4voG/fVoL+yAE1GFvTfpMrcPwtTo98bQLIe+785A2cWI9mEW8E5DkuTwtgH
 K4mJ7s1NWrKKjAk+ILq+WSQvQQiFQTp6hceS27pvxoafEMhPjlUyrkI/upDLlCJ5
 S4+kajKmisjlhngj822Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wn87txb6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:23:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1A39040045;
 Fri,  8 Mar 2024 11:23:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 111B725F7C8;
 Fri,  8 Mar 2024 11:23:02 +0100 (CET)
Received: from [10.252.7.115] (10.252.7.115) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 11:23:01 +0100
Message-ID: <365fd907-655f-4860-9e2b-dfdb338353f3@foss.st.com>
Date: Fri, 8 Mar 2024 11:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: stm32: Enable OHCI HCD support on STM32MP15xx DHSOM
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240304182553.106321-1-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240304182553.106321-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.7.115]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_07,2024-03-06_01,2023-05-22_02
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



On 3/4/24 19:25, Marek Vasut wrote:
> The OHCI HCD is mandatory for USB 1.1 FS/LS device support, enable it.
> This used to be enabled implicitly before, now that implicit dependency
> disappeared and this got disabled. Enable it manually.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  configs/stm32mp15_dhcom_basic_defconfig | 2 ++
>  configs/stm32mp15_dhcor_basic_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
> index 1d241529be7..0bfd3b76d6a 100644
> --- a/configs/stm32mp15_dhcom_basic_defconfig
> +++ b/configs/stm32mp15_dhcom_basic_defconfig
> @@ -164,6 +164,8 @@ CONFIG_DM_USB_GADGET=y
>  CONFIG_SPL_DM_USB_GADGET=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC2=y
>  CONFIG_USB_HOST_ETHER=y
>  CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
> index 6e0c4a8cf9f..1c1fbc5c7db 100644
> --- a/configs/stm32mp15_dhcor_basic_defconfig
> +++ b/configs/stm32mp15_dhcor_basic_defconfig
> @@ -164,6 +164,8 @@ CONFIG_DM_USB_GADGET=y
>  CONFIG_SPL_DM_USB_GADGET=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC2=y
>  CONFIG_USB_HOST_ETHER=y
>  CONFIG_USB_ETHER_ASIX=y


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
