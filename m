Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D02CCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B09C8493A;
	Mon, 15 Jun 2026 10:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XnUMNsrh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="id2mVs7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766BC83FEE; Mon, 15 Jun 2026 09:02:33 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CA983FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6Lrld3853904
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nSiGLhu/4iuRAoQ+FdDehY5gIBAOhwBvSWxN77akIV0=; b=XnUMNsrhaDTvr1FP
 YAxcFoc7UmB4viSxWQdEAelMW6uYa0TvOb+CCOp0wpr+NMq4AN6ue4F8iWj3zgYl
 47Utqco5HteM15WeD9mHRh1qpMKKE2z883aqck4LTU1Lt7ZAyKQBxG8vp1Okfb4v
 raMRK51XN1xZKI+y0b03YuYUfeBVLU9VVTqPlsE+zaABVYs6IooxNzMAJ1SyuEDK
 NzSnSYRcC9F8Tvs/BO8Go3g4I4TLeldgeV9eTS9RPpsex1Jy1ymQtyYvtsILzSxq
 Wz2QnSe255w8+FyffMkjSm72T4yJJCPBeorHSPOpXu5BXZAT4FWVy6OXO25PUfig
 61zIRA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gx5hy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:02:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8422b1354edso3971488b3a.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506948; x=1782111748; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nSiGLhu/4iuRAoQ+FdDehY5gIBAOhwBvSWxN77akIV0=;
 b=id2mVs7AoN5Wa99Mq01IOMZAJS8EXrvNsBhYeX9J0QeNZtQQ+p9B0ZixbsXLG6rs/R
 BYENYwWvyeEp/XEhIzErU5mrctncaakZbhnJblkkBQkTzwmFJp8ChOEVM4CiZC2qYbEw
 eIEd0Cjj7tEyWiKSr1FcXJ91EKdNqb5qhdHn8uXs/XOFq3dE1K9Rs5XAwjbCY27qLUEv
 7sh9GBvxSytnjNPDehJeEISs61zf6g05Tr55eLE8qBbenrBP6KI3/AABVA9fdyq9ynpJ
 NTakHIEY/86ilED78H3OothxwIMM34OoM1DwRHdrsujO/16k/E/E8kScYB8N0jfQrXJB
 Juhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506948; x=1782111748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nSiGLhu/4iuRAoQ+FdDehY5gIBAOhwBvSWxN77akIV0=;
 b=MAyyWfc+MTU6KT8m140QFDkW6C+RqJdpjjCd2yX7f77O6wdDD+KI0csV5njfBCqUxD
 ft6vMGHA7DJbl6vsdO+JHjZzIzQZmAWXINTM4rdMzsitg6q8B39bCbtiEHvi8+zK5Y30
 6ET7JJoqBoPOHYva8RpFM3u6qIcHvdLPzDZgMgrGVBBjPQrqZTpQpnBXx324BJnzGcbc
 O3dvlZpAFkrBaO5EUea3jOrZKGR6FiUfhBUouroAljxjBms7R+AJpuP2flZaEMYoytrF
 uO+dyg3NP95V57hGY/tm+S0Pak0RHKw6e9sFly2/86idJjPjG/yDF7GHgMubQDnmlFcI
 o98g==
X-Gm-Message-State: AOJu0YzGNqxXcpJBZYfqAxKqSj383artMeUA0f2RlKb2fBjemchBA6e4
 kbVf+y0OCdjObuhaMecBpte5q4YrAQaT3uReqxXN6HCipgH2x/HjeGuSb86NIS4re1IGtOCn7bG
 z6hWhP1Ewgj6xR0jdbt8WVCPrJZRDa1/1qveyCCUoN9n+b3VvdYAW4D07
X-Gm-Gg: Acq92OE2rmJyMYZo5qXbPQ46uTul0QmeNfgHFEE3MR1ZRovDqKy9ovfsWlFioG5lX8r
 JXzE8qrKG+CAkEpAMQ/pwb8a171dY8p7HxGNV3vvSgUMOzzHhqSo/FP9TVKCVFrRDWcI8tt/Tlp
 hgoDz6jJDmBCUq+Czkz2ybOcvBL+PBwBsFNKPmslbAHXpGBos57I2UtIxYoab89Y81OsVUvysgh
 CQHL/ubz6e53SNZprqe8lqmT7P4V4zM/ecWo9Wse/uz4nIa1lKpWwG5EWD3h/mzYSw9YgwGunBo
 Rg6D/9iXbjylzjVbz6ceqXF0JhLsfR+DCwDbbVvGNTOhX2D61oj9kOsBqes+J39fdBRgzStXQDP
 6RKGIGPRqUXiqPhVLZypdYt/J0MjohxVsSQSvCQihyfBYkeylGKnz2WjNVg3HBgJTYRdVDnzDHZ
 l5Hq2om8E3gWuW90vNKBv/0MSPkfo2VnChSrWHmzrHZqQjavKrHQ==
X-Received: by 2002:a05:6a00:950d:b0:842:7476:2373 with SMTP id
 d2e1a72fcca58-8434ce6d3d9mr13270960b3a.44.1781506948118; 
 Mon, 15 Jun 2026 00:02:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:950d:b0:842:7476:2373 with SMTP id
 d2e1a72fcca58-8434ce6d3d9mr13270846b3a.44.1781506947280; 
 Mon, 15 Jun 2026 00:02:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:02:26 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:03 +0530
Subject: [PATCH v3 07/14] ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL build
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-7-360bceb29596@oss.qualcomm.com>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
In-Reply-To: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=2260;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=qEMKBaJzoKNrl1ASHqvvmoWfYl9U0/YC2cN1stWikgs=;
 b=Arw1ybgutpR+SExIKEyOMDR3HX9KEmHPKQXdmTQ6ZCDKCow+KZ+e0Y5OYo/YUNVpL+oTEb29d
 LWq84HbvMZrCwXc+uK7XkU0JHfVfy1qOqczjp/QFbgDKgGAi3kN2pLI
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX255tkUqNoVn3
 c8IaGe8D15nV3FZm/ejYtL/GxqCF1HUKKnAeWExHQlW+fsLuV3/RzQXDqRDR99qtpg5UdXCfyKh
 qSclYU+1F8EP0sff+UisuDD53szAb0o=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2fa385 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=UUyUoatomyVau4bjKBkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfXzZ4P3sNVUCqI
 D/Vfrs+e8hjERyA2k0F/WBE3CMKmVHxvdrYmVJDSW5IQKzZMzUVi/ha6oFCwTk7kAXaT1KE5weG
 PcAcPJ/mkrv8LOu+N6FEaHkVh9FQcAawdvsNYk+x4UDfrTbeEsT1eZt/m1IggdOK1nDmAK96ax3
 3M1TDbcZppUDhT5NckAfMePrnYvLrCdA03bI5FDXwO18mcJjzaxkxhvgxDHs6ukQWMZaCrK66vN
 ERrr/6OSySwCC3FvDNIuzupQiMSEUh+qeooOGYmrOB/X94YVU6ryTekT+FBidB5BtPZayM+Rdb8
 CXxOz09sY0irwkDP3A89uqwVJf0VUTsfQ9JZNxyEK81E/PvDQGD2A2wLOwApMOdVKfQRIxIPm5G
 RyU9jOnxKo0K0P6h3JaXVoFUY26ZMB+/3mVOOCpqcqin54IaOyFMOJbAnF43Ri0ZLC5yEsTRWhE
 qyXdeIP/upHAvz0R8dw==
X-Proofpoint-GUID: f6YL53B8ffD5zxsymeb5ALxcC9P4eFl-
X-Proofpoint-ORIG-GUID: f6YL53B8ffD5zxsymeb5ALxcC9P4eFl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150071
X-Mailman-Approved-At: Mon, 15 Jun 2026 10:34:58 +0200
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

Add a new SPL_UFS_QCOM Kconfig option to allow the Qualcomm UFS
host controller driver to be built for SPL on Snapdragon platforms.

Switch the ufs-uclass.o and ufs-qcom.o Makefile rules to use the
$(PHASE_) prefix macro so that the correct config symbol
(UFS/SPL_UFS and UFS_QCOM/SPL_UFS_QCOM) is selected automatically
depending on whether SPL or U-Boot proper is being compiled.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 drivers/ufs/Kconfig  | 8 ++++++++
 drivers/ufs/Makefile | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 64172454bc6..2fe9346dbf3 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -55,6 +55,14 @@ config UFS_QCOM
 	  This selects the platform driver for the UFS host
 	  controller present on Qualcomm Snapdragon SoCs.
 
+config SPL_UFS_QCOM
+	bool "Qualcomm Host Controller driver for UFS in SPL"
+	depends on SPL_UFS && ARCH_SNAPDRAGON
+	help
+	  This selects the platform driver for the UFS host controller
+	  present on Qualcomm Snapdragon SoCs for use in SPL. Enable this
+	  to use UFS as a boot device in SPL on Qualcomm platforms.
+
 config UFS_RENESAS
 	bool "Renesas R-Car S4 UFS Controller support"
 	depends on UFS
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..c15635c01bc 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -3,13 +3,14 @@
 # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
 #
 
-obj-$(CONFIG_UFS) += ufs-uclass.o
+obj-$(CONFIG_$(PHASE_)UFS) += ufs-uclass.o
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

