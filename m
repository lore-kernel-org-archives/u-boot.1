Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7927CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B913847B0;
	Sat,  6 Jun 2026 14:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJLqfoW1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPIRSvdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C56D68405A; Sat,  6 Jun 2026 12:19:29 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9AF838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65660lma694274
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f+JI7LqXsro7TpfJks6TBZpR/wsnWJanlulZsiLJpiI=; b=EJLqfoW1/nzRkN3m
 WqMHv/17IpXk0vLrCsYovXoXQFW6cuTnzqz0fxNueqN3eErCeYLi2kBbi+15hCAU
 2iyxL0YvrX/Rfv4ctg46yE0kJJ+GiS+Lbq4a4eU4bV+ZjBc+m0xyBV7p9n3oNrL5
 a/QBsgG+Y6tu44GCP5FvwGe+EbQqcUBrKgwDhlLKrc6WbkVFhTZZ3rWS7mre1KjF
 isCDSLfFKSctv+7e6yaDqsBuY6DRVklygRtk7voDsdbmPWy/a+XvLhAhSkmu7AsS
 919QHX5ee4FZu1qEQ1/rowY/NASmYTUQtCxsU8uQVn+7cpDHZFTjejEW8oIvhItw
 dqRk4g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8rkp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:19:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36ba24fcd46so2189758a91.3
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741165; x=1781345965; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f+JI7LqXsro7TpfJks6TBZpR/wsnWJanlulZsiLJpiI=;
 b=JPIRSvdgHwXv7T7Tgy7sN6smFrMMa0RFTQqIpx+82vpvvNCaUO4BTvSbJqBFjpdoQV
 XSW7H3gLci+JippqJpyua9qoQqlJfdEKEhCNr053K88p+uAcKXSrFdhO8ym9SFOTVOVu
 CwCBSURUnsoJ9ZfHpJZhCJdqdT8oTj9rxdAHghdk+EN+oOSoWF+WHlTIJ+psCNk8219d
 rRCc3S+BRgobhK4vFZ6MvaFh5nMVsysgwPQ/Eus7hk/iQz9htWZaRiU1jRpSKHXALttf
 stWirJo1dvufQ5u0oxEIizeTXoKmDYEa/dLXeW/lyuTKARhTgI7UGMczx4KKdaEPoSt0
 6aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741165; x=1781345965;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f+JI7LqXsro7TpfJks6TBZpR/wsnWJanlulZsiLJpiI=;
 b=b1+pVDue15yiXQVsKRpJOeIoGszWHColH9aQcdpjSAAqcURT/G0o4mPtnsceoAXN6Q
 oIDyxLqV4g51/hFqh89Ix9Sgq8MxAKYFeDLx+pt8rMA9ey0l7DIOzpKfYUEhsGnK4LaP
 nHbN0d0QWRrDDfpoz/IO9N3oaNEKEXwkRdGBjcO5IFD5iYPdg33TWEvBQLhAGNe5wGNV
 UwqMfRyFlVfpCMT0uLw7zT3T04b2kXJ3n9oNxS+st7yUeWcZdBdBfgGa0u7r5bjwbcks
 oZA+PPOtAm1/3sCqarWPtxMEPMIFG6emQD23TI24WGcOSKzHUAD05WkRgPLW0SIRLeuV
 DHng==
X-Gm-Message-State: AOJu0YyfHJ8AYEaFspnDjaRZMBnzQB4FuscodYIjkHpAr0XNYis3hG3N
 s/wrmqlF9wbkyY53SJDM43tcv2mHaQ6T+JDrUSImSOTtEi5QQT1oVVRHciL+ZxyfoAGFpk8WWgA
 Ibh1SISFroOy7hE3e8DsvFfmflmm83gFK3F78aROwAnScmZem9/5FCVY2
X-Gm-Gg: Acq92OFsqIKtFK91H0/kbV8mGEL0/tdzkYtEWprnvEjxl5qxJB6KZZB1NUiHdRZJoT2
 JKxeYpsUUSwblnrT5fMe+WY2+egr3BjtYYzFoJnRXRi5eNlr1gQ5aTK9eUIPlc5cDrTlLmYS3Bm
 7M3ORyLBrviJp/GRtDXGr1pxhBPSXahIOhQp1KYbAEKMgkWXwAJiDTXY1PUSDMa+FOAxAkxOpAu
 1qtt3AwHQVwcJFShsy2mVKoLIXnunSLCZ7kx7JJNsl4gcQxHKZdm+APHdQruS05JFF5cdxI0vj7
 YBRZZtEePHMMswvVjPuhqg+gKnv0bVZNi1wpTsPpbSDLo8pRg9fVdHvfzx8Bw3eqv+8MMrOVcdL
 NBkwcY8fGdw51l+MjDCfR4YiL2Nm667eW2LGC9KukQgAxIsYC1of6vrahZhqjqQdd9GGeIVz2sn
 TbhgKa+k/DRBNB7Otqn1satyMbyE9bvtwxl8Hw3+j/LOdIjPAc/LJjHcY/bJZi
X-Received: by 2002:a17:90b:1801:b0:36b:bbee:fb28 with SMTP id
 98e67ed59e1d1-370ee33d0bcmr8474994a91.2.1780741164674; 
 Sat, 06 Jun 2026 03:19:24 -0700 (PDT)
X-Received: by 2002:a17:90b:1801:b0:36b:bbee:fb28 with SMTP id
 98e67ed59e1d1-370ee33d0bcmr8474962a91.2.1780741164198; 
 Sat, 06 Jun 2026 03:19:24 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:19:23 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:33 +0530
Subject: [PATCH v2 02/14] spl: ufs: add Kconfig choice for U-Boot location
 method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-2-72fed24ef01b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=3201;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=xHGogkaowTn0UwsrgpdismP3h1h3JMyOl5JGT3LMyIA=;
 b=Xx7umz9DQmEgIVjuE0Z/J6JgwIZ6+US2DkcsDnxlfB4lt8fmG7/fNB+HAO5aRur6C+tOEcOvh
 BVUaeqCNwKXDqVK1Hu7FVCHLl8hMcq4x4uKWq5+guErfNG2uLiwUE65
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: LbUY67jZpNyg_65Ufhk7uRniBiQUgW7S
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a23f42d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=0MC_39LZJF0Zaw0hVAIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX/sUkS+MSXbSb
 hxwchaySNKTQaYtOUaZ0mfKHtFoyZm0exbLl/sQ2U4H11nHBOxQqDt4pbN0D8NuFF5P4VrbpCG2
 7w2JWdQKUhEycMqFLHA3FUbpZIps3AxLbYBzIfj7/WkJKEfmxkplBHesOxWZIRGxifTxqJSzXH+
 7bvZiAC3wDLfbE3zGsOYDkZIx72b4hJYKR6qHev4cXsgLpr76ZLwxLTdZiDzXGn+0mwYJUUkz69
 1OJf1GUohxSnlTdytk/6dh1JWEsKDGRMSJI4U+GXGZWsxo2FWa3Qqh8xM+bkBd8cVuS2xg42gEM
 UnVY1PwRHLG9o1ju5ijQin+0qomRoT8oD4zuAEeOiquvo2rz0RRi6Epcv8XEvnjQLoUfHvHfYgq
 v7l7Tq3j3HqJG49hqpos4amLHM3/DSl1K/EHGU3lYPLLdUSIWnEXkEBGUSAchFU1mfKHuX7Lzrz
 03DLa/QFRq9iYlRSYTA==
X-Proofpoint-GUID: LbUY67jZpNyg_65Ufhk7uRniBiQUgW7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
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

Replace the single SPL_UFS_RAW_U_BOOT_SECTOR config with a Kconfig
choice that lets the user select how U-Boot is located on the UFS
LUN: by absolute sector offset or by partition.

The sector-based path (SPL_UFS_RAW_U_BOOT_USE_SECTOR) retains the
existing SPL_UFS_RAW_U_BOOT_SECTOR option with an explicit default
of 0x0.

The partition-based path (SPL_UFS_RAW_U_BOOT_USE_PARTITION) adds
SPL_UFS_RAW_U_BOOT_PARTITION_NAME and
SPL_UFS_RAW_U_BOOT_PARTITION_NUM, allowing U-Boot to be loaded by
partition name (tried first) or partition number as a fallback.
SPL_LIBDISK_SUPPORT is automatically selected when this path is
chosen.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Introduce SPL_UFS_RAW_U_BOOT_USE_SECTOR to clearly select between
  sector based or partition based lookup
---
 common/spl/Kconfig | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 10dcb7b2f87..82b757d1efa 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1634,13 +1634,53 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
 	  SCSI device number, which might differ from the UFS LUN if you have
 	  multiple SCSI devices attached and recognized by the SPL.
 
-config SPL_UFS_RAW_U_BOOT_SECTOR
-	hex "Address on the UFS to load U-Boot from"
+choice
+	prompt "Method for locating U-Boot on UFS"
 	depends on SPL_UFS
+	default SPL_UFS_RAW_U_BOOT_USE_SECTOR
+
+config SPL_UFS_RAW_U_BOOT_USE_SECTOR
+	bool "UFS raw mode: by sector"
+	help
+	  Use absolute sector number for specifying U-Boot location on UFS LUN.
+	  When selected, SPL_UFS_RAW_U_BOOT_SECTOR specifies the sector offset.
+
+config SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	bool "UFS raw mode: by partition"
+	select SPL_LIBDISK_SUPPORT
+	help
+	  Use a partition for loading U-Boot when using UFS in raw mode.
+	  You can specify either a partition name or partition number.
+
+endchoice
+
+config SPL_UFS_RAW_U_BOOT_SECTOR
+	hex "Sector offset to load U-Boot from in UFS raw mode"
+	depends on SPL_UFS_RAW_U_BOOT_USE_SECTOR
 	default 0x800 if ARCH_ROCKCHIP
+	default 0x0
 	help
-	  Address on the block device to load U-Boot from.
+	  Absolute sector offset on the UFS LUN to load U-Boot from.
 	  Units: UFS sectors (1 sector = 4096 bytes).
+	  Note: Setting this to 0x0 will load from the start of the LUN.
+
+config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
+	string "Partition name to load U-Boot from"
+	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	help
+	  Name of the partition to load U-Boot from in UFS raw mode.
+	  This is tried before partition number lookup.
+	  Leave empty to skip name-based lookup.
+	  Example: "boot", "uefi", "dtb_a"
+
+config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
+	int "Partition number to load U-Boot from"
+	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	default 1
+	help
+	  Partition number to load U-Boot from when using UFS raw mode
+	  with partition support. This is used if partition name is not
+	  specified or not found.
 
 config SPL_WATCHDOG
 	bool "Support watchdog drivers"

-- 
2.34.1

