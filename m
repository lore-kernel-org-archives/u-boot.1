Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF2E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4C08725C;
	Mon,  2 Oct 2023 03:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X7nt10Up";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336D18723E; Mon,  2 Oct 2023 03:18:19 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE988711F
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-352753fb42eso5157925ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209387; x=1696814187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJJPDhr8gJza++eiXv19GVrUFPV/DjDHyJwGOGzmmIw=;
 b=X7nt10UpF/8Peqi4C7C7FcNETNTCIcwu7usvO73AYIzKrdH3DpquQsjY9OFgutXPbg
 S4SraneLSPyrbTsesyCgFSTIKtNhxreEUfi42l4SLz6wcA+PI7fdBQ7atu9dozzx0or2
 f0ukhvuhIu2ymZJkJA4n3bdM1CaeiqMoysDtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209387; x=1696814187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJJPDhr8gJza++eiXv19GVrUFPV/DjDHyJwGOGzmmIw=;
 b=ajlKPQKLij7MdpFc2XLLG9YvrPxK6qqUZ9q0zjLiAO/6LUcHtXHltIw2fxOUVJ52F3
 TOHtflV9g8dt81dvbcCn/EHkA7oaIxbQfOJuz/C+C8/Pp1j6aFFvqkSI5d43iboE17bT
 vYVseMHKVZ1KTipChlqHF9XwO1L/L/OStyV/9w9h5ln8z0af7w9O9sWWQ0jp7VPnwHpT
 UTorsO4co9I3c+U5Gt9G1bpNABO32T7c58RQu4bcurdeJrQ8RL6Rtn4gLBT0u6gJBYUe
 uU/MCNyHT0YX+acIV/YJf+LAewAvmcsnS5xln0VcO+vkaIk0m1cdjYiY1Q9v6FkFPEeK
 kk1w==
X-Gm-Message-State: AOJu0YzhNDsRLFGKd5mkttMagYrUQuEfrx28stHdwbEWLPgs5KSPCrzv
 E228BEu09f7Rorqr2tPo831ET+ZG4vfo5z2hK2c=
X-Google-Smtp-Source: AGHT+IGEB5tKvOWsLjvUDR37yWHdlh2QOKvYJOVpSIi3s7hueE4kxoBw0AttXG0IgLegEVVIqpxHVA==
X-Received: by 2002:a05:6e02:1d01:b0:34f:b7b7:11a5 with SMTP id
 i1-20020a056e021d0100b0034fb7b711a5mr12669176ila.2.1696209387414; 
 Sun, 01 Oct 2023 18:16:27 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 24/34] expo: Drop unneceesary calls to expo_str()
Date: Sun,  1 Oct 2023 19:15:34 -0600
Message-ID: <20231002011553.463514-25-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

 boot/expo_build.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index 24ec4fc542a7..88b6f2ea7eb4 100644
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
2.42.0.582.g8ccd20d70d-goog

