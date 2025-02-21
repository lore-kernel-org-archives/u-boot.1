Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B915C021B6
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 20:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14B480F6F;
	Fri, 21 Feb 2025 21:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XocVTqWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC248001F; Fri, 21 Feb 2025 21:32:55 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A453B807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5fcef5dc791so916397eaf.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740169972; x=1740774772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3IyxbSGMIiRKTWnqxNLRjNXUPwmItku5ChxVgtrRrs=;
 b=XocVTqWRlq1pAGNYqz/FUFe/4ZvybkWIcuysk1q+lZrrXro5lavmSRwl5wbdGosueJ
 Jb3ziShvar0fATGBk3l6VcM+xOQ/w/Az7jw7kNYaya/x6S9Tiobo2yFJmQC6W/rqmxYq
 D1rPyT+Fvs0yxGOaOx9EtDnhR4MvtSTFr20rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740169972; x=1740774772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3IyxbSGMIiRKTWnqxNLRjNXUPwmItku5ChxVgtrRrs=;
 b=LukwbBRHfnNkFY+BSGeF/6NAuulvcploCqu++KZpkAM6UkuhdSx1pvi41TkVnf1HWi
 Sb9Jfl48at9JKqw7lhzolh7ewpWn3LoZBVPB2r5zm1zVR/bNQlq2dDH8qGuUXiaHaAgW
 T3szIOVBky8iltctGS4ocN2S/eInH56ASbII9txsdR2n0SjzfqREqX54EpKSY4c+7vEg
 O7romycuQdPz77QoVOEFP8LDhXJvRbS35Po+ZuVP5ezd+kWXLT9J5clueLUPrLsarDTf
 tlsyF14w3nzZbJlYn05leHET8YEqCLgEYnOPZfh91T0gE4U/8BZRnQPqIjC+11iIPaBU
 fWQA==
X-Gm-Message-State: AOJu0YwH7r27F4lS/UJ6d/jKwGRzzZ043OXCwFdLL/Ji6yqJju7PWA3l
 7ZPGmfJMo7dZl3rbqvbTGloKcuLeEUhl5VK2YMOeaQP1u1FXD/yAvF4zwacJXfGK1xhe5EW+JN4
 =
X-Gm-Gg: ASbGnctHRUyf2849WQnJh/1QXqXjzUBUxuSTTZd7CYVybFQ7ZfYHwOTJtDlifiRtbtm
 gM6vynri1EfaVyqBA3Vx399LJufC4HQPTTpDNwaf8NJED6acQBD/aX6D3kZ9yZXR4Il4C4QVvr6
 PfUGM6DRwa3fINXrM6VBIVNh2D3TrrqN3a6svf0UCalnAO5A23bfqGX2uAnTx9arq55C9AFtqop
 YP7cz16/BoPAstf4HIHWbNrejugjRk8I3/EmkzJ2uSuLbJ9YgWv/yMZysV2GREZI28BjPc/inTc
 tMEC8D2hpbUGBfE4JZ1cNYhsPZT3GPg0z3ZPj/5Bh2gpmgLDgCmnKk+KBXzzj4U=
X-Google-Smtp-Source: AGHT+IFVRiqtelDASWWZYQe6EK02iCazX4QO54j5GZ/XHdfSQTlwoyB6DuWgztpE98lkZTJxybUk+g==
X-Received: by 2002:a05:6820:1c86:b0:5fd:8f1:5f09 with SMTP id
 006d021491bc7-5fd1960a86fmr2902108eaf.4.1740169971770; 
 Fri, 21 Feb 2025 12:32:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fce4c93aaasm2523681eaf.40.2025.02.21.12.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:32:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 2/3] ellesmere: Add QEMU config for riscv,
 arm, x86
Date: Fri, 21 Feb 2025 13:32:41 -0700
Message-ID: <20250221203243.672465-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221203243.672465-1-sjg@chromium.org>
References: <20250221203243.672465-1-sjg@chromium.org>
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

Add symlinks so that the (non-labgrid) lab works on ellesmere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 bin/ellesmere/conf.qemu-riscv32_na     | 1 +
 bin/ellesmere/conf.qemu-riscv32_spl_na | 1 +
 bin/ellesmere/conf.qemu-riscv64_na     | 1 +
 bin/ellesmere/conf.qemu-x86_64_na      | 1 +
 bin/ellesmere/conf.qemu-x86_na         | 1 +
 bin/ellesmere/conf.qemu_arm64_na       | 1 +
 bin/ellesmere/conf.qemu_arm_na         | 1 +
 7 files changed, 7 insertions(+)
 create mode 120000 bin/ellesmere/conf.qemu-riscv32_na
 create mode 120000 bin/ellesmere/conf.qemu-riscv32_spl_na
 create mode 120000 bin/ellesmere/conf.qemu-riscv64_na
 create mode 120000 bin/ellesmere/conf.qemu-x86_64_na
 create mode 120000 bin/ellesmere/conf.qemu-x86_na
 create mode 120000 bin/ellesmere/conf.qemu_arm64_na
 create mode 120000 bin/ellesmere/conf.qemu_arm_na

diff --git a/bin/ellesmere/conf.qemu-riscv32_na b/bin/ellesmere/conf.qemu-riscv32_na
new file mode 120000
index 0000000..0646dbc
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-riscv32_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-riscv32_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-riscv32_spl_na b/bin/ellesmere/conf.qemu-riscv32_spl_na
new file mode 120000
index 0000000..ceda23f
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-riscv32_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-riscv32_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-riscv64_na b/bin/ellesmere/conf.qemu-riscv64_na
new file mode 120000
index 0000000..085574b
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-riscv64_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-riscv64_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-x86_64_na b/bin/ellesmere/conf.qemu-x86_64_na
new file mode 120000
index 0000000..3a1470e
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-x86_64_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-x86_64_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-x86_na b/bin/ellesmere/conf.qemu-x86_na
new file mode 120000
index 0000000..f6e7e5a
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-x86_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-x86_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64_na b/bin/ellesmere/conf.qemu_arm64_na
new file mode 120000
index 0000000..cf56db1
--- /dev/null
+++ b/bin/ellesmere/conf.qemu_arm64_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm64_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm_na b/bin/ellesmere/conf.qemu_arm_na
new file mode 120000
index 0000000..aa91a9f
--- /dev/null
+++ b/bin/ellesmere/conf.qemu_arm_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm_na
\ No newline at end of file
-- 
2.43.0

