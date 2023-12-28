Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9D6C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 09:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB00879E0;
	Thu, 28 Dec 2023 10:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CtcmqMVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4006A879DF; Thu, 28 Dec 2023 10:03:02 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 885A287509
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cce70ad1a3so2484541fa.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 01:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703754179; x=1704358979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w5LFq1GrH5d3R7tAz8TvI+RrVtsFiiM6d9QDE+AbM/k=;
 b=CtcmqMVuhsD5dGP03GTXiyzpK3whEJj0HMN8tUl4Nb53qLdqqiSpVYaWLeGR6OaM3d
 MMM9EBmXLw+2E0eLEgEU+RRjLjKYLY/JMXo8DGPKWPHqnr/FRQCV+0Scn3GJbeTxEASI
 BMI22EPE8cTTG+D26Jpn9Vp85kYKa7nvlDV/M6neKtrWzKG19AAhOrbWtDw9eZLvVmBF
 pMp8zEGsLEtXFZi+4ioQyA6YV1p0Wk4Hoy0lf0bB5290WQFyq9CVXkQTzZYn0w1vuW5V
 zCCRGLKC4TfiEt2cx1wOnEieSR54KniS0FjkRQFscIfWEUAJGd4PgXmhhA0BqVYx7jMG
 gxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703754179; x=1704358979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5LFq1GrH5d3R7tAz8TvI+RrVtsFiiM6d9QDE+AbM/k=;
 b=p/6sS7P2+SDB55dILPT3RQw1SdFthJAHPtKGj/DkG7B7RszKySYYqj8bHfakRvr5F2
 gIIKDr+ydLk6qQL9Fv6VC5j2R5ldnQywt0cWlrzn3I/9LKmWb7mHtNS8pcZAzz9E6R/b
 MyW1Cdh1bX/qtJFyb7XJfIsxeLVxehRRSpLuLzZIl30Z/VsnhGa8InYssciJMu2aAIUB
 D5sHRqszAxwYet/P3bksLeTRdOunLaKKg+e7c0tnCy8EzaHqVU3M48CVoC3fors2/LSE
 MTNb8ugRLguSeKTb/QIsluSpU14mFm7TizOgajuMx9aqxZEGkpG/ZiX8JUeqOQ5qmUrq
 Qm8Q==
X-Gm-Message-State: AOJu0Yzzny2E80BH0IWrswjccbWWLLFu6vZiEIjlD/WEu3vkDu650JDJ
 M1zusKbf8BG25f5NvvyqtaM=
X-Google-Smtp-Source: AGHT+IFxuYSKRwTE+R937Xe0Gp+ZZGIzFWuKUVuPtpfm12PQOuS05KEwK9/KlU3J3ztJsMB0xhnKeQ==
X-Received: by 2002:a2e:938e:0:b0:2cc:7171:8d6f with SMTP id
 g14-20020a2e938e000000b002cc71718d6fmr3599717ljh.10.1703754178456; 
 Thu, 28 Dec 2023 01:02:58 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 n18-20020a2ebd12000000b002ccabe13852sm2475708ljq.85.2023.12.28.01.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 01:02:58 -0800 (PST)
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
Subject: [PATCH v5 0/5] Implement fastboot multiresponce
Date: Thu, 28 Dec 2023 11:02:35 +0200
Message-Id: <20231228090240.18011-1-clamor95@gmail.com>
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

