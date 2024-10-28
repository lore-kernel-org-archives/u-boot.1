Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA746D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A88C8912B;
	Mon, 28 Oct 2024 13:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cg2s5FZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD7B89145; Mon, 28 Oct 2024 13:42:03 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6D689102
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso8510275a12.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119320; x=1730724120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL+eAnu4qxGgF/JEbsMBF6YyG0hBxPUGgSA8oC2cIfU=;
 b=cg2s5FZp07sZwSgxOuhSv+iXlcai+loi7JYkBANUQVbQjbH2n19Sy+KgfhfmxcvClB
 LoV17LggfQzqdq79XU4p16nV8wi96wWCLgv9OFrflvIyuyyUhunt2cxMyu1U5qnPTYtl
 Th0O/0ZrLiTCbmegVASyhxAzINKt9hr08flHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119320; x=1730724120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fL+eAnu4qxGgF/JEbsMBF6YyG0hBxPUGgSA8oC2cIfU=;
 b=dFX0ALTcf7SRNJtubkNOcoO0+h9VgUInScyRs0oQd9UV2vc9EmO72PFtKoTWlR3YWS
 ++tMsv3HZnk6nydZmDAXQxzIAyn74PopNAgz0pE9LrFlND6ABiA0WQLY9xCUtt8YPgBQ
 OjCSpR+JyHe1/Dn9l/gqwfEuFtkWr96hvqnN2joYRKjImpiQ6LDU04N73JyE3AQtHzNm
 2v7J1TS7hA4yFmEiFPILhukpuvWS5PJTgy+evx5Q19JHDZK4oR/DhzRKj9rQBv7hj4Tf
 rGZWsqNiC5I0EVZoUpBnNUNj/3bdK3DkRxkbiu3cHNqJCWweoQDqUiYVuK+qtx9mWyol
 hwtQ==
X-Gm-Message-State: AOJu0YxMHMcRcmPrU/SIefdXEGURoDdAbvA+8dBYlsq88PuBMra/nBti
 OBC42328gmHSvazpntT4SCLc5u4H+CoMsnNWci7a/KpU/yxrNbWuv6sm4u+ezVeRZUuhNCXEzl6
 6gA==
X-Google-Smtp-Source: AGHT+IGWUwGmnVu8k25ri8FG1oSH9L/GWk0kUVUuuixDm/6b8iFnFH/KUIHRGi+XipHZ5LP98Dt/tg==
X-Received: by 2002:a17:907:1c85:b0:a9a:662f:ff4a with SMTP id
 a640c23a62f3a-a9ad18272b0mr1612523166b.0.1730119319860; 
 Mon, 28 Oct 2024 05:41:59 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/21] test: Move unicode_ut test into lib
Date: Mon, 28 Oct 2024 13:41:20 +0100
Message-ID: <20241028124130.32072-16-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the lib/
directory, to match its implementation. Rename it to drop the
unnecessary _ut suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Makefile                        | 1 -
 test/lib/Makefile                    | 1 +
 test/{unicode_ut.c => lib/unicode.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{unicode_ut.c => lib/unicode.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index 220a249c397..0b1affcf445 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -21,7 +21,6 @@ ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-y += log/
-obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode_ut.o
 else
 obj-$(CONFIG_SPL_UT_LOAD) += image/
 endif
diff --git a/test/lib/Makefile b/test/lib/Makefile
index be20bbc047f..c36c8b0917d 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_AES) += test_aes.o
 obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
+obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode.o
 obj-$(CONFIG_LIB_UUID) += uuid.o
 else
 obj-$(CONFIG_SANDBOX) += kconfig_spl.o
diff --git a/test/unicode_ut.c b/test/lib/unicode.c
similarity index 100%
rename from test/unicode_ut.c
rename to test/lib/unicode.c
-- 
2.43.0

