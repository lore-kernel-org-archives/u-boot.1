Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A9AD18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC6C8921C;
	Tue, 15 Oct 2024 00:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eHHqUEKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D54889294; Tue, 15 Oct 2024 00:32:31 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2358389251
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a1a90bd015so13019385ab.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945144; x=1729549944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oxrt4YqIxAERj24WV+Erm5om9gFl0fh+xMwjJZkScQ=;
 b=eHHqUEKoR/MEoi2TUF/hQrv9+eOhAjmhmY+LtRxStwm79fPy8VV9W+rh3sOxBJGNkY
 wGblW2zhYK6dYuA++OLA1zq9oBaczzh5puaLoiLRfY7I/nsVkTxDRh8YH6B06JI09UX4
 jERSuhrzj95LBz+GCB/PgIEt47Vp8vv69m4/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945144; x=1729549944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oxrt4YqIxAERj24WV+Erm5om9gFl0fh+xMwjJZkScQ=;
 b=Fne3lHJAhlrl12Wk7hp2FOgHmg0g6eVXDB5fhPi4SbH5ib5rGWLFpukH0Ri/p70vBs
 PhoRj22EPlxx1JrAQEY54dK2f7QXimiV5n2iarNt6BOXexANJckt3UE04Ki6C4Inf2un
 m9H19TzikChpAhaU1V9c8A3zGyHAMDDY186p8iHgw5jQUfmA+7y9FmmUg+a/5zRlURo3
 8wD+8b5jlTSB2bFHDbG250Q9Mk8QNjosAUU5HaIlhlyamZ4lRG5pLN1ZQdvd1CEoDrzD
 YCIzpWBsjnZud6wUsnFFWMJWHvGlSEu0gjsFpdQgw6gdCNgJIpFF6wbpZloQEzAyHqzp
 KHAw==
X-Gm-Message-State: AOJu0YzW+iUI5M3+kCM9hm0qBgOUu81uHERJEwO1XNSJJvocYSsyBhmn
 yAOcxDTX/AK50In+GKg0rG5ePSqSQz9mjTYKzvctMCD5zS7kHYc4/nkFEq8HtlXcZBM9vMLYREn
 f1g==
X-Google-Smtp-Source: AGHT+IFgeQ808qv+w1Zee6P2OH2nB3+Xr+mbxmGnJAmIb45VxUv+0Y6fmcqA9PHaq1eUxhkNMg7xfg==
X-Received: by 2002:a05:6e02:1c88:b0:3a3:b1c4:8176 with SMTP id
 e9e14a558f8ab-3a3b5fc417amr105143265ab.24.1728945144135; 
 Mon, 14 Oct 2024 15:32:24 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 09/20] expo: Drop unneceesary calls to expo_str()
Date: Mon, 14 Oct 2024 16:32:01 -0600
Message-Id: <20241014223212.2212442-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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
index fece3ea67f9..930cc40ec07 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -46,7 +46,6 @@ int add_txt_str(struct build_info *info, ofnode node, struct scene *scn,
 		const char *find_name, uint obj_id)
 {
 	const char *text;
-	uint str_id;
 	int ret;
 
 	info->err_prop = find_name;
@@ -67,12 +66,7 @@ int add_txt_str(struct build_info *info, ofnode node, struct scene *scn,
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
 
@@ -94,7 +88,6 @@ int add_txt_str_list(struct build_info *info, ofnode node, struct scene *scn,
 		     const char *find_name, int index, uint obj_id)
 {
 	const char *text;
-	uint str_id;
 	int ret;
 
 	ret = ofnode_read_string_index(node, find_name, index, &text);
@@ -114,12 +107,7 @@ int add_txt_str_list(struct build_info *info, ofnode node, struct scene *scn,
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

