Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422F2CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDCED84A17;
	Wed, 17 Jun 2026 14:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQHOq84T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dTOTQ7uS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A792841F2; Wed, 17 Jun 2026 12:19:54 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F042838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UflG1654330
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cex5r/oc/6U
 8wBG7dxzZ64lTI6uV5bfmCjrFjT/JQtM=; b=BQHOq84TWj8r0r2cJj+Zgq26LOu
 TOtYeVE+LYZK9O5T3UFHnQ02jpiFXbRPpfRZ1dpwMgOqV9eOoGY63dNgZxunprMO
 HCM5tgZRVYP1zkFB6HAIhVSyoMcKu6nrQRTgll9GNhdbQhFCTZ6OTa2RzLOcYrnQ
 JMlm6MYndYC32XAA39LKDOItSFMAvsz0z1n7I/IUeGvs/cMVdiSPLimLq0UJCCQm
 LhJ2nLDIRSHt6WLPg+t6o5vAQ/eRi0MSCtCxLBU1hv3DwHJEOmwyefFChu6T6fWR
 JrvLOE1jaJLnGxcvOth8IQRGrHFtSA83j8DanE1M5d1qYh4xQqJ3M9m1nLg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer2jr3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8453031c567so108343b3a.1
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691590; x=1782296390; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cex5r/oc/6U8wBG7dxzZ64lTI6uV5bfmCjrFjT/JQtM=;
 b=dTOTQ7uSancN9pmGr9zI6tnGVx9UOgVVohrs4JJBZ45vPwJNWREH+vMdjBQrnq4/b7
 1hxNKSQ76nAm1gNe+oj1I0KoJYBwS1GHdfMTlPEGQy5uKEEVecgF54IoCOtyhH45IYHx
 FLy8tIUAT8DwedgNCYiPp9Ww76uFVYo5twrDO/6uPfVDz8CSOBxoxwa+02OUL95/fNrq
 BW3O4Jc+tr/6qKFjX6xvYlLIAXxmfEyjk+RC5KYPAvhfBsHpDli8D4FpfUqJ418BTSHc
 xpOBw/YgwVhlWhuGodT8gmNoGkrjUmzIC80qY9LsAwhYNpCrJ86e6BlacFgrUIHlg6qY
 NT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691590; x=1782296390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cex5r/oc/6U8wBG7dxzZ64lTI6uV5bfmCjrFjT/JQtM=;
 b=VGfJykzPly5SZXwba5qsrqsZGkPGZLUDLCwYXjAbP/U36y9AM56tXTQTrK7t8i9vsh
 3Yx+0KpPrHBh/SYi6+NU4TBxIskBI71PMtPbzccAxZjm6nL36bIwOfPBV+Cy+Jj0L/Fu
 /a5MpefVLAkbpZBwyj6nrBoQ1nV8HjGYQbWTqodM4UkFfX4Dc/AY70KxDS3kYF7ecdHd
 uYJxdrPwfdUNRM8Howp9Lfk9GtO0NLOqY49nuTjdm2wwYPuObMeudXEVWiu72j/qmGGx
 6z+Y3p/LbCFXgpvwSuFoG/FG9Zftrw0lD0Gv/3TlSZxcwoOq9831N6JSOm6p44zsYGbA
 vxqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Q/FVVnskSLNaw7FFn24PR3izFIJGOZG46fFcy3DZ7I3mLsivgV83XqmldLVmVUwMzQs+QGuc=@lists.denx.de
X-Gm-Message-State: AOJu0YxtMVDDdp7E/ayCfUCKn8k1fdqqiSxS7CZ6F/Zj0j7WkB7biEZX
 TSmJjoQT/6mGrf6H8Do+MRAtekTTGtPu0ZNPnF0ZPOSfcumZKbJA0GcH4YefvVejBuxrAhi3dcR
 sLBWVO3drD/0TOr6splqHxO572U54i70TRRKZnvJyYWlAEkK9ldAqnIKW
X-Gm-Gg: Acq92OHRiBLfdK1hN04DHxMBWtfQo8NwmV4tVF5Ib9gN3tKT1tRIoPszUgkODTV35KQ
 6Dalmnpzz2tCCC3HfhKkJiC9GywfBop/8K/muwEq1TaTyaqnqUQ+OPrp4YVRsqKRxHg8yhG9J9O
 q3CyyT9Ziwpl6hTDd21p3U2dCLHXqicb7g+J/SHNR0xi6lPP8gMI72Q932VMkAnjpzomI92FN2i
 5lgPVVbDHsStXf/T0WcmlUCr2MGelydMjlvRspU3RAuhWQTGJI/oy8sQi4QrLNVnBdjnNuTrfbx
 fk1GPxIk4U9umY5WKlV2E7xRviRNt0o4Oxv13PDwt5ddgc5pOsueyKQKKeqZu2nuNI7HrpGcYWw
 88z9TSUCZQ3l09Na71+6V7zaRLyiuIzIIH98mbzag6SSZijpwBB9+YfIUlOzppooXii5GEbrBBb
 BjeXIaCDPeF89s5AXZNwk4qF/mHRX6s0DER3Xxj7VH
X-Received: by 2002:a05:6a00:3991:b0:842:688f:3089 with SMTP id
 d2e1a72fcca58-8452459a035mr2995728b3a.30.1781691589600; 
 Wed, 17 Jun 2026 03:19:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:3991:b0:842:688f:3089 with SMTP id
 d2e1a72fcca58-8452459a035mr2995665b3a.30.1781691589108; 
 Wed, 17 Jun 2026 03:19:49 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:19:48 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 07/13] mach-snapdragon: Add PBL shared data defines
Date: Wed, 17 Jun 2026 15:48:06 +0530
Message-Id: <20260617101812.299586-8-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rk5FXSm0nAYY30r9EqI9fpTFctc5k2Pl
X-Authority-Analysis: v=2.4 cv=Mr1iLWae c=1 sm=1 tr=0 ts=6a3274c6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=sDdLNcq-EIZsHFQnZvsA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: rk5FXSm0nAYY30r9EqI9fpTFctc5k2Pl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX/WvRNFPlUpva
 Ru43lX+tXp7HB+i/Nvd9G2tmjagn0uZcsCZu09WZk7DRjL6DS6w/n7ngufHUYwhTc+/DdLmo2/9
 1E/PbImBJEZ0EeNfzt4Yg4mcBOcq+1c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfXzMK2IO25nrH/
 X2BXYJdPo+t79PJRevWO4OTJ/Tl11jk1yRW1+Jtaec5e3sKf5kKCAuKSsIDuGEd8LLPv4pAvrid
 1zewPlfUAzhjt0gacvuSL8nAooDb6mIN4o/C7OIgROVs1TWluVlkJFyP09Q8+jy2HV4//YgPL1K
 gImYkmyvzITRl/z+yvFd4oHeLT6g0kWCD8h+y1Yun9jRUPRHoG3jTPTERXdSalxyQKQGwsyRV1x
 nJcX+sfSCWGXBKwTWRmfRTQPYvnZz7OOf8jnaOiUBzHq/IcCgwGWBj8+PtwZvM3FDEHKXmd3QaS
 tLDOj29Afx2LenyGkaCRJo+c49Bx1wOVMAk2S9aSNglWpEcHnSr2GopQ+U2A81zPzhggumBi+Pz
 9B9jLZM0N8C48U1xJ8VnECkruN0epblRJwfs0tW2/mTP5KaHEBPBASkVT6o40gcya4BlTWLiiT0
 1/QdbBVMKMAwWf1+S5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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

