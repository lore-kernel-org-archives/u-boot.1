Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0884C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D71E87284;
	Wed, 15 Nov 2023 16:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hlVDiHO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8581B87284; Wed, 15 Nov 2023 16:39:01 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 925FB8269F
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9dd6dc9c00cso1031275466b.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700062738; x=1700667538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zcTZKM/mRHFziSuqYeGszpCEyovUDmhMgipTQCXRIrs=;
 b=hlVDiHO2DwKXMdKUE23O/WaX7lDIO8I2oMWuiOuV1FIH4fVA0aFgKkzPIOQDKjhGEP
 K3YmllcFUbEntLHem2nEJdXOV0PKp61elVa3KLeSmPfDzUvOy95Q2pP9m1GQopZlV1Bw
 XYtylHOtMgnanlI2HSCc5aWFw/QmI/IkC0NF8FzoQuZIFgfzwCZIDKUvv+s/3bwfYVKk
 7Az1/Iueq4cp2CtrA+W7abIHne3czOCISDV9tmLW1uCrN0PWqC9a/DvuoCM3bUCBC9bH
 SkpbPedNvCV/zNhbWRftd7HSinEX4UX4uOINoy5WJwEWis17qdh9+MnTXBD1VzifZQmd
 B56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700062738; x=1700667538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zcTZKM/mRHFziSuqYeGszpCEyovUDmhMgipTQCXRIrs=;
 b=xLi/BY8AK4TZbR4/GD4UOG4/0O6TSeX4c8gLrdzp+0vvXuHGikbDxDoAhH8SlCU8ai
 AkpqOHpGursiq9LzAP68LFPU7PAWXgTbMEenozr+ZSM62rXbO33w2VKewVaNeL2/jhA8
 cOb381EmXytpoF3jzaY5ESrj5X1e1BfG9u3HneLzqYqwmERQXvZgttsXkqO18fOA1I0t
 h7RSNcgqYSIkbqCzY1NF55Fg7Y/zL2Abc5FFdSy99Kx4Z9BG9VRjhZZyTv+wn+MAfokq
 qWxBUQZFo0tHcf2MhKIngC1zXptJ1OzB8jUHZihkZcHTiuNsk86EpcoC2fx7mmwBgHc2
 AY5w==
X-Gm-Message-State: AOJu0YwTps+tU8sI9xjbYUCKB/jO0XZX4p4EZ+iHsxEI1l/SLzeCMPc4
 1FZHbhw9V8X2/1FCGNs1Zsw=
X-Google-Smtp-Source: AGHT+IHN0pGDHh23TCantK5LJibtYRfpAfPda91KlOq0NojsdsYit3bKPwaGPBTYe7XzyJqC4BAr2g==
X-Received: by 2002:a17:907:7ea3:b0:9ef:c408:a4ff with SMTP id
 qb35-20020a1709077ea300b009efc408a4ffmr5454382ejc.7.1700062737875; 
 Wed, 15 Nov 2023 07:38:57 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 u10-20020a170906408a00b009e5d30422ebsm7234033ejj.101.2023.11.15.07.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 07:38:56 -0800 (PST)
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
Subject: [PATCH v2 0/5] Implement fastboot multiresponce
Date: Wed, 15 Nov 2023 17:38:31 +0200
Message-Id: <20231115153836.16537-1-clamor95@gmail.com>
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
 drivers/fastboot/fb_getvar.c      | 75 +++++++++++++++++++++++++------
 drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
 include/console.h                 | 14 ++++++
 include/fastboot-internal.h       |  7 +++
 include/fastboot.h                | 19 ++++++++
 include/membuff.h                 |  5 ++-
 lib/membuff.c                     |  4 +-
 net/fastboot_udp.c                | 29 +++++++++---
 test/ut.c                         |  9 ++--
 15 files changed, 240 insertions(+), 33 deletions(-)

-- 
2.40.1

