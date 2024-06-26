Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD69C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F1B8858C;
	Wed, 26 Jun 2024 18:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RP6JL89b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F2688521; Wed, 26 Jun 2024 18:00:18 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB2488566
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cdd03d6aaso4895442e87.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417616; x=1720022416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOduDstwRx9JFHQGUTamaoAoIgSOooUTdQ8x/X0aOHc=;
 b=RP6JL89brhAKEaA8+T8Ez35S/gj3f2SZfQS9Mi5CRBmcKmVs40K0dRsFxD4gMIOFu1
 UCkfcIlH4lSfAWcFHixTo+dL9i65xClbXQ+hzo0cw97815jsyM2ZtmVDebsVfQyw0XSh
 CJpxIaJLmv6ackwOKTInFc4pbQs6suCckjUdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417616; x=1720022416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOduDstwRx9JFHQGUTamaoAoIgSOooUTdQ8x/X0aOHc=;
 b=TCbxX3yTxMRGFXb4OYoQ/XX+5htUo+VryUqceO9yaRVlrEN8eJvUQXA4cyumu/mQ3K
 Wtgsl2XUWJgd9gJyDArxCrZowIKcPrXI3MymY0gvzHLJPuduQUAHFCd5fXH2Ysf05zDb
 wbFFz09oZXhPfh+PuRQ9Q4+9JpOFqckVFYWLQIPpTA8/biTIszAc9InWN2oQXrjEJmAQ
 dXA/X91ilXCPHzkivl0MWKTOrTObNByUgNZ6CO0XaPoSbQ6nlS1Bon0HqJl9WcHW/0ra
 SbYTyRWKJ0ARqpH0FIQFV/spwAMBdKA1fHatUHm8UD5Fd+VEZh2+zDM5UUr/QYOEAvbE
 rSsQ==
X-Gm-Message-State: AOJu0YzKcgT6bIju8Cdc2B/nUUgFYRcpOfh2oH2Kle03EV/qnRPbXnjN
 Br8RnfUKsC9gqjhIrNLcsOkwyoqtExSvYW83llvJ8H+3wN0M0j4MVxqaEVR4tleZF4XWFrBOGzL
 h0g==
X-Google-Smtp-Source: AGHT+IHBiJLPEBpn5xI6dw57Nn4Bj74NjmnQetF4BQsi1+kkGigd2vvNZBY1UEISsHZM1BbvLUkuaw==
X-Received: by 2002:a05:6512:3290:b0:52b:82d5:8fd2 with SMTP id
 2adb3069b0e04-52ce0673533mr7034573e87.47.1719417615069; 
 Wed, 26 Jun 2024 09:00:15 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v5 11/16] fdt: Correct condition for bloblist existing
Date: Wed, 26 Jun 2024 16:59:40 +0100
Message-Id: <20240626155945.278640-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

