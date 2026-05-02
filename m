Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D16DCCFA13
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 02:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1A5845E9;
	Sat,  2 May 2026 04:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pA9L8iFv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJe0dWwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A52280F0E; Sat,  2 May 2026 04:02:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4AD841D7
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 04:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GLvjk176708
 for <u-boot@lists.denx.de>; Sat, 2 May 2026 02:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rz28l9jep6HjV/l97+QkxvtFFK5AAoeC90QnvdiHrP8=; b=pA9L8iFv2nUU1Uum
 RVi1/Xf05chaQ/zYCuJ4f5VVwbxLs5QDj8ERAGgiqiXU8xMmDg4AkLTv/8pEQ6GW
 bdUpomzqQyi+zJl6YdncEzqXcrbRfwFnC8i2d0RaVsg7QPBY2V/TsJnccO+w0HLC
 6SsI8omiWaERK1GpuEgR8lrb06QrnvfpID7pLnuUdXF/8tmTKcrx7yLF8o6qmqoH
 hIDkBViFhdA8Kvwn/rVL2YTwQddL8C3ll501wgYWDDIW/XmGWOJTA5W+glekoZWg
 AoONVGugzUlchcqr2fdiH5VDfmKnaLw2sQxLmr7jBy3J+UUBhGdE1TWKNXtRXLGb
 LywCbQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dve0g442q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 02 May 2026 02:02:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82cf8dcd079so1729665b3a.1
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777687321; x=1778292121; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rz28l9jep6HjV/l97+QkxvtFFK5AAoeC90QnvdiHrP8=;
 b=XJe0dWwj2Dpcn0igoQN98CCinwxCUWe+GMCIeR0VMsThlkSzU5LBjJ+igfNUNltSnu
 uZ47xKPUoHjpfMmgzSu52Tfx4+pNDQ1pa5FmbkfsvxAvbYI/JQqDaOFC0HBmDZjmr4MD
 iS0Xs20nR8Dxkocn7OplHi7gZPoFD8DMTZVqjme6ASnwmHF97e6AMX8C2UVU1RcaadW/
 GzONFALwMo5dn1O/Iqm1pF0tk/uM2ad1qXXya+XLDQBxJf03qlpMGX79mvIzORDhIqCu
 LrbSe/3q4duYEEue1yOn3Aocdud6VOxA/uZmsGnJ9w9Rcgs5zVrK85fOwPKnN4QDJhJM
 4eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777687321; x=1778292121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rz28l9jep6HjV/l97+QkxvtFFK5AAoeC90QnvdiHrP8=;
 b=WgJHga1SwFR+Y124fzqrnBQzuR2e2/U591xGT0g3/ebzedMBN3qvu03zfxxHCfNbDi
 MWIq8GMnaqcoWQiShZPg3bJbmRWg7oiYlXPBzZrCd4+ZZy7Tr6IreKWFcgVU+aj13JL7
 S0eN9ocAP4VBCZm/cnVcahI4pS2SjE4rvSXyZJ/7qkF24PQy8SMH/RpN1fknIaTBRdyn
 b/nY0sTRtV/Y9EtC1fqCG/0VPDLjOLgsInSG1KFUhl37SPEB1uTPtfiQBxC6i537r+Dt
 ycsrmq1b22hitH3LB9LIQ4OrKtW0JVNrdtQ065WdmfVk9Hq/NjzO5SAg//+BPM/0SnJM
 yw0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/g1AEtqu7k3jguo+Wn3JzRp394nk87QRkaT+5Swo4cuNEzmH1fKRmSRgHViGkDuZ2rkcpjrbQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxCIub4qcGYjdgINEZD8z5CqsZEiM3mxxn9DzK63jetgdhMLjK+
 XTJVC0oeV/rLj8Kr/K3rUhm7zxgFEo4ihHC9YPypuugl13Ojn4eHPuIMz1b7aZTJq3yq14JAJOu
 ebB1AgnMDGya5tmVzNLXomi8AnsURDShM09WP+8iVfScDbTtOKp0UsAbs
X-Gm-Gg: AeBDietcCzQDWcvotMdP1OxMpRBukyUiKQOFgKgnHdwRDxRgo4u4bL+po23ip82p9x+
 1WOOalyr6rL57D26oV26ukheFGywXzLH4A+2k8FZDZJ8jCZ1tNxBU33X8dQJe8PTa3Q4QRK7/NZ
 B+0VxIt1g/uyRzxdSajaFzPVM39ErpLZDzC7/w6PaE8IChI6G7Zztgm90CmKZCPiTllRpzcFy6C
 HFrX+FbcJMBqo/hp28kBvSJ1x0t9OCkmGgxS9AdPqg7pqD8jvSPCSGFK2Pos06e5QHXvobblYfx
 oRr2HZAdAghoUf4k1adTbsSy9F/UIqmPorWGvvmNvJ3m0FCChKDJiuaOmiaX0W5t7GvxOPgbZ8w
 Vz0Pkl6oBhPATsBZCsL6KwRMwuJEzs0Hb8pBJ32DeDz8BTNWkEgMOa6F/vq1g/74txVH3mUkl8x
 nDHkey60SHVsFW4I2QJg+ZIsMbr1JhlyuyA85bp9YkXEcX6vKIyS38uLTXsoVD
X-Received: by 2002:a05:6a00:1a86:b0:82f:1d38:f68d with SMTP id
 d2e1a72fcca58-8352d23f960mr1376476b3a.34.1777687320597; 
 Fri, 01 May 2026 19:02:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a86:b0:82f:1d38:f68d with SMTP id
 d2e1a72fcca58-8352d23f960mr1376445b3a.34.1777687320101; 
 Fri, 01 May 2026 19:02:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515836e8csm3607059b3a.7.2026.05.01.19.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 19:01:59 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 02 May 2026 07:31:49 +0530
Subject: [PATCH 2/2] qcom: qcs615: store environment in eMMC logfs
 partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-talos_emmc-v1-2-98fe4a4d6f8d@oss.qualcomm.com>
References: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
In-Reply-To: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777687309; l=933;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=/EzeoKMR6dXkiqHppU6BvUJxIhjrA/fnFOJq67iWCyE=;
 b=oXYutgjWxqsJYfBjnMK+g+3O7UmKFrMVMJLySgVuRksF8Zdrp7YgFRzIwqyMg9rRGozH7gQBq
 j8DihvB1bVaAMKEcw0Ck1E6ne3vUi17KvxwwCMxUo7yP1lbWMpYx68m
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69f55b19 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=UfXMvLYf94O0DCq-joMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: LVbx3L9vkbXIehtPJQ0e4cJ_sW2chCT-
X-Proofpoint-ORIG-GUID: LVbx3L9vkbXIehtPJQ0e4cJ_sW2chCT-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDAxOCBTYWx0ZWRfX96CkukwVO/iS
 7geZAlKHIVoLdPtN0eVuZuCt5mGeRb247N7xcEYExArmJMjwBzVrNfZmfAFZFed50ATw+xyslU3
 AyYgZT2iSmqD8pH1UlDGeuQ9iYDGHcT2GR6L7ZXaNE86aBlO6leaE4jE9extPkvvtzNEiT/0IIb
 whNAtm3Hh+E8O+2htGmn7Cz3IDCGRnF4J3E0Zhd/lqkeND7MFrbqEOf36UjVFxAOHmcLLsKh96v
 40y1bLN2IGY36wI2k58USMXsYUoN318gIzYnGLHJMSpi/H2s4i6oWDQ+H83XSAAh8QPrBHgbtEF
 uRJQ3QtM/zc7BuKYgAquZkxs+4mUnUVo6lJe7fpkfGElQ5qKgdQK1uB2E3vzFhxHfUe9SDYGFZj
 afR4t0XA2UCMrx+8vECw1G1NBluKIiAM02wzWteC5Il6q39i3zcMilsE72FL2/Q6CX644cA6AQO
 fSmlUnm25YLuurm/How==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_07,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605020018
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

Configure QCS615 to store the U-Boot environment in eMMC using
a software-defined partition.

The environment is placed in the logfs partition.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 494e55bb18c..2cf6519b06f 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -28,3 +28,10 @@ CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
 # QCS615 has eMMC only, not UFS/SCSI - override qcom_defconfig settings
 CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
 CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
+
+# Environment stored in eMMC logfs partition
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_MMC_USE_SW_PARTITION=y
+CONFIG_ENV_MMC_SW_PARTITION="logfs"
+CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SIZE=0x4000

-- 
2.34.1

