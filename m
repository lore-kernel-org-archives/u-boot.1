Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A29C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 932C484B2C;
	Tue, 30 Jun 2026 14:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MK8rqjgg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+RTgzkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF0AD849FB; Tue, 30 Jun 2026 10:09:59 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C8384857
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CeDe1090091
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FcPWUo3XbDy5rIVMwM1uUb2uc0d5WjNDHCC5WsS3aX8=; b=MK8rqjggP9LoMGzD
 Phi31hgxomUIsx9xLMMJuhOL1wdp5k4CJStgv/1EWPBYmTw4QUilJP7yWCym1qDU
 j+gHr07p/DGMU4Qx8NrcG0DRx9n++uSP6R83QzAMs8VQYQqeAiePX9+JNueM7i8L
 uYSbmdX9SxWPat1JksWJRL0/nswkMwS5U8LIJ0kKeIhpylYcj1klu0XFgX4mIiQ9
 SCuU+lmWbxCoVt5VmoSzU7Q6rzOu8oDafinEjqKPyz5nY0s9WXv9ZD3uQ1liu5oZ
 IfHeE9J5jJqkN6/SDXEInAhwF5rPCdEWWJqd1QVT30MFSL9miLNmzqqhgd0l+U8b
 dtDLvQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfhfgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:09:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30b877ee493so622831eec.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782806994; x=1783411794; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FcPWUo3XbDy5rIVMwM1uUb2uc0d5WjNDHCC5WsS3aX8=;
 b=F+RTgzkJ41bQoE0B4Ncy1GlEcLo3ACdgWrAzaCZi70vqDIz9NCzToq1M8qKeuLx8CL
 y8xUIbWmB6qnoOR1zdcF6L5VfSSsqxx11RaVDe4oaiEhWwMBaWnixhD1Agdhv2iyFoh6
 lbEyJatfvK3Oo5cCZf/vs65sbtPZpfRvOCnVrVtzvamyXZ7bwPdO0QBCLJkDN6wxzDQR
 fd4K8/ajN/DCJ/Jz2gvgLlGmSIVN5zAFtoHCN4CPypUnVj3rO3TXzaR38VAm8q9Vmkga
 gJBP9wp2w5SJQfnlqGHn9E9vdiKXvu49tqhRhwirpQW4ZjGfR7e1P7e2jFbgAP+Wv1mJ
 FF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806994; x=1783411794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FcPWUo3XbDy5rIVMwM1uUb2uc0d5WjNDHCC5WsS3aX8=;
 b=mShby7XEDvxLh8rwS+cqUC/YTaT87VNBJkSyrA5ZcQ2acdk8KPef6EDvqSGdI0CR6c
 Ir6rqNJ40McKhnyGoi8h9Ky8zNFFgCw0OjHuv24xC0zNYcJJ071IfJUVmMkZMJKFXq0z
 o16KzpsDTjdXuymf5DdC5W+dESlGbj7xFpDd5zjznSMNStr/3DlDvUfIm/dR/vk8xRnn
 hpa2rMR7f+wnoJbek2wasYgn3aeZTbBMOyZnbwKJC+9aW4KNypP0yHdOkpbOANYPOZ69
 5d8em/9UcSTpUtz64glO4t/80sdSmXmp/q6WT9y7jWwkC0fJXTOHLoF70C7z7kb9uCtW
 hTDw==
X-Gm-Message-State: AOJu0Yzqu01jFgdfNIabhsgy7SigzeqDkoYb0JqXqTaF2MRA1qJ36OIM
 5majroIvTwirTcpp+LW0rLRvVBB0DGWKKh8+Ws02I2f20Jy9rG0Zl9bcOEgE8OlpfmkubPP+0U0
 RcioIMq/T93y65F7Ki28/lJmbCmE/oUVZ6t1w3/XTbAlG4xhf7lT8aiNl
X-Gm-Gg: AfdE7ck9yBc+c4i/R0DVL0cWracEzCOJD7cdD9AYPRTmGvcwn+RrAnNEvZrAtsQCOCi
 zcwsgqCbL9OZrBWJsQnK6ACK/ykbWYXndAEjhac4NhM3hv5O21+tINbJ3GDOyvZJU7t0ZtC0+/y
 y+536GAEwtHernSEqsK00NYI/9GpLSYFMPrG0I+a9cONn2iESVO4Ma0bjIxe/WB08a5PHmdl/PI
 oW0zC1ZLY9fhx2bBgCY949FOktzAli5Ai3Rj0QrYo1XQc191FTvXP03vvq1d25GQyDJsgw4xZ5d
 2p9P195L0uvIbyHwHUa9cWT+YU9IQCoTHvhRhPeBnxta0mXrj1l3UW3MGoFJbNOk5n+nK3mm4cy
 PN4PeiZJ8ZYRHZjZnxSpGVP0oRJGtFuSy927VQ2YfIGtn+H/y+986Usfb479XC3RDP5eqfzRz5Z
 MiJH9k59gAbaw/6CJAuUzqpYEkKdPNvdjuXVzEdVDw
X-Received: by 2002:a05:7300:7fa8:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-30eea03c66fmr709320eec.12.1782806994343; 
 Tue, 30 Jun 2026 01:09:54 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa8:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-30eea03c66fmr709265eec.12.1782806993782; 
 Tue, 30 Jun 2026 01:09:53 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:09:53 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:38:27 +0530
Subject: [PATCH v7 05/11] mach-snapdragon: Add PBL shared data defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-edl-v7-5-1dcb0d2a347c@oss.qualcomm.com>
References: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
In-Reply-To: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: MC9gmg5V8YXgaljgV1nV6K1itjmis514
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX87DKSy2lTmiD
 0EoE1icvkvefe21C7wnlIJewmFJUNZJtCJzz2+hbw1AhUHWDouyQQqSZ10yfyTecudF6c6CQ9hY
 VbZMRUMmqfpLKC5Xio/cbz0i2UFc6aZZfzhNVpoPB0pXSckL8QDY2vC+MAP2qZStHCUvs13OHeH
 gWU3cHflGfPqscIkFLlMSSmlNww0F9mCGVMk+dM2ar8JMcb7bW3Y/fOfRAjdDG4EQvQOeFPvudm
 w/0MP5RNfbvuwuUZRtPqASRMC5+arsVa2L0vDgaf3PhKVyw7P8Bs9IDrvuzR3+Su8cppYRDptSV
 lEXRTG5Ik9p1LfuWvsamIzQs5pCaVGQLtjDnTnmqncqaNlmiEmV+8OF18/+zMXUsyHavT4m66U7
 vreOwkvtwWSgtYHxrM9yUq4K/WUkz7u2TCHwxMNmZ8IfaLA6XSBSI5nxElDnSigsk2+KHP7eVtp
 WG3bV98ZNQvVuP8r77Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX/inYGC1aYfWL
 1SIKaQMnrGnqvbl9i/Vjz6XXuRHg4cT51lEW4eipFk3hWzHJeL3zYfB2j1g80jDq7pfBVrWfQil
 0d6pNq8MA2ebK+cc1M+fBPCDWfuJHbo=
X-Proofpoint-GUID: MC9gmg5V8YXgaljgV1nV6K1itjmis514
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a4379d3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=sDdLNcq-EIZsHFQnZvsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/include/mach/pbl.h | 58 +++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

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

