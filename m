Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2F5E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B2889338;
	Sat,  7 Dec 2024 18:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SXyToBxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6240289338; Sat,  7 Dec 2024 18:26:03 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36063891C3
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-843d7f16827so115333739f.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592359; x=1734197159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5u6BP0JIimx76IlHsUa8ckRXN3uBRnCokz7lYZmC5o8=;
 b=SXyToBxs6Z0RanUX3Bphgmst6wQSSDxJLJS8pbq3A2TD5a6ih4tTIpUpHbvpaG2xl4
 A11kI/5dIKQ7Kjlhpp/Kvn3Rct0AyhEcGGzNQzENhA8K0p9NLpGGC0+Zn7hV5FxJABe5
 0GQULPZ7CBUpDEQwogX9W4SUqK+Y9DP7qlGXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592359; x=1734197159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5u6BP0JIimx76IlHsUa8ckRXN3uBRnCokz7lYZmC5o8=;
 b=M8PqR/Dtbm7SCv/w37cyjToYFFJz7WgqZOvbzeVfTFK5KYBOHm+AlHD9I5CXqZFN0W
 THAMN5HXMmlfs5d+mFuVvU5In6J0KLelP+n3RFlj2g5hMTZt/N/3TvQtusX46aQGAwQ5
 BnWLLKue2wv7drW2m0dLwz3M1stgGOT6wKwEq5iIP584xL/A94KbmHrG3N/6CbD4oq3o
 8ghBVRJrjB494+dc9L/GELYDlAF8mepgdeCzRiaC7KvxHzAB207uN0KgH5EHw2f76Tc6
 1AzmFJ1fx8bPJ4I1x99pgSFLGwJ6+0d3d6HCtSej5d03IMC9NYXaTm4zIo3i3LLVnIpy
 peHg==
X-Gm-Message-State: AOJu0Yys5Tgs4J3ZKBwDsr8SDH8yqCvLd1TMBCh+BT+lChbrDG8KFdlT
 LZFvFNELYgUv6zPt0yzf/QBYxRc76SRn3J37qYZyA77djbZ36rT78gC4pwYhS5HWUdZ0M4FrdiE
 =
X-Gm-Gg: ASbGncspRwKQ5ET9ZrItFXbFIcTiFf6TSesDxYZxo3ePijOF2mf/wDgWnhima+J54+e
 cLTVUfJB8KFG7tYiv/alB6N6teNAopXZvw2Az4B1Nj0KsgCy6I3VdQGtPO1871YSZZ1okRpeNsf
 ToCWTr6U34GYlM04kuvKfykVO0uHxa1hjsuwBpIxwvXEllvRabzqM1TLuotAAD4N1UlpQW3zRye
 Qjugr94uxzHEmwnfO3YHq1LEZJrw7KGx2BeDfTiAcUULj3IyVp5tMepICUgs04wCcoyeMa8koyL
 Jbdjj587C4U=
X-Google-Smtp-Source: AGHT+IHJHB2QpjUelSnsb+o4+kZGtyxpcNJyRW60CW1uqYCwFK0EKLY0etcFLKOb7YtHq2T1jJ/AYQ==
X-Received: by 2002:a05:6602:6410:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-8447e212591mr843495439f.6.1733592359476; 
 Sat, 07 Dec 2024 09:25:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:25:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/19] spl: mmc: Avoid size growth in spl_mmc_find_device()
 debug
Date: Sat,  7 Dec 2024 10:23:54 -0700
Message-Id: <20241207172412.1124558-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

The for() loop ends up being in the code even if the log_debug() does
nothing. Add a condition to fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to avoid size growth in spl_mmc_find_device() debug

 common/spl/spl_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 1f696593216..fe4230170a0 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -81,8 +81,10 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 	struct uclass *uc;
 
 	log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
-	uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
-		log_debug("%d: %s\n", dev_seq(dev), dev->name);
+	if (_LOG_DEBUG) {
+		uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
+			log_debug("%d: %s\n", dev_seq(dev), dev->name);
+	}
 	ret = mmc_init_device(mmc_dev);
 #else
 	ret = mmc_initialize(NULL);
-- 
2.34.1

