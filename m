Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D59ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 22:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C36286DC8;
	Mon, 16 Oct 2023 00:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="POWo8X3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A81786B68; Mon, 16 Oct 2023 00:34:36 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DFD86D2D
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 00:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so6913160a12.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 15:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697409240; x=1698014040; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h7JXJp3VFak4xDc1CjnI1DGkuTQjRnjGHddVIevVllc=;
 b=POWo8X3H4SMRrC05PHlx6+AmxXdWcNbv0KtZtgCzcW8C0qAJYYSpSOh1oJWHr0Qd7r
 +YTAVlzbJC38KKRStouRsbIjL8tmJRMfc39J2/fHjC3vy21FPsxBSNhg21chdXBGTmcw
 CgE8jWSquLyamNvbiWI3F0+mZAC/0K+aBdBe/aUKkGz66a1dddcEtAHS0Cu1cP67DiNQ
 NOI5dKLRwxA0wBhnlboaRNjMsHq5a3zs4dYs8Mj4qWqTYBHQ3DNGf+LjAnZy38sa//XD
 AcdBo6X57Oa2IDHJq+mgsy6X6Lxo/vyTEP5YxY/SHhk3nW6CXL50HBiLGJe7gJF7RXor
 Hm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697409240; x=1698014040;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7JXJp3VFak4xDc1CjnI1DGkuTQjRnjGHddVIevVllc=;
 b=ILt6nud0LYGiBUZjK7G+xQCaq9b82WwDePrWS0wBfnp5sSsipBkj8fE3kApKF2pFk8
 0jmiZaPX2X71IIZsAjt30lefZ0A8qeslkyztTTixYodIz5Qoj9rkPV0NOHbihGgoLnYV
 zVNJV/nfzQja65DNPC4T6vzlIh3fomJvxPZfLQ4g1abzFDfPpSp513aDAjUhDSZnM3TU
 zr5mThU8h2a9Gd5g/xsRuIrlaAdOj1ng/Q8bnz+qN7kfF8W0fh2EL8MbCJ37p3iZwTuS
 eT5vmtTZzGi+QJdPKn2Z9QbJMudcwkUw/8QPdRmYzmDeq2idEKjqr0HCzWQ1yOHxlSFU
 JC+Q==
X-Gm-Message-State: AOJu0Yz0Lv0mZWc9B64FKfghAub4MszoHhSkrWN9ngDVtOQIohYI2vHf
 upjvdEdt6l3BJ1q9T7Uumog=
X-Google-Smtp-Source: AGHT+IGaUYfpI1AVK/dD2J5VkDEseXzJjrU+8U5qYrcXfwKJBwbSWrS0Ao0IMkeg+ChdYkzu4Sw31Q==
X-Received: by 2002:a05:6402:550b:b0:53d:b59c:8f91 with SMTP id
 fi11-20020a056402550b00b0053db59c8f91mr11652169edb.27.1697409240186; 
 Sun, 15 Oct 2023 15:34:00 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 17-20020a508e11000000b0053ed70ebd7csm292074edw.31.2023.10.15.15.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:33:59 -0700 (PDT)
Message-ID: <44655344-df0f-b6d1-24e4-3c5605adddf9@gmail.com>
Date: Mon, 16 Oct 2023 00:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 7/8] rockchip: doc: add rkmtd.rst
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Language: en-US
In-Reply-To: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Add documention for Rockchip rkmtd virtual block device.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V3:
  New patch
---
 doc/board/rockchip/index.rst |   1 +
 doc/board/rockchip/rkmtd.rst | 105 +++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 doc/board/rockchip/rkmtd.rst

diff --git a/doc/board/rockchip/index.rst b/doc/board/rockchip/index.rst
index 0c377e9bbba0..9a87a035e95e 100644
--- a/doc/board/rockchip/index.rst
+++ b/doc/board/rockchip/index.rst
@@ -8,3 +8,4 @@ Rockchip
    :maxdepth: 2

    rockchip
+   rkmtd
diff --git a/doc/board/rockchip/rkmtd.rst b/doc/board/rockchip/rkmtd.rst
new file mode 100644
index 000000000000..1481380ba6c5
--- /dev/null
+++ b/doc/board/rockchip/rkmtd.rst
@@ -0,0 +1,105 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2023 Johan Jonker <jbx6244@gmail.com>
+
+RKMTD
+=====
+
+Info
+----
+
+The command rkmtd creates a virtual block device to transfer
+Rockchip boot block data to and from NAND with block orientated
+tools like "ums" and "rockusb".
+
+It uses the Rockchip MTD driver to scan for boot blocks and copies
+data from the first block in a GPT formatted virtual disk.
+Data must be written in U-boot "idbloader.img" format and start at
+partition "loader1" offset 64. The data header is parsed
+for length and offset. When the last sector is received
+it erases up to 5 erase blocks on NAND and writes boot blocks
+in a pattern depending on the NAND ID. Data is then verified.
+When a block turns out bad the block header is discarded.
+
+Limitations
+-----------
+
+- Support with CONFIG_ROCKCHIP_NAND MTD driver only.
+- Support for Rockchip boot block header type 1 only.
+- Pattern for listed NAND IDs only. (Logic still not disclosed by Rockchip)
+- The MTD framework driver data and NAND ID must be extracted at a lower level.
+
+Available rkmtd commands
+------------------------
+
+.. code-block:: bash
+
+        rkmtd bind <label>      - bind RKMTD device
+        rkmtd unbind <label>    - unbind RKMTD device
+        rkmtd info [<label>]    - show all available RKMTD devices
+        rkmtd dev [<label>]     - show or set current RKMTD device
+
+U-boot settings
+---------------
+
+Config to enable Rockchip MTD support:
+
+.. code-block:: bash
+
+        CONFIG_MTD=y
+        CONFIG_MTD_RAW_NAND=y
+        CONFIG_SYS_NAND_DRIVER_ECC_LAYOUT=y
+        CONFIG_SYS_NAND_USE_FLASH_BBT=y
+        CONFIG_ROCKCHIP_NAND=y
+
+Option to keep existing NAND data unchanged:
+
+.. code-block:: bash
+
+        CONFIG_ROCKCHIP_NAND_SKIP_BBTSCAN=y
+
+Commands to enable:
+
+.. code-block:: bash
+
+        CONFIG_CMD_USB=y
+        CONFIG_CMD_RKMTD=y
+        CONFIG_CMD_ROCKUSB=y
+        CONFIG_CMD_USB_MASS_STORAGE=y
+
+Linux Host (PC) tool commands combinations that work
+----------------------------------------------------
+
+.. table::
+   :widths: 20 44
+
+   ==================== ============================================
+   U-boot               Linux
+   ==================== ============================================
+   rkmtd bind 0
+   rockusb 0 rkmtd 0
+                        upgrade_tool pl
+
+                        upgrade_tool rl 64 512 idbloader_backup.img
+
+                        upgrade_tool wl 64 idbloader.img
+
+                        upgrade_tool rd
+
+                        rkdeveloptool ppt
+
+                        rkdeveloptool rl 64 512 idbloader_backup.img
+
+                        rkdeveloptool wlx loader1 idbloader.img
+
+                        rkdeveloptool wl 64 idbloader.img
+
+                        rkdeveloptool rd
+
+                        rkflashtool r 64 512 > idbloader_backup.img
+
+                        rkflashtool w 64 512 < idbloader.img
+   ums 0 rkmtd 0
+                        dd if=/dev/sda1 of=idbloader_backup.img
+
+                        dd if=idbloader.img of=/dev/sda1
+   ==================== ============================================
--
2.39.2

