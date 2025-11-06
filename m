Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DC9CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 818C983B98;
	Thu,  6 Nov 2025 14:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="L01DFOAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4834583B85; Thu,  6 Nov 2025 12:12:41 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546D383B5F
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 12:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-429b7eecf7cso571633f8f.0
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 03:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762427558; x=1763032358;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RNz/JXJvqWgIzVJrgO885d5y+sKiDYZZznDeVle91NM=;
 b=L01DFOAZlipAfLB1aUb7Ms3c8gaG7DCF1mFZQDyEzrb4yZXA/W+QjkfOJfB5aE3JTW
 /7HZOD/sfXU1UQwM21Ve6CRU11BoMCj87Ks8Uzk8ihwmP9rAZ4LDkRE2RZ6ZOCsD6hcz
 wUdbkoQ96nlEcNHC2CkdjzUNNotSANkAeIoGlBZR57isVfmu2oD3NqFLF+0YB9+H9cTi
 C27/8xGlo8shyrSq6DO/dtXNwB1JYXoM89KXdFIRClRny6rDTLOIFdqztkMEHOwLh09L
 fzIgTRwD5K5Qcoq9+9mDTYhDvWLNGrK3HOJ4q8gYPU42vqcqtEVMXKwjwn9MB+dcPpX0
 HREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762427558; x=1763032358;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNz/JXJvqWgIzVJrgO885d5y+sKiDYZZznDeVle91NM=;
 b=aHANmS3WhMAFldNbaU1bOi4WsbmU/MVw++fb4IMDdqgbzdJ8J/0g6ELwnvIIWqCGS9
 yywLoKp1IHtK1u5B8LWRDwROEEll016oFWJTFImnElSRZnY/GJw9ViYPwew8mA/OqRX9
 pLgsGJVzh94F7ldkw6Hihhp1HqJMZ+VOTsnO82w8SdqXBMBQ6eZftCLGVDxUj4mYqgTs
 3EI+4KQnE2/EPrFHcwVVvc6LePOyYKXnSQIS6fqtaUy8Vn7yN2wlrfGJ/zcJQhFwo2v+
 1gtkDTVtvM8pVerXoFllRKouJjdRlAXM4Dk/DU2REa5XkiMp98PHO6FjTnWyx+7vW2WH
 bD9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdVWmV5l7e9+ZfEYcYsoxId0pWFyncfIBpdCdxkZOHJISCdO/ziM2cnR6HYfeXLTEk7csbgOI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8RhtRTKQSXFda3XX/DhtDs9aDzqJ1f5qN0xVseCDAojLX6Bf2
 Sr7SZtkyrQvGRVNa3aQgzXEbWglYFxlnP6J8sz+udtnOd9g9iotPuK8B3+YTt+lCRE8cxIBIE4+
 lQpH6
X-Gm-Gg: ASbGncuo4hu02MYk0gum4WlYKKxFlEuJlWeFI/yqfaqBKILCAbCgECpbF+MJqkfrrkl
 7jCKqy3sM1t62S9wz9AIP0222jjQoGgVgL3gddhXJTDC2KxsvrBu655gCSmKymiuwoZ1i9Gjiog
 PiIzmvSnBrr2AmPAON+5isi5xOkmIzyB5sI5xjhDlB05cTJMlMPyc2v6d7eIfOQsZCHwFF+4fbQ
 6o6L8eTZYJ7RBEXO7aIeP4HeHhu8qfUWLTeICDyvcyH1LE6qbN6LXOcz+nisqa7eG3LsVsC4vAy
 4V7NcdQ9rwj4D/8lJROi9jxEKSqLC2dAxooYdpujs/jwOqF993Awg2KvnOSC45zFNj9l71sVKKJ
 KAs7UIXB1CC1iYyK5fxNuarC0ihoicPu2MYMFZTpXp+MrPebSESxWL3/eRtUOuWEO96hRY1YhIN
 m4XxxXYf3Y4w==
X-Google-Smtp-Source: AGHT+IGySz5srdTbglbQfJ/WhyH5LN+7iBxvV8oWwSTrkZ4xFw5Y6HWn2fXDVD+6V0KWbDclGpQHqA==
X-Received: by 2002:a05:6000:2089:b0:429:d4e1:cb9f with SMTP id
 ffacd0b85a97d-429eb18ab6amr2773219f8f.22.1762427557750; 
 Thu, 06 Nov 2025 03:12:37 -0800 (PST)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-429eb3951c6sm4582966f8f.0.2025.11.06.03.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:12:37 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
Subject: [PATCH 0/2] mtd: rawnand: atmel: Fix ECC error on SAM9
Date: Thu, 06 Nov 2025 12:12:00 +0100
Message-Id: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICCDGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMz3YLc1ORk3URjCxPDZAvDZHMLIyWg2oKi1LTMCrA50bG1tQBa33F
 SVwAAAA==
X-Change-ID: 20251106-pmecc-a3841c81c782
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 06 Nov 2025 14:09:21 +0100
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

PMECC setup time config was lost in the porting, this patchset backports the
fix from Linux.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
Zixun LI (2):
      mtd: rawnand: atmel: set pmecc data setup time
      mtd: rawnand: atmel: Remove timing from atmel_pmecc struct

 drivers/mtd/nand/raw/atmel/pmecc.c | 6 +++++-
 drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 1c250e444ad3b15315ee8b0fcb3fc3acc26449e2
change-id: 20251106-pmecc-a3841c81c782

Best regards,
-- 
Zixun LI <admin@hifiphile.com>

