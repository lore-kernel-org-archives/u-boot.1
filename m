Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C94E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C92089698;
	Mon,  9 Dec 2024 17:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MQKP5ID8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30FB1896F9; Mon,  9 Dec 2024 17:28:50 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8CA89490
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-84198252db1so151129439f.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761726; x=1734366526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lNtQmbt5atseoMTBwuE8KywiTNFVdo9upyhbOuwLGSk=;
 b=MQKP5ID84rv/HNfTNWhIQg5K3d3tf55hv/EjQ8MKg24IM9gvI1hRXH/KDQWnwIa8O+
 ARg3FnW8/ea+HaATLdeRgUbFZlaEd7541EAsg9RMYE7ZoyA0xUX8Pi8lp6n7xXlWoP8u
 no/3x+9cpQ590tFXFA6cZLQQMiOz58KAvG0Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761726; x=1734366526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNtQmbt5atseoMTBwuE8KywiTNFVdo9upyhbOuwLGSk=;
 b=qgOZ5R6ZymsYscom+1ljFbMxFStDOLzrCsSlwOL5BWRfjvAjNk3143RPeU4ypjnJbd
 6cXruRqB1cRbMg7UHvVnn/5h2+gY8O7M8RbMxkk5RYayoErqI9U+R7UOhrzECTNN2i3Q
 YVAB0xdvpebxQRnQUFsqtGeIXQ0RX3G1rjS9fWQBL9yF2kvbpEJZo/RFArZ4L1nqoYIt
 4VpchVYq3mIaGyvL8l8quBdeDEPK9k4anNYd3NsU7F/0GARi6xxBKizoT9Z/WMBGM1HA
 QSU6e8+xnbagyyzBSNhrSjfWcfIS8f661kXqxO5+noyUwAihvpfqEJxBz5KCkorfIa2O
 6lMA==
X-Gm-Message-State: AOJu0YwJq3i3Vqx+lDM8LOD+lFqI6qH5FqWfJHfHGeQCxHs3CeQqnyEy
 3AqrA2nN3wsLqv9vNhUgQ3xy/SP+Kc9mI4daOzBtvNOARsGzU5UjZpMhXC25w7HzsJiND/Ji6Hg
 =
X-Gm-Gg: ASbGnctyUwOAsQF20LH596qhKkI/moKH7+badz+4QfvXn5PIto5c457e8DNRgH8f3rt
 JlWjdSaDv3ixq33+j5FNOJDHHlqrkv3ShD/UNnh9Na0Zqyx2suTfdbys/daJzZFdTHO1gIc/kjN
 SNhbehyi9Ar3ZAlAmSVqnd8IBjDXV5hUJaL1uxoGCsHVSAcfQOtv3ZDMIcMx4JtMhXNRW+byFUQ
 zTJsINEpbH0moGj2TFU0yWKd/jaFZb+ASDMlUusvOOZZRDPFg2olEOFYsUAjwTWhxjBKTSJb63P
 qT++ujEoGAI=
X-Google-Smtp-Source: AGHT+IHgRa2N0HtTAFwxOusGaaCqVWqrtswVZ5CV9P0kIwC9cMR8W3dLiJb3db/p+7Nxfx1HEWfl2A==
X-Received: by 2002:a05:6602:6019:b0:844:7896:8cb4 with SMTP id
 ca18e2360f4ac-844b8804d31mr118939f.1.1733761725777; 
 Mon, 09 Dec 2024 08:28:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:28:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>, Wang Jie <dave.wang@rock-chips.com>
Subject: [PATCH 0/8] efi: Add docs and tests and a few tweaks
Date: Mon,  9 Dec 2024 09:27:53 -0700
Message-Id: <20241209162801.288363-1-sjg@chromium.org>
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

This series addresses feedback provided on the original series,
including:

- adding documentation and tests for the two new commands
- fixing an issue that somehow didn't fail in CI
- splitting up a large function into two parts
- using lmb for the allocation, instead of looking at internal tables
- dropping use of config.h

Link: https://lore.kernel.org/u-boot/20241123195616.305687-1-mjg59@srcf.ucam.org/
Link: https://patchwork.ozlabs.org/project/uboot/list/?series=433949&state=*&archive=both


Simon Glass (8):
  fdtdec: Correct devicetree symbol for EFI app
  part_find: Enable for sandbox and correct radix and calls
  doc: test: Add docs and test for part_find
  efi: Drop config.h
  cmd: Refactor part_find() into separate functions
  addr_find: Use a simple lmb allocation
  doc: test: Add docs and test for addr_find
  efi: Avoid a memory leak in efi_bind_block() on error path

 cmd/Kconfig                 |   2 +
 cmd/addr_find.c             |  41 +++-------
 cmd/part_find.c             | 153 ++++++++++++++++++++++--------------
 doc/usage/cmd/addr_find.rst |  63 +++++++++++++++
 doc/usage/cmd/part_find.rst | 119 ++++++++++++++++++++++++++++
 doc/usage/index.rst         |   2 +
 drivers/net/efi_net.c       |   1 -
 drivers/tpm/tpm2_efi.c      |   1 -
 lib/efi/efi_app_init.c      |   4 +-
 lib/fdtdec.c                |   2 +-
 test/cmd/Makefile           |   2 +
 test/cmd/addr_find.c        |  27 +++++++
 test/cmd/part_find.c        |  42 ++++++++++
 13 files changed, 367 insertions(+), 92 deletions(-)
 create mode 100644 doc/usage/cmd/addr_find.rst
 create mode 100644 doc/usage/cmd/part_find.rst
 create mode 100644 test/cmd/addr_find.c
 create mode 100644 test/cmd/part_find.c

-- 
2.34.1

