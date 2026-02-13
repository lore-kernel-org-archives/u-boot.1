Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33877EF48EE
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD4283B9D;
	Fri, 13 Feb 2026 10:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WD7zJa4P";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JjNgzr5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9756B80FA1; Fri, 13 Feb 2026 10:01:49 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E217D80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7lvgH3424171
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=q0kdyqLqvtm5CfiRJASn2L
 9e9c/lXQy1Nkpin8ASIQc=; b=WD7zJa4PyLBrm8jK8+hJYP5Unv3OF5G3b9fv5e
 BlBz4e3z1+lq5ZV93sMuDJuZiHBHc+dhE21lV2xsNPpKHK/ThpJscyQMbmuD8otr
 79o9mLjvuZaL8KFKK1BFT2+Z4GLvaXQyS5eq2PQ7TrW5Z090lZQWuuypAIU5EpV+
 V/9Dx9uVTRPLbrmBya+i5vbWSFG6psuFck4iH15wl0DTdcUnAdxI0wLKaN6hUj6O
 PCs7FfeckJkXQGJz6XH+xMMZTnJ6CH04vrhfg77tGHQAQMfNgusgGBr3qLQwRqsS
 peSj1wx8oBYag8Ao0SqAud147HZRJg85e0eYPq7UwtBxcmVw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9yvrr9r6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:01:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ab4de9580dso21872385ad.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770973299; x=1771578099; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q0kdyqLqvtm5CfiRJASn2L9e9c/lXQy1Nkpin8ASIQc=;
 b=JjNgzr5ta21j3BFhbB3m6PdMQMXpuJ4dmS0UCkkn02ZqfJOozSVXoYwN9l92GHOsfH
 kj30eH0a4/VdT8t4F2paMN4ky+dHcUGM6gGhw02Mita5XBeRio1hh/WvvPsSZ7jGn8GJ
 WX+4XAcr3gAfUiK+c3d19hRczmPlEuU73dX9ma4G61st6/wImE+p9n8m61xhbY97FJQe
 T3FYR1VB4QQzrTd4t/AHWwluMOF6/+Q1ZgQhwTnS671M5JupJoeTWRMirtHNomg3D8/S
 bbJdBjkYKaK5SWMpgn/ZodrvfLwVn67W10aQL6G749FSAlzxPuTSGXsKCJjcou5KK9Ve
 jbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770973299; x=1771578099;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0kdyqLqvtm5CfiRJASn2L9e9c/lXQy1Nkpin8ASIQc=;
 b=Wy7TVyTPAsd57gzpSSLtGETXonqOlPDnP+lw1WRuVPTW/R21khNqgcukg7tdy0XeB4
 ibm1kMkYpfXcA0nGbqCXzsQ0fJyvXsuuBseSC5OHxZz1WXe8uNgus6X2crFx8UyeYk4B
 HQNYBhnON3TicXks7P6gkszKfp+Qd/dh9aytIohARX25sKxVhnpOehQBTQIytV1emw6b
 UqGJrUNqaCo88rlwCuMy5peQ0xk27vV6PCN/4hRQg/88xbsyQFwOEi7mDiRmV3yYvb0O
 oPIgG14iAh1Dh1NDkq4DLpWbRSKqsqSwvMEQ+D+A/tujPasaor62gA8sgZ4D8vcwbyF2
 YJLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH3fUuxW60wo+G7aEdHaXamAAGw0JOuqPs3iy/JxLBMXyaATx3idOEcCB034CMITX7OtyZqOc=@lists.denx.de
X-Gm-Message-State: AOJu0YzIqKbBtM63Mxg92uqFFTfhjT91XGgmbNaNAbBoR7vrDGZk4hB/
 JTJtzai8nFWQQdCc2yNq1jI8dpdy1Y2U34pwj4e0CqYZ1o20+hptRmC/cap7WPSJhGCOEdViFwb
 1lw9TbQelZ7+VfM0kn3Mrdr1tyiybuIO7J0aVAFvWGLzWda9JzWWSOaX9
X-Gm-Gg: AZuq6aIESAuXYMGQhH9ik9QMqtAmToWEdHhH04Q1CgPKMTGQRtL9U0+CKgy4k+q3+V5
 wwNQW3+pzcYEWLqNoT8K4jFy9ABXd1eEEk07vt89FieRNZp5JTonb1nJLuNGSS71+vPTkgKlXXx
 EpNlBOk8n5Zri4BL3GvTczPjtLn41e2lwlyBH5CT135IWersN2EWjrj+n/3vQItWMntU9DBH4cb
 8ULhqX4GhudsLaCtxDn69YHh3FCPkSJp6QrhWHfAq3YhsCvEH/L3AsE9Uu6Ofi8dIqRz7hnXZnt
 CjLlUUpPydk5JS+93Qk5cX/N2WcWStizWHu7Q00Cl+tdKYxql8mBmweYSc5PCmku9Uej4KN3BOv
 jjy+ZPHsrCMsgXdwfdbtt6vxmer6ab7tKC7e8htPSqBvsJPPvhPUzkvGxeDNGRHhcTT4pOz+3d3
 /ApcBk0Hc27yqaG/dnS6p6Y+KTIRKdN5vVZPkRGz/qaVS4/y7ktQ==
X-Received: by 2002:a17:903:2f8b:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-2ab505d435amr12707055ad.45.1770973298974; 
 Fri, 13 Feb 2026 01:01:38 -0800 (PST)
X-Received: by 2002:a17:903:2f8b:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-2ab505d435amr12706695ad.45.1770973298510; 
 Fri, 13 Feb 2026 01:01:38 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29965055sm77524755ad.53.2026.02.13.01.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 01:01:38 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/3] Enable USB High-Speed support for QCS615
Date: Fri, 13 Feb 2026 14:31:17 +0530
Message-Id: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF7ojmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Nj3ZLEnPzi+NLiJN3kZEsz0xRzi5TU5CQloPqCotS0zAqwWdGxtbU
 A96uOJFsAAAA=
X-Change-ID: 20260213-talos_usb-cc965d78decb
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770973294; l=1251;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=GkuNp66mutzhA5mFc4KzYJ/T9Q+x23IIXY1cmU//G+Y=;
 b=rukagiggo9ZEUAyFcnJnjI1mgAN05VdlKVn4/HfuJpc9qQw8ro1xQAPA1rrKwAVV7rOk+345E
 COgs5GB+ShYB6QL3DoKNaLYnFUVcQPGEO4C3GHLpqpS42DOFpRLGwQ8
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: nt64WGeWNDPgypyQyrHF69hE8t7LpXfM
X-Proofpoint-ORIG-GUID: nt64WGeWNDPgypyQyrHF69hE8t7LpXfM
X-Authority-Analysis: v=2.4 cv=LNZrgZW9 c=1 sm=1 tr=0 ts=698ee873 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JvwIKKDnixl23u57iVwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA2OSBTYWx0ZWRfX2kYou4GBNH9K
 JR8yNYZar2O/0DIuJ2VLnXiXC73pGXx4UJxQ2PmVPcet+IlpsrhoWiBl8fXQGS1kQdqSt+4M+n8
 RslcVHO5aeuvuIuXPGCxtQL+4AkNZmqKw/TxjLc1pWy346sk5ISloZdajttWSSOjJwSweSAgtxe
 bEy+4t+qN9xTQuxYq37mLkroNgN20kJiVQNtopZJmXW9NebNIq7PIdCyGX/ubNN7tzaNC6+jx7Q
 V0d2xxcgRSMdQfS3lYcG355XdZwGKQ/M55eokeE2MD9rjJBLZcOA8j5XHKT/lErWgHy9skZNZmt
 d8jeHz3WxEV7TSm2YIokQ+N1jahCSp8iMVXjRObP+yggobdI6wSMEjhNG8CFLhEN21CA6Qp+eJ7
 MAX4NgIssvm7Lh9szabuWgH+jwsSum5JXEuxst+NpScfjgYpPK1f/WpdvGpQXWcjaVj7liqc2D+
 L9w0lNdHzDZpVJcFCXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130069
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

This series enables USB High-Speed functionality on QCS615 by
adding missing clock support and QUSB2 PHY support.

---
Changes in v3:
- Implemented GCC_USB3_PRIM_CLKREF_CLK in clock driver instead of
  using device tree override (addressing review feedback)
- Dropped the device tree override patch from v2
- Link to v2: https://lore.kernel.org/u-boot/20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com/

Changes in v2:
- Updated to the reference commit for the QCS615 QUSB2 PHY support
- Link to v1: https://lore.kernel.org/u-boot/20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Balaji Selvanathan (3):
      clk: qcom: qcs615: Add GCC_USB3_PRIM_CLKREF_CLK support
      clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock support
      phy: qcom: qusb2: Add QCS615 QUSB2 PHY support

 drivers/clk/qcom/clock-qcs615.c   |  2 ++
 drivers/phy/qcom/phy-qcom-qusb2.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
---
base-commit: fd53b78a796335fe3d9f85637657a93991b708a6
change-id: 20260213-talos_usb-cc965d78decb

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

