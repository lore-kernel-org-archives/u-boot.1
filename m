Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DE1CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A75386B34;
	Sun, 24 Sep 2023 22:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RKLlX2Re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB8A86B74; Sun, 24 Sep 2023 22:40:31 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF908869CD
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3513c0c3318so2657995ab.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588027; x=1696192827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsYHw0YBLZA1S0aO461hh8XCHdTj+whryD87uUg46KU=;
 b=RKLlX2ReKDHs+YRCSbQSLaV3j5Q8sWLWAKexCY72jOjXAA/+/mF0XzmR6jGgqBBxso
 rDer5nCk1dePCoQxyDchgkz8SpMcq9n3SU0rBebVmNgGblMgkxdQuW+sZLiJsViOotEv
 Uh+PSNmjztekjrpx7FayVE+HOOh5Xs3pQXPKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588027; x=1696192827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsYHw0YBLZA1S0aO461hh8XCHdTj+whryD87uUg46KU=;
 b=JGeGo3m8eBR57Oejl8J+3BzJFujiqSFP8zLtdCin4KVQ+d49I1HlluqdxomIiLd+gs
 OCQDSleN7bhIjTckWJIcn7Ck3n76tczCY76cK6yxInOZA/s89cn5+CSyrT3cP11RjX1T
 zWowXOBYa+PU/DO9JSPqjA3EVvULAKL14XZcycTjZeG9VNCIRnSrl1/psC/6as616wyd
 QlavJnCX8dcxMczuo/9UJlEyzpOj9rDwmtbSw9nsa1zphz+2ygQYdCtTynOHzRx9Zaez
 Gjtn4mIFr1lowsPvk4P61/qwbBrW9K6WKaguyiM1tlCmVyRex37XnhkmygChSN8y97qJ
 xt9w==
X-Gm-Message-State: AOJu0YyPoTJ/e8bTv13NyjQvLgYg1ET/3bbcTnaawTXkbcyOZJmMKlGZ
 IjsFd3Iu5NNbIZPjomsL68Xdo/VBqxtD/YmXorE=
X-Google-Smtp-Source: AGHT+IHO2d/2Ns7SiUgfb3Q+pdm/vnHc6QzpFhYIzG3CSSnX+DnZfyqRvWveLKsU74T3Jo3zEKBBRA==
X-Received: by 2002:a05:6e02:218b:b0:34c:dbeb:a2a2 with SMTP id
 j11-20020a056e02218b00b0034cdbeba2a2mr7376630ila.21.1695588027531; 
 Sun, 24 Sep 2023 13:40:27 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dmitrii Merkurev <dimorinny@google.com>, Heiko Schocher <hs@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Samuel Holland <samuel@sholland.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 08/25] fastboot: Avoid depending on CMDLINE
Date: Sun, 24 Sep 2023 14:39:26 -0600
Message-ID: <20230924203953.1829820-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

When CMDLINE is not enabled, this code fails to build. Correct this by
adding conditions.

Note that this should not happen in normal use, since the use of
'select CMDLINE' will cause a visible warning. But it is needed for the
sandbox build to pass without CMDLINE.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/fastboot/fb_command.c |  3 ++-
 drivers/fastboot/fb_common.c  | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 71cfaec6e9dc..4e52e6f0f8bf 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -346,7 +346,8 @@ static char g_a_cmd_buff[64];
 
 void fastboot_acmd_complete(void)
 {
-	run_command(g_a_cmd_buff, 0);
+	if (IS_ENABLED(CONFIG_CMDLINE))
+		run_command(g_a_cmd_buff, 0);
 }
 
 /**
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 4e9d9b719c6f..35b7aafe5af3 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -132,6 +132,13 @@ void fastboot_boot(void)
 {
 	char *s;
 
+	/*
+	 * Avoid a build error; this will always have generated a Kconfig
+	 * warning about CMDLINE not being enabled
+	 */
+	if (!IS_ENABLED(CONFIG_CMDLINE))
+		return;
+
 	s = env_get("fastboot_bootcmd");
 	if (s) {
 		run_command(s, CMD_FLAG_ENV);
@@ -170,8 +177,12 @@ void fastboot_handle_boot(int command, bool success)
 
 	switch (command) {
 	case FASTBOOT_COMMAND_BOOT:
-		fastboot_boot();
-		net_set_state(NETLOOP_SUCCESS);
+		if (IS_ENABLED(CONFIG_CMDLINE)) {
+			fastboot_boot();
+			net_set_state(NETLOOP_SUCCESS);
+		} else {
+			net_set_state(NETLOOP_FAIL);
+		}
 		break;
 
 	case FASTBOOT_COMMAND_CONTINUE:
-- 
2.42.0.515.g380fc7ccd1-goog

