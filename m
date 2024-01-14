Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EE2C4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 18:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 332F2879BB;
	Sun, 14 Jan 2024 19:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRE3bA60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD748798B; Sun, 14 Jan 2024 19:08:15 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400798773F
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 19:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so2353408b6e.3
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705255691; x=1705860491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFmUBupdxwKtziR8C3jj0Ys3bE0RLYplWMx/OUaz6NM=;
 b=BRE3bA604wlxroKBxHsgErs8HFJI4SS5EwotCkcOj/hBtDXIOOLloRp5vdOJOJzZtG
 0wb11CJk5lbBnGCokloGni9PbGe+1wtDb2nB6qCbcLHzZ8jd6JTxrkAQB1eE848zf96L
 ay17cufI7qRhbhyJxiJjM58dO0rvXmiEQiFfn5y26Y7/3OdudierdYL5i5soyPUsMjfw
 wBZ7dBA80d+ElyKrMfgMftsvHSA6rm53dq3fl+Cgwye+YiVFDw4VBKyTMn9gimFWmxjU
 j1BhQ/RXgaYqvb+CilcJldZ9mC6RBsQghmALEFVfxYwIl1sWAhRbnZwI7NhwqU3+6NlK
 swwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705255691; x=1705860491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFmUBupdxwKtziR8C3jj0Ys3bE0RLYplWMx/OUaz6NM=;
 b=VYznN2TsZfGEUX/u2/0O9fok3nX/13Rz/nwjRjA5qARUPjLHhO1pmCMrMxkNEoxqd5
 1/9PafU3UIUix46RUeLHMslK4DEIFnbijUDB5BjRQukxx/xwXVCx7i3zpjevWgFpjWxz
 24lv82hPvt+/3nmLMMqxGLm54mwsQrawu5H8e2xjpvC/R+zpr1fzLqvbU6S3Vx7l4wqJ
 3TR6qcnruFlK0xMpSUS6XOQJoBNcOuh+kmwDcUd8CPWo5GfODAnJlOZLVh0cRIzC6bwu
 memfWqACzehfY2rn5WbeyD/Psl3ldQyKZO4WsKaMlcPaw1Pj0+Qg3/KhkatsD9KNE/Ry
 UIRw==
X-Gm-Message-State: AOJu0Yyh/VebFP6gyygZ374XXDbwRUgT80pLMXyk4HAWWpsZpSZkKR8U
 HPigAOBV10gBY4gkfwa3oXK9L1IQ4rcvyQar
X-Google-Smtp-Source: AGHT+IFyNS8l0bZQiAaYxTNGA6Aacx4gYq8QcokFuil/SSDJCdg6/By3z7yjP7n78Cm+HfAh8s+iXA==
X-Received: by 2002:a05:6808:2208:b0:3bd:5377:79df with SMTP id
 bd8-20020a056808220800b003bd537779dfmr5789306oib.82.1705255691059; 
 Sun, 14 Jan 2024 10:08:11 -0800 (PST)
Received: from localhost.localdomain ([120.204.188.187])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a056a00088d00b006d998f5b890sm6253657pfj.192.2024.01.14.10.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 10:08:10 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Morgan <macromorgan@hotmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Wei Fu <wefu@redhat.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
Date: Mon, 15 Jan 2024 02:07:39 +0800
Message-ID: <20240114180741.2114-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240114180741.2114-1-seashell11234455@gmail.com>
References: <20240114180741.2114-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jan 2024 19:08:45 +0100
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

(no changes since v1)

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

