Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35273D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9892D890A8;
	Mon, 28 Oct 2024 13:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Syr9Ezc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6622E8909E; Mon, 28 Oct 2024 13:41:39 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F3189098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fabb837ddbso63068291fa.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119296; x=1730724096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wSVpy04jgfCC/yAgV8PV0BJariXUmND7uWidq09crDw=;
 b=Syr9Ezc+v/SqawtAm/3ttlOu/QEaFEqBvHIPA9A4M3hytWLH3JWsdbR+C0yK9j+A5u
 0tb2AqXK/rM+a2Cch9HcJEPuKYKz6x2gm4TD7Z4s4k4dqW1EO+6Aqbondx3d7r1TLg+X
 p+EUBIPRufyy0UAupAjVxA+Awx/AfnIUME2QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119296; x=1730724096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wSVpy04jgfCC/yAgV8PV0BJariXUmND7uWidq09crDw=;
 b=E3ygLLY3bBB/UqBfnEWxmXxktNTmrubnQAGHauP2mlF+dv7mE5okonwbL2PXIPwDhD
 SSHTiqPs+2iRyoG3qnxdWS8HmxWxH3VRpgroBW8KYL5c2P2dRZkXV78SdTGsTYoTAOyT
 9Ts1VwIbM2+Aljky14nFHZS1hiF2sk/UvS+NxMG4ISkbUTJ1Ax7NFAXy6ayA2Tfm1uea
 GzOh7v6YFgC0tUuJeb7/VBaWXRp5IpwmpL2HmADWz7ND36SEnzInQelR3UthauL4SHI2
 Sw5aO8TQmXATKwDAqMgBsRFXCanyr7eJJvPhPdUSV/EILFix362ZOZ9z/k6yhAJ7x9fM
 p3wA==
X-Gm-Message-State: AOJu0YxRsOzat6OrWzrF8KNBqeoELkvSydmFJukb6ZVsdZMxJFYk/kMD
 PAS0OlMZ4YXL9snoAuh1IQ/insCyf0BtfPBwCPxzF/9PYXpG3iql/qAoUk1FrOQBbmYUE5jc6m0
 QkQ==
X-Google-Smtp-Source: AGHT+IE/J0mstPRWwbKWfthjko4Vpnct9/2JznXCw2MoVyoAd4/MQvIvyL3PNplPFJt4oxImPKs9fg==
X-Received: by 2002:a2e:b8c9:0:b0:2fa:fdd1:be23 with SMTP id
 38308e7fff4ca-2fcbe0646e6mr52282991fa.28.1730119295931; 
 Mon, 28 Oct 2024 05:41:35 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/21] test: Tidy up the test/ directory
Date: Mon, 28 Oct 2024 13:41:05 +0100
Message-ID: <20241028124130.32072-1-sjg@chromium.org>
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

Some tests do not use the unit-test framework. Others are in a suite of
their own, for no obvious reason.

This series tidies this up.


Simon Glass (21):
  bloblist: test: Move test into common
  bloblist: test: Drop global_data declarations
  bloblist: test: doc: Move into the common suite
  test: Drop test-trace.sh and common.sh
  compression: test: Move test into lib
  compression: test: Move into the lib suite
  command_ut: test: Move test into lib
  command: test: Move into the cmd suite
  test: Update command test to use unit-test functions
  bootm: test: Move test into boot
  test: Move print_ut test into common
  test: Move print_ut into the common suite
  test: Move str_ut test into lib
  str: test: Move into the lib suite
  test: Move unicode_ut test into lib
  test: Move unicode tests into the lib suite
  test: Move time_ut test into lib
  test: Move time tests into the lib suite
  test: Update time tests to use unit-test asserts
  test: Correct display of failing test
  test: Quote test names

 doc/usage/cmd/ut.rst                 |  29 +++++--
 include/test/compression.h           |  16 ----
 test/Makefile                        |  10 ---
 test/boot/Makefile                   |   1 +
 test/{ => boot}/bootm.c              |   0
 test/cmd/Makefile                    |   1 +
 test/cmd/command.c                   | 108 +++++++++++++++++++++++++++
 test/cmd_ut.c                        |  30 +-------
 test/command_ut.c                    | 104 --------------------------
 test/common.sh                       |  20 -----
 test/common/Makefile                 |   4 +
 test/{ => common}/bloblist.c         |  47 ++++--------
 test/{print_ut.c => common/print.c}  |  27 ++-----
 test/lib/Makefile                    |   6 ++
 test/{ => lib}/compression.c         |  39 ++++------
 test/{str_ut.c => lib/str.c}         |  31 +++-----
 test/{time_ut.c => lib/time.c}       |  60 +++++----------
 test/{unicode_ut.c => lib/unicode.c} |  70 +++++++----------
 test/test-main.c                     |   8 +-
 test/trace/test-trace.sh             |  64 ----------------
 20 files changed, 240 insertions(+), 435 deletions(-)
 delete mode 100644 include/test/compression.h
 rename test/{ => boot}/bootm.c (100%)
 create mode 100644 test/cmd/command.c
 delete mode 100644 test/command_ut.c
 delete mode 100644 test/common.sh
 rename test/{ => common}/bloblist.c (93%)
 rename test/{print_ut.c => common/print.c} (94%)
 rename test/{ => lib}/compression.c (95%)
 rename test/{str_ut.c => lib/str.c} (93%)
 rename test/{time_ut.c => lib/time.c} (56%)
 rename test/{unicode_ut.c => lib/unicode.c} (92%)
 delete mode 100755 test/trace/test-trace.sh

-- 
2.43.0

