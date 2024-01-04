Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308D6C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F7A879E7;
	Thu,  4 Jan 2024 16:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SraCA1+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF6B879C3; Thu,  4 Jan 2024 16:12:37 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D439D879EF
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3605cc59228so2148455ab.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381127; x=1704985927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pL5Rc9ZILNnSbZaVemGrqnxQG7qz+PTzseL1FPHaQw0=;
 b=SraCA1+I2m7m2J1DvPYfEiPEQA+swvUkVLBLh7IFFrGJtarHVTNMgQBXom112J4+ht
 SpHtUe1HJM+cRVj+l6JhGwhB/5qtCTnPKt+eG1NROY+3fTU9O6oLpyB1swY1tUrpKPEh
 jyx3/fDxj3m/fovuumYysYSTm5y8cqqUYoMsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381127; x=1704985927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pL5Rc9ZILNnSbZaVemGrqnxQG7qz+PTzseL1FPHaQw0=;
 b=HmsEjBjEd1jgYKzicaBYywgvG7goHIhwlSZf55m3xSK4mTBjKMd1OpWSU9lvDFHQWA
 ib2WGvvAb8/cE3ThdAR7QcYHRLFkysZD5gTOT1kuvxfX7P0J6+B0H5rKbxSIB3rgxmE3
 YgHDvpZztfX65kGmoGNjh2A5jS36JU2CVJwdWtKVkqkRuR+CsoPWEsXcHSQDDBEslVrH
 nmnUpr1w7muucF4+d7Jd21izgZbaXeoGsuLNzFxrxl/hHLTauyYpN0vug0ZczkP6L0/7
 FhsjI8pVVS3LU+WUi+Z/j1QmygLL9WRt7VqI9hrTwPxb28JmPiSrjEYkpg/X78jIInLL
 lsLg==
X-Gm-Message-State: AOJu0Yzykw0qPkcJiFkHvYQluD6w5t9tn1iubYPOJgHQd7ByaDpvIUaN
 pgGIGaV+/AXQuNRZDypz3++7uYNI6hXYJYiSjAV91DIp84gI
X-Google-Smtp-Source: AGHT+IEL2xmVXz0Oo0szrhlBjHv2C3f2ULbtP3AtcLARo/Fq8wutlV2ezYP3dAs15tHZqwClXYSmcg==
X-Received: by 2002:a05:6e02:1a6b:b0:35f:766d:3570 with SMTP id
 w11-20020a056e021a6b00b0035f766d3570mr831163ilv.1.1704381127067; 
 Thu, 04 Jan 2024 07:12:07 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 09/19] expo: Drop unneceesary calls to expo_str()
Date: Thu,  4 Jan 2024 08:11:42 -0700
Message-Id: <20240104151152.697855-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The scene_txt_str() function calls expo_str() so there is no need to
call it beforehand. Drop this unnecessary code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo_build.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index 3458bf12c67..71aa03f2826 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -47,7 +47,6 @@ int add_txt_str(struct build_info *info, ofnode node, struct scene *scn,
 		const char *find_name, uint obj_id)
 {
 	const char *text;
-	uint str_id;
 	int ret;
 
 	info->err_prop = find_name;
@@ -68,12 +67,7 @@ int add_txt_str(struct build_info *info, ofnode node, struct scene *scn,
 			return log_msg_ret("id", -EINVAL);
 	}
 
-	ret = expo_str(scn->expo, find_name, 0, text);
-	if (ret < 0)
-		return log_msg_ret("add", ret);
-	str_id = ret;
-
-	ret = scene_txt_str(scn, find_name, obj_id, str_id, text, NULL);
+	ret = scene_txt_str(scn, find_name, obj_id, 0, text, NULL);
 	if (ret < 0)
 		return log_msg_ret("add", ret);
 
@@ -95,7 +89,6 @@ int add_txt_str_list(struct build_info *info, ofnode node, struct scene *scn,
 		     const char *find_name, int index, uint obj_id)
 {
 	const char *text;
-	uint str_id;
 	int ret;
 
 	ret = ofnode_read_string_index(node, find_name, index, &text);
@@ -115,12 +108,7 @@ int add_txt_str_list(struct build_info *info, ofnode node, struct scene *scn,
 			return log_msg_ret("id", -EINVAL);
 	}
 
-	ret = expo_str(scn->expo, find_name, 0, text);
-	if (ret < 0)
-		return log_msg_ret("add", ret);
-	str_id = ret;
-
-	ret = scene_txt_str(scn, find_name, obj_id, str_id, text, NULL);
+	ret = scene_txt_str(scn, find_name, obj_id, 0, text, NULL);
 	if (ret < 0)
 		return log_msg_ret("add", ret);
 
-- 
2.34.1

