Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EB0D0D7BC
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0743789371;
	Fri, 11 Oct 2024 17:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="w0+geUhI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1B789319; Fri, 11 Oct 2024 17:36:39 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA05D89371
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0014bb5f26=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCWSqC028698;
 Fri, 11 Oct 2024 17:36:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 7/4XOOK+bH2qrJUGAgRxY2c0zKBSNHXf5f1yNxX1Uv0=; b=w0+geUhI7L2W85n2
 QUVguglPeN6qp8FFSH+fOq+nMHfm/Zi09stMQxE9VFO3D8sYntJm++keNlItdMq1
 vaCT/z6tY+Seqp0pno1H2J1M1REbeaCdx/DKNkszq/+kPsa+WgBIN95tmCrnffi+
 uwij9J7M8qlwl838SOw8jEVArh5CbpnQHq8JC0zHqaKjJVhlcm/R+CuidyDg4G5C
 T0jppb1W9XlwD0dWZQ/Kl9KRtrFgu8ZBtoLBSwe5v5AdpLGuautCR10vKNtGKxSp
 /h+qzHdpvQSUv+iXVMeVZCRJGk0I8d5veLhaE9oJ0AHbVU6w/Nr+fNzDSwds8Wma
 fkjn8g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4263439swd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 17:36:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D018240057;
 Fri, 11 Oct 2024 17:35:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1FFF228C106;
 Fri, 11 Oct 2024 17:32:28 +0200 (CEST)
Received: from localhost (10.48.86.243) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 11 Oct
 2024 17:32:27 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Etienne CARRIERE <etienne.carriere@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Vikas Manocha <vikas.manocha@st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/4] doc: clarify scmi device tree for stm32mp15 boards
Date: Fri, 11 Oct 2024 17:31:50 +0200
Message-ID: <20241011173140.3.I62101ff6150618cf00b69bb9c5c8ce84eab7ecf7@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011153152.1637303-1-patrick.delaunay@foss.st.com>
References: <20241011153152.1637303-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Clarify the usage of SCMI specific device tree to use with
stm32mp15_defconfig and with OP-TEE.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 doc/board/st/stm32mp1.rst | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
index 63b44776ffc1..8cf712992336 100644
--- a/doc/board/st/stm32mp1.rst
+++ b/doc/board/st/stm32mp1.rst
@@ -180,22 +180,41 @@ Each STMicroelectronics board is only configured with the associated device tree
 
 STM32MP15x device Tree Selection
 ````````````````````````````````
-The supported device trees for STM32MP15x (stm32mp15_trusted_defconfig and stm32mp15_basic_defconfig) are:
+The supported device trees for STM32MP15x (**stm32mp15_defconfig** for TF-A_
+with FIP support) are:
 
 + ev1: eval board with pmic stpmic1 (ev1 = mother board + daughter ed1)
 
+   + **stm32mp157c-ev1-scmi**
    + stm32mp157c-ev1
 
 + ed1: daughter board with pmic stpmic1
 
+   + **stm32mp157c-ed1-scmi**
    + stm32mp157c-ed1
 
 + dk1: Discovery board
 
+   + **stm32mp157a-dk1-scmi**
    + stm32mp157a-dk1
 
 + dk2: Discovery board = dk1 with a BT/WiFI combo and a DSI panel
 
+   + **stm32mp157c-dk2-scmi**
+   + stm32mp157c-dk2
+
+The scmi variant of each device tree is only supported with OP-TEE as secure
+monitor and it is the configuration **recommended** by STMicroelectronics for
+product, with secured system resources (RCC_TZCR.TZEN=1).
+
+The supported device trees for STM32MP15x (stm32mp15_trusted_defconfig
+TF-A without FIP support and stm32mp15_basic_defconfig with SPL) are:
+
++ the same STMicroelectronics boards with the no scmi device tree files:
+
+   + stm32mp157c-ev1
+   + stm32mp157c-ed1
+   + stm32mp157a-dk1
    + stm32mp157c-dk2
 
 + avenger96: Avenger96 board from Arrow Electronics based on DH Elec. DHCOR SoM
@@ -204,11 +223,11 @@ The supported device trees for STM32MP15x (stm32mp15_trusted_defconfig and stm32
 
 STM32MP13x device Tree Selection
 ````````````````````````````````
-The supported device trees for STM32MP13x (stm32mp13_defconfig) are:
+The supported device trees for STM32MP13x (**stm32mp13_defconfig**) are:
 
 + dk: Discovery board
 
-   + stm32mp135f-dk
+   + **stm32mp135f-dk**
 
 
 Build Procedure
-- 
2.25.1

