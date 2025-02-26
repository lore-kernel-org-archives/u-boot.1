Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B41C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A92880F7B;
	Wed, 26 Feb 2025 07:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="eSiAfx15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A930480FBC; Wed, 26 Feb 2025 07:45:43 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16BFD80F56
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWv5O021595;
 Wed, 26 Feb 2025 06:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DJYdpFqgbw0rHOcS4ZDz8aOnOhVZVxQApez+oCV1T1Y=; b=eSiAfx15qiiKKiK4
 3S4VGmFO8HeDwZjMasshccXeSA9PGrWNHHgt6Wfl3OS9MWKcTtXKzsUEKClW7g/a
 daMhNJ4KnNS++Udta4d0yLgWpefVsRWhuoGq0Qn6i6jH/nYERjCAOi+S5RUTwo9K
 v/iqrTLcOkFYowhxweBurSjuloCTSnNUd9zo++O5LsfoEpPUYq0HgGDFuI+txvJa
 1TGptIXxJMenEHlhLElZuTyK+K8QNUDvWr7whOEhy8ZPhVY1AQjnjjp3Q62GpMWT
 crlHJ71U9+Gv1bQuJrh1c3u0EzhwzrXVMqCnjhudQfDyTgjad7p/be+Hn0UqKHa+
 dGgkxQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkh042-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q6jQP2001956
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:27 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 22:45:21 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v6 1/7] doc: board/qualcomm: document RDP building/flashing
Date: Wed, 26 Feb 2025 12:14:59 +0530
Message-ID: <20250226064505.1178054-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226064505.1178054-1-quic_varada@quicinc.com>
References: <20250226064505.1178054-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 64UmP4VF6AE_iG7WNjGwaHB6PoXEH1KW
X-Proofpoint-ORIG-GUID: 64UmP4VF6AE_iG7WNjGwaHB6PoXEH1KW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260052
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

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add 'Reviewed-by: Caleb Connolly'
---
 doc/board/qualcomm/rdp.rst | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 doc/board/qualcomm/rdp.rst

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
new file mode 100644
index 0000000000..fd14f1d982
--- /dev/null
+++ b/doc/board/qualcomm/rdp.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. sectionauthor:: Varadarajan Narayanan <quic_varada@quicinc.com>
+
+Qualcomm Reference Design Platform (RDP)
+========================================
+
+Qualcomm RDPs are development boards based on the Qualcomm IPQ series of
+SoCs. These SoCs are used as the application processors in WiFi router
+platforms. RDPs come in multiple variants with differences in storage
+medium (NOR, NAND, MMC), no. of USB and PCIe ports, n/w ports etc.
+
+.. _Qualcomm's product page: https://www.qualcomm.com/products/internet-of-things/networking/wi-fi-networks/networking-pro-series/qualcomm-networking-pro-820-platform
+
+Installation
+------------
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make qcom_ipq9574_mmc_defconfig
+  $ make -j8
+
+This will build ``u-boot.elf`` in the configured output directory.
+
+Although the RDPs do not have secure boot set up by default, the firmware still
+expects firmware ELF images to be "signed". The signature does not provide any
+security in this case, but it provides the firmware with some required metadata.
+
+To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+
+  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+
+Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
+on your device with::
+
+  IPQ9574# tftpboot path/to/u-boot.mbn
+  IPQ9574# mmc part (note down the start & end block no.s of '0:APPSBL' partition)
+  IPQ9574# mmc erase <start blk no> <count>
+  IPQ9574# mmc write $fileaddr <blk no> <count>
+
+U-Boot should be running after a reboot (``reset``).
+
+.. WARNING
+	Boards with newer software versions would automatically go the emergency
+	download (EDL) mode if U-Boot is not functioning as expected. If its a
+	runtime failure at Uboot, the system will get reset (due to watchdog)
+	and XBL will try to boot from next bank and if Bank B also doesn't have
+	a functional image and is not booting fine, then the system will enter
+	EDL.  A tool like bkerler's `edl`_ can be used for flashing with the
+	firehose loader binary appropriate for the board.
+
+	Note that the support added is very basic. Restoring the original U-Boot
+	on boards with older version of the software requires a debugger.
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _edl: https://github.com/bkerler/edl
-- 
2.34.1

