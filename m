Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEFAE9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 13:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B17A864AD;
	Thu,  5 Oct 2023 15:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kR43qsGF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E24D86CC9; Thu,  5 Oct 2023 15:05:23 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DC386CD9
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 15:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-405497850dbso8610985e9.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696511069; x=1697115869;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lvcYIbm/mguCW80tK50Uyrd54fm3HM3fSbiIrS0WdeQ=;
 b=kR43qsGFzkp7p2CvBAPJ4//5Cfi8uLQWyTONte+MFYyPSqy0n/RjYJ3oWwFWBLBWR+
 +wkl2cjGx3Lc1XzRUkRgSzT5II4ekjObc4843wE34QbWvv7mKgG+jNfxkpB9yJGQzycH
 WYqwVAtLYxQC/4p7ns2fB+3V/keGcmdIE94sjoCkO+6RT4gD2KOHVYLZrxaqIjQT3IIH
 ZEFrb3kmoQ9KQ+QQD0dbLEfuckhNXzHOKziatxe7APqsHgDIysPPGvhu2POiEUTEf+RW
 5bHBWgrLndjMU9zcANAleiMG20EkdddPIBwY3295BfJVDWUXyGDqGoE2MrlKFcXCZKQN
 PzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696511069; x=1697115869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvcYIbm/mguCW80tK50Uyrd54fm3HM3fSbiIrS0WdeQ=;
 b=tQP/zb/b+wR9AdCw1G08+wr8XeAbScSx34xdlAa0UnLvbhv81sfgiZiA/PVJV7pfw1
 hIjMGKy71JFvOw7OWPFTvVNvvk7bIAjOz11D6uxTj75FOwyGWh+G8Ae0OHdX8YBjdymi
 0UVqW4RG6SX7PwaTnv50p2qSXl56aoCCFGil/onyC2evu3aHQkB/0cKZJPVYTfrx0RCL
 HJMn6P4n4Mo0rsRigmprpsIlZux5E/JZpsPHA/NqA0pA/SzFXbR5T/z8P/D4mF7FuUNs
 lrS9fillP1sV6Al0FQ/GeAW4l/uPsxiKdsHUHXE1qk64yhL6BvfWt1Dxge5iE8IWlbt5
 B2+w==
X-Gm-Message-State: AOJu0Yxl8pPfYNxX7OaZXgObhbqcZO8h41dMwIWsMJSAvnI5959AjkqX
 yerhhQngZWq/6ri+d/zUXYDahv1K6lXM5JfSKf0=
X-Google-Smtp-Source: AGHT+IG+xwmcj2r8nvdIZK5Ww9PC7WhZRrhghQhQj2mSt0FaJoajXYGCtKf7Cm2zuoxDwHDAGM8wMA==
X-Received: by 2002:a05:600c:2a4e:b0:406:44fd:6ce3 with SMTP id
 x14-20020a05600c2a4e00b0040644fd6ce3mr5058851wme.38.1696511069407; 
 Thu, 05 Oct 2023 06:04:29 -0700 (PDT)
Received: from [192.168.2.35] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003fc0505be19sm1466983wmr.37.2023.10.05.06.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 06:04:29 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 05 Oct 2023 15:04:26 +0200
Subject: [PATCH 2/2] MAINTAINERS: fastboot: add Mattijs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-mattijs-usb-v1-2-7e79ab31ca49@baylibre.com>
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
In-Reply-To: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

Fastboot has been marked as orphaned since 2021.
Since I'm interested in maintaining this, assign myself.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 008c593f30ee..6790f4ddbd45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1052,7 +1052,8 @@ F:	test/common/event.c
 F:	test/py/tests/test_event_dump.py
 
 FASTBOOT
-S:	Orphaned
+M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+S:	Maintained
 F:	cmd/fastboot.c
 F:	doc/android/fastboot*.rst
 F:	include/fastboot.h

-- 
2.41.0

