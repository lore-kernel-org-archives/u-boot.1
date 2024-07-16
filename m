Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3866C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9012C88977;
	Tue, 16 Jul 2024 09:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cqn1gVB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6D18896A; Tue, 16 Jul 2024 09:04:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEED88875B
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso37604645e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113467; x=1721718267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aL2KxptQixbrjXVsMrJ6VhxzDS9v9q++L8Ot8MmgvTA=;
 b=Cqn1gVB4dWBjaUsoptlxKT535/1y4geBXmSLxtNBAgxMPmox/pjbNhFMuiR84D4lH8
 1ld4RXQBKwxpVDbbWNKuJG3cPIccrUvUQg3PPUsAp7DCFFENBkGjtTjGqJxkFTWooHTl
 0l6nIGku5KJdYT56JpVl1XLoIcVx84ZZzoKCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113467; x=1721718267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aL2KxptQixbrjXVsMrJ6VhxzDS9v9q++L8Ot8MmgvTA=;
 b=VfmBWwcHPe2tQ8zDcH5pxx/RGPrO9V33eVeCtPZph8QS5VUoZjs0VfmZcx/3/d9xS8
 ZgFVvgDa/OEN847KfMLq+gH0aQuZ6q9rzwSVJOZ2W1xrtVB4KrG6ONy6iQ0wOwC/cLVN
 LPdQ3a0Ao5Fzo1JewDgNtTY4/hn+Z5U+zpYvMo9F/W3w+Nv6yIEH6hcHFkYUq2t9hLVA
 nfptlYZwDJcUtfC604H4aCVCDg9bxIw01hL88Dh6QtAbXZEVQRlCOExgtxmTetkesEGb
 1uHrCXAMW+c1bTMAOx2DiCPgHHqp1hsACXk1X1WU07grj9eWHKzNYNAftT3s7yhA4a1Y
 swmw==
X-Gm-Message-State: AOJu0YxCu9TfKFBtrTQ8o33fSit2Hfnhx1tzzQnRZnb2CdgkEejL1dWW
 XV09pv833vaWza7rfxYyOPpdqitnyOAIjIZjcmU6P9JGc+1TMF2I869LCiMDJkzl9XZfJvOWVmI
 =
X-Google-Smtp-Source: AGHT+IEXJKDATh2+Zcmda3cOdJYNrqwgGnJNPyddnl1kwAgIucpX51ULzQh7wG3MtlGu8YVVLJ4wXA==
X-Received: by 2002:a05:600c:3543:b0:426:6455:f11c with SMTP id
 5b1f17b1804b1-427ba701fd3mr8965715e9.25.1721113466892; 
 Tue, 16 Jul 2024 00:04:26 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 00/14] doc: Add documentation for bootmeths
Date: Tue, 16 Jul 2024 08:04:05 +0100
Message-Id: <20240716070419.1897560-1-sjg@chromium.org>
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

This series adds some documentation about most of the bootmeths and
tidies up a few minor areas.

It also fixes a bug in network-based booting of a script.

Changes in v2:
- Add new patch to mention automatic binding of bootmeths
- Adjustments from Heinrich's comments

Simon Glass (14):
  MAINTAINERS: Rename BOOTDEVICE
  doc: Move bootstd into its own directory
  doc: Mention automatic binding of bootmeths
  doc: Add a description for bootmeth_extlinux
  doc: Add a description for bootmeth_pxe
  doc: Add a description for bootmeth_qfw
  doc: Add a description for bootmeth_cros
  doc: Add a description for bootmeth_sandbox
  bootstd: Tidy up comments on the boothmeth drivers
  bootstd: Correct handling of script from network
  doc: Add a description for bootmeth_script
  doc: Add a link to VBE from the bootstd docs
  boot: Correct indentation in efi bootmeth
  doc: Describe the bootstd settings

 MAINTAINERS                                   |  4 +-
 boot/bootmeth_efi.c                           |  3 +-
 boot/bootmeth_extlinux.c                      |  2 +-
 boot/bootmeth_qfw.c                           |  2 +-
 boot/bootmeth_sandbox.c                       |  2 +-
 boot/bootmeth_script.c                        | 53 +++++++++++--------
 doc/board/starfive/milk-v_mars_cm.rst         |  2 +-
 doc/develop/board_best_practices.rst          |  2 +-
 doc/develop/bootstd/cros.rst                  | 33 ++++++++++++
 doc/develop/bootstd/extlinux.rst              | 28 ++++++++++
 doc/develop/bootstd/index.rst                 | 15 ++++++
 .../{bootstd.rst => bootstd/overview.rst}     | 43 ++++++++++-----
 doc/develop/bootstd/pxelinux.rst              | 27 ++++++++++
 doc/develop/bootstd/qfw.rst                   | 20 +++++++
 doc/develop/bootstd/sandbox.rst               | 17 ++++++
 doc/develop/bootstd/script.rst                | 52 ++++++++++++++++++
 doc/develop/index.rst                         |  2 +-
 doc/usage/cmd/bootdev.rst                     |  2 +-
 doc/usage/cmd/bootflow.rst                    |  2 +-
 doc/usage/cmd/bootmeth.rst                    |  2 +-
 doc/usage/environment.rst                     |  2 +-
 21 files changed, 269 insertions(+), 46 deletions(-)
 create mode 100644 doc/develop/bootstd/cros.rst
 create mode 100644 doc/develop/bootstd/extlinux.rst
 create mode 100644 doc/develop/bootstd/index.rst
 rename doc/develop/{bootstd.rst => bootstd/overview.rst} (95%)
 create mode 100644 doc/develop/bootstd/pxelinux.rst
 create mode 100644 doc/develop/bootstd/qfw.rst
 create mode 100644 doc/develop/bootstd/sandbox.rst
 create mode 100644 doc/develop/bootstd/script.rst

-- 
2.34.1

