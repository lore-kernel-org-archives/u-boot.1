Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17969CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E94286FD0;
	Wed, 18 Oct 2023 16:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvWNCN+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC3786F94; Wed, 18 Oct 2023 16:02:23 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C9086FB4
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so417095066b.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697637741; x=1698242541; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h7JXJp3VFak4xDc1CjnI1DGkuTQjRnjGHddVIevVllc=;
 b=TvWNCN+LwCFlgaG4mqnU1BLuEkOgceKeBL87XArCYq7lU5MwqTniA2i9h3Ri2hWfaS
 0kuLGLL19hMZUqHrV8/HG0lDitQuIa6MTjGQMwPg8KYy4LjwZG87rVltAVlBvYhtJm4R
 zqtC4cJm5YeHhZdz0AQaNy9DDuPnssxGRFg1z8b+bisdrjrCNm+HRa7kiPJT+YU/5Hxk
 KbLMo2F0O4n9wxqm6bP6KasqZlifTM8+x94f70gpLgUKbPydbQcVqWbiENCacfKDMgml
 hzxCQPziG+fBRq12dMhxLRlECrZJatjoQGRs1oVDVT7EWsqCI5BlwEtfGcvqngnsM7/s
 2X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637741; x=1698242541;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7JXJp3VFak4xDc1CjnI1DGkuTQjRnjGHddVIevVllc=;
 b=m5E5tiSgjKeupEa4nQ+RXQ1Oq1TzLaTUil5zP3vE/pnupX6TIC/YfDhTRYaFiEa+do
 Kbik6onVYlLsgizPmXPdUVEYRIeNKhODFzbl/exa1yyGL2Vp8mCK4CRcUwjVAqjVxoGv
 bwcno45LhOtgXxwMLFfalEPABbtycCZ7IvMo3A+F8iEVlHmOzD7Fn2NKjRcqVqW1KDP7
 f+rzqQUCpxD7t968Mm6e/l1Rb8jKhZnJEvAUnjp3WoT8Op20/HDhTj/tu+JvZOgudf7F
 4boDPYvGraxb0ys4WqUGKtztkrf0VkalcZNFOEp2YEcYVPo8tMn/GP1E6a7AKHadvLf1
 UOMw==
X-Gm-Message-State: AOJu0Yy+6AMWIAmFrvhZH/UYtfNL9hyPTC7m3hr2sI7NC7IgPEJdT3OQ
 oPNHoif8xha1D+gFUN6tc6JgRD1wAHY=
X-Google-Smtp-Source: AGHT+IGx4WqpsmQje6wLEaInHvlQkOZAw06gB6+2AzrqzOETyMzX/c98SXgK/kkNVyKX/1ESd/tdVA==
X-Received: by 2002:a17:907:2d90:b0:9be:fc31:8cd3 with SMTP id
 gt16-20020a1709072d9000b009befc318cd3mr3642974ejc.17.1697637741159; 
 Wed, 18 Oct 2023 07:02:21 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 gt23-20020a170906f21700b0099bc2d1429csm1759620ejb.72.2023.10.18.07.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 07:02:20 -0700 (PDT)
Message-ID: <f832c9bf-a706-5d6f-7933-6392554f9834@gmail.com>
Date: Wed, 18 Oct 2023 16:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 7/8] rockchip: doc: add rkmtd.rst
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Language: en-US
In-Reply-To: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
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

