Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425EACD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C01846F8;
	Sat,  6 Jun 2026 14:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dvSHQKJr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j4H5fOFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF238405A; Sat,  6 Jun 2026 12:19:13 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D24F838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656631eV613029
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EZ900iOw+EaIiFxLpE/8JOb9u4DWZjR5TURNVn3IDd4=; b=dvSHQKJrR9x10snB
 EVwXReX7AP32hm7ftXUbbMz/bhmL43AfBRq8nkpLBa/H1smN4qaAKNH1CQtTBNel
 RciBeLO5PogEUt8l9Jbs1LGdThxqSpc1RY73Vb5snx2RbwFQbO19o3hjnyF6IIU3
 upQnceDWsZAz5iR4Y9L2UhJypfwsdeufaNF7sSb/PTxxNAvo4ipOjBxugVD/gKbD
 OOlmH0qIXr6MsN0uImuaUvRuXlVtB0OJAi7OKCMp5iuNTl83PueFZf7bqcT5kRLZ
 TjtS2d+phjJxp8fuuK5FQ39CG2O2S/AbrqS3nGejV0PeEE6V2NNj+gYMtDJqZ4MS
 jVuN2Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf10ut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:19:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36b934a336eso1997781a91.2
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741148; x=1781345948; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EZ900iOw+EaIiFxLpE/8JOb9u4DWZjR5TURNVn3IDd4=;
 b=j4H5fOFIOWY4EcSKqoAIygahDSzkA7tdR1ms5blsftmTStcLu3LcmzVrGuFQ1FB2MI
 i4+5BneAZuTNMLIwntWpP0aoEpi9rDGooQtlogx4RS5dbZsDRQsPkjpHIIiwwxx98WUX
 /w7gPSBE5NfGn/aXRv+HxoxNA0tfteA9HmiV9I8rTcEdw1w2KF58gvCEtREQ+JRs0fwI
 mJaz4SZrqTEskLfda7f6N5QYHZA7AF2FMhGas+vJRXyVfGG5XCVaR1FMGEyIX4VK6r1+
 l8mYw8X5E677Dq74wCL7FQNxylVx7O8HEbEocP57JAcqu2JKVUNL6hRW9ktyz29OxUYE
 wecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741148; x=1781345948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EZ900iOw+EaIiFxLpE/8JOb9u4DWZjR5TURNVn3IDd4=;
 b=KTLnTrlg8ckKzFNyXoON80T8eQxaYVB0slgIKnoFVTy5CQfx/O4bOJbfBhe22NGjbB
 nOF9Iyb1paMRImUXyJSuE/wbhHZa9e5IqJ8u73IpTFiKCQd2Cl1TO6jU/3YKPki9NDRz
 yPelqIooODGj0GKrPp2Fan27QVn5xtbljeYteczsRlgZxGMHbMC+EwVVdlLdgfSMyUBC
 8wzuo01AwZfeS7LgiJPXrKXovyh0gh+fUk3kgV1rGpV+rttY33gwISMsL6X7TQoeyasY
 4K1aW5KA1fp4m60vdxFCYYlDTWz8RmZhMqlQNM5pEphQOxU5mxvF+zUwAZelFwSrSdYR
 yAqw==
X-Gm-Message-State: AOJu0Yx1fHvrHOT3LYvaDkUbBGnm9NmgAwu13s2FHp4GSn93vUd90JW1
 sTmcAR92IvK1Nm8SSIxgw4I2cFVy6G6vZzpMxKNrfv7KRWHhj/zIYgIbdf6xpz7xgYHKS+d6WtF
 WFMcu9AgslaBe9NF5p7RD2iibe8+I8Z7eOQ+I4ekgo28z+r4EleUDvLK4
X-Gm-Gg: Acq92OEuv4YSaAOgGx8aJA2w+370LZ0HpKyEEmAROmD3oqtFHmcB/ZLYxmvdo84ukvf
 jkb3X+nDHUSnMGtTM1O3B3N9UBotI2iA4u/LcRigJERvuIAbhTpOyu0KQbFk45YIeKW34E4K3CZ
 1Dyvr/2T7A128FLUBnSweXiN07/dx27JLb9Awez4mLxtRThukwwWfwXP+s4wGjU1PvS9gzU2wJT
 s/OqoPRlMBnvPJWIMBAvLkBi/b9slZ1SD87XrwPKLk8Sqb+tS/XIZSTPHMwmbfIHofhLHYNDhAC
 IDnmWnMXpNizzeluk/4utOA3GzWoSfIEMaKJRqZ6ofQ/r9Iug4PraUbwUiXLUwxsXl+IkVUceQL
 ocQyV21P4Kx+28GiSbyUpsgsANyBDzhzQpcT02dmQBo1jJhC9+ehKsIKvqSudCl7lc9J9KfwgAD
 moVJ4BdzdOiCSJ/6bH8wfWO0lqI6xIfFgjuzR7oahwzU3ftGKD9eQoQ9cRifTM
X-Received: by 2002:a17:90b:2ec4:b0:36d:bc0d:f789 with SMTP id
 98e67ed59e1d1-370f0a608a2mr8221564a91.22.1780741148227; 
 Sat, 06 Jun 2026 03:19:08 -0700 (PDT)
X-Received: by 2002:a17:90b:2ec4:b0:36d:bc0d:f789 with SMTP id
 98e67ed59e1d1-370f0a608a2mr8221529a91.22.1780741147721; 
 Sat, 06 Jun 2026 03:19:07 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:19:07 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:32 +0530
Subject: [PATCH v2 01/14] spl: ufs: rename SPL_UFS_SUPPORT config to
 SPL_UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-1-72fed24ef01b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=3714;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=xJjScQ5PGpIEsZ1dF/dvdUEzaMwe1q/fzhG8Ssue3M0=;
 b=4CAfNdckDS1E59X5YsTh3Oa8bjAVJxKb6YmCKT1N1eioCA7Udxh3RaDQitEgEuUeqWaHYrG4r
 2ORFndOMrLECOgsDY4ZxV3hvKCuCindwnsGZdHlEnsfvNUmg0tn+n1D
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a23f41d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oK4Qh4Z4KlirPaUN2WMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: BUCkwCkXNoXZoKbvMgEqyZcm-rtW5eDt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX5ludy1PMplnI
 dekLkBCUA2PAf8Ji8byWnIOdxVQd/n54wRKNutqsFL2C+GTaTin9MtsoRzJymXW2RLr5U/WTxEn
 lV4kSrlnWzyACx/NJT0pZ8vhuM2ZfuTukxXb31M9/4M4//HrWlYkb+RvNgs76K1XdBhKPp2NyZA
 ozoOw76N7oXHfuv+8wyiG8jP1rMU+XOs6mBZ6uSLp1jPLJ2SquEWe6S+J8BEl0+ZvWfHYJOMLHn
 Jtm/+It79RzlOjnmnhzzjX++ZzvYj1gFnJ1E80aMzYLrmmEJzi4MYI9iQMVxaMeXYblPvSTF3nb
 ArGgflORjYc0hUehPB7DepQVimvpUWbY/MDmtSkc/lP4o1dhYNJmCuHnDEeL1OBAjP1K3JTMR44
 FkNMPOS5u8YHTD/4idVKwlOghv9fXq1Z9Mp4q1HrAm38T8BbbRTNl6pk6MHStzaQRxc/CwK941M
 EtRazzc86WlTpOFci7A==
X-Proofpoint-GUID: BUCkwCkXNoXZoKbvMgEqyZcm-rtW5eDt
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

Rename the Kconfig symbol SPL_UFS_SUPPORT to SPL_UFS to align with
the naming convention used by other SPL storage drivers (e.g.,
SPL_SATA, SPL_MMC). This shorter name also works cleanly with the
$(PHASE_) prefix macro in Makefiles, allowing uniform use of
CONFIG_$(PHASE_)UFS across SPL and TPL build rules.

Drop the redundant `depends on UFS` from the SPL_UFS entry since it is
already implied by the driver selection.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- newly added in v2
---
 common/spl/Kconfig    | 7 +++----
 common/spl/Makefile   | 2 +-
 drivers/Makefile      | 2 +-
 drivers/scsi/Makefile | 2 +-
 drivers/ufs/Kconfig   | 4 ++--
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e49..10dcb7b2f87 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1613,9 +1613,8 @@ config SPL_THERMAL
 	  automatic power-off when the temperature gets too high or low. Other
 	  devices may be discrete but connected on a suitable bus.
 
-config SPL_UFS_SUPPORT
+config SPL_UFS
 	bool "Support loading from UFS"
-	depends on UFS
 	select SPL_LOAD_BLOCK
 	help
 	  Enable support for UFS in SPL. This allows
@@ -1624,7 +1623,7 @@ config SPL_UFS_SUPPORT
 
 config SPL_UFS_RAW_U_BOOT_DEVNUM
 	int "SCSI device number of the UFS device to load U-Boot from"
-	depends on SPL_UFS_SUPPORT
+	depends on SPL_UFS
 	default 0
 	help
 	  UFS devices are usually configured with multiple LUNs, which present
@@ -1637,7 +1636,7 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
 
 config SPL_UFS_RAW_U_BOOT_SECTOR
 	hex "Address on the UFS to load U-Boot from"
-	depends on SPL_UFS_SUPPORT
+	depends on SPL_UFS
 	default 0x800 if ARCH_ROCKCHIP
 	help
 	  Address on the block device to load U-Boot from.
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 9c94e8f143e..9714ada59f4 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
-obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
+obj-$(CONFIG_$(PHASE_)UFS) += spl_ufs.o
 endif
 
 obj-$(CONFIG_$(PHASE_)UPL) += spl_upl.o
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..86a54b5f332 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -73,7 +73,7 @@ obj-$(CONFIG_SPL_USB_HOST) += usb/host/
 obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
-obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
+obj-$(CONFIG_SPL_UFS) += scsi/ ufs/
 
 endif
 endif
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index c9af60d5d03..6d1f57bf101 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -16,7 +16,7 @@ ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_SPL_SATA
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 endif
-ifdef CONFIG_SPL_UFS_SUPPORT
+ifdef CONFIG_SPL_UFS
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 endif
 endif
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..64172454bc6 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -78,8 +78,8 @@ config UFS_ROCKCHIP
 	depends on UFS
 	depends on DM_GPIO
 	depends on RESET_ROCKCHIP
-	depends on SPL_DM_GPIO || !SPL_UFS_SUPPORT
-	depends on SPL_RESET_ROCKCHIP || !SPL_UFS_SUPPORT
+	depends on SPL_DM_GPIO || !SPL_UFS
+	depends on SPL_RESET_ROCKCHIP || !SPL_UFS
 	help
 	  This selects the Rockchip specific additions to UFSHCD platform driver.
 

-- 
2.34.1

