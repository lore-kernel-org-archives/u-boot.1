Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148B0C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 05:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A5782CBC;
	Fri, 13 Jun 2025 07:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="XV3cS4Th";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F6CC82CBC; Fri, 13 Jun 2025 07:20:47 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A220882CBB
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CHGnKP029045;
 Fri, 13 Jun 2025 05:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8n83t89qBtR0DC8Ae6acJBBPUevE0ERmiuAziZ++5e8=; b=XV3cS4ThubUDBIbM
 tvWjVKRdQkMVRICPh+TlWSz0tKQ8TTavCfqclgjXJJGWv4LGgbndUCmteOUpUaaW
 Mxv/GUd9FL/gZmWHU1oni2Frjw5HJpLFLN3F9i97XPSpBT/ai1rRZwUajt/EOMQu
 z282MlAOyTebviNc80QoIYlt+tDwlWxEJNofbijoj58O5J3t5xWGY0kwO4kRattq
 hDl7MiA92L45k7pnS+97IoT4K90umIEyliAXrtCgMu4+pf4Lby/CiZFKgKW0JjW1
 Gsl1TZn28g/fyljHfw/iqLuGZAW3+XVO/zqABjethjY70zJzwBosvk4AgSTCr4X4
 Pfam2g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dgy2vpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55D5KbHs026310
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:37 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 22:20:33 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <jerome.forissier@linaro.org>,
 <sjg@chromium.org>, <patrick.rudolph@9elements.com>,
 <clamor95@gmail.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v4 4/5] cmd: boot: Add '-edl' option to reset command
 documentation
Date: Fri, 13 Jun 2025 10:49:56 +0530
Message-ID: <20250613051957.3159564-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613051957.3159564-1-quic_varada@quicinc.com>
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: X03-YZ-IZBAfO-6EALNjXiwUZcr-SPuH
X-Authority-Analysis: v=2.4 cv=HMbDFptv c=1 sm=1 tr=0 ts=684bb526 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=Mf8A1FuHfXW03_C84bMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: X03-YZ-IZBAfO-6EALNjXiwUZcr-SPuH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAzOCBTYWx0ZWRfXzUmbqM2/4cSg
 DDaICn4O843lEfr98w4JJCdr1CFXwO/cXLrGNYImcM4gwU0r3+VH2lIiX9p0Dc/Zw9IhFWbGOxD
 2pDSzt5AXyoMs95rzrNBXv4HazubbRgmPqWZQ4NY5cR/xn8r+EKsXiieOj9KL5RAJ84Z1E/ycNL
 T73Go59KdbFCkP2p8RaAbozavpHPgbQvZxsDPuvILX0hiMHckn+fUdWVJENa7CsjDXaSrxleJIo
 w5/EvJDIVOzk/fk0TA1ZQq4suaoYtjz+y1wSMf6nwIvGWLsIzZRW3GJkEnulTxLv67ivkXtsMKV
 8Vm7a0GyHi8M6F8Kf8mCn9sDdTJsuZ8KKvklKm1PoCtikvVS/znted/iUJ7n52ftChdonQO2Uar
 HTcswEmL2+L4U93vCpoOw5deLXe7bYcCRilYnvZu4f7RMcAbBjSvNAK5UeOmVwjNdwEjhxhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506130038
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

Add help text about '-edl' option to reset command definition and
related documentation.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 cmd/boot.c              | 3 +++
 doc/usage/cmd/reset.rst | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/cmd/boot.c b/cmd/boot.c
index 23496cafdf5..d80f9d8c05d 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -60,6 +60,9 @@ U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
+#ifdef CONFIG_SYSRESET_QCOM_PSCI
+	"reset -edl - Boot to Emergency DownLoad mode\n"
+#endif
 	"reset -w - warm reset if implemented"
 );
 
diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 126db21cdb8..4237f764175 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -22,6 +22,8 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
 
+-edl
+    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
 
 Return value
 ------------
-- 
2.34.1

