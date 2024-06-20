Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABF9C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5380885A9;
	Fri, 21 Jun 2024 01:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="miYTlxSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE258839C; Fri, 21 Jun 2024 01:06:51 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A4E8839C
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7eeea388a8eso53539339f.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924808; x=1719529608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4lytI5B/VVQ+P1ExYkyDHmVTgiifZTk2pLRXpeygHA=;
 b=miYTlxSmIkcc/Lv8tcBAKDmgYDapQQfKUdb19mdfLFNiy5GzVBkf2k/RZ4CazugMRs
 KfxfDu4CIBTtBwKk0YkCgs54HiYwDuENKU0T4XR9mCbz9mnQSU0lMdC6mzzOTKA33ja1
 bNKNXvp1PTb4YoQyDzACZYCW5YTzgMJkjezyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924808; x=1719529608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4lytI5B/VVQ+P1ExYkyDHmVTgiifZTk2pLRXpeygHA=;
 b=J+qcg8HGN5ftcCQrsvhA35DhoXY3jxkCb+Y00Gdnd7t4/aEhH2A0aFPpSBohh1GTCA
 x1YzQO2J37z9MRpBxuwPEK09txAO3SgBTwZbZg9IWwdtRZZGxdN/L23faEg86h2PIv9k
 aK6uVb1oHspvD4MepOLnGH2voieIpaBM7m38Jy5lT1RgLxnNgCtht2PZiuH/txbUoBGw
 bG7CxVDqdL+1pogLrMKyOKzsJk4MuQHonDioPbqVbkGCoy1roUnPmcQYc8QGREGhveeh
 SX/l6Os2c6FWIVlVCQf50qAiBKDXckfEk1iiqGDTRZciaGuKT6Cyyo+UOVqBySWrGddu
 VZaQ==
X-Gm-Message-State: AOJu0Yz4wdOYnFDkTJG3XSXmF4ZBokRU0qw7O9Pv738/ohUOAhn0oV17
 5Ym16EFEH+2VV2C1WfbXA6EWtGd9CaqTlztuUe8K+NazqQBkE50YPUbIAuYc+MsOoqwfCGp2QoC
 M8g==
X-Google-Smtp-Source: AGHT+IE6YV1uDBnHAw5UUsL2TJbJ4trSvvmqc5WkLI8DS/fziNQqRMC5X54m4YVMq4KvkMx2FmiAAQ==
X-Received: by 2002:a05:6602:6002:b0:7eb:cbef:1731 with SMTP id
 ca18e2360f4ac-7f13eea7dbfmr723704439f.21.1718924807984; 
 Thu, 20 Jun 2024 16:06:47 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v3 13/18] fdt: Correct condition for bloblist existing
Date: Thu, 20 Jun 2024 17:06:20 -0600
Message-Id: <20240620230625.1797397-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

