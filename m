Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F95C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6AD1889FF;
	Fri, 14 Jun 2024 14:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZjmdX8d+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20D1889F7; Fri, 14 Jun 2024 14:56:11 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E2988A00
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E8REe3015661;
 Fri, 14 Jun 2024 14:56:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=uBBWfijVmTi8IiEV1pe3Ua
 722q08Ybn7fKDA13vbftA=; b=ZjmdX8d+fy75Gm40Arhun5PAqoXXen65GDif1z
 iafHDFwCRvsHJff0KOAuAA7LtsIdNROTXHvagef4tjfbKrVybN1RJOWcKl7lB9uU
 SB+opd6Eg0Cd4RPdlRayiHkYD/sVNhjEfwrAoS/ZtI8O+0zFOQajd2gecjcdiILN
 P0DBFbCAGvNuC1UarL1QB/bi/uP5SNcOkMvlpKi8RbE6472NTD/6h/I9Em94U9/Y
 /+feZImYf8JVCNvx6sI7nMnj46+B/AWRVCEZ7l+G7HwZ2uOfnvf25eNuF1G6Mxso
 t3BLU3n3H0tXnKdbW0yPTuGIGizdI1wCzY2aquNSVkMBkDWg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp50v8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 14:56:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B15864002D;
 Fri, 14 Jun 2024 14:56:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6460921455D;
 Fri, 14 Jun 2024 14:55:51 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 14:55:50 +0200
Message-ID: <dcc64193-dc12-4deb-9224-48e60cee887c@foss.st.com>
Date: Fri, 14 Jun 2024 14:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2024.07 =
 u-boot-stm32-20240614
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: patrick DELAUNAY <patrick.delaunay@foss.st.com>, Marek Vasut
 <marex@denx.de>, <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_10,2024-06-14_03,2024-05-17_01
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

Hi Tom

Please pull the STM32 related fixes for u-boot/master, v2024.07: u-boot-stm32-20240614

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/21116

The following changes since commit ca6a992e09441d6cca73439c63c3735f86b36ea4:

  cmd: sound: fix help text (2024-06-13 09:31:56 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20240614

for you to fetch changes up to 55df13d930f4f191f458a6454f4b8e614e19c215:

  ARM: stm32: Fix livetree conversion on STM32MP15xx DHSOM (2024-06-14 13:25:06 +0200)

----------------------------------------------------------------
STM32MP1:
 _ Fix spl compilation warning
 _ Fix optee_get_reserved_memory()
 _ Fix livetree conversion on STM32MP15xx DHSOM

----------------------------------------------------------------
Marek Vasut (1):
      ARM: stm32: Fix livetree conversion on STM32MP15xx DHSOM

Patrice Chotard (2):
      stm32mp1: spl: Fix compilation warnings
      stm32mp1: spl: Update optee_get_reserved_memory() return value

 arch/arm/mach-stm32mp/stm32mp1/spl.c    |  4 ++--
 board/dhelectronics/dh_stm32mp1/board.c | 15 +++++++++++++--
