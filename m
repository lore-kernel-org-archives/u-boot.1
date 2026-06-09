Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19B4CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 09:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3D48484F;
	Tue,  9 Jun 2026 11:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYIZqY/w";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B0mp3dco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB1F8484F; Tue,  9 Jun 2026 11:20:04 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B1C84851
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 11:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6599K0oY1784314
 for <u-boot@lists.denx.de>; Tue, 9 Jun 2026 09:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6j/DoWN5+fK
 +M1TjHKMryVB1TasAwwcbH0daN3HdBK4=; b=RYIZqY/wabRYKU911vgWwJKN7tX
 9Y3jQgfq2XOMIZXlPB9qQ8vxE5DZ5U6qLPJYT1Fooi7aKqtpEyXL2DkSwmdDdewC
 qk25UdLMIcqBMyDh6qFDR7JEzXc/UkSWSXl+jc4bHKJRankWKDc4e6FClSIFAk+r
 LNysCGeZMFdPCAW5/bxI1fwoTL5lQFWfDVo1MMbR/3S3hY+aFSlz11p4CHlUR8FT
 ycGf+QlR4k8a7jhZFV7+ZO65IEuLHQoDpLuP8veAthCIZ3lTSLiIYwDHEJqBH8yE
 veITl8076nHTuTOE94JLr9vDlWI9kNRvKlBkmfN0oL4Y/ZWXMff7OK04iYQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wg018-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:20:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36ba98cc003so3718632a91.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780996800; x=1781601600; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j/DoWN5+fK+M1TjHKMryVB1TasAwwcbH0daN3HdBK4=;
 b=B0mp3dcoA2ItV/p2K38Bfgsplz6e23oYkrNZMnbgHJhkVDmAVqiWxgLT57h5GukH05
 BwlrnEjC1cXo5S7zQALxPM8otaxc4pcxEy0vYCQjVz+I0rKeNUDo76xme9mykGnzTooz
 QwGiDd/5UE16oKlhcy8RcJeZQLg6YuVULKBq+VRnxiDgUxjJUQ48PH3nYiAMJIGiKwsk
 lzOylUX4H9qhBZYOUS4H6RziCl0/Gx4gPmwwircQeDYCFnYAc2SVqq0bqjNy2LQiVpX7
 VP+NiCKhuqazmgQK538eG9DbVznX2liglCIggFjuwVvyVjRQrfe5HrbNElscnG7NCWRR
 DSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996800; x=1781601600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6j/DoWN5+fK+M1TjHKMryVB1TasAwwcbH0daN3HdBK4=;
 b=rcUqI0ofXHSoUdOV6NYJYIbS2YyoD70qDQGPU/uPmZFTJK0x9qF3lrv9sYonk3Lt/w
 2P7up+kjWIZbARj27AECANrLQYaIV/24/pUJGnQ7jWLhafvW8If8y7DwEyEne28s0jRc
 c5Zx5gL1FfME+7wm1PbY9msta+gK4TkMw8HHpxXZnbxHKDMn5BRydN2zKbUtvJlKQ8Ci
 iEL5JvH4t2A6xYO+wfE3DWW85PBknH1VQdd16JSj6irSlQyrCIJzlPMycvUS7Uye86Pw
 SO4y86W+z+9qspnx9WTS55TFa/MIdRgJwhCgvQM9NvBAiZaNjt+kVKro0S9f0nvWUukA
 xACQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UdD8JGsURpMxsWPOsKmsEZWPo7GfgunX4wf5UzdbXw3aq0tObgnNSCqvQfonErslLyxumtQ8=@lists.denx.de
X-Gm-Message-State: AOJu0YwfW0k0nRFMn7Gxp6IgGzcCiSCufih7YxTX1t6w3YJPMzLxWem3
 BZ37n3K9YYSwRrvvWuwfXFmdSFLCEY+/NoVGFOPxvGBKQue+qtgIkkg2o5czaK94s2bjRHNwRp0
 RmFWPrEozyVkYadxjcqeX+VO6WSmbzc25Fk8wxV/+YwqCavlstOhLHgeD
X-Gm-Gg: Acq92OFlL7uDEHBQR2bUAVi5EkJ1E9S9i/LHzCtf3P8yZQX5kedqKgYek1MISF1jqpl
 bsSAW9p3Z7cR4ZQHIvgrEBs1Z/DcpitYA4CEBusmoWrlDznP7+0bO0imR1i+NAngQ2qS4WBrblC
 dyreJB9U2Zj//GrC6qzEYGTUwVYB6wz30AOUAEO7e03F4rCdmDSSF7G1FxPKnIIDRu/mt8AlwbH
 7Qz5n1j9Jr3GnTj1w/N43IosoY6qqCx4QhR+bp+IiqM6dsrWiO+Nv2KWPvSaHWwGEi38YNseXTG
 4KO7X6KGNcNicD+oviaSyzL7M0aKY6FKP/Oa+4DMauZhkw8Oe+HlGhjGzvbPS6knJ8UfUSXLVbO
 75C67pHCWbzD+9axG4HeibjyyvmBAg3RLiJpDgRmpYObOjcffaTwpr+/H0PED8fPFtPQgniD/67
 Z8PLzMW3xbj0456XxrjVB6RctSCTOKxufPRrFvNdne6QKoFC26H8xU
X-Received: by 2002:a17:90b:54c3:b0:36a:d6dd:9fee with SMTP id
 98e67ed59e1d1-37520dc57d2mr2468046a91.12.1780996799684; 
 Tue, 09 Jun 2026 02:19:59 -0700 (PDT)
X-Received: by 2002:a17:90b:54c3:b0:36a:d6dd:9fee with SMTP id
 98e67ed59e1d1-37520dc57d2mr2468016a91.12.1780996799274; 
 Tue, 09 Jun 2026 02:19:59 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf90a32sm22851397a91.1.2026.06.09.02.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:19:58 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: funderscore@postmarketos.org
Cc: adrian@mainlining.org, aswin.murugan@oss.qualcomm.com,
 badhrinath.s@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 casey.connolly@linaro.org, danila@jiaxyga.com,
 david.wronek@mainlining.org, jh80.chung@samsung.com,
 luca.weiss@fairphone.com, lukma@denx.de,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quic_varada@quicinc.com,
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 3/4] arm: dts: ipq9650: Add override dtsi
Date: Tue,  9 Jun 2026 14:49:27 +0530
Message-Id: <20260609091928.1564605-4-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609091928.1564605-1-badhrinath.s@oss.qualcomm.com>
References: <tg62gv.1na72fsokrnbj@postmarketos.org>
 <20260609091928.1564605-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NiBTYWx0ZWRfX6cWNpuFu1JOH
 28UWdLHR08vI/c10hEYks9VX/wRwb949J+uxmEG1IzBdBjdk+BPR7JqnsjziRHXnsEqlWDUkglg
 62FiQDi64+MvDvDj4HB/CKwcSo8UT94UB+AwDTqKL7Eor05vtt2CxmNtwnxYaWKyUvWGji7SLOa
 hBYXq7JSbSiKAQ7NYvWiD09jz+ncIdum1tm+MexyJCCJW/nvHaAhoc2a7P+P5lKiDNfKdXcYAyV
 l7wiKSbgLlP18vPdrerkQcWF4JTvieIiw9j81C5TFAx+LAQ6WbqGSpJOfCMVI7yEuCg0KDsRvnH
 telXJ/horm7y1ml+wZ37a+K5LGu0KlMDqFrWfdylV1wf8wgww/jgf88CNUPtAMWR6tht7Itqa1F
 ppj47JpmCqEAPkOaSxlO+xqn5wpsyySaM1ionlFmf5v1T25EIkoO4GcC8I6ZeseRAL/YYIBblIA
 qjlP3Bk0Idpjmr93Grw==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a27dac0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=hd9ws4i4fi2IlGS9FWgA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: wSM-dFYIDdbXO7S_MDu0vkNd3UW_ezqT
X-Proofpoint-ORIG-GUID: wSM-dFYIDdbXO7S_MDu0vkNd3UW_ezqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090086
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

Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
This includes memory configuration and SDHCI reset configuration.

Changes in v2:
- Fix SPDX license identifier to GPL-2.0-only (reported by Ferass)

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
new file mode 100644
index 000000000000..4733fc7ccd08
--- /dev/null
+++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IPQ9650 RDP488 board device tree source
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+};
+
+&sdhc {
+	sdhci-caps-mask = <0x0 0x04000000>;
+	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
+
+	/*
+	 * This reset is needed to clear out the settings done by
+	 * previous boot loader. Without this the SDHCI_RESET_ALL
+	 * reset done sdhci_init() times out.
+	 */
+	resets = <&gcc GCC_SDCC_BCR>;
+
+	status = "okay";
+};
-- 
2.34.1

