Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A54ACD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25F984954;
	Sat,  6 Jun 2026 14:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CyygtW8L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pbbu0Lu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63B4F8405A; Sat,  6 Jun 2026 12:22:15 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9562838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656630ig654204
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Mt9Mdq9Y2WRoW2L+mgNQ2BIo6L0+nbGC2JKeris82w=; b=CyygtW8LmQkARPnK
 c7IVTOqu/8qrV+d7GRaJZVP/3tXl7GHjhTR+hibzsdJFfvK+doDUR0sj5JvG3ey5
 CktzwvCatbN5LoLXHvH8/J3BfkCi8CNZLXA0guj/G4Ebics11YKeqGRFGgdrmGuI
 wY+iGTAy9JzaCUMIarFjpjeZe7N8de4fLudbMZMtKwrthBxANLM9vq29w1ygtb7w
 ydILY/1mXTnGF1jzUsAslXK410d7RPBYQ18wLkgrblhhqA7CLDzQHATYLew/WZRO
 wGkau5EZk6ivlvk9UWBBM10SMAVYyRUoQoZ0QHFjwPurCSgWjDDThpbNEibYkED7
 2WWzWA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmr8uap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:22:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2bf0b7425bbso54145445ad.0
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741330; x=1781346130; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Mt9Mdq9Y2WRoW2L+mgNQ2BIo6L0+nbGC2JKeris82w=;
 b=Pbbu0Lu9BACswmfrll9UV15uOtPjUeMf0HRhfhObBRtLOfdP8braojoRwVkDiL+qbF
 dZl/g4PUDq3tC4jC9EWxJzlhYqeN74ags5M1LkU1xHdaH4NOsGTmededmWU+fnd7Tmbz
 W1RsXOJd8Y8Mq6XqZgNh3/8imyV8nQJf0yVVsLPWQZdeU56w5cmjZpY3f4KjPleL01Hz
 IXHUQXlcVqTwe34X8zR2fu+pq2DIE7/D/U1hcVfIODPPAwucT+b6zB6yTJrzZYNVsTcB
 /Km9W6HIICQ0R5Q9hxmbRZPn0b6of93Rq90bTcfwabXKJpi0n/Q4b8qkGP81d2cU5k51
 qjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741330; x=1781346130;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Mt9Mdq9Y2WRoW2L+mgNQ2BIo6L0+nbGC2JKeris82w=;
 b=GJ1AECzqUcgJRkVRm8M5wSsUFtCRotTDV2MBiCh6HkVFOFG+SVTcJ8MWTUSw7/GHFM
 mz/QB/Da5cPlePViqUJLGUpkfVE/+Dd01T6OSnDw6wKWVVy6Q4+zavsnSM9nKLeFFi5z
 maJBsBU7YMtzz626s4uR1J3Jou2I50Lwuso31Oa5WPNYfe5YKqGDI5KwzqZywciZfTcM
 ozYV2WP+1nQFx0b84vx1Lfu/Xu6BhYpwvO4fOELSp+Fxa0CFGcbYIHXoNcwTgA4C5BDO
 NIawE7oQZ1HGAnv4HTNdWGednEXYdW+NNJFOUxbhazAJbvZXDCNhjK+FhY6YNinOHiCe
 NCqA==
X-Gm-Message-State: AOJu0Yx1SKmsBLLCPNZlPfGhXxqpiAsBvcfknQYJpxWudJV4hu77AHVO
 3a5mFdpdLMXUeiJUkacKvf3ET2dRQntjhqpXEMOiMD92Kjod+rVw8V2i0Oig0P8qDhH+acKox9G
 voJDxMf11SKgZsO0GgKeKmOXOvqI46+M2mfRSDmrQlfnZPPSZWmlrUs98
X-Gm-Gg: Acq92OE7s8E++We7DLrpSN5fNUGjMSTzTVZ38RQTpd6ukMI+lIgD+eMnHHsxUvQSuOF
 EOA8MXtaL3ULiPsaGJ5WQT7OmThxP/wWl86oxnyPu4MJOTZttzFbNmJjbKgtHCRTmkhZBp/Ggd1
 0HNvr1hs2wa0pr/PRUJWpWbf5AEFPE5P3Hcn82wsM6jl4dEUWMfLMraVHiMoasdNgPGZwEllRQZ
 Uet8pN+E4qtxOs9l1LoTyyHEVJgFs0IxXt1xia+V36Glx2XGZihc6X9ABp4gvuJa2OyVDHbJ1Bs
 ErHZhfI6dJPZDzFenL4fKLckZyCl8UvFmN+auVUiLm0/0ASSfi/eG4Dl3EB29OdGm9kT6/BZtOK
 6PybH5MIw5E/CtjiTB1tfqeu2H9kD6V8b+UyF+4hRsbtdESoC1d5Gh7pBwX/KrZQZzuXIxa7o15
 0qKNJxvF/Q0O3f5ebBAKU9TzN3DGWwF1gY888l/ZNWUCVAEzNKpvD6cfpLxvlC
X-Received: by 2002:a17:902:ce8f:b0:2c1:f262:4962 with SMTP id
 d9443c01a7336-2c1f2624b85mr72165115ad.20.1780741329821; 
 Sat, 06 Jun 2026 03:22:09 -0700 (PDT)
X-Received: by 2002:a17:902:ce8f:b0:2c1:f262:4962 with SMTP id
 d9443c01a7336-2c1f2624b85mr72164645ad.20.1780741329232; 
 Sat, 06 Jun 2026 03:22:09 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:22:08 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:43 +0530
Subject: [PATCH v2 12/14] pinctrl: qcom: add SPL support for Qualcomm
 pinctrl drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-12-72fed24ef01b@oss.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
In-Reply-To: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=16150;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Ewwp68KKceHAWlr5uLZ8n36I7Oqc4JP8Tt1qAkzPTpo=;
 b=mebcV4OXPnylPhn5Scm1vuzeK4MUkcZ+AMbBjsEwojuJIgMbG1gkFmJGeVGKTS6xsZ+Iw59yY
 jgOGrO86bStBOt9ssPDiSESvN6GHp03SInqXD8QoDlTNBy9EoWOQ3CR
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX1enDATQzMbb6
 ilDL+PGtDSlIU27i45kK3CuGr7djqlve58weD02e+TLY4VRbc35xguxKz7+bv2prrbscsKBatYo
 0l9N3vS3qql7GXRSc8u4kyz2BohgJLsgPbG57qblF8uh8lJWfyIApAd4M+ptZ+4C/d41qTvbeqf
 /AEfgGnkAKluZmqkyzHx2408yeWMW3GoK6nANGQ1nWCJ2Jh2CI7CAvnp+SL6thyk0LB4sC61RvF
 Kf+iXxw0Wy+omGq82NmvbGuGLPuUVyty4p3NwuX127bhTEY3B/r+nSHilPJW9YRXfdED6iMXbCr
 gQCrMn2kg262qx9SOFB9QRwuWNAzaLA5cz/V2Dh1XfSYAYa9eUaH6OO+/gnaS94eYUU5N5SkGro
 sV6RdynuGfB5emWwl7jadPEsw1xY6LPSalEGk7BfOAUUhm6nwQYXNq/aP+KsRZWlfjbNZOC7vP6
 dNiIIkWaY/zmpga3FLw==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a23f4d3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1VTZRoQubpJ2Lukw6YsA:9 a=qm8mj9RmhAb9jBw2:21
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: usgNk-A0x-zMsy7n8i42MV7fo-Qxmqi8
X-Proofpoint-ORIG-GUID: usgNk-A0x-zMsy7n8i42MV7fo-Qxmqi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060101
X-Mailman-Approved-At: Sat, 06 Jun 2026 14:46:23 +0200
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
Changes in v2:
- Newly added in v2
---
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

