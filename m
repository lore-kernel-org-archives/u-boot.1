Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D626C4167D
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B36987252;
	Tue,  7 Nov 2023 13:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YBINL8+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF4B5871D4; Tue,  7 Nov 2023 13:43:03 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C44183414
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so9297736a12.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699360981; x=1699965781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pv53i9bSDlNOBCGNi2DW1cMa91TX6nG8C7oxwH/ejSQ=;
 b=YBINL8+CFcCxLoe8W4hOIwDnha8yVqJDBOliQ1Yv1Io33WiR1uoOJyn4Y1/4PWFh/D
 u1BSM3p6OG9Q/NIK+OmXUhBZM5X6mUEnFtN8aq1Oa3evcqHEjd3givjJCxtpvi+HmhJM
 wnOJ6v/Gt8UARfpL1cBFkwC+wSyC3JPEvKAnQlonYLnoFN8fXTAIh9aJV11cr5xdAmOG
 27tJ03IXqEGxc6n0mmq8zvKl2f279oywy5onL6joEXttq7AoiJgaWUqQpuhv8q9NMhIH
 kXN7qv6oN2GtBPROonYQ4q3Vt8bnWTyTpWfYep+vVJc5YWTIpZspgiIsooMdIKVQwRKZ
 RsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360981; x=1699965781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pv53i9bSDlNOBCGNi2DW1cMa91TX6nG8C7oxwH/ejSQ=;
 b=ZEdCCmc1PlvIycX5I7wDKf9jbAUOODiXdP7fZ8z3ROjf/HO87vSzQM0xZ1icxk6DUm
 isatwHtOa65Hv8VtT+39mGYuAU8TErioDag0ETTchLBnArtd79W6ClyNwmb6pcp+6jYF
 rG142M6iIdxkEviboO/ZH/c11jGOIIOTo0LwuOZMK3NwjIjIHyi8TAcJzfse/XuPvYHK
 aaIdzpZU2moHwVYhdCzR7AlW9mBgVdaTlqQHLUQ4MAXrHkUfIcaEoM+87yhnde8pQOZR
 /JMTazKr4Pb+IYHpP9Yy1D66/cWW7mkTrBHhwTp/xorCZP7tYA6sUfQPtZoHQzLEzJvt
 HGJA==
X-Gm-Message-State: AOJu0YxLJFt+WgRhMEwLnU0Jrxzw7VtV4zw56OGpfqlDkco3f9yMLhk4
 5K6Tok5Sy7BBKJTOA2ZIfPU=
X-Google-Smtp-Source: AGHT+IG/XKQ0F1kmZX4WQknP9vjpenYiMuL5hMg/f2fM8CNB/axjp9wtT/2Fpt2NUE2HUeZIKG9Q1w==
X-Received: by 2002:a50:aada:0:b0:543:75cb:2149 with SMTP id
 r26-20020a50aada000000b0054375cb2149mr16232737edc.38.1699360980387; 
 Tue, 07 Nov 2023 04:43:00 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 u16-20020a509510000000b0053e89721d4esm5481831eda.68.2023.11.07.04.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:42:59 -0800 (PST)
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
Subject: [PATCH v1 0/5] Implement fastboot multiresponce
Date: Tue,  7 Nov 2023 14:42:36 +0200
Message-Id: <20231107124241.35432-1-clamor95@gmail.com>
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

Ion Agorria (5):
  fastboot: multiresponse support
  fastboot: implement "getvar all"
  commonn: console: introduce overflow and isempty calls
  lib: membuff: fix readline not returning line in case of overflow
  fastboot: add oem console command support

 boot/bootmeth_extlinux.c          |  2 +-
 common/console.c                  | 17 +++++--
 doc/android/fastboot-protocol.rst |  3 ++
 doc/android/fastboot.rst          |  1 +
 drivers/fastboot/Kconfig          |  7 +++
 drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
 drivers/fastboot/fb_getvar.c      | 75 +++++++++++++++++++++++++------
 drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
 include/console.h                 | 14 ++++++
 include/fastboot-internal.h       |  7 +++
 include/fastboot.h                |  9 ++++
 include/membuff.h                 |  5 ++-
 lib/membuff.c                     |  4 +-
 net/fastboot_udp.c                | 25 ++++++++---
 test/ut.c                         |  9 ++--
 15 files changed, 226 insertions(+), 33 deletions(-)

-- 
2.40.1

