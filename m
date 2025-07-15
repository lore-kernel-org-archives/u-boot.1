Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C38C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08580830EA;
	Tue, 15 Jul 2025 12:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="gG9BObBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0EE830C0; Tue, 15 Jul 2025 12:16:27 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F78F82F8F
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F5lVH2021130;
 Tue, 15 Jul 2025 10:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LEq7IuvY4VuI3qhcrrdT3Rp2nRfRCGrg4ZB2B6EYHa4=; b=gG9BObBGUW6AjaCy
 JanUNY0akZ7tS2xEJhQWGLOBh4F+RbeAuxp/oOCMfhe2bw3KP0UICbH5Tf0wNgqm
 7/N6PSaANfK5EhyQwVRYs4Q3xWnGSummCsc8AHbEs9euxkqEJVBQsG3zI81Kczen
 QQVBCK4dV9tKF+vUQoHvlX4E6zzDsUFg3aLcf0wbmwf6xkkv4vhOCGSAAnlBguuI
 8F02Uo1MdyHgrbOYlVsYPPlKeYGZpPQisFJnyZLO1cUbAa1hzoxDVg1W69DeUYYZ
 zh1y/22AdZC3wflplrdVKlNl9ym8sWaFRxx7N1Rqxt+ST8h9JZCDfX0OH00vBHR+
 HU8AVA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpakdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:16:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FAGGvX013292
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:16:16 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 03:16:12 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <marek.vasut+renesas@mailbox.org>, <bhupesh.linux@gmail.com>,
 <alexeymin@postmarketos.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v1 6/6] doc: board/qualcomm: Update RDP flashing instructions
Date: Tue, 15 Jul 2025 15:45:38 +0530
Message-ID: <20250715101538.4072985-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715101538.4072985-1-quic_varada@quicinc.com>
References: <20250715101538.4072985-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MyBTYWx0ZWRfX0iBpkh4ORZsz
 E/rFe7WomWO9S3lTKhnQx/8yQrCKKklHW64zo0d0UcozzL3f4G5ohFKkMngOvF6j3bhonjnpSO/
 A5AsG0BH8UXKYqskGDPjFH9DueHCpZTSlLC2IAA2yQcyshtD5CLPuX6wFkVdeTVLcc4z0Ft8+ge
 TNPt7nxEA0z4oitS05LyLYVfTEjuyntcR/Jewo5+V7/Wwn7dfrgyYJ77EjC/4z+7AzDEUqcUaQV
 d8Xb9NBTkwUm0LPA1XKWIipZiEJ1YQih/9a3ejqjOfOcxo/IKAEwBzzHYbt6ufFLqjezPr67fRK
 t8CjU9TxqDR4qIUs2b3fXLgBBO1sF1qQaS85oY14aCu4nYaTcz3SB57q1irNxp6qKUuwN0L+qm7
 PhSyr8HhRdFstH8Jexj2L2GGlJTX5BaHzfHeUifUxZu9G/0mFzeDFdJvzorfIiGCt99nvtus
X-Proofpoint-GUID: Za1wQY_PrQmMCdTB8zBWJDQq2budnrbm
X-Proofpoint-ORIG-GUID: Za1wQY_PrQmMCdTB8zBWJDQq2budnrbm
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68762a71 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=r5MC_wQ6cbKlY4jr-AgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=903 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150093
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

Update the flashing instructions to include fastboot.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 doc/board/qualcomm/rdp.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..97a64e4677c 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -42,6 +42,20 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+This U-Boot doesn't have the n/w driver. To restore the original U-Boot or flash
+modified versions of the above built U-Boot, 'fastboot' can be used.
+
+  => setenv serial# ipq9574
+  => fastboot usb 0
+
+  C:\>.\fastboot.exe devices
+  ipq9574  fastboot
+
+  C:\>.\fastboot flash 0:APPSBL u-boot.mbn
+  Sending '0:APPSBL' (620 KB)                        OKAY [  0.042s]
+  Writing '0:APPSBL'                                 OKAY [  0.030s]
+  Finished. Total time: 0.342s
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a
-- 
2.34.1

