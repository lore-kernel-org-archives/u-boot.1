Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF2FCD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88759848DC;
	Sat,  6 Jun 2026 14:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXnCjDIY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jno7VP7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBDFF8405A; Sat,  6 Jun 2026 12:20:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7E1838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65662v4J612957
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RpqLhMevJEhblsAwRPB5cdi6VJ6iTjUP9jwWTSm8otI=; b=TXnCjDIYKPAZZWii
 BJMiR8KjU48zrT1nO8fNoET0JOal8WtoOuAA/RfMW8Zy6IgBJ8mUyR7JuOHIDPgF
 0lHnh9NU96Is8fwIjYzRZgcXy3onqq64328vwuGn3ymyK/S9iBYPGxRPATSY6spa
 XGN6iriMwG9r7cYh+BGO1vk6TOjg4PBtwPy6Tw22lyBszMt3A2Kmw+l6cPh5CuN+
 tBa559MvMw6f1LrmRwbpycZKdnx5R3zy8EAMVHIUVJX1Rt8rz1ynN2g95PdVk9fF
 5ayU2Ck5Zf9/w78kd6Qch6XmEmJHVOnJOiL4gEE9XAHE8QEstXWw7Ktc191ZR8uu
 5DLiww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf10y4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:20:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0bf6904a6so32453425ad.1
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741247; x=1781346047; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RpqLhMevJEhblsAwRPB5cdi6VJ6iTjUP9jwWTSm8otI=;
 b=Jno7VP7gx1yCHSknROt+gZHYU61+qhJxfU6EjqQBTks99Hvqi4qwKfMbjjpqvR6dPu
 0tSxETh/5twUKl4GeNr+HtR8O79JbkrsVlh0VZaPLjMRjZXQMjzVMd2vE5U/Qnxle2uG
 P6urchsf0evcF7Qxcf5XV6Xj+aBVMLhhmaza8FL114nWOEHUMnp9jgJZ83tWIdL87MTy
 6v0LF8RxTdqFH3bloDtJRbdfvyicN3VBVaCqjUZTBDUsnndopjhNXmLSZhgb7C+8E0qM
 1RVHio3CKiTzB51zTrOCIdk0EcSRbRTps9D+NvsxuTV4IQ25/KTzakf97jHmsCw3r9Kc
 5t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741247; x=1781346047;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RpqLhMevJEhblsAwRPB5cdi6VJ6iTjUP9jwWTSm8otI=;
 b=kzIm3hwhz/GXKMkSy7s5kIpRSU7vfHDDwKAgoTwFcmSGmNg9h5rxhG3u+JuxEpB8dT
 /qa6hUXPmMTwQih7gFxhAQOafiLhcNr1R2b5KHflT6zMtwYYb8iKToBgBM31v/XxIkaN
 e0aKl4S6vQtUYFZZ6I9+l5z8/jmvucAC94Bs4LU16hWn0Sk9B0CqUpuB57GJ2LOzoe8B
 dXrTIQgu3oWAgXLKb9BW0futJau4H2uy6Y0ZL++cKRqVmQ6SYiVf7Gnr+cO5YAypFQi0
 rox8LXXHQhY3xWnVDx3tS7XeN1/D4Y8GpjSYC8f3O/SCWlAsUIg45xZLZKXs+BwcmsMH
 l1LA==
X-Gm-Message-State: AOJu0YwoMFzZEMNGl7zYkEcSKbgd4BhEadHSsRQHqLDWy/wlAcsPFKAq
 Jw06dd6Zc9c/ijk2prJN1oOxRh+qFReOBEtJC5eX24X88YDCsS9LNr9PPHxr10pKdKxjzbfkumz
 uh6L0Ql6DQesosowesz+Hv61vPwWoFwKwOEcKBdqFGN47jyMyCMfoZyVh
X-Gm-Gg: Acq92OFmaHjUpFviCYNRh9nTwpuHerIZWK1eB/aAr2YXjY9VFKpMqvlG4x7TV7BJk04
 NzamzXS+0tKXTcyGF2qFxsNqkrgv885dBhGqssAsmm4hrBC8Ul/KDG+w2Fe/Unga5XNVZj+Ee/T
 SIn55e2SmBXZkEBeZpFU92R4AX+o7vlyVmOcu++CvYXjMLnuwWY2mnDP1c8vworqNo0pBW6eihW
 faQ2BCOnJbRrGIak8/rwROMOgLnmKxKkxwCV1DGGlG2xhw4YSswkQn1fdNB33y3ANGp2wArbCgs
 yujclb0Awo0164CiPgQ/gZ+swroMIXeeDuZGxJhv61iobr0s9v+voNpOYK/QJbRDXtPslVR8eS+
 9fGl0Ic1eQgyO85eRFc2XSE7iKukVS2m3eZlnTd1ujXZcZG8Z8s53/CvuNCdZey1kSpC8gmDHdY
 QlqK3qlR22BmwtG/zm3rKd6baIAdwkTMdUMa6Ws2qg5Zsfbq8LngRRmyz9D92c
X-Received: by 2002:a17:903:41d1:b0:2c0:af09:f3c7 with SMTP id
 d9443c01a7336-2c1e85c0cbamr90670875ad.30.1780741247005; 
 Sat, 06 Jun 2026 03:20:47 -0700 (PDT)
X-Received: by 2002:a17:903:41d1:b0:2c0:af09:f3c7 with SMTP id
 d9443c01a7336-2c1e85c0cbamr90670465ad.30.1780741246510; 
 Sat, 06 Jun 2026 03:20:46 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:20:45 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:38 +0530
Subject: [PATCH v2 07/14] ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL build
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-7-72fed24ef01b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=2267;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=dOVdQzynmyL8Gw9Si8WP7Lkt7GWl5pgHFW8uvRtclp4=;
 b=Kl2K6FEgHvKMzM+J1Cy3c5YrFiWNUAAIwnmXV0jTKmNlS6AdcEslU1/0aCrA9Cve20EMC7UVX
 0o1c5sjzIUbCYAxt+/u1fNLDUQnj2BT8QP91cem7De0pK/scgTXZIbM
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a23f47f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=zLUr2VmSEcwqkAxLbBsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: dlY2XmkQEBriRU-KlglmRPd5aaxOl8Qj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX2OUHQ+91FibO
 6eq2n3EJInSyEvwJGQ+juvBTMjHlCWaVaQ56m3hR390LCVoeq1Mj1wylEnNek5MFuZ/cOU1RP4D
 NlX+2OeMSZQDipzYATaPOPWBHxJe2xlOBVhbiBjXbEmZ4Ur8biT5hP5LyEuAWJKhmSLIeDUONb5
 kunI48Tkw/yNepOHPeImFb1HD5evt8HAvZzpQEH0tlSmCSbqUJm8KoHefI73g4qW3qktRPyI9LW
 31NFpe/lMM7lKgN36AOMeREs5yeaaq+dNdbmFunyVJ4rgy4BVetcJ2lF410zK/BueC823j1iu2g
 3tVAxEKj2bIEwc+GBRlmSh4SnoEouHesdedPB7iqphbF4J553y0qIdeIR4HA43ac9hTwZQrIblh
 TuamafcP6QLuZPLnc8/YMdF10IEtozsaxG/uo5kbF6LbYmBz3zfaQLXylYr60BQz+sig9zzI3Bo
 7WbiwhSmFfyZTYSMYuw==
X-Proofpoint-GUID: dlY2XmkQEBriRU-KlglmRPd5aaxOl8Qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
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

Add a new SPL_UFS_QCOM Kconfig option to allow the Qualcomm UFS
host controller driver to be built for SPL on Snapdragon platforms.

Switch the ufs-uclass.o and ufs-qcom.o Makefile rules to use the
$(PHASE_) prefix macro so that the correct config symbol
(UFS/SPL_UFS and UFS_QCOM/SPL_UFS_QCOM) is selected automatically
depending on whether SPL or U-Boot proper is being compiled.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Modified the Makefiles rules to use $(PHASE_) prefix instead of
  using SPL_UFS_SUPPORT config
---
---
 drivers/ufs/Kconfig  | 8 ++++++++
 drivers/ufs/Makefile | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 64172454bc6..0e03d7ef438 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -55,6 +55,14 @@ config UFS_QCOM
 	  This selects the platform driver for the UFS host
 	  controller present on Qualcomm Snapdragon SoCs.
 
+config SPL_UFS_QCOM
+	bool "Qualcomm Host Controller driver for UFS in SPL"
+	depends on SPL_UFS && ARCH_SNAPDRAGON
+	help
+	  This selects the platform driver for the UFS host
+	  controller present on Qualcomm Snapdragon SoCs for use in SPL.
+	  Enable this to use UFS as a boot device in SPL on Qualcomm platforms.
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

