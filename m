Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE35ED1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D57DA8910A;
	Mon, 28 Oct 2024 13:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FbdC0raQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA32089117; Mon, 28 Oct 2024 13:41:54 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C882289099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a26a5d6bfso653463866b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119311; x=1730724111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiB74drxioaOZsywEIGdcAOpMQ3ZcTGnFS/HQvM8m9M=;
 b=FbdC0raQ8ZET3g7GDf50CdG9TuRP6l77dN6Cc+F3saS7p2xXT7esWhid7AuNtdgz4M
 Cc4+pmcIs0QhtFTNuQRb2EQ9qyg/adyRL6zG2FlI73LNBaTVXKVxKT2GyrKgwZ5ZRcaw
 XzrGOPwtnpD64le7EUuwPaLMI2vfabyvNjDuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119311; x=1730724111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SiB74drxioaOZsywEIGdcAOpMQ3ZcTGnFS/HQvM8m9M=;
 b=Ar7xauAs2RFXHPmEyeSKnBB6F/pT8WYDIIIA8Sc1L/RMIg9A/z+fHGblsveu8hs99z
 8LEfMK3qjuww66vGZqJdB+embutkGD5v9NXPgTL8Il3hvkvp/TQOSKLrYuWq0EHuVinN
 6PY7bQDcrKgHU4Y7sOI1WLfbnuaZu1QDMHJiHdOnaba9MIpGHjddI/54HG9/EVKbcw4n
 +9CtUBNCxO8vEGK7nTVCU1FqRVQVTLxzxQX21SjhCFepvkoEzWruKft+dsbMF3mwiDwn
 JiyIUDU23n6ljnxsIK73OMJJiLetJc4exz8XhbklW9IjfeGBhemJdWPlfFzXN9wF+iKK
 vcyA==
X-Gm-Message-State: AOJu0Yzt9Q0MQdeqoPlA+sJ97Yt3R3ClG+cWSjs7hXq8mZWNeZUr0xfM
 pCjNZjGQUpCqQOcWgDL3OgEJWOYCK0t9DCNhP7j8Ne4tgc2CTiNOrfbr+vWkd4HFqY1s5DwHDb1
 nYw==
X-Google-Smtp-Source: AGHT+IGyCHf0fCse24maGWME+YV1zJQK8rHTtOITpNxQlpnLVoGBcdvH9ttJTCy54VRFYRVsDQrzcw==
X-Received: by 2002:a17:907:7e82:b0:a89:f5f6:395 with SMTP id
 a640c23a62f3a-a9de5ca0153mr742267866b.1.1730119311464; 
 Mon, 28 Oct 2024 05:41:51 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/21] bootm: test: Move test into boot
Date: Mon, 28 Oct 2024 13:41:15 +0100
Message-ID: <20241028124130.32072-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the boot/
directory, to match its implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Makefile           | 1 -
 test/boot/Makefile      | 1 +
 test/{ => boot}/bootm.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{ => boot}/bootm.c (100%)

diff --git a/test/Makefile b/test/Makefile
index 283d97012cf..4366e495a15 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -4,7 +4,6 @@
 
 obj-y += test-main.o
 
-obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
 obj-y += dm/
diff --git a/test/boot/Makefile b/test/boot/Makefile
index d8eded20d4f..4b5e8a692c9 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_EXPO) += expo.o
 obj-$(CONFIG_CEDIT) += cedit.o
 endif
 
+obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
 obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
 ifdef CONFIG_OF_LIVE
diff --git a/test/bootm.c b/test/boot/bootm.c
similarity index 100%
rename from test/bootm.c
rename to test/boot/bootm.c
-- 
2.43.0

