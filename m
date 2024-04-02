Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A94CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 09:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 848678806C;
	Tue,  2 Apr 2024 11:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hul+kBXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58D8880D6; Tue,  2 Apr 2024 11:34:44 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46F98806C
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 11:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d715638540so53367141fa.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712050482; x=1712655282;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Qb7afiUIQL9fadkLPwer5AoH5BJhFvCtjIMN4ap6OAI=;
 b=hul+kBXNFGJeF+4PK48FFpIYOI+2amwFmK9btbSmhbBco6d7QMSc8fnC4ABBvFZLkO
 Agd2szilYhxOHHEl0X9ErvgX3kqr0YxTCwilWhVGIlklOWmZqEc7jwocXzijEzkEpJx1
 YByu5HLEBWQMKyXJSs0hCKv/IQrkxSs/3z31Chrtv+U5UX11TVXDP3uqliIOf+3NXEpe
 dSlh5AIHQuHNIT7PdPjcZ/Yk30LLiqeUnvUTyyuIzDFGzFl95u+UtlJqcioUvaAlWNye
 s4pbNz1mPFLw8lqFZkIMQqxLCWNvhAWO/ZmKB1t80qNb+CojSg5eMaoE0GfjmXRkbGSA
 ssZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712050482; x=1712655282;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qb7afiUIQL9fadkLPwer5AoH5BJhFvCtjIMN4ap6OAI=;
 b=T25MWPb3D55NFAM/kqT3MdA+6QMLpVUAfpkvFhXlRrDe0oNnYT6S8ZVuXIXEXnSXM2
 jCDTusFuxk74j5OTOzxzpARNEZHdJ3OGmBM6ZKsMLqV1hGyJkvejrY+d3ikIuhtlQ23V
 /xaXhkbnrr4wfmBwSmpJoTthc2LMgy10Jcg/5jqI2qHo61YNwT/+2pdB/faY70rqOvVv
 DkiA7k6KdnmIib3zAaylYpeXX4GxZibBaTR3e6sWAHDeypctYa1p07cUpUxwwwXfJaTN
 9LME8aMXGXX9y0j7rP0R/iDixhXK7wYofyWha0E9WZVcyLb/y1nTwvk2aoqYSHtrT9iy
 gGwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD3DKJ8VWm/SHNKEfO0ZJLfbLMjVqEJicjUJsNuGlVOSIMjvEgqMIiN+nOAdaJR36gmWZeuJAAZ01Pz4ImrCvWMRv91A==
X-Gm-Message-State: AOJu0YzxfTZp9v3KL5TvakhyLpgvAUKSfYcUcxZhGifOWSQ8kCJFut+c
 TRKqi7oVlXvhUcn4aDiyBmsqmuo0+gX2q2w2ISGrxugaU4FCOciG2b+NSxLt9EU=
X-Google-Smtp-Source: AGHT+IFmB7FzsJj7AFCtSvyDT6B3BfkbX2pN7xTyHQaop9H1k4UgvhU+wzN6qQHPtBOqB67ahiSp9g==
X-Received: by 2002:a05:651c:208:b0:2d8:12a4:8c5b with SMTP id
 y8-20020a05651c020800b002d812a48c5bmr3774317ljn.16.1712050481945; 
 Tue, 02 Apr 2024 02:34:41 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d400b000000b0033ec7182673sm13645342wrp.52.2024.04.02.02.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 02:34:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-next-20240402
Date: Tue, 02 Apr 2024 11:34:38 +0200
Message-ID: <878r1wglap.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here are some developments for next including:

- Implement Qualcomm wrapper for dwc3
- Multiple sector size support for UMS
- CDC ACM gadget initialization fix
- Refactor board code from dwc3 to prepare better interrupt support
- Bugfix for for qcom-smmu when compiling with -DDEBUG

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/20143

Thanks,
Mattijs

Note: sorry for the noise, I forgot to include u-boot list in the first email.

The following changes since commit e50cb36cb5e772d5bbd30d070faedf7323406364:

  Merge branch '2024-03-19-assorted-updates' into next (2024-03-20 08:39:05 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20240402

for you to fetch changes up to 12ac51cdb788b9f8e50cbc4fa3681102882ade33:

  usb: udc: dwc3: Fold dwc3_uboot_handle_interrupt into dm_usb_gadget_handle_interrupts (2024-04-02 09:08:07 +0200)

----------------------------------------------------------------
u-boot-dfu-next-20240402

- Implement Qualcomm wrapper for dwc3
- Multiple sector size support for UMS
- CDC ACM gadget initialization fix
- Refactor board code from dwc3 to prepare better interrupt support
- Bugfix for for qcom-smmu when compiling with -DDEBUG

----------------------------------------------------------------
Caleb Connolly (4):
      usb: dwc3-generic: implement Qualcomm wrapper
      usb: gadget: CDC ACM: call usb_gadget_initialize
      usb: gadget: UMS: support multiple sector sizes
      iommu: qcom-smmu: fix debugging

Marek Vasut (2):
      usb: udc: dwc3: Fold board dm_usb_gadget_handle_interrupts() into DWC3 gadget
      usb: udc: dwc3: Fold dwc3_uboot_handle_interrupt into dm_usb_gadget_handle_interrupts

 board/purism/librem5/spl.c          |   6 ---
 board/samsung/common/exynos5-dt.c   |   6 ---
 board/st/stih410-b2260/board.c      |   6 ---
 board/ti/am43xx/board.c             |  11 ----
 cmd/usb_mass_storage.c              |   4 --
 drivers/iommu/qcom-hyp-smmu.c       |   2 +-
 drivers/usb/dwc3/core.c             |  26 ++++++---
 drivers/usb/dwc3/dwc3-generic.c     |  81 +++++++++++++++++++++++++++-
 drivers/usb/dwc3/dwc3-omap.c        |   4 +-
 drivers/usb/gadget/f_acm.c          |   9 ++++
 drivers/usb/gadget/f_mass_storage.c | 102 ++++++++++++++++++++----------------
 drivers/usb/gadget/storage_common.c |  12 +++--
 include/dwc3-omap-uboot.h           |   1 -
 include/dwc3-uboot.h                |   2 +-
 include/usb_mass_storage.h          |   1 -
 15 files changed, 178 insertions(+), 95 deletions(-)
