Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA3F8A173
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D2A984258;
	Thu, 16 Apr 2026 15:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WhIlya7H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ca0yYTkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32BF841D5; Thu, 16 Apr 2026 07:40:46 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937BD83C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G1ELpK2834783
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GIBbABrfZ/F
 B5mqDGO3aS3GuDvip5m11UAHpSjzEKJ0=; b=WhIlya7HrRT3kJbUJt6suyYbw9I
 +/n85ScrwTP29Nyu3tyY9E2L3H143rQ/D8S7hITVgK0SguJiPGUPLuXnRjn6PP9k
 cxSUNDBSknLfBijmWm0wB9KciK2EFFHHY3/P8jVYf1E/nkYHd4L3KWFgedcyGvmU
 ZZOYbJPMPSGH+F9Eb/+JwmjXWd//SRmn3F6yFpfqys/vduMwTSo6d//bOY0Ptjno
 udvnyypYlr7ofHBAt8CGVbDaF0BPIpJ9dGWGKNGQRR3P8mjQI6sPBoxOXknASs4w
 FPaEQrgxnrONCGMzG5cd35UKKn4Oh7S+h4VhuVuXmvQGBSV/CEFtCaLjUGA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcsvjene-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:40:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f70ae35c0so552093b3a.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318042; x=1776922842; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GIBbABrfZ/FB5mqDGO3aS3GuDvip5m11UAHpSjzEKJ0=;
 b=ca0yYTkPCxa6jfCD7A1BMo3m0QBJlncn3X+2zDogUQA0mQCu2AFImUrvDFxw440jh2
 dlSUJc8Xh+ZmseQE7hbOAdL7ugYUhfjY2Xign7H/a/dXwBWL6H7dOWPazTb/yqQUcUDe
 qkqZUQQz8nY2Y+cOmmdJoQ5YchRf2ACkq06LICcJUvJs2hPGyK5KXGu5K+tZ78TshrwZ
 Jta9iCwnnYNnz4NNT8YfWao2+lJiJzmDVtgz6ZHBN3Wbcjkg/SGursiawBy1nTAXPrV1
 /35n5xLGMo9WpA9Fs95TL0gTSuFehJek92wu2tyPJ9YMA6BcX7+ZIyWkBNn+7rizilib
 yKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318042; x=1776922842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GIBbABrfZ/FB5mqDGO3aS3GuDvip5m11UAHpSjzEKJ0=;
 b=lUx3Fj/ZFmo2eoD9mfeoDTNUNlec1zXXf/fb5tTNWMrtS7Fc3wJi2ulTqB98ETOgex
 uWQBjVnMO6sjqj3IhA5jAB2VYcqJPCTEERY7KV1m3j4Jur1mSFSIOhbPxRJiLCTe+Kkp
 hx8yWk7Ut8p2OVW+d/wfa1lNOgVo3MaYkR5Z12wBaTqyIcTjoZYepZdhRSnHqnRlfbuK
 8vq7MUZ6JlUHN7ojObDNRfK2+QQnf4/I8c1n52A6gxAbS0g4+5VglP2Xlg3kyPm1rEyt
 lhUZYrcD0Izv5Zw61eVNW/5EQgFajoHJFazL616vvAIYhBU41EycCPbnzsGdq4G8tMNq
 wzyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KHnVzZz3FHzoxmD+615y46WCCFAiSLEXRsMKPNl/+wc2+Pv8dBtLUKvPexjeX65vHr4sXji4=@lists.denx.de
X-Gm-Message-State: AOJu0YzBxK56iASdzIr5CyBw+9YZ9eq6Wb1jCTGbttHpJVV+Pr8U3BwR
 B/VAwFKZCXN0HE6G5auRfVq993Qcrn5q/ArBajt+/sCx1SqYULhYHOsFW8n/TiPC0Fou+otM813
 Vs7a5lSVW6nE4ewEi6doXsSCdYNDBsM435Op1dOKkrNUqSVFS0QiQXwpE
X-Gm-Gg: AeBDietKvEJWh9/T9Kq8yKyNzJCrKqoylHuNFB0iOpCYmn2SgXHwc+i/6k9c07a0WYu
 7hgPOZCMXcmWqpVyPx2zboPOUNqZH2I6qBwJswKIIkqnBaftdVK1peeCHJeJ7X17PA5X7NGYhhj
 Gjr9td2Tt3Kfz/fF9sCw/KwcSB1a2fLTIQXBFI8jY0amh/IsCZHg5/7E4WNCvGbjMtrL6ss5YI1
 Aqh02W27LLlit0yvVCuOXqSIv5BSxtTVkn6NqKEl5NcIY+s/ydVFDfiIKUHik1YU7NT87xTLCw+
 C1gX4hT4bkazc+vO0UtR/ux+gDvXsjtcIcsuBUgiIlDVRchwvZ9YONVP3CdCAo1xTr3BD8/CaPi
 +3WgXk3sUXrNronasMGbkDcD6nnL4PBiADeBzgvGijiMN+nvuLwQiPCRaPeiliJrxsT0qB/QBzc
 mkL+osT2X45rDqMR1DIg8UIO0PeoykFpy/ekotUWORfsjkSwR7Jkw=
X-Received: by 2002:a05:6a00:4511:b0:82c:d7c4:4c69 with SMTP id
 d2e1a72fcca58-82f0c25e146mr22563959b3a.3.1776318041979; 
 Wed, 15 Apr 2026 22:40:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:4511:b0:82c:d7c4:4c69 with SMTP id
 d2e1a72fcca58-82f0c25e146mr22563919b3a.3.1776318041444; 
 Wed, 15 Apr 2026 22:40:41 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:40:41 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 05/10] spl: Include SMEM driver in SPL
Date: Thu, 16 Apr 2026 11:09:23 +0530
Message-Id: <20260416053928.2834699-6-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WYpI-0fYNoKOuOKpRTzoHB2zO1hI6kB4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfXy9svoPjXtwnO
 2GfURDq1HlyjmEzjOaA33zbQ3XU17pr/jMAKNBsoHE1UZZcRGbgjjxpodireomW9Tfdg90YiFx+
 1eOdPdhDG3q6yaiqUhPSHPaRpthIVO3tK5WNx22m5ujImLQTQRD4ijAMitSajJJmwW3E1Up7fOO
 MPyb7QJ3gFUqg9ET7Q2RvQV1nJMkSeIK3omEWPEipDUeZVARWzMDk5MvtWJaQVVI6cLOl8JBL04
 vLc8/nf87UE1hPiVC9VwoPq2IgW6hoCCI8ZGwlpK4lNYuQezgAjBEiGG3+ZZheXaBZrk5QAjonA
 1w1UZWSvIR3GpGq/Unzx/yTXZpf3AHU+bpc2CuW0vWmBrDehRxUlxAHMmqGQvViiz5kqOKuLtYA
 OOKpi8eJo9TG/k/IT+2U6bvKJDxkmD0Osac8ZQXvZV2OMNgXgCJ/I1EL+dPomVYUfVxxwajrO3A
 wQyhL4PyFf4y4I4Hq8w==
X-Authority-Analysis: v=2.4 cv=Iby3n2qa c=1 sm=1 tr=0 ts=69e0765a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=urvU1upnej4-CWmsP9sA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: WYpI-0fYNoKOuOKpRTzoHB2zO1hI6kB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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
index a21b71ad5d1..97c4e8236a4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1384,6 +1384,14 @@ config SPL_RAM_DEVICE
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

