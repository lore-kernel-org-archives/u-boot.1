Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7242BC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4840A88A7D;
	Wed, 31 Jul 2024 23:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="X852ypLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D0CE88A39; Wed, 31 Jul 2024 15:43:42 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEBD888A21
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-368380828d6so3717728f8f.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722433417; x=1723038217;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X4SNLmtN1TQT8JRRE39SLuFpqtgd86Bmub77WVBfnKE=;
 b=X852ypLjy6Fcl56QkmYyo4AaP+k6n8bkTK/g6zG5a4hfkmPGVVUwHFqAB0B1lVFVy3
 8/bqybbGdvQU7aYNLs7uOMgHw+TKLk9hPmZarIi+FCrbi/jAMdEcIKqjWy5nftowcMMs
 xEt4i9jTS/1dWkbWOXJeBJ42b+JkPvUFJsRB6ny1PZ1gRM/cmNIsXkl0IiUlCPEATn6P
 UtcYybbR0Nxvmrrg4SkeeEp9I9iIs6YqFwR53LSaHY0s4/VG0nSStuUmMFuNCT5BHx56
 Uan8kvLJ6nsnofiKU1P3UzyOcJVB3xRFN0b5USBsrwmYjeLAXMJeGzipaG8bED/AgCoS
 NfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722433417; x=1723038217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4SNLmtN1TQT8JRRE39SLuFpqtgd86Bmub77WVBfnKE=;
 b=es6d2APhsHApY+tKiVcbfMUvWfsd7MITFasnJdFfTkIQ9TOzp0zVPmrdtQHpB3C9cG
 IgntLOjpn53qBIcAexxq4YkibJqN9G1dzo0trKzJcYrwTi+KvaOoZmNQqH9GzKK6O9c0
 /dXun/EAQiA0AFT05rvEKvqaAryLhmFPxMV9B9O31HOW2BGbrmrVms5MbNq1r/HAvlbr
 NChtPBkmj3OzO6nMXMn5FfrkXNfpAQHKjdWC5mAcMHbfVvuItMEg+Y11RkzlyyB6/l2+
 sz1SG+XseQkbuRvjLZxs/Q/1Y5hDyYEaJHJ0YAajfHlk/gRZbMtsQQmFlJXn88IPFq2m
 Dpfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT1Ze+2d7M2o53EkWCdp5EVmRPGcTgvXsJK6RubgO56I4BGEfP421qoewwl91e7yTrnRxQ6XE=@lists.denx.de
X-Gm-Message-State: AOJu0YySta1FRisFi52ugsAEv5scKAz1x3xECgc/YHYWeLbg7oHcLnmg
 7aZlBJtRtYITRfXU1o/aJF9O1uyLC0gZxcyzJibwNnap8kfUyFeWKB9y1jGHlus=
X-Google-Smtp-Source: AGHT+IGzYi1GRt4zhbj0U8ZEQNEN2e2ow8rQ4ieAs9MFuDvLmb+WzJetbXAVN0O6qijuPTcMK94Jkw==
X-Received: by 2002:adf:ebca:0:b0:367:89b0:f58a with SMTP id
 ffacd0b85a97d-36b5d0cbd31mr8129309f8f.58.1722433416914; 
 Wed, 31 Jul 2024 06:43:36 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b29sm17063739f8f.93.2024.07.31.06.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 06:43:36 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [RFC PATCH 0/4] dm: Duplicate uclass name fix and alias improvements
Date: Wed, 31 Jul 2024 15:42:15 +0200
Message-ID: <20240731134257.686017-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 31 Jul 2024 23:11:08 +0200
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

Patch 1 is a tentative fix for duplicate uclass name issue met in
https://lists.denx.de/pipermail/u-boot/2024-July/560189.html

The idea is to use orignal class name only for sequence alias to keep this
alias function working and rename the class something else.

Patch 2 and 3 make "dm tree", "bind" and "unbind" commands to take care
of alias sequence numbering. As the alias sequence numbering is more
meanful than uclass index.

Patch 4 is the actual fix for usb gadet class.

There are some situations where uclass index and device sequence number
are misused which is not convered by this patch set, for example in
drivers/net/sandbox.c, uclass_get_device() is used which is based on
uclass index, while in the comments it says "index - The alias index
(also DM seq number)"

Zixun LI (4):
  dm: core: Add a way to specify an alt name for alias sequence
    numbering
  dm: core: Show device sequence instead in dm_dump_tree()
  cmd: bind: Use device sequence instead for driver bind/unbind
  usb: gadget: udc: Fix duplicate uclass name

 cmd/bind.c                          |  4 ++--
 drivers/core/device.c               |  3 ++-
 drivers/core/dump.c                 |  2 +-
 drivers/core/read.c                 |  7 ++++++-
 drivers/core/uclass.c               | 11 +++++++++--
 drivers/usb/gadget/udc/udc-uclass.c |  3 ++-
 include/dm/read.h                   |  9 ++++++++-
 include/dm/uclass.h                 |  2 ++
 8 files changed, 32 insertions(+), 9 deletions(-)

--
2.45.2

