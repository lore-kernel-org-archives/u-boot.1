Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C847DC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B4E88548;
	Sun, 23 Jun 2024 19:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Eh5E5W5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE7688387; Sun, 23 Jun 2024 19:55:22 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACB48843A
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7ec2d71059dso142114339f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165319; x=1719770119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hlsNfOpr6kJWowq3xrUw/u+YTbHPU225EG/T5Zw9qII=;
 b=Eh5E5W5SJIvSRy0fOMYS9nBR/ZJbEMQJgqxAvUyzw4w6dGwHYaWhxV/bGiM/SC0FTm
 jCDLr1TYBTL2nZ7yxiFQrb5wc+mutEqPVeH93Q9ZPE+hO38RckmYaO0WCxW2WTqCjJ1n
 W2X9FaP9Owk1/eqMFGccp0zoWwH/3uf7oggjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165319; x=1719770119;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hlsNfOpr6kJWowq3xrUw/u+YTbHPU225EG/T5Zw9qII=;
 b=Z/xVOZ2xreaUWBzpkERmYey9oD2iB47NK79egN5eGf05vKyVnXGq+WgaaNDpn2ngAl
 nZMhmlBLNSD4nSQaxE5JpUCPgLzSEuKgtsGBSiqmUw+G0T2ErtyQij4a4aeoE5hWQ95O
 FB7ZNiBzSsT3W8WkL3x+swbBDn29Rwrjr20CWVnv0kPlxuEU9BRzsA+2o1UN4lPkK0fc
 u5z9rmsFwkQlDPglWWli1H82AgYG36bYCu4aYEaEYrzHZR2B0D1bxuzodXl/y71NUQ3W
 IHPSm5NRkD85MUAwl9CeTtlFAioopnz6FDKWw/9sdUkZJJ7DQzClhJMURH7rlc0hGQBn
 L3qA==
X-Gm-Message-State: AOJu0Yziy0Ph7PHv9tKSsNCNrf+USSXfJj4HbTivZQk+u295UDlNkXz0
 9H+I7TWLbsYyL7CAw6YkzXUMq+R/EzDzP80SlZnbMuTT9+Yp+VsMjVrTZP3KuBDNX0giQBfpl7s
 fNA==
X-Google-Smtp-Source: AGHT+IH/lk2zTzDF3B+lSJgkC2gUjWBXNP5IKvATmOps6B2fHL0YzBrO7hgI5ui2pvl3tdA48umQgA==
X-Received: by 2002:a05:6602:6b0c:b0:7eb:8cbd:16a8 with SMTP id
 ca18e2360f4ac-7f3a753c92cmr290950639f.10.1719165318870; 
 Sun, 23 Jun 2024 10:55:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Marek Vasut <marex@denx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 00/14] Tools updates for Labgrid
Date: Sun, 23 Jun 2024 11:55:01 -0600
Message-Id: <20240623175515.1466908-1-sjg@chromium.org>
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

This series includes patches to update buildman to support Labgrid
better and some minor binman fixes and improvements.

Changes in v2:
- Move the binman assume-size feature into this series

Simon Glass (14):
  binman: efi: Correct entry docs
  binman: Regenerate nxp docs
  binman: ti: Regenerate entry docs
  binman: Update the entrydocs header
  binman: Support an assumed size for missing binaries
  binman: Make Intel ME default to position 0x1000
  x86: Set up some assumed sizes for binary blobs
  buildman: Make mrproper an argument to _reconfigure()
  buildman: Make mrproper an argument to _config_and_build()
  buildman: Make mrproper an argument to run_commit()
  buildman: Avoid rebuilding when --mrproper is used
  buildman: Add a flag to force mrproper on failure
  buildman: Retry the build for current source
  buildman: Add a way to limit the number of buildmans

 arch/x86/dts/u-boot.dtsi                 |   5 +
 tools/binman/binman.rst                  |   7 ++
 tools/binman/entries.rst                 | 115 +++++++++++++-----
 tools/binman/entry.py                    |   3 +-
 tools/binman/etype/blob.py               |   7 +-
 tools/binman/etype/efi_capsule.py        |  40 +++----
 tools/binman/etype/efi_empty_capsule.py  |  22 ++--
 tools/binman/etype/intel_descriptor.py   |   2 +-
 tools/binman/etype/ti_secure.py          |  45 ++++----
 tools/binman/ftest.py                    |  28 +++++
 tools/binman/test/326_assume_size.dts    |  16 +++
 tools/binman/test/327_assume_size_ok.dts |  16 +++
 tools/buildman/builder.py                |  18 +--
 tools/buildman/builderthread.py          |  44 ++++---
 tools/buildman/buildman.rst              |   8 +-
 tools/buildman/cmdline.py                |   6 +-
 tools/buildman/control.py                | 141 ++++++++++++++++++++++-
 tools/buildman/pyproject.toml            |   6 +-
 tools/buildman/test.py                   | 121 +++++++++++++++++++
 tools/u_boot_pylib/terminal.py           |   7 +-
 20 files changed, 545 insertions(+), 112 deletions(-)
 create mode 100644 tools/binman/test/326_assume_size.dts
 create mode 100644 tools/binman/test/327_assume_size_ok.dts

-- 
2.34.1

