Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB78C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 19:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F78881C8;
	Fri, 12 Apr 2024 21:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QZj4jF+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB18881CD; Fri, 12 Apr 2024 21:06:20 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 832E9881BB
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 21:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41804f10c68so4721545e9.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712948778; x=1713553578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QB/8ep8thFQQU4ta2bSV2+q9DJBmJSoE10CldHQqNHI=;
 b=QZj4jF+LjFKwvpu1bxFNz/iS7yaSLTp2sekQhw1URgX3roPuMLk4Yp+XiG1egpQfMB
 R9cvge1uCM+yMBsrlwT+uE3xUjlLF5h29O/0HVycw77bVJCI6H4PIzvtY3UoaISCtuJR
 zLImUahrJ+z1Asb/+GujM3ZEuaHL8+7ZxchoQTB0qWpmza1VACuMhhdB4EfvTb4X7spr
 nOUtihAyTtuglxpwj55iVXOkoNq4gNiE7aou9A3f0kdpT5L5SkPOZe2qMOV1wBWiEPCg
 R+uKgi7PqZar2UTBBzAogRmSKj5NZk5J1Z4JYM9d0Unb9vQX0yPAvHoCPo9eZ4nLgnN+
 ykZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712948778; x=1713553578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QB/8ep8thFQQU4ta2bSV2+q9DJBmJSoE10CldHQqNHI=;
 b=LWOJdjiEZtujFt2FOoYWDp5mTwOt9qWfa9xg3MjacqRTzQugmKB4j3fr77/CaiLo0I
 3aw7on5P+0hEYlTij8XW+2R26WK0yGTvNupj3pAX7BRKOaLyGzdwOamnipqZEjZp0xB4
 7NtFJvAeQpmLsRqldVUcIeQnzWLsOVFhp0Z47ravDT2dQalqb3zvw3NiV45RwYKBpUIZ
 lsy387htf/tLXAjhWp9Tqdm0oCeGDJkDT7g/+ji3aE0nDzMtNnb2k9vbEKRVWzKr1Ow/
 d368QxEnZNeSD8DX8PVW1KH/AJyYVZU5YyEhEjKMagklsM6/Vyr9mZKMcNcgyAROiaes
 qJUg==
X-Gm-Message-State: AOJu0YxneTBWU9RmqMW2BmMlS1egmaWHvZ5stWTKElIG6kHu4f3lyeeM
 LQ2MUA8Uqvxmh4JtBgfRr4++Z4ugnTOqwuwlU0o+0q+PVxZtRKH9CWpWS90d5DU=
X-Google-Smtp-Source: AGHT+IFsOZbxWiRPoKB+eOPEITuhNqOxwzshYItGOQHsXMMa1D32LHjrOMdhtsf3uimD80gnLS55dA==
X-Received: by 2002:a05:6000:a8d:b0:343:7ed6:765b with SMTP id
 dh13-20020a0560000a8d00b003437ed6765bmr2399361wrb.39.1712948777969; 
 Fri, 12 Apr 2024 12:06:17 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech (92.40.204.173.threembb.co.uk.
 [92.40.204.173]) by smtp.gmail.com with ESMTPSA id
 z15-20020adfe54f000000b00345c2f84d5asm4838062wrm.10.2024.04.12.12.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 12:06:17 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Artur Rojek <artur@conclusive.pl>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] event: add an event for livetree fixups
Date: Fri, 12 Apr 2024 20:04:02 +0100
Message-ID: <20240412190542.1576801-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

Introduce a new EVT_OF_LIVE event to allow for the livetree to be
modified before dm_init_and_scan(). Boards can perform fixups here to
handle incompatibilities between U-Boot drivers and upstream DT.

This will be used by Qualcomm platforms in future patches to enable
setting the dr_mode property if the board doesn't provide one. This has to be
set before dm_init_and_scan() is called as this property effects the binding of
drivers.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 common/board_r.c |  1 +
 common/event.c   |  2 ++
 include/event.h  | 12 ++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/common/board_r.c b/common/board_r.c
index da0b80f24ff0..7d2da51193ab 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -217,8 +217,9 @@ static int initr_of_live(void)
 				    (struct device_node **)gd_of_root_ptr());
 		bootstage_accum(BOOTSTAGE_ID_ACCUM_OF_LIVE);
 		if (ret)
 			return ret;
+		event_notify_null(EVT_OF_LIVE);
 	}
 
 	return 0;
 }
diff --git a/common/event.c b/common/event.c
index 16c2ba6cc921..db32ea0d06f8 100644
--- a/common/event.c
+++ b/common/event.c
@@ -45,8 +45,10 @@ const char *const type_name[] = {
 
 	/* fdt hooks */
 	"ft_fixup",
 
+	"of_live",
+
 	/* main loop events */
 	"main_loop",
 };
 
diff --git a/include/event.h b/include/event.h
index a8f046da3c32..c6436c07d16f 100644
--- a/include/event.h
+++ b/include/event.h
@@ -144,8 +144,20 @@ enum event_t {
 	 * images fail.
 	 */
 	EVT_FT_FIXUP,
 
+	/**
+	 * @EVT_OF_LIVE:
+	 * This event is triggered when using CONFIG_OF_LIVE immediately after
+	 * the live tree has been created. It has no parameters, the live tree
+	 * can be accessed from gd->of_root, or using the of_* helpers.
+	 *
+	 * This is intended to be used for performing board specific fixups
+	 * on the tree before it is used by U-Boot. It is much more efficient
+	 * to access and modify than the FDT.
+	 */
+	EVT_OF_LIVE,
+
 	/**
 	 * @EVT_MAIN_LOOP:
 	 * This event is triggered immediately before calling main_loop() which
 	 * is the entry point of the command line. Its parameter is NULL.
-- 
2.44.0

