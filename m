Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4812D70DE6
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 17:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200CF89D2B;
	Thu, 28 Nov 2024 18:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ASwXlbwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7891089D25; Thu, 28 Nov 2024 17:48:10 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4988F89782
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppeter.bme@gmail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-51532deb8a4so283425e0c.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 08:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732812487; x=1733417287; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dY8Y6UdjlzEUXjuzkiKeiycJJmiIwHq6lVzDXHD2vs8=;
 b=ASwXlbwuOg6qlFYh8yPG344/Wzsr9aj+XffpBQM11n77RCmbYldVzDApq5qWEyCLUe
 nZ1gwUPjLjzr3r/7NClz9kuUqb22wv2Sz1s3VjgXhu7rlS5fANB84QrAhca9kQ/20xgs
 zKHwTcWiOq6XScugI6LR3d8WsG7PH5lrlmjKTNg0Guh0lJxstwEHRxUGlmAirvFiE5Kq
 k5tpEK7ZgOKxEgKCxHzYBmRv7Wok7LCpwoegTo4kGpJwHkunYAr13eDYTCvwdgpCmxO7
 EFQuYTh5ylWupTJhjm974JQdh0jqqFylWQgs0yC63B7HzSi3kGOS+VYo61WYKPuBsq00
 mfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732812487; x=1733417287;
 h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dY8Y6UdjlzEUXjuzkiKeiycJJmiIwHq6lVzDXHD2vs8=;
 b=wVZ104ItW3BogW2l4FptuOd23I/Ymq68jHwL+/Fcf2oMCOQihoSxtGrDVX/ud+1bYi
 Z/Q/csn5SJLYd4mcDpvaszlezI9hwu+F8PmNXeeOS3mT/MA0pzjh1yeVEuNM0WOW8p22
 /8TyRsIEEoswx3GJPc+MnV28k8grw0QBaJ3ObFeTonu7m4D3a3H534ubsc9ATSlGXGyQ
 l/189udvwlvV+QDotNGUmXDE1hyWn6iwSkRqsPK3hWiNeL/Zg9yuaZsSJUarmpq0sjE5
 O4neyyvcCQ80YdYhLqvrkfgbY2+LEeEyx75gqgPSWp5Ft0UbWHsC/kI5xznwiDQqO5RD
 2DRA==
X-Gm-Message-State: AOJu0YxtiK7heJ0mIdZK9GhXqlOytuQUlxMVQDslleCI1OcOyoy5KMg/
 gHD9KXhICYoDY7IpD6jm3GmXmY54GQ8In2SJGqcEqp3CJOMYtY05f8nYUZNxFH37qdjQUkm+paI
 oqqVQ/jO3Oelc5mPrfMOWT5VU6/EtcVArApE7jw==
X-Gm-Gg: ASbGncvPnqwey+3Z2xN1M3GuBHXeVpns+E5cAGj1iCsBYnp0roJamU1vO3hVjaYGU8x
 swY0laeCR+88zRB5E369I+zqIEe5Zle0=
X-Google-Smtp-Source: AGHT+IGJ3Q3pSVo06jMBv9xy4+Ts5ZNWZ1rvkAAsP9gPK879b4MFHz59RoZrZigpbxp1mueb6Y14hA2cmyOqCFO0AYM=
X-Received: by 2002:a05:6122:2985:b0:514:f579:3bad with SMTP id
 71dfb90a1353d-515569ddaa6mr10146073e0c.9.1732812487045; Thu, 28 Nov 2024
 08:48:07 -0800 (PST)
Received: from 513505537346 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Nov 2024 11:48:06 -0500
From: Peter Polgar <ppeter.bme@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Date: Thu, 28 Nov 2024 11:48:06 -0500
Message-ID: <CAF2BDb_g8385y8WpAw0epu-oSE5Wx2Nab0NvQ1mf+=hOVowZmg@mail.gmail.com>
Subject: [PATCH] Add cross compile dependecy info for ARMv7
To: u-boot@lists.denx.de
Cc: Peter Polgar <ppeter.bme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 28 Nov 2024 18:02:50 +0100
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

This commit adds info about the needed package to cross compile
U-Boot to ARMv7 (32 bit) architecture on Debian based distros.
---
 doc/build/gcc.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index d8fcfdc4bf..c552e7b590 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -19,6 +19,12 @@ You could install GCC and the GCC cross compiler
for the ARMv8 architecture with

     sudo apt-get install gcc gcc-aarch64-linux-gnu

+For the ARMv7 architecture (32 bit)  use the below command instead
+
+.. code-block:: bash
+
+    sudo apt-get install gcc crossbuild-essential-armhf
+
 Depending on the build targets further packages maybe needed

 .. code-block:: bash
@@ -118,6 +124,12 @@ Assuming cross compiling on Debian for ARMv8 this would be

     CROSS_COMPILE=aarch64-linux-gnu- make

+Also on Debian but for ARMv7 it would be
+
+.. code-block:: bash
+
+    CROSS_COMPILE=arm-linux-gnueabihf- make
+
 Out-of-tree building
 ~~~~~~~~~~~~~~~~~~~~

-- 
2.43.0
