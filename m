Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8ADC4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90BD180DE1;
	Wed, 22 Jul 2026 07:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOnuJuOzjJ9E; Wed, 22 Jul 2026 07:42:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C308E80D9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706130;
	bh=H9AvdAitqP1CKY6ZesL43h0uOF2IhGLFl4RQEB7xv2M=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ylH36mxsJcZ6+iL5buglfhheTtYzoAzbHvGk5ptBGxVY9m5+DVw5MAhx88tobQ/vc
	 nWUJRjAkz0I7LDAPTVfnXUnW2hikq8DaAXJ/dKmav8QxFK8hMAqWEcK6GTsckdzdTB
	 eFeCtLRPSnfSEPk6ojz7WvAnNg26zbVFb322I8348mhTykvpYLaIajafL8FcMp3Shd
	 RVmj2JFkX1GbSGgAxKw7KBZYWJUIoMvqRxe2/JTBbCW4aKrQge1mk+hH2Ksb1MG8Tf
	 h+cj+JjZhyp2RyQPFv8mLH5y7nWfL/Ir2yTXGuavAqFO+11x7BpwouN1EHLGS8UAwL
	 Z62Ga1eycKc4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C308E80D9E;
	Wed, 22 Jul 2026 07:42:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 796B1109F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B94560746
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5B9GK7D9Sh1 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:42:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 68A8C60740
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68A8C60740
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68A8C60740
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M545Ye3663354
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:07 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2un5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso7856864a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706127; x=1785310927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H9AvdAitqP1CKY6ZesL43h0uOF2IhGLFl4RQEB7xv2M=;
 b=VuqgnFSFypmq5ryvffW7WtfmnILh6nCBpRBCFQ3yBPStBKyvBUOFoTj568RdtC5pEc
 jv7qtSRT9+sPXr0U6Y5vesA9Jcn6dMu1Vf2BqQfuywLiK4c+dn7bVqGE6ibt9xNl/Svr
 VwNbYqCIFIOjiPcUeeofZ/6Li/BzMGUnIrfiwOlO5OHvqAd9yZ+dmKXy2PBE1TJ5CpcS
 W+di3tDHCr3VYlHC1sWBruzavUR4cdh/SIgeR/sz4uroDmmguif+3fbOJaOBW0ixdCAT
 ETEadXGHB4Id/rahci4vhMOpQX6Ng7SS+RTQXhbNjcithQaaT7WMCCsuABaDUlyM6EUZ
 bd+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrj3lOi6P4KSDmcM2GQtQWQG4cjc85bjD2/gzy4yEMcQbnguZksabKz0+2FWr56Z4mKvV90JS8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzx/6dA9FQ9CVVIiT/3jydx0WSH/DoYcZX8WFvHi+d3DM1/SVP+
 PuOJVqWaJNn5BorEeYTzopubE9lCr18GvBJRjuDDq9Y74luK1VdkDh2Kj0UZIMgf9/M4GiW3wqo
 7adYVsQIBbGKvEdxLx8uHvIkiJ3fD3iV6XqVC2PeSj5f1snIpq84xezvVD8CgVqAu2uejgn4=
X-Gm-Gg: AR+sD11BcqCthkBVV2LwQeT/86AwM5hHqX2ev2XTkgfOpR4zc4a1jRibX9PV4XH/29w
 T55uy32LZB0Y3aZrKknAdi95NaVjgeN4SO3DoViITzqGGNltWglMgBb0Hn2eCU7AgmdGzaZ9gJ1
 OCdbjueV+3OijzFX9DFgiPAwnW1N12hR6JOGfHIKKHgJxaAZwBtt8gYfG6gCYswGkY6UG7HdFb4
 1P0901vVjNYI+j64A1F5IInbK5W0mBi74xxSGOSTwPBRS51UWC4qsZSzXtL6DWqp0M/13Gp053S
 dXiKKhhermGXiIRXe29Ceu7CbxyP2pwbM14JEeTP2327LbiF8kWDWFo5ZUFtVVbQmPDiBPzmozR
 5gnwegYTmsHu4BCz/bxpdBPjjt5c6hpbLqh3iNR0MlVzSoAqhEHE2b8B3LmuLrRr6riR6KlDPAZ
 gUjo8od2fq75SQDAgNAKiVUeSrNSJTZQ==
X-Received: by 2002:a05:6a20:7487:b0:3c3:6af4:a658 with SMTP id
 adf61e73a8af0-3c3ad9dcf61mr23293516637.50.1784706126998; 
 Wed, 22 Jul 2026 00:42:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:7487:b0:3c3:6af4:a658 with SMTP id
 adf61e73a8af0-3c3ad9dcf61mr23293490637.50.1784706126539; 
 Wed, 22 Jul 2026 00:42:06 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:42:06 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:15 +0530
Subject: [PATCH v8 04/15] mach-snapdragon: spl: Update boot device
 information in SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-4-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: fKtSB0HJHf2cYJTWpF6NLqrDDCwl8zYW
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a60744f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=9GHNYfyOn5LUBYWynLkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: fKtSB0HJHf2cYJTWpF6NLqrDDCwl8zYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX+L9HtKQwczqI
 XnoEe6TeQ+elu0tUFDWm9CRyRP47JK2yX3lyDx+2ecXMtUccUmOUPWYKwddZzsOfY3Py7Z4rMHw
 F7lIUXZ43dtHZiDakNyxg4VLI3QeL7f3UcnYzZhxlbs9TR0sQvuUBSyrM/vCmGZEAXVFNFTJrG9
 +iQ3kvpYiu0QDZV8nnljJ7zJMDexO0NXoa4kMIlVKc0UQkvswU2w7rqjFfvrV5/NDhw/ffOPdiz
 Ay9+ed2jNMJasSWoGxubTOnbfcd99MHlb41eXqW4NwhLPfzESgGh3qriYtLsNyTSve0GlBSg9FA
 nUAVTAK0Ho0q9w+k6+qMlop8mhPQgnYIICwssWtpVuJ0vZbyY67yX9lZnppTZMIB6R0tiPjNRZo
 7v3U5MM9jMSrb5x2gQmU/9AjsdSMwjzBRsqvymLV7RmddbLRdml2cGYTZuEaNR3P6LAYZ6VTq5n
 mSx+PyY56+nzIz6weCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXxJvvdkldE0ij
 kJAFjSOaVyfuP52tLAIJPd3fgjWD+HxBzpjjar+rCABITRSCKEHGm0MU+w4NmpO3/ltVpFnHNSP
 Zy8aGmRmx8prDohOoVVabuRRU38TNW0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H9AvdAitqP1CKY6ZesL43h0uOF2IhGLFl4RQEB7xv2M=; b=H2B+YCax+esuxa3H
 ZT40IAq+XJ7xwVBPZ39CRqpO2hw3M5k3G64DjSidVCD5PcYS60kxMu7Ehq++x1lN
 ouCGDA9f4nbOEcdDY6Vcgy0FWCvpVbAZ4f6qECDgkpeJk7RGGlPtmLejWaeAi95y
 pbiln9mLNj/uasteMSSJYbfDfxUlw/+cVHX4ryssDxgeWkPXUui68j8I1epBEIT9
 BmbqE0YFvCSmmcM2+r4MJr2i8a3aXl5B8/C2K3j3b8s0q6pIzErWYxEppKHJxeW3
 ekyqixpZS+HzlWlXybCk8tMLPQ66yEYZJsZmBNceRO72g2LWSF4F2qSw9kzTq0Ez
 R60vUg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706127; x=1785310927;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9AvdAitqP1CKY6ZesL43h0uOF2IhGLFl4RQEB7xv2M=;
 b=MEkQ8TSrMHNHqrZZT4utOAejTV/vVbe6FK+R/9SS/IM9HiWqgRVc7XY7NKaXnjEG/1
 vjbGkAR0l5EFrkqfFZ3FabCrK0vQc0ZlIk/KO+/H8xoFZ4Xd+N7gCjctZBXZ8pYA/vSn
 fsJuBmrIpipy60Uu2lenESXrtZXA+anhw2AVDT+rCkA24Z7yfTh/UsMc343L4jEArOb7
 PgiUkU4vUWutbl+BoGpGLWi7Aak1XE3ndu6a8L2sxKOtFV9cyWSvcG68yOomPcqrE59w
 G4uMJ8XMQFVdpoHdgxH3DEQrFj8iVNr7OhbYHuU10DbbGsrmjmJiWa2v7LgP0wBjoER+
 sDzA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=H2B+YCax; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MEkQ8TSr
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Update the SMEM with the boot device information got from the boot rom.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 6ae59481ba9..69a32e5d8cf 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -85,3 +85,49 @@ u32 spl_boot_device(void)
 	pr_err("No boot device configured\n");
 	return BOOT_DEVICE_NONE;
 }
+
+#if IS_ENABLED(CONFIG_SPL_SMEM)
+/**
+ * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
+ * @ctx:	Pointer to the global SPL context.
+ *
+ * This function initializes and populates various SMEM items with boot-related
+ * information, such as flash type, try-mode status, and ATF enable status.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_populate_smem(void *ctx)
+{
+	int ret;
+	size_t size;
+	struct udevice *smem;
+	u32 *fltype;
+
+	ret = uclass_get_device(UCLASS_SMEM, 0, &smem);
+	if (ret) {
+		pr_err("Failed to find SMEM node (%d)\n", ret);
+		return ret;
+	}
+
+	size = sizeof(u32);
+	ret = smem_alloc(smem, -1, SMEM_BOOT_FLASH_TYPE, size);
+	if (ret) {
+		pr_err("Failed to alloc item: SMEM_BOOT_FLASH_TYPE (%d)\n", ret);
+		return ret;
+	}
+
+	fltype = (u32 *)smem_get(smem, -1, SMEM_BOOT_FLASH_TYPE, &size);
+	if (!fltype) {
+		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
+		return -ENOENT;
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_MMC)) {
+		*fltype = SMEM_BOOT_MMC_FLASH;
+		return 0;
+	}
+
+	pr_err("Boot medium not specified\n");
+
+	return -ENOENT;
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */

-- 
2.34.1

