Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEBEC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 09:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4271087D14;
	Wed,  6 Mar 2024 10:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BnSWv/E/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CAA887BCB; Wed,  6 Mar 2024 10:52:27 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C4987BD6
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 10:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3795981c04=christophe.kerello@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4269f08L003942; Wed, 6 Mar 2024 10:52:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=lKb7DZC
 nVJC102h5b6C81H9v3aY+MiNggEa12vjinEo=; b=BnSWv/E/TetqSMY/nyU+EhV
 GM1gLzfd8uGdYkQrrizKPr9qINkyZ4krmvi1yDUR7N3rzTppXu2Q84CrGhqZsNUd
 Cv0wgxUqn0Qj6FJsRLOOZvo/5jqL+Ez8xoC6ExnQcCmN5Zx/T44EAXGQv6JVM5no
 GPNh6NM41kIbz83jhnvwlNF9/Giptc6pfUdJRECB4BDajMDlWUh9C4Jv1SKIERQW
 A35VdA9xE5BHuiEDLjlP+l4xQPp4jU/tlhcIBMd90jrv1Gz1F3lCv9XFv1G/vfxe
 ZoFYkKYiejvxQff46itedsTxLVjSh7lg/l0GLQV3tlSvb44OFnRFgcpABjtfaAA=
 =
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wktdm9uyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 10:52:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5AC1F40045;
 Wed,  6 Mar 2024 10:52:13 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3C7662504E1;
 Wed,  6 Mar 2024 10:51:38 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Mar
 2024 10:51:37 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, Christophe Kerello
 <christophe.kerello@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Stefan Bosch <stefan_b@posteo.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/2] memory: stm32-fmc2-ebi: Add MP25 FMC2 support
Date: Wed, 6 Mar 2024 10:50:45 +0100
Message-ID: <20240306095048.314546-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.177]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_05,2024-03-05_01,2023-05-22_02
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

On MP1 SoC, RNB signal (NAND controller signal) and NWAIT signal (PSRAM
controller signal) have been integrated together in the SoC. That means
that the NAND controller and the PSRAM controller (if the signal is
used) can not be used at the same time. On MP25 SoC, the 2 signals can
be used outside the SoC, so there is no more restrictions.

MP1 SoC also embeds revision 1.1 of the FMC2 IP when MP25 SoC embeds
revision 2.0 of the FMC2 IP.


Christophe Kerello (2):
  memory: stm32-fmc2-ebi: add MP25 support
  memory: stm32-fmc2-ebi: add MP25 RIF support

 drivers/memory/stm32-fmc2-ebi.c | 449 +++++++++++++++++++++++++++++++-
 1 file changed, 437 insertions(+), 12 deletions(-)

-- 
2.25.1

