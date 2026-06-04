Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E1ECD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C505184972;
	Thu,  4 Jun 2026 14:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFK7FTUY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cfrEoria";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B6C98486D; Thu,  4 Jun 2026 11:33:12 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C3F84868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6543HkV83233912
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nXLSvZfCrNm
 ea1OlojjtSjXU//7ORe65GmmRbp0OCrc=; b=FFK7FTUYFiC6Z7u0wXspMsUd5jM
 hnMfwoMt93cD2l/nkYaaqIj2rdapDhy0cl2eKtHnuMcBnHe7Wnfgna3+Cim/vnAb
 3zFV1hF94ZAka/cm7elxZcPYn1qUXduVMDhXgILhYynCM50teoYLXiYMlAX561xh
 O10I5scerQeVsvbTDMyIT/81S9/8xgJj5AFMT3Fr/V55dYkfqEah8pSRRiuY0p6u
 IefgneJlVnvn8m18VRrEoWH2m3NkDJMk/glXsH1MKxATIRaB0zy7dUKMr/k2Ej1U
 nbK83FfRcokDLXJpMZa5MXG61mGT8jw9GAQ59SuxOuGOaj+OCZ4unbMrsMw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s311t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:33:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8584e3fc96so331384a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565588; x=1781170388; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nXLSvZfCrNmea1OlojjtSjXU//7ORe65GmmRbp0OCrc=;
 b=cfrEoria5LGpMcDvT+MkA2Q2MFN+LmDKPjc9N6YyN9aTSCuhRAZVvTpMimFA+Q0CCd
 MLSJFWG+/mtOB01Gf6xjIo696ZADDxoMKg716vpLiPIQ4f0PPEzveNP9R3eqSR0CgAID
 uBHzo1Cp/fXsNZ+/Z2hveA3iZVkveILKhzW5vBNY6kT7LvJDUBOFxKq1R0rwJYpHjvgE
 SeYyjDpib1OzYhEH/fcf0HnRdS1LjcM72Q9eBLltUBuI9l8xaGmrxkVJqCsAbJ+Qo8Df
 l+OhKDcBFAivtKLUKYw5kBaQCaiaD1yrMXISBtxK7z96faB6XvSwROfypuIBTRdK+K0p
 hMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565588; x=1781170388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nXLSvZfCrNmea1OlojjtSjXU//7ORe65GmmRbp0OCrc=;
 b=j5GDSl7mpx004QaMUCfDCjPGwwUvDiyNw7SMyH5YJx5FfjaUxUXu4zaSou2Vd+XW3R
 IekoALxeEoY4NLusn7DUY7XFpRJAddoXtMYQCcDsv9ic1Q5psYvRp7FCQb7yTCd5LKEZ
 QFyhGozNtbgr5S6qKyTzhEXH//nVk9hzV4KScl1NGpGb1eTyo+zcEmCHTE+EqLreA/Ur
 /wfipTWhDCLGDaY7cEYCZP7BuBJ2nHvsqi5CbYcyGb8UZZ//D6LQNStxuyFu6ldVEd5g
 OaXEYH+/VttFYeS1ENEVmd2wt3exnMZuxV+qkfL7AV9QaxIXtv6RzLmG+uqxNbag2a8n
 SIvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+BPTXahcKLMjVQ5+NhIt1pumDEnPJabbtCKxYO4Czku+DFXRD3qP4lxxP+O8pCqgo2aB/e7I=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1BfwjqDeUyked5tTDHQMXsyGiiqg8jLiizIETZtuOQg0fGWQ7
 y3QZxPZ6lVQ3uCrqUbiC+DqS+DOKyXcB96FX7yZm4EJ4Yyp25o6FijTKKaZ2cboXzlnLbcdtxFV
 TGd1B+TmrUrNcdyPkjMQbeklxOI98Tewm1sC36C6Fap6zLGRNv4m+LSLB
X-Gm-Gg: Acq92OGm+UjJoE+jxBk0F31NEUQRCIZKoOfrimYZS94awoidLWSRUlOZWMpOJq3Cz+p
 3pj1FzlvoJBUmIXfUY8PJpK6m6yQx4BIO6TIb3xDTo5RIz2tcwIMq3hnbq0N0MN9NPAKW9ZRhds
 ws11jU/pXmJWL5HgIEBkv0O22EJ5aHEbaMG5pm/Ugcxe+jIUYo5OaPj85dvNE0F/+K1BDtwpL8P
 P86V/jGF+ke1XhIxfx0x+Nsn5cPMYeC2Dh19OjjQH32WSDoigoGew/4J0WqyoOPdZtKO7GjhKg+
 Y3S0UlsA9UpByVKxyX4UbvF9e3UaYemaEn5cUwhmRUHlM59W2Y5h23BpK21QBdy2TfYDeWwLU/j
 uY0r7TepQioy6IL4mnCfeQ/GPabxZT1e5bVA8Z/haRVKWuHmyMnVdIKXP3PdChMMFBdylbHuw8B
 JK6+2bjXqqXj5kRUNL7XPLZYFeBbTHHedwuHlwW09SkNA3IECdx/yrJYB9SrrdAw==
X-Received: by 2002:a05:6a20:9f9b:b0:3b4:8818:fd20 with SMTP id
 adf61e73a8af0-3b49748ea37mr8185563637.8.1780565587832; 
 Thu, 04 Jun 2026 02:33:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f9b:b0:3b4:8818:fd20 with SMTP id
 adf61e73a8af0-3b49748ea37mr8185499637.8.1780565587423; 
 Thu, 04 Jun 2026 02:33:07 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:33:07 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 07/13] mach-snapdragon: Add PBL shared data defines
Date: Thu,  4 Jun 2026 15:01:26 +0530
Message-Id: <20260604093132.757583-8-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MolP6k0U0YSW24a_60gs8Z2pLG1EySih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfXwF7xlCgkkU7p
 djZaUDBkYGpXf8sozMaBTMoYpr/IRXfnAbx7Wk0wuKJidntLUigDVl9j2rFC0kcTqiC/pCk0cRm
 IWuc8GMvmBBM8M4aA+p3pn8HWaIqTtcAV+CKgXpysYx2hRpHAUOVQhU6yeAsX8RD7ejcl8+6oGa
 TIxaEWajILqdLavPTib1wbToFS+qbztl+t1tm1JokD2mjlow3eE78J1MT15OCScEPaCqQDpU1Ph
 EBik9tMmcHo4OVxAHySAMk1BmDM5VbBPaxGdUESeA+89nRF8z28LO2Ifrwt38P3FDtI8J+deJd/
 mnsirHMncs6LLvFsankZEHRBNrTujMyYqyoNNZXNKsYKwES+N6iH03aZUx6NNPr1iEYRWzSn6b0
 7AeN1ECcf5w+kTBUyKMG9Z3vJdVJWNLtUOSEUcYTrSRf9ZMRThoWZ2IsKFZB/30I5Tly33QmBGR
 sfqvK3ShovmBShEqX1w==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a214654 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=m5b7a-9wxwWZBeM123sA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: MolP6k0U0YSW24a_60gs8Z2pLG1EySih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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
that is passed from boot ROM. This will be used to identify the boot
medium.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/qcom-priv.h | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b8bf574e8bb..8ebdcadc2ca 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -23,4 +23,56 @@ void qcom_configure_capsule_updates(void);
 void qcom_configure_capsule_updates(void) {}
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
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
 #endif /* __QCOM_PRIV_H__ */
-- 
2.34.1

