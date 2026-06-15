Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250BACD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843A88496E;
	Mon, 15 Jun 2026 10:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+tFu5En";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gj/DSvET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C02DC84704; Mon, 15 Jun 2026 09:03:55 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE1183FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6J9eo3250412
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OchZXkXDMDRMP3+VUwGxRh3XAhVhjNbDQKYQrJ1lTuU=; b=D+tFu5EnanjxW56A
 C9+AA09suJASW3iHrfZYr2z29veUFV13tkdqHW7NM1SPhC4cT+hsvLZW0XNVuEaU
 fH3jddrhnlYDznbf+T1AaP9hF947Z+BPtwj/0t1Z0PG0iPv8RisI+5233qVZ7uAY
 pgHujgnNXwpfbONLrs976rcw7CUzQ0oUHo/4EgW0k2UvRXp2Y/9qvzqxtboxPR/G
 PP8C7tei6btqaWayAMwjeljC101ATqZfDR/7SG9zaAlWk5w/NmHh+Otd4udkRgc1
 qtTOqeg7c4VMB+y+PYUpwyq0cZB21zH8PTCzPOtqJO5UaUNaddRLVFNN9QLLHlxg
 1Lw21Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryybx09x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:03:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8423efbfb61so2246925b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781507030; x=1782111830; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OchZXkXDMDRMP3+VUwGxRh3XAhVhjNbDQKYQrJ1lTuU=;
 b=Gj/DSvETiawmW1wVpyjtHhWxtOohPT+ixGBcQ2bs80KQr78oD4x2X9npKhua8sflW/
 2ICyV/u/ba0AXE4qShrfjPRiB/rhgoHZx0W/OzZU/07xcC6FW2vNqEh+ATKUxj7jYg7J
 Hsde2rnqalPXZPUp6KseobBy5oNDaVvuKaw0AEtz9Xgf0FwNjKRyiI8/ZQSq/ETAUV17
 artyoGYh/93MooppYsceu5RTlmEtKQ2o4V/2EJ/KC1hM5AxtSnTzdfxC6FKSwu6jjZTT
 uc/uvbdzsN5RfEs0UYR2/K6Qa81Fb+greTHiIXOCe1amzSurCiyJqfGZCtf96X+RJD44
 Qajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781507030; x=1782111830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OchZXkXDMDRMP3+VUwGxRh3XAhVhjNbDQKYQrJ1lTuU=;
 b=DOUmguUUnKIyL9EUA/XnK3IB6BvRvEBd+ymT5+faoNSlTRON2C//8hfpX4y8PCiFMH
 f/yySABdSRm69cq3xXrEU2gclwo2Fpfq5hRNFPe3ojbJrHHVkE5mDMlIi3e9CvvmPe6y
 GVX24GiQFusfjZ+KPGSPhvD0iEZerwG9w2WBv/U4pVZ39BKv+5TkURHa9SOvY4jfbsp5
 NptsR+F4xSIFyP299PUPxXGPqH4qmDOPKsWzMV9Qo/HdbM7w5Hh7n7fDcNX9sFl7deTX
 bc98CBVb4txoT2I1c/XRBPElRM0axJPtYdOE3d7LWbk4BQ/I7BM9GDUTHTIM53M+Zo1C
 cZSw==
X-Gm-Message-State: AOJu0Yxx9VDd3tMsRpT0rB3OaY1PHtItD3xVAQNBGBcwCa75UZntZqXN
 W7pSJshFQHIq8Sbcq0CVGFQu45JiXPcBle4vbdCUGnoHcaTsnATE8UtJFjyF+vQFXZnrbn5xRi/
 0Fzoptmng7KLHQLWHaa8PmW449iZa08aGgk7NFG9yk8dZHqsE0cvv8TIB
X-Gm-Gg: Acq92OFpmxnSK16wxe7CVP48cRNjsoVCoj2neFX31PblGlD4qVPzRSlTzQSQR8fXVi2
 +DYI6CV3B83rh1/iJX+dgbgIYZpOvjTAqUJLncXEWgHQJGTBxD8Q6pxks5ZZfkOlVwrhPBkBVWN
 Il7CAYqdXT1+0G74RulZzD/s43sVLSe+Bv001dq7OcJcTu5i2I/ozxCh7I1O2CHugFEy/axcQgB
 Y195q0mYX9q1OuWLYd7rvSLxLYUHsSLhmfXS3ZkDjfO45/afo5LU18KGA5z4cHvZEJ0fmAgQ8vA
 tnf8V/GEhQL3Udq4qTlMwxJDy0NY3dHdDS0iriFEdoPXErMpzkTfTKcn0rGb2OP87PItDyZ+yoS
 o1Y7JGEL0frrZy39zx3/6ekLoKS3r8KhBNysZxPUYp+d5UfMS8VXAKA1Opu7g2SGXL4fSZfy25m
 dojuQ00xuZtIZ0fFbnH+vJFfbjdGyV+xn7Ry8zmqy3rnYjezNcgQ==
X-Received: by 2002:a05:6a00:3a0c:b0:842:5b63:6119 with SMTP id
 d2e1a72fcca58-844e19399f7mr10409090b3a.1.1781507030199; 
 Mon, 15 Jun 2026 00:03:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a0c:b0:842:5b63:6119 with SMTP id
 d2e1a72fcca58-844e19399f7mr10408898b3a.1.1781507028837; 
 Mon, 15 Jun 2026 00:03:48 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:03:48 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:08 +0530
Subject: [PATCH v3 12/14] pinctrl: qcom: add SPL support for Qualcomm
 pinctrl drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-12-360bceb29596@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=16144;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=gPV8nvpKD5gQGfRQ0A8tl57Cd7izVoB3QSUZI87Qfcc=;
 b=IYQkgJ3L7TR5iOi5JeD7XGkDMVEyBK61CAbMfLAzTtBzXTDuVVr6nJ+08feg8suz/Q9UKQzY7
 PfvWQ4zdAmGCGOKCO+C0Ft3iOu/aWJ5bI4sTpF4WzuTPCTJYGMAfYcQ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: NSaTU1pbMdoqPk4JdvsBry-eJaR081sz
X-Proofpoint-ORIG-GUID: NSaTU1pbMdoqPk4JdvsBry-eJaR081sz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfXy8Of0pG8ZJMq
 h7p35s3U6TpmJhk3fwAB8H3NEDxMCHn8iyFZ+mRvPl3oJtQN/6z+mQdnY0Luf2w4+BRu7rdMfev
 /RjxPlOdgMZc90mFPZZYSjj2o5y2cY0=
X-Authority-Analysis: v=2.4 cv=JLYLdcKb c=1 sm=1 tr=0 ts=6a2fa3d7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1VTZRoQubpJ2Lukw6YsA:9 a=qm8mj9RmhAb9jBw2:21
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfX8fvHrg3kTq81
 wPlcQhLGnhipkzih5VoAxrG9D9NoVcuD8JX/C4NtpeSuJSBHmyn9L1RRTWYj4QXZ4J2PUYitGOy
 RLmgg9H9tSS9hApX882c2VZN3+jrRfR1mlFhPo2wnvRHoFFzGcbPYkf9nIIrvSCwE0sLsmHoh9J
 MxnDg7CPRPk+xQivu2r/digdKhHhqJqiXEMiE3ru2hg+mX9Qk/KlrMVP6cSpQwU0IindBnoCeXb
 7TlzMF7h8W48Dnv6X6J16quu+wNQixF8mrlufvzPjlmfklEJwQKRDH09OKP4hE4gtS0tN+gIVaW
 CGkh8XqWj5El4VEEopSN/56CD6ONMGHUBS8n+fiPJZTv4X7umhyN28E+KcRBrO5rjBKH833+yZW
 chggLmeri7drVSNuulH5N10WYvRwjtNtYDVAdy3R/5EAoNGm5pGDb3RPCJAW7OuTryOKA9U8l9c
 +dOAYC1XiaJ8cMZME2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150072
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

Add SPL_PINCTRL_QCOM and SPL_PINCTRL_QCOM_GENERIC Kconfig symbols,
along with per-SoC SPL_PINCTRL_QCOM_<SOC> entries for all existing
Qualcomm pinctrl drivers. Update the Makefile to use the $(PHASE_)
macro so pinctrl objects build for both SPL and non-SPL phases.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 drivers/pinctrl/qcom/Kconfig  | 201 ++++++++++++++++++++++++++++++++++++++++--
 drivers/pinctrl/qcom/Makefile |  46 +++++-----
 2 files changed, 219 insertions(+), 28 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 11e6763b5f3..24618b21b7e 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -4,6 +4,10 @@ config PINCTRL_QCOM
 	depends on PINCTRL_GENERIC
 	def_bool n
 
+config SPL_PINCTRL_QCOM
+	depends on SPL_PINCTRL_GENERIC
+	def_bool n
+
 menu "Qualcomm pinctrl drivers"
 
 config PINCTRL_QCOM_GENERIC
@@ -14,6 +18,16 @@ config PINCTRL_QCOM_GENERIC
 	  This is useful for generic Qualcomm defconfigs that support
 	  multiple SoCs. Individual drivers can still be disabled if needed.
 
+config SPL_PINCTRL_QCOM_GENERIC
+	bool "Enable all Qualcomm pinctrl drivers in SPL by default"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_GENERIC.
+	  Say Y here to enable all Qualcomm pinctrl drivers in SPL by default.
+	  This is useful for generic Qualcomm SPL defconfigs that support
+	  multiple SoCs. Individual SPL drivers can still be disabled if needed.
+
 config PINCTRL_QCOM_APQ8016
 	bool "Qualcomm APQ8016 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -22,6 +36,14 @@ config PINCTRL_QCOM_APQ8016
 	  Say Y here to enable support for pinctrl on the MSM8916 / APQ8016
 	  Snapdragon 410 SoC, as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_APQ8016
+	bool "Qualcomm APQ8016 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_APQ8016.
+	  See the help of PINCTRL_QCOM_APQ8016 for details.
+
 config PINCTRL_QCOM_APQ8096
 	bool "Qualcomm APQ8096 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -30,6 +52,14 @@ config PINCTRL_QCOM_APQ8096
 	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
 	  Snapdragon 820 SoC, as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_APQ8096
+	bool "Qualcomm APQ8096 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_APQ8096.
+	  See the help of PINCTRL_QCOM_APQ8096 for details.
+
 config PINCTRL_QCOM_IPQ4019
 	bool "Qualcomm IPQ4019 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -38,6 +68,14 @@ config PINCTRL_QCOM_IPQ4019
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_IPQ4019
+	bool "Qualcomm IPQ4019 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_IPQ4019.
+	  See the help of PINCTRL_QCOM_IPQ4019 for details.
+
 config PINCTRL_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -46,6 +84,14 @@ config PINCTRL_QCOM_IPQ5424
 	  Say Y here to enable support for pinctrl on the IPQ5424 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_IPQ5424
+	bool "Qualcomm IPQ5424 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_IPQ5424.
+	  See the help of PINCTRL_QCOM_IPQ5424 for details.
+
 config PINCTRL_QCOM_IPQ9574
 	bool "Qualcomm IPQ9574 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -54,6 +100,14 @@ config PINCTRL_QCOM_IPQ9574
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_IPQ9574
+	bool "Qualcomm IPQ9574 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_IPQ9574.
+	  See the help of PINCTRL_QCOM_IPQ9574 for details.
+
 config PINCTRL_QCOM_MILOS
 	bool "Qualcomm Milos Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -62,6 +116,14 @@ config PINCTRL_QCOM_MILOS
 	  Say Y here to enable support for pinctrl on the Snapdragon Milos SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_MILOS
+	bool "Qualcomm Milos Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_MILOS.
+	  See the help of PINCTRL_QCOM_MILOS for details.
+
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -70,6 +132,14 @@ config PINCTRL_QCOM_QCM2290
 	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_QCM2290
+	bool "Qualcomm QCM2290 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_QCM2290.
+	  See the help of PINCTRL_QCOM_QCM2290 for details.
+
 config PINCTRL_QCOM_QCS404
 	bool "Qualcomm QCS404 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -78,13 +148,29 @@ config PINCTRL_QCOM_QCS404
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_QCS404
+	bool "Qualcomm QCS404 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_QCS404.
+	  See the help of PINCTRL_QCOM_QCS404 for details.
+
 config PINCTRL_QCOM_QCS615
-        bool "Qualcomm QCS615 Pinctrl"
+	bool "Qualcomm QCS615 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
-        select PINCTRL_QCOM
-        help
-          Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
-          as well as the associated GPIO driver.
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
+	  as well as the associated GPIO driver.
+
+config SPL_PINCTRL_QCOM_QCS615
+	bool "Qualcomm QCS615 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_QCS615.
+	  See the help of PINCTRL_QCOM_QCS615 for details.
 
 config PINCTRL_QCOM_SA8775P
 	bool "Qualcomm SA8775P Pinctrl"
@@ -94,6 +180,14 @@ config PINCTRL_QCOM_SA8775P
 	  Say Y here to enable support for pinctrl on the Snapdragon SA8775P SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SA8775P
+	bool "Qualcomm SA8775P Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SA8775P.
+	  See the help of PINCTRL_QCOM_SA8775P for details.
+
 config PINCTRL_QCOM_SC7280
 	bool "Qualcomm SC7280/QCM6490 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -101,6 +195,14 @@ config PINCTRL_QCOM_SC7280
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
+config SPL_PINCTRL_QCOM_SC7280
+	bool "Qualcomm SC7280/QCM6490 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SC7280.
+	  See the help of PINCTRL_QCOM_SC7280 for details.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -109,6 +211,14 @@ config PINCTRL_QCOM_SDM670
 	  Say Y here to enable support for pinctrl on the Snapdragon SDM670 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SDM670
+	bool "Qualcomm SDM670 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SDM670.
+	  See the help of PINCTRL_QCOM_SDM670 for details.
+
 config PINCTRL_QCOM_SDM660
 	bool "Qualcomm SDM630/660 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -117,6 +227,14 @@ config PINCTRL_QCOM_SDM660
 	  Say Y here to enable support for pinctrl on the Snapdragon 630/636/660
 	  SoCs, as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SDM660
+	bool "Qualcomm SDM630/660 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SDM660.
+	  See the help of PINCTRL_QCOM_SDM660 for details.
+
 config PINCTRL_QCOM_SDM845
 	bool "Qualcomm SDM845 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -125,6 +243,14 @@ config PINCTRL_QCOM_SDM845
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SDM845
+	bool "Qualcomm SDM845 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SDM845.
+	  See the help of PINCTRL_QCOM_SDM845 for details.
+
 config PINCTRL_QCOM_SM6115
 	bool "Qualcomm SM6115 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -133,6 +259,14 @@ config PINCTRL_QCOM_SM6115
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM6115
+	bool "Qualcomm SM6115 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM6115.
+	  See the help of PINCTRL_QCOM_SM6115 for details.
+
 config PINCTRL_QCOM_SM6350
 	bool "Qualcomm SM6350 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -140,6 +274,14 @@ config PINCTRL_QCOM_SM6350
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6350 SoC,
 
+config SPL_PINCTRL_QCOM_SM6350
+	bool "Qualcomm SM6350 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM6350.
+	  See the help of PINCTRL_QCOM_SM6350 for details.
+
 config PINCTRL_QCOM_SM7150
 	bool "Qualcomm SM7150 GCC"
 	default y if PINCTRL_QCOM_GENERIC
@@ -148,6 +290,14 @@ config PINCTRL_QCOM_SM7150
 	  Say Y here to enable support for pinctrl on the Snapdragon SM7150 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM7150
+	bool "Qualcomm SM7150 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM7150.
+	  See the help of PINCTRL_QCOM_SM7150 for details.
+
 config PINCTRL_QCOM_SM8150
 	bool "Qualcomm SM8150 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -156,6 +306,14 @@ config PINCTRL_QCOM_SM8150
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM8150
+	bool "Qualcomm SM8150 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM8150.
+	  See the help of PINCTRL_QCOM_SM8150 for details.
+
 config PINCTRL_QCOM_SM8250
 	bool "Qualcomm SM8250 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -164,6 +322,14 @@ config PINCTRL_QCOM_SM8250
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8250 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM8250
+	bool "Qualcomm SM8250 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM8250.
+	  See the help of PINCTRL_QCOM_SM8250 for details.
+
 config PINCTRL_QCOM_SM8550
 	bool "Qualcomm SM8550 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -172,6 +338,14 @@ config PINCTRL_QCOM_SM8550
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM8550
+	bool "Qualcomm SM8550 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM8550.
+	  See the help of PINCTRL_QCOM_SM8550 for details.
+
 config PINCTRL_QCOM_SM8650
 	bool "Qualcomm SM8650 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -180,6 +354,14 @@ config PINCTRL_QCOM_SM8650
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM8650
+	bool "Qualcomm SM8650 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM8650.
+	  See the help of PINCTRL_QCOM_SM8650 for details.
+
 config PINCTRL_QCOM_X1E80100
 	bool "Qualcomm X1E80100 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -188,6 +370,15 @@ config PINCTRL_QCOM_X1E80100
 	  Say Y here to enable support for pinctrl on the Snapdragon X1E80100 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_X1E80100
+	bool "Qualcomm X1E80100 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_X1E80100.
+	  See the help of PINCTRL_QCOM_X1E80100 for details.
+
 endmenu
 
 endif
+
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 4096c1aa491..058395695e2 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -2,26 +2,26 @@
 #
 # Copyright (c) 2023 Linaro Ltd.
 
-obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
-obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
-obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
-obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
-obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
-obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
-obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
-obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
-obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
-obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
-obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
-obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
-obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
-obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
-obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
-obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
-obj-$(CONFIG_PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
-obj-$(CONFIG_PINCTRL_QCOM_SM7150) += pinctrl-sm7150.o
-obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
-obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
-obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
-obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
-obj-$(CONFIG_PINCTRL_QCOM_X1E80100) += pinctrl-x1e80100.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM) += pinctrl-qcom.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_MILOS) += pinctrl-milos.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM7150) += pinctrl-sm7150.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_X1E80100) += pinctrl-x1e80100.o

-- 
2.34.1

