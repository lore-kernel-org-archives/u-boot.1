Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E41C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 871C140757;
	Wed, 22 Jul 2026 07:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfdk2OstjeRB; Wed, 22 Jul 2026 07:41:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C490F4071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706104;
	bh=oD3+QAF+7lSe0zxT/ieLHfKa2cJ3r3sFmk7K/YVe49A=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Xr6FiWwZKs86a4IEkI1bP5ft9Hgg+Fymr1lX0xA5HxxfFEogCiveojIfdB7BvLYJM
	 gZTRV4Z5IBSrterD5ML9Ciahz1Vq8QcB/oH/TrKPMOg7SGb/ScnQjUIV7nr/p3mboc
	 5JBzQP3S4fvEfF29sUzzUv9IvW9aUcO/wps/PnLVH7I6spGEBDwqnPSpf9SzDnG4KT
	 3HHU/rGUZT9VDzR3+U+4u7nHf03Hb5bbFevPk3GdicBb0mGbvW2dQrKoKm/ghGmp3K
	 QTgZtlfk6phqSZdqe5nLiUMrPiR2G3hLAw9XELdklQmC/01+UyvNxiL83Py/q98Xed
	 e+TMSqposqJRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C490F4071D;
	Wed, 22 Jul 2026 07:41:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A48DBDB4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A8E54071D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05zzdotTxxnV for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:41:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 628F240718
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 628F240718
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 628F240718
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53uAW3996056
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:41 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d2v3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso7450380a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706100; x=1785310900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oD3+QAF+7lSe0zxT/ieLHfKa2cJ3r3sFmk7K/YVe49A=;
 b=MXRtfqVfTNnvNoaayxzb0lDlY4SQ8ftgsOpHtE4faaqD5B2tTOPZKdOhALEgCRdFj0
 t2W9YQ9Ze2NRMfCOLiHgFDbbaXXCdsOiOtuqURhcgZ/G8V2fMt4QUTYfOwyfQgdvkF60
 2RdaBXjnBHnWjFcZoY9CgvVcqjkZxUbUlOJak5MXL6/H5DW/U8xnHZBEVdJTJNvzj5uK
 S0Z/Y9T+zBFiJDHWLSYOpdEWFF/uk1ZEoPEjqn5kY9BKqNuga1V67ztWMuE9HxJcSLyv
 H2EGMQmB5bG9uIFxp8BycM8ZGZpmZQtP4UwfVzY92fB7W/fOCRmRcPNdV1mBlSv3Khah
 QUjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFpsKURGT4K0e1wGo6iU7wpbYACbnmZdVlUF1Ca50wYj2/q2LmcsXUnA4EdtXIbgJqn/qi0f0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YypmINmUYB2lT0btaclEI2paAMXV4gvE4YnGEKyD1MVAe5u6zJC
 Zg6GFqo6YTS5mA93dutQEJugf458bqgAvb7gkcNWhIAB04JP8CoOjTdd9s5tyjVNG5vgH5wnHwI
 CXOvwJA66leNJtl2UREIGXMDbE+nY+nMlSJH02ycXPWwflmzXzGDu2Gmcn1LnZMCssfuIc3M=
X-Gm-Gg: AR+sD125FfaG5wXXL3xSEdCWaxNnNOMkQ18LIBinGFJaBXVX6YZxhZkPRhJ8Lr69UKC
 PVmiUml1O0z6j4NNKOI9pxFxKUBlh8TYSqzkb9uoSBGpyEZKbGMO17qQvUFJEMhUHgGa0mGGVdT
 AMrhcH61OY0AlG3qvoX8V09z1tYLaqbCG2BqLWi/LiSZcV86fJzoqBiWOzkGGPdMhYnEtyaz0wr
 m6TRGCxptqZBqblqPinMt3dtfX6WAVEm9fUF9ViT3FOAtIv9GWCn0csBSXMBinFn8hwz7XNtsot
 810bwd4NkhmfJidX7tnHHSTuQpGOH0cIgkwCfTcpjefJtHQ3zNp3X8pwPTTGhxUFk+8EgQJDx80
 BsEDcg5v5/frS+aP/n5+Hxfb+DpD7uA8nzV6pks9j/6e34fJz4fTMw2jYDBe3p5UjYXADJjcw6e
 bVACh6IweOUMdzDaqwmfs8Pz3dZUNlrQ==
X-Received: by 2002:a05:6a20:7487:b0:3c3:6af4:a658 with SMTP id
 adf61e73a8af0-3c3ad9dcf61mr23292573637.50.1784706099430; 
 Wed, 22 Jul 2026 00:41:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:7487:b0:3c3:6af4:a658 with SMTP id
 adf61e73a8af0-3c3ad9dcf61mr23292540637.50.1784706098970; 
 Wed, 22 Jul 2026 00:41:38 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:41:38 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:12 +0530
Subject: [PATCH v8 01/15] mach-snapdragon: Kconfig: Auto select options
 based on configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-1-cbfa79e85a9d@oss.qualcomm.com>
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
X-Proofpoint-GUID: RRaV_JtupizNNWP5j5LxLOoA66Liaezs
X-Proofpoint-ORIG-GUID: RRaV_JtupizNNWP5j5LxLOoA66Liaezs
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a607434 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BYZ-A9fJ0MEHusibbq4A:9 a=RW3EtsfI09ntgIjO:21
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXysSm/68YcEQt
 h5mUVzMxjpsogWnn+cZ+v9zZRmgCNm13SQarolvexBxmSlpYmz3aI5zjIXW60hapte6VOdtl5xl
 l1ny9HGQSPYIQPjAUL54914KBSF3gS/BNBXYqv896+AmYwgQrm3N30cPiOwGJde9hyCIskuRwpQ
 PC3qpbd7MopLnFmX3Hllqf64JdI0bkQziJlxIB7Q/PYRM9nQkqepO65kQJeQ69IEKGM9t90CBH1
 8J8nZjfwM91Yhp6ZjVTIf3IznFra6dgJH8YnSRcW6yqmrVn5zC1ECwI35doylZJ6BwykVupTGXa
 pHmZEd5VKtP+NYqbCzgY6GkBbZKnfm8P0+/xkGJciPRAg0boWHOBSSe7SBuPpTOjSw1WI5eQU98
 D+5pm7gk7j95Pk7WJijqgoqDZz1BVV2jOq3R0Go3U4xk4RT1uzLPrwMmN5uuShuLAEVqeplK6A0
 ki2/90a6/Z4sOCkS0eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX8Fl5l7AbPVeF
 Lmx9wlN3aL2cOTG299PqBKw3mdw6yUjUrwnFAI18eezn5FIPurbmApeia/a434Lvrw2atlY1kqp
 PVr11CtJTpX1YL+JVno//Mb/ys5WjZo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oD3+QAF+7lSe0zxT/ieLHfKa2cJ3r3sFmk7K/YVe49A=; b=ACB1vKO1bSHD4KRf
 gvVVt9OA/DRNpYMpBmDMQNuWKYQHMYQbLXJR8aVp0uevKSADY+P1kgCe2zwvAkIz
 njudvlUOeoF3/6Ac623+ge9hxF14DJMdNRAFyX5CCDyMmZaz/Twg8XIzQCOYwLae
 I7J6DFEbnRP5o4QVG1c8RoBYrNDINBiHtI9Qa9LaGlKHNW3GiDY1g6M6sMBa37UH
 jbw93DcpSUBeebVzwILQwNKdT9sLEPm2OeVkpx5b9skN6QT89gab1oUxL2OFrLpa
 EHWJwubc1xehxN85o7hijR5x5RW2XO06Zpy5Y9h4mQ6fnIPvnH82uVJ1FJHgDiqE
 0m1DxA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706100; x=1785310900;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oD3+QAF+7lSe0zxT/ieLHfKa2cJ3r3sFmk7K/YVe49A=;
 b=VorgPlaZwSItowssUx/G9brPmNT4eitoQn/inzY8wk9/2HfH+iyDOGJLWGD6fOqcbh
 H/YTP0f1ezNxUtbq9F+DAJFdNXpJssVDpPNt3nX3ZTTq5tQi4ZEu235ZZP+lQxJjU4e0
 JOsxRLKrzIkoR1RIm3UNpOnr5cxcCXrPMVn5OmDpZxYo6ZmWm5Pnlp/jK/FO16w7FdOq
 fpKWEoejKML3kM9s8/UjKLPN4ojOWEeSk1a5DKcibBjX39t5f22BamugfwBvvmc85fgH
 zH1j/cgf8804L3RkLANTY/XRkz9kJXHbyWbeugh+RBbRzMxqSzi5dU1e9YPRokadcMBw
 bcnw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ACB1vKO1; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VorgPlaZ
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

The commit 0debfe4801bb ("mach-snapdragon: Kconfig: changes / additions to
support SPL") auto selects options that may not be applicable to all
platforms. This results in warning messages during make xxx_defconfig
and/or waiting for user input for on/off or values for certain configs.
So auto select options based on the enabled configs in xxx_defconfig.

Fixes: 0debfe4801bb ("mach-snapdragon: Kconfig: changes / additions to support SPL")

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f307340e3aa..51d60ef65fe 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1147,8 +1147,8 @@ config ARCH_SNAPDRAGON
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
-	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
-	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
 	select SYSRESET
 	select SYSRESET_PSCI if !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
@@ -1161,12 +1161,12 @@ config ARCH_SNAPDRAGON
 	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_GPIO if SPL
-	select SPL_DM_PMIC if SPL
-	select SPL_DM_USB_GADGET if SPL
+	select SPL_DM_PMIC if SPL && DM_PMIC
+	select SPL_DM_USB_GADGET if SPL && USB
 	select SPL_ENV_SUPPORT if SPL
 	select SPL_EVENT if SPL
 	select SPL_GPIO if SPL
-	select SPL_HAS_BSS_LINKER_SECTION if SPL
+	select SPL_HAS_BSS_LINKER_SECTION if SPL && SPL_SEPARATE_BSS
 	select SPL_LIBCOMMON_SUPPORT if SPL
 	select SPL_LIBDISK_SUPPORT if SPL
 	select SPL_LIBGENERIC_SUPPORT if SPL
@@ -1181,7 +1181,7 @@ config ARCH_SNAPDRAGON
 	select SPL_SPMI_MSM if SPL
 	select SPL_SPRINTF if SPL
 	select SPL_STRTO if SPL
-	select SPL_USB_GADGET if SPL
+	select SPL_USB_GADGET if SPL && USB
 	imply SPL_MMC if SPL
 	imply OF_UPSTREAM
 	imply CMD_DM

-- 
2.34.1

