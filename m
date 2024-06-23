Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9EFC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BC3885E7;
	Sun, 23 Jun 2024 19:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gs3ntqzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4030188433; Sun, 23 Jun 2024 19:55:31 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0587D882E2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7eb7c0f9784so135777239f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165327; x=1719770127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEIyFClr1N2iZpbhFlJ046p2FxvzCXNHilvLmZrk4Mg=;
 b=Gs3ntqzz2MZqBHEZYTWl1gvg930BPFA1ohy1BOXmex6KvjgNnzpLrRhJsM3n6F4Xvs
 52xMkCtqG8151mrl3I7WutMHhqsdmau4DzC9Lj5+Cac+VMYmSS4jbMO7JRQbI7hJ28Nn
 8MhkW5k1lSlaM+4lUGIDZBVO93lmANm7nO558=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165327; x=1719770127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEIyFClr1N2iZpbhFlJ046p2FxvzCXNHilvLmZrk4Mg=;
 b=mGYUUMaf4vNjA3WyJc5tBBqVGAHkSuhl887lZgEm5BRRyD3+bFImFArYg5jj49FZdg
 dVywnSEnhUsz8KWcWSgNTKPVPIcO0jeRCJtrQPxeV2c1o81/WbjVxXbTclPiytYOXMQi
 6RVgpeKiGUceRHNa9hHAtDwbbSxTRcTz1jW7JvNJjm/3vhC9ijYRh8mcq8dVDamqDHGE
 isEsr0maY5rZ30sGYyqNUTjzMRu6jYP6Jkjoi6w7sNi4k1CcLApVihZoCaTlGMW4BfAM
 qDQUcBraup6WqDBiZjSqgURxi7pqLaO3OC46HwdMvcalFUBjS4guBocy+GS0P7JSE1dG
 SxiQ==
X-Gm-Message-State: AOJu0YzKlQYt7GrRrktzQAcYh8TEFWAXZ/WVc3pu7jMpFIJyvCTvrtc9
 iyBliVorMrCvSO6AnzdAvTdtTvSfnL4SPyhqvj6R/SPdU9+ZaXBu7wr1aqBz7/9Js5rMDvTNDqU
 M6Q==
X-Google-Smtp-Source: AGHT+IE4gdPvCaJiN3MRB88nL6mwWRCHoqHwUn9ZjaYBuMmD69rWcMnYANojvLGfHWD/Evc/uOIlhw==
X-Received: by 2002:a05:6602:13d4:b0:7eb:85fd:e29d with SMTP id
 ca18e2360f4ac-7f3a75b301cmr316233139f.16.1719165327665; 
 Sun, 23 Jun 2024 10:55:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/14] buildman: Avoid rebuilding when --mrproper is used
Date: Sun, 23 Jun 2024 11:55:12 -0600
Message-Id: <20240623175515.1466908-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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

When this flag is enabled, 'make mrproper' is always used when
reconfiguring, so there is no point in doing it again.

Update this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builderthread.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 0a7ff2e083e..c0b1067e3f7 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -700,7 +700,7 @@ class BuilderThread(threading.Thread):
                         job.work_in_output, job.adjust_cfg)
                 failed = result.return_code or result.stderr
                 did_config = do_config
-                if failed and not do_config:
+                if failed and not do_config and not self.mrproper:
                     # If our incremental build failed, try building again
                     # with a reconfig.
                     if self.builder.force_config_on_failure:
-- 
2.34.1

