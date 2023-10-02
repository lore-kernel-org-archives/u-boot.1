Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F93E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E2D871CC;
	Mon,  2 Oct 2023 03:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e4CwJzfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2D886CBD; Mon,  2 Oct 2023 03:15:19 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133D087129
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79fa5d9f3a2so490951139f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209261; x=1696814061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjo3caQuitAqa0gkCkZoWJZRKB77glLrAeqGPGl7HDU=;
 b=e4CwJzfVCZ+Y4kFGc99kKAtu1rfvmft5/D3maobGRwOj3xsOxadOC0XPYR+APP9kSh
 FtfpI8DyqoXrdjtOg8H4C8xSnhaFnsJopxks1P8nv3NR9ESNJXo8Uu1fnaHZbEnquyU6
 qgpnLsb9cZlzeNmwq8nFIR4sIaCGaKY1Qp0pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209261; x=1696814061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjo3caQuitAqa0gkCkZoWJZRKB77glLrAeqGPGl7HDU=;
 b=kDiEMXFMzQOsEnaCWhxsP62zwJ61F/4spUvj32abElRh/4/eDz8wBx+05Vmo38tnuR
 RlHWSUqeg3v2rDwTu/UIGhSrpwDeg+845ogdrP8Awgc7sPq6qZTcqVWq4EuZe0mlXLkR
 lq7J5qn9AJuGgAozN68V4bgk5zYAn4PkKqSaXYyDdjhUpbPpXFaPfbSW6v2pn6ifAU5m
 FQ56lAlTnIs/ezhztQPIrAzQ88fVPWdlXcQ9d7t2SqooNdLomOIB2Hx85kGvOVHADMCk
 9VHcDPT3r0Ixg9GpA7QlWonTTjY+9/Rxc4tqm1M8LMQiSy2CFZV1CV4BJso/FxxzNJ1z
 +T7A==
X-Gm-Message-State: AOJu0YyrVPsOEqIVH2mmqJUxQP8BFw0n+forOih5VQf8I8y1KkL+Ghq7
 vMga1K6kf43x03o3eTVXgkA7Z5zIijHM8X3GYB8=
X-Google-Smtp-Source: AGHT+IErYT5q/aUlCq9ChdV5X02K8+bk3DdpGS7ZF9zqnmIFV35l0EK9bBoWPdn3ACmyiA8AzudTaQ==
X-Received: by 2002:a6b:e005:0:b0:785:d4f5:2225 with SMTP id
 z5-20020a6be005000000b00785d4f52225mr12508266iog.19.1696209261690; 
 Sun, 01 Oct 2023 18:14:21 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 34/36] expo: Support building an expo with a textline
Date: Sun,  1 Oct 2023 19:13:38 -0600
Message-ID: <20231002011349.461284-35-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Add textline to the list of objects which tthe expo builder can build.
This allows them to be provided in the description.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo_build.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index 66a4e5e67d6d..d66d619911df 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -287,6 +287,49 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
 	return 0;
 }
 
+static int textline_build(struct build_info *info, ofnode node,
+			  struct scene *scn, uint id, struct scene_obj **objp)
+{
+	struct scene_obj_textline *ted;
+	uint ted_id, edit_id;
+	const char *name;
+	u32 max_chars;
+	int ret;
+
+	name = ofnode_get_name(node);
+
+	info->err_prop = "max-chars";
+	ret = ofnode_read_u32(node, "max-chars", &max_chars);
+	if (ret)
+		return log_msg_ret("max", -ENOENT);
+
+	ret = scene_textline(scn, name, id, max_chars, &ted);
+	if (ret < 0)
+		return log_msg_ret("ted", ret);
+	ted_id = ret;
+
+	/* Set the title */
+	ret = add_txt_str(info, node, scn, "title", 0);
+	if (ret < 0)
+		return log_msg_ret("tit", ret);
+	ted->label_id = ret;
+
+	/* Setup the editor */
+	info->err_prop = "edit-id";
+	ret = ofnode_read_u32(node, "edit-id", &id);
+	if (ret)
+		return log_msg_ret("id", -ENOENT);
+	edit_id = ret;
+
+	ret = scene_txt_str(scn, "edit", edit_id, 0, abuf_data(&ted->buf),
+			    NULL);
+	if (ret < 0)
+		return log_msg_ret("add", ret);
+	ted->edit_id = ret;
+
+	return 0;
+}
+
 /**
  * obj_build() - Build an expo object and add it to a scene
  *
@@ -316,6 +359,8 @@ static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 
 	if (!strcmp("menu", type))
 		ret = menu_build(info, node, scn, id, &obj);
+	else if (!strcmp("textline", type))
+		ret = textline_build(info, node, scn, id, &obj);
 	else
 		ret = -EOPNOTSUPP;
 	if (ret)
-- 
2.42.0.582.g8ccd20d70d-goog

