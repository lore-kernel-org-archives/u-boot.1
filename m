Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D2FD6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC36789606;
	Wed, 20 Nov 2024 01:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m6Z9pWuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD95189121; Tue, 19 Nov 2024 23:29:04 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9337D895CD
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3821a8c7c5cso664711f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732055340; x=1732660140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDsyndUQyjOR/ej0QEwrzt2UW70HvxLYg0ZKtMybNFw=;
 b=m6Z9pWuUUieeRWz6Cug/WoCbMmGiwDgYCFH31MZGh6E7Ms3HfzflcbzYeYHDD1JKHj
 BurXJV9kWJKxvgZDgXXLUICJDxHHnfhwwfBL4Fy6IY8/1cYaLHamOMoXsIgh9Tcue+qQ
 myXlzyTIfUlwzJav9kbkvMRQyfqTu2fK+pt012x7FB0gGQtaUkbegZpwace48c3udHrF
 9Xh/PPH+t+lRpdox50uGWTPka8Ku7E6AfVRAhnX7gbvDlt8vuGIOs9lhq+JHVdu8Gmov
 CR4XhIv14CBKJfrnuj5AskDFhyfjtMkYWtE2dMFTp1gFoRqIMkY/wfT38gx7NRfN9bCz
 KnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732055340; x=1732660140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDsyndUQyjOR/ej0QEwrzt2UW70HvxLYg0ZKtMybNFw=;
 b=A2hEHi3SD23ePqfx86I1uEPQu/LUiKDpdQn5d+rbcYooftgL8yyA5J4u+xeSSW8kyo
 1uXHqqvXHffG0L9ShOd3SPmrbWXdpRFHa9K4wJAoBkXaB7a3Tud0K0D8RESEwZgnU7gc
 S2tGRPBig/+fO2zrjdw/9TBD/3H3y4Hl/0a0/ab5lsFE29KGWPtjeN/nWGnVDt9Cduez
 i0dWl2imfzDQmpZ9k/OyMwBQG+aRYA/fXz68UZK0lPRY7rb++mmsJYzYDpe2dXpDrf0I
 M5P/eIsixiKAyY7bYUnnypXie5xtLeMxMUo6C+fQl7KzGnr0Dmj6IqdWo/+pQqn85oZo
 o8DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqMBBidbvYAKKOBxeXcWyFqc4QgbYHmW/h5f629ydGxQOwlQEbXgOPMgkys/yaA6fNToHMuPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyH/8n+V06tihQtKGqg+u6NrZq0oi++cHs0wqXWjls0VVeGkxY6
 8CQe1ebi6aSerVnKNaHiPzFf0egjvXNTywrwN96W07awbdNuRvT8kAJ/Wn2V
X-Gm-Gg: ASbGncuYbefrp+YPxxwBxDEL2SBxg1WVEIDGNTxjmr0zhgQWWUlcZiITEc6pU1yeean
 JqaNBn9/GP0r0X+kSIKhI1+LYY2mJqT/NV9jM7gKWMnDE8WSIp5s33XjmVPNgEcIponlFrvnrGZ
 fiAbSV8nc1vi8eDwOqJRR7oYNgwzJ7pHZeGDnXF7eE0/a3kqCdsBW5Rs96r64bZYbyAYrkMxo8q
 fB3G3jUoSBj8iFULvy/w+AOZ8Ay+I++2l1xHflDRzQfAhgTpGt3XrqmHJ8tySuFZ6B/BBF2tLH+
 002Ew26NusYIvi/gCRxcg8JZHncK
X-Google-Smtp-Source: AGHT+IH/SE0N6j6Yvl3mpCVqG1TsrG5VNNYIsiWvLSYEWtAwnSnjk+65KLoASJKQmDgmMuIWy3MZQA==
X-Received: by 2002:a05:600c:3c92:b0:430:52ec:1e2a with SMTP id
 5b1f17b1804b1-4334f025a9emr2060375e9.7.1732055339797; 
 Tue, 19 Nov 2024 14:28:59 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1fb7asm208058655e9.42.2024.11.19.14.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:28:59 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de
Cc: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com, al.kochet@gmail.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: [PATCH v1 2/3] doc: develop: Fix typos and wording in gdb.rst
Date: Tue, 19 Nov 2024 22:28:36 +0000
Message-Id: <20241119222837.27550-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119222837.27550-1-l.rubusch@gmail.com>
References: <20241119222837.27550-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Fix some typos and duplicate words in gdb.rst.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 doc/develop/gdb.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
index 4e359c7f22..dc38435227 100644
--- a/doc/develop/gdb.rst
+++ b/doc/develop/gdb.rst
@@ -8,12 +8,12 @@ Using a JTAG adapter it is possible to debug a running U-Boot with GDB.
 A common way is to connect a debug adapter to the JTAG connector of your
 board, run a GDB server, connect GDB to the GDB server, and use GDB as usual.
 
-Similarly QEMU can provide a GDB server.
+Similarly, QEMU can provide a GDB server.
 
 Preparing build
 ---------------
 
-Building U-Boot with with reduced optimization (-Og) and without link time
+Building U-Boot with reduced optimization (-Og) and without link time
 optimization is recommended for easier debugging::
 
     CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
@@ -24,8 +24,8 @@ Otherwise build, install, and run U-Boot as usual.
 Using OpenOCD as GDB server
 ---------------------------
 
-`OpenOCD <https://openocd.org/>`_ is an open source tool supporting hardware
-debug probes, and providing a GDB server. It is readily available in major Linux
+`OpenOCD <https://openocd.org/>`_ is an open-source tool supporting hardware
+debug probes and provide a GDB server. It is readily available in major Linux
 distributions or you can build it from source.
 
 Here is example of starting OpenOCD on Debian using a J-Link adapter and a
@@ -124,7 +124,7 @@ with the command *bdinfo*:
     Early malloc usage: cd8 / 2000
 
 Look out for the line starting with *relocaddr* which has the address
-you need, ``0x27f7a000`` in this case.
+You need, ``0x27f7a000`` in this case.
 
 On most architectures (not sandbox, x86, Xtensa) the global data pointer is
 stored in a fixed register:
@@ -144,7 +144,7 @@ riscv        gp
 sh           r13
 ============ ========
 
-On these architecture the relocation address cat be determined by
+On this architecture the relocation address can be determined by
 dereferencing the global data pointer stored in register, *r9* in the example:
 
 .. code-block:: console
@@ -153,7 +153,7 @@ dereferencing the global data pointer stored in register, *r9* in the example:
      $1 = 0x27f7a000
 
 In the GDB shell discard the previously loaded symbol file and add it once
-again with the relocation address like this:
+again, with the relocation address like this:
 
 .. code-block:: console
 
-- 
2.39.2

