Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DCDCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA278484C;
	Mon, 15 Jun 2026 10:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pQWTnMgR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QyuFVUv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEEC84704; Mon, 15 Jun 2026 09:01:27 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAAD083FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6LiPS3853182
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JT+AHubUdWiKa0MJHdleyHYn93jOHbJwGN91goTFfec=; b=pQWTnMgRfAB4b/3B
 dXzFrY3WF5yqjQCswUtJGtUZSb8tAnUfz0X1y5+q8Pl/oWHatjMgHw7r0MOViS7U
 FAhT+0nwrK8W6iswECF1QRC0OpWrDxd3Jgqz0NsBUgTqLp1BPzFzU+d2NzKDyvQm
 FfbtnzSDsjcstRjJPN0Aw1fCT+Xi7+1jk41axse65B7xgBvzMdv6Q/kp53COdN4D
 KL1xkz5sfMSQOJWdPhAMEJP7DtxglczI9gGTZhKq1cXJ2qOkcz9l8UhcruVbbCO6
 SSoc5PAWRB7R44SP/3pYr0PLDokqOS9MWGUcRScFmjB7PvS2hKEvufqJ9/wlLRNX
 JXvAgQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gx5c4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:01:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8422a0eee68so4266442b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506883; x=1782111683; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JT+AHubUdWiKa0MJHdleyHYn93jOHbJwGN91goTFfec=;
 b=QyuFVUv/MTX09nTkhb79GuvbMlc8dkQFHq/WGxooJyhE8cmgtgukgP28Wezfv3GL/h
 4M00jpFImi0ZyeaI98q2v3A19L+2fKEVz4Gv/Qok8nkRccU2jwfiTNIrdYCwg+z+L9jp
 F660nqFmBqtYgdbOOAzHb0OXlzb7wCbMZG4PgQtTcPNRmgEuI0NOcAKSPFoH7ZlrbqJP
 MXxW2K2wR95RVFrZXu8tyQGVppHnP2T4mFHqA7anZThnixyxsXM5nG9a2ghxk6yONmMK
 eF7H8yOwvCnAexsxH37o2BuA5Nt87P9XwtOte3eTKGeQCHPXXM9wf+LLwAh91ZPPjsQq
 8K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506883; x=1782111683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JT+AHubUdWiKa0MJHdleyHYn93jOHbJwGN91goTFfec=;
 b=oxaTEag0e6oL/QLHlf89nkrB+QZKwCpGVZplvoUgrOcrVMnJ9URFCWBVbT+B0YE2G1
 y5rQGMrwKVtS/4Kp+X5j5ZOnVV7UGztkNZb6RQPkqE4k1uLLLX5QteVWw2ljWxAi3ZqH
 3ZgBm2n8IulNyx9EqXSWrW7xemVE1KHoZLz3wfOexrOSKdb+G8WeD/lLPViAG18DSQMP
 omZpBl/Lly1qhTYh3NpbUvZ9rvTNQj9fAFmLIj9Owjp/vlRPQ7NDXtUaZPlRuTkW3Eqf
 DB3AyMZOf2GYMrxo0G64TSJw8M4sCULw6/6jhOvawK+t22f/bsVUViWLaISvhVig+RhG
 hWOg==
X-Gm-Message-State: AOJu0YwrXAMNht9QtJEpf0vjxCX3oAcXABevcRg+gve2VDFrWk1KPLrR
 xVUU4o03Acy7mAkBvUAsf2kbcVQ/Oam/gtMDxOPcj+uDT7uuM60NV3+8/MlPR6+a1mI5AzlWFXZ
 7xLnom4HG+Fdbi/NJbCEkzV/+/StqoB305DSkbfnE9EGhvF0QmPSr1xUl
X-Gm-Gg: Acq92OEEl2k2M5w5QjuOiIJzHvsc9Pwjn6Mkczi7FJ95oHcalJKApG1eQcOHVj4ptxl
 SV8sHt/Ldj39q1qyA0XTHin8/IPc5toWrvceS9DsaTN0Vm1fN0cr5q/YsvbXzeKFqIboYVLbnJ0
 Smx1RfVPwoJ3fxMDBQ9KHM1bStgdMqxW5AftmBOPqRlq98dnV7WUjfVdKaaxsiga0cv4mkr1C83
 JNAeHXT7ANHhpmoJE7gkQO5Ndk4+VHjh9G5n4XWt77zVx7vxRcd6YpyvwLhkwYgDQ522vs25KTY
 k3ul65/RlpRuch56UnTxSLIj8XGTPFZDV7MMHHGFvLdKcbvUPCuphZ7HB7ziFJuZIOhGQ9OEn10
 i/YgicMYq/f6AJQf/ZY6HEMUgcxdc0pHHKnNahbjVAbuGhlXP8jrpWRrANTcVyv/JtSArqXrlVN
 TBvVohU3BpoS2hUISe/U+fJhf8i2jaYfTZiJI+tGyKg95qc6qW6A==
X-Received: by 2002:a05:6a00:3486:b0:842:670d:f6dc with SMTP id
 d2e1a72fcca58-8434ce46526mr13996127b3a.27.1781506882815; 
 Mon, 15 Jun 2026 00:01:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3486:b0:842:670d:f6dc with SMTP id
 d2e1a72fcca58-8434ce46526mr13996064b3a.27.1781506882355; 
 Mon, 15 Jun 2026 00:01:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:01:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:29:59 +0530
Subject: [PATCH v3 03/14] spl: ufs: add Kconfig choice for U-Boot location
 method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-3-360bceb29596@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=3233;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=lagggH30Fqf6TW19MNVMXUttsMHD6XZdFPoUUypLuoQ=;
 b=vV7A1wzOGRMWEio2MpEh469P9tZhzCpW7pDfs7rhe/hpWJVzt6tGNbeeJKKLXKwWxefpRBt/Z
 Ezgxl+UbnKhBI5xwAnCQ+N/gqC5l5nCL3JdXM1eZOD/U9lZmat6JjUd
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX3TiRUPZbmOZR
 4ZA/5iW8mfPdLrCVjfmtNJvlcxLGArjaPQUEQez4qs2DIqBDbHMMluIW4cAY7T6B26Dva5QykbS
 8/zRpcwCQCRUY9BG2QtKJjX83lE+AEA=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2fa343 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=0MC_39LZJF0Zaw0hVAIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX6/v3iRvkklzE
 ocG7f3KuH3NDVTRV9z8ZMi4anot3VBJDzsjW9p3lpQgmrEWw8soTxQzTN3LwhQicb4TjROqxzP8
 88wPsuLuwSCmd65vOqrlwbz7zZrwhyepFbdxGnd1tNtSFC+hcRqRUYRjOvPaeTQqrFevd1JZQ2+
 Tk3CgizkGfqCuAkLr7nOyRDPOfr3Kg2Vk1SOM/5vyraWC7KhfX9VCswjq1PCJQWbEw9nd3BnSST
 5eiUQxBEJDJVPgmHfHGrNfeqKRZ/OKvF2tdfTtNI5M3WunfcZPukubyGz/d15zfcnMyeZ2zkSQa
 +9vlkPwTq1FuB/x+gKnnVNFHlUkkqurQLegBQDCbxRSwci2U1g5KyHgqlwFeJIaTJ5Il2Cs+ikG
 12s55hg2RBoygH3lb/vF1SNI68ddV6HFaOi9qgNOofqeUzoPAyiWMgqdI/WblrHZSO3nLKaSeyG
 tuk2q2VjMvC9ZWlpmmw==
X-Proofpoint-GUID: PHuY-Gle_ZEczKL-cbl8u40VzgjP4u0p
X-Proofpoint-ORIG-GUID: PHuY-Gle_ZEczKL-cbl8u40VzgjP4u0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
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
Changes in v3:
- No changes

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

