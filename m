Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6413ACD98CC
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97285848A1;
	Wed, 10 Jun 2026 16:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A37PaIkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E985848BC; Wed, 10 Jun 2026 16:37:21 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3748489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6919623d97eso492637a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102239; x=1781707039; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oUOSfsOcJEBJa5vMrlZ4T5OMO5OgvJh6SNjbo61soEE=;
 b=A37PaIkIIZ5sYnpGz7rsOlxHzurSWjWooM497hKjy9wXxlD17ZITDORRFG/ug8BGcd
 s9gG4hLQpMy7ekggX+OGagn3hY7yHtu+zTukRO1YI7gXqhkkkdLj6ZKh4N3sNM6WNJpX
 BJq1qIOkVtWgQCMDW0Jev8QNzLtXpTg1bOOYPPL72Vqygkp6SLrd6+vDKXNIt59BwzpB
 wUCWSP7/xi8gSmEubq0Bt4RDHSJMZufAigOSZH1J3tI2NWnJbsnk2ouJciVk74OPeTfW
 N8+Hxf5QbASW/Hh8keDFumGDxq9vexesL7JvmduCZ74wHX0JJIZuawEtQD7PX+oV5k8Q
 ihKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102239; x=1781707039;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oUOSfsOcJEBJa5vMrlZ4T5OMO5OgvJh6SNjbo61soEE=;
 b=XIe4DvCjS+RENWOi4/Tz4j7bCAf8Hx8ux9kUJjCXO+9bny5hzkxkbdJYC8CDznBDs+
 yojPq68wI1xGUkaEh3b7//8gDnMa12LPU4U49X/4W+uVJR7fV7HCujrspUYu86MbDMmI
 t366I3nCF6yT+VNAnog+TM5cbqJYRIBBC4zP3ELGkV+hL6K5/pjNHekVKp3gDro0DkgJ
 UZWSUSPJE9KQn4h38cu59JR095NsrWNkDb360af2qplxn/SVd50mkC9iTKitBlzSx1YS
 uJStPOVeGOyLf1b088GA4cGNMuB0kzLQBlB4haQQudpPKUeiKhZGdnCYAheR3I5Yef4p
 17kw==
X-Gm-Message-State: AOJu0YyFNVm80jFPWRlECokoS93xyAj/BBDWArwQXPsmFiaZ2TrfItLG
 dyzCm763fONMjXY+2D23iSEmsyVB5PvpZSpPRwMfNX5VU1qjSrEXiGJq
X-Gm-Gg: Acq92OEzlZ+HQU6g8pvYmNBvDNVQyiulVAVOFoXrGBJjVuOVhlLnNZmOSrFghs8k5RV
 oyWDB7aD2jgDEdH8hFkQRzbwPJLtamf5l0+UI8xncHsnszOkLrRHvlLKSa9vJECC/fObIOLgtCX
 KU9UTPp8qm5anKHtcfsRo8RIHf0B8+mYrHG5JWEgnVhLXnbEImdBURHIJF/rXyURSco9vraAo6m
 5m2xbKufcm1ci4VsiIqYO+RkfFpHFFWdQr+g7VRnsVimuYrGJBXjaYdBjh0TWkYDOSnDGJwPMmf
 FKKeV9sXgnOYG3fva+X6dhKBAD2uUO+T/5q3yv9p76rx7gzgOZeT4JGftNfy/xNRB5qVhhOLcVJ
 qMjeKnWe6RKSrCDnsmkRaqeK7DN1cCbZ/36HSGOJzeo+ESKSbtGPFtPE8DTu/qCnYrBEV3pY5QD
 kazCAi4eAyGeqqdpiIN06WNwiTJX2WD+f+tD1l0sCIRZFJLX0ntoCZBBwXxXeWZzfLe0p2Gn4sA
 X90Jl7Szhc=
X-Received: by 2002:a05:6402:528c:b0:68d:9b91:413a with SMTP id
 4fb4d7f45d1cf-68fa503adadmr5438070a12.3.1781102238926; 
 Wed, 10 Jun 2026 07:37:18 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-691ace58e5dsm4888328a12.8.2026.06.10.07.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:37:18 -0700 (PDT)
Message-ID: <f1736424-e480-4a3f-bca2-f7c00b56fb3a@gmail.com>
Date: Wed, 10 Jun 2026 16:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 01/18] Kconfig: boot: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "boot":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 boot/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede6..03b25923ebe3 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -653,9 +653,9 @@ config BOOTMETH_QFW
 	depends on QFW
 	default y
 	help
-	 Use QEMU parameters -kernel, -initrd, -append to determine the kernel,
-	 initial RAM disk, and kernel command line parameters to boot an
-	 operating system. U-Boot's control device-tree is passed to the kernel.
+	  Use QEMU parameters -kernel, -initrd, -append to determine the kernel,
+	  initial RAM disk, and kernel command line parameters to boot an
+	  operating system. U-Boot's control device-tree is passed to the kernel.

 config BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded"
@@ -1051,7 +1051,7 @@ config MEASURED_BOOT
 	  to use some attestation tools on your system.

 if MEASURED_BOOT
-	config MEASURE_DEVICETREE
+config MEASURE_DEVICETREE
 	bool "Measure the devicetree image"
 	default y if MEASURED_BOOT
 	help
@@ -1060,7 +1060,7 @@ if MEASURED_BOOT
 	  Therefore, it should not be measured into the TPM. In that case,
 	  disable the measurement here.

-	config MEASURE_IGNORE_LOG
+config MEASURE_IGNORE_LOG
 	bool "Ignore the existing event log"
 	help
 	  On platforms that use an event log memory region that persists
--
2.39.5

