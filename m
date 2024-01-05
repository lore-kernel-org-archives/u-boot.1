Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A969C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 07:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF1187967;
	Fri,  5 Jan 2024 08:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RRcw8p3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882B287941; Fri,  5 Jan 2024 08:22:36 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B6A8792D
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 08:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5573a920ca3so95304a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 23:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704439352; x=1705044152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l2XhcbcErHjnPahfx9h3ZSBiYuyG3Kj7YHjKPPlySms=;
 b=RRcw8p3cOgZ7H5+Ab1Zz3s7CmFoSopnpxusLoPLJ4rmWfnfLkC5kD7oEWT+ksViyYY
 A2D4an0KPm8Wa7Sy9WbAkj5P+rAdnDI67EHRtr/0pQUEWEB9fjqgYeHJPDKw5AJYS4CA
 Iyv7h+tFWDG1RK90un2qM04PYclbk2j4t/KQOx7e21um2TgqxpTlBP6Ii3q+Nsxo/dVp
 fu16oqLDk06cOCNGga5zMO/Dm6Z575hUOFSNzojhjvRGVyEQWmOQFmjY4mPtJn3ZmUeR
 yZPywNocmbfkaJ1uSliSNVWo1add3G9twMfCpaZFyQp7dbSm5ZsJ+2Zx7SjDjHJ77SgV
 q7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704439352; x=1705044152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2XhcbcErHjnPahfx9h3ZSBiYuyG3Kj7YHjKPPlySms=;
 b=TqK0agU7KaHgfbFv3qMQOAc2DlZJHp8LIdoLJMd2mxRGIxk41uaK0skD1vFUKZdHme
 +BzXcwgg8W9+cp6yw+OrtfibdYk2Sw+rwkFP9Dmf0CxdBA1MnDmuBtkjr4/2+LnE2dIN
 O+40OehZewRYPiXybAl6zMoFad70Ok3aGhJCExy2rNDH1phCFLv0s3azLemgUHjzAmb1
 Ux9Wq19qPbChiHNHHWEYgpRm++CK75RBEW6lKD4YmEDeirRg38t+jNtKQJ2G+3RvrB3V
 VYGKVoW23pGrZ986omK6sRV02Fs9nL/yf1U4dpe9lP8T02eslp6R8VJd6uHaN5uT57NO
 KWHw==
X-Gm-Message-State: AOJu0Yy+MT91diHs8th0DMcBK9GAFyeXPywRGsiToNOClL4qycBNyFvA
 d5fCP5PMGGqmO0NFd9uI/yU=
X-Google-Smtp-Source: AGHT+IGSdv5WZv8+s1PdVXBC7nAHtAwrLDZa2CTuJnwv71pqcMHXBAhH+rgmWS4EUsS7f2KFvwOpAg==
X-Received: by 2002:a50:99d7:0:b0:554:4bb2:9a6e with SMTP id
 n23-20020a5099d7000000b005544bb29a6emr1530678edb.11.1704439351524; 
 Thu, 04 Jan 2024 23:22:31 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 dd5-20020a056402312500b0055627eeb8b9sm636471edb.32.2024.01.04.23.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 23:22:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 0/7] Implement fastboot multiresponce
Date: Fri,  5 Jan 2024 09:22:05 +0200
Message-Id: <20240105072212.6615-1-clamor95@gmail.com>
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
Changes in v7:
 - fix hush/dollar bugs introduced in u-boot/next

Changes in v6:
 - remove prev console changes
 - add console_record_isempty helper
 - set record flag on init

Changes in v5:
 - restored membuff_readline behavior changed in v4

Changes in v4:
 - adjust membuff_readline behavior with overflow

Changes in v3:
 - fix missing function calls if CONFIG_CONSOLE_RECORD is not enabled

Changes in v2:
 - changed variables to static
 - fixed multiresponce for udp
 - documented use of "MORE"
 - converted #if to if (...)
---

Ion Agorria (7):
  fastboot: multiresponse support
  fastboot: implement "getvar all"
  common: console: introduce console_record_isempty helper
  common: console: record console from the beginning
  lib: membuff: fix readline not returning line in case of overflow
  fastboot: add oem console command support
  test: hush: dollar: fix bagous behavior

 boot/bootmeth_extlinux.c          |  2 +-
 common/console.c                  | 10 +++-
 doc/android/fastboot-protocol.rst |  3 ++
 doc/android/fastboot.rst          |  1 +
 drivers/fastboot/Kconfig          |  7 +++
 drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
 drivers/fastboot/fb_getvar.c      | 77 +++++++++++++++++++++++++------
 drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
 include/console.h                 | 13 ++++++
 include/fastboot-internal.h       |  7 +++
 include/fastboot.h                | 19 ++++++++
 include/membuff.h                 |  5 +-
 lib/membuff.c                     |  4 +-
 net/fastboot_udp.c                | 29 +++++++++---
 test/hush/dollar.c                | 23 ++-------
 15 files changed, 236 insertions(+), 45 deletions(-)

-- 
2.40.1

