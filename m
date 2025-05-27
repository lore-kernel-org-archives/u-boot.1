Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D5AC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82CD83754;
	Tue, 27 May 2025 15:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="sNG4vBBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D013A83818; Tue, 27 May 2025 15:52:15 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70870830AB
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCVGGW027975;
 Tue, 27 May 2025 15:52:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 HqqQvAXFKZGzFciPAZOlqzuMi0AVtMR9/VXrPaCoAVE=; b=sNG4vBBaFReSkOyt
 Cn00iqFZFE926gMOitbv6nQMt7I8+fMp1Yq6p/mxPWHz1o6HR12fN15BtCCgerNx
 gT+W3NfX3GHoT4f3LTwvkKAMBhgzyczJuGT7ftAGUR1fsvs6nLvlEO0y1f/NyQO2
 HAskMsVBf08yeXZO37XMFPdK+0qQqehh22+ddlAwUYW+wQ1BuwiByp+xJVa87t0a
 7rmZVzKWVB6/Q/MHIHtaejGxApR6+IUeypX8rmFXn0Ev6Dv3Q5zlzDSicsszFvBj
 YN4De9uNJpIWMoy9ow2axQGtUe0M3NPuJ2N32yEFFfPO3G5fHS/kf90c+CnmRD7+
 6+2Hug==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46uqp4j8bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:52:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 690E540050;
 Tue, 27 May 2025 15:51:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DF63AF294C;
 Tue, 27 May 2025 15:51:09 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:51:09 +0200
Message-ID: <81c46671-3cb5-4ad6-8d49-bc4b3b497352@foss.st.com>
Date: Tue, 27 May 2025 15:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] add STM32H747 discovery board
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-1-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-1-johannes@krotti42.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_07,2025-05-27_01,2025-03-28_01
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



On 5/8/25 23:23, Johannes Krottmayer wrote:
> These patch series adds support for the STM32H747 discovery
> board from STMicroelectronics.
> 
> Johannes Krottmayer (10):
>   arm: mach-stm32: stm32h7: add initial lowlevel early function
>   arm: mach-stm32: stm32h7: add initial Makefile
>   arm: mach-stm32: stm32h7: add STM32H747-DISCO board
>   arm: mach-stm32: add stm32h7 subdirectory
>   board: st: add STM32H747 discovery board
>   configs: add STM32H747 discovery board
>   include: configs: add STM32H747 discovery board
>   arm: dts: add STM32H747 discovery board
>   dts: upstream: arm: st: add STM32H747 discovery board
>   dts: upstream: arm: st: stm32h7-pinctrl: change pins for USART1
> 
>  arch/arm/dts/stm32h747i-disco-u-boot.dtsi    | 101 ++++++++++++++++
>  arch/arm/mach-stm32/Makefile                 |   2 +
>  arch/arm/mach-stm32/stm32h7/Kconfig          |   5 +
>  arch/arm/mach-stm32/stm32h7/Makefile         |   6 +
>  arch/arm/mach-stm32/stm32h7/lowlevel.S       |  45 ++++++++
>  board/st/stm32h747-disco/Kconfig             |  15 +++
>  board/st/stm32h747-disco/MAINTAINERS         |   8 ++
>  board/st/stm32h747-disco/Makefile            |  10 ++
>  board/st/stm32h747-disco/stm32h747-disco.c   |  43 +++++++
>  configs/stm32h747-disco_defconfig            |  35 ++++++
>  dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi |   4 +-
>  dts/upstream/src/arm/st/stm32h747i-disco.dts | 115 +++++++++++++++++++
>  include/configs/stm32h747-disco.h            |  37 ++++++
>  13 files changed, 424 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi
>  create mode 100644 arch/arm/mach-stm32/stm32h7/Makefile
>  create mode 100644 arch/arm/mach-stm32/stm32h7/lowlevel.S
>  create mode 100644 board/st/stm32h747-disco/Kconfig
>  create mode 100644 board/st/stm32h747-disco/MAINTAINERS
>  create mode 100644 board/st/stm32h747-disco/Makefile
>  create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
>  create mode 100644 configs/stm32h747-disco_defconfig
>  create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts
>  create mode 100644 include/configs/stm32h747-disco.h
> 


The patches 1/2/3/4/5 and 7 can be merged together.

Thanks
patrice
