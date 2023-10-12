Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8834CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A6286A4C;
	Thu, 12 Oct 2023 22:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e7lF2vzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F24986D3F; Thu, 12 Oct 2023 22:53:56 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E8C86E14
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 22:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9b275afb6abso542230566b.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697143967; x=1697748767; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jl751q0sFvIf5oWY1rIL11jpyfLpoxcoyN8WZ2zG6GE=;
 b=e7lF2vzw+sLomtSczV7q5AYcw/ijYD5GCyPrtD+2b57qpVaQLyvPnuD2Ug08tlsjJ6
 eKHjvKn51SapjwQjhGZkUql0novYNM9/zyX9A9OrzpctmNZAn/EoKZE5zNS4FKT+S2RC
 IzCRfHF1PcDN8O48Uf8rS1U/+gtX3MVsw5wNk2gaKleFegJyxop9IqmpioNuhDwApm56
 MeX4ONgkK3+jQ3iVzj/dM+aCUG0sTJOvsndwzygcLFUk4YdPK2a+bzNbY5FXXefs1/2H
 +tNWvqx7kbdt/Guf/393qBSW4GGTt8YD6XM07KnE4qPfbWdgCT0mMAy0M5qNqsB8mUi8
 g3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697143967; x=1697748767;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jl751q0sFvIf5oWY1rIL11jpyfLpoxcoyN8WZ2zG6GE=;
 b=DvwgP6coB7/exOgVTNqsfiPy5mCdj8DzXpgckvsSGyeHrRFDy6P7QYYgqL8LMKh0nF
 8OOy7MAkoBaBuK2RqXC4QjeI1Aa0zRhOGmX+UUbJC8ub/zlz5chlsuKm/O7QEnlgCCYO
 Ro9AN0aKY+cKeRQ8f9O1QWO5FKQ2B5S9ZByHp2+61ik0Ur6TkkubO/zKItG66VZgIwIz
 LwQk02eglDVd3TdpmLHBHujCXyhHD1k64E088BPeHJOpoZQTiHVcpNvtgqNw051nvnYD
 Hn8jSFNcAYH7RsI0i4ouQEMPCTXN0m2j/U1g3xWuCwZvtkPRJB67qS7sNQ2blFb5VHEP
 r8kQ==
X-Gm-Message-State: AOJu0Yy6A9txhsBXBd1GATw+7SuXgTXj+55zNYVyhMTqCevFWHIkkckj
 z8QBDRLV1f1/t2q0X61gkpc=
X-Google-Smtp-Source: AGHT+IEJHzUFcWzmVT4Myl6Qpltks6bDw73uZ6ZaKkLGvjeFzqKvVSsijCsyRo+pkfnHUUilVOB58A==
X-Received: by 2002:a17:907:7daa:b0:9b2:b37d:17ff with SMTP id
 oz42-20020a1709077daa00b009b2b37d17ffmr19768735ejc.19.1697143967238; 
 Thu, 12 Oct 2023 13:52:47 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 ci24-20020a170906c35800b00992ea405a79sm11395455ejb.166.2023.10.12.13.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 13:52:46 -0700 (PDT)
Message-ID: <95fbbaee-2c74-a788-e016-52b269730b2e@gmail.com>
Date: Thu, 12 Oct 2023 22:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 7/7] rockchip: doc: add rkmtd.rst
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
Content-Language: en-US
In-Reply-To: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
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

