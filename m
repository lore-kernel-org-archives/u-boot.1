Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E58ED743D8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 20:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF0389358;
	Wed, 20 Nov 2024 21:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S1Sia3UB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA76895CF; Wed, 20 Nov 2024 19:57:28 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5408389353
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 19:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4314c006fa4so44715e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732129046; x=1732733846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ijvj6DYxLnCgyHH2cJs0mTKpSphzlGw608di7eWslwg=;
 b=S1Sia3UBHLVG/3IQzbBTt8I85y0fC18hhnrxu++KesRXTHWylc7WV/LLzUgLv0ZXsC
 f/D6PH/tbOirRz9CxUL3A0C28J/fX8xnQIBzLovTJf3aBIV6JIRGCNl44efsrvvvcFsL
 XWCQy4t3dFm1xPACrJZRQNt036xEa+L15MF6MJFc697RSm9VITzKRS11b+gBdk6jDzgj
 2+7JLwSryjwkQkQgi5bfNtXn044okdXj3zPUtJLdwGo6j9zj0UyJRfH2x8y0G+HVC4ir
 /u8c4ByG+yeDiHmY7KEgxvRfi+5qWEv+P0LkWvWNkjub6V55hPctAuX0udWH5JkYGY8J
 fUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732129046; x=1732733846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ijvj6DYxLnCgyHH2cJs0mTKpSphzlGw608di7eWslwg=;
 b=Pn8D84wcMJx9eIWF2wh+kc8Fbxlms2uewdc7/cvxDLvwGymt40l+OzdYq9QICJOyiF
 mewsNsjUYsBqZYdbjpFIZq5VmbVfTF7MCLnu0JvTnaBC6q3c8dKRkuAFoRZkKe8215SL
 vmFe1hlFm4WRk/YK+E+Nfl60FPJF1MwkiY91/U2QbzxzpBIwq7JQSdSlmnH3hP7SHhoi
 6x5izmdm3a6wfQwuYdzhEn2M88jJ2fjt81dX3mc5uFdA/gjpEop3C2txnLS5TlLsrjaf
 tXlNGNh/VjT8cWj+B6SltTN/94pfTNqcv13C1mf4VlERyQCrkxa1GU8vwWHjybEjRNxa
 69hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnQNoVeNZCHyH1+lxlfHXCKhCVSpTUy5KSLZQBv+q5Fk5Ik5UTUJx/PpiqiGbMqqvXDdfAW2o=@lists.denx.de
X-Gm-Message-State: AOJu0YzxAhzEYd6Alb3mlgsvxn2ylgQK7oQoi20v2kKyDkqlwAyDVizi
 XO/8looGXU56q+nNHNWhTJpJn0El0kiRl3xPlhd0QbADf7/X758NR7K6xrI6
X-Gm-Gg: ASbGncvEMAlJ9wjNMlHyM8D7BrkOhwbtnWX2Qi2M/oWl5oHY01nregx4fmF5zNcBAqy
 CMWavttVfHXTYPp42Hc+sADydogBpr0o6FxtYvHxYnb2xJM0edRro2x2Ds7JkqWTGF1PuT0ug+k
 W+PgqGs5ExmEmGV8q/nmxDy7hAhADC7ImgZcNTbj9kyClTcgkjMlh3ytRoeWkNqQcA+AmpWyG4w
 rc6V1PrFeRE2T1Ze5Wd+6B4Oh1eI8UDyERuWzgTkXmXJlsX/VQhUC99Tf18Z4LgjqdA1C58pOvn
 bHatvVf0XeQLCHoBbp2UTiFpz3TF
X-Google-Smtp-Source: AGHT+IHBkNlnSuvg3mMxMT+T2AypqbatrRE1XsTPWesNCXF10/VMOO+0TWCNu21y4C/k/bqARIv0vA==
X-Received: by 2002:a05:600c:5107:b0:42c:aeee:80c with SMTP id
 5b1f17b1804b1-4334f023b3dmr14359835e9.9.1732129045614; 
 Wed, 20 Nov 2024 10:57:25 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463bd19sm28161785e9.44.2024.11.20.10.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 10:57:25 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de
Cc: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: [PATCH v2 2/2] doc: develop: Fix typos and wording in gdb.rst
Date: Wed, 20 Nov 2024 18:57:17 +0000
Message-Id: <20241120185717.29768-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241120185717.29768-1-l.rubusch@gmail.com>
References: <20241120185717.29768-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 21:41:16 +0100
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

