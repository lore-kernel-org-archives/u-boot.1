Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6DEC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B373875B8;
	Tue, 21 Nov 2023 16:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oukoEMIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DBF5875A4; Tue, 21 Nov 2023 16:41:14 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B27875B8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77ba957043cso364406185a.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700581269; x=1701186069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vbmWLQpcOM31wyyi2322VSIDEPDMmphXHWQl/mW24Hg=;
 b=oukoEMIvo1d+uRl9jpg8aeQRmq12vdre14iXwM8K56Y0izZNkAhwoluszjzFTN0BLl
 3Cfi8jkhBPAnMfB6EGDhPcK7lpFmEVQFCzVeVCP103F+q2Lk5L7da/ERXss3mbzn745M
 DKYt0vjUJzAl0ZfCrGrur8SyQeabsnhutLb40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700581269; x=1701186069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vbmWLQpcOM31wyyi2322VSIDEPDMmphXHWQl/mW24Hg=;
 b=TJ7hnLTvUH9ieUwTLw/SSqY+UBw332L0ZjQCW6uixzyAD6modI4CpAhlfQCGYYqo8d
 vhkNjFnJyMuq22ZBMjxgwSonbFBfyuMC/c9zdkfKjxVBxwC66+5NfLCOF2Uc7LzwFTJB
 lojTswtLNE+CINARj6aDI8n6oPySQW8r8e+NRP7+iiQNTfeV312fye2u/EWotEYnASaj
 ZbOWI/xkI+YYykfTobHjhN3RQBG0+DLZO/WjADj6Ek83pbg1Lbi0uQZfpa+aqTpfmv+T
 wqzIpVEyxt/hiYUDhbVYBYwfxm+BebQI14H0DEwFMIqLhvjPGiiHGHn8j1LQCva7vxh4
 Zghg==
X-Gm-Message-State: AOJu0YyfA6uP5wzueqIKpW0fSyzYFXrt4B5YeXer+JJszRYulAm8KxZy
 InT8Lnzsdquh6p1y116a5QgE9OoLviyKartJ8795Yw==
X-Google-Smtp-Source: AGHT+IEhrrP7Izjv87z7abjvUJnMFM975p06dSYAkXThEgXkznFoT/6255e4+SbAZFaEwNwSzn3QUw==
X-Received: by 2002:a05:620a:2aef:b0:778:9824:4b6c with SMTP id
 bn47-20020a05620a2aef00b0077898244b6cmr11887931qkb.16.1700581269414; 
 Tue, 21 Nov 2023 07:41:09 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 bk4-20020a05620a1a0400b007776c520488sm3682803qkb.9.2023.11.21.07.41.08
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:41:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v2] doc: clang: Update and correct support notes
Date: Tue, 21 Nov 2023 10:41:07 -0500
Message-Id: <20231121154107.1668976-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

At this point, clang can be used on both 32bit and 64bit targets without
issue. Make note of logic we have that will inform clang of the
architecture to build for.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Reword the segment about CROSS_COMPILE and -target per Heinrich's
  suggestion.
---
 doc/build/clang.rst | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/doc/build/clang.rst b/doc/build/clang.rst
index cc265506c2fb..09bb988e9236 100644
--- a/doc/build/clang.rst
+++ b/doc/build/clang.rst
@@ -11,14 +11,6 @@ The ARM backend can be instructed not to use the r9 and x18 registers using
 supported inline assembly is needed to get and set the r9 or x18 value. This
 leads to larger code then strictly necessary, but at least works.
 
-**NOTE:** target compilation only work for _some_ ARM boards at the moment.
-Also AArch64 is not supported currently due to a lack of private libgcc
-support. Boards which reassign gd in c will also fail to compile, but there is
-in no strict reason to do so in the ARM world, since crt0.S takes care of this.
-These assignments can be avoided by changing the init calls but this is not in
-mainline yet.
-
-
 Debian based
 ------------
 
@@ -28,14 +20,20 @@ Required packages can be installed via apt, e.g.
 
     sudo apt-get install clang
 
-Note that we still use binutils for some tools so we must continue to set
-CROSS_COMPILE. To compile U-Boot with Clang on Linux without IAS use e.g.
+We make use of the CROSS_COMPILE variable to derive the build target which is
+passed as the --target parameter to clang.
+
+The CROSS_COMPILE variable further determines the paths to other build
+tools. As assembler we use the binary pointed to by '$(CROSS_COMPILE)as'
+instead of the LLVM integrated assembler (IAS).
+
+Here is an example demonstrating building U-Boot for the Raspberry Pi 2
+using clang:
 
 .. code-block:: bash
 
     make HOSTCC=clang rpi_2_defconfig
-    make HOSTCC=clang CROSS_COMPILE=arm-linux-gnueabi- \
-         CC="clang -target arm-linux-gnueabi" -j8
+    make HOSTCC=clang CROSS_COMPILE=arm-linux-gnueabi- CC=clang -j8
 
 It can also be used to compile sandbox:
 
-- 
2.34.1

