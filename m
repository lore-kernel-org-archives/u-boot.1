Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B05C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84493880F3;
	Thu, 21 Mar 2024 19:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PymVsAS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A2C8810D; Thu, 21 Mar 2024 19:12:19 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D77E86564
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 736D93FB75
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711044733;
 bh=2oEd2wX4uYKq/HRP8/y9+SyQlUwtciO2YMZjeI44Yl4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PymVsAS+N3+xxHvx7eIf2dm0Yl2jwdRMh9QzKbr5Svl3D3Fa1K8mbEWEJ25HR2XLQ
 b0CT0f/JqBV+5CtCBJUZwYArGLvUNaEPlUSEwv1nHTHqbiSHCUb3oAufyQjHa+3b28
 OEH6bUv13BE6JsRvmdliabCq/d1fyCAJs6NVVS6Hfxp/QO153ynhZ9UUohV4kNiaCf
 eVNekY6CwumU/ZxtVExPfGzhy+u+wlorbOYq06ug/BX4kUvEZg+OkQ8mDUsiw6O6t2
 7FieRnNVjqYJMyEqtJltTdNWU8XAg3vQOIIrytFh1ffbaoHpV/YSXYQB/EpIboS92r
 a1a2/4eICqb3A==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41401eb321fso7644745e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711044732; x=1711649532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2oEd2wX4uYKq/HRP8/y9+SyQlUwtciO2YMZjeI44Yl4=;
 b=LYGuHcBKcu5gLWVfeobzFlxvZau4suvmwUrilEhd3JhKnpkm/MjoHRJk5iuZvj2zY7
 wYiqJLkwyRK/6gKwoqCYkbkSEjas1jZk2nMjYr/6/uAzW4aV2B5527aZHxdDO3MKlhzj
 El4nNdDyLIcWX9qIYUxibD/kVGjy1Hx5Q1T09XQ2YjgYEObCQzClpYLnApKb75T2IAQG
 ty/8fogrC96txnkhSr6D0ml+X/APNqreT+kxgKcxDnbF38VfoZ+csFyXXXSJsMNAiw7X
 ltNcV9o8EE6NxWKttKky01w0NVVqX0rysbQKN2st295yL+0iGC4H+MR5kLSbwIceGp72
 6AFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhEDlja66jZ9xAZ55CsRJPIOPZL8bYVpevucC/cz+nwpPr9fIhbWN5o+fhJ28JC/hqmqrncmZkZhJPbMNxso2TVGUwtA==
X-Gm-Message-State: AOJu0Yw96Bvr78v/7IHFg4GjLx7RdXkxNHsUt55RZSErXMhxgOVylDvB
 xKzBi35hCeBMcaFmCCxldsOY2pl9waEgA82srw6oN0PE7o+bKzPla64/S+pJpHj12/gca3BrKQc
 E2WYayc3LSAoFEpUZ4yUAY7FnSBxgoc5lXdl5vwoLgE7oxWAwp8Duul3pCLJVMiYwOWY=
X-Received: by 2002:a05:600c:4ab0:b0:414:37f:26d with SMTP id
 b48-20020a05600c4ab000b00414037f026dmr2056512wmp.10.1711044732557; 
 Thu, 21 Mar 2024 11:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxLdBpPpTKmB8YJmqtBvVxH+1Twg8Xm6og+VJmv5aI+nIcSv0FbHYcVPr1bKsDcTRqVH84Q==
X-Received: by 2002:a05:600c:4ab0:b0:414:37f:26d with SMTP id
 b48-20020a05600c4ab000b00414037f026dmr2056486wmp.10.1711044732092; 
 Thu, 21 Mar 2024 11:12:12 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 hg10-20020a05600c538a00b004147743bd0dsm1469420wmb.38.2024.03.21.11.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 11:12:11 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/6] riscv: add support for Milk-V Mars board
Date: Thu, 21 Mar 2024 19:11:43 +0100
Message-ID: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The Milk-V Mars board is technically very close to the StarFive
VisionFive 2 board.

With this patch series the VisionFive 2 U-Boot SPL will detect that it
is running on a Milk-V board and patch the device-tree accordingly.
This is the same approach that has been taken to handle the differences
between the Visionfive 2 1.2B and 1.3A revisions.

v2:
	do not set default fdt for VisionFive 2
	do not overwrite /soc/i2c@12050000/eeprom@50/compatible

*** BLURB HERE ***

Heinrich Schuchardt (6):
  riscv: do not set default fdt for VisionFive 2
  eeprom: starfive: function get_product_id_from_eeprom()
  riscv: set fdtfile on Milk-V Mars
  board: starfive: support Milk-V Mars board
  riscv: starfive: avoid including common.h
  doc: describe Milk-V Mars board

 arch/riscv/include/asm/arch-jh7110/eeprom.h   |   9 ++
 board/starfive/visionfive2/spl.c              | 100 ++++++++++++++--
 .../visionfive2/starfive_visionfive2.c        |  48 +++++---
 .../visionfive2/visionfive2-i2c-eeprom.c      |   9 +-
 configs/starfive_visionfive2_defconfig        |   1 -
 doc/board/starfive/index.rst                  |   1 +
 doc/board/starfive/milk-v_mars.rst            | 111 ++++++++++++++++++
 doc/board/starfive/visionfive2.rst            |  18 +++
 8 files changed, 268 insertions(+), 29 deletions(-)
 create mode 100644 doc/board/starfive/milk-v_mars.rst

-- 
2.43.0

