Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F4AFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C612984178;
	Mon, 27 Apr 2026 14:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMtR6sTx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S90aiBd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA0080433; Mon, 27 Apr 2026 14:07:04 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0B883AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8TNIZ665837
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G2FyCqvVEZxx0KR8u1AMr6abjhvNsK1ubOfsU7Ff64w=; b=WMtR6sTxMK7gh701
 jlrCVCmjNrJHcN8R+UUAYkI3fy07RuQAjigqnc8TRYQKCwO0h+wqbFaz4ROkSGsm
 YBEONz2JZnxfriZ9vhDMwHCcnQWaorX46BVpOl3kXBZxy6UYSL/hdaALsMb35Bil
 HiirO3pEXvuh0ru+B9mwMyQZ46TJZX7Zr7mse1LcDIark0f6c4qDcyOGcIk+ojc3
 0LX3Pma38a1t73aQrfIqXmdugUbni1J/G0RaB5KQ+2Wd9sB/4KTeqREAH7vwaFnl
 j2tNz+CIO3eZcZQQhFkh/jfPNbG6CbzbiaOYQu96wqn1agyhWpA9qjytX1T1TlMg
 mLyjEg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n18xs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:06:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fb969a4c0so11068819a91.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777291618; x=1777896418; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G2FyCqvVEZxx0KR8u1AMr6abjhvNsK1ubOfsU7Ff64w=;
 b=S90aiBd/PwH6pcTK5sP90jJqWecAeZVH0WAFtxPeaQq0g3SJQFaH/U7TrrlIpSKCRV
 uz4tZq48+EzFjvQL1Iiv7PX3a76lJGA9f+ZvjcHZ2+4t4FX7s7MHas+kDFH/cQwR4Cmm
 qYM8mvJda2e3HeWsUTuuZRrqujy4rNNQdNOAiQf3NPMOdJz/MzR3anDIrdBmNlsH5gxZ
 Zg0RtNDVxUglTN0KtT01+XVTd1fN9yf8Onhlibz6b49odHXQdB9OjHRuAJmtcKNSPngD
 OwSvVM1QhV3gu7Tztik5i544GY4UjUa65fF2y0l0s/OHjAycWzeE9a4aRi5xyXpREhE7
 ghQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777291618; x=1777896418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G2FyCqvVEZxx0KR8u1AMr6abjhvNsK1ubOfsU7Ff64w=;
 b=sKnpo8OMPXLOCMWVs33qfqkj/fSl8GFsSXIChMQu0puA3PIF6x9YEv8RAO0tpiig2i
 ImZGMi/Cr9FNSmCX+iXw/0P366KBgnS7yOYWXempRStidwfaL6nVGcJyKDSfasJ2Mmac
 h597XBD7DmT10iSlnY9F3w8wwgB84jalolYWrBq8BfQ0yOwwXaD5TlVcyqXoc35zpgti
 Ser4If6AdX7nMebZR6JCRurfuHw0bwoYa7fOTEicK7MPRKkcf/GBpkcSDdYer77yU4Y9
 1VreNIbLzJB3Pa7UEtc++tj+PGbDO9xEJQdrM8m+mBYTFhVDackiKFZC2IXDJ/lmKLKR
 4AWw==
X-Gm-Message-State: AOJu0YxPp3ScFUf4h6paLVfU0N2ZdQPSwipPcogDLwx35572aWSgcdsM
 qWmu5sOhSuFPmlPwfduFse1bscVE1D6kMC5gfX/z/IHFbbExfbkMOBUXaTOi3PGUQH89q0WiYXM
 lBS3rcdKjEY3LE9X2Kb6Jv4zBkTL1uIXKy8mTt1OdIzY5us8PUk/f+/6E
X-Gm-Gg: AeBDievXaMFLeJtcKTmBDlw0OxwJSBJ8m0PLG2UFUtZO5mMvA4Rv7zltgYeU/3h4+YZ
 i2biXRisrVN/p/ejiNt0dF4zZ6nx6lmSUjlsLcbevyLbr8LEKmSjr0aRwYOJoAOVGOJtbK+0PdE
 8ccRQARRhyajMzXRtjN7SKqpmYPvfIwy6zqPIY1npGOtNBOPJwChNCbtm9LnnC9LmMcyVkg8m9r
 VqDYNE0g+ff1dPatxC72d7rRUWMGj8i2wLliuHoR9jgM3FCxQ/CqHiG+JYo4pUD3nS5YoTOn8IV
 n0X4anf+Eh5/OcB2ma4mbM8M3ZWqWFZE8nxLOjXotguK1D/sKiXbWhfKGoW8VeOaBmfBNnIPo99
 xLZWxjBT00Hbf8ansvDF/QJr2n2jb3fQEkDlwLM3MjyS+JQknZgm7R4PZhNjCeqaRXoqabbm2Z6
 rKp5shvdyYq4+QFF4iEJu/yNSsuEshgLHeYFQD4xeulCGGO90olt5HCk/1RWO/
X-Received: by 2002:a17:90b:3f4b:b0:362:e7e5:a20a with SMTP id
 98e67ed59e1d1-362e7e5ac9amr13745404a91.4.1777291617427; 
 Mon, 27 Apr 2026 05:06:57 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4b:b0:362:e7e5:a20a with SMTP id
 98e67ed59e1d1-362e7e5ac9amr13745362a91.4.1777291616780; 
 Mon, 27 Apr 2026 05:06:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140feea38sm31832910a91.6.2026.04.27.05.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:06:56 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 17:36:43 +0530
Subject: [PATCH v2 2/4] fastboot: Add GPT/MBR partition table flashing
 helper functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-fb_gpt-v2-2-9e7fe3c1649a@oss.qualcomm.com>
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777291604; l=7540;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=LOjHstRk6nfcx42gdY+r/pBsozQA0yOz3mjM8e+UnqY=;
 b=1Yf5r2Wmr58Ym3Dezh3qkXjMYYjelrIMPAJLj+5biNXyT9LLxor3prpofr7JEoLX2I3vYAYI4
 c/3IQbeFzZuBRQaFfuiYsV2mv6QT5qyoIZ524cGg0i9enUwahdmaVOG
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyOSBTYWx0ZWRfX74uBlThI8j5z
 8kaSofruaR8L7TqauIkOyu+6MWCddEyVxCp1QGLAjU064AwDtXsK7NX96DpGzS27urjQM8QvKKJ
 xzbsCTXxXJwa1vSObQapE26kJiV9DbtZ3AAGrZH8MeSvD4bsxnsE6YqrgI6mJeP3TaA0JeqSlnV
 KD7Og6z8mopSLkcM/3RMhLjPqq2QpBwbs6FtrY/OJZ8sN6iIpvBsXSTUsuZzgN3KnOK1z0JK34f
 lEj2yi4gCvGJBoj3afyynBA8Cv4AaeLtcUoFy+gxWZ6s0WvJFVZcHQWtpe9w6oy5k+MDqkXCBQS
 e2HxEXH4XC6oI5ivkjHTK3bGRrVyt6BJsvVKEaycd07vLDdgXUyupwRW/jrNTJEeja7K+8k0h/j
 D2rb02LlOC1QqB1ha9UUnCTwj6lDoQrPQHoEH68LSSRI8QiWepHPqZXbqdimT+luRPaxuAYvUco
 J1PP7mN8LcZL4W2rJpA==
X-Proofpoint-GUID: WciWY3jeWk7ERiWqu4--2Lpj9XSWnlVU
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef5162 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=3dU_fRaA568bylSsTIQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: WciWY3jeWk7ERiWqu4--2Lpj9XSWnlVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270129
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

Add fastboot_flash_gpt_partition_table() and
fastboot_flash_mbr_partition_table() helper functions that handle
flashing of GPT and MBR partition tables to block devices.

The MMC backend now uses these helper functions for GPT and MBR
operations, simplifying the code while maintaining the same
functionality.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly created in v2
- Adds fastboot_flash_gpt_partition_table() and
  fastboot_flash_mbr_partition_table() helper functions
- Update fb_mmc.c to use these functions
---
 drivers/fastboot/fb_common.c | 94 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_mmc.c    | 49 ++++-------------------
 include/fastboot-internal.h  | 30 ++++++++++++++
 3 files changed, 131 insertions(+), 42 deletions(-)

diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index dac5528f809..b20bc728910 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -245,3 +245,97 @@ void fastboot_init(void *buf_addr, u32 buf_size)
 	fastboot_set_progress_callback(NULL);
 
 }
+
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+/**
+ * fastboot_flash_gpt_partition_table() - Flash GPT partition table
+ * @interface: Block interface name (e.g., "mmc", "scsi")
+ * @device: Device number
+ * @download_buffer: Buffer containing GPT data
+ * @response: Fastboot response buffer
+ */
+void fastboot_flash_gpt_partition_table(const char *interface,
+					int device,
+					void *download_buffer,
+					char *response)
+{
+	struct blk_desc *dev_desc;
+
+	if (!interface || !strcmp(interface, "")) {
+		fastboot_fail("block interface isn't provided", response);
+		return;
+	}
+
+	dev_desc = blk_get_dev(interface, device);
+	if (!dev_desc) {
+		fastboot_fail("no such device", response);
+		return;
+	}
+
+	printf("%s: updating MBR, Primary and Backup GPT(s) on %s device %d\n",
+	       __func__, interface, dev_desc->devnum);
+
+	if (is_valid_gpt_buf(dev_desc, download_buffer)) {
+		printf("%s: invalid GPT - refusing to write to flash\n", __func__);
+		fastboot_fail("invalid GPT partition", response);
+		return;
+	}
+
+	if (write_mbr_and_gpt_partitions(dev_desc, download_buffer)) {
+		printf("%s: writing GPT partitions failed\n", __func__);
+		fastboot_fail("writing GPT partitions failed", response);
+		return;
+	}
+
+	part_init(dev_desc);
+	printf("........ success\n");
+	fastboot_okay(NULL, response);
+}
+#endif
+
+#if CONFIG_IS_ENABLED(DOS_PARTITION)
+/**
+ * fastboot_flash_mbr_partition_table() - Flash MBR partition table
+ * @interface: Block interface name (e.g., "mmc", "scsi")
+ * @device: Device number
+ * @download_buffer: Buffer containing MBR data
+ * @response: Fastboot response buffer
+ */
+void fastboot_flash_mbr_partition_table(const char *interface,
+					int device,
+					void *download_buffer,
+					char *response)
+{
+	struct blk_desc *dev_desc;
+
+	if (!interface || !strcmp(interface, "")) {
+		fastboot_fail("block interface isn't provided", response);
+		return;
+	}
+
+	dev_desc = blk_get_dev(interface, device);
+	if (!dev_desc) {
+		fastboot_fail("no such device", response);
+		return;
+	}
+
+	printf("%s: updating MBR on %s device %d\n", __func__, interface,
+	       dev_desc->devnum);
+
+	if (is_valid_dos_buf(download_buffer)) {
+		printf("%s: invalid MBR - refusing to write to flash\n", __func__);
+		fastboot_fail("invalid MBR partition", response);
+		return;
+	}
+
+	if (write_mbr_sector(dev_desc, download_buffer)) {
+		printf("%s: writing MBR partition failed\n", __func__);
+		fastboot_fail("writing MBR partition failed", response);
+		return;
+	}
+
+	part_init(dev_desc);
+	printf("........ success\n");
+	fastboot_okay(NULL, response);
+}
+#endif
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 11d9c8e8460..c85853915c8 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -343,7 +343,7 @@ int fastboot_mmc_get_part_info(const char *part_name,
 	return ret;
 }
 
-static struct blk_desc *fastboot_mmc_get_dev(char *response)
+static struct blk_desc __maybe_unused *fastboot_mmc_get_dev(char *response)
 {
 	struct blk_desc *ret = blk_get_dev("mmc",
 					   CONFIG_FASTBOOT_FLASH_MMC_DEV);
@@ -389,53 +389,18 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
 	if (strcmp(cmd, CONFIG_FASTBOOT_GPT_NAME) == 0) {
-		dev_desc = fastboot_mmc_get_dev(response);
-		if (!dev_desc)
-			return;
-
-		printf("%s: updating MBR, Primary and Backup GPT(s)\n",
-		       __func__);
-		if (is_valid_gpt_buf(dev_desc, download_buffer)) {
-			printf("%s: invalid GPT - refusing to write to flash\n",
-			       __func__);
-			fastboot_fail("invalid GPT partition", response);
-			return;
-		}
-		if (write_mbr_and_gpt_partitions(dev_desc, download_buffer)) {
-			printf("%s: writing GPT partitions failed\n", __func__);
-			fastboot_fail("writing GPT partitions failed",
-				      response);
-			return;
-		}
-		part_init(dev_desc);
-		printf("........ success\n");
-		fastboot_okay(NULL, response);
+		fastboot_flash_gpt_partition_table("mmc",
+						   CONFIG_FASTBOOT_FLASH_MMC_DEV,
+						   download_buffer, response);
 		return;
 	}
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
 	if (strcmp(cmd, CONFIG_FASTBOOT_MBR_NAME) == 0) {
-		dev_desc = fastboot_mmc_get_dev(response);
-		if (!dev_desc)
-			return;
-
-		printf("%s: updating MBR\n", __func__);
-		if (is_valid_dos_buf(download_buffer)) {
-			printf("%s: invalid MBR - refusing to write to flash\n",
-			       __func__);
-			fastboot_fail("invalid MBR partition", response);
-			return;
-		}
-		if (write_mbr_sector(dev_desc, download_buffer)) {
-			printf("%s: writing MBR partition failed\n", __func__);
-			fastboot_fail("writing MBR partition failed",
-				      response);
-			return;
-		}
-		part_init(dev_desc);
-		printf("........ success\n");
-		fastboot_okay(NULL, response);
+		fastboot_flash_mbr_partition_table("mmc",
+						   CONFIG_FASTBOOT_FLASH_MMC_DEV,
+						   download_buffer, response);
 		return;
 	}
 #endif
diff --git a/include/fastboot-internal.h b/include/fastboot-internal.h
index 610d4f91414..35683cdb642 100644
--- a/include/fastboot-internal.h
+++ b/include/fastboot-internal.h
@@ -40,4 +40,34 @@ void fastboot_getvar_all(char *response);
  */
 void fastboot_getvar(char *cmd_parameter, char *response);
 
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+/**
+ * fastboot_flash_gpt_partition_table() - Flash GPT partition table
+ *
+ * @interface: Block interface name (e.g., "mmc", "scsi")
+ * @device: Device number
+ * @download_buffer: Buffer containing GPT data
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_flash_gpt_partition_table(const char *interface,
+					int device,
+					void *download_buffer,
+					char *response);
+#endif
+
+#if CONFIG_IS_ENABLED(DOS_PARTITION)
+/**
+ * fastboot_flash_mbr_partition_table() - Flash MBR partition table
+ *
+ * @interface: Block interface name (e.g., "mmc", "scsi")
+ * @device: Device number
+ * @download_buffer: Buffer containing MBR data
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_flash_mbr_partition_table(const char *interface,
+					int device,
+					void *download_buffer,
+					char *response);
+#endif
+
 #endif

-- 
2.34.1

