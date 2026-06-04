Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B3CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11AC884979;
	Thu,  4 Jun 2026 14:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TlYNW0Dw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CJpZhtS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4576F8486D; Thu,  4 Jun 2026 11:33:23 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338F884868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UJVZ313926
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OjhIRHuAt/V
 w0p3ARphWJGQu0zd40pT4zrHoK8huZxY=; b=TlYNW0Dwq60duLLQn8ic5SbAKwZ
 1g+E2RPX0kqV6yHssg2vRYSrwQdJCfTC4/nOLYqgrBwPDBT2wqFWerKB3+qVMmGT
 I01A9BHwiFT2p6eFDUzCjkSHm0NK0vNNwvDpKGDt6u0KdcV9OoQL1C0LlTRUCSeF
 dXDgAsBKFllJeSmso+1LzmlugNvvpKiUrAF5hO0ncwZV+qMukXk8hkDHjwnDbrCu
 9bTAPQNi7fyMjA7jELY36l+3pXfrNLGUZMggAfeDa0QUT451thmaLagA9tdCVALt
 39XFwGIDLN5k5PotczRY6NJM5jm4ZWSSN6bR35uhcB451ria0mqMunl3ZGg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy5v1pgm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:33:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so409514a12.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565599; x=1781170399; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OjhIRHuAt/Vw0p3ARphWJGQu0zd40pT4zrHoK8huZxY=;
 b=CJpZhtS35/YUqVdRqu1r8HDukH8zFrX4gWTKNSmuWjrRFx9m1rt/LKtzTS9ZqcgqxD
 pwO0sALAsuHFAaKhjXli2wsdP1+CoUptw4xXuh/W8+3S+gjlnazp3yKlHJLo4F/1Vwt2
 dBFcqxQDfwt4OCrQI8Kkq1IIE4Zu3hR2Y1f8YFxJYlsIcel4TIHph/XbVfqRNctKCHIk
 0jh9d8W1URbs1SY765GRdNtfHCfqjqgwswfQBtLgELqsB0nytPGSTGmalRixj0Np5e4J
 /e/O4m9lsqgZvg1LLPhDbn7aoEp1fEqxPvOBcNTtR5w8JFhQa5Kg87yxgVzq9tEMPZq+
 Y7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565599; x=1781170399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OjhIRHuAt/Vw0p3ARphWJGQu0zd40pT4zrHoK8huZxY=;
 b=BUhf2DOFVhlS0/oGCpDYdrPAJYD0IEC0OxCuhGhX05HU/JSeO8MVHVC2RGUk4uuwPq
 7hEv1kpZsNCuDvLtHLP+9NwfVIdPE7lKrHt++XwI9dHqpEORLqzOmfU0es4eZHfuAR6n
 FIZz8ONtGaDvap+MgcejmgaHsp7nwhYcQrMCog1cmZftWbBW04ee+stbxwxus8teN6Tw
 6Np4do1vsSVjAu+wc6oD7Ypyab4FsLObmry1p1V6WaULAftG/z4V/hD8oqAOF9O+Ys/Q
 tS0v+F/sUwTTHxUoc3dllaUa5FRXb+2fj2JqLOZXSukDrwjmvW7y2NgB8x37lFtXKTyf
 feuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iacW9dwihO1JjFbJQnKgfaJDFrDZFrWd9i03rXAKbMN9BS5RiKc/WhHVkDhbsbuZmsU32l/s=@lists.denx.de
X-Gm-Message-State: AOJu0YxNfSEqqGu7mAK0Tl8XcArlhUQ/I3EYUrPganXDcF67+XCcoKHL
 0Z9t2QnbqJeTtXRYm2ZQgdgAe+Ol9zNeIeG2qfkUv7NfcOtZRUx3C8UWYKrs10aaH9PmOZiZ5+U
 MAtMuS2bUzrfblfuItWQD3rgkM09w4G2q3wqWlDal6G2Ti+hTkKjI/z1k
X-Gm-Gg: Acq92OGLz4SK9G6cs3ewMsUWWBTvamTGiQUb1LzWqnp2uNMqGEFnrhdztL5iWooUtdW
 yqcQms1wC0fv11U56uIpjbWli1Qpt/65OlV8TIOF5e3u+Xj9QlfkvYf8POFOyUxQ3LB76v63mz0
 FWwzhk05q0pCMu6onEPp28GkNxp7rXKWR0IFdByecG1/DzGAfXZXgaLTXBYagm6yV5w4UIpCjDv
 UFs8cSAPI3+JmaUMbf00lb6du1qldNMEk9ogyBLC3gv2y60iZXOrZNV3u/fBE9WPDsc42qkXnLE
 CMCkrszAPmwUi2Y+nnmZOOxaRSjR6/5UWoZX5ohfTXLv+443g0aZWL2rhruFZte35tuBLALoSAG
 YskYcWZVffM9pgaLV4317HQngVTDHSRc0Op7qkvpyMpoiO5hP81PzURhUFFl7L9YRKY8zCSgt5/
 sLFjLi6MVx97bdj2xDzsNn++bhKml5s2+rFUeDh7GSvKFKYlVIuFqGZ2SDhIk9rg==
X-Received: by 2002:a05:6a20:d708:b0:3a2:e0d3:37db with SMTP id
 adf61e73a8af0-3b4973adaadmr8200438637.11.1780565598771; 
 Thu, 04 Jun 2026 02:33:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:d708:b0:3a2:e0d3:37db with SMTP id
 adf61e73a8af0-3b4973adaadmr8200374637.11.1780565598328; 
 Thu, 04 Jun 2026 02:33:18 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:33:17 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 08/13] spl: Include SMEM driver in SPL
Date: Thu,  4 Jun 2026 15:01:27 +0530
Message-Id: <20260604093132.757583-9-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX6sIKZYDBFJvy
 5Yb/UrFzJ3x3lin1lZhRdjXXZJRV0ZS5OO5zm6PIl9gGaauHRj+hpuDNDnaqdaDjT2/NTPypFga
 lM8knuD1A0mc5H3h+TFTv0pxeyA/OrNcQULhLQyanF7MUfycQtyZYQM2JlZtaPZzFYHQ+tfv8uw
 YJWOzJE4aIJ7NR+qy++pe+P6LBvFg+H25HgNKCjV+JB4501QNZHw6HkHjdg5MUok/C8zoLasec6
 oaPYtQCQ5r+b4pb0FBUP0hmlV9YcnnxSJ3hgMtokWUItNJqOzCDtCgRjJPI5lp6y+HhygCNx1Kw
 5M3p7qamen0Vn8ugS68hld8i6HEvPxCbbujGEScORO5ot/jIogT27P2tdLn2QdmOpTk0wADLrsP
 opCeYu14U149eCC7PbTF6i3Tzf4bY1Tjj8TEC3yeVfJ1XcOBbbBY+q2/anMzNYch7eCmo3k5+M4
 tL8X7qJiLSB86Ov1TuA==
X-Proofpoint-ORIG-GUID: OV3a0FxYWjUYVs5LHCC0CqA79RKSEE23
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a21465f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=urvU1upnej4-CWmsP9sA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: OV3a0FxYWjUYVs5LHCC0CqA79RKSEE23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

Add SPL_SMEM config to enable/disable SMEM driver in SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v3: Pick R-b Simon
---
 common/spl/Kconfig | 8 ++++++++
 drivers/Makefile   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e49..88db96807b0 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1387,6 +1387,14 @@ config SPL_RAM_DEVICE
 	  be already in memory when SPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config SPL_SMEM
+	bool "Support SMEM (Shared Memory manager)"
+	depends on SMEM
+	help
+	  Enable support for the Shared Memory Manager. The driver provides an
+	  interface to items in a heap shared among all processors. This enables
+	  the drivers in drivers/smem as part of an SPL build.
+
 config SPL_PCI_DFU
 	bool "PCIe boot support"
 	depends on SPL_PCI_ENDPOINT
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..ead082450ca 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
 obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
+obj-$(CONFIG_SPL_SMEM) += smem/
 
 endif
 endif
-- 
2.34.1

