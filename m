Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B95CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3795A828A2;
	Tue, 26 Aug 2025 00:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KQHNH+r5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57CE830F6; Tue, 26 Aug 2025 00:34:23 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95DD828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce85dso1297386f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161261; x=1756766061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q97MBpiO4/zyXPCWEeGuh3+trRW6+XwuLZSAjqmBeGw=;
 b=KQHNH+r5dbhn4anzP4bLO0xmX6Wk2DWoc6guCZ0tcPU8qcf3BeKtU1iKyEd0D4zt8p
 J85KOt/5wH1IjzUuuNGFWQ7a1DZRzgA9n017ug3KKk0Urv6T9QOeVrkqOoTuSLesz91N
 C4fn0a/c2RdHkUtjRJtyITZ9g7eloJpLsljgCNk+hKV3MMe5cfPDYr6Mc71xLL9tLgte
 Tonc/QSUO/7IapFAcxRz+41wpsFL0KopN6dIYupfLVnlZFzm+kUW6HprLqgZbYur5RT3
 vPuzO2tFt7LhDFEVDoxOwQjS34tz+a5LuZi3XU/uwWWj9WX9TAwgVK1bjpHF39TI5TTJ
 SNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161261; x=1756766061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q97MBpiO4/zyXPCWEeGuh3+trRW6+XwuLZSAjqmBeGw=;
 b=QyLioJir/95AKhgKGiPalW7yynfwSOyU8+D00d8j83B7r1NMJ8Ao2QFzIXdtwJyGGV
 ChLoopAzXIN6MLCuP1cE9IfRfzelQYW3s/Qsbo8EcxHKnvy+aWJcXJVa7J4zfATBL4Mi
 CS5eKDcmfE5Rw8TAP5SwvNy5PrmkaunLuRF7GzxUAeVsgdMw83d8p28wJjobKQyzK//i
 Btz4uVCdutx/Qps/vqJN0hIqJviw+VFsACg1VG3YYDSGjR46+x5fJ/EbWw18QpuvBYFV
 aH/ZQSMn+ZupkE4dv+xg4h7T444jLeXGbOTROUg34Pooj5PGKvaJoiWsZy/tfVTbjLMO
 ukHA==
X-Gm-Message-State: AOJu0Yy+c9H1+Y3waNo8HcO/1o9+JXWpuTJfQ7uU9w2N29ClNPy0iHBA
 Ty9OsQ2jemJTxxWOg523kHq+uDqICwkpXiXSaTmi+8Hnjn1Q/1YXV+xKj0Gnr876JWk=
X-Gm-Gg: ASbGncv7PYdSB8ryE9OYIL4f27Vz6rGuWRCJ/OZPQDch2fFVfQH+4UXiZLVqx99z9q4
 fmzggsnybjTX3bM+/7JCvPy7LEp93q5EKjO1TtKTLZaGi0Coz60zKdJyu7lbLqRBhnKyABqGqIb
 o3KIKhPkZbQQrZ2WrobtZH2asNR5rxlvVTwXaHfcnQsS5OLn6w0aZG3Hi0lKvgbf0OOwG7qz9GK
 0KRFWj1aYJ0Bgf8TqQXoQWZZJB7lzlhKjaioDaGYUjh2aJgJjP8y1s0SOnmHJiXaZ+zS0B2wnen
 VMThbu4Xdiqj0zPpjYs+4/97Fzr0ojsyKXNMDficI505qAWy66IWi7cnO9GQOVfV1EikZP5qfMe
 q9keyBbZqhFfAQ/8pGKxcwOw3OftKhCmS0e8NjH4=
X-Google-Smtp-Source: AGHT+IHmWxfTkVeEa9zyr7YiZ/yI7O6/UgK0PoOsp9TQQs0s0WNEG2jom5FemtgC9hBgLZaqQzmlhw==
X-Received: by 2002:a05:6000:2512:b0:3c9:3f46:70eb with SMTP id
 ffacd0b85a97d-3c93f467c6amr3667140f8f.52.1756161260947; 
 Mon, 25 Aug 2025 15:34:20 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:20 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 04/10] doc: Add riscv and unfold the list with the
 architecture/code name
Date: Mon, 25 Aug 2025 23:32:31 +0100
Message-ID: <20250825223251.674591-5-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
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

riscv was missing from the list.
To some, the architecture's name may not be obvious from the code name.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 49ac5caeb14..368ef5c6f19 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -478,7 +478,20 @@ Setting up
 
    At the time of writing, U-Boot supports these architectures:
 
-      arc, arm, m68k, microblaze, mips, nios2, powerpc, sandbox, sh, x86, xtensa
+   - ARC (arc)
+   - ARM (arm)
+   - Motorola 68k (m68k)
+   - MicroBlaze (microblaze)
+   - MIPS (mips)
+   - Nios II (nios2)
+   - PowerPC (powerpc)
+   - RISC-V (riscv)
+   - Sandbox (sandbox)
+   - SuperH (sh)
+   - x86 (x86)
+   - Xtensa (xtensa)
+
+   Each entry list the architecture's name, followed by its code name in U-Boot.
 
 
 How to run it
-- 
2.48.1

