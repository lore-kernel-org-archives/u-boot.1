Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D26C369CB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 12:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E9C81E72;
	Fri, 18 Apr 2025 14:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZFJ853lV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A9E82012; Fri, 18 Apr 2025 14:51:19 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DDE819D2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 14:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-8616987c261so60739739f.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744980676; x=1745585476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VE+kf71l/IFGAs81jts9GCU9TN3UxnbQWOW+I4DHmn4=;
 b=ZFJ853lVlCtg+yPj9Hm8+6jcTS9yV4fmqGRX9Ro0K2Izq5fMrdmLK3eUaDBehVpsCd
 uIL39dIZ/TpMXjxU4QlFaJwEuseK74l4F373VBe6uHA66k9a9UzeDpGNoCDZyNYEPZLM
 M9AGCh+q4VS4qUHuGrXNI77q9g+3cQFrh4L7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744980676; x=1745585476;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VE+kf71l/IFGAs81jts9GCU9TN3UxnbQWOW+I4DHmn4=;
 b=ZMAJavK4fNPdqb+sIgYNHVTAt9UNWCVJBE8ddYwk8lbLL45ozqsP9auAnnBbi/Bxh0
 9xxQQ8iHpybut55zoIa1bW+1mVTmbKukq6ilKUtMsantBItgwQbayebRmstHWgEZoYNC
 7bMOfL+p7EI0Yu57WldV4OB2tx6WJ+Gh/XGMXUaoFOUUdL1lIcUHMcagKxPOwdKZIQ3p
 IEgD5YsIHIokhCTeiXugDpySzBvkLM+EVigGJLxTEP9nssvUVBsKRoDuN5FkQmZe+1z7
 //MUjZCeRZttnP04Eb96dJ8BqUXTuX0RnLQoRkI2RqVbisJYpF+YzK05Lb6ZKv/7xvTW
 e9fA==
X-Gm-Message-State: AOJu0Yy+1e2rbss8FndnU+d9z82a28sOowefgfOrLAqncsBeP4gLdi3J
 Eu85swNGNpQ8latv24rN8yzt1CyctzT7JdWjlhViJ5OtEtj8cRLfro44vt2K7dZ4bZjRLPjSaeM
 =
X-Gm-Gg: ASbGncvg+L5cy59sqv6ab2e8BIi97g64hUedutHbin4crdmhl9viu2f9s3q2GNw2D5R
 ZWPKWyhSVtmbStm/bpeWpNAm/7QKQrvY7TK04fEONcd9KRzZIOxkyy35EHZm8ju1feOsmka6zhR
 mz4u6aLy3im9o1ks6ipYbE3+xRaYyHvWt/hab0V3qb6rjMwjYzVIY7CTw/uxE78c9huarVJsD8e
 i/n7FJbPYyUwFHd6KDLdjC/ZKFQQlLPSOI0cfa9X9dwHQDeO/csolAkhlF/y+WmdfQeBtYuUBen
 paqwyBLb+rGxcH6ziQ+5AEq8ACtOF/pfp64uuIc+wKuz7LtDPtS5wA3gT+kaGAvu0zrwOwsjbI/
 Jew==
X-Google-Smtp-Source: AGHT+IHTWKzg/eb8Otbwx/xe4rgwGFl6b40X32tZYTeIm4hd+d9225ZWichzbex8vScQ6pZIPYlN/w==
X-Received: by 2002:a05:6602:3789:b0:85b:5869:b66 with SMTP id
 ca18e2360f4ac-861dbdc728fmr205501639f.1.1744980675710; 
 Fri, 18 Apr 2025 05:51:15 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cc0a3sm427555173.20.2025.04.18.05.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 05:51:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Date: Fri, 18 Apr 2025 06:50:59 -0600
Message-ID: <20250418125111.2193434-1-sjg@chromium.org>
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

This series restores the original behaviour of extlinux booting linux
'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
a limit of 10x the compressed size.

It also adds RISC-V support, since it uses a similar format to ARM64.

Future work should integrate the code in 'booti' into main 'bootm'
logic.


Simon Glass (3):
  boot: Add a function to check if a linux Image is supported
  bootm: Add RISC-V support in booti_is_supported()
  booti: Allow ignoring SYS_BOOTM_LEN with the booti command

 boot/bootm.c    | 31 +++++++++++++++++++++++++------
 cmd/booti.c     |  1 +
 include/bootm.h |  3 +++
 3 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0

base-commit: 5f31163c8f42c16f0035ae26d1e36e94e931fe6f
branch: fix-booti
