Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68157C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 191FB40740;
	Wed, 22 Jul 2026 07:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qLNWCMFAn2KJ; Wed, 22 Jul 2026 07:41:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1595240761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706113;
	bh=9xP+aiqOpI1Imz3OccF5vZG9L9MvbqclK/UmjGFxUSI=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jVE1TQ4rEcGTsHAtiJJpoeXEJ+lkUdXqPIp2YWtMRbs5wVHgVIaQQ1haCB5cI71Xb
	 FgCSniuCZh2yA5dpy4v4H/0iGonz+ukNbWWyvv7FIKLJE0BtfbzdDCZh73X0bG4+Up
	 fF6wqq3BQFDOhctlbNRfg3Sq0zf4RZS3UYpn7FUhJT1XR0PbNro3NfMLhDw2vbX52r
	 6MogK8uWSiruQhJXSOUl9sOg/yhLjWz5xmr1MAPv9JPWw1Bxnzxw7izieHJszuCMxB
	 cepiyDxwb/mm9oPfttHHae//I45LrIZrkPqP5Tzqnou7F8imsE0tTO1JqdMuYJcmpd
	 AyvoSHuFqPXBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1595240761;
	Wed, 22 Jul 2026 07:41:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F3B2FDB4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8FEB80CA6
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XjyxoXCrOYPo for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:41:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6616C80DBD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6616C80DBD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6616C80DBD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M61qDc984400
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:49 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr838dby-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb835525b10so3294306a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706109; x=1785310909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9xP+aiqOpI1Imz3OccF5vZG9L9MvbqclK/UmjGFxUSI=;
 b=E8W2czBcQIfbnYkdwKRS/INqTdLNrx3i6nwuyjMzidmzKR/9BTcyYXYlVEbXk4KcoZ
 Dh5bVbF8dSqpg5328Cfz1OyrdwUmQWeVBnZMpcRwK3wP2PLeSmvL+8IFhIo398VkGxpd
 xBKIQgpbR/gGiGfu3ALL/Z/JKKemaqSQ/8QCtLNxW+ZmIrJC4SBZwfIVSjFE8SwQ/9wR
 fGSM3EBz+d8CoMEmVi2iL1e2d+ra00TfR+qR0RLEEHpML2IR3mmYhOQ3LX7fnUJOFi7J
 HX4VTXpcon/HnML8r2q28rIR8XfhfC6kayDMLeMOSqVbG5Gwn6lPrGWMumX/eZW4dco4
 OsXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXTa1BnXVIPNjE15h1y5DLmMDQfgdOVNeeThiKI0/PcWWmvL4eOWkHuB2tDMCWFgZF+GkNAQw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzrc8odWsHKg67+bkkuMxOdmfL8JPT70F71kcklcl33IWYe6ScS
 5QkEaAIfJPpMasGtMI8pJz5IwEFpLiy6zFN3WXlF0MqfGkOD7zuwSApfg8jFAUREzB7TgiWhpRu
 hye2zlCVmXBrUPeFsYgnDw/zWbSCFVN8LGbhsepZKJC3E1sivLqc7zeSc8R9Xe6URGctE1mk=
X-Gm-Gg: AR+sD12h8AZJmAx5hUCMpexY+8w4+2qcL9yYItwAU7eGFtKehoPN34g/aBz7dIj22YZ
 YZX/po8fgz/xHJw0vcYpnjSEFVoDa+o2G+7eLdqtQoTxgzQ/uPJg09MtzBv+HAoUpWcV4j7zexL
 YI7VJ7lXyaVdnRXCQ3gg4FYfbSTf3/O/35J3CvyAYZ0rOHXjMo3nOpvHoew90cV2SbrkbobjH9A
 6Y157xFMlWpTQFg3fbFkV2D5Njg+QlA3gjPNp9czPjwWDoh1G4fUys83Qsw2SLI+LTpi9SfjudZ
 hjX/D9HPGq1+GiZgqoxT6p6G0mcnbpNJVue69cr5ny6LpuxGUH9yaiyK6mAg1x4B9eypZD0p8cx
 Mp9XHa+I6m/JyJ061XXU0UJO5cmK94MJbunktcWwni5rKXgf2vJ/2TUar260Xnma3whmEo+3L/k
 yQt6SQLI/hqT2aj7NP9T2hS7VDiBHGWw==
X-Received: by 2002:a05:6a20:9f05:b0:3c3:8bab:80b with SMTP id
 adf61e73a8af0-3c3ad9ec8e5mr25934873637.61.1784706108627; 
 Wed, 22 Jul 2026 00:41:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f05:b0:3c3:8bab:80b with SMTP id
 adf61e73a8af0-3c3ad9ec8e5mr25934839637.61.1784706108221; 
 Wed, 22 Jul 2026 00:41:48 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:41:47 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:13 +0530
Subject: [PATCH v8 02/15] mach-snapdragon: Add PBL shared data defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-2-cbfa79e85a9d@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: E-ib0SImMDw-B1FmeYCqLDsfT1X-2A-L
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a60743d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=sDdLNcq-EIZsHFQnZvsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: E-ib0SImMDw-B1FmeYCqLDsfT1X-2A-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX+RqANxHkZ8tm
 QSC4euyVp9WFJ3IO6lX6qkc+DshykFqsY47JIevfmvj93zL1AfXr+amv9D+PikYi/D+kg3Oo/02
 sqcNkFPWE+DPhclE9EyEHoMb6dV2haZS8I00hjC1FHYbWxQj+so0F5U1gleh5rX2cbRnk3KyxGl
 5TJfMeAhlcKWNhBfTGfc0dd3+vlyS9XYiY1ftTesEZ7XTvMP+oglyUbHq/oBbX6j0X2bx2GKlrl
 PeazdjLeUayViWYJoGSWBWEtvkGxmC9AgjaW/l4Yq3SA0eMk/QiCuxIqdEzev6SFZnwe6rbbpa3
 l5oLzS/gV/yuH0zpppOZ0iHCbjgCNs0clyl4rc2ZyxYf5VtfEle9TlVb+0XLhc9r3CkLbkiPqqF
 MOW00cmZJXZWsDI0HyXY679xK+bj3XVqMbIV0MHOEX/WOr1imGSIW6No73OKHioCuC4lHwra/2o
 guDjEsT1H2o/T0a4TPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX3VuezwL+KAI9
 406O23sa54WqVUYmSBNa7QL73RRCA8bqSv0yxV7U2tmXEntffx82nxbcE+qAjngd0eL59j8sdv4
 NrwjJIOiSeg8bllCYFZXBICMZxIGdr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9xP+aiqOpI1Imz3OccF5vZG9L9MvbqclK/UmjGFxUSI=; b=Vtk0YSp2ANu6lRO7
 MgSnFudETTdbcPbcNKgRA/onZ9oz1AgjwEqgayL0upKRi2qPcCYY+6LZFeWJINJz
 GP/YodZY++lMYQ0jMoPzSdZNpM9jfbasUWU1P0UfbcWpZ/q48OxTHUcBjndxBvOK
 z+YDQqY4HvX6g92cq0lgQQQmaLAXmuwtN2yHvDZ+BkD9zkW1e37kJO+ap7Pt51Y1
 U5lg57Iul2Oa20nqH9Q/lFaENIgfu8PU/+Zd/JS0A108ny+ig80jxeRhpcIrxrsI
 zbuTSAlAWFIYGdEMIoMbhULVlDN+iVhmuJswGhSGb+ltZDS2cUGM8Xaiywt58dGX
 U2haug==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706109; x=1785310909;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9xP+aiqOpI1Imz3OccF5vZG9L9MvbqclK/UmjGFxUSI=;
 b=GwGbncO22fUnvbVqnBFOyKt+6hakYLRvuHlgbO9AdD+RMWQNavN6KzRwYNTA3tTLCR
 k9atLsakk3uzvVXf9hCM/s3SOfVZ4M22HUXxwTMh34ZExjHEIYX3oUCccJ5V0EaeIfvW
 GlZyS8G+BhQ1gDTaF463AX0/pqd+ZYjJ+WcONkNunVwRs4RlAAC5uZ/1riMqATrSqZIZ
 LLPDU8Jj0KgOSxNOayxz0isfGNOAq2kRiH2fQdNNW6zQa9Vk5nwgVT+cY4ZHjOTjqqSy
 2mJvuNYhLTjgxVXUDamqnvZHZX2gxNxbL5LFpTi5leSyK1qbwAh/yT6cf+FAXoOoYKBx
 Fk5Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Vtk0YSp2; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GwGbncO2
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

Add structure and enum definitions to be able to parse the information
that is passed from PBL. This will be used to identify the boot medium.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/include/mach/pbl.h | 57 +++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/pbl.h b/arch/arm/mach-snapdragon/include/mach/pbl.h
new file mode 100644
index 00000000000..2e6ad13255c
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/pbl.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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

