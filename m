Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09377D60D14
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC53689680;
	Wed, 20 Nov 2024 10:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RIBExUPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A19A18967C; Wed, 20 Nov 2024 10:22:52 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DB489555
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso3488725e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732094569; x=1732699369; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Y1gMFnlB7TYksUC/LfXjXcu/lzeZpum+ykeIjwe0yQ=;
 b=RIBExUPejhenCJ4tVe6JeJPBOVqUGYCNRV2YMSmPMjpC+LA6mWcBD5y1vtQHy37Gac
 lcA2EYuRfZvJS9xdC1bxYYekucHyighh3D0zoDqBNr5sF32I/+V0bCY8JhHuenZaqH/o
 aUKkNddMo90qO8ogXt5Gg+wITg5W4+vSS7ZVibBTZ/tAsz51VxApNVWKPny8o7+BTFrH
 G1ExNhtfD2kNGZUgdRY61+wDRBFyeXyW/FDAq17nBMxrTE0KsxAWpcn11d5z1HH0Mx5/
 vYvdiK+NdG/J+wpW+X0KrrPLDoQKEpiYOGpNdzCuTMuPKSrMfG/uLfj3XaXquDwPFOdj
 ynrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732094569; x=1732699369;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Y1gMFnlB7TYksUC/LfXjXcu/lzeZpum+ykeIjwe0yQ=;
 b=WVI6H5LWGtltxRvlu7Q+Gq0a5Dfd7Ph9uE1xfZ3pAnAuP8mK7Awt72IiMc3NG2JpgH
 0pg3c/3rwTy9MQWrMOB7TiP4oDtCm/y6bT2UMpGUi/cOxKzo2Lbvg40ptL302y4Bssbh
 P31q3YDfUsL/qNRjolUYdZEAQQeREao9FjB9PpQRLdCI13hokWMKXr4RoT9CFuTPmCEJ
 /I6nCvtgrZLXDapCE2TRqx9CwymvFBWXk8DBCe2gr9VdQ3GA8/TOf2/5ntEXnaw4W6Zg
 dZiMsvVsk1IGiphSPMiP/OQuvk1P52tWkodtJHKAIOLLeQZeLrMoYX/ErYfFNOzHVSXR
 g1Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfBMlmo0jjwqRJnjMgICee5EztBtKmly9Ix4uSqK97Jg5+tZh7K64xow+zUsDoqdNnE5mN8HM=@lists.denx.de
X-Gm-Message-State: AOJu0YyqAnswSeR7o+/84ppPwMVg/167wQbA9dizjdnyrQGbAuDeKGNB
 iA3QBSas8/C1O2SXIwXPNI8aD5O5S9e+GZw1UfQJo5dcCqvWoWAEzp1EfTlrVwU=
X-Google-Smtp-Source: AGHT+IG2UEv35GyA28eoydycYA6ZPXA2hWAfnk9mhOlNKlrT6qD1VWUwHz0FVO0Rqi11cp3r7KCZuQ==
X-Received: by 2002:a05:600c:510d:b0:42c:b603:422 with SMTP id
 5b1f17b1804b1-4334762187emr15999835e9.8.1732094569216; 
 Wed, 20 Nov 2024 01:22:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490529fsm1557333f8f.4.2024.11.20.01.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 01:22:48 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 20 Nov 2024 10:22:43 +0100
Subject: [PATCH 2/6] ufs: core: mark unexported functions as static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-topic-ufs-cleanup-v1-2-a5cef54b1cdc@linaro.org>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3058;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mmBzp805WZH+Xoa18GEw/cjU1b9Arfstj6a4kNHiBew=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPapkWoCxA0MMs2MsYvOSK5qfyvbxjQyua422hCQt
 KABKD1KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZz2qZAAKCRB33NvayMhJ0QmvEA
 CKnAOGwlxnKBADKa7ng27Q8ICAPGUOTQwC0TtxV1yuHtppRj76vSGoJWAhgO5embQdRUxwgtUjub1P
 rSGLR6PfyVQs/zCdvANPytp/DwloHsm8gvob8vEaY29qwbRfxxvXsRRrYHnc1VeGGd/YHEEv1p/ps+
 IfmiLtq8eZD10DwfHLXRNKW4S+r52qkpTbcQlaWBCDIJRuHStnsssPi3xaiWvyQQu2u9GtkP7a33Vh
 xDPQGR7Y10zfnxl9WKn3rLSWaRQ0Pa9gzjsIQxVS5yL+AYW42QdPAiryjhO2TUFHnvGmEXrUBn2L50
 1JYxXwK62XwUHP81QXkzhhOD3AekrtwGKyveKxPOSXYS1O2OXWLURH98T6WycKPkwSLqrO1l5frnn/
 LWns/wwpxi3fdf1xMbhz1JrjceGeLb7az752BczFolfuB/7+j+v+sz/LIFKcEFAbN6ZDLZ0IvbPN0I
 EYdUdNpHsdtxZUdoDgn1mZtAbtl9gCWL7LLQ3fJkjg0UFDsCPt9lzuezHG8gHhDo6/Rk1zMenjHN5h
 rO+ee/m5h3kUAYRbD7MMKHgazAfBF8dipsXqZYei6qlSneVCArG7YNpLxLGduIEQhP1uk9ChzfDEPu
 WxhBjpJ+AYA9PbijuxHhnoFYSEXqVXjdXPFhkguUDPlLNv9T+0NG+3benJOA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Mark the remaining local functions as static to avoid build
warnings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 31c2959aeb12931b2bbdf26b3c676ae1a7b0fd1a..8a6c9f1e40b058dfd29bc07d011d576cdfc504cb 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1035,8 +1035,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
 /**
  * ufshcd_query_flag() - API function for sending flag query requests
  */
-int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-		      enum flag_idn idn, bool *flag_res)
+static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+			     enum flag_idn idn, bool *flag_res)
 {
 	struct ufs_query_req *request = NULL;
 	struct ufs_query_res *response = NULL;
@@ -1171,9 +1171,9 @@ out:
 /**
  * ufshcd_query_descriptor_retry - API function for sending descriptor requests
  */
-int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
-				  enum desc_idn idn, u8 index, u8 selector,
-				  u8 *desc_buf, int *buf_len)
+static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
+					 enum desc_idn idn, u8 index, u8 selector,
+					 u8 *desc_buf, int *buf_len)
 {
 	int err;
 	int retries;
@@ -1265,8 +1265,8 @@ static void ufshcd_init_desc_sizes(struct ufs_hba *hba)
  * ufshcd_map_desc_id_to_length - map descriptor IDN to its length
  *
  */
-int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
-				 int *desc_len)
+static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
+					int *desc_len)
 {
 	switch (desc_id) {
 	case QUERY_DESC_IDN_DEVICE:
@@ -1309,9 +1309,9 @@ EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
  * ufshcd_read_desc_param - read the specified descriptor parameter
  *
  */
-int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
-			   int desc_index, u8 param_offset, u8 *param_read_buf,
-			   u8 param_size)
+static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+				  int desc_index, u8 param_offset,
+				  u8 *param_read_buf, u8 param_size)
 {
 	int ret;
 	u8 *desc_buf;
@@ -1570,8 +1570,8 @@ static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
  * ufshcd_read_string_desc - read string descriptor
  *
  */
-int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
-			    u8 *buf, u32 size, bool ascii)
+static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
+				   u8 *buf, u32 size, bool ascii)
 {
 	int err = 0;
 
@@ -1882,7 +1882,7 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
 	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
 }
 
-int ufs_start(struct ufs_hba *hba)
+static int ufs_start(struct ufs_hba *hba)
 {
 	struct ufs_dev_desc card = {0};
 	int ret;

-- 
2.34.1

