Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8437C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1815887B92;
	Fri, 15 Dec 2023 05:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q8DoyhqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A0087B73; Fri, 15 Dec 2023 05:19:39 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7532C87B18
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b9dc3215d2so123569b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613974; x=1703218774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4Es7mvWIXU9TmKm/4NaYG4azuXUc37F3EDRjzHb/3s=;
 b=Q8DoyhqIAF67Actz5i8cOHa7eeVroAPfz6kPPx7R2XSfg1QDV8hYUMvqL0WdlUWL4W
 /UjW/1/sgdpTP0la6RUus+BcZGUzJsbrYraKi1RQz+MYxBLy5P1ghj9Jkfh63tEH+CIL
 OS+xWMkNLbfjWC2ObawwZJjBsHX5UHikn5xsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613974; x=1703218774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4Es7mvWIXU9TmKm/4NaYG4azuXUc37F3EDRjzHb/3s=;
 b=LzFuYOsfgsh1aoi9GRobV2JjICRkK9vjjesjjHW7A04ocE8V1zJgXBYtDibL4z5gBD
 jW/9dVEcPAfJMf1EgMsmfQFVm6en+JDM/dZ4dcOqDi+aHTskwnr7tWG5ClWWQxqHEDEj
 FQbjW3nBqodAOlw+Mx+X+Jj7mwBj16dPFkK+Hz4BZhzglO7Py0OmWtYiaEKdZ73l+co9
 ggRXUKIuQXXs6whXxs5r5XepWKhQW654r3j3jII7G9cqnEm/C3WKUdLSEyqZQ+RW9J85
 b0cO4ToPmSPmvRWvtADMKWolPegvmn8+xhvpUMoVG5qjn85rMeW6ZGi6JX5DpnsBrN12
 cJCg==
X-Gm-Message-State: AOJu0Yxcjx05ntYDTJAVBa0yG4u9W1XZq7/zOI5e+FUicfIODBSFoCv9
 XWTorhT8PbQsdJQscfyqnMq7jPfgDR5oFa8oatJ/IA==
X-Google-Smtp-Source: AGHT+IGpqSiDrLz5kQkVTE6fCMbUDSVoLdULoVg8KdDGTna/BAKIBGZ2DwtpEDspnnDbs9oskfOXkA==
X-Received: by 2002:a05:6808:3c4f:b0:3ba:1080:f8db with SMTP id
 gl15-20020a0568083c4f00b003ba1080f8dbmr7968991oib.55.1702613974722; 
 Thu, 14 Dec 2023 20:19:34 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 09/16] doc: Mention fastboot dependency on CMDLINE
Date: Thu, 14 Dec 2023 21:19:07 -0700
Message-ID: <20231215041919.2197788-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

The fastboot 'boot' command only supports running a U-Boot command if
CONFIG_CMDLINE is enabled. Mention this in the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 doc/android/fastboot.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 1ad8a897c853..933a652538c7 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -127,6 +127,7 @@ Boot command
 
 When executing the fastboot ``boot`` command, if ``fastboot_bootcmd`` is set
 then that will be executed in place of ``bootm <CONFIG_FASTBOOT_BUF_ADDR>``.
+This is supported if CONFIG_CMDLINE is enabled, which it normally is.
 
 Partition Names
 ---------------
-- 
2.43.0.472.g3155946c3a-goog

