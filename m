Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140CFC3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6948488582;
	Thu, 27 Jun 2024 11:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ykfm6Lty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A38288855B; Thu, 27 Jun 2024 11:19:38 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC43F8852E
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50cso55074851fa.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719479976; x=1720084776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOduDstwRx9JFHQGUTamaoAoIgSOooUTdQ8x/X0aOHc=;
 b=Ykfm6LtyvIzrZwGEQ5LabFH2erhBbmXY8+ZbHS30b1lsbT/R15guDfix7L7X9Hqk/i
 C/uWbRDS8EEsclp5BIha9G1ykxN7R+5qxLreaDQmvLXGcfxdWlT6HiUcGh0mbHipvqwI
 sHrYDRO/eoTuwvVGMdkjQUMsQW2ieHB7abb0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479976; x=1720084776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOduDstwRx9JFHQGUTamaoAoIgSOooUTdQ8x/X0aOHc=;
 b=FQu6DzjLsUYEef411yfabxnttZVxwUmUTdYimLcC6T1Tai3KPAeLmfKL6K/pRhdg8j
 IzuP6XhMrZrrTAU/4ljU18eOjAEgyrpd0pMOWc06hlit3Uy2KTTfP+NnMaBNZqEOuuCn
 cgamkWjBu4MJQleu+sOe3q+SZvExI46oq40SXJpwYGNZPuRjrBuIZtp1JA12dklwUM4w
 /6Hp7zH4gS+xSeFur4b+MatwswTXhGgVS1+NgegXyj3fHXGdGKzicTZo6e1rIY22qBna
 cXUQMqEsVi8y/gy0zvhawapVAIgGJVnF0r+fV672KpYzPBbZB9XF5EXPmRd+EgtJdYfd
 QTLQ==
X-Gm-Message-State: AOJu0YzlDkhN1dD1n/uYXE0PQt1Hr05M68OfeMylE1virvaoCe6BHWFv
 NpGRb0DMmelGDeVoW88UGP0EjMNAz/2qJAzFf571anbXfxjAbxffjzzG3obb7P9Q+S4/qtkTNMz
 5bQ==
X-Google-Smtp-Source: AGHT+IG9V/3wcXRobw3JVKwex/ISt2dC/19BB+S/d/yDbDi27PxqtqAmMzBV+cpz1lcx9s0hFPnvzw==
X-Received: by 2002:a2e:3002:0:b0:2ee:46fd:7ab9 with SMTP id
 38308e7fff4ca-2ee46fd7fd9mr16655111fa.30.1719479975983; 
 Thu, 27 Jun 2024 02:19:35 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436a28f7sm1199818f8f.117.2024.06.27.02.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:19:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v6 6/8] fdt: Correct condition for bloblist existing
Date: Thu, 27 Jun 2024 10:19:24 +0100
Message-Id: <20240627091926.374633-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627091926.374633-1-sjg@chromium.org>
References: <20240627091926.374633-1-sjg@chromium.org>
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

