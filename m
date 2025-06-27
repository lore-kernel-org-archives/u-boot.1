Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2887C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 04:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07ADB81F66;
	Fri, 27 Jun 2025 06:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CvV/TCej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE56D82B34; Fri, 27 Jun 2025 06:52:57 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A809E80C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 06:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4DDVM017812
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 04:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=oqBPHa1YMGmMB3VH2SfpieIbd67WAfa6dL4
 k3KHLAGg=; b=CvV/TCejG2icY7yWj5o8mQsItd+4KkojRdtQY11YK8WGZSb62RU
 jMlp6WC/utssNb4I9zyMHelbYU9l1NYxhalP4Wwp2SetQJ+kyV0IfIWKWLId0JJg
 Z9Min5vU8aiwSLyn7Lbx7UjNQ5pQjE7NrhrFJtLoKAmV7qRAoO+sRlbQp58t51sO
 KBJuESnNswo3JHNSvzG8gpCf+AWFl38J+CVubjZ2cRwicnMei1DOWmHGs3JK+87o
 M2oaa6+yaT1jysDioeoq32bVdlhgf5Rb0gje0/EKfJ/N+4qIEVvygcRrGArs4AVJ
 dlAYfDm1iv8lSabMHAEnxqGCbfcdaIpiFuA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx3tf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 04:52:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b34abbcdcf3so1139196a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 21:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750999971; x=1751604771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oqBPHa1YMGmMB3VH2SfpieIbd67WAfa6dL4k3KHLAGg=;
 b=a6WExw/QSVo3243b33DvDt+AYiHEARGEirLIBNVIpTGfRt4SyKlPlqV5IlrfAXm82v
 W7CkfHAZe/UGNjd3s8lMsba01DEjgK05DEYvq0A3UWeaZewv5UOP571csm8wbv7p8EyW
 68ANUBg3wEa41jMf+0K0+5rknCTlg0XEGrgAlegvXr7YBENt75HS0g/280JVtP5rzxrE
 vxWfRxjRgcAmI1qN6icEBz4jXQ6c66SVx/X3IOCrpSBViME+cUr9IV5ua05zIAtFAgnK
 SHZjU59xGc1yHXBM1QdONoIa03CjVzOW4QWKTFwSGl/pYbZ+9KP0FEvR4iVS0+LlTYp+
 KSeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHe5BAlUflBvHK1dSrphdQcOn+ycw8ubEyBIpKY+ayttsYoGFgPVd6vSJgBUDploBWBOxXs/0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+ploLrqNYxBJzBS5qar5jtUCjL8wRCVqjtp3OGpXOhmaJcE0O
 4w7sQCJrP5tmtZQTpdhXdyT8d3HbcFloXbn8Bki1YEWlhYGuTWXvaIHSO9DqSVVRPfkAm7TZaLn
 /sWxcx+gQuT2FrqIMnCitOBhqUUhOGh4wSldpl2ErkimJv2ZJni89DvW2
X-Gm-Gg: ASbGncvjcI5zxsWEvyYmkO20F64b/obzZHNQVIlpaJioXOub12cDy315eGoNminPiwq
 PU5wFuARDbFEd115oNPSUzRAooQpQ6oXpNyudN4qFP35tuuQvTVfLfDo0uhxS0ZWRYzP0QkqsHJ
 to30fidh96IsXH2T8K5+LTb7Dfc+ELV7phr6rpx84YQ1ZJUPMyK31T7TWuvkdenMmVRpn7wjOjv
 MBK0bl8bUgFH5P/s9oxmioqDCxt8f1haY9FYXQ7+hJsbiZ7STxz0QgSY6YLUz/DuPr/bSldkIyr
 xAVNs0Gru70OVlKwOOn//lCLInG17M7LW6HG78uymcBgzxyyGelRt1RY5QDsQOa8Mg38aq6uJ9w
 AgiLsDQcgwbIANPBNMS00etSv3i2zcGg/fWjj5yyYEyRNDhjLzA8=
X-Received: by 2002:a05:6300:8e0f:b0:220:81e2:eae4 with SMTP id
 adf61e73a8af0-220a1802be3mr1800500637.39.1750999970888; 
 Thu, 26 Jun 2025 21:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEST+KjOQ54DI0IPrdpkE9UNs2vnr6DCB4EYC2aGBYQSXt/9VurgBo/yWXbZFiosdiwmxeeeQ==
X-Received: by 2002:a05:6300:8e0f:b0:220:81e2:eae4 with SMTP id
 adf61e73a8af0-220a1802be3mr1800475637.39.1750999970386; 
 Thu, 26 Jun 2025 21:52:50 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e300ab8dsm631490a12.8.2025.06.26.21.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 21:52:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 s-vadapalli@ti.com, patrice.chotard@foss.st.com,
 jan.kiszka@siemens.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot@lists.denx.de
Subject: [PATCH v2] usb: dwc3: qcom: Add delays in UTMI clock selection for
 Qscratch
Date: Fri, 27 Jun 2025 10:22:44 +0530
Message-Id: <20250627045244.2225303-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8c3vwGbzi3siN_QgtO74J4EC-yThdR-8
X-Proofpoint-ORIG-GUID: 8c3vwGbzi3siN_QgtO74J4EC-yThdR-8
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685e23a4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bGMnijIEohOSe27sD7AA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAzNiBTYWx0ZWRfX8daEv+1ph8pO
 hfGpyJNqPDtkgmbGCJAw9mgmkQysOMcPSe5CpStokMxHoZmXtztoOjF2JwXOKvTTyH0jMbpupM0
 ICXhrOrkaoW4W22dMI4s9VwgbQ6Z2DIEBshkVriHonlr3zlTUvfjfP0rdjKGSx11q7Alvr9M2+i
 91fPyrBaWCaEv6dMA8yTnmOyMkJVOBpsylf61PBKgU9hxQPznzeUjl0OKZtHAbRWeEDJXBlQrha
 PuwsTh0cXEJieHueJPGSJhXkQL/qGk98TnmWv+XEjnXDggJKpO0GD5bGbiQpiKcmf0gWCjmKChR
 9lEsUhWKtDysV2qv1GBZbYGSuuauz3NHMN9+U8cR0V2FgZEChrFt2ZMX/lnGjuBE7eE/YbzWkO6
 1p0sKgL+n1DvaOxDqFaeMYEzqPVLQvkMnVaQq0OGkyUkvi1R7iObSX5frqwgzwyLbsxUx2uR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270036
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

Added delays before and after setting the PIPE_UTMI_CLK_SEL and
PIPE3_PHYSTATUS_SW bits in the Qscratch GENERAL_CFG register
during UTMI clock selection for DWC3 on Qualcomm platforms.

These delays help ensure proper timing and stability of the UTMI
clock switching sequence, potentially avoiding race conditions or
unstable PHY behavior during initialization.

Tested on platforms using Qscratch-based DWC3 PHY configuration.

This change is taken from this Linux kernel implementation:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/dwc3-qcom.c?id=a4333c3a6ba9ca9cff50a3c1d1bf193dc5489e1c

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Corrected typo in email id in Signed-off (in v1)
- Link to v1: https://lore.kernel.org/u-boot/20250627044304.2223767-1-balaji.selvanathan@oss.qualcomm.com/
---
 drivers/usb/dwc3/dwc3-generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 21452ad1569..4800eb64484 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -460,9 +460,13 @@ static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
 	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
 			  PIPE_UTMI_CLK_DIS);
 
+	udelay(100);
+
 	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
 			  PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
 
+	udelay(100);
+
 	clrbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
 			  PIPE_UTMI_CLK_DIS);
 }
-- 
2.34.1

