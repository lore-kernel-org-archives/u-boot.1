Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76205D0EE19
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 18:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2E588916;
	Fri, 11 Oct 2024 20:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="IwTuYjnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E681893D7; Fri, 11 Oct 2024 20:17:47 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92ED188881
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 20:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0014bb5f26=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BC8tOl019689;
 Fri, 11 Oct 2024 20:17:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 wbI7ehi6VmsCuN61BvZShBdMN5lf8Lhu1hpdpUpoHYk=; b=IwTuYjnJBH8WawPy
 jbCBNF7OBB/ntQFOIN4D4tW4f8f/RXPnNUK5ZQqlCD5kvGfHIMiyrwgv42dnFe+M
 QKBIGzUxd4aiHsL//xtfqYOv2MZF3lFyM8aq4lu3HOH7AZvs7Q/c5HKEzeZ6xtDW
 9fYEmPjZnUEhIV78lqoIwg2mRtFN7O5D98h3b9QhyEIMCE0KjxKQR04kIARoRo6J
 tOyoN+uup/QtuWUbxFZBzR9qugJP9Pk4E1+dOR0VJa0FmhSgiboQ8U8lo1EjDWEI
 SWRoVSf6mMJf4JC4yM3K2KmwLDD32q77aYEyfxw2a7lnRiElBJNdjHIjDj1lqKu7
 WmMsUw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 426343a9kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 20:17:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 93CF54005C;
 Fri, 11 Oct 2024 20:16:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C0612A438D;
 Fri, 11 Oct 2024 20:16:01 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 11 Oct
 2024 20:16:00 +0200
Message-ID: <55842cb0-5199-429a-8e92-5bac71dea67c@foss.st.com>
Date: Fri, 11 Oct 2024 20:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: dts: stm32: Generate u-boot.itb using binman
 on DH STM32 DHSOM
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241005011647.436456-1-marex@denx.de>
 <20241005011647.436456-3-marex@denx.de>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241005011647.436456-3-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

On 10/5/24 03:15, Marek Vasut wrote:
> Describe the u-boot.its generation in stm32mp15xx-dhsom-u-boot.dtsi
> binman {} DT node as a replacement for current CONFIG_SPL_FIT_SOURCE
> use, dispose of both u-boot-dhcom.its and u-boot-dhcor.its.
>
> Use fdt-SEQ/config-SEQ to generate a list of fdt-N fitImage images {} and
> matching configuration {} node entries. The configuration node entry names
> no longer encode _somrevN_boardrevN suffix, which was never really used, so
> drop this functionality by default. Rework board_fit_config_name_match() to
> match on the new configuration node entry names.
>
> Users who do need the match on _somrevN_boardrevN can either replace the
> fdt-SEQ/config-SEQ with fixed fdt-N/config-N nodes which each encode the
> matching 'description = "NAME_somrevN_boardrevN"' to restore the old
> behavior verbatim, or better use SPL DT overlays for U-Boot control DT
> the same way e.g. i.MX8MP DHCOM does to support multiple SoM and board
> variants.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: No change
> ---
>   arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi    |  1 +
>   arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi    |  1 +
>   arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi    | 53 +++++++++++
>   board/dhelectronics/dh_stm32mp1/board.c       | 19 +++-
>   .../dh_stm32mp1/u-boot-dhcom.its              | 91 -------------------
>   .../dh_stm32mp1/u-boot-dhcor.its              | 70 --------------
>   configs/stm32mp15_dhcom_basic_defconfig       |  2 -
>   configs/stm32mp15_dhcor_basic_defconfig       |  2 -
>   8 files changed, 70 insertions(+), 169 deletions(-)
>   create mode 100644 arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi
>   delete mode 100644 board/dhelectronics/dh_stm32mp1/u-boot-dhcom.its
>   delete mode 100644 board/dhelectronics/dh_stm32mp1/u-boot-dhcor.its
>

Nice,
I discover the binman FIT Substitutions with N / SEQ


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick




