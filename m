Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99766D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16098909F;
	Mon, 28 Oct 2024 13:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fuWVwn5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60459890B3; Mon, 28 Oct 2024 13:41:41 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7C189098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c9428152c0so4926950a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119298; x=1730724098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nybyNbpjpq7jOmKtgwcICbCa66i7HO4mSFcFqFffh4=;
 b=fuWVwn5mpto1R9ZGotNcJr/qM56o7Ny3ygEStT7AHycVlqDNe/LoAQHpIeKJJTXWAh
 8C1M6ekGL2wSdWNKiNsLLANKewZNvoyzmpJlo5ySOh/0YtX+GG4nxB/jhMJsUWnfsGPD
 mo5rCc4tUuEOQxv2p5jUC2s4usMjgIX4bcrzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119298; x=1730724098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nybyNbpjpq7jOmKtgwcICbCa66i7HO4mSFcFqFffh4=;
 b=uDFonzC3e6KualwlqozZnLKucdqTG6qLkyU7kay/wpDMIItE6xTIBOuNdTnloWXa7e
 CDjmH4BaysAxZ/LFwkVEP5TOCC2uiS8+Jdc0xVZmy7Xi2r1+V9A7vlJw+NpEuhq6ELLx
 CShYdE/MN/qjeK1ZghxpWkN4VzPdOcl2Q4UaOlROpxlFN6Vbf1qx+3QBBGjYLAf5cWkA
 tVSRhaur3WY6aqahfHeTu+0VdlgAlW/aYd+rzp5dH2y5uVsvLIQdZ3RgWpE+SuuAmxb9
 VPTwADnqNL20fZz6STegBj/OBETASjhgi8CnctIXuPNf7bPkP5u+OvyMTQEU/DXuc2D3
 0dRQ==
X-Gm-Message-State: AOJu0YymesGglaMtKH2mJRPOL9q1OgUREoRDkEr28xmjvZaXugeJt5j6
 r/bzYHwXLxVKyLq6GCGjk7MmMFdmvWUr0hBJJyhLFbl44ScpyXtuWsUBBmM92TIAOSxkcBJ8ULp
 8Kg==
X-Google-Smtp-Source: AGHT+IEBPf7XRpqgpd2I19wNO9hpGaGotxZ17EcaQNkDAwsTpiVMt5OkoGK9GHhnQ0mVZ2YNExE4/w==
X-Received: by 2002:a17:907:1b84:b0:a9a:bbcc:508c with SMTP id
 a640c23a62f3a-a9de5c91a6emr574424966b.2.1730119297577; 
 Mon, 28 Oct 2024 05:41:37 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/21] bloblist: test: Move test into common
Date: Mon, 28 Oct 2024 13:41:06 +0100
Message-ID: <20241028124130.32072-2-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the common/
directory, to match its implementation.

This also fixes the build rule for the bootm test, which was depending
on bloblist by mistake.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Makefile                | 3 ---
 test/common/Makefile         | 3 +++
 test/{ => common}/bloblist.c | 0
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename test/{ => common}/bloblist.c (100%)

diff --git a/test/Makefile b/test/Makefile
index 145c952d2c3..2beff431899 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -4,10 +4,7 @@
 
 obj-y += test-main.o
 
-ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
-obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
-endif
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += command_ut.o
diff --git a/test/common/Makefile b/test/common/Makefile
index 12c65f8c951..b6bff9201ec 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-y += cmd_ut_common.o
 obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
+ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
+obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
+endif
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
diff --git a/test/bloblist.c b/test/common/bloblist.c
similarity index 100%
rename from test/bloblist.c
rename to test/common/bloblist.c
-- 
2.43.0

