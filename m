Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C73CC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA57F828C2;
	Thu,  1 May 2025 03:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="blRF071j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF58807B1; Thu,  1 May 2025 03:06:18 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD4B82905
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d90208e922so2392155ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061574; x=1746666374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezY/b/GCHqEMK7ja9BtUXOeWX/jxS84xJu5DwaubkJU=;
 b=blRF071jrtVSEGu/r1k+F975ANT6JXZuu/u8k8W4H/QBMyzGf9tbvKIae948i2WiRN
 b0DxtmXtD2a2GQvMYv4Ua3E5X5O9z+xcw9Vf4uCvVVIy3s7CuW2DPGyi6DBgz7md35z4
 VhKaX7H8cGbvGg9bZrGltf3JhM30umIPL1Iok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061574; x=1746666374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezY/b/GCHqEMK7ja9BtUXOeWX/jxS84xJu5DwaubkJU=;
 b=cGNmEtnC+PiB6SuQc3UD4UGwTvjEOlfjnUh1DzqdkYXEyzRWSbVBJoXf/9xS5BKQNI
 RdUTPIOeEQAmqaza0VkL8Mbr5nChV8cSpjoMovcQWZgo6rr++2nCmGSNFk2FD96IeO3L
 rGLvtdlEyAIScoEZQ+uymqvhpNzkjCyjglfqYy/rJHl2kMWP7dqDfhKE0SAmR2Jqz45o
 Ww9Yu0iek9yKDcsJgxxRajhBfRbn8j9s4Ooryj9rMdAPwYrE3xChp/M7R+uT6elNsti9
 6qMfUdj5bjsyXkppfOMXwFS6f06/jynPuwqWpq1T1ovWGXrgyPatKHwRPIk4sLuBRwJg
 xDig==
X-Gm-Message-State: AOJu0YxYs/Lxzec+RkbQcj+WLyPWudH1vVkDE4zfEHl8PgzmoREJ+TgE
 ajCJ63wTSZjSsffxIbfdt+jZOxOEW1n8zChsPVj+pzEJd3sDPEZBpkJVDZLAyeSTgjp9VqVTO0U
 =
X-Gm-Gg: ASbGncuMYsDCBkck2OBazZiGen5DcaG7BFT3xNuxyoLB6s3t+eqQN2ANM0OR+L/aFOe
 Wmm5P7cOlXXs7FXtW2lr1L4tDy6Mn3/cf31UuFw6Avet+K4GoeW9mzMyAQz5FJObVCG2XnHQhx7
 kgRyY3BUIz75M7vvqIXEPPMTWxyKQALKuj2KUS2bTjiTPGiFg6PNTScyWuY1rhJsAzIA2A03L5b
 FkZJEqnqWmeqrsaLA5WoN34eAcRD0AAD7orVFpGTqqCwEFso8tdMrMRyvr2bcepKMs/xRHYscGb
 alimYfGZ4bPbmHvMUOpbjPnRuwq4u/A2J/RkZYkOqGP1AzzJXZK0d3JVoFQZv/aCLJgkqHa7ecv
 4KA==
X-Google-Smtp-Source: AGHT+IHfsrhc3aZYAsdFg2C6n6FZ2KZUh4T+pkPhBUIZDHp7qR3KsCQcHIDZW2s1b91WYzzz/pSSew==
X-Received: by 2002:a05:6e02:3b81:b0:3d3:f27a:9101 with SMTP id
 e9e14a558f8ab-3d96f18d478mr19398985ab.1.1746061573824; 
 Wed, 30 Apr 2025 18:06:13 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:06:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Hanyuan Zhao <hanyuan-z@qq.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 21/22] net: dc2114x: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:46 -0600
Message-ID: <20250501010456.3930701-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file uses the environment but does not include the header file.
Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/net/dc2114x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 7c0665faa8e..8fa549280aa 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -3,6 +3,7 @@
 #include <asm/io.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <env.h>
 #include <malloc.h>
 #include <net.h>
 #include <netdev.h>
-- 
2.43.0

