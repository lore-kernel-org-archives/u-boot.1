Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8FFC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D7D88A94;
	Wed, 31 Jul 2024 16:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BpwRWa6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4402E88AB3; Wed, 31 Jul 2024 16:49:20 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24977889E3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-396db51d140so29430325ab.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437357; x=1723042157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pfmf/6o7DbXMlaIeVlN3ssWt1k+mHBgxaykLu9wR+xk=;
 b=BpwRWa6St8Ry7U5P55qBiU9l1ysUsFEYrDmVPs9MYae9etbM994zcI6copmp5OAx4v
 FFRHJca5wt5gh1524MOmh89/7D828mUqlJ4Tx3gvHV7WJsinRJt+VXlfzKR5I1ynKhZ1
 l14ZEWoWDJHLEd1EQ0y4ueSdLtMtY6tB28thA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437357; x=1723042157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pfmf/6o7DbXMlaIeVlN3ssWt1k+mHBgxaykLu9wR+xk=;
 b=SM57cbK1JE5jwi5yxbpoM+9kQ0Eltsl/R7jrcMGbwa0CyJbi5rk7GQyCZQgraezpHc
 TCWhyoYw8XiwIHE4ivvl45Z6LQLPcRXsQ2bB587++T6DjHBRlURj/tgiv+7BFq24Mi0M
 G8UaeT0Pi8F3ARue8uWkGcMTI608lShpd6CAdiIi5z8gKjlMilUKbT6EN22xK8bXsXs6
 a7bNDlhDBAusnGV/aVabNRD7Q52kia43MbVkFsQ4YU25QwtlRS3RLzua1SGbo0H4rk/f
 NWcrEVxO1AQb3G/MNteiUl6wVVgAhaZhy4O6W68898AN4VfuzV+qjjQX8ZRIz/Gv0hQn
 mpYg==
X-Gm-Message-State: AOJu0YwIegEQz/M9SdObxqqa84YsnLAuj4YGjVwD/TW0lvGKJInryk42
 5MlqXCR+tzb4wDELZutMlI2u2jGxEuOvpOCQBEs+7qyMVp90RObLQLBMqCrrls+CoMceKrIva/U
 =
X-Google-Smtp-Source: AGHT+IEazetpybBgM1A23k3n4yXUiTFkvmGDoX/2ozkNfmOApIEsIwA7xoPHG3mpY+QbZ0pIsw8UyQ==
X-Received: by 2002:a05:6e02:1cab:b0:398:16d1:610b with SMTP id
 e9e14a558f8ab-39aec24d15bmr201043235ab.0.1722437356744; 
 Wed, 31 Jul 2024 07:49:16 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>, Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v7 6/8] fdt: Correct condition for bloblist existing
Date: Wed, 31 Jul 2024 08:49:05 -0600
Message-Id: <20240731144908.795290-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144908.795290-1-sjg@chromium.org>
References: <20240731144908.795290-1-sjg@chromium.org>
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
Acked-by: Raymond Mao <raymond.mao@linaro.org>
---

Changes in v7:
- Reword the comment

Changes in v3:
- Use BLOBLIST instead of OF_BLOBLIST

Changes in v2:
- Use 'phase' instead of 'stage'

 lib/fdtdec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 5b3b26df968..6865f78c70d 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1668,8 +1668,16 @@ int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
 
-	/* If allowing a bloblist, check that first */
-	if (CONFIG_IS_ENABLED(BLOBLIST)) {
+	/*
+	 * If allowing a bloblist, check that first. There was discussion about
+	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
+	 *
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

