Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4B8CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C2C084659;
	Mon, 18 May 2026 00:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bbgNj+/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C2684664; Mon, 18 May 2026 00:51:35 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEBB1845E3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1821221a34.0
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058291; x=1779663091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1zTgI1iFR3M2j8tnn9EL59bYsbXgmSzQJPmW/TlcXio=;
 b=bbgNj+/M0v4JA0kat6QuRXG9rXdG+6tQqs1kJUXPpl+6q0iWd8LiFsTD8+VsC8Ke9/
 mF4D1y4xj4lt9psseCrLu6wNtsQKsPr9ZOEc9ZUjRmtaGp9VKfAFvXccPsoA4sbFPUmn
 a7ZKLX8c0ZtPsMzeDpHSdRSm5HY5qwCyGUkio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058291; x=1779663091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zTgI1iFR3M2j8tnn9EL59bYsbXgmSzQJPmW/TlcXio=;
 b=Tv9a1NE+mVr+FYISb92xxMNc/d6QGegDYRZTDojqisD7rYE8xfn/LV/Dj8qfdDKqvI
 ZH/RfU1hvmRcjK8Yoc2dGjdjMiu9Q3G9lXVYKEKiCa1JQKA/WZgxT1QW0htVtKfbeD25
 geIZorXCIgBIrTW23OVEi4mS/KU7tyv5Y+LfI5sN3xQF501xMopYCQk7Y/kwko9sPfsp
 CERweAD5/S6e/q7eGra169uKpqAQC6r7M9/ZCPyYSUdjeUZF1tg5jVrfkO08uyPi4s3X
 mW7ZJLz6mxBZzH1A3F8hUXoMCwuTixyOTXxKPRI7MJy6VdsKYgQ4u0ta4zS0ubj53W3H
 qteA==
X-Gm-Message-State: AOJu0YyVoTUWdWteU5Spbe+hAFT5f/TNmB2brz4i6gC+uEdnk0kY5dwj
 F4/JJDBd7ILd9YeYWLpvStscWg+h1TB16vVGih/C2a1R2N39FDKLD68d/FmEQAhtu//kvaU/2R2
 lcr/qRG53
X-Gm-Gg: Acq92OF6fDBxuj7dGse7nQ8Qv5ymfprS3bVx9YFn3SXS1bLctAnXUEwDO+N3IUhYeOb
 AIMOeMUKdR2mMN9/g7tZO1JExRpkSE4G1rfCeYTFeDkMtotoj6bGq3ghl+kcrlQMRxqyxGpTTdX
 1dhZ6uV5JmoVFNgWHfsLxRKshwVVmx5yhL/oihHDnbt6xoKukiohExNR+7pqwAc1qg55t4PgjIJ
 ujvVXBXYjmHClcb9k11O1jgOrkxAeEgqxTxNCOOxP1eqYQwQCLvT9jq+f8R2k9mIKtDI8Mmo77q
 71KkRgOuSi9MJSKfstoGZHQr8YWyiYPHj6SG77tzQAliZwoRpYOpcq3CEWNjyce4Xef+Mm6UAk6
 +WULySIojuUFfmrcJTOJaNiFjWPo8qBIUrRxs0zyHA4nTLcRloM2EP45ygQq+PVqPvrohADDr8z
 Ce24Mhgg8gVaqohdj40ssYymMqYwaY8TJKP6uqQRA=
X-Received: by 2002:a05:6830:6d47:b0:7de:477c:9799 with SMTP id
 46e09a7af769-7e4f2b4887dmr9189234a34.15.1779058291184; 
 Sun, 17 May 2026 15:51:31 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH 00/11] Move test/py image creation into separate per-OS modules
Date: Sun, 17 May 2026 16:50:58 -0600
Message-ID: <20260517225122.2966807-1-sjg@chromium.org>
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

test_ut.py has accumulated a setup_*_image() helper for every Linux
distribution that the bootflow tests want to boot. Each one is mostly
shell script and partition layout, so the file is large and the test
logic is hidden among image-creation details.

Move each setup function to its own module under test/py/img/, with a
shared common.py for mkdir_cond(), copy_partition() and the extlinux
helper. Each patch moves one image at a time so reviewers can see the
relocation cleanly.

While here, also redirect the generated disk images to the
persistent-data directory instead of writing them under the source
tree. The sandbox mmc, scsi and usb-flash drivers now look there first.

Further improvement are planned, such as using the context manager when
creating partitions.


Simon Glass (11):
  test: Create a common file for image utilities
  test: Move Fedora image-creation to its own file
  test: Move Armbian image-creation to its own file
  test: Move ChromeOS image-creation to its own file
  test: Move Android image-creation to its own file
  test: Move EFI image-creation to its own file
  test: Move the configuration-editor setup to its own file
  test: Add Args docstrings to img setup functions
  test: Reformat line wraps in img setup functions
  sandbox: Find disk images in the persistent-data directory
  test: Move disk images to persistent-data directory

 MAINTAINERS                      |   5 +
 drivers/mmc/sandbox_mmc.c        |  13 +-
 drivers/scsi/sandbox_scsi.c      |  15 +-
 drivers/usb/emul/sandbox_flash.c |  14 +-
 test/py/img/android.py           | 143 ++++++++
 test/py/img/armbian.py           | 132 ++++++++
 test/py/img/cedit.py             |  24 ++
 test/py/img/chromeos.py          | 153 +++++++++
 test/py/img/common.py            |  86 +++++
 test/py/img/efi.py               |  37 +++
 test/py/img/fedora.py            |  34 ++
 test/py/tests/test_ut.py         | 537 +------------------------------
 12 files changed, 662 insertions(+), 531 deletions(-)
 create mode 100644 test/py/img/android.py
 create mode 100644 test/py/img/armbian.py
 create mode 100644 test/py/img/cedit.py
 create mode 100644 test/py/img/chromeos.py
 create mode 100644 test/py/img/common.py
 create mode 100644 test/py/img/efi.py
 create mode 100644 test/py/img/fedora.py

---
base-commit: bacf09599a133f0274bc9fb8e67bfb444f057c16
branch: testc-us

-- 
2.43.0

