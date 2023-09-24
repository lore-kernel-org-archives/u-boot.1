Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E0BCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2972C86C31;
	Sun, 24 Sep 2023 22:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nZojFsfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298A986B86; Sun, 24 Sep 2023 22:40:39 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DEC86B69
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34e25ad38cbso16983115ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588036; x=1696192836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbpdbeBkri86uHFiHDXhnFo6/gzQiLfcZTRi9608tzI=;
 b=nZojFsfzo/5ygt3uqHk0OVzEaCWi84X1VEs+UntOcmRHyoOcHTbG2MZFuKCIw+ijhR
 bneeZ4JcLYmFGLuY/inG282M4EMDiHf/Svs7UIl2DxhJLARo6/JaURTslJATsw3kwCAC
 1xPMbOVfN6Oyb2LOzPJJjg/EWkPTiopn95Uo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588036; x=1696192836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbpdbeBkri86uHFiHDXhnFo6/gzQiLfcZTRi9608tzI=;
 b=iZW6PShl1xEL07v9mnUslmhUJz+PZ6TX6sX0Oyki825M7jKsOif6B3PB0QAbdepfI6
 3rtg2utmVaHaOzBJSC+H0XtOrXv7PZ228va6RWOCDax35H66yGf185MHQZVCNfUuN2Sc
 Yk40zW7oxMOFfZ8mYoDunC2YgTEp+XRFwBD3uckvYa3Ef0F7ZUp4+1qp9GKMAlfmuoMd
 6Hvt7bXwslvLGmsrDegffq/TOZucsMWpScnxJL5EPabaE8KUstOCKBOXphY3eNZla4PU
 vBmT96eiKqHmzhA9M8f7+OSK+hoPIlWxXxNQXlF/BMyKgfGbRWC+GHab4nVUM745OyLF
 efcA==
X-Gm-Message-State: AOJu0Yxrx2oifClOAQZ4TTtAV3VjhkRn1ZNrdXAi/HaBenaqmqeSL5ih
 xUUUtPpB6+AoLD2DCCbAbPRsnwQefKmiG8B6Zow=
X-Google-Smtp-Source: AGHT+IHnck7hGWAdgPYrlgBAuiMRIuAJTd/97doOhvXOYQrxOq9HnhFQhl3FpRV7m39SsiWJo9HSGw==
X-Received: by 2002:a05:6e02:1288:b0:350:f37c:3546 with SMTP id
 y8-20020a056e02128800b00350f37c3546mr5435332ilq.11.1695588035852; 
 Sun, 24 Sep 2023 13:40:35 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 18/25] net: Depend on CONFIG_CMDLINE
Date: Sun, 24 Sep 2023 14:39:36 -0600
Message-ID: <20230924203953.1829820-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

At present it isn't possible to use networking without the command line
enabled. Add this as a condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig | 1 +
 net/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5f6834b335dc..c3428d19f31d 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1687,6 +1687,7 @@ if NET
 
 menuconfig CMD_NET
 	bool "Network commands"
+	depends on CMDLINE
 	default y
 	imply NETDEVICES
 
diff --git a/net/Kconfig b/net/Kconfig
index 4215889127c9..25d494e1db46 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig NET
 	bool "Networking support"
+	depends on CMDLINE
 	default y
 
 if NET
-- 
2.42.0.515.g380fc7ccd1-goog

