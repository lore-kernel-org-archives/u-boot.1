Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F58E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 11:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46417801F5;
	Fri, 10 Jan 2025 12:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jN020L2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50778036B; Fri, 10 Jan 2025 12:14:05 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6888E800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 12:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baltazar.radics@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso13993155e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 03:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736507643; x=1737112443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oPd19QcP7V3uZa7KsYCbdkODezOp4JfahAu8Fpuf+wk=;
 b=jN020L2A2Ev/1u71yZAS6AB4by+0kO3VarPNhkHMnFNMhUQ4MFxTChn1/V2mTNiquE
 KAJCzInv/PG2qQdef7Pm2H2DgTaJ+hOMwZ5U1lrqTkxJJTnjWUKk3XHWA8iEkwUB5EE/
 hyLAMnHV5nOkkjJlNHpVX5s76JtwE1FjFUJM1U32Q/9FphAloOufNWm4WWy6XAotiK8N
 TCk/xbjTLnb092K3zP1qoQQQ4S0GCJHAATNIrFAj53vO5faxT/e+rPqkWS/C/y1oEcnI
 J0Ixr+Zieqn8kWXEbpdnmc6NBhz2vB02PvnbiU9TpXVAxD8jBbuBzszCZ/b3K/QpHoSp
 Vqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736507643; x=1737112443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oPd19QcP7V3uZa7KsYCbdkODezOp4JfahAu8Fpuf+wk=;
 b=el53mO4/apPt52nN5eS9H4OO7hfeJZ6nliGf/BUbBv+RFobAQjb7AcxOGSa76xL64u
 awT05Y4ukj4pBDtqqFunJSVGm85CDRq4kridgy0BqSDSP6BMUGuSUkXyd4j4zIPsNWPx
 IuXg/wuWctcXpxZZiSI8+EdhPA6uNC7g+0P+n5eWItmD+/EHjci16pi1R/YLEtY2/4UV
 hkov2McC7BCpjbgOZSJ05BsBbauauZ5YvWR9fK26DZV4HHWOTUR+OXP9l8fylcXGsNx/
 iA44WG1KBlVeYC6UC84V8AhLB4UBZcVsffcx+J9oP6CsXMX7KIMG22SNc3iFhcOiDCId
 h1+Q==
X-Gm-Message-State: AOJu0YwU/uuIveAeQb241CdrDKelKPlKyjV313Pa9RC0e5JkLAWEF0GM
 O+OJA+oUE+/LcbGPY7ki42fkiFAEAJr4n24/o3y2JsZ6TdxqnmhZyCfQyTym
X-Gm-Gg: ASbGncuSqu8Ybwq5xRpA6n1PP9iKMbT5V+ZfwT1CRq+SQxzvOgz3Ju2sKX9TAjDvK0o
 1kTzi10PwOLplR3AxKBjNLUIFSXD+8VAYz838j00tQk8XMDkDgx1N5KL5/HAUqTd4ALg9KLxbzn
 rs6DljSyPtyIVPM54NIjxjawpL/L8mfUA/6su/mkDaTVGCQEwHKP/Yv6PnI0iAelLR1IFhDfaPu
 JQl2a5nRtD95KJXaizPZmIVNmYZU4Zvmxow2DH0TGdfRElJhdJTlFfHZOZrAvtAbitu5YgtD2Sx
 PwU=
X-Google-Smtp-Source: AGHT+IGlttaxKPpoAYPz4GQvpy6zbS9ubm1lRliMdHZNh02xpU6cQst+F/wbTquvAMzs6Q7zLq64Vw==
X-Received: by 2002:a05:600c:1d10:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-436e26a7af2mr106392185e9.10.1736507642469; 
 Fri, 10 Jan 2025 03:14:02 -0800 (PST)
Received: from pluto.karinthy.edu.hu ([2001:738:80e:b5f3:51ba:c885:8ac2:fd5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a9407fd62sm2469452f8f.92.2025.01.10.03.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 03:14:02 -0800 (PST)
From: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io
Subject: [PATCH v2] board: odroid-n2: Update docs for signing
Date: Fri, 10 Jan 2025 12:11:24 +0100
Message-ID: <20250110111335.9221-1-baltazar.radics@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The previous instructions resulted in a bootloader that wouldn't fit in
an MBR gap. I have updated the docs based on upstream's build process.

Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
---

 doc/board/amlogic/odroid-n2.rst | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
index 883720f8fb..5222a21c80 100644
--- a/doc/board/amlogic/odroid-n2.rst
+++ b/doc/board/amlogic/odroid-n2.rst
@@ -54,10 +54,9 @@ image so it is necessary to obtain binaries from sources published by the board
     $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
     $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
 
-    $ DIR=odroid-n2
-    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidn2-v2015.01 $DIR
+    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 odroidg12
 
-    $ cd odroid-n2
+    $ cd odroidg12
     $ make odroidn2_defconfig
     $ make
     $ export UBOOTDIR=$PWD
@@ -74,12 +73,8 @@ Go back to the mainline U-Boot source tree then:
     $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
     $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
     $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
-    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
     $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
     $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
     $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
     $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
     $ cp u-boot.bin fip/bl33.bin
@@ -113,7 +108,7 @@ Go back to the mainline U-Boot source tree then:
                                           --level v3 --type bl31
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
                                           --output fip/bl33.bin.enc \
-                                          --level v3 --type bl33 --compress lz4
+                                          --level v3 --type bl33
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
                                           --output fip/bl2.n.bin.sig
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
@@ -124,11 +119,7 @@ Go back to the mainline U-Boot source tree then:
                                           --bl33 fip/bl33.bin.enc \
                                           --ddrfw1 fip/ddr4_1d.fw \
                                           --ddrfw2 fip/ddr4_2d.fw \
-                                          --ddrfw3 fip/ddr3_1d.fw \
                                           --ddrfw4 fip/piei.fw \
-                                          --ddrfw5 fip/lpddr4_1d.fw \
-                                          --ddrfw6 fip/lpddr4_2d.fw \
-                                          --ddrfw7 fip/diag_lpddr4.fw \
                                           --ddrfw8 fip/aml_ddr.fw \
                                           --level v3
 
-- 
2.47.1

