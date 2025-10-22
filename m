Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A052ACCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 12:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA1E8323A;
	Wed, 22 Oct 2025 14:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZRkR+Lpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA8B832BC; Wed, 22 Oct 2025 14:23:37 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17B0782B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 14:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b4539dddd99so1230821466b.1
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761135814; x=1761740614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uBXtJZKm4Qx6U/IGgmGVqb/7nbijCHd8cr28I/iWUNI=;
 b=ZRkR+Lpa1FGjYkQO0jRsY+goJ8Am5iSLzOYHOa5d+ygwXnY3ZMlR7Cu3Snz4swQbux
 nejgydH5Er8R5xpdzctNHqReILriGvv4Q9CGu6bv28fpbCX3qM8NV4DmW3v3Xaec2MCM
 mpjYyf7BD+77by1wd6sp53Uu9e4IzVksBEMZs5OFIxxrzyM4LnwU92lVNsE4UnfA/MvR
 klBZOoEQkhKf7ZBaZjtdtU4Drcb04AQwiLUgJ35Potb+Agsz7U8KSANMNz4EtepLEZpS
 XIXp9RbGGXtL0UL3sL3HGKK7hT5a53OWJPMPCbP0e/zQwtJPd74+Ie3O8+4WRh4t3e7Q
 yCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761135814; x=1761740614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uBXtJZKm4Qx6U/IGgmGVqb/7nbijCHd8cr28I/iWUNI=;
 b=MJMzjq4XjOiucYr+ErKWEmbNR4u1adjDNNut8K9DJeiE3d2YPn+VMI3oHTpO61/iXW
 SsYwvklVXmL0gN+eEFGDxDwuKpc1lVVaXKBYs9wzXC/hsPkEc4E6YO37T5EcqbLNLtK1
 q67HaBtj2I6l8cWJyTxXYZ7V3DlC8hbpVGYKJ5ocgZv90XKjORKKfU5uRnwv7eLtg+BC
 AWST/Gpu+opGiuxMhcpVbbjsHNjRLDeCKVtEXzRHEs/rl0yvFJ0UQIMhGsmCgKqhwIOL
 zc+KhRlNpYeliU2cumIM9v+rib22IOXHoL9v4Ta/oVudMXv8co98fJdzifEe+pCiMXEI
 L6Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+oMalijxMwPJP2NR7CEQF0pjKmc6KpNGi6GrfleWUnAL3Jjlbl3ze5gcP5UAKmQEVIPQ2dTw=@lists.denx.de
X-Gm-Message-State: AOJu0YzSBzrn2F7uC9nX2I78A1kGlL8oZ4PB+v9K4DR/lQyyDV4YzftU
 ANB91pf0UD9XMja/H6igTD+czg0D0TYUhDBKwHarufrd1TY8Bs3PqewoSJ5rxNu4TeE=
X-Gm-Gg: ASbGncsN5AEXAtAEz8tClWjBmWz5sYrPeuLP7hQcisK/ri0tJdnbbMC3paBJpUwdjIL
 snHFXobhgJce6M42YwINqO/emuZ7/al/kIWI2NH2PspYRrauR1TA46zo5AplofGIAawwi7Dgttc
 CQQ8XhElDUUltCxlSYlZXkZqC6Kl9eR1xxwZlEG8G3aQwYG5jo8pdLNqHCdES5kYPAHCDxkotKk
 NW1whzgVC20r9ZongfHckPHaQTP7umuLD2zYdWlvdwN9NkGxMvCcjPfn9BJMLX28Gu7CfoNodBs
 YsHCjz+0Qw4UOq42Jxr0GkGQAbVwYUnHqUS6hBGoZPeJ9aDaSsR6pfrDf12MLsuByLcXjgg330o
 nnZB4oXDmYWc1x+wc08q1eSHoTIpSrlwtgdd3iqm3cC3MeHDiZzSiyXJPaRRRFGxBzUsMSW09GR
 MvqLfD7gJ4A8hDRnIgm8eKcs7OtSDI2cFlwH8AUrRGjiEIvzvAhZrK4VY4XGg=
X-Google-Smtp-Source: AGHT+IGeYjmQptvspw2C6SH1KWKmQ9w1xr1WdB+LnpPhn9+MbNNr8UBUBoV99s8r7IWNASAdZZa5GQ==
X-Received: by 2002:a17:907:2686:b0:b41:873d:e218 with SMTP id
 a640c23a62f3a-b64730451abmr2355193166b.14.1761135814485; 
 Wed, 22 Oct 2025 05:23:34 -0700 (PDT)
Received: from hades.. ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65ebb499dasm1353776066b.73.2025.10.22.05.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 05:23:33 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH] makefile: Fix recursive makes
Date: Wed, 22 Oct 2025 15:23:15 +0300
Message-ID: <20251022122317.3943103-1-ilias.apalodimas@linaro.org>
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

Since the Kbuild bump to 5.1 and specifically
commit af1a9935708a ("kbuild: make -r/-R effective in top Makefile for old Make versions")
the recursion rules have changed.

'make O=/output/dir/' as well as './test/py/test.py --bd sandbox --build'
is working fine but anything that recursively called the makefile was
failing e.g 'make tests', 'make qcheck' etc, which calls a bash script
that ends up calling the makefile again.

The reason is that the internal 'sub_make_done' variable of the makefile was set
after the first pass and the output dir was never evaluated properly.
Reset the variable value if we are executing any of these tests.

Fixes: commit af1a9935708a ("kbuild: make -r/-R effective in top Makefile for old Make versions")
Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 2402f9313d8b..8cddee3c5a96 100644
--- a/Makefile
+++ b/Makefile
@@ -2666,6 +2666,10 @@ help:
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
 	@echo  'For further info see the ./README file'
 
+ifneq ($(filter tests pcheck qcheck tcheck,$(MAKECMDGOALS)),)
+export sub_make_done := 0
+endif
+
 tests check:
 	$(srctree)/test/run
 
-- 
2.43.0

