Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5A5C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F24A60660;
	Sat, 12 Sep 2026 12:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjraPo5mblYk; Sat, 12 Sep 2026 12:37:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1108B6063E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216661;
	b=L3P5xUL62jsS3q85q6JMh2ifGyvkbdbfO0r1roVTKBw4m9+I+DV7u7/eVUHTjE4bm5xk
	 s0J9+X2rMNNPwgFW3UXg37h3RoONgUaKUeToYY056j0vnsnsAYixPakpEKGkWx5CjqeMK
	 Lq8xegXIo4l4yqYoYM6FN1OfvDDR6gHg5jUQxFggs31U/isyicU7cUnyokTZ3ZIfGm0R/
	 2g+grTtv5iCVMk3nSCyPqzoBzp+4VRsp3D/Gp/2q7F9xcooUKZymhAmdXB6Uu3Urq5c05
	 t3uheDTjHiFJ3xLc2pJLKTn+AgE64fLmluTWhuzr6vK/cKIA9XMxxqX81BH7/gDSenQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cBa7CbNFl9+kIdFyJV6pmxk8FUT6jAfJ+540HZK392M=;
	b=gA76HgaRRVpro5zpIPiLQkm6lVPfFEcsU8RgINIAmREQGOgmKhfwYMGDmGV71Me4tyei
	 6kVdpxy8PyFV/g7pUY9kLxEvewWSdVsqmscfI2MHA5MI8CRptEq16jd9wp/VeYnMwWNKI
	 97dNko92AeMJuBPi2UyUVYbga/IyuUDVxWfdXsdq6/tg0yT2zEtUFBgy2QSRMHjuu2SQM
	 YcVU2aUEclx7U3HSyyclF0cc3t27SNwdo3RtlJ4AQhvRoP0raCPSz4yUug8okMdkZoXZN
	 uOZ/E0Fr71ggR5C7KcPRY5/tpQgj7W749pSwfyFsASdktpXqmVIzobS4WDcR3O0QZ1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216661;
	bh=cBa7CbNFl9+kIdFyJV6pmxk8FUT6jAfJ+540HZK392M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8cyQ+3HuVg6pAfe/ZE86X0XcCWjgFuzJm60Va2oylvirLgOWUHnuMsDeAXKzBAbP
	 Sj1TIey/TE5EJzb7SP1jgb0NCJslZa9ihFYsQbQO67XEaVPjCdTkg+Q8QHiSs9EQ3m
	 +OoUnp/d14psAWFUyEUUN2jfOh8n76ANbxL6F6tdw7QUJVosfxp0RwLex4WMat8Yhs
	 89iuCW7XM4XE+1WZvbtdwTrWixRySD57Q9CpdttR2di9GUdDz7HUcbWsOxpVx1Xq5U
	 /8SNosB4jyW8UxGspxSg6/+pf7DOsuHGZvXfKFQk7F3oXCix7hOD3nQbgg2SikEzCM
	 Gmv9XhDFnm/Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1108B6063E;
	Sat, 12 Sep 2026 12:37:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48D93701
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F23B4007D
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8S85sZg2fLU for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:37:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8CE6540068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216658;
 b=GsxEqwrGRlqKHfmKACQrLzacZiEtJaXzkQMBlt0lGHLY8QfuSiuh9WYQzoEtqtN+U8Kr
 2kTwNIgmXx/U2cQXqK0rK/zyi8OJ2N3YC9v24w5SPBGevykzD3BWakMSIYyjoYqC/PWBl
 AOKH8mGDhnS8Ny9OzKWLWKa7Xv5lan/UKlTPgCLmFYD02SvZsgjTw/tT4Fww8GQJxhqjq
 zMppupzD3yJENgqDCEOOIDcZtogyHj+k7Qdat0FzvkXYxrVgL9f5116izwW8kNltI6xWv
 KZwzlWtetl/RlMfsOF+TKp9Rh+MpBU3GQSEsGbD21n3byAXe4Gi43NFJyJ6tswSwStg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216658;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=cBa7CbNFl9+kIdFyJV6pmxk8FUT6jAfJ+540HZK392M=;
 b=Vu1kIpdoNU8MKEi1t2vF211/NiHprCyADFQK+lRp8xgopedXsAXw7rCarN/V1J/OwDPk
 qZLep42NlXBONl6K3yE5NeiMRAQo8NtK3MWpZSmSBJm9R3VYXHMBqY5DRA6oRt/nw9NvX
 Rrz2fq/9E3J8atPTK4DyrYimUfaNl9PRX2RwOeaGOpHvLauHgtUdMDINzFsynCOW3Z73h
 vumEuomZ6p5OhOzIIxK6jh6uBRqXGXvCV2Qxc2KkwK1ObEU4C2djcmaHdw0FnWCFTbtzu
 FxU6jAa9xGmPADx64uXFvQ/1SOwbFtOhDH/j+L2nnWc2BaGYLqO+9HENfML3j6mZ9hg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=VzHTOWED; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=VzHTOWED
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CE6540068
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:38 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso1812187a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789216657; x=1789821457;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cBa7CbNFl9+kIdFyJV6pmxk8FUT6jAfJ+540HZK392M=;
 b=VzHTOWEDSaicVy01wBACpqzcc9F0WLMAnZYPGs2snWJLsGvwgwzRkKsHnK5Eyp+RaL
 XD/dlAGRQOs0GrJh4Xri5uBUVxjYemlkSE6BWcapjHSaReVOWW7AC6GjypFGTAj2VYLC
 yuuOH08wnggYx2aH6dLNnIb3RVRzsP68C8Ft8HhaKFA0bs39C/T0e6nO7jb+BDbq4zoG
 LvvY9eTMAw2b+ir4XSxxxAoTnHpHQQd/bkfiGd+bKk5J3uwRqaKaBJNYunB/zS/nugY3
 XXe9AgmHUEQcaC2aRAx+F9SnQudSTpwmE9H65zXf5Ap5IUJHtpGeIQp4w8UQpMxg3MUc
 /6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216657; x=1789821457;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cBa7CbNFl9+kIdFyJV6pmxk8FUT6jAfJ+540HZK392M=;
 b=abIgtRExNqKCnojlr8+CT4O/K9srtSaIuUPwq4zV7TEbPsvz2evcowO7yS7Yyng21v
 QcpiKr7AYEJHeIvEVeCfWOW/ak7alC2WetbhBy4p8JIQGrFT9d8XzPYYSckWT9m3xB9O
 KuRVkbDlQXs3cwKFtLDm8jSMq8wKyguE9Y3cVkWgVVxZy0jGymnyxq9lj1NhonM1DG3j
 YK53tGuho0UNuv+cirUMG8d40eCxZ9eCT8qcf5ZLlMj1ZyNqVBnj90AVf62DuZeHiYnb
 5abfHPcVt6NItoA4paqJI6S2fynjr9lWFIi64CwR2p0tAwtJ65hGKCXlsuIX4VELMg8i
 RfbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz71Q0hDxIsBjhq7UoWDamn0q7WFou/LUy+xH0OAUh8Ac6lhY6YXU2TTHwH1ss+ZM2+CDG3gSk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nhLpfk33fQUaQtv2zTawjRdba87pCMWJknKR/W4eorjKHkuZu9
 sP1j4pdzLgi+vWT25mYs7LWJfXH2nP985uZW/NNfMhhLFIG9VxsUFYkjiQmYqRm+wmo=
X-Gm-Gg: AYBFou1XBRZC0c7Za2DRcmPs1qgF8Gmutb+f8mZzVbC7/Bo/tOWPUDW75dmflVBX6Zz
 K7aIJ+2av2DxsUD9jMFDCzU2xfIacqqh0+FCdgm858XrRUX4TCS8LNO0OVTI4qqaDNFbDG2/sef
 1GisNhhbcEjr33JJbMN+IF3+2Dw3RXnkVHPz7lx4tr8aj6gV2n6ytp6Ko9ElythN2NIg3JnqRaF
 +v3vlNt9KsMWUfbP7HaowObB6BVu+NsFOOIS/XLjrnO6tD72WIigi+oy8G98TMSik5RhEf866az
 Wl6EKNOrOsUWXfeF3gSyFJIc99XI6UWHmuH85DHGkWY+Zd5mniGAMNAfbUGme7HN+PWfX3Wm298
 g5nPp93TgDOYdS6q8/qdkfGqgA1gpaSHb29O8iSsEEnxHW/kDqwvKpS5BeqdjYAazDVyyWRK1st
 tQ1MF+yFrVkzquPZiyWcLkb0R4gfIDwxsh9QZ0UTanxjilmB1vAttpy9j6t23AegWUe5/e3Fpew
 b87RvoWFXn+w69IVf1Th3Q54x44Cs/eP3IZrCoP/n6VilGXQwDk6E6imF80RCC4GvUEXWCAruuM
 nzqkVq2aoRYWE5699ZOBMJ2Muw7Q3ok/GXdb
X-Received: by 2002:a17:90b:2d82:b0:39d:6c95:7e4 with SMTP id
 98e67ed59e1d1-39d77d205f7mr17188246a91.31.1789216657271; 
 Sat, 12 Sep 2026 05:37:37 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13288737c88.13.2026.09.12.05.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:37:36 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 12 Sep 2026 20:36:59 +0800
Subject: [PATCH v13 6/7] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-m4-v13-6-71043b29630f@riscstar.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
In-Reply-To: <20260912-m4-v13-0-71043b29630f@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>, 
 Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.15.2
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

Add document on how to flash images into eMMC of K1 SoC based boards.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v13:
- Only flash the minimized partitions for SD boot.
v9:
- Add to generate the partition table of SD card.
v3:
- Add document on how to flash images into SD card.
---
 board/spacemit/k1/MAINTAINERS |   2 +-
 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-mmc.rst | 268 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 4b2bc4ecfc10..e12288a206e0 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -6,7 +6,7 @@ S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
 F:	board/spacemit/k1/
 F:	configs/spacemit_k1_defconfig
-F:	doc/board/spacemit/bananapi-f3.rst
+F:	doc/board/spacemit/
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
 F:	drivers/mmc/spacemit_sdhci.c
diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index a5e35ee12ab6..71854e5735bd 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -6,5 +6,6 @@ SpacemiT
    :maxdepth: 1
 
    bananapi-f3
+   k1-mmc
    k1-spl
 
diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
new file mode 100644
index 000000000000..4f35e836fcfd
--- /dev/null
+++ b/doc/board/spacemit/k1-mmc.rst
@@ -0,0 +1,268 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K1 eMMC and SD Card Boot Guide
+=======================================
+
+This guide covers two separate methods for booting and flashing U-Boot on
+SpacemiT K1 based boards:
+
+1. **eMMC Flash**: Flashing U-Boot and SPL images to eMMC via USB fastboot.
+2. **SD Card Boot**: Creating a bootable Bianbu SD card and optionally
+   replacing U-Boot on the card.
+
+Tested boards: Banana Pi BPI-F3, MusePi Pro.
+
+
+Chapter 1: eMMC Flash (U-Boot via USB Fastboot)
+===============================================
+
+SpacemiT K1 U-Boot Flash Guide
+==============================
+
+This guide explains how to flash U-Boot on SpacemiT K1 based boards. It covers
+flashing images via USB fastboot.
+
+.. note::
+
+   This procedure flashes images to eMMC over USB fastboot. The fastboot
+   function is not enabled in our SPL yet, so the download stage runs the
+   SpacemiT released SPL; our built FSBL.bin and fit.itb are the images
+   written to eMMC and used on the next normal boot.
+
+Prerequisites to flash
+~~~~~~~~~~~~~~~~~~~~~~
+
+- A SpacemiT K1 board with USB Type-C and UART access
+- USB-to-UART adapter (3.3V TTL)
+- ``minicom`` or equivalent serial terminal, configured at 115200 8N1
+- ``fastboot`` and ``flashserver`` tool on the host
+
+Hardware Setup
+~~~~~~~~~~~~~~
+
+Refer to k1-spl.rst.
+
+Flash images on eMMC
+~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the release images**
+
+Get the release package from Spacemit website. It contains SPL image, and so on.
+
+https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip
+
+Unzip images and store them into a directory.
+
+**2. Obtain flashserver tool**
+
+Get ``flashserver`` from Spacemit website.
+
+.. code-block:: bash
+
+    $wget https://cdn-resource.spacemit.com/file/flash/flashserver
+    $chmod +x flashserver
+    $mv flashserver {flash image path}/
+
+**3. Copy built SPL and U-Boot images**
+
+Build U-Boot as mentioned in k1-spl.rst. Create a new directory to save.
+The official u-boot.itb is used to download images. So the built U-Boot should
+not replace the official one.
+
+.. code-block:: bash
+
+    $mkdir {flash image path}/build
+    $cd {flash image path}
+    $ln -sf {path to FSBL.bin} ./build/
+    $ln -sf {path to u-boot.itb} ./build/fit.itb
+
+``{path to FSBL.bin}`` is the signed FSBL produced by ``fsbl.sh`` in
+k1-spl.rst, e.g. ``~/uboot-2022.10/spl_bin/FSBL.bin``.
+``{path to u-boot.itb}`` is the U-Boot build output, e.g.
+``~/u-boot/u-boot.itb``.
+
+**4. Update configuration files**
+
+The ``partition_2M.json`` and ``partition_universal.json`` files come from
+the release package. Patch the ``fsbl`` and ``uboot`` entries to point at
+the images staged under ``build/`` (pick the layout that matches your eMMC):
+
+.. code-block:: diff
+
+   diff -puNr bianbu-25/partition_2M.json clean/partition_2M.json
+   --- bianbu-25/partition_2M.json	2026-03-02 11:55:58.631116807 +0800
+   +++ clean/partition_2M.json	2026-05-20 11:25:21.683801401 +0800
+   @@ -13,7 +13,7 @@
+          "name": "fsbl",
+          "offset": "128K",
+          "size": "256K",
+   -      "image": "factory/FSBL.bin"
+   +      "image": "build/FSBL.bin"
+        },
+        {
+          "name": "env",
+   @@ -31,7 +31,7 @@
+          "name": "uboot",
+          "offset": "640K",
+          "size": "-",
+   -      "image": "u-boot.itb"
+   +      "image": "build/fit.itb"
+        }
+      ]
+    }
+   diff -puNr bianbu-25/partition_universal.json clean/partition_universal.json
+   --- bianbu-25/partition_universal.json	2026-03-02 11:55:58.642116862 +0800
+   +++ clean/partition_universal.json	2026-05-20 11:26:23.932581853 +0800
+   @@ -14,7 +14,7 @@
+               "name": "fsbl",
+               "offset": "128K",
+               "size": "256K",
+   -            "image": "factory/FSBL.bin"
+   +            "image": "build/FSBL.bin"
+           },
+           {
+               "name": "env",
+   @@ -32,7 +32,7 @@
+               "name": "uboot",
+               "offset": "2M",
+               "size": "2M",
+   -            "image": "u-boot.itb"
+   +            "image": "build/fit.itb"
+           },
+           {
+               "name": "bootfs",
+
+Deploying via USB Fastboot
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To enter BootROM fastboot mode:
+
+1. Power off the board by unplugging its power supply.
+2. **Press and hold** the FDL button (called "Boot Key" on some boards;
+   see the board layout above for the BPI-F3).
+3. While holding the button, use a USB cable to connect the OTG port to
+   your host. This cable is also used by fastboot to upload the firmware.
+4. Release the button.
+
+On the host, ``fastboot devices`` should list the board::
+
+    dfu-device     DFU download
+
+The serial console shows the BootROM's USB download handler trace,
+including a line like::
+
+    usb2d_initialize : enter
+
+This indicates the board is ready to accept an image via USB.
+
+.. tip::
+
+   If you are worried about insufficient USB power, you can first plug
+   in the power, then release the button, and then plug in the USB
+   cable.
+
+On the host:
+
+.. code-block:: console
+
+    $sudo ./flashserver
+
+When ``flashserver`` is running, it lists the detected fastboot devices.
+Enter the corresponding number to select one.
+
+
+Chapter 2: SD Card Boot
+=======================
+
+
+SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
+==================================================================
+
+This guide explains how to prepare a bootable SD card with Bianbu OS for
+SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
+card with a custom build.
+
+Prerequisites to boot
+~~~~~~~~~~~~~~~~~~~~~
+
+- A SpacemiT K1 based development board
+- A microSD card (at least 4GB capacity recommended)
+- A card reader for your host computer
+- A Linux host system (for ``dd``, ``sgdisk``, ``lsblk`` commands)
+- The Bianbu release package from
+  <https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip>
+- A custom ``FSBL.bin`` and ``u-boot.itb`` file to be written to the U-Boot
+  partition
+
+Prepare the SD Card & the image
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the release images**
+
+Unpack the release package to get the image files. Replace the ``FSBL.bin``
+and ``u-boot.itb`` with your custom builds.
+
+**2. Identify the SD card device**
+
+Insert the microSD card into your card reader, then run:
+
+.. code-block:: console
+
+   $ lsblk
+
+Compare the output before and after inserting the card to identify
+the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``,
+or ``/dev/mmcblk0``.
+
+**3. Write the image to the SD card**
+
+Run ``sgdisk`` to generate the partition table, then use ``dd`` to write
+the images to the corresponding partitions.
+
+.. code-block:: console
+
+    $sudo sgdisk -o /dev/sdb
+    $sudo sgdisk -a 128 \
+        -n 1:256:767 -t 1:8300 \
+        -n 2:768:895 -t 2:8300 \
+        -n 3:2048:4095 -t 3:8300 \
+        -n 4:4096:8191 -t 4:8300 \
+        -n 5:8192:532479 -t 5:8300 \
+        -n 6:532480:4726783 -t 6:8300 \
+        /dev/sdb
+    $sudo dd if=FSBL.bin of=/dev/sdb1 bs=512 seek=0 status=progress
+    $sudo dd if=fw_dynamic.itb of=/dev/sdb3 bs=512 seek=0 status=progress
+    $sudo dd if=u-boot.itb of=/dev/sdb4 bs=512 seek=0 status=progress
+
+The SD card is now ready as a bootable system disk.
+
+Understanding the SD Card Partition Layout
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The role of each partition:
+
++----------+----------+------------------------------------+
+| Partition| Size     | Purpose                            |
++==========+==========+====================================+
+| ``sdb1`` | 256 KB   | FSBL (First Stage Bootloader)      |
++----------+----------+------------------------------------+
+| ``sdb2`` | 64 KB    | ENV                                |
++----------+----------+------------------------------------+
+| ``sdb3`` | 1 MB     | OpenSBI                            |
++----------+----------+------------------------------------+
+| ``sdb4`` | 2 MB     | U-Boot binary (``u-boot.itb``)     |
++----------+----------+------------------------------------+
+| ``sdb5`` | 256 MB   | Boot partition (kernel)            |
++----------+----------+------------------------------------+
+| ``sdb6`` | 2 GB     | Root filesystem (ext4)             |
++----------+----------+------------------------------------+
+
+
+Booting and Testing
+~~~~~~~~~~~~~~~~~~~
+
+Insert the SD card into the development board, connect the serial
+console (115200 8N1), and power on the board.
+
+- If the board boots successfully, the new device tree or U-Boot image
+  is compatible with your hardware.

-- 
2.51.0

