Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A4ECD8C8C
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA338495E;
	Sat,  6 Jun 2026 14:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUBcIlZK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5oM03Go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134478405A; Sat,  6 Jun 2026 12:22:31 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEE7838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65660YYK697413
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u5CpQGsiWRqR6Z0arnYmZdUAyzlEd8QtLEnVndZhJ+0=; b=lUBcIlZKnhkrEr+W
 1aEosnV9kJn3ugEcDWXLdXWTccUftNaBvIp7biM/2HlKP3fUNDSNQPg80DBLc/lH
 ZjXsr6oO+A/fVyM9dsMr93H8faYQnyqumBloxouXjnA+ZlbEzB57sXpdQwg9sQuW
 a53IeasVPtq/wq2r8Qt8kl2WBdx5eMViB3O4nfTrZ45F5nqRD/kLwnaJIPvVffh/
 j2+NB4wqO9YT3ikngeL4zOj7t3jm846jhqaMDzzzH0fOr5JRyvGTyQC3BouyA/mM
 /ecmT18WersTvPLi+wkjpBE5z1fkl1ShSXEB0MfkGADgFY27ibRa+G2FX1Z6ZcWh
 50t1kA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs18sc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:22:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c0c3315d31so31262015ad.3
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741346; x=1781346146; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u5CpQGsiWRqR6Z0arnYmZdUAyzlEd8QtLEnVndZhJ+0=;
 b=M5oM03GovonjsOtK5oIfFiAPZLJ2NicRUtEgwBoexeFsr+Moa9QkE8jg0O0azVT274
 IRuknDuPMF35AXj40XxDxZVqMr+Y4u4DZPBsBHuu+BAu+nb9Te+dwLoJEV+p/GuJ0a3j
 PjvZ8pWwCFY4NlIZpXX1bKsa0LqdTDGLI32+qhLZLAXHjgGETT8QliWFwhC75kNC0kZq
 v1LsiOipY3zfNUMVDAyt2GT9YvXzP02elhwljsmcD0HrsHOYLlIS3z2kmS3BS4t7QeV2
 pkILq61N/2Z420jIBp0ArAiKO/Roe/UxMu18UHTPLRrefVFLgLLn/Q3IGbw1RKychJR+
 VLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741346; x=1781346146;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u5CpQGsiWRqR6Z0arnYmZdUAyzlEd8QtLEnVndZhJ+0=;
 b=qIkgXXNj40Wpx8RR/GkukSDeroyDUaX1H0HT2XGd2T3W5/ji+auS86QFTbP/RmN+Sb
 pzLyShRlMyYlE1kxqlJ3Z/xb+UAHSima596G0jSmrWA3bh1VBy6eOTh11sfBxN2ZfkNj
 TRBdRRdF51ME5KmC9egMcGv6NvkpUSvlaRZLpUFGhQdyjbT6HGKd1evaBGL0X/5mvIM0
 n8IEpv7Fh3EGYUdLb2a+iQnA6iyWOL85eBL8jvdHsK5u6gL+ubNyMXSqSdDSbphDxK7e
 DUFtLqdFWq+nHoTVNB3bGAMowlZ8mtWTylsZV1CvHudW+qmmsdOwlum+WTUkoTvzRNdZ
 uOSA==
X-Gm-Message-State: AOJu0Yy2itAQ79MRHFunHiCWGpvfBhnnLj2SGDL5S0Cp0qpsprbcjXzf
 4/okK0Du6dW3szHPc3hr3+Z2EUj4X57TlzixLrlDar8W/phpJ5Y9nDGSBsWllKUW/zn/vfcySOh
 sr+zxoNj32ivGthC+Q1VfYAo7T3IS6IJkOLojVsO8LIiovbD3kelYHb+P
X-Gm-Gg: Acq92OG6uiLxYxVguH7uyUalIpc2TswzIwzcSy2Fl6d5ykt1FzbOzK0jJnVAf3LWFHO
 AzC1pA06Y2VcCfDuF0FFACt7I1ze4d/XTaO96rcDuwC49tabWs6B1LsSWCzBahIerJI7swfltA+
 nr7TMjn1HadqSL+aMY2SILdIYAjYAGjbKvt22O4TkAxkXiWwkC/Hfg1q8aF84ccD1QNxHG7LUzX
 OAWr+LR8XJjH1iUqDn9qwndP8RDqdWhNvbha7FxbkMjArmbz2PB/0zrMVVsJD/eAFQGCuUmypnt
 Ldhoz/Xe6vNtXx/RGfBEE8b8QBZTzVn5CmreDl7tJ7mtLx79xmeRrX2ujpTFzzcWW+0wTVI8Jfz
 L4zfqBX9rDUdVAZVeOTcSwcFPjtNc0uTQZ68PPNxeVLtLemigrU6N/nA5b++7Ie3w/iocqc5T2m
 D+wYg97ZrLeIGv945MVik+cWDxLBwW3UyrdTtQ0DuU5Y/a5JdQDlI4jKap5CJj
X-Received: by 2002:a17:902:f64e:b0:2c0:ee6c:c53c with SMTP id
 d9443c01a7336-2c1e7b2f52dmr89215635ad.1.1780741346226; 
 Sat, 06 Jun 2026 03:22:26 -0700 (PDT)
X-Received: by 2002:a17:902:f64e:b0:2c0:ee6c:c53c with SMTP id
 d9443c01a7336-2c1e7b2f52dmr89214785ad.1.1780741345743; 
 Sat, 06 Jun 2026 03:22:25 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:22:25 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:44 +0530
Subject: [PATCH v2 13/14] serial: msm: add SPL support for Qualcomm serial
 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-13-72fed24ef01b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=2645;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=JNFG/1g44cBTMF2v0C7TAaepM79WbVE3eMTXxldxFgk=;
 b=eBnSqjB+uqOzWJRYrYOhHDWz6CMz3zOPMFnQhspjDq0DgrAeI3Z6qKY26wQ3v1TzVgwyzbXJd
 U/BYeDGPbefDhF1BEoH9Ko307vTZGX2VgVE9bwYBeKEgHUgWXpcvmSJ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX4ca+6zQl8I6b
 qViJ1X43ueNhfYgR9bZO8wpxVq+CEvn33oHKBovfnuDyQ2QUejNbtIKxIZAOVnzgLVkDVdG37pK
 Za925HucS1Un0qw0K3uLLWZy7j8aKZjagFKd0IRX4PHr7sRUv4lI3+olGPIkMgFCYcS3usEEb3/
 RsszUQ6/HNjqns0/13H3JwVnxRXRD8ozL2THZ9T+3qBt48gMAuuIOkHxnAq+jmoffaGCnMPShuA
 F9BFq96LaxspRey2vb8IavauG8RSAxpp+MFx3ZH/PsRpMiGQCOsnHXuq91CtelitQ9PnlJ03R4B
 tfJjX+8ljfF16dq51bNMTbjCIVMf0rK9gg0Js49XU7wlfEPt+0uDieAeimNoyars3pa8mzmuVzc
 kYTMdAmXL3Wm8kMyBu7RINbaTGsNx/yjFpbAyrtrS/YqAxQzxGcfJJN7ijowAgWcxVerbLHY0Iy
 GKFirRzm19qos3nqm2w==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a23f4e2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0WqLS-FEAbKVq3S080sA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: O32Z4Aaq3-N-ppfEavHtqLZdICIYvn0Q
X-Proofpoint-GUID: O32Z4Aaq3-N-ppfEavHtqLZdICIYvn0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060101
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

Add SPL_MSM_SERIAL and SPL_MSM_GENI_SERIAL Kconfig symbols to
enable the Qualcomm UART DM and GENI UART drivers in SPL. Update
the Makefile to use the $(PHASE_) macro so both serial objects
build for both SPL and non-SPL phases.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly added in v2
---
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

