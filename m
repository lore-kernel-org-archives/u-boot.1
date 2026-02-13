Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85C7EDF148
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436B683E23;
	Fri, 13 Feb 2026 12:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VquWJG70";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R0CV9e0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3A383E48; Fri, 13 Feb 2026 12:28:12 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C3B183E21
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D547Nc1827717
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oIqmY1U2TTb
 vrEcBcH9cIyJaj8/Q2HSIPA3TzE2b4U8=; b=VquWJG70ItTsSMarArl/Uha7Aql
 m32DR9SAfEQ1I7pEhyw4ea0J3SLHziXvz3+5ZdWgNRi/yQwvKfnEMCjBkiqj0ZB1
 iqEMgBRjPzNCpAbfLsWB7MUwe4NpJWcVJg26TxHbcwNQfAl3/+/uqiaruTAFzKGf
 pghSZHgLGjplxl6TaO1OMjuZPtim5cLg/olgZmscrkVUPTg0DYuMaEaKiTkeTTjH
 rm+FqxHWtm6GAB0KxSfJYjeY9Ethw7R74ePAYwwhg2rTiZjzFIOjTtdZgTxUvk6O
 5pgOinqOseBvsEOBbU0/8cLmYSyZON3LjdX6WhwzyuSgML3ezAQNI3TUa1w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9wg01arj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:28:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aae146bab0so12050865ad.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770982087; x=1771586887; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIqmY1U2TTbvrEcBcH9cIyJaj8/Q2HSIPA3TzE2b4U8=;
 b=R0CV9e0ZXCMr4oMF7r63tA8GS1P/1FH8RwxxHrv3E69QtWBhVn9tqCX0ouipDLndbu
 FMCm64RVsfonNnyVr2+uVs/0LNccQqgdRFlzcaVCPB3jvSCnAHZ/0CNY4swJZLbDmlmz
 0tJ2JUhbU9MVqisS7sDj1vPo7NRqt1jyMYSLVR8TR0ATVFud3Y8rp7zW0lcHN7uO3/3z
 02zaL0rprINI+uneF/0kai6R+2rfI38kIkfzeYjLnlnI+cD4XucMyAPaizNmt7lsdk82
 o1gX/Jn8Biew1atXpMjr0jvrGcsNnOHRQsAuWY2CLKLODb95UsaRtI5n3p241n3EJuUA
 StCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770982087; x=1771586887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oIqmY1U2TTbvrEcBcH9cIyJaj8/Q2HSIPA3TzE2b4U8=;
 b=EWPEgBynPA5ooSHAEfb9tLFD7eZECarU+jpYcjRG3KZViXNQikHtzGjnpm2yb5Xaet
 3C1pKyuIiMBeZs10Lt+LX8amrDqqkFQmaGJlOjD3IPcSIow6qrYVd+8qjouV5QwWyWJX
 vu8ko13+SrbLTk1MJS+qDC4poJSBi3MsOX/fgCIWuwFcPM5sM9W3C+X5tnAWvSSnGPIH
 bqejcx5O0btPizHkHyNhDGdYhmnzD/fFNfK7WyFQpRP8xznR5RICHi+zD2tbiEmpXXx2
 y4PDPmqejZJb03nCchq4lXqv7B470YvX51yyIT5tWXEHDYSr0KfDSYi2onLh6UUC9Hm4
 q/1g==
X-Gm-Message-State: AOJu0YxpWxsjMB5S59H4Nx4gP8KaeW8ZNpURFmYk+CPrZCQ0uy9vpeqH
 qmucJ0HxlCS0IRgeGR8fyU9X5X6+YxuaNkFioKA8QfP8c6f/OIK0dDsOOnjPgeYLJIkMW75dP+r
 4Y9wyxRsF48HeTZdDoK8ehrqX9PL0PsXWwnwTOhfrEgrGdFE+/jV87EI3e6pKILrP
X-Gm-Gg: AZuq6aK5ElTX0/2+X75osweOzMr0+mq+VVBUtIWexoip19GrodKgaNZ/WfvlbcmC5u/
 8M9YIVlfe8V1fuOXjXnVuFBj19t/tMlJFbYDLenqYPE5EgfHLeXT7rlxlDlsC2kVYeCdaaHTRn7
 kaiMIlG51G9bgP/WXXwbqMAqejzLZFSj+yESMMyvC+D6WSnBWLqNNI2ogfGWCJ4xLoWJd7HOJ2A
 vwXIsQxFi60utEZhzLk5gZJXBDOu5q3V69HIk1P4u9DttQhYoRITdkuGsBPoifu4KiD/jZxo3vo
 axmOiFboJ5g9hWDiJHUJf5tCNiB5o0QyOvyARbjTgM2q8bN92+nIr+dwcC9O7gLmExq3ZM5ufu7
 ZaQE7UkJLzjCt2YUp8L4NkZPxqo3wMKpz76ZABOim34JqY1GbJoHFWPG03/xX2EUBN7iRrI2UFq
 tOB3flWsLjpU6OKEVuGCgXE4R1SS6T7GPGMvphI8Fv
X-Received: by 2002:a17:902:ce91:b0:2aa:f469:fa32 with SMTP id
 d9443c01a7336-2ab50521f2dmr17242235ad.5.1770982086738; 
 Fri, 13 Feb 2026 03:28:06 -0800 (PST)
X-Received: by 2002:a17:902:ce91:b0:2aa:f469:fa32 with SMTP id
 d9443c01a7336-2ab50521f2dmr17241855ad.5.1770982086234; 
 Fri, 13 Feb 2026 03:28:06 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1969f314sm7996939a12.8.2026.02.13.03.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:28:05 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: seanga2@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2 5/6] dts: qcs615-ride-u-boot.dtsi: Add reboot-mode support
Date: Fri, 13 Feb 2026 16:57:16 +0530
Message-Id: <20260213112717.1256823-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NyBTYWx0ZWRfX9Vgpr8HEmvP6
 ZQ3uHrfRW2oDnLSDLLY5ZqdV4gNokY2y+yOTPfI905cTkCANuecaVWavAb1rQTR5t7MH3AfcDIK
 B+d7TmcZrjvukaT5ztvNCGxlyH+vmwbqIflT8XsX7YvW3B4QlTt/g8wUOs5PeI+rn7Lms/Ao5eE
 cU2IgRcRHcKGynJJ3msLKR3S2P0UiYvWroxovaRWMPekvAkAnH3YcjszZCCUjv2K+WC5p2GkMBK
 dl7EfEpVV9c2YC4BqURnsLU6DCDZ9jiCfMZ9mEVidUNC278OWNmFfVUEM7h/OdkjzhGcKzUyTE0
 nrrvq5MRQIEt4UQG2l1IAPfeRjqHTp0lbPh0FxW2J2jm+SUDYGF4Meq+oE1smdF0fdITIwHc3Jv
 XghBfDwm9UCljNWOYJpZ2RZl7btIDVbBR9ipO4vP4CJ4UGq91KLVpCgh1LW0olnn5rfppbHxMYv
 +Vu+KRdWSIRd/UBu75A==
X-Proofpoint-ORIG-GUID: 6HrmmfTUXtcbWSsi7KZgHut1d10S1dIb
X-Proofpoint-GUID: 6HrmmfTUXtcbWSsi7KZgHut1d10S1dIb
X-Authority-Analysis: v=2.4 cv=bo5BxUai c=1 sm=1 tr=0 ts=698f0ac7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=yUmxN5dSmvX78ioYZS4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_02,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130087
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

The PM8150 PMIC on this platform uses the older PON (Power On) register
architecture rather than dedicated SDAM regions found in newer PMIC
generations. To enable reboot-mode functionality with the unified
NVMEM-based approach, add a compatibility wrapper that exposes PON
registers through the SDAM NVMEM interface.

Add device tree configuration:
- NVMEM node with compatible "qcom,spmi-sdam" wrapping PON registers
- Uses 'ranges' property to map the PON register block at offset 0x800
- NVMEM cell at offset 0x8F (PON_SOFT_RB_SPARE register)
- 7-bit field (bits [7:1]) for reboot reason, preserving bit 0
- Mode mappings: bootloader=0x02, recovery=0x01

This wrapper allows the SDAM NVMEM driver to access PON registers
transparently, providing a unified interface for both PON-based (older)
and SDAM-based (newer) PMIC generations.

The PON_SOFT_RB_SPARE register persists across warm resets and is
automatically cleared on power cycle.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/dts/qcs615-ride-u-boot.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
index 68fffc70fcb..50784807cf4 100644
--- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
+++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
@@ -11,4 +11,30 @@
 		      <0x0 0xc0000000 0x0 0xc0000000>,
 		      <0x1 0x80000000 0x1 0x00000000>;
 	};
+
+	reboot-mode {
+		compatible = "nvmem-reboot-mode";
+		nvmem-cells = <&reboot_reason>;
+		nvmem-cell-names = "reboot-mode";
+
+		mode-bootloader = <0x02>;
+		mode-recovery   = <0x01>;
+	};
+};
+
+&pm8150_0 {
+	/* Virtual NVMEM node for PON-based reboot reason storage */
+	nvram@800 {
+		compatible = "qcom,spmi-sdam";
+		reg = <0x800>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x800 0x100>;
+
+		/* Reboot reason cell at PON_SOFT_RB_SPARE (0x88F) */
+		reboot_reason: reboot-reason@8f {
+			reg = <0x8f 0x1>;
+			bits = <0x01 0x07>;
+		};
+	};
 };
-- 
2.34.1

