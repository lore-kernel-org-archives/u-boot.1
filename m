Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55038C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6148294C;
	Wed, 19 Mar 2025 15:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cyuwXN3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFB08291E; Wed, 19 Mar 2025 15:57:05 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0CB81ECD
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso31735535e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396222; x=1743001022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EWO4ebLARjh5inRiixYrRFxE0s+Wdno9NHuj9oFiRs=;
 b=cyuwXN3+dhRCFVVLcvU5NCvrrNn+xQNNcgaZKoM3alUI7+2E0aDSn+pJFEXx3sh1Kr
 CwjnG9V86ibq0Lpnk6V5ubi+TSpBKzDXpzRZzWHgA9m9EKPFc7HLIxXB/UiE3KvU5jtV
 1IC4rGhl3/yY83ZRO3303GaZmvCG2XkvgHlrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396222; x=1743001022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EWO4ebLARjh5inRiixYrRFxE0s+Wdno9NHuj9oFiRs=;
 b=RDQ5A3hlZMbdtbYAgH/4Da1JIfpfQRol6fWJ1ydbZ3FKsKwLCxen/PUWe5ltEZgJv3
 kvHKlxDO1U0/kJlpHWuBRwbaCOw48n5CyFxDatjGaL/jRO5DsgX2EBDPKzYvIP5WU5cm
 NETL46z5toJWvm1OSk9187xPi/xvGuIRzl3QBcPTYcmVG5VFIdvR5XjtOgfNyLPnw91i
 f/abNxjiyF0zzFG/n3YS+GL2ITNMeQVHoiKrQ4xKNlvb9GY/t6H0LGhlk6F/5fRe77UQ
 xfyiJIg6eEQuwHShQz3yQ/xPh3KuYVVGMmvzaczX7aBeXGrN2p6nm3Z/phV/tRgOO61e
 U4aQ==
X-Gm-Message-State: AOJu0YxHmwhyyauo2cuHimGGAS0cr1QbToFqu39iBGIFbLPGbnvC8qlE
 PHkeR92lQrtfaBEAGAnhQAOO3Zp+KD55NcmEfEeLpzZVR72nly+c1nrWFp66ukS5xIMrsO0zikY
 =
X-Gm-Gg: ASbGnctNcG1+vbC7PGaDU66JNGpjKKPolGSYLp1+s0NcJZpU2rk1MFnOe3MZGZPWnuB
 RZpt3+L1NTjscJ7NcHNnwmI6X2JPlIJiO2AvPd0urIzwoAsPnabh0qRjztDCZIGwcVkAllyV9rW
 VgV7/6dYFcN61JVTOfqWsT/nxmmLxBM3pZ5y7C9djLb0VQ5PnyEfYzLOOKmobtOIiCxdjMl5W7x
 ikU9Jw3OEOO+Abz4Ri3Ku6vVsentC3u5Pt6hIryjXiWQndpxQlorsCd+KSq3awD82GGkjd9kgD4
 /bBwdLSHk01vXnnLRfcThfk4r26sIa1rwuRVipYEZw==
X-Google-Smtp-Source: AGHT+IEKWk7BTpjaqLLlMYOYvdw73YE2Wg7ODbMYJ+FBTrfkd4ARn86UB3cJpgiViDo121H2Fp0rIw==
X-Received: by 2002:a05:600c:3b10:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-43d43849772mr23620915e9.28.1742396222062; 
 Wed, 19 Mar 2025 07:57:02 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:57:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 51/52] expo: Set up menu fully in bootflow_menu_start()
Date: Wed, 19 Mar 2025 15:54:56 +0100
Message-ID: <20250319145512.2391122-52-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Apply the theme, calculate dimensions, highlight the menu and arrange
the scene correctly, so that everything is ready to go when the expo
is rendered.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 4fe5d985064..03ea24f4778 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -208,10 +208,6 @@ int bootflow_menu_add_all(struct expo *exp)
 		LOGR("bao", bootflow_menu_add(exp, bflow, i, &scn));
 	}
 
-	ret = scene_arrange(scn);
-	if (ret)
-		return log_msg_ret("arr", ret);
-
 	return 0;
 }
 
@@ -290,7 +286,9 @@ int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 			struct expo **expp)
 {
+	struct scene *scn;
 	struct expo *exp;
+	uint scene_id;
 	int ret;
 
 	LOGR("bmn", bootflow_menu_setup(std, text_mode, &exp));
@@ -305,6 +303,18 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 
 	LOGR("bmd", expo_calc_dims(exp));
 
+	ret = expo_first_scene_id(exp);
+	if (ret < 0)
+		return log_msg_ret("scn", ret);
+	scene_id = ret;
+	scn = expo_lookup_scene_id(exp, scene_id);
+
+	scene_set_highlight_id(scn, OBJ_MENU);
+
+	ret = scene_arrange(scn);
+	if (ret)
+		return log_msg_ret("arr", ret);
+
 	*expp = exp;
 
 	return 0;
-- 
2.43.0

