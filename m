Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE1EC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F400682A59;
	Tue, 13 May 2025 11:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Uz2W1tuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860CE82A1C; Tue, 13 May 2025 11:19:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0470182991
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6h0AO007509;
 Tue, 13 May 2025 09:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x9SifL0YCmO2W6i6i22EiR6/GrwQxZJg89WHWobgBIY=; b=Uz2W1tuzGmM49ujX
 ADaNzHqcxNEpu/zhXI+BWo3pKacUN9lGx+r7kAKBTuZGmS1bC55HU4/BRWwxM/QQ
 NLSHEDGhhkgE8MhhZVhypsDNEKwBVvEJdrrPfbKL2oLCOE/hmwvzxFD2+iMI9Us0
 Qt2QvWiHvbT/RyGl+sU7UMLCexx6tjVfjyES+tUWyClDSysA3XKUAlB3PzhiKTOt
 9PvN5toLtBkSjoyw7XsoV0L1MRjext1xodIPQhIhjUJNseYzgecMlkPBMOrVH8vq
 rNdPtKEcIHOibWDFvustAbA0aiZN2pmLIPXaJBjA8UXO5eQ7Dg9l3in2GXdI8HO/
 sUUPOg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hv5qffgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 09:18:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54D9Ih9B026625
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 09:18:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 13 May 2025 02:18:38 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>,
 <sjg@chromium.org>, <hs@denx.de>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <venkatesh.abbarapu@amd.com>,
 <ansuelsmth@gmail.com>, <cniedermaier@dh-electronics.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v4 4/5] doc: board/qualcomm: document iq9 building and flashing
Date: Tue, 13 May 2025 14:47:09 +0530
Message-ID: <20250513091710.3719292-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513091710.3719292-1-quic_varada@quicinc.com>
References: <20250513091710.3719292-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=DqtW+H/+ c=1 sm=1 tr=0 ts=68230e74 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=fZOVrP4WiPEGLte6-pUA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 17fNqTt7NSkw1R_V_x-O4k1h4BCs3GAb
X-Proofpoint-GUID: 17fNqTt7NSkw1R_V_x-O4k1h4BCs3GAb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4OCBTYWx0ZWRfX5LHemEdMsFiN
 Lem8uQlVQIb3nx/z+EYcVtEQx8WwXkmOcVsWKgGegl9iuU/7Ym5+K8PkBet3dh56SGf3b8RTQd9
 br5G5RWZkU/hdrfVJB4e1zeprwFrSLrRggzJ9OoJp14vxsmEnZjU76Yi8s/zPqgeyRfYwGE7gy+
 icIKse4N1u0gvP+N3pgp2kFOq+5eGYnNhB1UiM7TuwthWe1qlNeziM6TdqmAfYCiGn0gV48Rblj
 GKjYuFihSUZkDc5V6Lofqq5EqnVKi35wn2LKGTvoahlL0a9QCGPjyFyau7zFI2aFqfOgVjYy/Bv
 AtfnUdoOsl6hpTqlnoCNxvabyWHYxi4puuUrRd3h+rdRVhx/N1Mf75G/YNTvF9Pc0Rk1DZxCeMr
 2BSsndChN3h47LWdsRvjJ2M4tVx+G3eLriaPcyq9F6g3/88YBpdrcscs9jESMSNM3dDioKYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130088
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

The steps are similar to other boards. Minor difference in
the way environment variables are stored.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 doc/board/qualcomm/iq9.rst | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 doc/board/qualcomm/iq9.rst

diff --git a/doc/board/qualcomm/iq9.rst b/doc/board/qualcomm/iq9.rst
new file mode 100644
index 00000000000..bc89f286add
--- /dev/null
+++ b/doc/board/qualcomm/iq9.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Caleb Connolly <quic_varada@quicinc.com>
+
+Qualcomm Dragonwing IQ9 Series
+==============================
+
+The Dragonwing IQ9 Series delivers unmatched on-device AI performance for the
+most demanding industrial applications, as well as available built-in safety
+features and design flexibility for high-compute, powerefficient performance
+capable of handling heavy workloads in extreme environments. More information
+can be found on `Qualcomm's product page`_.
+
+U-Boot can be used as a replacement for Qualcomm's original EDK2 bootloader by
+flashing it directly to the uefi_a (or _b) partition.
+
+.. _Qualcomm's product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
+
+Installation
+------------
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``qcm6490``::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make qcs9100_defconfig
+  $ make -j8
+
+This will build ``u-boot.elf`` in the configured output directory.
+
+Although the RB3 Gen 2 does not have secure boot set up by default,
+the firmware still expects firmware ELF images to be "signed". The signature
+does not provide any security in this case, but it provides the firmware with
+some required metadata.
+
+To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+
+  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+
+Then install the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
+on your device with ``fastboot flash uefi_a u-boot.mbn``.
+
+U-Boot should be running after a reboot (``fastboot reboot``).
+
+Note that fastboot is not yet supported in U-Boot on this board, as a result,
+to flash back the original firmware, or new versoins of the U-Boot, EDL mode
+must be used. This can be accessed by pressing the EDL mode button as described
+in the Qualcomm Linux documentation. A tool like bkerler's `edl`_ can be used
+for flashing with the firehose loader binary appropriate for the board.
+
+Environment Variables
+---------------------
+* The environment can be stored and retrieved directly from UFS partitions.
+
+* Environment variable partition details
+
+	UUID: 71cb9cd0-acf1-b6cb-ad91-be9572fe11a9
+
+* Relevant config options
+
+	CONFIG_ENV_IS_IN_SCSI
+	CONFIG_SCSI_ENV_PART_UUID
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _edl: https://github.com/bkerler/edl
-- 
2.34.1

