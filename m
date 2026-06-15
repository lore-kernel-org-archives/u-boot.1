Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CACACD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBBEC84940;
	Mon, 15 Jun 2026 10:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MTIMIzXB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DAwjTNJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D5384704; Mon, 15 Jun 2026 09:02:49 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 826A083FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6J3vg3327636
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ZzKf/ePHdIWO1hPtHi+yhQ1aMf9h2I3SFjL3MNp1Cw=; b=MTIMIzXBF+LGIOoO
 C3gTw04cc1pz14lLrA6ZviQDZWSTsdqQt4REgPAhYHfKhee9KbKTCLKMNEDqizkd
 XNzr3QIisDy2H01S+zkDsWJZcqoLa7nW/LC7jU+3nTUf+X1BjK/HD9EJ85y5ol94
 PApmBr8fSPf8E5y/lyX2RrdgzXAgQBISH3xmXoQrIkAegw+yFYAigGZ7I7JUHeIn
 tecMP+uI/RQBXQN+bYIuhuWV543hG/MwYFINEiHHqPQ7hgcvuxg0VNvjMwcF2S+h
 v8SH7Q7vWt0e6a14aGo/CvMks2Zty9Rh2NhNpSxmBOnismXYJlUp11fWdomm3+Dz
 Jn/bgQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgnxx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:02:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85c530ddebso1434262a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506965; x=1782111765; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0ZzKf/ePHdIWO1hPtHi+yhQ1aMf9h2I3SFjL3MNp1Cw=;
 b=DAwjTNJ56XlbpDGT/6Bp0h9OjniOHhKO+Cd6AiaoWlqv218MNLU8O8bIGCCFLAgR6x
 2+SgL/iuWVaQaIR7cs4sNNm9E6/RxNMvP8zvMB1leernWS7y0zqpj4Py/EiZJkADKpk+
 sW3IYL3WOO7mYLrLBjWU74NHISCLm1qcYTivk07l0REMTl0Gma9GrZafcHfxdkyovqEl
 FRK/tEy2WlY0NWTf7+fhZckk7yWJhMdiugNgUZbub3F9qDAlrybTKhYsyIwB+OyzVPad
 phyPN2AD4ftV2654HWzPpiLDrcLyRjT8xkEfKf/3m2papoC4yDVLU65x6hdJ9kPOmHJK
 qLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506965; x=1782111765;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0ZzKf/ePHdIWO1hPtHi+yhQ1aMf9h2I3SFjL3MNp1Cw=;
 b=NPHvjdGL2Ls+fbGnp8X2ae0ydLer7NjUJDTHPjSg0cGema1C5Psbc0406cKR2y54UV
 7zSOtOt4/qkMaHHejx/l6aPkILzIWgHH2gSdFzTd0b0f6HO9DhyVJZX6vX2udBF0SyLj
 g9Gnu+k9SepURVSbYgtwe2Av+aZL4E6A2x06YQguWT3Cwu8xrxGMIuQv1bTmvx8FfnWU
 pj4K0wOxtFzC0ONr1TqE3sTQZa40TLCMkN7y2qUCAqIUyVls8gMSKPf7k4oRqTVYbAZX
 TncW26v58iNLtkmF4FNsfGphl17asmi75RF+Dwt3JlTrRhCFgbkArhwE4WEJBMzX0Syp
 orXg==
X-Gm-Message-State: AOJu0YyelNVzUqE9oYjSao7FwzvuoOIo/Q7FBF3zH8/lEliTqrakQkK3
 fC4RSxJpLnbhZ8rrRoUN21aePmxgNcKd1Unium8a2XoyFW8AFC4g+MHagHxuYBHuJkb3pYMY9r6
 72ewBMEK0bVdP6dkO2nhbS1QYSWdxvATGHPrIYUb3tz8+fclLKnZVgGB0
X-Gm-Gg: Acq92OHgfb1At8yczUGcfd6O4wkdKG+CMEyfrJOU997qKIalv3IGAixVmU2rrHYV7eS
 OsujRmjwvNPJzPf9G8/E5zMpcMYa1J14AVfBobiW2TrEs001seHQrYpL+sg4woZUso31m0Hu7c5
 HdsqMBUjKSNPXMrIr/g4Ums1zcEKl6BuIRYWy/DYcu9zFGMpEBWKlbD9jFXE9T9PXMODq+7s04V
 fQbPiJshdbMqQoOCtNNzhrA1OlyvgkbC4hilHDHludKcTMvMNeloY6Z1KbVciLF1DQwldrHeQxn
 ywZMLbo9Dtb9/SUNSaK/nQJcWVJJigbTbVu+ty8TRk0e/QMqBySTeaN8l65SIk+4vFhkAI2ZMLW
 n5HCDmCGi46oH87W2huJbHDLybiS/m7k134SDp9sTUoMeZZIJGUAzDFYceqN22iizH8iUUlhet5
 lM2rFbRJyEOTV1NjjYsUreRILw8xKDSoy/lbDGaSnd9U2QOX+PWQ==
X-Received: by 2002:a05:6a00:148d:b0:82c:24d5:63e6 with SMTP id
 d2e1a72fcca58-8434cdff318mr13719567b3a.15.1781506964831; 
 Mon, 15 Jun 2026 00:02:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:148d:b0:82c:24d5:63e6 with SMTP id
 d2e1a72fcca58-8434cdff318mr13719437b3a.15.1781506963791; 
 Mon, 15 Jun 2026 00:02:43 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:02:43 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:04 +0530
Subject: [PATCH v3 08/14] phy: qcom: add SPL_PHY_QCOM_QMP_UFS for SPL UFS boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-8-360bceb29596@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=2126;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=f4oRHX2dkSFAbq7LcF3kvNv4T1af4d2mygEhDVyyy2I=;
 b=T2YUiixPxOtmDik0zIk3YyiFM2Bk27ehdbrUMa2/+YQ7jsPC4ucJQoYyUc/WokepDE0kLOkn8
 1nWjimwsiAYBbnBnafB6jzR3wbXB1mySBzg3cT5Qq3tuwp8Ey6n/iOZ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: XDgxz3pfgzm6vQ5_HFdDMLaaCGDewIB8
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2fa395 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2JwEUUrR8hw5j8-u2NYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: XDgxz3pfgzm6vQ5_HFdDMLaaCGDewIB8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MCBTYWx0ZWRfXwO31TwrC1PML
 nYV2bQSmau3GcvTFPqhpRNUXQ0QrSiE2bLMaMDTYHAaIZEpuxMzIAlu5zH7WWUWFm4gslPhyYWh
 /B2HLKCherAAKZI4timY70WpBS7UdJ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MCBTYWx0ZWRfX4VdCuAnNQDJ+
 9Ek6w+NiGLSIoBVLVN1NH7DJ5NWliGSWIPBAtDGGu5XcBVjRvztM2aqViPHRLO6ptdufBE3TUr1
 KteNX2Jz3ZT/t5/FJndDPKIWteYLo/zLYQUCdcDmwYzKsqftnhjtG9no+ItO4ktALGEscRZ3G4h
 UdLIpFaTVpZqj6/znSOmPcBHPnPq/MAtiq7OgjNqCbN9gYhy3Ae7ftDaLFcmQVRRcwS+XR9vQEe
 DABSUbMokSRGqXJRhc0vDtNUEz8UHbrOY2oSZrdGIHSu//yXQJSa81k4g89ZHpjkeNwQ3hFRAe0
 m8duzynI+X99vSSckJgypMLEhJj1LECWJva4L2uhd/Eppmyf5mjK1yEbWHTBe93Vp6+Bp3xKih/
 PSQes1wdDfm2P1A2ujCyDPUJ3ZdypTe/sDPzo1GB4DI8Jhzd1ge26W72/vz3/y0CeXUok1RlM5Z
 NhARrcq+w8tG7PVgn6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150070
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

Add a new SPL_PHY_QCOM_QMP_UFS Kconfig option to enable the
Qualcomm QMP UFS PHY driver in SPL on Snapdragon platforms.
This is a prerequisite for UFS boot support in SPL.

Switch the phy-qcom-qmp-ufs.o Makefile rule to use the $(PHASE_)
prefix so the correct config symbol is selected automatically
for both SPL and U-Boot proper builds.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 drivers/phy/qcom/Kconfig  | 7 +++++++
 drivers/phy/qcom/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 49f830abf01..f7c6234678f 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
 	help
 	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
 
+config SPL_PHY_QCOM_QMP_UFS
+	bool "Qualcomm QMP UFS PHY driver in SPL"
+	depends on SPL_PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the UFS QMP PHY in SPL on various Qualcomm chipsets.
+	  This is required for UFS boot support in SPL.
+
 config PHY_QCOM_QUSB2
 	tristate "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 714013dc572..ec99fab4468 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
 obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
-obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
+obj-$(CONFIG_$(PHASE_)PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o

-- 
2.34.1

