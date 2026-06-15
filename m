Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7810ECD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756158485F;
	Mon, 15 Jun 2026 10:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLY77d8K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IqRs03o/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B293C84704; Mon, 15 Jun 2026 09:00:56 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E1B83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6Iu9B3332455
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 paWsQNqMywxoM0dzSUl+slyHQFO/sJH3sWilijNeJJs=; b=BLY77d8KMnN36l+3
 Co/t9e4hlTsoWVBFLZrseuOxtmieRnandFH6Z87RSMmcKwAt5i1o3ipzxuybE5uf
 ck6FORgeOyVAlE9U4QEo+1eKvqKsGMNX4Z1wuqeZlN8XBY4tUaOXZuMUDTCeO07v
 0B3YgZ3FQTs6jumAkOO06kjz2rMxTmPS56Ek/JJ2l80IzyjxyvWA5qbpIXoCtqr2
 B1j6ir8dAQ5Xrw+yGqBqdKtx8d4Dey5a1InsVlTXXPmIKwjBZwEYiupxBQq14m+O
 YN4bzF6ztrRf2hcjiYNCSUQlGnE3/sFW9y6W3MFChhJjaS/CXkxLqx64ELb5Hoqi
 ywSSdg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye164na-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:00:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84238e83851so2017290b3a.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506851; x=1782111651; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=paWsQNqMywxoM0dzSUl+slyHQFO/sJH3sWilijNeJJs=;
 b=IqRs03o/sAENhd3MD4OwSU2Qke7SXckeHzRl6sFCEnQfjBe+nGs8QRcF7XLKPbuPAa
 xnnlwDKFJTbAnqrKH0pZ4aApcpbpJCOcTFRW4N2kBG5Uj5ON9ipRCoBQy7hMED1WWPPF
 3NZwHkV2Cf04dZ4Lh0baRFzdabFgsCLmD9ChxpY9PY8N1xFxzU0ZPrrLHYkCpiafQ+b3
 y2nHRDiRnImYyHNWGT5UjnSRiAr+jnz9WwKFHlMDZAY2ZKPxAynHV12f6OYxResi0TdD
 aFmFj5qP1x4yVsTHkyVSxEAP9+sXKP53R+dyulrNN+Azd1GhhFm4CzRHk4SXYHIr2CWG
 J1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506851; x=1782111651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=paWsQNqMywxoM0dzSUl+slyHQFO/sJH3sWilijNeJJs=;
 b=FkJzoc2XoRz395205iK2WfrPuJjH6KInU+2zlRhEiGFVa6M6cQBk2p9OsDws6i1YBp
 vWatErt/usJ1NtgmvO8bzB1quyy6qdDMQsi5yzGTnNl8Atklm3qPvqc6nJlfPk2uHDaA
 ovzAynLrNe9dWkqhRTIlmtPAx1O00JIY4cEi4H6rC9Z6BjIuaIqwniAXIju3ixB6cJSI
 lmiXivB017udHbSXq0XGw0JmzduE2X+NY7RP3SsjjLS+ThbjUvW4Qa5REGOqTmGUyXCJ
 9s0EgML2AhDerfQUbol9uqW2ThvC2wvYpAmh9/hHRYDMeYjT0Boh7DI3h1jRGyrMzdjK
 TCaA==
X-Gm-Message-State: AOJu0YxYSRxTcXZYvHqxJIjdFpd+imu62XLsnLBpLZogtOb8jTyvE/AA
 sCXh9btrKqAfkr7MQ82usqsLV878YjzN+Wi49KyVe9pg3Dssd+IrlTAs6sqsgDnDx2glJyp54i6
 QoL3J1nhdpahthY3qX+geNH5mZkDUHOwfNBBe0xuVkXvFwXe9o9Pmk+bY
X-Gm-Gg: Acq92OF+Ldenh/SaYbytTZNA4INXdcMK/Y63kBdt0+fTgO007KECbQVgo7AXpH+8Vdx
 FtG560iRA5o2R3Y/mKz/04fhbj/TYuCzNrrmzx+rhKqE6+UxueaStuQvN1/nWMsQzJhy6aXckUY
 TvPOkIT5LFpkjBPzDinQ+GwFLVxf0lcWNOh8NjNgE8s9Qj3x3LrjZ9jxiYBc45Xqnh/hr3KqTIn
 KSMdkOhin/+L9O1MnsUD+sIzSdsf7BOjuUWRxslJjVm+jMVz+ExksAKUzQ33zVBR2+ZiSH/Mh7P
 nMfRDjNW7tvqF7SLvdn0gVC/qBe6WQDpuQysSZ2P7aqy8lc6WMtgiBuPpt+CtPslstu0L4d+P5W
 kZWhL7zlF6k8S/ywBgtAwoflPz+qnyhPaXB7tL68a1U/6ZJVUZGxPSu3Z/227nQx7zpuF7KdKP+
 b1u8DMN0ftoqZMXKQLViE5PaXPpv21xVwo+EYbV7adU8v7nVVLgA==
X-Received: by 2002:a05:6a00:12c2:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-844e19399d4mr10727716b3a.7.1781506850403; 
 Mon, 15 Jun 2026 00:00:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:12c2:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-844e19399d4mr10727629b3a.7.1781506849825; 
 Mon, 15 Jun 2026 00:00:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:00:49 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:29:57 +0530
Subject: [PATCH v3 01/14] spl: ufs: rename SPL_UFS_SUPPORT config to
 SPL_UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-1-360bceb29596@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506816; l=3879;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=GWxW3HCl9ZPoDKR8GIvcZa79BY8HFxKJfvyc21oD7C4=;
 b=LIEXKDR/O2e7/bwBxLmmMZiKU6p0fn3cOUTvKR5AZZ18eatF1/4q8SUhs/iixlrgzeY9ZnlCL
 +3OBFJ6jTcGCLfsJbE9MsGayVQlqGw6xnBPuBZ2HpTqHE5LUpMF72cu
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: zmRsriK4mPXGZh7uVhW5WY_zZBp5f83L
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2fa323 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=oK4Qh4Z4KlirPaUN2WMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfXyr0mkHbFzKvn
 Sq02uWSq9FD/2BBPMtBfqDymcpJKAFsHoAVm7x5vZljXAdU04IsXiT1BfTJ+HFsXhipAjY2XOuw
 RxWwNQJJ357XqQeueKlaokmkX/Hxv+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX7RBnikJ46369
 JyI4ak65WtZ+j/yd+GAqLlXV2L/Jr5misTYQgyXs0Jl1T6dwAMD7I22ejEduGUllKlGtToqOq16
 o/e5+33OWxEAC6ll4yADpYJzDmbBk1iMHn71j+v0TKloAFVGqR8PAy/zbRh2uMSWZ7e5Etm3Snm
 eye20ISvO+Hp1WWqiRvEZHMCT9BbSsGWlmpvIUdJYJoEyFp6hm34Y+YMkmuMzkzWhso5eHHHTqb
 1fDW9anct7wmYRWUZJoEn/RqHnqOriWzh7YHUgggjdHyF8W2dMBGojU99ixBt1fMKQSimmhmQJ0
 gXq0kxYEQqzYdsFmE/aKS5RlrPMER5XMVTEfsaJ8do3vXxO/75SpFSDihm3S0duz+QfloVBblj4
 RZqA5t50w3SIjvURKFQUSAzBs0uNlaBvIAIkNqSn2KXiln689Ys6BCzSiNIoRBOdBq4tGn0XjNC
 y61Il7huTnRT9HPzj/A==
X-Proofpoint-ORIG-GUID: zmRsriK4mPXGZh7uVhW5WY_zZBp5f83L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150071
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

Rename the Kconfig symbol SPL_UFS_SUPPORT to SPL_UFS to align with
the naming convention used by other SPL storage drivers (e.g.,
SPL_SATA, SPL_MMC). This shorter name also works cleanly with the
$(PHASE_) prefix macro in Makefiles, allowing uniform use of
CONFIG_$(PHASE_)UFS across SPL and TPL build rules.

Remove the unnecessary `depends on UFS` from SPL_UFS. This dependency
is not needed because SPL_UFS is a build-time option that can be
independently controlled.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Updated commit description to clarify on why SPL_UFS does not
  need to depend on CONFIG_UFS

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

