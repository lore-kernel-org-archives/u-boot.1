Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4275CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E198495E;
	Mon, 15 Jun 2026 10:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVMvALd4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O+JXVq2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF8E84704; Mon, 15 Jun 2026 09:03:37 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B988483FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6J1wI3344660
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +XFHO8hY9z036+nEnptoRWZEoIh9Tyqr2YrYo8cBn58=; b=RVMvALd4CPK/KqQt
 tLL8Fjz7yOsxyb69IYTisBzpTvtCli591Abzj1CwUs6NWOTTFQovm0baq4fNfbXj
 E9Jgmm/MkiF0lrBS+i+63LGZFiSFWm1CPwK2QvqS9Ch4NZTewAXoBnEAAUvcSCP3
 ToHC0/r6Evmj2ethTJwsjZZIlSKl7TnYL8dEOPUpbCHi5ZQV9PTQKfxQo24ECYCA
 P3U0Ttdl++a2hAUAvmeLBWHs71wgA/du1JMkBZGN45Mar+1coRxctCNzdD8kjUQe
 mmxxgGKmiieiJYyF4G8WCBIiubAMcLfRspgL3AtqPleIyM/Pte3auLzzyKXGGbQl
 +fv83A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery9fe3hx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:03:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-842cb4c62f9so2514883b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781507013; x=1782111813; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+XFHO8hY9z036+nEnptoRWZEoIh9Tyqr2YrYo8cBn58=;
 b=O+JXVq2Yhge6rTodkot1RBRi3wZMG56dh1isc3Osb3Z35dIWO2dzkmEt3S/rdS7QGk
 YHTpgjWmE3oZcEJoV/sDpRhx1SMe/TWIMa/HUha8963fTbrj7pW0I3m+dTgU/2rco8Ps
 a1/PZCmmOuAXmarh0QOyZzFfFWIN8MDjego1G/dKVYbJlzHus9EC1wONvSgAmjdsa6tz
 VfiZ9R4Kz50y9r+q964RUqBFCcmcKmeCS7BnXtvjU2CFX55ZEW4odmhesZaiymERu1ey
 71eSnkmAhq0RRtMcTuC1oPP7YttbVbs+cK9lvoGL7uAMtZs1Hu4o2VwslzY4jv2eESJD
 eJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781507013; x=1782111813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+XFHO8hY9z036+nEnptoRWZEoIh9Tyqr2YrYo8cBn58=;
 b=MO3nXxDqNoEI8R3/E84e3Zx4QJXEVd2aMW2Wv2YqU7VFAtOn5TmcoV53deDiZqwGLS
 J0JcVnC3BgtSww14rdROPmR+oj3b9jd5v5wIrtZNCp2UkzUNhO7k9DKjzpsUMQsVtwWK
 cfwx/k6TNsZ95SOGBRQixb8wTsCSrDPr0Wd3YVBnyldgunijD6Z21eb6slDeT30pu2Za
 b6NUfzAiS2p20OzKgEUj6bpYI5mr3153bG3F0cRvA4JWH59dyliUNO/ELkkYgZyOmx80
 QIA0lZ2d3byAz6C4ReR/glIDnhAj76Op8gdQBRMK9oFO0P8YpKWnzcG1nZ7UQ7u9D+eR
 i7Ag==
X-Gm-Message-State: AOJu0YyYGY9hvi79gy1NHyy1JkUNGCiZKJYoMs+JKeJCjF6XSEVdiO3D
 IZJ78hxA+7M5pkDt3TOjVe44vq3inm8lho1hTFR8gQbdLN0AoYIMTGklQei4JuZ24W4Xw0GCaqr
 IOwVR2fEPtuFN2rhu0i8sUsFGVqTWOCRA3NRQz96Fgf+KTBdIJgzyqW7J
X-Gm-Gg: Acq92OFCM8AHPKNlcdSagb+hceupkrXk3iD/KIiKBVYAuD9f6WUvSOIiGsMxYLBImC2
 PpMgXvHxaHmSitQBUA//qM+tPfD2kuY2+SnlT4uPQBmINH30fSF62edUjorDoNe1BM1Yuz3l03F
 LcLI6Rz25PSBhMklxEHjXB9rFx8FGrjeAr+oH8Edd38XznzNZdDN+Xv7KxzNb0d+6zcefxUOd14
 ihVJzNzby5AhgU0W8xNtMaFsGHG//rB6WfdX6sjisK2BxMbgeSZJj/f/Xd7gy4Zzte/JK3nKHbB
 rEyFdCjv3tj1AEBGUYHUpK8hVMgMnjuAkXShUS2BFPrtTsR1CkTkcKkVGJUAyjD/8mkCxLnl/en
 DL6gRcW1MKfrOOde5b8y+/S+pD+RMIPHqz9IN63poRb4JUjpFAO326obL0ZOHihm5+o7gLXLIVM
 TOZpFgVxm0MsPfVx8GGuqGgG3jEOBvwp08kb0ldTCAnyz8FXo7/w==
X-Received: by 2002:a05:6a00:3e1b:b0:835:447b:a2ac with SMTP id
 d2e1a72fcca58-8434953f8b1mr11869299b3a.5.1781507013159; 
 Mon, 15 Jun 2026 00:03:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e1b:b0:835:447b:a2ac with SMTP id
 d2e1a72fcca58-8434953f8b1mr11869194b3a.5.1781507012477; 
 Mon, 15 Jun 2026 00:03:32 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:03:32 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:07 +0530
Subject: [PATCH v3 11/14] misc: qcom_geni: add SPL support for Qualcomm
 GENI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-11-360bceb29596@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=1746;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=og2znBC8ya6C1T1PeKNrAunREI+YMTTyeJpKbzwByI4=;
 b=FvvaoGPWv70kmAUJf9nsHsFy8iQdunWyDyufJJDoda41XysUP2VcpJgRSjGaBWMS0wMzW9g2o
 bErA+3Rd4JaAl7c+VpA4BWN+eCQO7VfFlNd0eFP+A1rfhlyyUBg6vf6
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfX/rlB7MxGkfNl
 HQlMXCfvS+hp8S2KKPcRe+0+zBxZUAKWM0/4dg8DSWYna4gmfl1eXiRtmFcH627C/crB+WfjQGf
 v6lNg8Mo1jDlkW1BUlxEC7Lr3Yp790gqQ8FKXlA1tq7zNBTT2QSfrH6EWAXNE0+8Ld6Y0krb3e5
 y5UZK+WVhJ/yvhWLGX9mhf3UyUYi7rCvFJYMgEx3mQeVLvT1+ci6aMvLpKSMJ8hMVj53siVBd8t
 biODrDjDLojHL9EFmS/+wFnBmRL+L2Ct5BIYHr4XwCwbIdSPeVjM+T5dgY7mtuc36wDkBB3v0YI
 XHfbkB+0iTNTjBTLyrLpw+XIlDSq9zc0aqfu1wENFlDoNWTtDIKsqLRlVN6k64IR6jUsVjyRdb6
 ojgmbilFUqyoorvI/vwkwPaenufMv7ZpSYg7gLfLUWbU0aGzGxeUj8ptj8MIhNZFUgqsFOhJemC
 zwiW9eI3QEcjKLy26eA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfX48jm4YPSmsSL
 ocCzG9CPpol+A0QCTU7r3nSdUk5mvho3a5skZd4JbhrCZ1TkDcv23wMmWbt7jgRfnsGVfY+MOby
 zb7VWGqeRh4Bc+lggga42u1AckRUmWY=
X-Proofpoint-GUID: W-cG0I7cpX1v3cOcV02nvA4LL7NAQsGH
X-Proofpoint-ORIG-GUID: W-cG0I7cpX1v3cOcV02nvA4LL7NAQsGH
X-Authority-Analysis: v=2.4 cv=ULvt2ify c=1 sm=1 tr=0 ts=6a2fa3c5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ydkT0emSJiMV-jbtYrMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
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

Add a new SPL_QCOM_GENI Kconfig symbol to enable the driver in SPL, and
update the Makefile to use the $(PHASE_) macro so qcom_geni.o is
built for both SPL and non-SPL phases

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 drivers/misc/Kconfig  | 10 ++++++++++
 drivers/misc/Makefile |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ea785793d18..0a186538526 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,16 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config SPL_QCOM_GENI
+	bool "Qualcomm Generic Interface (GENI) driver in SPL"
+	depends on SPL_MISC
+	select SPL_EFI_PARTITION
+	select SPL_PARTITION_TYPE_GUID
+	help
+	  Enable support for Qualcomm GENI and it's peripherals in SPL. GENI is responseible
+	  for providing a common interface for various peripherals like UART, I2C, SPI,
+	  etc.
+
 config ROCKCHIP_EFUSE
         bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..e0293193174 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
 obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
-obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_$(PHASE_)QCOM_GENI) += qcom_geni.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o

-- 
2.34.1

