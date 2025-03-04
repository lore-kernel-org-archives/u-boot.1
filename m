Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647E2C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 11:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04FB68169D;
	Tue,  4 Mar 2025 12:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="pHRRfC9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376C881545; Tue,  4 Mar 2025 12:01:56 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB7B8164D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 12:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249m65i015504;
 Tue, 4 Mar 2025 11:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f8NTAx2wCAcwTOthW1di16Cvi1RIuT48V6U5DOEnnE0=; b=pHRRfC9Reiw+FTzu
 fYh2Oi8qGpPnrw0daf4IfdzFlMo5QfM+5YZbMXYMGMSguWlXZMQpmukMwdtWWXCY
 6O3b/LWHhy50eW/U6jw61cqetfqxk9MQ9iANdcAX+qs6D6MZXHNZLuVXQRY5yXJy
 4Gnw4EeSey5P/k/UFO9Kc79iAFOTS2N07QJ0sL0u1WvKTamYAlBmQoBZen7fYjAx
 nViLpGj8DvEi0OTPxZXD/FSrUtmrfj/V6q7V3R1I7ajQhUVqT4K3rXOFAKe8MFDX
 csV8FV1sy4sl3x6eHvbLE+xSC9x3FcrFbIruKA27kSscYQcbS6vuru2V2enkdes5
 QA2ZNg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6v1kwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:01:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 524B1aVm009816
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 4 Mar 2025 11:01:36 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 03:01:31 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>, <sjg@chromium.org>,
 <robert.marko@sartura.hr>, <dmitry.baryshkov@linaro.org>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v1 3/6] doc: board/qualcomm: Update RDP signing instructions
Date: Tue, 4 Mar 2025 16:31:02 +0530
Message-ID: <20250304110105.2762124-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304110105.2762124-1-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 5bIC7yBbfsa0yl0Ko2gGr3pEXaPNa_Cu
X-Proofpoint-ORIG-GUID: 5bIC7yBbfsa0yl0Ko2gGr3pEXaPNa_Cu
X-Authority-Analysis: v=2.4 cv=fatXy1QF c=1 sm=1 tr=0 ts=67c6dd92 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=qC_FGOx9AAAA:8
 a=COk6AnOGAAAA:8 a=0mSuIBaIFOjkIpLIiMYA:9
 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040093
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

IPQ5424 expects U-Boot to have MBN version 7 header. The qtestsign tool
presently documented doesn't support v7. Hence update the instructions
to use a different tool that can support both v6 and v7.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 doc/board/qualcomm/rdp.rst | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index fd14f1d982..99cf8eba57 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -21,13 +21,16 @@ First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
 
 This will build ``u-boot.elf`` in the configured output directory.
 
-Although the RDPs do not have secure boot set up by default, the firmware still
-expects firmware ELF images to be "signed". The signature does not provide any
-security in this case, but it provides the firmware with some required metadata.
+The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
+can be used to convert the ELF images to MBN format.
 
-To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+	IPQ9574: (MBN version 6)
 
-  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
+
+	IPQ5424: (MBN version 7)
+
+		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
 
 Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
 on your device with::
@@ -51,5 +54,5 @@ U-Boot should be running after a reboot (``reset``).
 	Note that the support added is very basic. Restoring the original U-Boot
 	on boards with older version of the software requires a debugger.
 
-.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
 .. _edl: https://github.com/bkerler/edl
-- 
2.34.1

