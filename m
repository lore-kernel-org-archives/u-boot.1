Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E35FC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A681E86F84;
	Sun, 12 Nov 2023 01:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JVKhY73R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834D886FA6; Sun, 12 Nov 2023 01:09:53 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF83986FED
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7ac7b2b1e99so129090039f.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747776; x=1700352576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWZ5g0ICIUP/wd9EUP3MkhQ9D0uFJ6Uo0BGtkGUL8w4=;
 b=JVKhY73RjQwJ9UNW/ScEv7I6VRwCcidDScficRYypzx3x6IkMc6rIqyTJRVJh9MaiZ
 ZZrJ3NSKkm4+sMrpMGYiHq8D5mYEMgDS+9hFBeKTHcdsncMKMofY67gcKxrGpWZtNNiZ
 AEBB9Nz5jLmJzGc+PSQN5DjnhzrRz3Hv4eeUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747776; x=1700352576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWZ5g0ICIUP/wd9EUP3MkhQ9D0uFJ6Uo0BGtkGUL8w4=;
 b=eWR+GwrXxmD6OI3Sj8NsJY4s3lraGOP9tK53vBVrZC/geHK/ZvCutVvLQnSxLwEo8o
 J8547AN8Ts4POfwzMWn7pHFGGM/nbOHLd89LxfVAAiv92nLGwDUfcHYV3t48rgDLVspQ
 oUqpEYG+uBAgNt46aSbF/h7WzJeAHI76Edh833I3kKYg0GMF0jlcCNqxxe1YrzQSIRHz
 4J02yuaYOqWQN1ZC9pQI4732Pi1DJwPY4BE8/mh13qrSiNEIZihf8l19SRxp2uMLPTsI
 2eWx3BFYuc8tj5THLrmdcVCqa6aNkLZTEeZ5U+EW611b+lCrWshwO1qDZVFrvDUEXRnG
 0M0g==
X-Gm-Message-State: AOJu0YzbhgJEcT4HTXnZyLH0OFUIysyYQLxGgwbTBk8clG329lDeu0Mo
 zZHtFuc03ZEjuZk1d+9HLkUyh7NsX6WcckW1xOo9Fw==
X-Google-Smtp-Source: AGHT+IHJIISg7uus+budhI7YJOxFzXHHt1eVPzkx/LGOSjwozncTY5TvUxiKB9gZAdAfTSkLr8oieg==
X-Received: by 2002:a05:6e02:19cb:b0:359:5389:c0dc with SMTP id
 r11-20020a056e0219cb00b003595389c0dcmr4831355ill.7.1699747776273; 
 Sat, 11 Nov 2023 16:09:36 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 06/29] bootm: Drop arguments from bootm_start()
Date: Sat, 11 Nov 2023 17:08:51 -0700
Message-ID: <20231112000923.73568-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

This function does not use its arguments. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cb61485c226c..fda97706fc26 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -69,8 +69,7 @@ static void boot_start_lmb(struct bootm_headers *images)
 static inline void boot_start_lmb(struct bootm_headers *images) { }
 #endif
 
-static int bootm_start(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[])
+static int bootm_start(void)
 {
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
@@ -783,7 +782,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * any error.
 	 */
 	if (states & BOOTM_STATE_START)
-		ret = bootm_start(cmdtp, flag, argc, argv);
+		ret = bootm_start();
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
 		ret = bootm_pre_load(cmdtp, flag, argc, argv);
-- 
2.42.0.869.gea05f2083d-goog

