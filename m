Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A04FC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EEA800C2;
	Wed, 15 Jan 2025 11:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="8VD8iVa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B891980214; Wed, 15 Jan 2025 11:19:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD31880027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3110841290=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FA4cH6027205;
 Wed, 15 Jan 2025 11:19:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=98GOkwBuEZSca8hLRFnO4C
 NuKsnU9VPd58vegLmbtEQ=; b=8VD8iVa5DZdsN/voc2kvzRsnklxvW0RcFmwu4g
 o+hORREkbBVAH8eL4hD5WZdX6aAXTCaozuwa0wdEbB8WmA5pYlnB64oNpuVrCi4F
 h0lAv0PQrNg3QA6ZTevd9V0fsh/X4A+4h2K8gjpyyEVm9BloI2eRER/jr+uagS90
 RlHbAdLT0LXs9zF+RzU7XwPmzotzBM4xT69vp1Kq07PN9yXWU6CS2GRxlXmTV2kq
 WKD/izDEpm0g9WWW+AWPgfoUXWbNKJAhi9oK+rK38U2QgKyo4ssyyAXut8ld7Grg
 /C92f824qN3Fz91VpbeQW9aBhP1SQJGVnlmGe0KhmZGhmCWw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4465wehcx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 11:19:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 94A3340048;
 Wed, 15 Jan 2025 11:18:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3CF924B1B9;
 Wed, 15 Jan 2025 11:18:47 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 15 Jan
 2025 11:18:47 +0100
Message-ID: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
Date: Wed, 15 Jan 2025 11:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: dtc: "syntax error" linked to &{label/subnode} syntax
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
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

Hi

I am currently converting STM32MP platforms to OF_UPSTREAM.
As we use same binary for several boards, flags CONFIG_OF_UPSTREAM_BUILD_VENDOR=y 
and CONFIG_OF_UPSTREAM_VENDOR="st" are set.

So all dts/upstream/src/arm/st/* dts files are compiled.

I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-prtt1* and 
dts/upstream/src/arm/st/stm32mp15*-mec*.* files.

To be more precise, these files are using a syntax which follows this 
format &{label/subnode} to override some nodes.

This leads to DTC error: 

 AR      drivers/usb/gadget/built-in.o
  LD      u-boot
  OBJCOPY u-boot.srec
  OBJCOPY u-boot-nodtb.bin
  SYM     u-boot.sym
  DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
  DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
  DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb
  DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
  DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
  DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
  DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.dtb
  DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338.1-2 syntax error
FATAL ERROR: Unable to parse input tree


At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi we got :

&{qspi_bk1_pins_a/pins} {
	pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
		 <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
		 <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
		 <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
	/delete-property/ bias-disable;
	bias-pull-up;
};

If i update it as following , the DTC compilation is OK :

&qspi_bk1_pins_a {
	pins {
		pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
			 <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
			 <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
			 <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
		/delete-property/ bias-disable;
		bias-pull-up;
	};
};

On kernel side, the DTC compilation is ok, but not on U-Boot side. I am not able to understand the difference.

Thanks
Patrice
