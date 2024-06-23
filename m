Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F24C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D4F8857F;
	Sun, 23 Jun 2024 19:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JK1Z4Mgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24008856F; Sun, 23 Jun 2024 19:53:31 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B34882E6
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-36da84df7adso9877075ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165207; x=1719770007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOduDstwRx9JFHQGUTamaoAoIgSOooUTdQ8x/X0aOHc=;
 b=JK1Z4MgyH1WBQ3BbjU0u6gw6UP05r6SYMTukSbabVY6XB/Xjqq5uSCAtUH0a2h0JOh
 I5po/cnbQ4Frtvgpaz2ATYp9IEo5QCEodIGW2v+wjlATbDlyZ4H98/2iQYNvO+fRoAF4
 T+xtwMOlcrKfG6gG0JI1ydsTrxp7jL4Ul0Yoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165207; x=1719770007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOduDstwRx9JFHQGUTamaoAoIgSOooUTdQ8x/X0aOHc=;
 b=wf9G6u0CwjK9sDqvF01FNXFuXBZYZFvF7GaQItiliF6lEPKr3ZsNqiBpYSzEk2T6U1
 CPxxQyH+3lTyMIeqUB8PWfX52hOWLpEBey8VP3jN1Gy0hex0GK6n7nYyOwJIsdiyYXxj
 noRRZ/W8620zasZRuKtNlgso0oHU2jqRiQi4NwRJ/XfLwBeXiq5u5ftgPQmtJNUq9MZv
 gSikiCQQneQWJ1oS6d8n2oIl00MnOElfEjpSKP643iyDfxz/4dxR7c04t7G6yTqBDj4r
 dqUENnYc69eF83sE9SQ2gPoijtB7fkru6FTK+eozo6wwTwmCfTC4/UQ+xzG6KWzbdQa4
 uxtw==
X-Gm-Message-State: AOJu0YxOCMyMK2HE6VW3NWcESWpiyqYDpcUUZR91MquZ7imSEycBscbe
 J+5wfBskEH5vbGi00spT9MdeXcCtK3VLp+x38M351MsXZ+ShRlPs9l1h2hrffidDZAnJvyg27Bp
 wAA==
X-Google-Smtp-Source: AGHT+IFQVqhYODgrMsCwe0iyHTsCvydKrjhURWKIB3o77OTDXzUdjVjpEMV+ZNxAarsGGxCQt0Zs/w==
X-Received: by 2002:a05:6e02:12e7:b0:376:4261:5b1c with SMTP id
 e9e14a558f8ab-37642615ca5mr5864125ab.3.1719165207500; 
 Sun, 23 Jun 2024 10:53:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v4 11/16] fdt: Correct condition for bloblist existing
Date: Sun, 23 Jun 2024 11:52:57 -0600
Message-Id: <20240623175302.1463973-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

On some boards, the bloblist is created in SPL once SDRAM is ready. It
cannot be accessed until that point, so is not available early in SPL.

Add a condition to avoid a hang in this case.

This fixes a hang in chromebook_coral

Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use BLOBLIST instead of OF_BLOBLIST

Changes in v2:
- Use 'phase' instead of 'stage'

 lib/fdtdec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b2c59ab3818..e16d1819449 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
 
-	/* If allowing a bloblist, check that first */
-	if (CONFIG_IS_ENABLED(BLOBLIST)) {
+	/*
+	 * If allowing a bloblist, check that first. This would be better
+	 * handled with an OF_BLOBLIST Kconfig, but that caused far too much
+	 * argument, so add a hack here, used e.g. by chromebook_coral
+	 * The necessary test is whether the previous phase passed a bloblist,
+	 * not whether this phase creates one.
+	 */
+	if (CONFIG_IS_ENABLED(BLOBLIST) &&
+	    (spl_prev_phase() != PHASE_TPL ||
+	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-- 
2.34.1

