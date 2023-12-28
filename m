Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3FAC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 18:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58B587A92;
	Thu, 28 Dec 2023 19:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbTJaUXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A7987A81; Thu, 28 Dec 2023 19:02:17 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB09879E9
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 19:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cc9fa5e8e1so64621321fa.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703786534; x=1704391334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jYJobFAjEJPr2jE6ZRljY6k8QQZfS86SoQAx+56oxpc=;
 b=QbTJaUXV09Nf7IpFTf4LXTHY+mHBNJHAzN+wMLDD3WuSd3hfVuKdkLmr9QlP50eXyt
 DtuBMfoNVV105HZPEo2mkKcWgankZPtDzatKiphth0RtkJHU99/aMUSXdHweFhe+YwuJ
 V68Ku1cVc41TJut5mebBBavsQKOfSBfYo350GqerL3CNJ3/3NYaSRo75o6Q/8oqvHCTj
 izqS+EZ8QSHKgv0WSgd/peu2qm3ml+PI7ig8RXxJ9YSj73ZcwKyKrqHFiNq8ncd+I2Bj
 Jk6z0Ti4K10RZEhNd++wXHVyzmwOep9PQ1pYWx4wsr+6AcO/25RSVczpQjaT7BnmUWzh
 kN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703786534; x=1704391334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYJobFAjEJPr2jE6ZRljY6k8QQZfS86SoQAx+56oxpc=;
 b=DvQVQJp8Vp7F6Ou/MiYHMjRQZ/+tFnIYJUQOvCwlVSr0DTR1B/Rc5EKaAk9KBz4GBv
 0PC6EHTi/z/9JJ/JJAwUy93TdDZ7aDWjgGjYCrw/PkXJA8Yfjgph5wjoYn1TO6TMyt3F
 4csYj65uvBcAJZm4sumD4mxwFLRJGO67zbBF1FxWVAZ7/bLPvtuxGWEqvBK5hr+PZKr9
 Z17VP42nMuCUFOjbQg0twlW/HX5Ebk4nNllfT9WrFTMLPgAT02YvBLph2Ky3AWqolwCn
 IHgBo43QjEfkHKvVSgMbsiG8Z15rIWp6Q5kqIipagjw6Xhy3FlWNiZSN2tfQH/PIvn8L
 uGAA==
X-Gm-Message-State: AOJu0YyooN4Jg4Cp+huMOnRQfCKkVFWQLKYe1fr/Nvw9nqLyeDhgD+BC
 eOHjFTLYCjEk64+b8k/QAQI=
X-Google-Smtp-Source: AGHT+IFyhBb+m4XoPfKFTadalkLMkfAcO7eaBx37h9D0wDGC44B/E5E0uMGbqLVyf4bsWJwHRjlUcw==
X-Received: by 2002:ac2:5934:0:b0:50e:7673:54d4 with SMTP id
 v20-20020ac25934000000b0050e767354d4mr2451358lfi.29.1703786533922; 
 Thu, 28 Dec 2023 10:02:13 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 s4-20020a056512314400b0050e6b04a5b2sm1955101lfi.251.2023.12.28.10.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:02:13 -0800 (PST)
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
Subject: [PATCH v6 0/6] Implement fastboot multiresponce
Date: Thu, 28 Dec 2023 20:01:48 +0200
Message-Id: <20231228180154.50473-1-clamor95@gmail.com>
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

Ion Agorria (6):
  fastboot: multiresponse support
  fastboot: implement "getvar all"
  common: console: introduce console_record_isempty helper
  common: console: record console from the beginning
  lib: membuff: fix readline not returning line in case of overflow
  fastboot: add oem console command support

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
 14 files changed, 233 insertions(+), 25 deletions(-)

-- 
2.40.1

