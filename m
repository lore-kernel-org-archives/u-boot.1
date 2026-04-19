Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0B2EA7195
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 10:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02BA48425F;
	Sun, 19 Apr 2026 12:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gDrWf9bO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GRcwqct3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614A5842A4; Sun, 19 Apr 2026 12:24:55 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 107C7842C2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 12:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63J5YW2T3311323
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qhqp2BFl668JUKSrT+fCk05XnRl/lrEjwLRcjhUh4uk=; b=gDrWf9bOyKSUl8Ku
 quJ+SmDdtZF3uqvMY7TwaXLtcazLRGm3bkl+Krf83jDeCOrVS55D7QQg5Gzu6m54
 kybK4J/zzQX6iwtb18uZIp1AinlfORiG+MfrRhXuPJgLqM1ql6BV8Ab5BO12x5/K
 pllwP5JfFX9a6p2Oar0/KpUF0KaO8kmKeMdO52e5Foit099VrDforFO7nJsFpJyZ
 n/MClCE7BCWZ86ML6n7pAb9lxkbwRmrwyfGNz/66nqlgxPTq+A/OmkJ2/XfVW+BS
 Kw+lceqXBXLxcYd9yXxOnFV/3ieK9iJI8/skPSmoRrfNrGeIi/APyuOACQ/SY6jg
 9Yxteg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr2gbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b45cd0bb96so20766245ad.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776594289; x=1777199089; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qhqp2BFl668JUKSrT+fCk05XnRl/lrEjwLRcjhUh4uk=;
 b=GRcwqct3KmZp+wtY0RidgjGXUonShG1CoNQ8q7j+2rrq98iYhe8B/6fWK6H3WWMj3B
 HNutjDDY6x3U4h0dWpkfLkrbg/rzn4ScdzyP3pySqBQMHHlHXTst47guMEqOtTCsC2v9
 v8DsdWmBZ4LkTDwIJM+h2BKs1mHSd5PH4P5AN3xXMPEo8ttI96mno3qf4oSZueHtg8AM
 xKT4bH2p9j5LIlz1snkOFr/n8NH4EceGdIobEaIXpWbDiNuLVbNQ2RSDPLi8u9GtqU5i
 ieXIyYi17uuUPfQ5avkjnIhOO3/D4s675Xrj3EzvPa3dWrbKMZRCDVWcVwH1NaJLPc68
 dg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776594289; x=1777199089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qhqp2BFl668JUKSrT+fCk05XnRl/lrEjwLRcjhUh4uk=;
 b=oejF0xWtrKGL8waQb+/kZT/qJbA65cGKmHhw5Gdu98FI+GY9jsurQGZueaaAhaGWIi
 SIMsrNqors3mYZOkdFQoy4jRO9UiREq5yyqHdoAIOx1aqx8/XJl2pa7uTVE9o4kgB+mi
 cV62PeSOM4jCQe6oMcMDoqS4sfwVsuCvItPmk47xL6/YREzN/WnPVkWw6ZUEro4+nOeg
 jIgAe3wtfF7nPAXD9gxY1bNF0d6TxaxhZAhhny6c23TuFNjSq7Uy1ec9C+v4Ds73TZba
 6/6Wsc3q/aK+zQybWjTngpATcsqLaEFJlgbcGFZk1Oyto2IBRjkbFVmWKVwf1QD6aFut
 PY0g==
X-Gm-Message-State: AOJu0YxdIFM8ZiYyNISHcqPDcXQakSTa571z7DbJT9I44z5IY3MG2LGC
 X10m4kOYrGHbEJrOIo4307BlPqL4D77Jq9f6Oxm/M/z6zgfnNyMajyE9wUU2YjaHREADZwy7Uq7
 +if3hxZlnes4tkZ5/8DTs80z6O87P+EyoWs3Vrstu9Ny6M/uHCRUNRWTC
X-Gm-Gg: AeBDiet0QKRhCmSoaS2IjJf1JsreCDAqVww200YzmrFuO1MEKqHlWnQX9NIwsZsPAvw
 8p/w/EOXKIaFUYjRGeYtqZlxzPM24k49LOSBOycjT9fNUGqxyn4eh92j7rsFvWShaIK8S9hcZWk
 ScVdm8mfuMOY0dHeLrCWchMrIjlZGh3zdsQ2LV0mKfSk4ORHLz17NLkXUOc7SM8WX8bhYKx4dDm
 TPUL4jhpnH22ya/hBhCpscZnnvjF3P8Iydp8MS+SkSZy8+nqtmO140eJmvwywvUHlmPw28NYwEV
 768H1KqHyMnu99hCebZczrvxjJWjwXJI9INHsXh9zJ+AnDQ0mfUnkMb66g1DXm6Bacgo2thInIw
 ETV4sCitDimglPTg/ySy622W56VvWc1VRLxNAa50CnEHeC4L9sRVESfnR35XxGYXmXYllP0zHVN
 N4jxZTVhev0xOpDOi+Ib0yftksRELgtcQ9r6wIRzc/Z0G7GqSRI74SUAkpP/tE
X-Received: by 2002:a17:902:8f90:b0:2b4:5f96:184d with SMTP id
 d9443c01a7336-2b5f9e5da53mr70617425ad.5.1776594289454; 
 Sun, 19 Apr 2026 03:24:49 -0700 (PDT)
X-Received: by 2002:a17:902:8f90:b0:2b4:5f96:184d with SMTP id
 d9443c01a7336-2b5f9e5da53mr70617145ad.5.1776594288964; 
 Sun, 19 Apr 2026 03:24:48 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0caf1sm72754675ad.42.2026.04.19.03.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 03:24:48 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 19 Apr 2026 15:54:06 +0530
Subject: [PATCH v3 4/5] configs: Enable partition type GUID for QCM6490 and
 QCS615 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-type-v3-4-ec49acd6870e@oss.qualcomm.com>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776594245; l=1532;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=JXI73jyxHQ6nhsN7nlxvYZ6h2H3gE6l69sEi4WtTVgo=;
 b=0IqIXp72qgSGbaWHFZdBW96LcBKuQ1t3dmcfWyZRTYHAIlUuEauJ7NrSdBPeK+slO6D+U8YZi
 kIeJ5XAaLqPBMvWZ597mNZcsFPRrzskJT4+KMURotYCiSXi+IvxAdIQ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDEwOCBTYWx0ZWRfX0zQ7ExDB0heK
 rcJg3QzQ3O5RXN7t4g+24gm/c/eGbR2xNYGoY0yrBJN+I+MzwbalvG3iL//1aE76hwhpu/MmU04
 wtYPNEQqjuEJgDt3zF5sYMNSbsCktjjvmWf+wkqWrRuHIzx2dkusu43Fj+gj4brLNz7NE6MQzCU
 oLcGK4sFFGNda92NqeF8lfEPDACyFQU+GrTz8fkcghRHfI8iMZtYNQYQMWk+Emu0MEvoueDRqRp
 pXFc/7no0q7dNxP6Ev18z84z/kZohzHYs7BY+hssEzBO1s2S16OhfHqOxSMyFpED7s3R3IvkrWN
 RUIcgJG0oQHdvP1z9OE5TvSYpMFlCmab3+IILAXoEeH5VPhVm3javuS2j/pWhQ7HJOXyyhgYyad
 2gtD/RtCelMM5NZLQfxtQ++oG+AuQv6i2mxyT1vCLslyjNTfHHE+czBejCx9ONyzzH6nYqC4RPF
 gvZ6ijWBcBs+WaIlUwA==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e4ad72 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=n75gXQ6Ar9n30J6Kw9gA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: XBG81Sk3ZEdhWb3tcCUsL-cS9nX9VFnm
X-Proofpoint-GUID: XBG81Sk3ZEdhWb3tcCUsL-cS9nX9VFnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190108
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

Enable CONFIG_PARTITION_TYPE_GUID and configure SCSI environment
partition type GUID for QCM6490 and QCS615 board configurations.
This allows these platforms to locate the environment partition
using GPT type GUID instead of unique UUID.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes

Changes in v2:
- Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
---
 configs/qcm6490_defconfig     | 5 +++++
 configs/qcom_qcs615_defconfig | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 618098c8860..f2bd5e4515f 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -15,3 +15,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 27666a8129d..88f692b2bca 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -22,3 +22,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_TEXT_BASE=0x9fc00000
 
 CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"

-- 
2.34.1

