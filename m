Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAEBC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 06:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114B480F56;
	Tue, 25 Feb 2025 07:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="DsNzUk7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7B580EC0; Tue, 25 Feb 2025 07:53:40 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C4C80EC0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 07:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOGDW009083;
 Tue, 25 Feb 2025 06:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qe+D5gREU3ZBNyjlwn17zCeoi96Klp6b/DOyvRjIPFU=; b=DsNzUk7xPK4YS2kq
 AWTc1xhPKivEVN0gPAEvpNkQGr6exGkqCZXapl3TY9jG4VI1y/D9MxIm5FSDgx7a
 Yq1WOKwf6h4DQSEoK/umZll+VM2cCEX4xYjTGN/umpRhsv+FmpQiHQMgLP6c37C7
 gVY3zO4Afb/2AQ82GODRs7qAZTbJD0+x/5h/lFPMwjOVMVNUDPdEDo0cd9gTMbh7
 VENco42Kcix89rKLJ4AFjsCk3dTvWQuWt53Kh1HiVJfU/bto64b9moFjjEqi7Onl
 or02Mf5qdEZHzxyUT4sHbRKyZPGhE53h5SvN1GzhcQL6hb3fR62rZLB7pVpuJL/1
 8obHOg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6y6qud1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 06:53:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51P6rP1n000350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 06:53:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Feb 2025 22:53:20 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <sjg@chromium.org>,
 <pbrobinson@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v5 1/7] doc: board/qualcomm: document RDP building/flashing
Date: Tue, 25 Feb 2025 12:22:57 +0530
Message-ID: <20250225065303.342174-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225065303.342174-1-quic_varada@quicinc.com>
References: <20250225065303.342174-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 8vSah7xWS0e5xIfNMCQFrVC-a6Mt1q4A
X-Proofpoint-GUID: 8vSah7xWS0e5xIfNMCQFrVC-a6Mt1q4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250044
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
index 00000000000..fd14f1d9829
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

