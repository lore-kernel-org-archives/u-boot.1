Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582A9CE8D40
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A0D83623;
	Fri, 14 Nov 2025 16:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HyhS2UiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E386584142; Fri, 14 Nov 2025 16:28:45 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884EC80433
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775638d819so12506765e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763134123; x=1763738923;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pIMTNXLK0EnW3YHSYty6+EavwVdpJ86AdbJXDqctkuI=;
 b=HyhS2UiHi7alwKFTmC16b2N7sEqURPyfRKwfIe8/RuOfeFthnZaxQNiwOwBmfzNQFk
 4wNVykqpxQpPgukNtkW2/mdKX5yGUWfiYSEQ2VDDJjKNhIjjIrRgyGP4NeRiF3oUF/sB
 lqcZv5AE5vcTpGpfeqLDrBYaUQJqElywci/88eBVf/pibJUNwXJBOOzK6Fwdga4GYkJD
 nxVMlsVJS82wEjrK1YcFxdiU1qQwojmBSfZ/FWWVTztqxs7KqhRgdUojBNzB8vTJwBns
 M2wktYcuitOib3NdWrInC2H90A7tbWrH1GoTPnc1CS8clgEs0bepqX5dwrLRjeb9+QV0
 KKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763134123; x=1763738923;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIMTNXLK0EnW3YHSYty6+EavwVdpJ86AdbJXDqctkuI=;
 b=iCJ649KnoKrswjxWrQQqp6AMnXSuxIH03SnLcV18a5d1y/8icFefdzCEZf3d4JlXR/
 T+rlG9uNMslOauu/Fj3CYsMSGxJtTLYot5cAQI+JZ+bWCfx7xliz2R5k7uyEnhKAZY0n
 3hKNWZOCpfCK//jQ0v9FFP0ppfCUDtAcOllDetgtg3IlB9cVlnLJqgrLF6iyJa8zLNwZ
 BWZg9IAOXX6Mt9G5UKTS+IwYqhLX5Qa5M9AX0PJN9eVuik9XDXSuRrKU//AVEUIYB2tG
 D1TLrSHw8THjNbOkJEFlrBqAdm7hOcmZ+cmAmvHC4OQWhDU+NHUAqaoLIXVuzdkCD319
 Qm6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3PKGsnvtvB5W4ezeSu45+a39pH0Y7EK1mW/ftuJSVHTni8tG5ZCDZCeAfmRkAoiF/uf5MkDw=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ3y1c1l2xjOOY5+2gypCDvuTLmML5vOuJuHt4ez0ZxEtqR7zg
 08QjuDXdaluL5fg30qo2+q/IkQ7/t5jYIixkv78/a/VmhidZCv+8sP2qYImRu3tudcOeDcmxA+r
 WvsnGook=
X-Gm-Gg: ASbGncs75D3ULvxBu1NbOuoVSKgCaZ1gFMqbeTg6y6EsfI+PwgH22/Hkp6F8CFXpTFH
 k98w7TjYou2FapZEQR7Gz4cOq0L45EQfVDRmeBxl0S1+SN7GstMVsxT1t87eD3aeXl2Rbw6GMf1
 62zK7iXwWDLaWBPxTu6d4uEAmGuXTudJMv3CxG/cQHyJ24v7XWFFogd6EiM3UB3cjL6Adz21fJE
 0dUCQ0tQfv42q3vti4f2lPyC2GjpO/nhZoUpcBZfzxjYO00Wgl59uRW1VA8S9oT1TRcuMa+sejc
 wyoRSzJ7r5AhwtQmcOQqZxOA62QuM/oJiuxVne6PAeM59Pw/qE4wwX2WWjpcJyBkIkmeyLG0Fja
 wyROiRqEvI58++kPFLNKXnpAA+ZhqKcmW/3ueccQtoct4G+8kNL0vOd2TdHziU0a3pUPoa19Avz
 njWW521Iu9x15o
X-Google-Smtp-Source: AGHT+IGRwgwpwdG1NHHVqLYfCRbX3VLZbZvh4iU9krv13CY2c8PCU7LJx2R6nkfDJuFwaSINULszWA==
X-Received: by 2002:a05:600c:1387:b0:477:7b30:a6fc with SMTP id
 5b1f17b1804b1-4778feb13femr40624555e9.30.1763134122917; 
 Fri, 14 Nov 2025 07:28:42 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:1ab:5fd8:dd9b:8e8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779524d2ffsm15741035e9.3.2025.11.14.07.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:28:42 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Subject: [PATCH v3 0/5] android: add bootconfig support
Date: Fri, 14 Nov 2025 16:28:39 +0100
Message-Id: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdKF2kC/03MQQ6CMBCF4auQWVtDx2LBlfcwLGidwiRKTUsaC
 endLaxc/i953waRAlOEW7VBoMSR/VzicqrATsM8kuBnacAalZTYCuP9Yv3seBSor4RKG+o6hHL
 4BHL8PbBHX3riuPiwHnbCfd2ZRtZS/zMJRS1aqy06pEZpdTfD+mIT6Gz9G/qc8w/BtMsLpwAAA
 A==
X-Change-ID: 20241128-bootconfig-276e247be992
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>
X-Mailer: b4 0.14.3
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

This patchset add support of android bootconfig partition[1] in u-boot.
With Android boot image v4, all androidboot.* arguments must be
passed via bootconfig instead of using the kernel commandline.

[1] https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
Changes in v3:
- fix test check
- reate subfunction for bootconfig append
- Link to v2: https://lore.kernel.org/r/20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com

Changes in v2:
- Add test
- Add new command to be able to load and read bootconfig before booting
- Somes fixes to works with sandbox test
- Link to v1: https://lore.kernel.org/all/20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com/

---
Guillaume La Roque (TI.com) (4):
      boot: android: Add sandbox memory mapping support
      boot: android: Add bootconfig support
      cmd: abootimg: Add 'get ramdisk' command
      test: abootimg: Add test for bootconfig handling

Mattijs Korpershoek (TI.com) (1):
      boot: android: import addBootConfigParameters() from AOSP

 boot/image-android.c                        | 199 ++++++++++++++++++++++++----
 cmd/abootimg.c                              |  35 ++++-
 test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++--
 3 files changed, 308 insertions(+), 34 deletions(-)
---
base-commit: bf1d8c1fec863b7da2f0d1ed4bd5526275d70dc2
change-id: 20241128-bootconfig-276e247be992

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>

