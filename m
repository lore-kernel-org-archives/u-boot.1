Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB7AD132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7500688DC7;
	Mon,  4 Nov 2024 14:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g+slfJze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD0188D5D; Mon,  4 Nov 2024 14:40:06 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F4210889D2
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-83ab21c26f1so173362339f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727601; x=1731332401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jhNEYiLQOx8RFHwHaE0O3cvj/xKx1oo4Bxz+6l7yeyk=;
 b=g+slfJzeryRMeEe5Pf2g8oxoXiqAm3lOIfHtryu4VdJqZzdLeJjbT6DhSlCh+s+LvM
 +f6zcu0hS2O7/qgGAn4TwDqhfygKmGe4R7XgXiqd6Fwp5FVCNtKxzxT+I/O/3GcgagpR
 IRCJ63FPJzTaJW5f451B2vmzDVVrO/IN9mumU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727601; x=1731332401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jhNEYiLQOx8RFHwHaE0O3cvj/xKx1oo4Bxz+6l7yeyk=;
 b=EJ72TJxOpSUPN8Q9eymaGOX0rzFisHYiyLOy/ViJYxNtp3OwdlFPIpQTOIN7QYFTnp
 OKzOHhtdT/UjcZP+4IsUIIkLs2i2PoF2cj4ydox8X3QirWu0Y7eWOaRVrPZfoB2OaJAe
 X/Azfv9mO0mMJY4csKJG8nW5Sujg/RA1eMPCJ1lBe8w2MfBGiRRSvDp/50CCcKZEAJxz
 iNYUW0AoDGDlZxkHFzgob03Vbu7HltlHe4iM40HfOK77qL99Jk19bjSP7XfVsf48U8JW
 gWuBOrs6/L+O+TAvZruxDLEtos8XCZo9eQulwNGqvd9wmwtTMPAU4G9MmOoEn3W9APDG
 jCUg==
X-Gm-Message-State: AOJu0Yw9uzLF/bh4tc1ajx2IeuBDueZrn9zn+ExjvEulBSXA2mAxnMXd
 3HXzfvt+F38ILHfroM2APKnP6PsU561bQonant0g7ePgh/HVSuA+X61Op+Fnjq16Lkbyf1JrNoY
 =
X-Google-Smtp-Source: AGHT+IFrte3HbjGl8Y+wSuA1lj5YsBmc3nfeeb6aEyHLiSQyb7cXC3//Da/sg6XLotA2pME06kZnhQ==
X-Received: by 2002:a05:6602:608a:b0:82c:ddfc:c57b with SMTP id
 ca18e2360f4ac-83b566ee5ecmr1921989439f.5.1730727601185; 
 Mon, 04 Nov 2024 05:40:01 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 0/9] CI: Set up for an arm64 runner
Date: Mon,  4 Nov 2024 06:39:44 -0700
Message-Id: <20241104133954.840994-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

All gitlab runners are currently amd64 machines. This series attempts to
create a docker image which can also support arm64 so that sandbox tests
can be run on it.


Simon Glass (9):
  sandbox: efi_loader: Correct use of addresses as pointers
  test: Adjust print_ut test to use unsigned char
  docker: Support building for multiple architectures
  docker: Adjust packages for arm64
  docker: Drop grub for arm64
  docker: Drop tracing for arm64
  docker: Drop coreboot for arm64
  docker: Fix LegacyKeyValueFormat warning with PYTHONPATH
  CI: Add platform variable

 .gitlab-ci.yml                        |  1 +
 arch/sandbox/cpu/cache.c              |  8 +++++-
 drivers/remoteproc/rproc-elf-loader.c | 18 +++++++-----
 lib/efi_loader/efi_image_loader.c     |  3 +-
 test/print_ut.c                       |  6 ++--
 tools/docker/Dockerfile               | 40 +++++++++++++++++++--------
 6 files changed, 52 insertions(+), 24 deletions(-)

-- 
2.34.1

