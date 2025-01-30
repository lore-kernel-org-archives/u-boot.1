Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB318C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 12:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD3681F69;
	Thu, 30 Jan 2025 13:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="AjIwKycF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A851382012; Thu, 30 Jan 2025 13:59:11 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB73F80E9A
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 13:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125fc93c8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCfFX9029988;
 Thu, 30 Jan 2025 13:59:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 YRMcJ2yiOC1lRh2ptmhHc/DjcsqxSEXYkMogzrKAEeE=; b=AjIwKycFNHneIakR
 TWLP3ZWfCgoXDjWZ8smTKsktlNm7prwJ52YKc8hs431xnfGV9iDyiBj7ngCSuf3p
 WuRiiH+P+b1n4nAuVAtROdvIyMyedIj6sRKYVUMg9JnGHs3iExBD6XspmUfpkEez
 hMsKr/hPX7X/dleGzK7bEoaNc5e9oWBbZFzt2kHHgRj6/n0hfIzdyy+exAFNDRcm
 ilc62Ke/AuqQv7bbnLaqK6WwAPtAULuJaj6zGJO8zJFZIby9IpvEWzHuLCWbhB/g
 6/SH7KJq3GQTmPjetdFCXEnFb/3AYE4Mg2SWrucdKfkV0wwYGKG28MoXZVJLlAoI
 ypQ8mg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44fy472du4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 13:59:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ACD2040052;
 Thu, 30 Jan 2025 13:58:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BDF463BECF8;
 Thu, 30 Jan 2025 13:56:08 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:56:08 +0100
Message-ID: <dc9dbd62-3eaa-43bb-805c-a3b5f2b9bd60@foss.st.com>
Date: Thu, 30 Jan 2025 13:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] ARM: dts: sti: Add fixed clock for ehci and ohci
 nodes in stih410-b2260.dtsi
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
References: <20250123144718.1139824-1-patrice.chotard@foss.st.com>
 <20250123144718.1139824-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250123144718.1139824-2-patrice.chotard@foss.st.com>
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
> On STi platforms, all clocks are enabled by BOOTROM, so CONFIG_CLK is
> not set as no clock driver for STI exists.
>
> As ehci-generic and ohci-generic drivers are used on platforms where
> CONFIG_CLK is set, clk_get_bulk() returns-ENOSYS in case of
> stih410-b2260.
> To avoid this error, add fixed clocks for ehci and ohci nodes for
> stih410-b2260 to fix the following errors:
>
> Bus usb@9a03c00: ohci_generic usb@9a03c00: Failed to get clocks (ret=-19)
> Port not available.
> Bus usb@9a03e00: ehci_generic usb@9a03e00: Failed to get clocks (ret=-19)
> Port not available.
> Bus usb@9a83c00: ohci_generic usb@9a83c00: Failed to get clocks (ret=-19)
> Port not available.
> Bus usb@9a83e00: ehci_generic usb@9a83e00: Failed to get clocks (ret=-19)
> Port not available.
> scanning bus dwc3@9900000 for devices... 1 USB Device(s) found
>         scanning usb for storage devices... 0 Storage Device(s) found
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
>
> (no changes since v1)
>
>   arch/arm/dts/stih410-b2260-u-boot.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


