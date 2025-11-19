Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375B0CF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E312183FC1;
	Wed, 19 Nov 2025 15:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p2NIS/iZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9493883FB5; Wed, 19 Nov 2025 15:55:30 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76CF48004F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-44fff8c46bbso1611392b6e.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564127; x=1764168927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAh+XAli8d/gWDJAYP36CBAyay2X+patJt56UyrFIdY=;
 b=p2NIS/iZec2EfVSZ2CXTe+TDnW7A1mSv9PzR3wJT+gVNEBxDcdSdncfzPw3sjuvjpb
 CGYVCk4SxK0rWLbJQDHeTJ+aZpgQOKFJB/yR2JyYvaaJawzmryZ5CRToRi4Cc9cUGpK1
 HixdEKpWs3CXQMfJYwXczZyINgNgXObJ9HJA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564127; x=1764168927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAh+XAli8d/gWDJAYP36CBAyay2X+patJt56UyrFIdY=;
 b=TLAsNUykEeoFwf+83+eYabekmn+5Mm3Ane/VBsoRfV4QT2NBk59Ue8A0kfnWWpD287
 2bAzzbOMcRjjVx8NrseiDvrnnAGB7MyTqBlpNuQXTBrMPFajGbv/Bw1ujvhQt+vV5rdC
 kcTcV6LQLMnz/DVBHld+4gvvp1hiedboByqNLtbiAYkzZMYPcwRYXZQXPUHOPmk9J6ar
 Xscy1NqXIefZElYk0zsfzHA1Az2S8C0NXQ79FWs1tJyvu2+jK7QCwdMPakKwKrB03w97
 ewukCOoYtuc/ZzmfgIhYPrBXUtvP+ikObYrZLy2HSxTSCbjjox+7vKVKmaP7Pf/MJ9lx
 +pNw==
X-Gm-Message-State: AOJu0YyR8wiwrGjhxachyx/erZ8Q+zTZVPO5K/iIv/gQAEH+uouWaMgD
 epAXlD43YnumpGemp4fcMrmXtGPWwPEi+kI8hazfcOsMkYXQRq3azF6f/K9cPn4l7GDuvQp7bYW
 49yGEemx/Xg==
X-Gm-Gg: ASbGncv8+VTmzuNPrAE1mWwVR1lZBI9DQb1oLCyrcGJXS52rYQKgdgTNPy1NsnNWmzW
 hZUzmB5/5kWVsVIGcg5tvEqsXL7SwVq4CiLV97ZgDnH79sEw1ceCmVA0w8sp6wW+rjGA3bpZdlv
 o8dgcOM0TKtBH74a7i6pwApXORcVAu7bPDQ+9VArkBlfvQud+wU710+HUudvX/e1hIySNTNrrsZ
 tvGrn42F77IwkuZ+PPOM9Gf7JWMVwjWIB16mes8SrGw3l/9qlRf71FdcFTPbAf4kZpt4LE2N4vG
 7hBB/4fe8iEKoth4E/pWZhm+u3HrdYNvAYW0HLTXVAHSjECPYTW4OL3ZxdBFMUBDgIYqel7VNu9
 WV9SK7OjaPJWkpJF8f3Rfg5MtOFi5BH80z6kCSHOF2yQy16Vu0EPqrd/zKiEUjMplep8APzvJsW
 yYZ3JM7bHzrU2ERQdIYlQIE3As3IqSZMyOr9Wq+NjNKRV/V9qWpsrv
X-Google-Smtp-Source: AGHT+IHfv4DHxBIgin50idvBlD+CKbi4mXOs1nS6k+jvv6J29ACP4WqGZWdlinfGPcwKf9BWvyioaA==
X-Received: by 2002:a05:6808:3087:b0:44f:6d8b:5836 with SMTP id
 5614622812f47-450973bf34cmr9458018b6e.1.1763564127187; 
 Wed, 19 Nov 2025 06:55:27 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450d8c0e116sm2055497b6e.2.2025.11.19.06.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH] hikey: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:25 -0600
Message-ID: <20251119145525.843250-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Peter Griffin <peter.griffin@linaro.org>
---
 include/configs/hikey.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/hikey.h b/include/configs/hikey.h
index 36bf22b1870e..3b49079881ae 100644
--- a/include/configs/hikey.h
+++ b/include/configs/hikey.h
@@ -47,7 +47,6 @@
 				"kernel_addr_r=0x00080000\0" \
 				"fdtfile=hi6220-hikey.dtb\0" \
 				"fdt_addr_r=0x02000000\0" \
-				"fdt_high=0xffffffffffffffff\0" \
 				"initrd_high=0xffffffffffffffff\0" \
 				BOOTENV
 
-- 
2.43.0

