Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D31BC61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 11:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 986C3875F8;
	Thu, 23 Nov 2023 12:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j3OfuOuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F802875F2; Thu, 23 Nov 2023 12:02:45 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EFE875F2
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 12:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507962561adso1048992e87.0
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700737363; x=1701342163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4EBSIIBbKTuXS4bnp60vTykSYnOYa4IKm5diDZBnbn0=;
 b=j3OfuOuYWOP19KFW5V31giXfUfok27RTwRAcM9yXCPUE6M/7TTVg5PmcxTnGDJbojD
 5CAYR/2wvlqzV9PLvHb4RLKjsEcntJAPBHOF+A9+EhMLICP24Otsl+pESmvaL/MBODV2
 3+L+JAOQSSWYennnHkkFRTm2tGfz0gAyhjiiVODK8sALRTBVBm5NO1GscFEHod/WNLok
 72q9AvJoxLedZyYTTM45RLtumgBc8b6z3Nq8amzbzw0sYxAywbScyVSCo9MKyFHm1XAV
 UkNhshno21SG8tN97fsOXA0Oa0kQhGWczd7JCopF1GqtcgJPZ/WrnTmGrFg4Dd6a4dp9
 Rptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700737363; x=1701342163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4EBSIIBbKTuXS4bnp60vTykSYnOYa4IKm5diDZBnbn0=;
 b=JVf9clHQwt0f1kpib+oufMrXehlQ0Z060M0gqehPSDlINFw6eQUpT9MpVz4ssyddNg
 Z3Oj7jPSNx4VGdEQakUnGohqzpz956u59Y4vzFXToVaevJYOX+Hp3w98Mmm9qdsQHQet
 JGu0oBZORG6HRqjStUus7mdY8h0AZ15E1K/rdaY0ZFe4dSyP55pUfyHL8BwH/EscqZdI
 LZy/Hbbu9+R2RSPeVZdv3tncSc+TkeFwnM/XgyyxT7bomJbnzzHBiyrE/5XPGxQ1aqlw
 r57cfgvxeuSbDCRfVwBMFApPVc2uR6A+OwF2x5EjVM7rzK5IdJEYUMhpMMlpvx+2BlJN
 GlYg==
X-Gm-Message-State: AOJu0YxZGBatkvdMlwKsEqHn0L+AP/ws0K41fERdWBegSzM4kr0g073c
 N2mEie3g6MRtNCIVXllamgM=
X-Google-Smtp-Source: AGHT+IFF0B+nPcUDLLhPypI7tr9dLWlkOe8LJFI8/+5LfmCS+NxwQKOrtJg5cNVnQQZel/vWLWPDCw==
X-Received: by 2002:ac2:5544:0:b0:507:9ef2:fb1c with SMTP id
 l4-20020ac25544000000b005079ef2fb1cmr1852910lfk.2.1700737362462; 
 Thu, 23 Nov 2023 03:02:42 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac254a7000000b0050ab61a09f3sm156857lfk.104.2023.11.23.03.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 03:02:42 -0800 (PST)
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
Subject: [PATCH v4 0/5] Implement fastboot multiresponce
Date: Thu, 23 Nov 2023 13:02:17 +0200
Message-Id: <20231123110222.15116-1-clamor95@gmail.com>
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
Changes from v3:
 - adjust membuff_readline behavior with overflow

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

 common/console.c                  | 15 ++++--
 doc/android/fastboot-protocol.rst |  3 ++
 doc/android/fastboot.rst          |  1 +
 drivers/fastboot/Kconfig          |  7 +++
 drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
 drivers/fastboot/fb_getvar.c      | 77 +++++++++++++++++++++++++------
 drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
 include/console.h                 | 26 +++++++++++
 include/fastboot-internal.h       |  7 +++
 include/fastboot.h                | 19 ++++++++
 lib/membuff.c                     | 10 ----
 net/fastboot_udp.c                | 29 +++++++++---
 test/ut.c                         |  9 ++--
 13 files changed, 247 insertions(+), 37 deletions(-)

-- 
2.40.1

