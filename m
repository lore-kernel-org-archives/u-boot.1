Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D161DC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C4C80F4E;
	Tue, 18 Feb 2025 09:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="IDz9xfKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246E080BAE; Tue, 18 Feb 2025 09:55:20 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E47380BAD
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I2m6fT003648;
 Tue, 18 Feb 2025 08:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YHOThmve5T/9VY5ncFn1J7xvl8+eis46PEgwZX8sLCo=; b=IDz9xfKcrEGBuYTY
 AB7/eaQoYAsfbwJXXfFv9PNXr8u0yy5NpMITyGVIDM73ezvRgIoCVeMqGta5YWjt
 wRZsPgyXth34+V3G874qa+Y3UN3MUZe0UCsCVHN0K7aLiylPHmGpGx2pMabhfQj7
 HW1IxQml8FdFTRP/SY05s9Ufm5GfoDGySN97DHKe+rzi4cNJAMWHVUwWFrBM+sHf
 tAxmedNyE0S7qLlKz9AjOjkQJzsHsuPr2wwHp8ganQomg44uNToqkj5PtJre7UYp
 8P8uqE6OrQlUy4vZ6TPqfZ+je+eitxTjxZUeNdZse5AWeUJnQ0lq41Nlqrzwcx+n
 4g0SKA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7s47h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 08:54:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51I8sspO028613
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 08:54:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Feb 2025 00:54:49 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <Volodymyr_Babchuk@epam.com>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v3 1/8] doc: board/qualcomm: document RDP building/flashing
Date: Tue, 18 Feb 2025 14:24:23 +0530
Message-ID: <20250218085430.2422287-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218085430.2422287-1-quic_varada@quicinc.com>
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: xE_sehMR_x102fFOSSeZ73lbiMn1SZAM
X-Proofpoint-ORIG-GUID: xE_sehMR_x102fFOSSeZ73lbiMn1SZAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180068
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

Introducing basic support for Qualcomm IPQxxx based RDPs.
Document the build and flashing steps.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 doc/board/qualcomm/rdp.rst | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index b51b495e4f..f6ea689b91 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -1,24 +1,21 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0
 .. sectionauthor:: Varadarajan Narayanan <quic_varada@quicinc.com>
 
 Qualcomm RDP
 ============
 
-The Qualcomm RDPs are development boards based on the Qualcomm IPQ series of
+Qualcomm RDPs are development boards based on the Qualcomm IPQ series of
 SoCs. These SoCs are used as the application processors in WiFi router
 platforms. RDPs come in multiple variants with differences in storage
 medium (NOR, NAND, MMC), no. of USB and PCIe ports, n/w ports etc.
-More information can be found on `Qualcomm's product page`_.
-
-.. _Qualcomm's product page: https://www.qualcomm.com/developer/hardware/rb3-gen-2-development-kit
 
 Installation
 ------------
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
 
-  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
-  $ make qcom_ipq9574_mmc_defconfig
-  $ make -j8
+	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
+	$ make qcom_ipq9574_mmc_defconfig
+	$ make -j8
 
 This will build ``u-boot.elf`` in the configured output directory.
 
@@ -28,20 +25,29 @@ security in this case, but it provides the firmware with some required metadata.
 
 To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
 
-  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+	$ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
 
 Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
 on your device with::
 
-  => tftpboot path/to/u-boot.mbn
-  => mmc part (and note down the start & end of '0:APPSBL' partition)
-  => mmc erase <blk no> <count>
-  => mmc write $fileaddr <blk no> <count>
+	=> tftpboot path/to/u-boot.mbn
+	=> mmc part (and note down the start & end of '0:APPSBL' partition)
+	=> mmc erase <blk no> <count>
+	=> mmc write $fileaddr <blk no> <count>
 
 U-Boot should be running after a reboot (``reset``).
 
 .. WARNING
+	Boards with newer software versions would automatically go the emergency
+	download (EDL) mode if U-Boot is not functioning as expected. If its a
+	runtime failure at Uboot, the system will get reset (due to watchdog)
+	and XBL will try to boot from next bank and if Bank B also doesn't have
+	a functional image and is not booting fine, then the system will enter
+	EDL.  A tool like bkerler's `edl`_ can be used for flashing with the
+	firehose loader binary appropriate for the board.
+
 	Note that the support added is very basic. Restoring the original U-Boot
-	without a debugger is almost impossible.
+	on boards with older version of the software requires a debugger.
 
 .. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _edl: https://github.com/bkerler/edl
-- 
2.34.1

