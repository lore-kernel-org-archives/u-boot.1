Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A11C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCC583013;
	Tue, 15 Jul 2025 12:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="N5oNrs9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96710830E4; Tue, 15 Jul 2025 12:16:25 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B7F83013
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F5muxD028103;
 Tue, 15 Jul 2025 10:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 98EiIp2mxXFhCLRygz0npM1W3gu8P01Npoz/sruD2Ag=; b=N5oNrs9TRJS2Ufuq
 Ri6+q+YH72xD823sORKzHJDA4/SfBuE9FwDCDh30Fexy2DuCR7av757VUrlBKsfZ
 CUsa9Gm/PODgerK/K43NxeIid+1EWLw0kBTVi+UKTysKuqLC1adwUBE+ViB8+NkS
 K2tZAewV/TsZfv+MyhAMi4tjRzFVAARR/rlySZaCsbDJ3vvAfUEOepQmLMpoAzCr
 RoCCnObEfXpt1zv4y0/jCwAqc6Q2/BQBUEJvWr73pki2HCG9Crn5HJ9fXVfQfp20
 k1mzUMTRChB0BNP9U3d+s0iqe8kqAxcTn1eAw9gj/bZuAPgqPsbY6kNh+ki24+gR
 V4dXGQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drjkp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:16:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FAGCUh008869
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:16:12 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 03:16:09 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <marek.vasut+renesas@mailbox.org>, <bhupesh.linux@gmail.com>,
 <alexeymin@postmarketos.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v1 5/6] dts: ipq9574-rdp433-u-boot: Enable USB device mode and
 MMC
Date: Tue, 15 Jul 2025 15:45:37 +0530
Message-ID: <20250715101538.4072985-6-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fIlsf8gpEWQnWR8qdqZZ_nbKorBxCRcT
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=68762a6d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=CNuWJGMGguEIvuNeiLgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fIlsf8gpEWQnWR8qdqZZ_nbKorBxCRcT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MyBTYWx0ZWRfX7QuuQb22kCG7
 G8Icwt+e6A3qe1eXu/eBTiAqSUQEGw5TX9D0iZxFUX7cDA64Yda+RTnxJh4Vk+HldR3022iUzgt
 Z6u0ETynkyFtQNfAkAK4cCKRWEb6nI270ib3y+bc55e4cHBLk581VytZpHi3TGPfHp7uQwbH7lj
 d0eYkjI95b9BIJd7UakwN+SEOHKzx0tuzn/AqMXy4h/pqUSAYUet4Tq7WrjzfhSWMgTaJZJdwBz
 A8+z62GyoE7TPoEMKSn8qF7ZA6Yxx5LmGYy8Blta53ocV9VH0gfQizAyIPxdbZYoQhFyo63g+24
 SlePVxKih+ZQEVa5HxAx6nzEuNpiYOnqhPuQ8zYnN+WdS5puaVpM2wRd//9ji8Gx3VEHWkI4IP2
 yqJcpR3+DkSmsR5i9/LcOgtooOCdnth2QfemBObibzrl+A8i7E5x522ikAAajxhsD2qBdWqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=874 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150093
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

Enable MMC and USB device mode by default to be able to use
fastboot for flashing images to IPQ9574 based boards.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
index 390e2338d65..9f04c0c1077 100644
--- a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
+++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
@@ -22,4 +22,10 @@
 	 * reset done sdhci_init() times out.
 	 */
 	resets = <&gcc GCC_SDCC_BCR>;
+
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	dr_mode = "peripheral";
 };
-- 
2.34.1

