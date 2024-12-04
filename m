Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF17E77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 18:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD62896D2;
	Wed,  4 Dec 2024 19:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HXXKxyqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70304896E9; Wed,  4 Dec 2024 19:33:28 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EBB389443
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 19:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4349d25eb5bso152145e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733337205; x=1733942005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EIWRFYuRs/kozdfQOUak+0S8dUt2hgAmyEuxT0BrGk=;
 b=HXXKxyqLvYkKoJNPtqy8+lfr8SAhZ8Yy1O8zQtt+cqGn4agcqBtXxm97P/Eut2hUBC
 lJMc5M2MEUkFWn7ML29cmeiAUim8G/vMlQUmR1lXqU1DemxLjb0sn5NPw9L/3Bd9hbub
 wyTnSGBfwgF7TJc5kdhyT4iDoScWnhaR/lZprg6bmEoXNgeEO/hrkjdzK/oeJNgRqGgZ
 XtwgjFBUx5owj+CJ4TgxVv+jkUoW0zJIF2w6gmOW9KvichXQv3/r6IOX+basE5IIrlu5
 ETjrE5VCcC+RU7MQECJoepnDyv8GghyeoNTU1WbDeBF5FY3tM7weYn+OE4kvpPEVoPgM
 UDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733337205; x=1733942005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EIWRFYuRs/kozdfQOUak+0S8dUt2hgAmyEuxT0BrGk=;
 b=jAK4flSlFO4t/lrpLp7R6O3+v/Bmz7AzWs3Y4KXpSa0iwNH53JVIm8JXVpQFRO+Yh7
 MLDjsekPKG/75RjZMed3uDDWUQILfOjbjsrSGvUJRbodNRJPvYndFdENUM7oetq+8M4R
 SyfPPbmuzVNbfkdEwQjVDSdbaTQcr9mKoLT6fBcIyTWkh4SucGHk2gVLe8UnEGZPoKZ9
 RyR6CQ/tofBf5EkmH4S3wFmiIfbsqByoA9+ZYkc1Y4cl53LmjnkD7SILGVQ3r2pU/4pN
 Y95oPFXcm4XoruxAtWZ+wGaNtAB/MS8+DLvjvIZvLs4nNYMENZbr8vk6iSKvWKWctbsi
 0LrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz9Ary0Gylyrkn4hPBCU/DBlA6Vrq611/Tjv8xfMdeRCsH1dAZIqS0G/btQ3j1barp13PAefw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2mR1ShO8ls0xqikJbI2RxuAaJAUIu69q00exD2aM/ZqWIg4Mg
 +yPKij3gmfKBZEFDIZ0tZyTZ56dtdzY2hSz4m/TZsw6nYGLYeIw4
X-Gm-Gg: ASbGnctTFwAMz4/SeKtcazCXLBbclWRBam5r+bPTO5acQAAXl7yYTXyjaLx2gTR0gZP
 8ZgpU23b7oG+23MQweNoMn7Zz/g17NWK9ObDiVqQrBmiQjbrRoX1aVVjMN7eXXNZPL8+3qSbjor
 ZxpGLB98WUtjUpEJNR+BU1ltRvfAuFCLl9XzHuoMUiq6IcpoMkPylX8/GbtVqutJVdK5HE1ByWL
 o9n7KkpnG+rFlnl8V4QTGtZhIZfora3LgPXYEkX+3gCi39p76dtFqexJG3GKcpeIv/ci82CvMq9
 9Bs/mqFvlxTXRyth9D9hKzNN2C83
X-Google-Smtp-Source: AGHT+IGKZD451XAAviKs/mpeKe3InwUDSBKb2Poo6ZUtk1DQFAExW6/hHEgH4DTNhmLYPuNPEB2dMQ==
X-Received: by 2002:a05:6000:1541:b0:382:4e71:1a0f with SMTP id
 ffacd0b85a97d-385fde04982mr2346963f8f.7.1733337205493; 
 Wed, 04 Dec 2024 10:33:25 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd80435sm18663825f8f.100.2024.12.04.10.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 10:33:25 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de
Cc: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: [PATCH v3 2/2] doc: develop: Fix typos and wording in gdb.rst
Date: Wed,  4 Dec 2024 18:33:13 +0000
Message-Id: <20241204183313.144473-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204183313.144473-1-l.rubusch@gmail.com>
References: <20241204183313.144473-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Dec 2024 19:50:49 +0100
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
Acked-by: Alexander Dahl <ada@thorsis.com>
---
 doc/develop/gdb.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
index 4e359c7f22..79510ee94d 100644
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
@@ -24,7 +24,7 @@ Otherwise build, install, and run U-Boot as usual.
 Using OpenOCD as GDB server
 ---------------------------
 
-`OpenOCD <https://openocd.org/>`_ is an open source tool supporting hardware
+`OpenOCD <https://openocd.org/>`_ is an open-source tool supporting hardware
 debug probes, and providing a GDB server. It is readily available in major Linux
 distributions or you can build it from source.
 
@@ -144,7 +144,7 @@ riscv        gp
 sh           r13
 ============ ========
 
-On these architecture the relocation address cat be determined by
+On these architectures the relocation address can be determined by
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

