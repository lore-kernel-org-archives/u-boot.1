Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EA7C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE4928327A;
	Fri, 18 Apr 2025 16:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nib+BvvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4755832C8; Fri, 18 Apr 2025 16:11:50 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A5B83212
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so13822225e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985506; x=1745590306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFdUmEArC4nCIPlZpQ8HD42bJlzOFpeSi8YUEv3cTGU=;
 b=Nib+BvvVD4M8t3RYAtnEYVyxguDjnuYIYKLuucw1Am2Yfs3TowHDJDvLxeAnKn2bl0
 KybF1jRltGw9u5pbza8QIt/aYWmjgYQ3oel714V9Vobcnx0BrrawRe5DRpBMpUirHICL
 adOL+1n9bosy8z4GpzWhZrmFR/vyWlXfze+9AN2dclxEDnyKhRoIZQHMWhQCUl0O8ExL
 wFvFzZYwd/oBfCiZ3CebNSntYUjEysizV3rq0d8m0/o72sN7rXm33xj8HHAtI/GjUnHI
 ASJz3U1+lyeatJ+fJPvxwHDQCbb/F6o75eEdL27Rm0qV2JdupBgNo7j6FaiDQwGe/mw5
 tStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985506; x=1745590306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFdUmEArC4nCIPlZpQ8HD42bJlzOFpeSi8YUEv3cTGU=;
 b=iNwCnoS5Xkruc4vfGHU6Pa5kOSKmIPN9K1E5tdE4ym28ZwjhUdDvoHTvPkufySLs3x
 Tw0OUgG1UXrUjdJPRB658jEvbPzwCb4PppCFgQbb1dr4KWNsWvPwIkPUlzIZ6T+MkyxL
 yZu2qXwP5nA4au4cdu89xGwZROuWv8qqh15WYYFr9gdlN80AJSa4lvhhWeHmd8FLXwGT
 xBFuDU2idEw039t29Iu15K264vJWLEb2zBSkeUrO7M1eUdSjM8Vtz+2f74Z2QqOn5TNl
 Bf0lKDUHw+lMWBwNtnWV+0QAHy18cOfMP0dyNnDnoawwbX7sn26ovewPs9vF1glBNHdD
 5QCw==
X-Gm-Message-State: AOJu0Yzk3f+vWg8YY28ycP4istcrlcskHgvsWWsd2GwIsaDbRkH15Nqx
 djqc7yaOTU9rssHCBg+nzTVBIxGMvD5jZw0tQh+z5QkDlHjczdo/3RFJ3eCk/JhOG0i5mtSZnNQ
 SxqqB9w==
X-Gm-Gg: ASbGncu6JmNnXgeohV+sXJtBAWvfHAiQviO0tGmwlmIpdLGs4EGrpb0fXh6rdwCcNDF
 jhiM21Hv7PAJiDxip2fVXgHa+JBNbTgGWUQ+rzMaEQgNdOXiObaxpsxue2MIHC6D/1w9Tttrugw
 TF+XMYtIgnd3QP6rPmHcPIzqpXFPVjOJdd0Me38Dokwnk6s+pujQMKEWuZ2C4jRJJTEEGfDPRdN
 ytiB7i2Ja3mY29AuC5OEB1m/WLfOqDoT3SxF+/zG3d9IeQIVSAWg+xk6nrrlZAghFUJbjwjLvO9
 2Kks8rhHl8Z4g7jCddLIrNETnDQqINiVjGFYCkwkKSHVwK25IA==
X-Google-Smtp-Source: AGHT+IFxhMWLR9xNRuyahSjkC/UUz8QgUZ0kFy7h4oPZiL1NMpQuVQtflvZ1d0lENEp5nyYiiW7QKQ==
X-Received: by 2002:a05:6000:43d6:20b0:390:e1c5:fe2 with SMTP id
 ffacd0b85a97d-39efbae068bmr1433143f8f.38.1744985506202; 
 Fri, 18 Apr 2025 07:11:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:45 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 16/17] MAINTAINERS: add UTHREAD
Date: Fri, 18 Apr 2025 16:09:44 +0200
Message-ID: <20250418141114.2056981-17-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

Add myself as the maintainer for the UTHREAD framework, the spawn/wait
commands and the associated tests.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v6:
- Order files in alphabetical order

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0b06e9ee24..0d8b58a12ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1824,6 +1824,15 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git topic-xhci
 F:	drivers/usb/host/xhci*
 F:	include/usb/xhci.h
 
+UTHREAD
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	cmd/spawn.c
+F:	include/uthread.h
+F:	lib/uthread.c
+F:	test/cmd/spawn.c
+F:	test/lib/uthread.c
+
 UUID testing
 M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 S:	Maintained
-- 
2.43.0

