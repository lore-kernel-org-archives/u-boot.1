Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7C2E7718F
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 10:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5750805EA;
	Mon, 30 Dec 2024 11:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fc8FG/1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B3880615; Mon, 30 Dec 2024 11:31:08 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76524805EA
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 11:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so95857355e9.3
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 02:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735554664; x=1736159464; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5KWtDfUrleNXQMS1nijml6OAU847GUFzOHAdGU0C2/g=;
 b=fc8FG/1u73bwoFH5ot96gWgf0cTXWovbsssnWM5ocr13H7E9K7HZWRTJtHy858AZng
 mJcpdQ1CXwxatktgzhKdcZcxQX4TVBIYjCAFuyWOmo6ZPD9P8Eb9JosrWz8XXP8UX3mY
 VHg0YppCJlMMczc2yi37zT8wVw7Xx9hKTDKR6yzkvaA7swH9GyMG6B4f5XSKlqir3vGZ
 TpuGFWAK8sdphzv0Ayx2FdXbsIqMrs1N6ZvlJDP69Xfi9audfmHLzy0lQ14FgggXJoA4
 IOcdiw1syopb6P/vsa2vmqGZLU/j9Vyw6xKBaKzx52sczmZ8pNNl1mat7K/99KYVEDy+
 i0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735554664; x=1736159464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5KWtDfUrleNXQMS1nijml6OAU847GUFzOHAdGU0C2/g=;
 b=UTxIty3VVGklBEIuyI4SXcMduHXtvRE4VRsZH6dcMybd3gQT0u4Jr3JgkCMzYrl5Ii
 qQP3aPYT/LwdC8r+G473rDkDHKatqB5XCFQjJu/BF8GsvtKh3r2bThsV2Of2w/4auvsK
 2mU/DiyXkoHCSINVWUiGCiJg98QyhijQusRBs6ZZh1ZhFbdD6XS95TgcHQvCkiG8aBRC
 nyOOEfFiczZwOTooShJD0NRpxXBe8ABQESNa4gEWiOcXh0k2MtxisQCM5U0Ra5qml47+
 E4ZaRW2zoBMOWuaqXeQ3ogZdr0fO2qw/3CQE7qzRpxkX3L37KMS3+PrqvNujDFpWQsCw
 +i3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrxQDqvwypK0zcG1NLYMNLsw24RKWnVqBiJPjSN0WGi9Cavy7z48jPqC3xYThYL8s2lo97sQk=@lists.denx.de
X-Gm-Message-State: AOJu0YyMkLHEVZj/zDjro+iSRmOF0G2HoBSV0pdSxPCttkR+b/uQ4u1l
 NR5yw635uvVI2T/ZXXC0OpDkezLlUwbIscIickxMea3FERoOAOgck33rRChEWRg=
X-Gm-Gg: ASbGncvTZ2Ex7yF053ceAbdR0PCDoH3bwVYUHgewG1UlAMlktPlV0jXUTahu4VGHXXt
 CqHLxXZdR41ypWX9cbEZfaZVEg0VmAQNl0+aOk+GL44e5bPt1N9B9IWag7qc8k/kGrVWUtZW82k
 mafy3GiWeQNlbmenkEHESb7GBeOnYociErvZzLeVvlF95WMfHGf7qXpjg4/sV1uHyTyKJH1lv6h
 PGcpgEoKdE+pBNmYBcZxbglX32z+B4IcmyATT3yYU3321bA5sYwX9VvGhyXV7UwSjyyCsrkYfqu
 LA==
X-Google-Smtp-Source: AGHT+IFeF7ry2C2DzwcAlgnwswAybnaTC+t9ZVAjjEAtfjMXTzlwP6i7OfB4o/qPJOJiL71JaXQMdw==
X-Received: by 2002:a05:6000:470c:b0:385:f5c4:b318 with SMTP id
 ffacd0b85a97d-38a221f9186mr26104915f8f.31.1735554663972; 
 Mon, 30 Dec 2024 02:31:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm30201550f8f.77.2024.12.30.02.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 02:31:03 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Dec 2024 11:30:56 +0100
Subject: [PATCH v2 2/6] ufs: core: mark unexported functions as static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-topic-ufs-cleanup-v2-2-4c6d7994a45d@linaro.org>
References: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
In-Reply-To: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, Love Kumar <love.kumar@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7Ntx+ovL4LMYDY80gnDbfbqsbq1KGnnMMPEC3UEq0H0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBncnZjjFpN/LKB82U3aQuF1zW1YoG2xY7YVz9yKJyQ
 T1xO8OeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ3J2YwAKCRB33NvayMhJ0XsLD/
 wNHngWLIdWyWFdnZofJJFu2zP/6KFxviIuHEB3dMS8ET+izeFDBXQiofcPBn+KKT1OPSSZwhPg/DOG
 exRP+/FuE6NN8ILESpcfzZ9jz7jLjOvzW+fWV7En7/15An3/iK9n8KvA+KZgstOhLUv5NpXvMlbHH5
 thmUrKDSBzZsqJPPdC2nx0ebV5JfubDhdzqh/EeWIW9ViHmb5SdeBBfohIeIJazWJPgwJgiOSw+GYo
 9UJPKooWXv2cTJx7n0eKRM/xCnbmPHO5+K+6L52MANMrtS+IytJkSSLzzSQm5ECojPc9sNV0Wgv93w
 4+oAM7ApMZa9AqFjUDkSnexIxwc8cADEfXFQLl90lz2pNPXXz6+Wm7nRt3qmunB/jnGsPSf+tbCJ4K
 w1xD5ATdtIX+ljIDlN8/rM/+AdkvEPJ3FmjygmObJ175e1BDpc34Kns4v+QmdX7drFqlAveKi7VxP+
 fd5Bd6oOeSHNaNhfUFTQLZMc7PhoA7y9Estw56TQ85GMUWeZxZJCuk+LABJh1ha3fXabJHyX1mngui
 6wduEOmN6VOkQq4X6eQ5Kb3Amlcj1KhxRovKn4tCO93Gry5jO+E3KfZlh6V8aLzKcWtkFfjQig234z
 CKeBzOgDLx34k4DqtpUwef+bI6YLlLgTMHdpjmBRuYdKoAFXr3HdXV09gw1w==
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

Also drop the EXPORT_SYMBOL of ufshcd_map_desc_id_to_length.

Tested-by: Love Kumar <love.kumar@amd.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 31c2959aeb12931b2bbdf26b3c676ae1a7b0fd1a..654f8b6799ec6735f2db4f6e1c81ee94ec14a74e 100644
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
@@ -1303,15 +1303,14 @@ int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 	}
 	return 0;
 }
-EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
 
 /**
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
@@ -1570,8 +1569,8 @@ static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
  * ufshcd_read_string_desc - read string descriptor
  *
  */
-int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
-			    u8 *buf, u32 size, bool ascii)
+static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
+				   u8 *buf, u32 size, bool ascii)
 {
 	int err = 0;
 
@@ -1882,7 +1881,7 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
 	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
 }
 
-int ufs_start(struct ufs_hba *hba)
+static int ufs_start(struct ufs_hba *hba)
 {
 	struct ufs_dev_desc card = {0};
 	int ret;

-- 
2.34.1

