Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995AFC4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60DDF4076B;
	Wed, 22 Jul 2026 07:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C6nZ6IoDDlbN; Wed, 22 Jul 2026 07:42:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D84440756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706121;
	bh=BUvf2W0iMW0hj6g16UgQH0svshOEgqRQXUhECWxP0S8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=h4PEYjCPa9CgJlPbgEx7Xatg2jCNL3/uUFTFP+EhnonBltJAcXAqFbejSeWrCrOuC
	 AX9A+2slHzvZb0tO5CERRKl2oB6QQDQtIyTST0l+Dh2yxXHdAY43EZGwm36IcPltzw
	 F+xytshafkN0/clC17JBgmeTMMX7oLmR60OyLqAWP2stcxnO59e+05MzfV2aEENibQ
	 rSm9Sbz+gUPdnsCiWpsI+69QDwyn5Wbm5DOuGjmvBCMOM9IyLYF+kHc+rNzg0muW6T
	 F2Xnl8WI3Ezt0AEaBkK5P9A1i1UtLV9yI0EBG4OSRtX4sO9BW3YNEg1gEtL0ByBjHp
	 wJeMaCL0G+iVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D84440756;
	Wed, 22 Jul 2026 07:42:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5879E109F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4634680DDD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bq2nWFZZjuFb for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:41:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2C3E180D21
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C3E180D21
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C3E180D21
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:59 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53eaK3662714
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:58 GMT
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2umq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so51798165ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706118; x=1785310918;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BUvf2W0iMW0hj6g16UgQH0svshOEgqRQXUhECWxP0S8=;
 b=bSd3S+HCc68Z+SNiyW38tgsT2sI/CjcD81Vg6Yhp/3iyGE+4uYHIGc35ycKe9ausJn
 CJiXRipp5wjASK4Hpe3RIAleYKvP7CYKGteeGvVvnezS3BDJnLQj3Lk1djO+Rv4Jyqix
 J97g5ZwGm2uf9jLoUEI9LgK8BOVCFIfMI964feSgwwSGbDCRrMcJOK1UJcJZoqHAjFsL
 WQXipkH05vp2bBaV0QYAh4YH7/X28AfglKRv5JGEa/wSXe3T2tsPll6m9cYfRHU+7Kuk
 hFpggwM++LtO8sJ/4uFHoeZsDZM8sTJJ69zSCMV8TMaWX3MIKCMwzx2vokbpOYY/IDqr
 WL5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZRf+NWI+YaWCpcb/gmjZcRznd1Xej6PRkJ9KS775n0hW5Ag8/VXrtVe9SHMUwzzywJSrohic=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxFHARc4ULQJYi28q/qJY5BAPczijLilpU5yhWO8Viycxz3HgqB
 ColGvyvI1wAbRowBDWF2tSZw7u1898FNIAeLfkG6GQv9l/c7O+tWaJbWBKKhC9BumBu7/YOfD0w
 X/We7MswMPUH7onyJBx5nBelPqYl125efhXnN5l1Cenc0517mIWzDfRu63OXa41xmZJUINbM=
X-Gm-Gg: AR+sD12NCW+1OHDayQ3fLxnL5ilwc//ThjYz23KOaPvRMuRAyaV3EqEORiHloIxEaGe
 rgEOfkPZP5V+0jQlvqXWz8FINHZ6AOqLMV2X5t03uFqjzenMoR71gzAkGpIzrZCwTLvLGKp0qzw
 KcxHFkhYP606LhwtDlbLDAQRENy20eZNyCaUK5A3IV5VCv8c7FN9OAI/n8SiMVFen6svNFJAc/M
 0KJGH8ha5UXF4PKSTHVGJxdclQHOkQU122YEceLiUmLX+jOQv0patfiNqUgGljQ64dcrxEXRiAx
 Jp7kzR5X6QzjcqaoeB0IeJaRdjuEEI2QKsUX4yAH+RkC/iBEOcFEJXkKzWTdWZ1xRGCxJ3naLGu
 IML6fZFu29k3XGDTzQqm0S8YCU1ilUd00UAFDOqUicPJAQhCTKy8cX6O63QwIXMk9T/lfVNuMlz
 xaNQsn1i/mV/MED0GJ4RvMO6NjPBzERQ==
X-Received: by 2002:a17:902:d481:b0:2ca:d034:ee7d with SMTP id
 d9443c01a7336-2cf8dc6d169mr31144995ad.4.1784706117816; 
 Wed, 22 Jul 2026 00:41:57 -0700 (PDT)
X-Received: by 2002:a17:902:d481:b0:2ca:d034:ee7d with SMTP id
 d9443c01a7336-2cf8dc6d169mr31144625ad.4.1784706117372; 
 Wed, 22 Jul 2026 00:41:57 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:41:57 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:14 +0530
Subject: [PATCH v8 03/15] mach-snapdragon: spl: Add support for boot device
 detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-3-cbfa79e85a9d@oss.qualcomm.com>
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
X-Proofpoint-GUID: 35C8ektkQr22duriu3fmGSB8HDWZTPDw
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a607446 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ucNO7vKwwCUcqjR4YxEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 35C8ektkQr22duriu3fmGSB8HDWZTPDw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXybBvPT2cF/gj
 FThKGhBhT6Ig/Ntse0ACs007bjxLnK1wUlYn53WO3ie7C0Wu7VOg2p1TlPMkX4nfII9UzAYV1Ap
 wz0dUA1L4HolsU1HjxguzLL7E+dRl/wZAHqeE13moMiaYkbhqqUDmE9etLZ8NdoM4W261wlQ5G2
 ljFUVD3NJ4E4fXekQqtYxjUuydqq/ock5ViTKl1IBlkJ6SIiwf8dGDXZU9OzGuUE8zk9dZ334DS
 GAnh4E4+9jIFOxr9T5GidbkIh1Wkf2ywR8IXErxQuq0it+ZR4H6clRDpbJ+iHdfLuTrEZEZ8v1O
 MtIGMfBk3ugCI7mzBTMhjsPXU6FyXFLCjg7qoIOUsULNX+KaCcDfzJ7ABwCMl7MTHi+ff1+RHrz
 4TqU1HPjE0eBcC0jdQXChH24jjkbHqci4q9wu3spWnMo+D9ROYWqWu5KyXPgwYqHFrr8PBzvJ2Z
 i2os9Aukvwt3Pyqd6Iw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXwjX3ZsOJRQJ1
 jd9Q9YyrUmVkTWofH6bgf2k/yMl6JClxyHuAPPV9kPblF4v+tKa1j+P2Ymg53QyeXlxdfeH1q0E
 n8lx2OqGYDqHmS88TDgS+ntqt+sjdxo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BUvf2W0iMW0hj6g16UgQH0svshOEgqRQXUhECWxP0S8=; b=izOWC5/tD8+piifs
 tKrc3YW7BfIcTZ6qW5AyZlofKqJArKQXrpGeQrgUjuw2loZPYNquNgQycKRrov4E
 7LDPh3vhYvqVwSdbyZVCeoBPFGAUJ7XZkrW3mclhen68X6iy6KGT1cv3WuPebyNh
 ddxKvFp+3gYHU0fwzgNo0J2lrZA0LpzUZ7u3PFiTg8lv86NLn0dd/is8cvqYFP0B
 pcbq5zjBqvOs4jQ2T0LoI3NRZaykISE7tklUwyQsYLduCz/AZ5iQCvfx436ykP5a
 QZGoT9hUNzkG1twYbDcXRCESLsxyl+J9C7fCMOFUAoGmdsSTNdDOmOfRsqOrBmQO
 XohfPA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706118; x=1785310918;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BUvf2W0iMW0hj6g16UgQH0svshOEgqRQXUhECWxP0S8=;
 b=OxvIpxwCUy76MGJJqRqGUs7r/Ae0jaitMr1Q8Gsl3hTGY9z26+5a2EsnPKKn1L6Q5w
 kXNNt7bk1qoCHQGkaQSNNOwgcMAXydmv0262L/6nRNvzxItBSL44U2toRF/XFCu1DZnn
 GJrbaCLnvVTgpRnpwHIFBVdiCaZQuL/ijF5QBcQNiMehBj+5DMM3gMqxfFyIsjProMG+
 8ojq9h7tU9Y96+nTmhmLzNgAIRkFxXAqYc568A4NcfMXESpFXHmb2FUVtPEnL2JNtzdR
 GmLdX7mJsIgP35Ahyf2pwRipDoVkn1sYu6lwN4yoaj1l5bAoJ7DRWgFeTBpUW/C6j1iP
 5b0w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=izOWC5/t; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OxvIpxwC
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

Save the boot parameters passed from the boot rom and use that to identify
the boot device.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 63 ++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index d69f3e8aafe..6ae59481ba9 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -5,8 +5,13 @@
  * Copyright (c) 2026 Michael Srba <Michael.Srba@seznam.cz>
  */
 
+#include <asm/system.h>
 #include <hang.h>
+#include <malloc.h>
 #include <spl.h>
+#include <mach/pbl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 /* in SPL, we always use internal DT */
 int board_fdt_blob_setup(void **fdtp)
@@ -21,10 +26,62 @@ __weak void reset_cpu(void)
 	hang();
 }
 
+static struct pbl_shared_data g_psd __section(".data");
+
+void save_boot_params(ulong r0, ulong r1, ulong r2, ulong r3)
+{
+	unsigned long sctlr;
+	struct pbl_shared_data *psd;
+
+	sctlr = get_sctlr();
+	set_sctlr(sctlr & ~(CR_M));	/* Disable MMU */
+
+	psd = (struct pbl_shared_data *)r0;
+
+	if (!psd || psd->num_of_entries < PBL_SHARED_DATA_PARAM_MAX)
+		goto out;
+
+	memcpy(&g_psd, psd, sizeof(g_psd));
+
+out:
+	save_boot_params_ret();
+}
+
 u32 spl_boot_device(void)
 {
-	/* TODO: check boot reason to support UFS and sdcard */
-	u32 boot_device = BOOT_DEVICE_DFU;
+	struct pbl_shared_data *psd = &g_psd;
+
+#ifdef DEBUG
+	for (int i  = 0; psd && i < psd->num_of_entries; i++) {
+		printf("entry[0x%x] = %d 0x%08x %d\n", i,
+		       psd->entry[i].param_id, psd->entry[i].value,
+		       psd->entry[i].valid);
+	}
+#endif
+
+	if (psd->entry[PSD_ID_IS_EDL_MODE].valid &&
+	    psd->entry[PSD_ID_IS_EDL_MODE].value) {
+		printf("Selected boot device: DFU\n");
+		return BOOT_DEVICE_DFU;
+	}
+
+	if (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].valid) {
+		switch (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].value) {
+		case PSD_MMC_FLASH:
+			printf("Selected boot device: MMC\n");
+			return BOOT_DEVICE_MMC1;
+		case PSD_NOR_FLASH:
+			printf("Selected boot device: NOR\n");
+			return BOOT_DEVICE_NOR;
+		case PSD_NAND_FLASH:
+			printf("Selected boot device: NAND\n");
+			return BOOT_DEVICE_NAND;
+		case PSD_UFS_FLASH:
+			printf("Selected boot device: UFS\n");
+			return BOOT_DEVICE_UFS;
+		}
+	}
 
-	return boot_device;
+	pr_err("No boot device configured\n");
+	return BOOT_DEVICE_NONE;
 }

-- 
2.34.1

