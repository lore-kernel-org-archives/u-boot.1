Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA85C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D8A8871D;
	Wed, 22 May 2024 16:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G6Fb8aRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D06188464; Wed, 22 May 2024 16:23:32 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5904B8883A
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f6b1ac1e90so627378b3a.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716387808; x=1716992608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NJrQZW/p15f6KtobDsahsNuhGMH08fovDSyLL11uC94=;
 b=G6Fb8aRsjf2oC9sFsIMyPBnpAqYehOmsC+XLpulGIFycSYaWEH+0xlY1wCT8nY4QOZ
 HURt2jzijtgxOFAZ8T2AqSVEFk8WEmxeEbZdPS6YDHzma6/ou1uFSWtGANlLxbXMYBjR
 bnCdo//AsXW0fQhwAWUoFEca815+Nj1KN17fd/3AyV8xS3ia3XIEJI5Pk4EoaYWHwBq1
 FdqPkiCbnhkNrZ/oDa0n/CdJLVflPZunkL+7Upo0krng9vxd/g49Mt464Prw3IaLlTvi
 r/SbgUysJRNPMD8/PTu0X83ZuTUaiNUyONQI1djJXbIOWIJt6rSru+L4Rw9BrV3eLapo
 CJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716387808; x=1716992608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NJrQZW/p15f6KtobDsahsNuhGMH08fovDSyLL11uC94=;
 b=BWS+sqckG2KddO45uwDwWiTvEFNzKgbJSJFucQsBhyqn5Fvl0C8KFY1G1UHJYN7e1s
 5BSzaMVpyqnkfBAleq8jfvQWBbDFx5/Q+56hobHaAlQi0g6SnW+a6z9qv6ajYcSzHSFf
 Ennl5V+d5iXTNCyYtUhymM3SQBu6aXk5eajZLWgOQp/BJngNRsmo31CQXSm6BL7tDaN2
 HtsEa+Hcoin9boOG5gczxPPlZemGhU+JCDRppNZueIuH0vsQABkF0b2h3/t5VZEv4E0S
 2EhqiDihZW+6bKPBmodntTDbZHcM0+kWHF0mbcgweNak3M04v51DhAun7y/FA5aftMnp
 Ba/g==
X-Gm-Message-State: AOJu0Yx+cNFsFOjCUR9b3RB14h43cpuRpugW5682J+WAHAbeNpIsElgp
 Ihlx3+I7hXiERu31x6S+sNQi/F7g802JJyQiz8vc59ESYgTDXi+6uVFMLUB0GKs=
X-Google-Smtp-Source: AGHT+IFopAhYSeEIb4Tyv5+lgohIjx7hxWVr/8vKFl2iNC7kMqLaexSrvrOAuxUby/DYzgEXPI9GIw==
X-Received: by 2002:a05:6a21:788e:b0:1af:37bf:d7de with SMTP id
 adf61e73a8af0-1b1f8045d48mr3305480637.7.1716387808040; 
 Wed, 22 May 2024 07:23:28 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6596fde8fa7sm9410942a12.13.2024.05.22.07.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:23:27 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] usb: dwc2: Refactor and update USB DWC2 driver
Date: Wed, 22 May 2024 22:22:47 +0800
Message-ID: <20240522142311.17351-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
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

This series improves the USB DWC2 driver by extracting register definitions
into a common file for better readability and updating the reset method to
reflect changes in version 4.20a, including the new GRSTCTL_CSFTRST_DONE
bit for reset completion indication.


Kongyang Liu (2):
  usb: dwc2: Extract USB DWC2 register definitions
  usb: dwc2: Update reset method for host and device mode

 drivers/usb/common/Makefile                |   2 +
 drivers/usb/common/dwc2_core.c             | 103 +++
 drivers/usb/common/dwc2_core.h             | 557 ++++++++++++++++
 drivers/usb/gadget/dwc2_udc_otg.c          | 124 ++--
 drivers/usb/gadget/dwc2_udc_otg_regs.h     | 247 +------
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 306 ++++-----
 drivers/usb/host/dwc2.c                    | 392 +++++------
 drivers/usb/host/dwc2.h                    | 736 ---------------------
 8 files changed, 1039 insertions(+), 1428 deletions(-)
 create mode 100644 drivers/usb/common/dwc2_core.c
 create mode 100644 drivers/usb/common/dwc2_core.h

-- 
2.41.0

