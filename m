Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EDECD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56A984975;
	Mon, 15 Jun 2026 10:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IypiFCfA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c+nahP6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433E984704; Mon, 15 Jun 2026 09:04:10 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095E983FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6J3wX3327636
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lwL+Ok+0XawVcuoK2jbWRJ43K2J9ek2Oxgl/JfMV8ZA=; b=IypiFCfAPlXKCsMt
 uC8b/1WpadGGBnN8Uyj+YG/0zewMzWpcKtDEvBdTRTrlQGeMEA8oA+/EM3+hCHDq
 EpTLFCEsDIUA1pypd5YdFnortvjeeHg9ry4szcuZ5c/ggS2Ixo90ysEJJZjKI/Rd
 xQi/Bqi7RGV/cXX0nx4MSv1ls+Pe8GN1gAJbs3V+yx/vrcOTQWrmbYyKL0qHB/Tg
 nI/mov1UaG9uf+WBZ73AqJLyY/9QlZa163Rh25FpV7SGO+f/sW3y9dAQ4pugWlCq
 yFRyiAHX4SjWRTCQq2fgtmSPC6cAEaTjgqqZzS4OLYq9/KGOHnPYFh+IFz3+jaqj
 U0FZAQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgny5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:04:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-842211d6e48so3818335b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781507045; x=1782111845; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lwL+Ok+0XawVcuoK2jbWRJ43K2J9ek2Oxgl/JfMV8ZA=;
 b=c+nahP6JaTHvhgwfXXV7/5oZPsF3jeI/yt74QYNWDuXLP202AJmJI69jsBrEvSO2qZ
 PquklN0xztMZFiULITfDJsQDlHADqXJMYXZ/VhGW4405ycueuXds2mqMsD6Ll0Zxzd8K
 jTzGKDlotCchM39ppKZg5sHUd+rPe66+DL1TaIMR4QwyufMM8ooB3E0+2u2M6qCFQrQ8
 reZVr4sAAhQGxdU1bfyGwVXMg1msNEfKIY4/BQHAWjGn+kwNGJT6bhdxYH/sJ0JwKlmu
 yGHbTpI/ELxfS/4JZj9kTESAIWIdJ8mmYpo4INoSygvIUBcaCcN5ea+malsXUa5YTpag
 G6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781507045; x=1782111845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lwL+Ok+0XawVcuoK2jbWRJ43K2J9ek2Oxgl/JfMV8ZA=;
 b=YyOwV6ouau5td7Rc17utCPLkE1T/brbGIZAt1ddXgCE5v1cKbabEmbxkq+Pm04MY2J
 NhYGW2jgvb8nvWocnsjMK8hMHZf0TAGrrxwSZNyWw37bmxUKOm1u6+hoimd1Ai/jN/iD
 hhDdmiRAFv++2quQaaoxCa3pio9S5zshHY8rNkiaU3X8FuKmHjvBeWaGALpY0sp7sRDk
 k4NlPYvypT3iUWopFYGg7oRt9TZ/S/egSb6h2gHJhHi9XlxoTn2dArOLrcp5gYUXV8u0
 ItXCoSgZsxLFhqsTWVPYcOUjYedrBBMs8K1er3CReFKYjr3a6sXdaBp4A+s2A6dLe2Kx
 FUMA==
X-Gm-Message-State: AOJu0YxokRnnE3uUSjotes0kdHKtPPe2OtQQpoTHa3plEEQXLvU/wa1O
 qrpA7bMMlzUfuSlGOZAzzFjZ2cWNT93Td+WwcWSbxn+IW8Jbek8/DSbSjrwoNEsZ51hiCgI2TUC
 xZqdB0kkIG/jpiLTQw1WARNqfemBld3dpEnMcA/05Mp8qGuCBIeQcWlte
X-Gm-Gg: Acq92OF0l5XKiFx+JaiScPRk86/E9ZBwPuRMz/ONOqRuBDuj50cU7G08L8D5inX5OdI
 V6/83U70qGvK2PKTxDgw5g7vr0sWQV/0khrdeDWKQpWzxo/da3BtU/C2+/+0Ihx+XUYO0tQ2yHM
 h6XNKCoo6nilu5/iENpX0nrq9tBu+X73Gu8wti39G5ZYw0GoO0RF2cGv55Q2/Ar32JefErB7asm
 N9xiFk6qKB/iEwkkBIirqVdPKnJtPwF2hckv8u1lk2Rvl4uI+zPCe7Y7giUOYyhBTfIdM3o4XkR
 9jXKOeVgE+ItLdw1A9/nUOM+3/lhWsyubZi0xqVOC7df/qPcHkpKC0V4SBk9N/kK1vPrHYBNJ43
 EKTD72beOC2ZSxq25Y05mskRydm/kumhLVZYed29gJ2paM1J3gFEITO7KS9Hx9XL7+W1624xAAg
 L5gxlprNP7ZEztbFk+aO/v0WNpAIoeJsTV08Z3NuNTWlc5HgHk/g==
X-Received: by 2002:a05:6a00:1f13:b0:842:80c5:c425 with SMTP id
 d2e1a72fcca58-8434ce2bf42mr14326496b3a.35.1781507045467; 
 Mon, 15 Jun 2026 00:04:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f13:b0:842:80c5:c425 with SMTP id
 d2e1a72fcca58-8434ce2bf42mr14326437b3a.35.1781507045067; 
 Mon, 15 Jun 2026 00:04:05 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:04:04 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:09 +0530
Subject: [PATCH v3 13/14] serial: msm: add SPL support for Qualcomm serial
 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-13-360bceb29596@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=2639;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=9E+xTsOx8dw/7+C25p6ny3hBj1Rr8z4VmkLKWdjpzhU=;
 b=7Edrt+QtPWdEPM9L6b5k4a4P6sr/rw7vME/ZPgIZw6DGN3lEG6Ih7dfvEG0IM7FcWIYwIOLZv
 XwqLi52PbsxChbBCbnWrt+Lct/JATRWu2EAlnO0uRArOLowGjDOxjnC
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 3JATALriSLu5klm6vWTb9Cq4ctO7KC9P
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2fa3e6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=0WqLS-FEAbKVq3S080sA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 3JATALriSLu5klm6vWTb9Cq4ctO7KC9P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfX7vci8l8ps7CP
 YSC3bbPGaUJHuVDM/QTONzW/rz4Vi9Nivw9B07dZYDryCNNzywD6IIqUbXgQfkfmkcoF3Ptjdsk
 RatQQAcrEHzSHCKl7R+++44jHxxVdWI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfX+D4wBxbWyZ4l
 1B5k5Q1kUOoW3968slusEQseTrqc6tHD+FHdDLJpR5MZtemLFm1AMmOAV8aVWA7wnPXE5LDWfWE
 HuAGOuQEsa/EgLutQ7quRUJvhBoozCGLi/OF4D0vIKpqxg/3vSuwfnnG2fpbY0T9ziBWRot4I5Q
 373xUAfeJuaOFW5LpvOACH7wAi5++05pS8hL6j3ZRWW5pTv+VMHOavhl+hQMDjnGIArn3qnPtBu
 SoP4fVbTrF14iy24j8qM/wyh7nOc5OW1s/EiZCHKmycf94RprMMrTG5M+FkFk56VUX2WBxA4VOJ
 mmf0gws2LHt2XipV2AOqVxLaCdqiRQnmtcpiCzTEQUqqvRhDyxgiB3EZxPN5D/LlQq02re3EBPr
 nJI+IigrY2lpn9fjGeDALK4QB8iTZ1dCinVGUAgS8wCgd0pvMg3ySjE3dILnn5mHruAE/ud+NfJ
 c/4MT+3xNOQTw0Kr36w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150072
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

Add SPL_MSM_SERIAL and SPL_MSM_GENI_SERIAL Kconfig symbols to
enable the Qualcomm UART DM and GENI UART drivers in SPL. Update
the Makefile to use the $(PHASE_) macro so both serial objects
build for both SPL and non-SPL phases.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 drivers/serial/Kconfig  | 20 ++++++++++++++++++++
 drivers/serial/Makefile |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 5f8b98f0704..05654011cae 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1001,6 +1001,15 @@ config MSM_SERIAL
 	  for example APQ8016 and MSM8916.
 	  Single baudrate is supported in current implementation (115200).
 
+config SPL_MSM_SERIAL
+	bool "Qualcomm on-chip UART"
+	depends on SPL_DM_SERIAL
+	help
+	  Support Data Mover UART used on Qualcomm Snapdragon SoCs for SPL.
+	  It should support all Qualcomm devices with UARTDM version 1.4,
+	  for example APQ8016 and MSM8916.
+	  Single baudrate is supported in current implementation (115200).
+
 config MSM_GENI_SERIAL
 	bool "Qualcomm on-chip GENI UART"
 	depends on QCOM_GENI
@@ -1012,6 +1021,17 @@ config MSM_GENI_SERIAL
 	  Driver works in FIFO mode.
 	  Multiple baudrates supported.
 
+config SPL_MSM_GENI_SERIAL
+	bool "Qualcomm on-chip GENI UART in SPL"
+	depends on SPL_QCOM_GENI
+	help
+	  Support UART based on Generic Interface (GENI) Serial Engine (SE),
+	  used on Qualcomm Snapdragon SoCs in SPL. Should support all qualcomm SOCs
+	  with Qualcomm Universal Peripheral (QUP) Wrapper cores,
+	  i.e. newer ones, starting from SDM845.
+	  Driver works in FIFO mode.
+	  Multiple baudrates supported.
+
 config MXS_AUART_SERIAL
 	bool "MXS AUART"
 	depends on DM_SERIAL
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 66088b44eb6..92cf036632d 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -42,8 +42,8 @@ obj-$(CONFIG_STI_ASC_SERIAL) += serial_sti_asc.o
 obj-$(CONFIG_PIC32_SERIAL) += serial_pic32.o
 obj-$(CONFIG_BCM283X_MU_SERIAL) += serial_bcm283x_mu.o
 obj-$(CONFIG_BCM283X_PL011_SERIAL) += serial_bcm283x_pl011.o
-obj-$(CONFIG_MSM_SERIAL) += serial_msm.o
-obj-$(CONFIG_MSM_GENI_SERIAL) += serial_msm_geni.o
+obj-$(CONFIG_$(PHASE_)MSM_SERIAL) += serial_msm.o
+obj-$(CONFIG_$(PHASE_)MSM_GENI_SERIAL) += serial_msm_geni.o
 obj-$(CONFIG_MXS_AUART_SERIAL) += serial_mxs.o
 obj-$(CONFIG_MVEBU_A3700_UART) += serial_mvebu_a3700.o
 obj-$(CONFIG_MPC8XX_CONS) += serial_mpc8xx.o

-- 
2.34.1

