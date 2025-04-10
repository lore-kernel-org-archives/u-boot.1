Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD893C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8BC83C14;
	Thu, 10 Apr 2025 14:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bkn+2GGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 602E983C08; Thu, 10 Apr 2025 14:43:45 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1394683B98
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d5e2260f52so6356385ab.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744289021; x=1744893821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V3q8Qz1x1WLKT9+mfKqTSBPyTSJjlSH2ANRhLtS7u7s=;
 b=Bkn+2GGMNJCSov0U+bdQGjixRYHYp/4FYF6TTnpRf0Cp5lsLIgWjqcmTWMiET3t0+/
 yLpmOXIbL4rye506UlxXOz4x7A4IVXP1Us1dGHkO8BWB+y7wNtrLc+pGsqSgJQNiUqfI
 M/qxl1E1jphjVdofep45VOqRjAOhQXX0Qys+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289021; x=1744893821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V3q8Qz1x1WLKT9+mfKqTSBPyTSJjlSH2ANRhLtS7u7s=;
 b=usiezRO3QgxxbW7zqEHYWR9SY9QFN4oh3KnOlJvO6YrrEwBAYo9w+hGLuY/OmzRZ20
 mh+N6qfBF7sR9Fi3OttcmnuSN/nIkJ/XitJIhcDjjzco0tatJBfMkmohH4QjxCtyAI4m
 pCPibV8aUUS4KG+lQBXTlYFgWKMSCTg22BUryO+fu8nuZBAzd4riSFppL9Y34Yt7dkGn
 EFb3BzmlUkmyY9Rs+vFQGC0gk15akIYtilTcUi2TM4z8xhbY4lmZBPQkPfYGEi6Hzp7K
 1PbUh5IQLRPqMJaZ1liWOVEKLWLeS+faLuLdcoRcX2nadNTfDGjnZk0BSh/S18orNXMg
 YpCw==
X-Gm-Message-State: AOJu0Yw9ZmIioWraclEnGQrSUlAY1ksSGQwsZkWmXZtNWiwq3oZ2Ord5
 R88qoKbbN0K/2JQ9lHUZ0kJs6WB7U2J/snF/ZJ98pZgs35oLqOx6z+lYzyS1CV7t0P/5wJI+K+I
 =
X-Gm-Gg: ASbGncvSbRl6qCMC7PA5zEr0AHDsHjgECAkC5jBm8S1Lhlz8AfZxBiGq6LV/v4XY2k5
 r4aexWuWGaAte3wQmSUObn+EiBWG9k6UlKfU4eKJgaeHRoTscNRi5LHtw1toa5Fw4xtrVN8WzIM
 8qoWxaxK+yaOX4hBXkwaYcDyQ2GTKEZr3Y41fRfB6JMEdRxaWpvU+rl+KUkzBbhkb+klrTWgsyd
 yRSOsBSdzeuYJBaVAFT0XUKUPlNuQnSOb920MDioukqqzDCAQ0t2sh5/afBBVCPFNiwSFvDFHxS
 AtiQwwfLTgHVOYKPO1Lsk2yAwghoctRi1dvpDMM6c7gUYEc2iLKtS12hx2omoiuWSt5zR0XeGbd
 yUA==
X-Google-Smtp-Source: AGHT+IENYrDONAYH+UMCttlCptsFqryC0dK3S+ZdRiugF9cX+IfPh9QWc2WaJKZY27/v7ZEIUhapqg==
X-Received: by 2002:a05:6e02:184a:b0:3d3:f040:5878 with SMTP id
 e9e14a558f8ab-3d7e5fec417mr19420695ab.21.1744289020904; 
 Thu, 10 Apr 2025 05:43:40 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d170e7sm729471173.32.2025.04.10.05.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:43:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/8] binman: Check code-coverage requirements
Date: Thu, 10 Apr 2025 06:42:57 -0600
Message-ID: <20250410124333.843527-1-sjg@chromium.org>
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

This series adds a cover-coverage check to CI for Binman. The iMX8 tests
are still not completed, so a work-around is included for those.

A few fixes are included for some other problems.

Changes in v2:
- Add new patch to add coverage to the requirements.txt file
- Rebase to -master

Jiaxun Yang (1):
  binman: Workaround lz4 cli padding in test cases

Simon Glass (7):
  binman: Add coverage to requirements
  binman: Exclude dist-packages and site-packages
  binman: Drop GetRootSkipAtStart()
  binman: fit: Drop unused code
  binman: Drop algo check in CheckSetHashValue()
  binman: Work around missing test coverage
  CI: Run code-coverage test for Binman

 .azure-pipelines.yml                           |  5 ++++-
 .gitlab-ci.yml                                 |  4 +++-
 tools/binman/etype/fit.py                      |  2 --
 tools/binman/etype/section.py                  | 17 -----------------
 tools/binman/ftest.py                          |  7 +++++--
 tools/binman/main.py                           |  8 +++++++-
 tools/binman/requirements.txt                  |  1 +
 tools/binman/state.py                          |  3 +--
 .../binman/test/184_compress_section_size.dts  |  1 +
 tools/u_boot_pylib/test_util.py                | 18 ++++++++++++++++--
 10 files changed, 38 insertions(+), 28 deletions(-)

-- 
2.43.0

base-commit: 8a2cf6307a2ccc09c39dde486b6d9375b78c82c2
branch: bing2
