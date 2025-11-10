Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87950CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7D783A47;
	Mon, 10 Nov 2025 13:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="my6kS5kg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B41A83A47; Mon, 10 Nov 2025 13:48:11 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E7C839B7
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-297e239baecso16250965ad.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 04:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762778887; x=1763383687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rjZneO1ABHVCMD35CV6fJQCVw2KRWnXV7yEsVvaL4Fc=;
 b=my6kS5kgBQ45T0RbM4evj6omSB/Txt8KRUlC8DebGzpn2WktwlQeSFBrZs75jLMFdF
 ZrvQH7kJD5CiVnamAtowaQD8Q2Z7++qllGGQzFXn6Lib8L5nXcwOpCYKlWUM/tNjHQdH
 V0Qv+N89OCYrm8fsH5QheebrsWR54nW2UT9pSqCc64GdVlHzcDaalYJyXiz/Us4ooh+7
 eYzs9ZnT35SgHfeGTmFy4cKyIHliaoqTvsFMmS1XSR9lE6iQDWyvbnK3Lf7HvzNPjjJx
 FeRKP2Krje+a1YGZ43Y6o235IAUq9Bet6ajbdHXEoisLCkxuNXeBw5YvdrTqBNSczy1f
 lckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762778887; x=1763383687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rjZneO1ABHVCMD35CV6fJQCVw2KRWnXV7yEsVvaL4Fc=;
 b=HRySeMAdnaSA3t6in2io3R8nTEVm4lUVAFX+Lw6YGkLZeFPYbP8CVYLiNy6MzNCUyX
 uY/5cl+VDyQ9fWggsWKLwv3bkeuUN8THzqLbH9SPdXC5q606fZh8nc5gK+YM4+8vE6v9
 ijEvGs2ssvRtWwyGA8Ql9Pz0x8m7GU0dPIBqH5AZ9mMY9RIS/oeKzUldF0SY6DMTt/L0
 rnwkEt+nAGKnePsq+Ggyaw64qvK6g5WUammEAUzkT+l1N1pIS6mz5R4VNtlj+nIkBnEl
 bIoF3LAZc/gK4E9+JXUqgh6W+EtF5EpvaSeGifp0FYRbPucOVY/uyDEP8iBYAmfdUhGx
 0myQ==
X-Gm-Message-State: AOJu0YzOlcb9QGzNZNfOewdjttnDXVrMg2lsHhpnTizQf3PVcFYCE9CR
 aLBy5YRTcGNKg+8jntbsMga73H16nekUJ2JJ2to4mDrzLpUbv11Oz/t4ZR1El/jo
X-Gm-Gg: ASbGncuHzO/vankWEHQNoJpeJCr4T7MjJ2eH2G/GMDHiiekeyMncz96Fy6xoX9jQDdn
 7F7tXuqUAvm7/2sf/96zuc84IRznWOpRN6uxL/3SlF4vedzgP7sBUqOUwZOHBEa1wc/xpBbSh4/
 H0lTojBAtLDfQZX1PzuIM0XVywAV4OheeVU0ZYx4+8GKNigeUJVUNVjoBJM0hAw+OeODUzC/zD8
 4YqlkHaFZkdry5aHefb65srbElQoU65Cgy7aggFLnMDa3kOdNqwEaAlRh0sJjCA4Nlkrkio/Ggn
 NOU8SdFktzDIAP0aUwn7C0x7itt2oRiIxJohsnzchLnXJSfDeAGCfVGXcILR/HPjMXJDgf1hsyB
 hS0aHXucsrC3voBLZ7VVSHSTRgowo1/uMvXdrhFQVxoHMIicRfu+KYWXiRvfwvksRwskXTRZKYQ
 ybs0xoJw==
X-Google-Smtp-Source: AGHT+IH3plVNNjuRPUQhPb81JGFiYgAlZgDOwR3s3aN76+o0exU3joULHR+GkoavOA9Ia1nh/+EaQw==
X-Received: by 2002:a17:903:37cf:b0:295:134:9ae5 with SMTP id
 d9443c01a7336-297e1e61caamr94385405ad.24.1762778886956; 
 Mon, 10 Nov 2025 04:48:06 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ccec04sm145345885ad.102.2025.11.10.04.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 04:48:06 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] bin: Rename QEMU arm* conf files
Date: Mon, 10 Nov 2025 20:48:00 +0800
Message-Id: <20251110124800.1642591-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110124800.1642591-1-bmeng.cn@gmail.com>
References: <20251110124800.1642591-1-bmeng.cn@gmail.com>
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

Use a hyphen between "qemu" and the architecture name for the
"board_type" field in the conf file name, and indicate "arm64"
for the ARM SBSA virtual platform.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

 bin/ellesmere/conf.qemu-arm64                                    | 1 +
 bin/ellesmere/conf.qemu-arm64_spl_na                             | 1 +
 bin/ellesmere/conf.qemu-arm_na                                   | 1 +
 bin/ellesmere/conf.qemu-arm_spl_na                               | 1 +
 bin/ellesmere/conf.qemu_arm64                                    | 1 -
 bin/ellesmere/conf.qemu_arm64_spl_na                             | 1 -
 bin/ellesmere/conf.qemu_arm_na                                   | 1 -
 bin/ellesmere/conf.qemu_arm_spl_na                               | 1 -
 bin/travis-ci/{conf.qemu_arm64 => conf.qemu-arm64}               | 0
 bin/travis-ci/{conf.qemu-arm-sbsa_na => conf.qemu-arm64-sbsa_na} | 0
 bin/travis-ci/{conf.qemu_arm64_spl_na => conf.qemu-arm64_spl_na} | 0
 bin/travis-ci/{conf.qemu_arm64_tpl_na => conf.qemu-arm64_tpl_na} | 0
 bin/travis-ci/{conf.qemu_arm64be_na => conf.qemu-arm64be_na}     | 0
 bin/travis-ci/{conf.qemu_arm_na => conf.qemu-arm_na}             | 0
 bin/travis-ci/{conf.qemu_arm_spl_na => conf.qemu-arm_spl_na}     | 0
 15 files changed, 4 insertions(+), 4 deletions(-)
 create mode 120000 bin/ellesmere/conf.qemu-arm64
 create mode 120000 bin/ellesmere/conf.qemu-arm64_spl_na
 create mode 120000 bin/ellesmere/conf.qemu-arm_na
 create mode 120000 bin/ellesmere/conf.qemu-arm_spl_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm64
 delete mode 120000 bin/ellesmere/conf.qemu_arm64_spl_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm_spl_na
 rename bin/travis-ci/{conf.qemu_arm64 => conf.qemu-arm64} (100%)
 rename bin/travis-ci/{conf.qemu-arm-sbsa_na => conf.qemu-arm64-sbsa_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64_spl_na => conf.qemu-arm64_spl_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64_tpl_na => conf.qemu-arm64_tpl_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64be_na => conf.qemu-arm64be_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm_na => conf.qemu-arm_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm_spl_na => conf.qemu-arm_spl_na} (100%)

diff --git a/bin/ellesmere/conf.qemu-arm64 b/bin/ellesmere/conf.qemu-arm64
new file mode 120000
index 0000000..312f519
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm64
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm64_spl_na b/bin/ellesmere/conf.qemu-arm64_spl_na
new file mode 120000
index 0000000..112a3d5
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm64_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm64_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm_na b/bin/ellesmere/conf.qemu-arm_na
new file mode 120000
index 0000000..d103ff9
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm_spl_na b/bin/ellesmere/conf.qemu-arm_spl_na
new file mode 120000
index 0000000..aee911e
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64 b/bin/ellesmere/conf.qemu_arm64
deleted file mode 120000
index dee6855..0000000
--- a/bin/ellesmere/conf.qemu_arm64
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64_spl_na b/bin/ellesmere/conf.qemu_arm64_spl_na
deleted file mode 120000
index abbbc02..0000000
--- a/bin/ellesmere/conf.qemu_arm64_spl_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm_na b/bin/ellesmere/conf.qemu_arm_na
deleted file mode 120000
index aa91a9f..0000000
--- a/bin/ellesmere/conf.qemu_arm_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm_spl_na b/bin/ellesmere/conf.qemu_arm_spl_na
deleted file mode 120000
index e171c5a..0000000
--- a/bin/ellesmere/conf.qemu_arm_spl_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm_spl_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu_arm64 b/bin/travis-ci/conf.qemu-arm64
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64
rename to bin/travis-ci/conf.qemu-arm64
diff --git a/bin/travis-ci/conf.qemu-arm-sbsa_na b/bin/travis-ci/conf.qemu-arm64-sbsa_na
similarity index 100%
rename from bin/travis-ci/conf.qemu-arm-sbsa_na
rename to bin/travis-ci/conf.qemu-arm64-sbsa_na
diff --git a/bin/travis-ci/conf.qemu_arm64_spl_na b/bin/travis-ci/conf.qemu-arm64_spl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64_spl_na
rename to bin/travis-ci/conf.qemu-arm64_spl_na
diff --git a/bin/travis-ci/conf.qemu_arm64_tpl_na b/bin/travis-ci/conf.qemu-arm64_tpl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64_tpl_na
rename to bin/travis-ci/conf.qemu-arm64_tpl_na
diff --git a/bin/travis-ci/conf.qemu_arm64be_na b/bin/travis-ci/conf.qemu-arm64be_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64be_na
rename to bin/travis-ci/conf.qemu-arm64be_na
diff --git a/bin/travis-ci/conf.qemu_arm_na b/bin/travis-ci/conf.qemu-arm_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm_na
rename to bin/travis-ci/conf.qemu-arm_na
diff --git a/bin/travis-ci/conf.qemu_arm_spl_na b/bin/travis-ci/conf.qemu-arm_spl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm_spl_na
rename to bin/travis-ci/conf.qemu-arm_spl_na
-- 
2.34.1

