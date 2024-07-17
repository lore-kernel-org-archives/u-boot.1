Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731CEC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9E388A4C;
	Wed, 17 Jul 2024 10:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kuUXvl3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC2688A6B; Wed, 17 Jul 2024 10:31:28 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5021F886E5
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36799fb93baso3890577f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205085; x=1721809885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNoOt5PguCcBNLvXXO7pgo72MDpPKtDUlw274PpmBpM=;
 b=kuUXvl3TUrjMaZBRJAto9LoUja3Y658/eSYPPd3ZQWrAYB6x6rNhhpQ/P0oavESv7j
 rrvh9ods4duE3EDcnX1RnbKxlrei/wHIAZMbgqV78+NHxguXycOySiHsTe5di73n5e2l
 ap03mMwMBpYrF3RuiFt5xNwK0ev50u3YKrdr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205085; x=1721809885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNoOt5PguCcBNLvXXO7pgo72MDpPKtDUlw274PpmBpM=;
 b=l3AeMhv0AcDnH/bdDFUoFk6+7p78bmlBMoIqFP18JDCQj5YyyWzRjc+mK9mvRdYN2e
 QTjf6WNmnw35C1iGY5gMWx48bSTqD+Oa/1L43pfURjcDL4JW5AmRuuV8xSU/tfrZvGUH
 oLBvstIQGAOT4yylI0uUGt4bP2inaqxA8OqdOZshA+wNlbi5U8JW0++LEGBczV4iSbdX
 6GHg8zk5wVlma4mJL64Nvx7Ko2Ui5gVc0oiCvEK3ASZNWU+OQ653pw0j7XIt9Mj3W3ro
 59qW6FQ8HVaJPCc5hW3wia7p78rQ0DlB7tMZOu4TCdZF4is7XNtQtW8w6QZcrigrml4T
 j+yg==
X-Gm-Message-State: AOJu0Yyv7nQiv+QVNg61YknaeQtCqZtaGGIhwdwhnP0KDvB9KP4Cj1wf
 TkaJQj1FTQEcHK7kj5woBuDxeYz2Cu/i5VcHN+vY8jetk0yczgbR2UYdkZlwdRNz6p9sMd9AB6Q
 =
X-Google-Smtp-Source: AGHT+IGe3euFtwYwjN/FKY329HRcnBv1Vjhwm5RpuH9H3uIL+F6hooSnoP7KHNE4ConkcSlIQqMCNQ==
X-Received: by 2002:adf:b647:0:b0:367:8fee:443b with SMTP id
 ffacd0b85a97d-368316f5e94mr816540f8f.41.1721205085705; 
 Wed, 17 Jul 2024 01:31:25 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 14/14] doc: Describe the bootstd settings
Date: Wed, 17 Jul 2024 09:31:04 +0100
Message-Id: <20240717083104.1963431-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717083104.1963431-1-sjg@chromium.org>
References: <20240717083104.1963431-1-sjg@chromium.org>
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

The bootstd node provides some configuration properties. Add these to
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 doc/develop/bootstd/overview.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 4a55b7da00a..d92a649beb0 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -406,6 +406,19 @@ You should probably also enable `CONFIG_BOOTSTD_DEFAULTS`, which provides
 several filesystem and network features (if `CONFIG_NET` is enabled) so that
 a good selection of boot options is available.
 
+Some devicetree properties are supported in the bootstd node when
+`CONFIG_BOOTSTD_FULL` is enabled:
+
+    filename-prefixes
+        List of prefixes to use when searching for files on block devices. This
+        defaults to {"/", "/boot/"} if not provided.
+
+    bootdev-order
+        Lists the bootdev ordering to use. Note that the deprecated
+        `boot_targets` environment variable overrides this, if present.
+
+    theme (subnode)
+        Sets the theme to use for menus. See :doc:`/develop/expo`.
 
 Available bootmeth drivers
 --------------------------
-- 
2.34.1

