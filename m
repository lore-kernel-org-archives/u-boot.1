Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48FACD8C8C
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA048486D;
	Sat,  6 Jun 2026 14:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y5hXFg6c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W5d9UKU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 233F88405A; Sat,  6 Jun 2026 12:20:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A6B838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656618E2653172
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oIjV0g9D3+4E/Ndllqev11p+eSmXErhPqDfuzB0Mim0=; b=Y5hXFg6c6M4pAorS
 xUOVqalKXtq1tJjPAaWsEI7VLl16FuJwVX8cAoGS6JvAEzAxiiTnwHs3q3LOYP0Y
 K2zb3kuOtgvU9DTbzHvDwO2ESwlu15F9q16Lci1Ee/sTBoj5ih8sQaDhz5aflO/o
 VQPBQ7U6FSeRZ4pDrYsUkWzekNcEBxSXhJgwFx4CA1H193ZOREHLPSqYqIzt+qrL
 JWTLXhB35d8IIgdXg1q9oQgJoI6MHFUy0MRCoehHIsqgXjeh9VVmCwCWTf0CqAmN
 1cggnqLN+eR6SOplEK7bUEtPTljKlF9UXRkS0NwxnR4iBIwPNtIpaJB3x90jc82P
 XQAyKw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3h8k5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:19:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bf08c2a24bso26816045ad.2
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741198; x=1781345998; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oIjV0g9D3+4E/Ndllqev11p+eSmXErhPqDfuzB0Mim0=;
 b=W5d9UKU/jCOOAXlFBGq+xla2gEn7tLNJj8DZ86GnCUI214EchqHywZMGhNX51DPnn+
 pv3EViuBEOY10xJGRU7/DCpFNnp/MvRdYxjK+QUIX7MGKizUeyGlGVAUVVIHKhwFlHRV
 cDqRoMGl8aYdOXFnEVFi/YxjxEb9bA1aYqHgySfhvDniHXnCunTJLU0ULyAqBc5ihMyw
 GpkWLEhlC2AQrRGuK6i/3y7nV/ks3lUuXCByV1UV8NVTQJWDnSpngqL5Vc6ShPrbxKEn
 aue9Hq8D6/AoNXlIbFPfLaibt35mdIGiWkfWV1I3O9kW3KSAez85CztnwNZyA0FelLu3
 Z9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741198; x=1781345998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oIjV0g9D3+4E/Ndllqev11p+eSmXErhPqDfuzB0Mim0=;
 b=XjOdtfzBYSQyvqQX9ZvMLFPAjKO58ScTT1H9c5nju7LMfUz+0PuAwaHDt9LukKSFsC
 Bxy2mo6BspYUt55YWZDgt6XKiZdgJd2HmLn9DyH8BTjCDrSy6LnZ6D68QdqZtPYiQpbw
 4rhpL1t6xZ579U1ji98aBbOfLCCBgF9ofTRUrQuZl01BLYxOfJo7B9p/FQncsDYiWQJ3
 5IE6mXDj3EQoxH+a4eHqMxPrqa5jCgJjYvC8awLdKZxbN96a7F3PIM+DzM9xG9Rhz9Tw
 V6kfTW/RfpAaUL2Nyhh+88wIDT8M7YR0NYq5DyqMwR6npvFl6GCeXcsODKn+RAv9E7nR
 pkqQ==
X-Gm-Message-State: AOJu0Yw2PEFx1XtLmVAR9sqb+djja1RgwFFSyY7M0lifbWllupF6Rkbs
 n736QWZYCOE0FrYVSpxJVjVBlv5pOApP+ZgAqJiMJDWXRnC4gCc7boKjO7IGRfLFxxqMzNecpAZ
 pXvfDlrOu0ak8wjLzU3Pbm3Yt6ovQhrtyDkYCiRpXlbxD0naaCPDcrRk3
X-Gm-Gg: Acq92OG2P3uRK4INKA4soRXYU9sCW7PGs5a+rmkQdicVpYVLy5ERQsScT3oHiZOhZIp
 BbNoSC83xRAch5ZnPFoX/9wx0rPAPKZchxC9CVRm1NdckGfDTp27KYbdnzhB41ZypEylclnEwxT
 WNT3JSewzkEVWzrgTL3EfT1W6OXZGl6uxUPRf0niVKN506zyQ+RX1WpROCDHtOLwtZMNsB7nXhY
 NvXrp1NZdYyz7ANKQIgR/QAXk/XLOa7P0IpHv2a1Pjo/mL2odnXSbdeo1HrFVfHeFQXApVaLKUr
 NLXPPhJsrQj+EQyZHZaLdnl+jAqd4UJyUziu2xors2i1giQhSDdvgyrSz9NVjWWpCEWWinuwLN/
 /0XK51xCGNNhTes9wtRhEBA13MQBcg7hvbzJ51TN3/43YJRk1f1ukOfiBOXrwSA5d1JjILcwe7e
 gPxXsVwSsjgkNSNjYxMMB8AHCsnasQzshd7iWHm78lgu55GkQjT8B6HQbx95D2
X-Received: by 2002:a17:902:ef0f:b0:2c0:c625:401a with SMTP id
 d9443c01a7336-2c1e834f82fmr89665205ad.30.1780741197487; 
 Sat, 06 Jun 2026 03:19:57 -0700 (PDT)
X-Received: by 2002:a17:902:ef0f:b0:2c0:c625:401a with SMTP id
 d9443c01a7336-2c1e834f82fmr89664445ad.30.1780741196983; 
 Sat, 06 Jun 2026 03:19:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:19:56 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:35 +0530
Subject: [PATCH v2 04/14] spl: ufs: add SPL_UFS_FS Kconfig and filesystem
 boot stub
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-4-72fed24ef01b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=1911;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=HLfo2Bjrit6nO+W5L6q2+2O58yb8bSW8NyRPXbqnBu0=;
 b=r9oQ6rvNUNvWPoIJgBWPoZRxP5JUlV5MDcs156hAVMnrw2i8QyDjeJQ86TySudpC5Rg7l728g
 B5nKRH+GLrjBJye4LgO9LzydnSwSyXrodoBDj7sESMFjxCvCtGS/7el
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfXwApCmTHsHuC/
 gCaKn3E0csIySertHUnpALW0nS5RXW06HjgjsrCTeoqb6/x0SJdjaofO4/bW41G7oj2rYMdzCCf
 DJhGrUaqyWuEhQJS/Pe4AnTGMmbFV6g+uOnPBjXLZzs9q1m8QY9vfmyQWSZoG5mNE2J+h4fL16G
 jWz8/9NvOgGlEdc9memfeTB+RpiVg7ytmCBGWhi99MJYdw/rHlPqANmfaEbqoiRhilMZfJ5HWRU
 a+9B8N0jezCK1p8bXreQccncRZ+sHR/cX9GxXOZSkyKnzWWZHrjYVDy0kJUsXtTxSSXflZdTTJH
 ydNzPMPnF7qzbt+Xg9Hsb+mQO+8DtPW5oPBBRFWWzNUnfXFGxxa1A76EVtg8CkNeFnVdysxl2Kh
 LqAtz8kQO8YrNXluRqVltsw4t+VSxWOp0J9bCirg40Li/V/lePGP3m5Wq113Mn/BTy1I/s5LEy3
 hb5e0JQ9huuZbvtc7kg==
X-Proofpoint-ORIG-GUID: VASGHYQSBW42ZKXUEB0FE-8fyRAt-RPm
X-Proofpoint-GUID: VASGHYQSBW42ZKXUEB0FE-8fyRAt-RPm
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a23f44e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JO8pBW9224pcBZ5wZvUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
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

Add a new SPL_UFS_FS Kconfig option to enable filesystem-based boot
from UFS (FAT or EXT4). When selected, a UFS_MODE_FS case is added
to the boot-mode switch in spl_ufs_load() raw mode on failure.

The filesystem path is currently a stub that
returns -ENOSYS, serving as a placeholder for future implementation.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Added the filesystem support in SPL UFS as a seperate patch
---
---
 common/spl/Kconfig   | 10 ++++++++++
 common/spl/spl_ufs.c |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 82b757d1efa..8609f08413b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1682,6 +1682,16 @@ config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
 	  with partition support. This is used if partition name is not
 	  specified or not found.
 
+config SPL_UFS_FS
+	bool "Enable UFS filesystem boot mode"
+	depends on SPL_UFS
+	help
+	  Enable filesystem-based boot from UFS. This allows loading
+	  U-Boot from FAT or EXT4 filesystems on UFS partitions.
+	  This is tried as a fallback if raw mode loading fails.
+
+	  Note: Filesystem support is not yet fully implemented.
+
 config SPL_WATCHDOG
 	bool "Support watchdog drivers"
 	imply SPL_WDT if !HW_WATCHDOG
diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index 0590b796267..8a60948a304 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -142,6 +142,15 @@ int spl_ufs_load(struct spl_image_info *spl_image,
 			return 0;
 #endif
 		break;
+#ifdef CONFIG_SPL_UFS_FS
+	case UFS_MODE_FS:
+		debug("spl: ufs: boot mode: fs\n");
+
+		/* TODO: Implement filesystem support */
+		printf("spl: ufs: filesystem boot not implemented\n");
+		ret = -ENOSYS;
+		break;
+#endif
 	default:
 		puts("spl: ufs: wrong boot mode\n");
 	}

-- 
2.34.1

