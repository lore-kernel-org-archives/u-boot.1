Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BF6C71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BA282CFA;
	Wed, 11 Jun 2025 22:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NLbB9jE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E848828A2; Wed, 11 Jun 2025 22:25:17 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7273D82CD2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so1342745e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673515; x=1750278315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDueBkdFPArmbo9xyYSwcVMqBU+ZAegSrjoUIKHVOVA=;
 b=NLbB9jE4a63LJ6ry8lv8ary93guz8PaHh5hDs/PW7Yyo9ZfaeZQ3kXHx/j170JG7df
 SM6g83RtRuuPCm3fVOVnU+TA6O9bwL3wtdZtLfSPzLCePhOagBpSlaw2ULfNoZAZ2sZt
 B2GwKnXbrluwvQDknI8HdwwkN4DZcW3EetDzpC+7ESH4fZLOguvYXp+f4Ere3eNl371n
 r+z03YBvyf2QgNTuCMRcm9WvEAlE22iYtAjdqyWguzPI+0vW1qjLpXjKa7sT0SubGO/D
 TW9+uOMXyTH7JWAZhs/YOI38cOISR4TxUWo5FbKqGs1KsY3dMiK2r9QpdwjdMprlq4Oz
 fQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673515; x=1750278315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDueBkdFPArmbo9xyYSwcVMqBU+ZAegSrjoUIKHVOVA=;
 b=aqIkkWHdsZd55qYbrxJcqGobHIYFfqdy6WVT+vOA7igU8SMY7lgtV8h4N4ZIvsRiiY
 JqNlTiJ9shcZ5B6pCZLDBMka/EJdx4Ph0UZaQynZUjhTn/ZGdb8RsThTM34M8CBEJEqt
 hJDAtKjnE5sO3lNptL85AqBE0eNyxAfpO0QZfasyOlEyLJuTR0mUsq9jjGj02U1065zB
 YzMiGWZJNz9FqiQc36C1oSUarFFEl1WDmbQmdta7Ft9phlo8a6V4rkIZuvXuJor8Lnb7
 9oe28/y014RfCdpACUvV6XTXezK//ul8rUPQpquRCKEP/3Gkta+Gb1UKcgrFNdNMoBkj
 Svtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJt0y6ltkkFGmkwwjWOAnPOb3MV/sUDVwB3O5pRVIql6r84KbVWbJy3k8h125P29qhH/nBJ5k=@lists.denx.de
X-Gm-Message-State: AOJu0YzikO41DE+YzDV36h8NZ2sh7XnGLcNd6ySh2tl+qut6amn3Bm19
 G8wbe67zw/fY4wFPBgxeZYrfm62hbL3rIOiL/zQvj4NWomcU73VWf8xnj+lQs7tLfnI=
X-Gm-Gg: ASbGnctAv2ZBuAaNXtNI+jfUmhNGHw8PVOIL53UjNXeYODmXweX1FG9He6QnwGCQDbK
 eoH5DsWLwWQds6xoNetvCx1I5dKK8cgAWh6MDh8m3EvehNVvBNltSArKDLCdbw2iDessSLoYIA7
 ghHEiA/9xvnImsLHibfL0GfT/5Y1IKArRz/zQoDtUmufWhhbQz0YFT1VdKObtYCsUXdlBDITlxt
 BvLqJpTaw8F6WXNCQHZ7LJ8m1BfeHE6XawVU1V2YAsHeklruUTv9FHux7GY8W1A8kmQqiMfLSVh
 Ew9JddT3ndM5k6XtpZjUMl3/BOleU4BJob9L2w28X9W0NlMiFnCeSfmgfxVNSzSWicTrHS5am7e
 GZEBqZMTBp9OrwXSsBd/uCEvyj6TFtnSFJA9R5F4E
X-Google-Smtp-Source: AGHT+IExOjajrghhgxcHFu0HFSKa4hhTaSA97JSC9W0yrGmYAFv5miZlx63m/hsGNwuxeNW15ViLPQ==
X-Received: by 2002:a05:600c:8012:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-4532487a6b7mr48524785e9.13.1749673514910; 
 Wed, 11 Jun 2025 13:25:14 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 09/13] kbuild: do not overwrite .gitignore in output
 directory
Date: Wed, 11 Jun 2025 23:24:36 +0300
Message-ID: <20250611202449.2317279-10-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 156e7cbb3ef5 ("kbuild: do not overwrite .gitignore in output directory")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f05c70073b85..5dad1aa57f70 100644
--- a/Makefile
+++ b/Makefile
@@ -519,7 +519,8 @@ outputmakefile:
 ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree) source
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
-	$(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
+	$(Q)test -e .gitignore || \
+       	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif
 
 # To make sure we do not include .config for any of the *config targets
-- 
2.49.0

