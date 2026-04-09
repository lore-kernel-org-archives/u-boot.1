Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37322F31E3E
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E474984142;
	Thu,  9 Apr 2026 17:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KofNQu1x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MoTxzeJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 989CE83CF5; Thu,  9 Apr 2026 16:44:09 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8AE78407E
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 16:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6399hvBY2246886
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 14:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XHCiR0Rh02pIUW8vRifIOowfChg3aEXzInmCkiGVeUk=; b=KofNQu1xXvGBRY2G
 6WjkZHpYMiep3EAq9joZKyyHRcCl+xsCrijXSCm0WCCq3fhkTcZ3SNUnBXjbEQNd
 /2Yo+RbnsOdyrNh78pYMcs/axzMO/IfUiWXT1YHw5UI3VbTAor77Ad4PtUv4zhat
 iV0fSje7pAt340lVhDaThRWOIaDbaJpnsevBTc8u/J5cRWW/imttJXf4Hp5fRLPO
 tlMne7bNMkw5LU/0ephdyWUSVb4rC5ZDRnjpt0967O42/jeGMFkwkI5i8kiOGaa2
 tNIlO6KXkGFNMfk8XjoTJ/Z59diIGcPPF0LGUTD6bkXm+fq3/iSm4eG7swWgj11l
 i4BRTQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4de3s6tkkh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 14:44:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2497cc190so5001515ad.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775745844; x=1776350644; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XHCiR0Rh02pIUW8vRifIOowfChg3aEXzInmCkiGVeUk=;
 b=MoTxzeJcQvC2WQe4sOztgDOZZG0vEDFczOa5wtk+Wtwyx/69y5ZvaJ7hB2AqyODmeM
 SZ3DO0odzkgYhhVxgAvyPtiXAq2oPHfHfFJO7M2mRxAwWwbuoSkmotqF6wEuBNmtF3dX
 HhfTPF9yDDlUFCNnmhHNtAJxBlBzG1+BQm8VyySo9xX10xbOMqxtam4Xe/IQXCPkdSo4
 tG+K86zksSkc0ant2cjBQXBrb6wSdN79kNsgT6P9+6G2jYNOHX5XB9WpJxCIy0XXrXu1
 ny3DfWUKsT5CTUSt0xo3JHobeI4zBgsDsp4ddHIhIF7yA/TVyuDzwTRYq94a5Rr0TtFI
 LRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775745844; x=1776350644;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XHCiR0Rh02pIUW8vRifIOowfChg3aEXzInmCkiGVeUk=;
 b=A+NxUwCbs7r+fhFspuk+sA59CHFjjwL0uHq2x4HBioHkO3N1SKaSahnkJ142Ifqv/B
 F/YJ5DdE8sNUj7xrPPD3n6BpKmuegQXEXp8yKU/U6vXdqqmNe4+lpJQtkdffbtkLhoc5
 YlyozALsUidxalWnnPyUhD5ge1cU7rR5JD8P0esXoDBRLe3oveud5dibAjRVN7u4B0Hq
 gQgziyLkZ47Af+Mi9rLZaXxP8Q905LqEZHR+DQOcRYGn2lrgYZNa7KirexTvRlv57Gqa
 5ea9rD5ZpbSHp1FTI6v0Imp+ToXGupNdYpwizoappNXkjMh8ZvfS0LW++nFs+1+7tjTx
 Xs1A==
X-Gm-Message-State: AOJu0Yy5cMsc2iNa7+Ti5Vk7lutweTtOh8YdWMSA9jAcdfKWI0PdO4ym
 YJRIpq4ZgQivbwPxh7kx2ChHX/xjJWw+Juxnh4xLO+8q6Ly6MYOTp9YJ9gbPhN1gXHzXsLfVL5I
 gdAYMAJuoE9kQF6khsuGsF/uxGmMAkRMOcQDpLLNqaxuBqp/TW3o5k3Kt
X-Gm-Gg: AeBDiev1vmbhu4rIiy0aWH+NPcqCdD5AKAk6KGC2kzleJlGAQwODxBEDWy17bCML62A
 HnYIKMKC9Rd8WWLKSB8l6Y71Q9zR1DToAhBI35fil07/i8RpuowLOTHOsNBvqKq+bElaGOOh2x5
 87AhseDrJ0DDJF4NaAQ9aa1aOjMpei5YnbuXiwtKkCqwWP5D/a/DCllUAUWW0GLolws1lPgv/eu
 XUrJoN0FZAdPARLoPLtagwYTXfN7Z15FJPmnLiNhTqTN7be3/mOLerO3NAt5OTOZaGKNLfONnjX
 /77sRJ97dgHRp3JxrVKcj7A5QKWsfqpbpy2S9Eba51ATolSu8x344HDa8LlZOJcB742MFy2eLcU
 2BEWtcovI1JCcvlo6F30ZRiq03RIw1VeXmoEDXoXlEBPCo0C6c1Xo3fPGnoGS4qewAPBoDj0e5W
 XPQabA++Q1ZmMWXOEKCrHo6oecx4XXEpO/zPI33zVpjnXBrpO7bQ==
X-Received: by 2002:a17:903:32c6:b0:2b0:ac1e:9730 with SMTP id
 d9443c01a7336-2b2c7347516mr34826835ad.14.1775745844294; 
 Thu, 09 Apr 2026 07:44:04 -0700 (PDT)
X-Received: by 2002:a17:903:32c6:b0:2b0:ac1e:9730 with SMTP id
 d9443c01a7336-2b2c7347516mr34826295ad.14.1775745843558; 
 Thu, 09 Apr 2026 07:44:03 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd85sm235083535ad.74.2026.04.09.07.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:44:03 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 20:13:32 +0530
Subject: [PATCH 2/4] drivers: ufs: qcom: Add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-spl_ufs_only-v1-2-f7e0e243d805@oss.qualcomm.com>
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
In-Reply-To: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775745813; l=1956;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=XL92QUuM9Wqahnq7FGb32axwy4msGeNWb+2k0gh+ze0=;
 b=19f0JLKBC/rSn1ob5/d2O08DlCIlVR/sY2WmBgpF4JiHrmzg5FzoURTt94aDxzm5JJWbzmmCQ
 BZep+1O7K7WB4ZqywAmzwPSRhFAZmZqCcZYMom58cNMaToQxD30Yz5Z
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: ZPyhelB1LzAihPfiNyWLUrQ37FaSAJBq
X-Proofpoint-GUID: ZPyhelB1LzAihPfiNyWLUrQ37FaSAJBq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNCBTYWx0ZWRfX8lSyLAODKpag
 oXyHBn6kHR/tUzGOtwYRqXeJOKypVDBhyFW8uyGZdSjS0lej/O4NXRI6YdSwU7/E5YCraFYGqv3
 2e23AOXuut9/O9sDvnQn4A/5FA7tPEZU84CWmzgcz1cTSZWqxkZB5cMRSJ5TmqiWpR2ZPwP7Ewg
 pdmJClCWDdPJW6PkE9csBWK1vsUbsm9W79J2hzhTeTAOmjAHEapn7Nok5uEE9Ej8Rz67i0y8LDv
 p9YbKWAIMI2VbRY61BOB5gR2LHj5c8Lt3uoVxre9JIOl69+7SjTyVFmPyjFRcWSUkC8RQd7fdnt
 qjDlmiwlgw1i7VTyL5XgSLvfITDKN08r+iq1LHWE79Ohp1YTYyVwEkt2N3uwA/Eg7310vwkYtbd
 JCatZncJqONTsXVxJYu0B82ZYNeWZPIJ+1nFx+4rOu2X6TO3oP1sc16u4A1xhj8ooycTGbRfJqM
 C7qmPSu5uQdIAHsn0VA==
X-Authority-Analysis: v=2.4 cv=TZemcxQh c=1 sm=1 tr=0 ts=69d7bb34 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=g6IXnUAnD-C3L3xnWwgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090134
X-Mailman-Approved-At: Thu, 09 Apr 2026 17:38:43 +0200
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

Enable Qualcomm UFS driver to be built for SPL. The ufs-uclass is
also built conditionally based on whether SPL or
U-Boot proper is being compiled.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/ufs/Kconfig  | 8 ++++++++
 drivers/ufs/Makefile | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..a32d51cae1d 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -55,6 +55,14 @@ config UFS_QCOM
 	  This selects the platform driver for the UFS host
 	  controller present on Qualcomm Snapdragon SoCs.
 
+config SPL_UFS_QCOM
+	bool "Qualcomm Host Controller driver for UFS in SPL"
+	depends on SPL_UFS_SUPPORT && ARCH_SNAPDRAGON
+	help
+	  This selects the platform driver for the UFS host
+	  controller present on Qualcomm Snapdragon SoCs for use in SPL.
+	  Enable this to use UFS as a boot device in SPL on Qualcomm platforms.
+
 config UFS_RENESAS
 	bool "Renesas R-Car S4 UFS Controller support"
 	depends on UFS
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..7056066ce25 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -3,13 +3,18 @@
 # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
 #
 
+ifdef CONFIG_SPL_BUILD
+obj-$(CONFIG_SPL_UFS_SUPPORT) += ufs-uclass.o
+else
 obj-$(CONFIG_UFS) += ufs-uclass.o
+endif
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
-obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
+obj-$(CONFIG_$(PHASE_)UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
 obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
 obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
+

-- 
2.34.1

