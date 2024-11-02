Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62631E677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D534E89066;
	Sat,  2 Nov 2024 20:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e0gW45ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF3F89065; Sat,  2 Nov 2024 20:37:24 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882DA8860B
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbceb48613so20154756d6.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576241; x=1731181041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kRuSsfirHPj3DOr6tAOtCw8ea84TBwO4J+VXX+M5bXA=;
 b=e0gW45ay2YGHOO1w6kiAO+Q3BvIW9Zd8Vg3+uEK7MhM7ieTRqqYqwe8ll+lLZapsck
 naEs+6MuYPmq9xfqFhyBsnBKjBD3f1uFx83l2VMzP+xX/SIXWLEfiS3N2eCeAb8RdMyX
 UzKQY4c+nyXDx0RavyBwlTp+mA+AqhJPXXLFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576241; x=1731181041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kRuSsfirHPj3DOr6tAOtCw8ea84TBwO4J+VXX+M5bXA=;
 b=cPqoJbgIgMOm3Fx1KW8h7o7wVDhnaS0yAhTfWFT09wWAN1H5PgbkRzyzsSUQBGSHuX
 AdB1X1utW54T7KvtSD9+e6zNaONFf/SBjHtKSWsh6fViPX96dwE3bAkU/N6+5HO7rBni
 APT0AcnZydo0Si/2TUKXFWpHJwfsl8Y3dNVa2QhOVEgC3r6wN2fgvbO06VtrjkNxxkmW
 YTbPhwwTniWyXo+/3iquYJLKrjOkjvCLYJ/rsr4x9uaZaw6RuJlouBuXM2vsjRaqLd9c
 MKs02dzEa+EIzyzpmKNVih5nAScR1oVYc5r6WF552lQAok+8Kx44I63k5HHXAVnfJw1B
 /mXw==
X-Gm-Message-State: AOJu0YzSwiXbff8h+E6Bc5k8IV5Y9JtKoOMwN1N2V51ppT15D+JX2ZmS
 XbdvBWb1kn23ym8TCxPeeTGI6iL6KrP4VSxH+J1WneidLuXSo7NT/ZFRWiahHIFVi2DTGBmkRD/
 zHJAU
X-Google-Smtp-Source: AGHT+IGwtdygepsXIsvViGuLH/7HZ/HHR8uWwB5I6HIXQaZsOSvKzqCf2ZA1+NLlzpROEsDJleM3bQ==
X-Received: by 2002:a05:6214:5b85:b0:6cb:e798:5589 with SMTP id
 6a1803df08f44-6d346022456mr212426136d6.28.1730576240867; 
 Sat, 02 Nov 2024 12:37:20 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:19 -0700 (PDT)
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
Subject: [PATCH v2 00/20] test: Tidy up the test/ directory
Date: Sat,  2 Nov 2024 13:36:45 -0600
Message-ID: <20241102193715.432529-1-sjg@chromium.org>
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

Changes in v2:
- Leave the bootm rule alone, as the bootm test only runs on sandbox
- Make the test dependent on sandbox
- Add missing 'common' help in this patch instead of bloblist
- Drop patch to move bloblist into the common suite

Simon Glass (20):
  bloblist: test: Move test into common
  bloblist: test: Drop global_data declarations
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

 include/test/compression.h           |  16 ----
 test/Makefile                        |  10 ---
 test/boot/Makefile                   |   3 +
 test/{ => boot}/bootm.c              |   0
 test/cmd/Makefile                    |   1 +
 test/cmd/command.c                   | 108 +++++++++++++++++++++++++++
 test/cmd_ut.c                        |  25 +------
 test/command_ut.c                    | 104 --------------------------
 test/common.sh                       |  20 -----
 test/common/Makefile                 |   4 +
 test/{ => common}/bloblist.c         |   3 -
 test/{print_ut.c => common/print.c}  |  27 ++-----
 test/lib/Makefile                    |   6 ++
 test/{ => lib}/compression.c         |  39 ++++------
 test/{str_ut.c => lib/str.c}         |  31 +++-----
 test/{time_ut.c => lib/time.c}       |  60 +++++----------
 test/{unicode_ut.c => lib/unicode.c} |  70 +++++++----------
 test/test-main.c                     |   8 +-
 test/trace/test-trace.sh             |  64 ----------------
 19 files changed, 205 insertions(+), 394 deletions(-)
 delete mode 100644 include/test/compression.h
 rename test/{ => boot}/bootm.c (100%)
 create mode 100644 test/cmd/command.c
 delete mode 100644 test/command_ut.c
 delete mode 100644 test/common.sh
 rename test/{ => common}/bloblist.c (99%)
 rename test/{print_ut.c => common/print.c} (94%)
 rename test/{ => lib}/compression.c (95%)
 rename test/{str_ut.c => lib/str.c} (93%)
 rename test/{time_ut.c => lib/time.c} (56%)
 rename test/{unicode_ut.c => lib/unicode.c} (92%)
 delete mode 100755 test/trace/test-trace.sh

-- 
2.43.0

