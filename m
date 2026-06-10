Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8E0CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 05:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F3D8467E;
	Wed, 10 Jun 2026 07:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hJ90P7Lp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WKKSV9/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1AF8407D; Wed, 10 Jun 2026 07:37:29 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19DC846BE
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A4Wl9m571792
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=12wvQnemghb
 XyXo/fGrJ5/v3SXAtT8hAmEu4McajIzs=; b=hJ90P7Lpeev4ZyfrwM6ABISUy/L
 DakD0CIFOSjq9bDZiuSAd54hnWQeoMbvzXchPeqPbcyOPoxN+vMVr9mg3jmjs8dR
 15Weqy2tZ+q73xKJdloF/DAnklCsfI9A+U81dnJ7s2ZtcVM9L4LeU18lzl0EKGbJ
 xp18/96psIzpZRueyAmPf6YeFievy+WsPOJqDuc5OPV7K6WMxtiQAztp/6UZehiK
 ZLSNAdGGLcx/QYIhqjkS0jUUxMEIE0mDFmnCQf1PtReL1q6/f87hg/nUOza5g5R2
 xGePGpOPAKrHYaXYt6PLVi3+8lMuM4VUPCnwEZUSUxDk4WGwWcyFYQ5xN+Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a8673-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:37:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36b7c55406bso4545938a91.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781069844; x=1781674644; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=12wvQnemghbXyXo/fGrJ5/v3SXAtT8hAmEu4McajIzs=;
 b=WKKSV9/VysbHriVad3eFF8icyy27dIAHY/t6jnZ2IYcVaEW90g+uOSQ/El+Y541bE4
 dsI70ihzjctMZBBvfaegLYdIsXafSm7lM4skqzmtRXBJW5ucnX8fksCwURrGP1lGsfNo
 29L1NwHps4zQZgEzUNGt/bHJE2L0TEcANcmK2Vy2UaB4mVf2e482WkgaIusq1avdATzv
 lSxaKP7In6W73DhSjWLMe+wvQMedqCu3tBZfPqvWHcF5/rtOv95z9DTranlLxxhmmYVz
 CV9MSWnbMHOYIp0do0WmepCvgZgRYG7QSBZGT85tvEgX7LOGiKCh66YZC3IHsl91PzTz
 UUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781069844; x=1781674644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=12wvQnemghbXyXo/fGrJ5/v3SXAtT8hAmEu4McajIzs=;
 b=kFlzkRF0jPiCLOxSuT0XAuNNiQC5G9aQ6kKonAT0CYip0TDdkobkpnf3X/EMzX8Ipi
 t7QTEjoEYihGjqLb5GC+IdxIk8PpinwTZhCrOHaQ5IQ2CB9Yjx6SfpYAaXl4IsR1qVNC
 ngGz8v/pb5dr9gQ0QPxAJNu9d7ux0yllcDtcLWBELAkV+Xa1ERBB9nK8S9w7kN3BpWOa
 ZVFXfRdptbYiGAuvWkKc5srOJjFJUoezjIjF9NtCubXRXoKJoDZ0vB8cq7vBDwnL47rE
 Mnwd6KDQ4zFaKscC811FVIWkI2o+YZDJAQ/+jW1gnY8NBrBPhNBLXem5ESehbv/ckcnc
 3Tjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RBzuyhGxVQDX+Nag4TGnF6+Dchegkkt4yFqXakChcbTkz6Gzdkov/RMxowluOqzz9CgL4w/I=@lists.denx.de
X-Gm-Message-State: AOJu0YyN3Fjhuzdl4Zu9SuZgztVDm8ZWe11cZyB90xP9w1NMHXXiuj5T
 pWst31NxwHwm+TmTQJ+FvKGQB9hURafnPTVhQl7fjya2D+VFjKewqgD6Ux5VJ1WPuLoT9xX+ZFH
 ap9OUQMlrm2EElob8jXtuR6cwKRJY28a08xm8ZFPynOdnkW1xq+Yfc2V6
X-Gm-Gg: Acq92OFxiqNvkvabw+2qhQ1gzGG1BBbBmwRi+m+mP12SFsQIRjRvKEVUY+oeio2EUct
 tBfcAi7kJNb3R1xnx6b9H4Ue6db4UDIzLy0P1zeEmth7pAoZDrpfJWgJ9u1fIxtcl2mqYYlZcsN
 X2Ord9tErNrIuXCY97PEGEV+sMPVSXHVH6c7/I2c23/whnne6O9jU6rCtA4UOtQXj65a2CBVPu8
 rmkyWcFX79uF9rgpJnwlf4vK8vzuwelxkBYLXq/DRK/8kM+r8ig6l6o/CnR6vwRU+akhoNXuvie
 h39uOFGlE85p4r8U8dHRowfk9AFWHIG4iRRbf6tGzTZeUnE6HQ8DaSx8V3aUc3QskrXi/RMBxE3
 4gqdTCMzs/jGt+e2AzfZKqF9iEyy8tDG9BHKX54LKu7DwvZatWblFx3p48egYf3qIjWZ52Ovr4N
 jozCx9dmpulQ1sHXFMuJ1JTn8G4NDzh+qHZM2+b68i3aE4txbtogZ2
X-Received: by 2002:a17:90b:390e:b0:368:1064:62f7 with SMTP id
 98e67ed59e1d1-370ee33cfabmr24996440a91.6.1781069844086; 
 Tue, 09 Jun 2026 22:37:24 -0700 (PDT)
X-Received: by 2002:a17:90b:390e:b0:368:1064:62f7 with SMTP id
 98e67ed59e1d1-370ee33cfabmr24996411a91.6.1781069843508; 
 Tue, 09 Jun 2026 22:37:23 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-376467bab00sm831918a91.2.2026.06.09.22.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 22:37:23 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 quic_varada@quicinc.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrian@mainlining.org, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 3/4] arm: dts: ipq9650: Add override dtsi
Date: Wed, 10 Jun 2026 11:06:54 +0530
Message-Id: <20260610053655.2825589-4-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
References: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a28f815 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=hd9ws4i4fi2IlGS9FWgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: _ebsAMiy9I2A8Av1_-RGdYoDUgIPx3m5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MCBTYWx0ZWRfXx9NkwifUnnhV
 YOwl5bMdKI/PHHOjAAUT5rkZUHuAjv3nJQjPC5ykU66N0VBPXuDwDxi0T0lyba8OIglIu7EGLpa
 Lbu2CkXsQZyhVL9vpRE5G9hD+39+B54vagKCwFnRSqNoje9Qxb3fcLVTJD5R+xIqqOOJWtiHVAd
 8ds9LFC/P0cvPDmqICsx/zBLHU8zDzPg5vYoJetDrhJwFdM+ig7XEYGRpKjOO8Nc+0dukwn17ty
 kdAXy5sQ0IYWZLm5ceauIzAzz60VvfmVJZm2upnTdam3OoRJkWp4UUTHrnyaz9bzq5bsioWDi3a
 672PgPlxw0dZqGzEA08FYP1psGA3dUD5sJNaXnQWeDqh0y2tvKddjJ2JKFR4O8GfzbhYMobiqMF
 Jr63ksbGxpQ23jnO6nmYdN0iugo97WzKOOaAb3XEziwy/aAWH293DlJJ/1PS0Vq6LUfZ2SvDUKc
 zAsGGVZjLoLntnofGRw==
X-Proofpoint-GUID: _ebsAMiy9I2A8Av1_-RGdYoDUgIPx3m5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100050
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

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
Changes in v2:
- Fix SPDX license identifier to GPL-2.0-only (reported by Ferass)

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

