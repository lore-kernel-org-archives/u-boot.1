Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD5EC52D54
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 05:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CA388ADF;
	Thu,  1 Aug 2024 07:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mF8J8rmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BDCB88599; Thu,  1 Aug 2024 07:33:43 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3958188599
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 07:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa63so7151363a12.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722490421; x=1723095221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JDXUUWrUJqsKP9jn4YEZOcLpPmqWV7OmoCOajHM5ufs=;
 b=mF8J8rmdGrrB6GvHopxICP38QZsY08FnsjLIgYQAKtUiFhtKcWraJ3/7eO9oWRz3nJ
 Jf1AVTlsb6hJ7tssrh+ziJjJopS5uoBPCO1K25jEUclfL+/4QOypB14PBPHR9ZhUs8pF
 ug3CWv63spYsIr41jJ8DIkpBJ6/CFol1OzS+x/YtGflM+Gu7OaLEhVj3l8NK3oc2TkNy
 /XzLItavVq8GDDj63o/kYvQjig03J6FdZqrP/y35RbcAmM8D6M7CHgFFl2yRgsebNE50
 dJfxoOIO46l0Q/lGc+0YLs+gZ4kx1MBS4CGTVpZXyYb5oDY6YPgLtqFhoh8kD4zavrX2
 J3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490421; x=1723095221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDXUUWrUJqsKP9jn4YEZOcLpPmqWV7OmoCOajHM5ufs=;
 b=P0DMo2FrqbfbuWIFBvjyFd1rpbdxWRGHily8/BJg4jUSwNlTFiBNV6uVTHeGkvqsFX
 YEpQyRYUL0BKwhvQKi/xDP/cWCHYg/5bMOB/PGpDoB8gk0Dhs4z04IVWfpqUxyMJdpuC
 LZLAOC4+hwrALVW1fOscMTozRxLNYmTtdm9F4BZSofJWZ5yuTKEFdcyl89EwnBHPjA38
 YV0biBeDx71v7CwrVYm78wwP9bM3XuHCZEX4bujnDl4BF3WOepEcyVdcEuA0uwIOs2wT
 N8wqJRD4NJxljMNUA0ojs6X3GhSU0T/RC3omuJsH+Upfz8AsECoBU1lJ16RmdBELO5Wj
 yJ/A==
X-Gm-Message-State: AOJu0YxLcY1PKEanwRzFFoSf1tUsjbJBLGDdeRAWw8BL7ORtWqa8BnOP
 SuDKWRrWgCCWY7QRkdE1RW4NzDyonbt8FHeI3LEa6lmmvxor+WgK
X-Google-Smtp-Source: AGHT+IHnwxsBx5XQ1A1zZW4CXHCExleLFtuFF9tucCKtnIWPnvhvJWKVK1pO58O+x9sVVvYrmAGwUw==
X-Received: by 2002:a50:ec8d:0:b0:5a0:c6bc:9f5a with SMTP id
 4fb4d7f45d1cf-5b70187f99amr630185a12.38.1722490420272; 
 Wed, 31 Jul 2024 22:33:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3a95sm9477990a12.61.2024.07.31.22.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:33:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] video: tegra: implement ganged dsi mode
Date: Thu,  1 Aug 2024 08:33:12 +0300
Message-ID: <20240801053315.6428-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patchset implements DSI ganged mode and basically implements
the same ideas introduced by Thierry Reding for Linux Tegra DSI
driver. The Sharp LQ101R1SX01 driver is both an example of a panel
that supports ganged mode and a preparation for upstreaming the
ASUS Transformer TF701T which uses both this panel and DSI mode.

Patches were tested on ASUS TF701T which benefits most from this
change, along with other Tegra114 and Tegra30 devices. No
regressions were found; U-Boot CI passed successfully.

Svyatoslav Ryhel (3):
  video: tegra20: dc: remove DECLARE_GLOBAL_DATA_PTR use
  video: tegra20: dsi: add ganged mode support
  video: panel: add Sharp LQ101R1SX01 MIPI DSI panel driver

 drivers/video/Kconfig             |   9 +
 drivers/video/Makefile            |   1 +
 drivers/video/sharp-lq101r1sx01.c | 282 ++++++++++++++++++++++++++++++
 drivers/video/tegra20/tegra-dc.c  |   2 -
 drivers/video/tegra20/tegra-dsi.c |  95 +++++++++-
 drivers/video/tegra20/tegra-dsi.h |  15 +-
 6 files changed, 396 insertions(+), 8 deletions(-)
 create mode 100644 drivers/video/sharp-lq101r1sx01.c

-- 
2.43.0

