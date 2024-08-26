Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8472EC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2D788B12;
	Mon, 26 Aug 2024 21:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aH0KYvUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA15288B05; Mon, 26 Aug 2024 21:11:56 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA10F88A76
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39d3636e955so14920455ab.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699511; x=1725304311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2OQFtq1kMUIaikCgl3q2khD4bZNxnwgMpxsp8CudKVs=;
 b=aH0KYvUsCJHrgMiU7iKF5zAYkgNz/yaP8poGhmCfFC9PTC9fr6i8UWqt0QkM1bYCEH
 9MueaAeu7ii23OIqElozKVBPA3TJsGyD5rGiQIl7kDoikb/eMcpd2rqHPxEnsGx0WYBJ
 dg64MJqOHqPSTsABxZDUriq5A3FvagUOr44aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699511; x=1725304311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2OQFtq1kMUIaikCgl3q2khD4bZNxnwgMpxsp8CudKVs=;
 b=aLPvfwsBjf6eKDDAnXqR529ZS8Bn8G6oKMCjRj4wb4Cuhvl+c1W0UGi1K7T3QwYSFy
 hk033kHJHkjaTwHb7KQt2/edL+V1mz2McUn0Y6h/CQT/T3uBidOIYfXu2VC1aCYwxrq8
 4pxU879og9sJj2kYrB/h2zk5jMQ3uoQGKtWDwEMqpguYOdEUnxhuDCzX0Z1hFmG035DR
 ol3RQzvOPaBYH81AqqPbCNN+zIkpwwWBIYw/skx1F6ylbCnCj4bgyT0i9kwAg2HJgjGK
 Bs3XL4JxCqziPdkkin+HaM9MgFtCikBt7pyN/nAHBetcVYzgSWVY9aDKOrJPv6zN62GU
 qf6A==
X-Gm-Message-State: AOJu0YxLiPE/i76+7CgBmIf6kxvHfNOWMUdxfQhYZelCq8hqqj5Or0Kn
 57zSei+IZGcBmCk8KRainTR+VqI1XlgHqFECSe3j7ukfTSVABYSU4x8VsPW+rEgkObzKRHkb6bw
 =
X-Google-Smtp-Source: AGHT+IGllaTC+PtFiae1tlCepT6vP/xvFFuCbQ3nryXE1BmOggaE/UMufn73uIncOQ2ywzOIC86xEA==
X-Received: by 2002:a05:6e02:1946:b0:377:14a7:fc99 with SMTP id
 e9e14a558f8ab-39e3c9ea964mr147141295ab.24.1724699511306; 
 Mon, 26 Aug 2024 12:11:51 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:11:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Rong Tao <rongtao@cestc.cn>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/15] binman: More patches to support VBE
Date: Mon, 26 Aug 2024 13:11:28 -0600
Message-Id: <20240826191143.426387-1-sjg@chromium.org>
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

This series provides a number of patches to make VBE easier to
implement, particularly with the new OF_UPSTREAM option.


Simon Glass (15):
  binman: Fix up test coverage for mkeficapsule
  binman: Correct the comment for fdtgrep
  binman: Tidy up comments for Entry.GetEntryArgsOrProps()
  binman: Tidy up comments and pylint warnings in fit
  binman: Avoid setting the image_pos attribute directly
  binman: Update fdt-list-dir to use the provided directory
  binman: fit: Avoid assuming that a FIT member is a section
  binman: fit: Set the image_pos attributes only once
  binman: fit: Refine handling of devicetrees for OF_UPSTREAM
  binman: Adjust naming for reading symbols
  binman: Add minor improvements to symbol-writing
  binman: Provide a way to set the symbol base address
  binman: Unwind the end-at-4gb special-case a little
  binman: Allow image_pos to be None when writing symbols
  binman: Make a start on an iMX8 test

 tools/binman/binman.rst                       |  19 ++-
 tools/binman/btool/fdtgrep.py                 |   3 +-
 tools/binman/elf.py                           |  14 +-
 tools/binman/elf_test.py                      |   4 +-
 tools/binman/entry.py                         |  25 ++-
 tools/binman/etype/atf_fip.py                 |   2 +-
 tools/binman/etype/blob_phase.py              |   5 +
 tools/binman/etype/cbfs.py                    |   2 +-
 tools/binman/etype/efi_capsule.py             |   2 +
 tools/binman/etype/fit.py                     | 116 ++++++++-----
 tools/binman/etype/nxp_imx8mimage.py          |   3 +-
 tools/binman/etype/section.py                 |  31 ++--
 tools/binman/ftest.py                         | 152 +++++++++++++++---
 tools/binman/image.py                         |  21 ++-
 tools/binman/image_test.py                    |   8 +-
 tools/binman/test/336_symbols_base.dts        |  23 +++
 tools/binman/test/337_symbols_base_expand.dts |  24 +++
 tools/binman/test/338_symbols_comp.dts        |  26 +++
 tools/binman/test/339_nxp_imx8.dts            |  17 ++
 19 files changed, 386 insertions(+), 111 deletions(-)
 create mode 100644 tools/binman/test/336_symbols_base.dts
 create mode 100644 tools/binman/test/337_symbols_base_expand.dts
 create mode 100644 tools/binman/test/338_symbols_comp.dts
 create mode 100644 tools/binman/test/339_nxp_imx8.dts

-- 
2.34.1

