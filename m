Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2AEFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A69984689;
	Tue, 28 Apr 2026 09:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dsqx/oyT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/rqxp5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6B38467C; Tue, 28 Apr 2026 09:32:56 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89696845E3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S42u8X1329549
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nHmxK7Htbmk42z+2+CSl9NZp5Fw9VIisC5IFWzljTO4=; b=Dsqx/oyTq2xaghU2
 tUj5XaocQRhZefBuarNpQwQd1rCVT6difu+m76Hmntv8ohvrcmOZRML4qT2Y7aMF
 U6Ix6mtJh6kGQqOFcouatCuq7zp3qpZMtetTYUAolnrBzqB6HyDvrxNTNsHmfLCC
 yCtehzLniHelJlfoyxEBk1Fc3ONnm5DKK8FHIkJpaT+sCmYWkgfnRt/0/xI+cg2Y
 DXlLnb9alR33Ecx+X4et8eGJTIJPwbWnAUiTZvmRcsZCre3kAVQ4TP0dkSg2J9j8
 dR+PFZ3XwIbyQta4FTrA6rWRy0iyDl9vuhFnjbsgMdyFSxwb9JRhcX1aPojwu8gB
 RwljGA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhagqah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so120069985ad.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361572; x=1777966372; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nHmxK7Htbmk42z+2+CSl9NZp5Fw9VIisC5IFWzljTO4=;
 b=G/rqxp5VYNSrrVXmqH5etHx6qFWXOj49VpffHhX3XgzqlNyI9GxttGdbytlOVApEhu
 sTkhGRCcut2PmJ1f6KMEyo6eY+I3VbcD+lUq13B1An4Pmf2/aYwoF8ZkwwjJDs8TtJWF
 tzuBwzNpA2t98neyx9RCP+IPOft0iExDeej4HbaOo7fi69HQ91qLGZ86yIY9LCwQEBG8
 FClADk7K6pKpCVvs847f/4V0f/XGqRVTzjfffh2biM0t4iuCEErM8BTdhSOXrBB1wezY
 xsb+k4w6W3b3CtVmTu0riNCs0iqm8wAcBIHXIEhJ7CTe42eBFyTX6fxj6s0ZPyyIrzHU
 puCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361572; x=1777966372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nHmxK7Htbmk42z+2+CSl9NZp5Fw9VIisC5IFWzljTO4=;
 b=ArXxVFTvZQBrU/UqWL+IzhmSD1My6LxgxmbliPxI8Y7SAYm0RQUQre59JG6b1GcKvz
 xRvWi2+MYk49TRxa0sj0G15yFoDu2ZDQLMcN4IymPwWPz5+Hc157i7ObAnPffYGvBs+o
 g8l748Ri7Wu/GPZVu8+S9/MTK7l4zeBXc0PprCC1gSb4+MvpsekYH8HsgcKWQsJTbfxS
 nhp8EvTvCOFrPbJApiNsacwGCHNkJ8meQ77mQzO8gIdGrDbyKlasOSzYWNhqUuTr1krB
 6jBYksrz3vzwUIWQRmG/TuM67yj4z/ZHx+iOAH1udFtLld7W29HT9D9LP1Qf37Q6o3Z4
 ArDQ==
X-Gm-Message-State: AOJu0YyACSAjhWbxdrIR2ao71xvtprzFj8qSOfsqvX3tj96/DFTHpEVd
 xCQ6yZ13comnhvxyTGgZpYu/abKJ0q40aIKXnjTFCFw2A7vD0IkNEGv2PThoA11SnharZmyOH7G
 5CgMaEhCv6L/shFChePg+75YFYSuvkoL/wkRFuPz47p/Y9j8QYTvSmffs
X-Gm-Gg: AeBDieuNCMw4OC7XvApQmpxI9UXoa81SdV3dfxX6Eo53rvCccCEtZq+cJzQQ49Dx+d8
 jH8FinjuFi8swBvhx3yjfukwpyHNF1ERKBwKOYT377snBzdm3wBeJt7dAPcycrudZrNa5OBI/gB
 qwHb++DQhTlVGYt+MdV2jM4TT7xMNifUXO0CRsbUTGPrXxiw4eqhr7J1q4I2kj04k/butOrNp5W
 JkyaZtbbkJlJcCkiDX1G5RDaNIGrrYszRXRfAYhXb5BeAfAPhbP5P7VvvC3gqJIwtFGiGiwvNIf
 F2GDjk+HAL5jVmsP2BLaUkWkVjbxQE/7QZ+3aYrO2WZvrCQi+XNh8z0s23Cojuj71trrdOjQNX8
 d1kEzIS3gs3zyZ4qghQxgp2y175dYgNwSHSZLd3NZcPjKY5uG4MNkDA8Py2Wl4zCjURuVgVvWAC
 0r+SiYPOEBQg7KdDWCt9or3CsQph1TfttmtWs2yqjc6xUS75CoDsiWXW7OXXkw
X-Received: by 2002:a17:903:2ec3:b0:2b0:6068:4c5f with SMTP id
 d9443c01a7336-2b97bd6b567mr17308535ad.8.1777361571932; 
 Tue, 28 Apr 2026 00:32:51 -0700 (PDT)
X-Received: by 2002:a17:903:2ec3:b0:2b0:6068:4c5f with SMTP id
 d9443c01a7336-2b97bd6b567mr17308175ad.8.1777361571421; 
 Tue, 28 Apr 2026 00:32:51 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:32:51 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:01:49 +0530
Subject: [PATCH v4 7/8] configs: Enable partition type GUID for
 QCS9100/QCM6490/QCS615 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-type-v4-7-b7051dc45a88@oss.qualcomm.com>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
In-Reply-To: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=2239;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=jX/8xGr+vz0wxWSwWGjt6JUqJxojz+KElTDrclgtKsU=;
 b=uxoXSwjfkn1PDSO33Pm+XRC/e0hf4RPmTD5imrFShgD+6TxQkYk/BHQhr7oyALxUF5Ntz8iTl
 TcFzdU1oCyDBerwURpCpKxAAASzSp/16zF3iPmp4wanlwJlA7SuT3u4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX0b20HJdMProN
 oapPhBWGP6/oaAjEe3+ughkO9eq4+1H1qQnWJq5OCvcB3ozu83ld3ZQlQ9hscysLN0ptQFTxilJ
 3FksrVShxrtHPb9b64r+xcOBNJflBxJwhZYiM9HQWg5q4RXNc1AZxKh5EbQdjwtjhef05Hv4v75
 5M6vLNlCdxyhp97Dq2IkvM1UIDaNxqU88WutPIZ90roaQ9rY6ChAtN4uekbLmFhQxjzUDXPKWQt
 262yefFQ2KqorQFWNBT6Pgc/8UpCBnxOKSJ8R5HTITmq/iLUi2oe24nW3iRdpL/SkD+yZasb1nD
 Ejnakvj2xR6Gh8m3WFKKYwLJqMgQG7/9jJxQitKauRL7IG3BfBO1p995lsVQ1Df69BrX3wntO89
 hYF4NJWprlZpaMJlaTr5kmL0fPHQzxwkAb19V6Esz5pVjqpUjztCDT+rYE+8PyD93Kk6eLsM3cv
 eccGnEnLic0Xt42ZU+A==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f062a4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=u_qGlHSrht8nJ-mVAGAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: xUzXPGgOUU_uJkhUyCtrPpmQHF5vMUOc
X-Proofpoint-ORIG-GUID: xUzXPGgOUU_uJkhUyCtrPpmQHF5vMUOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280069
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
partition type GUID for QCS9100, QCM6490 and QCS615 configurations.
This allows these platforms to locate the environment partition
using GPT type GUID instead of UUID.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Add type guid configs to QCS9100 defconfig

Changes in v3:
- No changes

Changes in v2:
- Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
---
 configs/qcm6490_defconfig      | 4 ++++
 configs/qcom_qcs615_defconfig  | 4 ++++
 configs/qcom_qcs9100_defconfig | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index b088367f86c..9560886a37a 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -16,3 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
 CONFIG_PHY_QCOM_QMP_COMBO=y
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 27666a8129d..d0ffa567619 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -22,3 +22,7 @@ CONFIG_REMAKE_ELF=y
 CONFIG_TEXT_BASE=0x9fc00000
 
 CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 082106157bb..fbaf21952f2 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -11,6 +11,7 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
 CONFIG_ENV_IS_IN_SCSI=y
-CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
 # CONFIG_ENV_IS_DEFAULT is not set
 # CONFIG_ENV_IS_NOWHERE is not set

-- 
2.34.1

