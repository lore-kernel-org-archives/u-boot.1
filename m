Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4F2C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AEF885F4;
	Mon, 10 Jun 2024 16:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jVR8ZPvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 052DB885CF; Mon, 10 Jun 2024 16:59:46 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E503F885CF
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-36ddf683ad7so222545ab.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031582; x=1718636382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rch1N+RVGzHMc51Jj2sUeBQ325MDbk8FDnOVAg9COLk=;
 b=jVR8ZPvtPv8rWIySyrvw8FIwsieBaYSA/T3BjS3rao0efKRUgrsGK4G8bLZIU+Eqr/
 M58AMzjjYirMF3Ybi1SffVNvk/Dz0ONPNqLpx/mtUbWaRM3FJaelCW1Qp6CaPanlt9zv
 bFJK+eXrKOLlwyC7ez78w3ZGtkOuVfzO8WW+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031582; x=1718636382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rch1N+RVGzHMc51Jj2sUeBQ325MDbk8FDnOVAg9COLk=;
 b=DY1oJgbTIeGMGQl5Mt1dMAYBxT4VrJJEudV1fgtRSQHdFfJrJ84uHEsKvWBk7Odb/o
 QwnIkCgSUuhHHtlud/Zy9k8ZpYIyA2SoCGT9oxHY/R/BFVmsDsdMIV8HUPROPYMJpxjO
 yk87VkF8xYKVCRmWivFq+9qO0uXZIPvhZVWxCGrRNllKQnyXr5kXhDb2raa4Ez3El+cF
 n3JIJH1AtrRLSdhRgY94uFsC3CPAktNyIU0SkwrQzxMnMk4DIxGbCbx+skcS1bLNy8H8
 9PTwHQ8iJH0ZVqlx1oTzRPP2Ex2p4TkSi8XF+HBOvDq+5UOmXLFl2loT9H7j8SCCJx7X
 xIvg==
X-Gm-Message-State: AOJu0Yw6IGryAp22EsBZqhZxMIKOHrtLd5sQBMcmqUyvMlW09zVranGl
 EqYyXmtd3kyTxZOGTbE2QPYhoXcuVmhbp4ELcml5E2hxSKMNYsqXxyzw8o+XHHyzke6xi3CQXcx
 IaA==
X-Google-Smtp-Source: AGHT+IHx98WmdhI2Sc40hP27n9iFEQNKkEdiD0hzPI2ArUzPHGEWAOnHqpOhO/rBxX9gDJO5hMSWpw==
X-Received: by 2002:a92:cda9:0:b0:375:aca4:65de with SMTP id
 e9e14a558f8ab-375aca46883mr16142585ab.7.1718031582531; 
 Mon, 10 Jun 2024 07:59:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2 5/9] fdt: Correct condition for bloblist existing
Date: Mon, 10 Jun 2024 08:59:16 -0600
Message-Id: <20240610145920.3302001-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610145920.3302001-1-sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
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

Changes in v2:
- Use 'phase' instead of 'stage'

 lib/fdtdec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b2c59ab3818..79eaa56ea39 100644
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
+	if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
+	    (spl_prev_phase() != PHASE_TPL ||
+	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-- 
2.34.1

