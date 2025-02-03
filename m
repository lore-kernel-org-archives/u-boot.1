Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8911C02195
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F34800B3;
	Mon,  3 Feb 2025 17:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VVcvZ8I2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF80800D7; Mon,  3 Feb 2025 17:27:20 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF9980079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844eb33827eso114643839f.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738600036; x=1739204836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GN9oxdPV5jD8324xpHp34MnJIFm75vK0Xq4vUCpBwCg=;
 b=VVcvZ8I2i6EhPycTlSTjHEd7T+yYewaT1ewPjqCXkD7lnb+5s9J78LG24b08IgbE4Y
 miVWDcUi+o8UkRFUQg4yAuiw8CG8q2Y9HzNdkM3SRdmLs5hZeUoK3Z3yogX2IU+FhExA
 YeNnl1TTvNeKq1Wqph/aYdCfUGqJALZuOosDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600036; x=1739204836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GN9oxdPV5jD8324xpHp34MnJIFm75vK0Xq4vUCpBwCg=;
 b=s9yoMGSMEDaRWy5UaYx9HcTsYYjVf/VpzmKcoIpMSQ2EqhPgIKMmtg8LW7UHedqe/3
 upeqA4HfSKfj37jcxHLP2k5mL97eslct8Ix5G/+/wfHrWUUVfCbuXBMzAv7eS4Idw+cy
 Jdf0oqlDCgAqYEndR3yBuUracdX7sLlhYkNry+dCojKXzc8zq3dupNZvAeNtx6j/ZhPt
 aCO1TZK7SyY2PI6bqpQu1HQFunaixiBubSTASHsNy+00/8GxA6lgrZH3+lBFaNQR99tC
 y6IxFT/xexE2QSdjOfYMZbZ4YEmus3gQigzgrakvxwvps3ges9/Jy9k1kBiuVFawxspV
 WM+w==
X-Gm-Message-State: AOJu0Ywb9Ixf0T6eQLdS4f52/kbVq+SppcUbWMKXzSEIFbrPngk4+KnO
 DQxXH0tg91/XBA1Ho6czCDP1e2JS81qQEz0vx/xSUI8y5h/+O9rqk4M2Ncc6TAr4OO1nCn5ex5k
 =
X-Gm-Gg: ASbGncsanhzWi8sobv4EqumO3wpMZtD7in4TLQiZGw1khyVcDH8Sp+DYsa7iziXBSfC
 lb1xGi+/gH5+8fXbA1ovZtyG15nvx78pn1hyyOoaOGjwPmDlRmsbdYj8qHW0XWKv0PyfkQOLWke
 Nqcq+fWHTTwPg5HqIX2oGvpBoUNGOQg8yRMtPi/nUMBB94bn7OW6ulzjyrbi9PW5kvstd7a9FY8
 BPmLtB4ws0L1HPntrvi7/Wtg3KAko/Mg5a3AG9YR5aQOaT03HqAlzbtRIOy65Fdj1d4jo0h9PtR
 xyK9AZoBCaOUM/fnlbBIDC0hCFVF72L6zONhzdh6+E40baSdqt8e
X-Google-Smtp-Source: AGHT+IHAoIsd62Rhh6ofvtSD/2iaQ7XaNFZn5t9ygLS6tkWWgiPbvN9HNEkT3YQGtDDRwW/v2kTS3Q==
X-Received: by 2002:a05:6e02:1a4c:b0:3cf:cd3c:bdfd with SMTP id
 e9e14a558f8ab-3cffe4478e9mr206337475ab.12.1738600035787; 
 Mon, 03 Feb 2025 08:27:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d01da7e688sm15935735ab.33.2025.02.03.08.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:27:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] tools: Minor clean-ups for the command library
Date: Mon,  3 Feb 2025 09:26:41 -0700
Message-ID: <20250203162704.627469-1-sjg@chromium.org>
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

This series adds comments and fixes pylint warnings in the command
library. It also introduces a new, simpler way of running a single
command.


Simon Glass (4):
  u_boot_pylib: Correct case for test_result
  u_boot_pylib: Add an exception-class for errors
  u_boot_pylib: Fix pylint warnings in command
  u_boot_pylib: Add a function to run a single command

 tools/binman/ftest.py           |  19 ++--
 tools/buildman/boards.py        |   4 +-
 tools/buildman/builder.py       |  11 ++-
 tools/buildman/builderthread.py |  31 +++---
 tools/buildman/func_test.py     |  16 ++--
 tools/buildman/toolchain.py     |   2 +-
 tools/patman/gitutil.py         |  58 ++++++------
 tools/patman/patchstream.py     |   2 +-
 tools/rmboard.py                |  25 ++---
 tools/u_boot_pylib/command.py   | 161 ++++++++++++++++++++++++--------
 tools/u_boot_pylib/tools.py     |   2 +-
 11 files changed, 204 insertions(+), 127 deletions(-)

-- 
2.43.0

