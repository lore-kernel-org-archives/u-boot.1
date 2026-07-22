Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5CCC44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99E6840769;
	Wed, 22 Jul 2026 07:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6SafFDmqMB4Y; Wed, 22 Jul 2026 07:42:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC6CB40776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706169;
	bh=NBHbDA6Vgc7ZKStBnlt4bmo0AdQZvXMWOkLdwRuMZeg=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Osw4QOp405ud39t4Us235XirrGyw5DML+0D02HXbllMwa31mx0QAfggGqPxE0TLFE
	 3frdHxK60XjYymQJ94K0s0f7gYddb99L1PEAfVfg+7OlWg2d8xbn0UiklF89TlsuUr
	 3TLXsJfPxaGwZ28kv2bZAWu0lX2h6FpP9hNiV1EA2i7cipW8wZI3Oq1H2UgD0Os++c
	 U2x2ke3b1Gtw9fiVjOfcDYp7KHq7EX/Ao4DgANsLrsrmbhfXMyjyGsdaF/rX8gg8Kr
	 CUGOEbTYUMU7zcFvUJ8tsd53L8JHCMYuimOqqj2ECiTDNB0PAkQ2urZ7+JEgF9EIou
	 m3oElg0x1ez4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC6CB40776;
	Wed, 22 Jul 2026 07:42:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED973DB4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D35F040776
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZiYWObYpfeSC for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:42:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B2C3340778
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2C3340778
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2C3340778
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53cCs3882982
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:45 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjntn0xmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso17131168a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706164; x=1785310964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NBHbDA6Vgc7ZKStBnlt4bmo0AdQZvXMWOkLdwRuMZeg=;
 b=jf2cOL4Q1jtosNwVHVGPR5s9IONLQSpaanWX0blOOvccvKCb+awBoisa/0gty52UJO
 A3QcbImNkLmt+pMA2EhJTSUPpygH3whMnumuHZyohiNV7vUR/Vabvc3FOCqr2iu+NifR
 vwnjFWADQdN3SYA8jxvHO06LgIAD9zaxh1vSoNERffK8EXS1HYHJ/JTc2yLjLgDZ8Y/B
 U3q4z+zGnocTDvy6UZtix1nTCZvyYUC3A+t1xSA4Cm5SWhTBCe13zEI3/twYt2sLcstf
 wWl4FRrb6yC8s3aucH4uwfgPn2hkEScI5a1kAq0GXiQjllFqvFZwO8j+dOf26adtKY1m
 TjGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpN/ZV8cBrBmxxFpa+5D6T/LPvbFxDZITomsr/kp6oeuM8EUF5Wm5XEcf4qCJfhKU0ULbm6Un0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwWhPncK6vqvIAT+TWQQfupC1g+Kz4Lq+h6ffBVfnjV8pKIokpC
 +LyYiwcYUDBdJ864jdOlJNi2Kyx6HlDCKdVOYbzjhIdaCUr9MwQdfv+rwkTue60y73uRpdQPSUU
 BLizZHhNnXtxjboY0+eegF/d1V2myirILscHHlyPJAuDQ5v2W3qYvfu3Up44w24+B2Z/4VLI=
X-Gm-Gg: AR+sD12HGOuHlTYG0tDWP7RAGf2SVTd0YSYepZkCY84r2K2nEokzjrD8tNhToeHPjhG
 fZFAiSa9FWaFJpZrLhEIw8x8CudX3MW5gOMLnBDuH1RVER/UOCfcenyMIuls3oxEi/+7AhO5CUr
 qpR8p+nKszD9e01F36BIIJw1lVn9LIWC3h7de+5ms4tOd8AbrNzwDoa5d14Nc49fyf/E+3wYVMJ
 8TAsaNepSJJD01WDl3Pa0VIT+Gfi157zmO3+thBEUVhM4fTTc7GU22h7+N9IRXEfNGtrZeiWhe9
 ZvrJueRXh1o4UTAZYTzS0Uczd0vvsnGcvN9dYC+h0tlyUo/NBCbk/SeXdM2ib/WdKmRFHKBt/Q/
 OD2C0EoWWEIcFLlepQybb/6VuxlFMYyKLyoj8FQQ2Q4XP6ibEqexdPRAfgLu4c4XYzy+CB35Z4e
 pGfzy8caSj6anDoZM9PnPvrK1wabRJ/A==
X-Received: by 2002:a05:6a21:828c:b0:3c3:9ed1:2563 with SMTP id
 adf61e73a8af0-3c3ad9d5b60mr23423001637.42.1784706164066; 
 Wed, 22 Jul 2026 00:42:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:828c:b0:3c3:9ed1:2563 with SMTP id
 adf61e73a8af0-3c3ad9d5b60mr23422957637.42.1784706163632; 
 Wed, 22 Jul 2026 00:42:43 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:42:43 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:19 +0530
Subject: [PATCH v8 08/15] mach-snapdragon: spl: Load next stage FIT image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-8-cbfa79e85a9d@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=AJsSZ1gA c=1 sm=1 tr=0 ts=6a607475 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=ckyOdtNtguyc0zMl90IA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: _qnFW38NlrcG2cmmC448tPSVGnQVkpsA
X-Proofpoint-ORIG-GUID: _qnFW38NlrcG2cmmC448tPSVGnQVkpsA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX6FEmds/4ieDH
 /BoqU85NtMfpRBplAHKl7vIRpRkqyHxsV+i5YYvUSKE4Z97mzlM0YHt+Ng+v1jc/3MyOhvU4Of5
 cnTvZRaPQf8IuDBjrv7H/aoqt2ji02k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX+c47+EGLHZp/
 /8oO9gUhZ4y+Vl201rJjKLtZX5wfO8zNl2/gUQaH1qj3AkGTXYqa+UFP92/hLkL9OqtjMHhOzCE
 g3VUgtixdkmeyFGZOa4WVA42//AmxWD3IR1fA2+OIINnBxXJrrrPM7Jd/Ec8IWPKqGPVcXQyA4h
 +KnLQXDWT2Ff0rRS75Gkkv5kk7f9expVGOiVbRLBnmygWbr4YJb3F0WmvLDhzpehywJ8Fn8q/SF
 MY2SNEGqp/wZHagufBmlHlZYSUBieTOsSBhEVqJYPjuSx3jnpp9RKAYvNIq2fxLcxwA1B2y/D34
 ujN1HGHCG/RDf9rz6LMAboOOlHsI/IKv8um6jGpiFJfyCgpQhuB2xFNlI5b0pkaRqhkMhqSyUyA
 IqOVK98D8UteqED1jNDM9SkJK98uPxhfg0SJh153ASu90iGAKY4I3Zo7MFgBPDbwhLCB9Cjlc01
 0UwkGBqwf54szpieHcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NBHbDA6Vgc7ZKStBnlt4bmo0AdQZvXMWOkLdwRuMZeg=; b=HRmH2bxmKTDzdoVI
 e5evBW2nYBiOZ26RbE5eCgevejUDX8qX77aUuXyjdQDUaDhuwQ17mxlC2tLE0p/H
 QIWEJhRhuo7KigV7tBjs6YX5sdtyCeW0iYe+ogqSOhljJLBMLJQmciDp2rc+PT+h
 6IhOEA+ePLPWdUkde600Ib/IWKLOEa9KOnNbNsIo/8x2rmbvAPztd6x5nlVOxVil
 6Iyl2LLda6gnJlzwbeLLyBqexydqAoA0F24N3jcpP3nT8rNrEV7Hp1wnnWjM7n5X
 n5hVhiR8YM5kH3n5ZC28uZ9t02MXnJFRRBjRj2W6DMyHW9Tt0bCMnMoT7jtbepV8
 vBbujQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706164; x=1785310964;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NBHbDA6Vgc7ZKStBnlt4bmo0AdQZvXMWOkLdwRuMZeg=;
 b=U40Zzd1Um4NscywcJvbwWA3qa3oWXvAUNBQXFTxHFDcw/EqVlDvwAs5sGgkko7SXkB
 U02g9AkCmuS4xrEM/DxbwS/vKi34UkgvtH6iM+Rdyp8hwMwDsR7yPrBYblrtft9N3uRW
 wVG/twEHmqwbQJr3s5+vnKmFbAQwnDYO/EBlCdnNFMsqr9EU/Kfr/cnFcxB8RR6fLRLY
 puAGYbKBggvpqc+PKZWfGajxcedvoTamyHSVYTdt69hLWgNWIlgR7hNr32iEFIc53wJW
 Jn0/lZhtM2Eo/N/8fkXbBtzuqPcwp5SxBw5/754E0CHU/hvFvsQoBhrb0kb4JNNUV0Jf
 zsKA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HRmH2bxm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=U40Zzd1U
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

Identify the boot media loader driver and load the FIT image that has the
binaries to initialize the DDR, U-Boot proper etc.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 25b1779391a..716a21156e7 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -253,3 +253,62 @@ void qcom_spl_malloc_init_f(void)
 	mem_malloc_init(gd->malloc_base, gd->malloc_limit);
 	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 }
+
+/**
+ * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
+ * @offset:	Offset (unused, typically 0 for SPL).
+ * @size:	Size of the buffer to allocate.
+ *
+ * Return: Pointer to the allocated buffer, or NULL on failure.
+ */
+struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+#ifdef CONFIG_SPL_LOAD_FIT_ADDRESS
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+#else
+	return NULL;
+#endif
+}
+
+/**
+ * board_spl_fit_buffer_addr() - Get the address of the FIT image buffer.
+ * @fit_size:	Size of the FIT image.
+ * @sectors:	Number of sectors.
+ * @bl_len:	Block length.
+ *
+ * Return: Address of the FIT image buffer.
+ */
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return spl_get_load_buffer(0, sectors * bl_len);
+}
+
+/**
+ * qcom_spl_loader_pre_ddr() - SPL loader for pre-DDR stage.
+ * @boot_device: Type of boot device.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_loader_pre_ddr(u8 boot_device)
+{
+	struct spl_image_loader *loader, *drv;
+	struct spl_image_info spl_image = { 0 };
+	struct spl_boot_device boot_dev = { .boot_device = boot_device, };
+	int ret = -ENODEV, n_ents;
+
+	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
+	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
+
+	for (loader = drv; loader && (loader != drv + n_ents); loader++) {
+		if (boot_device != loader->boot_device)
+			continue;
+
+		ret = loader->load_image(&spl_image, &boot_dev);
+		if (!ret)
+			break;
+
+		printf("%s: Error: %d\n", __func__, ret);
+	}
+
+	return ret;
+}

-- 
2.34.1

