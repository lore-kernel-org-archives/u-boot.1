Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8D0CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C80DE84A26;
	Tue, 23 Jun 2026 08:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFS7CCDG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bNujX1HI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C5A849BD; Tue, 23 Jun 2026 08:49:25 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A58800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6clZY3564072
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cex5r/oc/6U
 8wBG7dxzZ64lTI6uV5bfmCjrFjT/JQtM=; b=IFS7CCDG7l0j4sGrVdRPXQ5ikX2
 E9ZloUnux6UaSuclh3656aQsHayrkIFnEss7xab1bABC7cIxVXErBaMXs82LbXV+
 ZXV2zKEmv5V9OiAJsmDgS5geNRRAElA1YBzpqNJGdwBDNs1KGLBrYFjrXJKg8xb0
 +u1aVP99TzqFuAvirCDBqld6mYrcwhmGkdk04futc/E5Vk6qShOKyv2OCIS3cDE4
 5rQjoSYbvGhmrF2nd0fD7L9N466TNAKm0apkI+Zg4LCJiXXOTBhPzgKL4E/r+chK
 VOl95GPvtEMUXfl/JHeskGt0AJpkIm7CTXtXzsK3+o26Lu49ZmFLFHnTElQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n43d4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:49:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37d4eede8ccso2247559a91.0
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197360; x=1782802160; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cex5r/oc/6U8wBG7dxzZ64lTI6uV5bfmCjrFjT/JQtM=;
 b=bNujX1HINkTLt6GhpDy7eqd8VSQdUBM9TgQBda5POrGkQQ1BdsmBuQcSjMVWgh/QLC
 FuIGKkYJkOglAW6slcTucRHus3AgY+fKvOuHZCjGQl6VmrU3cSQyXrOYIetoIamNggMJ
 TPPodscP2cvIcCthpBwYLzFfaRYiJBpCJa5NBFQIRAddAQVrdFojsWJONKKc7XSqLg92
 UHAAcrVGrFdgcbNfNgw6ZQJ9lAne0tVTR4/wvjhgFJG+hfx5S2JvvzKvnYK7nDRDTMUQ
 qbpveNy6Hm4CBFu6MANkuzs171UKdEYmxlGuTbYANyblpDK+1mGVLkpjqUwYpd7GIuO2
 u48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197361; x=1782802161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cex5r/oc/6U8wBG7dxzZ64lTI6uV5bfmCjrFjT/JQtM=;
 b=nGeeH6JL6b6q+YrJ+Ay61sv+6wBx46pV/erAMCwyV/RcnMPaCZQEq0WPg25Y1mtLpA
 nkAdf3gFAQpC5f5+FEFdVbiVm60Afe+zF3zExApQHuRYUS3qHjS26dvG5s6Zkx8s9nlf
 ZVjTIwvBo13OuiDHBwVs9NCKgsAOV3KqXSi5s08Qj9OWVA6Y8P92aX68oSGPoQLNmZK/
 ENCBWjDmrvGSNFGyZtzRBP89Ex0rINek2hfo/D+xCZdJa4ZGBdg0bu7n+Rbs/EA5xPf+
 /YvTcA4GRk0yucxNZ8C52NG36fo7Tx4z7vozeRV1mxSLxCenod+ET4Bpxc/hk0YdVRaN
 izxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RogcW1yclxrJ3oeA2Y/63vn9jVqNw/sNfV26AFwn64myHuJVci4nrTTxhSORedlHc2Qzr6r8kA=@lists.denx.de
X-Gm-Message-State: AOJu0YzUrR/Ibv/7NxQJr2btWfveNMJI9GDaUXAxRRmloEH2Il3vSuSw
 g2r/7XmjcmfI5sVgMyzz0yfHPHTlE0f6nTxoqami76rTlhCwx3snlqqOGLa+JeQKtQW2ycD/Btd
 h8e+gMGBWmNkL6Vg3o7XuzTSn1T9HpYlsxZwsUSGdyq5nkSTAcUsCb5EW
X-Gm-Gg: AfdE7cm6yr+TBPt9g8MspCYtcd4wWEBP7hT+TCARU/9iPVxTWOjEUaS+yIOuydxX7lz
 DjcSjZp+yhWI7rwmRUzBO6oo5y2PSUaoizR8fCuiYiZLItAl+ZjlJPUPADLsoLZnS+/RIly4sIn
 +3lPKCrX+GtuX4lKv+HvD4rtrPjge+tS/ewQYUyE62AMhNB9dPZ8o18b5W5DyE5Io+tZu3Uhnif
 oPoSMZtWmUsXmd9yExdM4/gQnDGY1v7Ifyyi222Ru2Sa+aGWbCSrCvtRuRaj4Tg8ihNBZElqN+T
 3P2TuX7seoulG7bG6/yhrtzK3fJVfXHugf6RQGfBNZ30JiGJxQoOWbXmMTrjev9NnV8KyqQK4WL
 uxu2ZfdCHd/aIeOTNIA3vuJflmt8foQ/d7l5egVFkihSYNR7XYwc0KvgM211WPv+jO7cCJ9eTrE
 tkJA924F8HYIJ5Kh6Gsvz3dwnU1W5W14X4jpD2kgO5
X-Received: by 2002:a17:90b:5803:b0:36b:e8b9:46a4 with SMTP id
 98e67ed59e1d1-37dd1747aa8mr1416588a91.14.1782197360556; 
 Mon, 22 Jun 2026 23:49:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5803:b0:36b:e8b9:46a4 with SMTP id
 98e67ed59e1d1-37dd1747aa8mr1416538a91.14.1782197360056; 
 Mon, 22 Jun 2026 23:49:20 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:49:19 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 05/11] mach-snapdragon: Add PBL shared data defines
Date: Tue, 23 Jun 2026 12:17:58 +0530
Message-Id: <20260623064804.3988799-6-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX9LmseYM8eCNV
 PQuxuNupus6KIaR404H8GKyE20Q2y/Ow6Yi2kuxyRGOV36Pcfd6aUAFRs/SBD+Nhlg0a+D8aiEs
 LCDImcwk970DS8Z5kkuBnr2Vjf7A+IU=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a3a2c71 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=sDdLNcq-EIZsHFQnZvsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: a8ReqJcmKs1C8V1bKbDjcegD7wUUIg9w
X-Proofpoint-GUID: a8ReqJcmKs1C8V1bKbDjcegD7wUUIg9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX34d5tSBGh/Wl
 IQxxCFWLrL9mTZ5GMOMxY/A322t29NTVNqZpK7Bv1rkSWiTHupj+V6Tupw4J0KDRh/P7pMU9rZX
 pNjp4U6yI76Wu1HP4Cvxmsg2NPDLFGAwSFPmku1rjl5+cr8v0GD+f5z1r0eyx0hGvdoMJZMtMud
 zeuV8GoQ0/12FkcRELa6ec1QoJ5vV7bwHvxHcqYBygob3TZrxcUFdvoLsaXa9INxnzdFy8O3vco
 bVqu7PjZu+WQabr/aOIW6h6xHHJoV+OCM1U0c3rXBiRJnM70wrfvjnorjsNtv0tX+ORCRwkYgE9
 eDufPc9b6iov0skUAPvBWHa0Osq+Yt44cezL2xlgMBo2yp+CGI0WWJrkEqF/tjq/vvp0WEOSqpq
 cC/zPo5874xa8Eo7o0AxiYRK1MVhyyx3+/n68XIbyd9+pJf30sS2reGDliKhnf5tIzqPsuIt0dJ
 fqCW/bGWytJ0jFasPWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230053
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

Add structure and enum definitions to be able to parse the information
that is passed from PBL. This will be used to identify the boot medium.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v5: Move PBL shared data related defines from qcom-priv.h to pbl.h
    so that it can be shared in arch/arm/mach-snapdragon and board/qualcomm
    directories
---
 arch/arm/mach-snapdragon/include/mach/pbl.h | 58 +++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/include/mach/pbl.h

diff --git a/arch/arm/mach-snapdragon/include/mach/pbl.h b/arch/arm/mach-snapdragon/include/mach/pbl.h
new file mode 100644
index 00000000000..94f845d070b
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/pbl.h
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __PBL_H__
+#define __PBL_H__
+
+enum pbl_shared_data_param_id {
+	PSD_ID_PBL_FW_VERSION			= 0x0,	/* PBL firmware version */
+	PSD_ID_PBL_PATCH_VERSION		= 0x1,	/* Patch version */
+	PSD_ID_RMB_MBOX_BASE_ADDR		= 0x2,	/* Not used */
+	PSD_ID_CPU_BOOT_SPEED_HZ		= 0x3,	/* CPU boot speed (Hz) */
+	PSD_ID_BOOT_MEDIA_TYPE			= 0x4,	/* Boot media type */
+	PSD_ID_IS_EDL_MODE			= 0x5,	/* Emergency Download mode */
+	PSD_ID_DEV_PROG_ELF_ENTRY_ADDR		= 0x6,	/* Not used */
+	PSD_ID_XBL_CONFIG_ELF_ENTRY_ADDR	= 0x7,	/* Not used */
+	PSD_ID_XBL_SC_EXT_ELF_ENTRY_ADDR	= 0x8,	/* Not used */
+	PSD_ID_PBL_TIMESTAMPS_BUFFER_ADDR	= 0x9,	/* PBL logs address */
+	PSD_ID_PBL_TIMESTAMPS_BUFFER_SIZE	= 0xa,	/* PBL log size */
+	PSD_ID_PBL_DEBUG_SHARED_INFO_ADDR	= 0xb,	/* Debug info address */
+	PSD_ID_PBL_DEBUG_SHARED_INFO_SIZE	= 0xc,	/* Debug info size */
+	PSD_ID_TME_CPU_PBL_ROM_BYPASS_FUSE	= 0xd,	/* Secure boot status */
+	PSD_ID_XBL_SC_DEBUG_LOG_ADDR		= 0xe,	/* XBL SC debug log address */
+	PSD_ID_XBL_SC_DEBUG_LOG_SIZE		= 0xf,	/* XBL SC debug log size */
+	PSD_ID_CURRENT_IMAGE_SET		= 0x10,	/* Booted image set */
+	PSD_ID_MEDIA_DATA_INFO_ADDR		= 0x11,	/* Media info pointer */
+	PSD_ID_MEDIA_DATA_INFO_SIZE		= 0x12,	/* Media info size */
+	PBL_SHARED_DATA_PARAM_MAX,
+	PBL_SHARED_DATA_PARAM_SIZE	= 0xffffffffu, /* to force 32 bits */
+};
+
+enum pbl_boot_flash_type {
+	PSD_NO_FLASH		= 0,
+	PSD_NOR_FLASH		= 1,
+	PSD_NAND_FLASH		= 2,
+	PSD_ONENAND_FLASH	= 3,
+	PSD_SDC_FLASH		= 4,
+	PSD_MMC_FLASH		= 5,
+	PSD_SPI_FLASH		= 6,
+	PSD_PCIE_FLASH		= 7,
+	PSD_UFS_FLASH		= 8,
+	PSD_RSVD_1_FLASH	= 9,
+	PSD_USB_FLASH		= 10,
+	PSD_SPI_NAND_FLASH	= 11,
+	PSD_SPI_FLASH_GPT	= 12,
+};
+
+struct pbl_shared_data_entry {
+	u32 param_id;
+	ulong value;
+	bool valid;
+};
+
+struct pbl_shared_data {
+	u32 version;
+	u32 num_of_entries;
+	struct pbl_shared_data_entry entry[PBL_SHARED_DATA_PARAM_MAX];
+};
+
+#endif /* __PBL_H__ */
-- 
2.34.1

