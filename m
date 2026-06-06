Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4479BCD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5055848F0;
	Sat,  6 Jun 2026 14:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KcsaaEom";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QoPC/bV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B8168405A; Sat,  6 Jun 2026 12:21:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACA5838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65661MGj654032
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nroo4Cf4zt2Qa6ejbVMn31XZOpAN8ZRa+245YL+zq2w=; b=KcsaaEomJ/pOLCzJ
 Tjp5ArdEqxmFZ9rXjSJCuNkfO2p3NIaH/K2aXdDqLDbB6qunsvFM5fN49D8rv5f4
 AfDKnb48LnWkBTcVrCjrOH4qfVAyGRVpQxEMAcQOoqQNbEOWs1E2bVhrieg5iU7t
 2xK8xTk2sYqYTintferPyD85eAlbLopmZppA6wXUBL6VS6XdbpnmUX9mDWC+jqxD
 XCYMXPBDgzyW80tX8G2PJbFi1vBwT2akMaoUGmHirqdi672SWwgCJCNwZxQPv16E
 psaRasM3aJEC75vKCtYZP6Y5ZkaEMRewpOn2f3VYlefPZkeGwQdoIHFvK/g7owfp
 iPSLnw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3h8nu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:21:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf1dece2ecso27980195ad.1
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741264; x=1781346064; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nroo4Cf4zt2Qa6ejbVMn31XZOpAN8ZRa+245YL+zq2w=;
 b=QoPC/bV7LneyPUJg1yIEyFRyYjiI+hSBFiZaGms8Cgg7HmK+Wc7OrQLCZftp/nEJ0y
 4KH6RS/NLD6EDryOLdKmq2Br67JclNak/AN1eg8FNX7uEBWN+/PPBGYMkdU0VuFF7Fvu
 NfKDeJS2Y8RvdkqQ462llJel3+Z4BKAbvEm8k+osU6RlS/7mBAsfEAc6lMVDzfb80k2G
 otqaybfIkN2/FKLWcKINd4+xMclbguLha86W0onmHwxvxvulQv0BFfB9kEf/wEdPzIyS
 Zc22OL5duEPdnQx1Wgcy4LeqKeqK1+M/bTSAGRcepJUdL5xCCDWtUhTZHB6rvd8TC2QN
 nS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741264; x=1781346064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nroo4Cf4zt2Qa6ejbVMn31XZOpAN8ZRa+245YL+zq2w=;
 b=RfcxUY8/IuKrCrGeUu+Kotan11RA4o0Vhlurmh6+wcY9RVuIOZq8uk/ddmdDR+/nkV
 Aq7FUe1RDnRZpHh7LJ6Y3/+NgNF/LYg7/q7pvUdcP3rYh7+0YzeNsmkiRj/GyOVwd5d4
 JXMZJ9+g41fFtL4P1WPaTHQH2HQGSn9Vql9UmqNjUeLeO6ZGX+0hNQ5qQ0psTuEQUU8K
 f8bsFqM9fQ1Y41fNoM3TA/UxJJaQxhnIdMHfmSryegbZp2NCjIKDlIm6JwkdkKDE5+r4
 3JttYkxIYhW1snq8AvQDHuLpUqt3LnHcmrtgchycwWopDxRL81WGjncTOBBnfH2k+XM8
 +3hQ==
X-Gm-Message-State: AOJu0YwymA7nYQhkkE8/QxevHgqxNrorYENCNew2o7K8AIkqXPumkj5H
 oiTH1Gv6eG5b2An5Zqw7HBCU+BvFLZL0R9VVCc2EmNpEnSe/A7uo+l6BJuD7NKc29xAMZ1gfiSw
 6C4gAbpBZ/Kf4vHOxixTkpKES3WNODXBvDgbPg+3FJMOfbaNC6FcxPwaL
X-Gm-Gg: Acq92OH5dnK3pz9SVHbyGLjaX+J1vTJZZFLXi6QrSAacAOBX5KajOVkdWMg0NIlCQOs
 Jl9XV8Q8ENCEoul1fJphkgZC7RUW1VTnxzwVKnGNGQ+Gv9rEcUK39O1U91ZUXxjcexItW+Dk7Xs
 GTEL1zwiu8PVDGrTLs86FztLItptlJIFc8GWANfilhUrCJqP/THf/HrkVgrRKhF9CN5PCF5Myjh
 2FbPVg9q6ET7Z/ovky0zULF4Y3JjjovFhLRdM/8dK79vqRWbHvct0szdL9Jr9hLfjtzJMavyg2v
 ACbEWuJp6sv2G+XPmezArWSY/yTR3+7HUaLBeu0WZTZDmVCedfAoPxpRn9ArXxcMCZ125lt6/5j
 dEt1jwBu1YiDInFhIxOa1e6bLmFaRU398k8vzBSywC0Ae0OiyWPE+OK4xIUG+j50ZfURTeI8TwO
 MSI6+8FapCi6nndoaEj6B27mhuiCucsNS5vGYTS7msQRy8LRIwUXuTDHohzu8k
X-Received: by 2002:a17:903:1b47:b0:2b2:5491:e32f with SMTP id
 d9443c01a7336-2c1e8344ef4mr89543285ad.16.1780741263587; 
 Sat, 06 Jun 2026 03:21:03 -0700 (PDT)
X-Received: by 2002:a17:903:1b47:b0:2b2:5491:e32f with SMTP id
 d9443c01a7336-2c1e8344ef4mr89542695ad.16.1780741263134; 
 Sat, 06 Jun 2026 03:21:03 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:21:02 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:39 +0530
Subject: [PATCH v2 08/14] phy: qcom: add SPL_PHY_QCOM_QMP_UFS for SPL UFS boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-8-72fed24ef01b@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=2043;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8JFPvW1WGrdx/xEpGLUjhMJREIGHIXXzESGYPI+vpW4=;
 b=umLLpP9bRprDTxb5owMH65It35GaeIJvzQ5jrTyhFfYk2x7bh43SIIp6foTWk/IXY3rI+AWxP
 NiZOOVZzRnJC9FdwS8+R2BXggla+2xAx+P8WyXXq+xbgnXTxZi4qx9x
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX6pvxlQB33EIE
 eb5bn/ElkFvAVDJBChv8/XHQUxrALEtHV7PaxzV/y7JR4TkXRExDHBJh62e5B565AKp9+pYTb0g
 Wvt+3Ce6/8KGbc4wZYVR22StLsSmzQiYSgEI0f7MgJKf4fEcdrpUNExl1NmVYh5QysKc0JXRh5p
 Mhima+bBH0XmXTiK9EArdaIhy8QahfDuk69qS2HN+cv6D07XvRH75IEX0bNvHyTBN6RlNOeTU09
 cOKWnaPJ1qsAXRQmgquVOERb/FFllDlAvRjC8uoQ+tniAlzPu5P6pqHyddYpGfo3bYkGPzD+zuG
 E9hBcnpNH7I7g+9DQzwGu4MMyWm7JeTaZzICp7xZwuE/ZNvBzvo7wK0+KJpqVhrYUWdYVleIN+X
 2D5eOf56ODzPio8wNPUMgpHhglAoOcHndJYV42KLVP0rCIokJkFbyfILp5a43xo5NOhNkRri33I
 KB18YvosOysoXLJ1OHg==
X-Proofpoint-ORIG-GUID: ZACdkfBRRQYnNbIJC4aXqaJ9Y-17xUSg
X-Proofpoint-GUID: ZACdkfBRRQYnNbIJC4aXqaJ9Y-17xUSg
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a23f490 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=WckjSPRqp3cVtEsYfEMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
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

Add a new SPL_PHY_QCOM_QMP_UFS Kconfig option to enable the
Qualcomm QMP UFS PHY driver in SPL on Snapdragon platforms.
This is a prerequisite for UFS boot support in SPL.

Switch the phy-qcom-qmp-ufs.o Makefile rule to use the $(PHASE_)
prefix so the correct config symbol is selected automatically
for both SPL and U-Boot proper builds.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- No changes
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

