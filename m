Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1755C369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 13:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7326F82102;
	Mon, 14 Apr 2025 15:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T9vs2fq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2469B82114; Mon, 14 Apr 2025 15:55:17 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B698006D
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8D83C3F1E4
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744638913;
 bh=pGHIY/oPRieAZ2I5eNeNGj1yZEwoMoOu2wcREUob9uc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=T9vs2fq/6mdlm2k2PkHvsycYwmA8/H5kI/1Mh4hlvXLAz/FMAJ3iCS6U86SAz4WwN
 SMPV76jTtI01UP4CpnvvpI9DNGrvgGyI1UAlntvmIUUVTIRKm+a9/ZN0qYyqossa/b
 EnPUVLbnkbkHf+4h7JVgGtGraJlRU7bmfzGhDRBpjQi8i1Y8Nc3Dt+8ARCmuqaR5iN
 v1qwUxWZO8wdhq0uH5OfRvjOhYcpZSLjZFYnTNzrFkaJyx38RHwMA8fmrFIzqTXThW
 Ws4uXrDYy8u3BqMgFipLoTeLsVI7EBnDj2tzpWc49FYffp9QEiJkb7I4l+spk6FsX3
 wf68YpQVqFp+w==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d51bd9b45so26840875e9.1
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 06:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744638912; x=1745243712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pGHIY/oPRieAZ2I5eNeNGj1yZEwoMoOu2wcREUob9uc=;
 b=CPj9Wu8B4h3Ahfumi0+xNiyMrgD5Zd65VMPgCWoR6zDLcU+++aqPmbdUS1AM1/SVZJ
 w4Q30nk89WEpyYiMNVQhSG7pUD8A5mhsgkqSMuTNHSfw+BzRrRVYiKruXV63+Xgl1U/W
 cBNY59+1dJPOesYMT84IuHu1uaEh9uNTmik/gsql/wVjZogAqMM0mmc8EuRMZuDb5LKg
 4G9CEmWvrmLHrfk9jHlED82BJ6lIR8XAk31YTFkYr5vIKBQr5ALNYRIw5QJ0mQxDkI+d
 nFftP25U2vNPx8JTSkPodNM6lMUxJn1BUEsDXNgYrQ4j2XwxmZGgb8yiw9k4VL8yc1MS
 4mIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/ogE8rsnRBDca4sxBbY9I6odze4ty7UqVtW11sT5kiNFyveyALYxTGHmRZrFW2h6BG0p2jb8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1sEIGA4qBwMGIlHl/gXi7mGfDVjLkj4BlZxJH5S/WhduN8Pxa
 19ByvljrSU9D1wZK4j2M/CKYd+QkcJPbrwvz84c7HOMmt8SwQXiJ1/wbV+Fl5J56qH4H7dq2Yhv
 rmAjNUXd1DE/ieq1D7xUWbzJviRMsHLuN73EXfj/9phaOWI/vk9mQEtAiuhZVQRGiJeg=
X-Gm-Gg: ASbGncvIPZox3l7kNKLrpewGXHbBmkh3OKL6aUklqomMvcxZRlL7Hrw6TWQk0kbwT1A
 w/NT0HDIhKsKE2G4VFf3PqV3OUDrUE7nCnn54hz//B6jPEPyOcOB/AbcbWseh5CLAZjZgzwUBKX
 QkByCH5gFeEijiJC4dRBqDxLW1/ULiJOQipZIhcH3kKUu8LDDO+QFAh791iYZedPokh7+OS4CuQ
 pwi8MCoHJWDBXmMAUfPLHv15LzJ/e2OPMC+G+NIqdvKsq+IZ4Ee6uTjT/c5oRM+U4cWeRTgGn6l
 TlS6XocH2TzZ0196s6ZB2WbC60Pq6bKbUncDdhr2IMR5IRbLbUu1XgoorS1aEg3q0IIilAslCj3
 MWPmrtvdicbShhg==
X-Received: by 2002:a05:600c:698c:b0:43d:49eb:963f with SMTP id
 5b1f17b1804b1-43f3a9a70aemr108053295e9.24.1744638911995; 
 Mon, 14 Apr 2025 06:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5xLkl1tQKWZ69LGhWkYndLn0BkUUPCgWSAykm0h6MD368zvwe/Rezv3P4La2eL8ZdEFb1ew==
X-Received: by 2002:a05:600c:698c:b0:43d:49eb:963f with SMTP id
 5b1f17b1804b1-43f3a9a70aemr108052925e9.24.1744638911579; 
 Mon, 14 Apr 2025 06:55:11 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963f62sm10913352f8f.5.2025.04.14.06.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 06:55:11 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] net: make initr_net() invocation command line agnostic
Date: Mon, 14 Apr 2025 15:55:06 +0200
Message-ID: <20250414135506.87892-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

initr_net() initalizes the network devices by calling eth_initalize().
There is no good reason to disable this if no command line interface is
present.

Let initr_net() depend on CONFIG_NET || CONFIG_NET_LWIP.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/board_r.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 62228a723e1..0b1dbd4196d 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -482,7 +482,7 @@ static int initr_boot_led_on(void)
 	return 0;
 }
 
-#if defined(CONFIG_CMD_NET)
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 static int initr_net(void)
 {
 	puts("Net:   ");
@@ -747,7 +747,7 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_PCI_ENDPOINT
 	pci_ep_init,
 #endif
-#if defined(CONFIG_CMD_NET)
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 	INIT_FUNC_WATCHDOG_RESET
 	initr_net,
 #endif
-- 
2.48.1

