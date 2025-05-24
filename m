Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531E0C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0398357C;
	Sat, 24 May 2025 16:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jNvgUCoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C034835FD; Sat, 24 May 2025 16:38:48 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BEB82F67
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-86135af1045so73190739f.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748097522; x=1748702322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zcW/3TqyZ/bg/50SmYa3X9I2W4ECdPpQJqL5tDG42IU=;
 b=jNvgUCoau0myytxEdBIt5f7E+oCJewEP0s/OlEYTQhHasQ8ibn+b+gdfXJ3HteLL/p
 KOxxW5/GvwvjSPuZyktkek4byDur8ZVIsrOyIxGR7ONxy0AMiYr6pYQ7tz9C4x4Dyp13
 eN7CzYtq2L0ajRWltyjaCpnzwUzJ4SWYQS19Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097522; x=1748702322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zcW/3TqyZ/bg/50SmYa3X9I2W4ECdPpQJqL5tDG42IU=;
 b=NcKRjYUjKBKNdkNs1QyW4Nv4/PQc8a3EFACXmGC4u/PK0W9ekmLYlhMKUuqR8fPKPH
 doNh7Lc7l8HPYioYymBHHMJxKjBQx/u4IOdUy/AJUaeBbHKRN4yynPhiKYYmQVQYoWvA
 mpSzqpa4+UNLH6Mzh9B0ETCmvPeot9Y0AyPL3SznIlB3NR3z/TXQaSK/IHp6XHjI+tq/
 fF/lE3ja/NzglF7KX31nAvElhUjsOXFBw3wGwNN52ykmnQR7xo510j9W5dL6GRw+xVQv
 nxaFXN+/nMCrV81TFmwa5i8UiTwlSDEv9tOfdXXNgLlOvTHWECLHdZ2pn3YV3NfactI8
 SuOA==
X-Gm-Message-State: AOJu0YxyjJt6IJefnvS4NiUYUfZy2ISZLOXlZWUa03bzkMe3vQ9W+Qcz
 KHMUaYFcHGQAlzVQjmX2LV2SgKr36LapXyi4gzoUbyxzOH1wINRLz/IlHeW0zkaPXvoMAcPtCDO
 HnbEBzFJU
X-Gm-Gg: ASbGnctfdwd3kGJ1Pie1TRa3fFH70LoWtW90pZKrm8TpEVf9KLfpe5+ugiUJTksvEhr
 2fjqaRAn7ufb6nsHVvgcI6aimVcLWok1I7VU6AZrGa0R8WDPSCWK702G7ej1KRT1nqu7WyVkxuc
 noL4mAO3yHD0WWepKNjkvlZZErQcbBy1OmGvl7LB1bYQ5qo+BNt7oQ9KY9ECp7oKRmlPZrNsDUt
 d+h0nwkFOqp3eQ9OJTeA2Fy/AnOmhOPQHpyVtNenRT6BPMin4OHQhWDfG+zdQRqUPsHeckFQ21Z
 eSYcx7eAVOLDpuzofL/j/r+XqV/NSj7Ade1zGCsKTrzqwzxkW9Y3aoQnFxOqhCDHJwDJ8eKe6aT
 mqLiR8YNd9zgI
X-Google-Smtp-Source: AGHT+IHr6gsmwO+VpaB6MLJX5ksbrqw91Eoih/lRQP1B7PtdGz9rxEIz60RwinpmwoCxJ8CZGedv2g==
X-Received: by 2002:a05:6602:4a0c:b0:86a:93c:f5fb with SMTP id
 ca18e2360f4ac-86cbb7b7c38mr286547639f.1.1748097521983; 
 Sat, 24 May 2025 07:38:41 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-86a235bff42sm389321739f.1.2025.05.24.07.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:38:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] sandbox: Move FDT to a different address
Date: Sat, 24 May 2025 08:38:27 -0600
Message-ID: <20250524143837.1205231-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The FDT is near its limit and may overlap with the early-malloc region
if more things are added. Move it to a better location.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/Kconfig         | 2 +-
 doc/arch/sandbox/sandbox.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 1c8353d6156..a6b69fb5f53 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -75,7 +75,7 @@ config SANDBOX_BITS_PER_LONG
 
 config SYS_FDT_LOAD_ADDR
 	hex "Address at which to load devicetree"
-	default 0x100
+	default 0x180000
 	help
 	  With sandbox the devicetree is loaded into the emulated RAM. This sets
 	  the address that is used. There must be enough space at this address
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index a8b0d7f0395..f9e73c91fd4 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -658,11 +658,11 @@ that are mapped into that memory:
 ========   ========================   ===============================
 Addr       Config                     Usage
 ========   ========================   ===============================
-     100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
     b000   CONFIG_BLOBLIST_ADDR       Blob list
    10000   CFG_MALLOC_F_ADDR          Early memory allocation
    f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
   100000   TCG Event log              TCG Event Log
+  180000   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
   200000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
   400000   CONFIG_TEXT_BASE           Load buffer for U-Boot (sandbox_spl only)
 10000000                              PCI address space (see test.dts)
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: sand
