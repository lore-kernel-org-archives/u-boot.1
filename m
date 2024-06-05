Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89283C27C55
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5ABC88354;
	Wed,  5 Jun 2024 05:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZcnAoJ29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4764E8831D; Wed,  5 Jun 2024 05:26:44 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D42888260
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7e238fa7b10so266619239f.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717558001; x=1718162801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngcYL01ZVBNa2KTdKhaJKl3V2rTn0y1GTNdVJcXa3eE=;
 b=ZcnAoJ29Ommku8kd5nnK48a0PU0aq/RiiL2PAO9JTNzifxUJxb7q5kOzjnFBwJqkjF
 TY94gxrAeW6USrlO6dZVwvhMoVCc+jb23DH0TBVImq+Cv1TG4b1iLLcSl5ENivWEanod
 4MhZNWLeCwag9fxNVDl1FBc+qTUocxzwnnN2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717558001; x=1718162801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngcYL01ZVBNa2KTdKhaJKl3V2rTn0y1GTNdVJcXa3eE=;
 b=rbD+7yIxrF0dngIGkilQ2JR2CwOFBEeOnrEtLSQLmecP+WY+nMnaTUd3lQNj1QYoye
 Tj6YQvsrQCheT50+Xj3mlyjfQKnx2jqXr4VhcQdB2PMH6AaOvncCeAmGG/sQ42PPMHpv
 GHMe+T95Qb3yixL0uZHR/r6ZNsgXJEhshs2Zu4fIYARRXE7Ev55UPjlolzVD4Q6RPTkS
 vXY/jiX5ina5adoHdwvwMQHqoY+6oWsAiKz3tVTD6mwphMzMm+5HX+ZMQg/A5Qar9KT6
 F+iQCPAR5YM3hRQvwLbVZjLD7owxUoz51E/Xj5npyPdGewKRl1EIKTJVfS6Iy9OVwA0+
 K5mw==
X-Gm-Message-State: AOJu0Ywl+FKIJfD8Bxh9W5/HVvD0VXNDuLHOZpzIB1x5o2rhsedm+/d3
 HpGBgRRcd9hjmLtTS/RU1oUZzkPfqLadvaVNB5Bl+6a68fySU5FGjDNP1wlD3E6C7T5eK4URqjv
 SBg==
X-Google-Smtp-Source: AGHT+IG477YnsXOoTcKxxQ/S5rUMcsAcgmH5v0efIr3QoRerO2xn+Zdcg30cir5Z5tHuKyyoDJ/i5w==
X-Received: by 2002:a05:6e02:1c84:b0:373:2ba9:4274 with SMTP id
 e9e14a558f8ab-374b1f65fb5mr12711475ab.30.1717558000692; 
 Tue, 04 Jun 2024 20:26:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 5/9] fdt: Correct condition for bloblist existing
Date: Tue,  4 Jun 2024 21:25:17 -0600
Message-Id: <20240605032521.1142768-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
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

 lib/fdtdec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b2c59ab3818..b141244e3b9 100644
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
+	 * The necessary test is whether the previous stage passed a bloblist,
+	 * not whether this one creates one.
+	 */
+	if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
+	    (spl_prev_phase() != PHASE_TPL ||
+	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-- 
2.34.1

