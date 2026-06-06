Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B0FCD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3E884869;
	Sat,  6 Jun 2026 14:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F43v/ix9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bituzUfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4837D8405A; Sat,  6 Jun 2026 12:22:47 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C666838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65662wCo654131
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ods4Fu71UcvI+uTaWOHxFLT5IgeN0CVQuJ7Z20jI5qc=; b=F43v/ix9CKVLa9f2
 ZND+awliFnWZRU5kJFc771ut9aghhy1QusLZQVLywAg0NwBVWU6Pwl2OGw9g6nz4
 S1wwLdkiQ5njZoOMjtQWu/PAnhn16x0ni+RjjTrl/JD2pYWuguIf2Jwm9atGTyqY
 UK9MNn19AwpipoE9TYsjnYHMVzTZ/BjVMHdoRxPhlGAAcHSocfOIYAl9R/Ot5811
 a+51TLh1LwmcwcLDRmaQKp7lJRPdKo0S9HN5KxZsqThkR8vU0om48JnERXsWfmAJ
 pzJCDInIGHN+Ty8o3v72N1w+NT6QlYLaT4f7vigr0H9zDLhVWzZhBBSKpJbo3IUo
 iRJJ6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmr8ubu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:22:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bf1845bddfso32698005ad.1
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741363; x=1781346163; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ods4Fu71UcvI+uTaWOHxFLT5IgeN0CVQuJ7Z20jI5qc=;
 b=bituzUflDctMK/cfDqvu4wDwWsFJjYSb0K0yOvY+aRwxS+jRDBBVv7QSQ1bLQiVrz/
 AVGfLIh5yTPFx3FgINokQo5uZy2vVVlQifps2OxlX7Dx3EcqF8LFHZg6ixlpdFAkpiRQ
 xhltQaprOXNPm7rFdjSUPMNi5am50uhFNA+wk35WDFZpHmq80GPPkpZ99MLlI1vloWQ5
 YoDQt6gRW7RllpfXxDuy33Qet4YEymcPr01PofKPvdZF/Ox37ap+PcWDVg5bdbIVdEx8
 Sn/3faZI6R8d35IX7z8UBiiGkPKllqGwXeaSllnF4vsLZNGg+o7BDtESk5LISIjltcyF
 DdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741363; x=1781346163;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ods4Fu71UcvI+uTaWOHxFLT5IgeN0CVQuJ7Z20jI5qc=;
 b=OuKBklZVEXIlWzR5r1O4iCuQkncVyKijhG3/79RKvBM3QuKnurXJbGkAyGg1eqKIQt
 bPC+OMEa22bYc3zew9uk0YEb7iE2lIJkVBuugQTJ+en/g7eWIrD+r8sCMObDihZpltPU
 H60qHhzK7suTjSHtsHEGQB4kHm5WkPAwfxksW0ws14TZTgqlhZTthhAQc4XAnT5+op7n
 adF6YCmRE0Xi3LqAcA0LO4gyP4r86NIjCd8CZwsSozhieB1DySjEHfXyTknsETQX/BOx
 lMzagGXM5N1wN1qsmGu8IUh9lzIv7Ka7Su/4CkOfD0s5hRXvLNWdYmWL83FwkKNBizSz
 LSMA==
X-Gm-Message-State: AOJu0Yxan+cqMLo1+1LLmESMmy2wtfTFd98wKBEXAl8QTpDha+fRB367
 5EbkPR9RFQyZv1g7kZCUlocedvqSoISJqqOrKKyTVfRNWYC01dNPn+QWISm8Q0yM5J8+32FQVO2
 rKnFXflcoLJYvOklPTf6C1IFQkpF4CfAN4h76df0H5TPfIzlhnq7Hf2xK
X-Gm-Gg: Acq92OGXhNaUqgTMPVBjQLhtzQsbQ8hlK3upGMAsiAuxkhJ4s7P88zNWMmpZ2F0ec4n
 2SW+6PwYdFnCvE/nSWgpBXFwbzscXNyQK5o6GjjbcpOLC6z31pubp/hDjzooUheCaAMmYaxYOLB
 gmyWi6Y5HxBnZVsrHM1o/r3xFAp2YiS4VIyBytVcSyOkpA6Ny8XWJIqcYhdtJMQQi6Bgl3qKs0A
 J666dJ0FUO2rX/1ijvJWfnuLyCXs8nQd4DA5BIXEmfbd3tzPiyGLOs2+cr+GuipRaqtcSLIsTeI
 ZrBtK8LUq+s4kqlXrbfbcU4/OTszCrB3HMd2kxLu8h/aBJdDEWmhZ381Npe0ztcoQ0EUj+30Idg
 xVTyeOG40VBceJ7ZBIp3wDVJgPvXxP5w8cThohg9M/oF8/h0LNayhFJMjP8LuNcHpkypOnk1K71
 eXHwlOLkQPIxNWL49XN3wF1l3FCd3+B5Foy84f8VkSVNhwhCWwu0yXyENYAeyc
X-Received: by 2002:a17:903:2348:b0:2c2:33a4:aaa2 with SMTP id
 d9443c01a7336-2c233a4adcemr11772135ad.35.1780741362725; 
 Sat, 06 Jun 2026 03:22:42 -0700 (PDT)
X-Received: by 2002:a17:903:2348:b0:2c2:33a4:aaa2 with SMTP id
 d9443c01a7336-2c233a4adcemr11771385ad.35.1780741362256; 
 Sat, 06 Jun 2026 03:22:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:22:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:45 +0530
Subject: [PATCH v2 14/14] power: spmi: use $(PHASE_) macro for Qualcomm
 PMIC and SPMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-14-72fed24ef01b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=1448;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=O7ICTSAUsvA8hQKn6RwQxrTMYhe3QjLPn5XfuWjonuA=;
 b=K8dMTNvu4i+duc5hC6m5rC+i8WwRRLeaUqWx/XlFEQThRxx3VUZqz8sLEP+L2JwxAoEwyBP18
 FRRxZhoDK+rDk6CYRn8kp77bIO4BgTmSGMlCKJ3GfZkd/ZlWHP7dHRS
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX0DzobwtSGE+4
 6lOm4jsjoWmbKiWR8hg1rHixX1Nb1YO/t7p5lpRqBbSnXwIvx0xI5h7ajQL8t5g4/pxFhEjpFLn
 P8nga4MK4S2V+Q8Vz8BVtHD8MM07jq60llIghFSMoBtY18r+7U+2PTVTJnQnPEV91u8nsICCaM5
 KiCQMwGVKvxx3n8XDVBfPt8VhvvbOAvW1pyI0CMiBMJtXB5nhCVF55hj+UK9LlEe4MEtwVTjk8n
 pdOKUnr6OIxgfo6L09YkthzF+5u9K8MWikwcSLAaKXiBCzhS0SmtNNPRa8dLUWWzW5VgCAITOTS
 BtJBrfaq2acV6ROsE/+NB77SR05bYwtNj+jPUuDfH79va/sIvbho6U6qOhiy/gD/MxNFDrdDiPd
 IAUkcDRLN5qJDW7HcK1Cvq0iAWTfkkW1AUQ62M0zi6ivx/d1a5cveUTlMJPIwiNJt5jXpiPxgIh
 Roj73iXYLQqPaY29GDA==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a23f4f3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=GKIzsqOsdNxB7MIq_SMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: wDsoZx7Jbr1GGCsY2p1k4LlAU_xh_AS_
X-Proofpoint-ORIG-GUID: wDsoZx7Jbr1GGCsY2p1k4LlAU_xh_AS_
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

Update the Makefiles for the Qualcomm PMIC and SPMI drivers to use
the $(PHASE_) macro.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly added in v2
---
---
 drivers/power/pmic/Makefile | 2 +-
 drivers/spmi/Makefile       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 2cda5a892fd..f0dbb99a6ce 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_PMIC_ACT8846) += act8846.o
 obj-$(CONFIG_PMIC_AS3722) += as3722.o as3722_gpio.o
 obj-$(CONFIG_$(PHASE_)PMIC_AXP) += axp.o
 obj-$(CONFIG_PMIC_MAX8997) += max8997.o
-obj-$(CONFIG_PMIC_QCOM) += pmic_qcom.o
+obj-$(CONFIG_$(PHASE_)PMIC_QCOM) += pmic_qcom.o
 obj-$(CONFIG_$(PHASE_)PMIC_RK8XX) += rk8xx.o
 obj-$(CONFIG_$(PHASE_)PMIC_RN5T567) += rn5t567.o
 obj-$(CONFIG_PMIC_TPS65090) += tps65090.o
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 1b3d57f36a9..8cb93c820e0 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -2,6 +2,6 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-$(CONFIG_SPMI)  += spmi-uclass.o
-obj-$(CONFIG_SPMI_MSM) += spmi-msm.o
+obj-$(CONFIG_$(PHASE_)SPMI)  += spmi-uclass.o
+obj-$(CONFIG_$(PHASE_)SPMI_MSM) += spmi-msm.o
 obj-$(CONFIG_SPMI_SANDBOX) += spmi-sandbox.o

-- 
2.34.1

