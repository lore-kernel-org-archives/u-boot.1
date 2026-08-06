Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C66C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2EB580E63;
	Thu,  6 Aug 2026 11:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wBWIcEeVyX1e; Thu,  6 Aug 2026 11:00:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 258CF80E35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014051;
	bh=bn4LLlOyWovEIEPS509pZhNY38vgNUfs3BgGv8h3/5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pYQZZhOFgmM7EzVGmEGnliTdmxpW/4eVN75V/4KtLnrE0eYWEt4JmkiL3pvuISxMh
	 V9RNILB+sVFTpSavsrg+Y4Rcf9HHJ3+2GhIffbgzqevP/rBO6qHAXW6NJD5zKh2jFN
	 9+Ly3CnKb1ha9BNVg41/020yyfigZs1OMETE7yVEXuEd7LRcmAxjQPniaJ6KqRojqG
	 OYPm0l5toqzm3yE66gLVBAzHYClp2WIkm6c8Qm7J6/FxYgHiaXCjNo84weWEm/hMNk
	 IzdJ++bBr+jaobed+1gebLPBw21fjRpTcx/FiWNDWNRVuXeUYGnW1IZX8ycTqzrvlp
	 Ky/dR9layoPHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 258CF80E35;
	Thu,  6 Aug 2026 11:00:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 38C4F282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F09A4053E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZxrHCECXUvT for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 10:18:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.46;
 helo=mail-wm1-f46.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 73CD44053D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73CD44053D
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73CD44053D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:18 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so16481415e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 03:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786011496; x=1786616296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bn4LLlOyWovEIEPS509pZhNY38vgNUfs3BgGv8h3/5o=;
 b=HyflYgrsdWDqqZh3B3BcOGs7zpfhT2EGRMjhdMkIe9x5oetDcodL1GE0OnP/q0Csb+
 BiarRsohpLgIZ2XLv6N1QJexRxLXgiUOsx92xmD7uk/22zb1EA/1uoXHYKIB2nrxp1eW
 8fQh5EoK7oo2eF+96B4rIlLd4pcYf5mKn0OoXwJnHGXgYYJ00Cj3BSm3AHpbs2HULUJc
 HH1fh9QhZbazrgAyWPQnasi9qqV+L0PqB1Ak13OK0ooUAEVx/1BhtM3DeqYxzmMp/DOD
 Egq24WA8pPTToBbw17m6ZdIv4XWb32ERF6kG7x4icWGjRfmkHIWbKgJi6CxpI06J4fZP
 8+5g==
X-Gm-Message-State: AOJu0YwOXRPVnYAliCCIncDggwujRfTRJYxFtTb/eNJWcxBffXMaX/i5
 AYLOXPkTS3GNGadx3hM7yhJEcjapE/r6D2h3xwnuUVec2c/yj08poQxTyCxpAw==
X-Gm-Gg: AR+sD13qYkMxkSWGBxwZHWUfkvQz59oi7BbO8msmwMv5O2ZxS2/pirPJycMhhlEAXoq
 3FPO4qvKWTCDMF380Jw/UJbWxQ+z2wC7hdPfC3gtlDTZkPipyy/cCI4nPXlTdW3kp5rVx21azcd
 4olBniWj8GRboWSrQ0lY2+p1lIDW1MK3i2Wmq6XQ3v73qGyEaQqA93pdyhOJ4EQ5K8SIG+dibMa
 ISVZFosUWLowOcfCmR9G2DlEXYAKkAca46NLMcVjXVf5oDWwvzxWmBbH6LjojmgSoKD+mWE6mYn
 7cKcOsK8SOkExDoaqo5XmFCvQDtoEWZpJZZdyIVjHujpyzA4tDTwNDcqebupBoqmtcKULecCLWB
 yXkTSeLkboBjMlbwBU9DVQAZhOzugSCx4ImwyRU1xF4ClEV7BIqOrABJpur2iRLIdyW8XBH07BR
 E39nPRwy/rCb25fFSuWdJoibFZrtmHFCTt2EAV6Pxa9LAXKMqCLbmejk0OIhEiu4uDFtyGaXE+Y
 Tf2yVSAZnUsUCZG3usVEXS36yuAnrmWh9xRwg==
X-Received: by 2002:a05:600c:1992:b0:499:593c:3384 with SMTP id
 5b1f17b1804b1-49959e08773mr2445625e9.6.1786011496109; 
 Thu, 06 Aug 2026 03:18:16 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e988687sm108654725e9.3.2026.08.06.03.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:18:15 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: [PATCH 4/4] doc: board: amlogic: add Khadas VIM4 documentation
Date: Thu,  6 Aug 2026 11:18:09 +0100
Message-ID: <20260806101809.72526-5-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
References: <20260806101809.72526-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=linux.com
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Document building U-Boot for the Khadas VIM4, chainloading it from the
vendor U-Boot for development, and packaging the boot image with the
vendor tooling, and add the A311D2 to the support matrix.

Notably, the SD card image layout differs from older Amlogic SoCs:
sector 0 is a checksummed BootROM header (a partition table may
coexist in its MBR slots), so when writing the bootloader the first
sector must be written along with it.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 board/amlogic/vim4/MAINTAINERS    |   1 +
 doc/board/amlogic/index.rst       | 119 ++++++++++++++---------------
 doc/board/amlogic/khadas-vim4.rst | 122 ++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 59 deletions(-)
 create mode 100644 doc/board/amlogic/khadas-vim4.rst

diff --git a/board/amlogic/vim4/MAINTAINERS b/board/amlogic/vim4/MAINTAINERS
index 5e1ec98b571..b2e5717e846 100644
--- a/board/amlogic/vim4/MAINTAINERS
+++ b/board/amlogic/vim4/MAINTAINERS
@@ -5,3 +5,4 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/vim4/
 F:	configs/khadas-vim4_defconfig
 F:	arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
+F:	doc/board/amlogic/khadas-vim4.rst
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 23380ac33f2..0785d495d38 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -10,65 +10,65 @@ An up-do-date matrix is also available on: http://linux-meson.com
 
 This matrix concerns the actual source code version.
 
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SoCs              | S905      | S805X    | S912     | A113X    | S905X2   | S922X    | S905X3   |
-|                   |           | S905X    | S905D    |          | S905D2   | A311D    | S905D3   |
-|                   |           | S905W    |          |          | S905Y2   |          |          |
-+===================+===========+==========+==========+==========+==========+==========+==========+
-| UART              | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Pinctrl/GPIO      | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Clock Control     | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| PWM               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Reset Control     | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Infrared Decoder  | No        | No       | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Ethernet          | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Multi-core        | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Fuse access       | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SPI (FC)          | **Yes**   | **Yes**  | **Yes**  | **Yes**  |**Yes**   | **Yes**  | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SPI (CC)          | No        | No       | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| I2C               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| USB               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| USB OTG           | No        | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| eMMC              | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SDCard            | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| NAND              | No        | No       | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| ADC               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| CVBS Output       | **Yes**   | **Yes**  | **Yes**  | *N/A*    | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| HDMI Output       | **Yes**   | **Yes**  | **Yes**  | *N/A*    | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| CEC               | No        | No       | No       | *N/A*    | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Thermal Sensor    | No        | No       | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| LCD/LVDS Output   | No        | *N/A*    | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| MIPI DSI Output   | *N/A*     | *N/A*    | *N/A*    | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SoC Rev/Info      | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| PCIe (+NVMe)      | *N/A*     | *N/A*    | *N/A*    | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Watchdog          | *N/A*     | **Yes**  | *N/A*    | *N/A*    | *N/A*    | *N/A*    | *N/A*    |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SoCs              | S905      | S805X    | S912     | A113X    | S905X2   | S922X    | S905X3   | A311D2   |
+|                   |           | S905X    | S905D    |          | S905D2   | A311D    | S905D3   |          |
+|                   |           | S905W    |          |          | S905Y2   |          |          |          |
++===================+===========+==========+==========+==========+==========+==========+==========+==========+
+| UART              | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Pinctrl/GPIO      | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Clock Control     | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| PWM               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Reset Control     | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Infrared Decoder  | No        | No       | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Ethernet          | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Multi-core        | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Fuse access       | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SPI (FC)          | **Yes**   | **Yes**  | **Yes**  | **Yes**  |**Yes**   | **Yes**  | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SPI (CC)          | No        | No       | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| I2C               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| USB               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| USB OTG           | No        | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| eMMC              | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SDCard            | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| NAND              | No        | No       | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| ADC               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| CVBS Output       | **Yes**   | **Yes**  | **Yes**  | *N/A*    | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| HDMI Output       | **Yes**   | **Yes**  | **Yes**  | *N/A*    | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| CEC               | No        | No       | No       | *N/A*    | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Thermal Sensor    | No        | No       | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| LCD/LVDS Output   | No        | *N/A*    | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| MIPI DSI Output   | *N/A*     | *N/A*    | *N/A*    | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SoC Rev/Info      | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| PCIe (+NVMe)      | *N/A*     | *N/A*    | *N/A*    | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Watchdog          | *N/A*     | **Yes**  | *N/A*    | *N/A*    | *N/A*    | *N/A*    | *N/A*    | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
 
 Boot Documentation
 ------------------
@@ -102,6 +102,7 @@ Board Documentation
    khadas-vim2
    khadas-vim3
    khadas-vim3l
+   khadas-vim4
    libretech-ac
    libretech-cc
    nanopi-k2
diff --git a/doc/board/amlogic/khadas-vim4.rst b/doc/board/amlogic/khadas-vim4.rst
new file mode 100644
index 00000000000..a42a5610877
--- /dev/null
+++ b/doc/board/amlogic/khadas-vim4.rst
@@ -0,0 +1,122 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Khadas VIM4 (A311D2)
+===============================
+
+Khadas VIM4 is a Single Board Computer manufactured by Shenzhen Wesion
+Technology Co. Ltd with the following specifications:
+
+ - Amlogic A311D2 (T7 family) Arm Cortex-A53 quad-core + Cortex-A73 quad-core SoC
+ - 8GB LPDDR4X SDRAM
+ - Gigabit Ethernet
+ - HDMI 2.1 display output, HDMI input
+ - 40-pin GPIO header
+ - 1 x USB 3.0 Host, 1 x USB 2.0 Host/OTG
+ - 32GB eMMC, microSD
+ - M.2 socket
+ - 32MB SPI-NOR flash with the OOWOW recovery system
+ - Infrared receiver
+
+Schematics are available on the manufacturer website.
+
+Current U-Boot support covers the UART console, DRAM and PSCI reset,
+booting either chainloaded from the vendor U-Boot or as BL33 from
+power-on, packaged into the vendor boot image. Storage, network and
+USB are not supported yet.
+
+The serial console runs at 921600 baud, the Khadas convention for this
+board (this is also the rate the vendor firmware configures).
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
+    $ make khadas-vim4_defconfig
+    $ make
+
+Chainloading from the vendor U-Boot
+-----------------------------------
+
+The resulting u-boot.bin is position independent and can be run directly
+from the vendor U-Boot prompt, for example over TFTP:
+
+.. code-block:: none
+
+    kvim4# dhcp
+    kvim4# setenv serverip <tftp server address>
+    kvim4# tftpboot 0x01080000 u-boot.bin
+    kvim4# go 0x01080000
+
+Note: use load addresses in the vendor kernel load area, like 0x01080000
+above. Other areas, e.g. 0x08000000, are not mapped by the vendor U-Boot
+and loading there makes it crash.
+
+Boot image packaging
+--------------------
+
+There is no open-source tool yet that can assemble a bootable image for
+the T7 family: the BootROM and BL2 only accept an image signed by the
+Amlogic tooling shipped in the vendor U-Boot tree, with u-boot.bin
+taking the BL33 slot. The vendor tree and its packaging flow are
+available from https://github.com/khadas/u-boot (branch
+khadas-vims-v2019.01, see fip/mk_script.sh) or through the Khadas Fenix
+build system, https://github.com/khadas/fenix.
+
+To generate an SD card image, first build the vendor package once (for
+example with Fenix: select VIM4 and U-Boot 2019.01, then "make uboot");
+this compiles the vendor tree and leaves all the signed stages and
+tools in <vendor tree>/fip/_tmp. Then replace the BL33 payload with the
+mainline u-boot.bin and rebuild the device FIP:
+
+.. code-block:: bash
+
+    $ VENDOR=/path/to/khadas-u-boot
+    $ T7=$VENDOR/fip/t7
+    $ TMP=$VENDOR/fip/_tmp
+
+    # wrap and LZ4-compress u-boot.bin as the BL33 payload (1.5 MiB slot)
+    $ $T7/aml_encrypt_t7 --bl3sig --input u-boot.bin --output bl33.lz4 \
+          --compress lz4 --level v3 --type bl33
+    $ dd if=bl33.lz4 of=bl33.body bs=1 skip=1824
+    $ dd if=/dev/zero of=bl33-payload.bin bs=1572864 count=1
+    $ dd if=bl33.body of=bl33-payload.bin conv=notrunc
+
+    # rebuild the device FIP with the new BL33
+    $ $T7/binary-tool/acpu-imagetool create-device-fip \
+          --infile-template-chipset-fip-header=$TMP/device-fip-header.bin \
+          --infile-bl30-payload=$TMP/bl30-payload.bin \
+          --infile-bl33-payload=bl33-payload.bin \
+          --infile-blob-bl40=$TMP/blob-bl40.bin.signed \
+          --infile-blob-bl31=$TMP/blob-bl31.bin.signed \
+          --infile-blob-bl32=$TMP/blob-bl32.bin.signed \
+          --outfile-device-fip=device-fip.bin.signed
+
+    # all payload slots are fixed-size: patch the new device FIP into
+    # the vendor SD image at its fixed offset
+    $ cp $TMP/u-boot.bin.sd.bin.signed .
+    $ dd if=device-fip.bin.signed of=u-boot.bin.sd.bin.signed \
+          bs=512 seek=1313 conv=notrunc
+
+The resulting image for SD cards is u-boot.bin.sd.bin.signed.
+
+Unlike older Amlogic SoCs, sector 0 of the T7 SD image is a checksummed
+BootROM header, not only a partition table: the image must be written
+from sector 0 so the header is written too. A partition table may
+coexist in the MBR slots of the same sector, as the vendor SD images
+do:
+
+.. code-block:: bash
+
+    $ dd if=u-boot.bin.sd.bin.signed of=/dev/<sd card> bs=512 conv=fsync
+
+The BootROM tries SD before eMMC, so a valid SD card image always takes
+precedence. If no valid boot image is found, the board falls back to the
+OOWOW recovery system in SPI-NOR flash.
+
+Note that the BootROM only considers the SD card on cold boots: after a
+warm reset (e.g. the U-Boot "reset" command) it goes straight to eMMC
+and then SPI-NOR. Power-cycle the board to boot from SD again, or write
+the eMMC variant of the image (u-boot.bin.signed) to the eMMC boot area
+to make it the default for both boot paths.
-- 
2.55.0

