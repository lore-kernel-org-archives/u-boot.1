Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E18CC47073
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 12:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E6F87A32;
	Sun,  7 Jan 2024 13:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cg3KT5Le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB9387463; Sun,  7 Jan 2024 12:28:00 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BFB87A1A
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 12:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dc00dbb560so679813a34.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704626874; x=1705231674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIp3frhh0FrNzykLM5uS5ORJ91fdFZh233EbV7SEjCo=;
 b=Cg3KT5LeaqYxvwJNkF2nPLFc3fOHrbAH22ZbeAGxGNMgGdbkzS+Jgqp44CorNUHgC5
 Akbj1I09aQpm3dWcgOIwQVz8rHVzoS40Br1awwVAeZbEEadBWnZaLS/YIik/EQjPXFLS
 GEICXWUkKyD4OlTO2xGw2oACidQ/50FCvWopZi1dh4tLMqSUc06U1biJ0/aVyPC6bdud
 NH3DFGRaRKY0W71GRe+0IxTQvI0TChdePfPCjKPEsDShwY7i3f8EocBNvk4r+LN5urKZ
 oKOH8HmNHz93FoOIsBnCOniO+DCYIQsjCL1/WD7F26kIvrxsiToP1s/EPvLI/5mZ7qMz
 sdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704626874; x=1705231674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIp3frhh0FrNzykLM5uS5ORJ91fdFZh233EbV7SEjCo=;
 b=ViUfiazZ0aaQj7mVFnfoI9RAZgwf7hxzGLWtfHHotBPNC9YNcUiownCFO9zaK3cji4
 nxwmTTW6TJqes/+HJ8eRqQUXsxuM3X8fdLX7de7KOL5KJBOj1Xzr5nxDHSpruXrTMQKO
 S1d1UjahgY06QrbqTBHtYZCNCndYVa1x+ILhFmvl+5kig699cS1ae9ZTUC8IL5QBd5Qu
 cXGfbMlPwYnNm2RMTFODyhApGriDAmD2lPCJPO52ZdXHSUoRM7yU0FemtyIEUpx5/ong
 L+g9XpBzNMQpUpcx3ApAaTV8dMrt/1iuQezDK92sMgFXyVgZ5bkLPapPb9Mi61Rd7r3v
 oB1A==
X-Gm-Message-State: AOJu0YwW5INdeaX0aCQzZmcFNxvy997Smh2ZNNq7JR0CazCDCSRzgPmu
 NZXodtSO134tgmXdYGfNm9VMzGn5gqFubswau8o=
X-Google-Smtp-Source: AGHT+IFH+UyQIvHhlQBf6zrY6OlpTTMVxFnbjhXkFtenObdugaaJd0o8LT7aAFnKVRWZpmp6uIKLLg==
X-Received: by 2002:a05:6358:418b:b0:172:de18:c9e with SMTP id
 w11-20020a056358418b00b00172de180c9emr2308037rwc.18.1704626873998; 
 Sun, 07 Jan 2024 03:27:53 -0800 (PST)
Received: from localhost.localdomain ([120.204.188.187])
 by smtp.gmail.com with ESMTPSA id
 sf15-20020a17090b51cf00b0028d435cc2cbsm1279253pjb.15.2024.01.07.03.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 03:27:53 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Fabio Estevam <festevam@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Wei Fu <wefu@redhat.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 4/4] doc: sophgo: milkv_duo: document Milk-V Duo board
Date: Sun,  7 Jan 2024 19:27:10 +0800
Message-ID: <20240107112713.61966-5-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240107112713.61966-1-seashell11234455@gmail.com>
References: <20240107112713.61966-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jan 2024 13:25:04 +0100
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

Add document for Milk-V Duo board which based on Sophgo's CV1800B SoC.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 doc/board/index.rst            |  1 +
 doc/board/sophgo/index.rst     |  8 ++++++
 doc/board/sophgo/milkv_duo.rst | 50 ++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 doc/board/sophgo/index.rst
 create mode 100644 doc/board/sophgo/milkv_duo.rst

diff --git a/doc/board/index.rst b/doc/board/index.rst
index 531e547e7e..a0bd534742 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -45,6 +45,7 @@ Board-specific doc
    sifive/index
    sipeed/index
    socionext/index
+   sophgo/index
    st/index
    starfive/index
    ste/index
diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
new file mode 100644
index 0000000000..e097afdac6
--- /dev/null
+++ b/doc/board/sophgo/index.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Sophgo
+======
+.. toctree::
+   :maxdepth: 1
+
+   milkv_duo
diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
new file mode 100644
index 0000000000..b63304b510
--- /dev/null
+++ b/doc/board/sophgo/milkv_duo.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Duo
+==========
+
+CV1800B RISC-V SoC
+------------------
+The CV1800B is a high-performance, low-power 1+1 64-bit RISC-V SoC from Sophgo.
+
+Mainline support
+----------------
+The support for following drivers are already enabled:
+1. ns16550 UART Driver.
+
+Building
+~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+   cd <U-Boot-dir>
+   make milkv_duo_defconfig
+   make
+
+This will generate u-boot-dtb.bin
+
+Booting
+~~~~~~~
+Currently, we rely on vendor FSBL(First Stage Boot Loader) to initialize the
+clock and load the u-boot image, then bootup from it.
+
+Sample boot log from Milk-V Duo board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+   U-Boot 2024.01-rc5-00010-g51965baa36 (Dec 28 2023 - 13:15:53 +0800)milkv_duo
+
+   DRAM:  63.3 MiB
+   Core:  10 devices, 8 uclasses, devicetree: separate
+   Loading Environment from nowhere... OK
+   In:    serial@4140000
+   Out:   serial@4140000
+   Err:   serial@4140000
+   Net:   No ethernet found.
+   milkv_duo# cpu detail
+     0: cpu@0      rv64imafdc
+      ID = 0, freq = 0 Hz: L1 cache, MMU
+   milkv_duo#
-- 
2.41.0

