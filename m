Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A67C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C38875F5;
	Tue, 21 Nov 2023 19:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m2XFf5lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 582AC87253; Tue, 21 Nov 2023 19:35:35 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE0D87258
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c87acba73bso36960641fa.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700591733; x=1701196533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+l4E+tLaHc2IALRZ9BEvgf5bUkeN343I9d0PK9ASpyw=;
 b=m2XFf5lvoyOYoBUfcZSeuGWofRCtC+c06LFmaSeezEee8j6h/7opaYPK36YovynssZ
 QT24Zi1Z3L2i29Q9PfXCTyt8nyHIvX3Lx9e6X5PAWQlyXfh5Zv2mV0QXBAyrZTF4ZEVd
 j7Tg8yy7wM21WX7duPSWXzoa578h/6+K5JR92matcLWov2eEut2QEYjmT3DtPjEq2uVQ
 lc0jIutyFtcu0Gg2oYTOfJp8HToPetiOfXinUhsq7opCt53ErTpnAqpFH1BGUD7VKO0A
 lV7UJLsNJt4avoZ4P5IKb+5GkvptCjYHn4FfyVm3O1YR1P1fGkLkrHSwM12wUx3WzH+W
 Z7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700591733; x=1701196533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+l4E+tLaHc2IALRZ9BEvgf5bUkeN343I9d0PK9ASpyw=;
 b=QYquqJRTnPjTGh4RAglHpwbTnJTn2pFG3q6Ge4V0ff1wjiVI9FwPRcQxttbbT0L2rH
 2ajn/m0Szj08aMt+lNXY44MT6c1qOEXqxTgx3oOZ5wGZMiLXymLrZdiKMqwFQPYPX6Xd
 2eDW+DVfq1dKj/PFuFU/CUR/XBbntJog3xo+tpX5V4iui0Kd+bNKZuTpd7hCxnnq039C
 r2K970+GxmQz4CKQT1kMxsmBympV8Y3mX3MB4O1wi+exq+3D39dBcZS6sS4UBNjR7coZ
 Xtjz3XPqjAWLt8Gp17KGhTEWuQIzgcR52fVQztWXaA5A4hIi8w6kFXTQ2of3CuWZe1NK
 pk3A==
X-Gm-Message-State: AOJu0YxirvBnTl29OrRaeneRQqesK9JUIYPI6wEcuu7Kz26ej6cBee08
 TfczgQHj5h3yHs4ZMLCaNa8=
X-Google-Smtp-Source: AGHT+IH62WCG34V1BxxA2nuJ9ieMW/Ra1NqcRhAK9J1IMEVfsathiRsKfqH5+xbOLCVQdqGWmk7W3g==
X-Received: by 2002:a05:6512:3e06:b0:50a:a327:a463 with SMTP id
 i6-20020a0565123e0600b0050aa327a463mr90482lfv.13.1700591732295; 
 Tue, 21 Nov 2023 10:35:32 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 a22-20020ac25e76000000b0050089b26ea1sm1592862lfr.276.2023.11.21.10.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 10:35:32 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 0/5] Implement fastboot multiresponce
Date: Tue, 21 Nov 2023 20:35:05 +0200
Message-Id: <20231121183510.6451-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Currently u-boot fastboot can only send one message back to host,
so if there is a need to print more than one line messages must be
kept sending until all the required data is obtained. This behavior
can be adjusted using multiresponce ability (getting multiple lines
of response) proposed in this patch set.

Implementation of multiresponce leads to ability to dump content of
console buffer which, with use of "oem run", allows to entirely avoid
need in UART.

---
Changes from v2:
 - fix missing function calls if CONFIG_CONSOLE_RECORD is not enabled

Changes from v1:
 - changed variables to static
 - fixed multiresponce for udp
 - documented use of "MORE"
 - converted #if to if (...)
---

Ion Agorria (5):
  fastboot: multiresponse support
  fastboot: implement "getvar all"
  common: console: introduce overflow and isempty calls
  lib: membuff: fix readline not returning line in case of overflow
  fastboot: add oem console command support

 boot/bootmeth_extlinux.c          |  2 +-
 common/console.c                  | 17 +++++--
 doc/android/fastboot-protocol.rst |  3 ++
 doc/android/fastboot.rst          |  1 +
 drivers/fastboot/Kconfig          |  7 +++
 drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
 drivers/fastboot/fb_getvar.c      | 77 +++++++++++++++++++++++++------
 drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
 include/console.h                 | 26 +++++++++++
 include/fastboot-internal.h       |  7 +++
 include/fastboot.h                | 19 ++++++++
 include/membuff.h                 |  5 +-
 lib/membuff.c                     |  4 +-
 net/fastboot_udp.c                | 29 +++++++++---
 test/ut.c                         |  9 ++--
 15 files changed, 254 insertions(+), 33 deletions(-)

-- 
2.40.1

