Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388FEE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 03:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7DD8006E;
	Sun, 15 Dec 2024 04:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mq0CMHrz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C0CF8006F; Sun, 15 Dec 2024 04:00:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44128006D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 04:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E15D3F871
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734231622;
 bh=AvYXoFJ3kDfQ8WCht8ogYnFRHrBNDLal1nXpEZQW5TE=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=mq0CMHrzTLCUsVCrIiovfPNJp++G9YhSVwVlSatXMuThq6iFa4GMxO7mEDR2qNUK+
 X/kNsEHpQVqccvlVZFYMtNylDjbUAMCID9K1dqSpG3v5ZT3yK6Ejo9bHvxDiYylPsk
 nb45psPCsHhldAh3UhG7b5IDdeemW7ZMrPNWhFN361uvcUG/LRVVKEIfe6AiKLJ3sR
 5ud9ZAuuFVnHO5W9lr8TSVxD4xxmduCbjjm3z9DW2SLAufQTbYqbhtSIG9I33afVIj
 nvekEcpVhwNbkXFMrJMbnjCo0on8hEjixuXx7bvEmZSe/tGa4J8IgxzayDRMEUiEtI
 a7+psAT9yXxcw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436228ebc5eso16813935e9.3
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 19:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734231622; x=1734836422;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AvYXoFJ3kDfQ8WCht8ogYnFRHrBNDLal1nXpEZQW5TE=;
 b=frclRio/ld/l8lK8NWP1wFX8Wi0P49AkqFHP02Im+ay2oNt/pMSqH09/7uBZ+Z7fLB
 36g6KTwuoWhlrtgM4El97EYLEr/mf/cnfJtN6nxeggOPWneNDeJiqxboQFRz09UPCFtG
 3WbwH/7uIdxDr/TU7uY6TnsY7u/v8p6Gg3IVLj/gJWnOjUmZc1jch328K3oMPmY1BCms
 y5PjfCD6DxMbg49fapguYHV49whKFCzMwEhLSn7HgvOC77IzdA8vNR5PVkFKy6i59MlN
 g2VkALBaWk+sIOs5tdtseaIPjTJ0G7yGp4GZg/FncfkVYuKLKrfFPZov+9QvXdVjxG7i
 PGYg==
X-Gm-Message-State: AOJu0YwvLOGvEO4HuZy/CDJpQw/MZhWmv03fZIvpApquayP4FOy1j0rD
 fBxPxcRRHlZkchwGTOpYJsQvgCT8S3vAGHF6+zzennb9rsqwBWI3dtSKAf5g/JBzusZ/QXciDpK
 IbrogmspzX71DPBZThpfswf53wcTgsqL/5j+6AQLSn1XTYbo8A97WcyYURGhvaGYuoP0=
X-Gm-Gg: ASbGncuIar0UFS3hFiG38qG9ZioXyq2ZKI2Jp2lC/cj5Hhggrzb30I/+s/ztlJMX8HY
 X/UTDOI/yh9duaNBxxsB8/7xFNn2YQqv6J4SmLmXEND4zjXpraAqUNu5cTb1CTEtgvr4gVqDYKE
 VzzRXfUI/O9htaX0zIWrT08cvHz4H/NdDtULQJMt1xXEcy3C9Q2wihl9euQW/jYezoKgpGSb/0C
 zvzrCZg3UE4uBT9Z2WEGrcoZVEGxJ/xduM+7pA2XhW3qynikSTrJISvNo5xwbTI33a93OqcFt+l
 FF9qJZHrMY3HGLz7EuUx4PyP4f3Z3s1bdBQTeoQp4QELrubW88JDaQ==
X-Received: by 2002:a05:600c:1e0b:b0:434:feb1:adcf with SMTP id
 5b1f17b1804b1-4362aa9d2afmr60656455e9.25.1734231621851; 
 Sat, 14 Dec 2024 19:00:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV02yjDKKCZlrFesN7rkCx6Kv6U6Ma6ekn1kgssLtPLPIxc5cqNk9Jqlj8/RucpenfeTa+2w==
X-Received: by 2002:a05:600c:1e0b:b0:434:feb1:adcf with SMTP id
 5b1f17b1804b1-4362aa9d2afmr60656135e9.25.1734231620872; 
 Sat, 14 Dec 2024 19:00:20 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436362b74c7sm40652855e9.33.2024.12.14.19.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 19:00:19 -0800 (PST)
Message-ID: <7739d82f-fdac-482f-8c04-8261e8aae069@canonical.com>
Date: Sun, 15 Dec 2024 04:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Andy Yan <andyshrk@163.com>,
 Johan Jonker <jbx6244@gmail.com>, Leonard Anderweit <l.anderweit@phytec.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request doc-2025-01-rc5
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Dear Tom,

The following changes since commit 88bd5701efdc48048e030d91c2633048f0f753a0:

   Merge branch 'master' of 
https://source.denx.de/u-boot/custodians/u-boot-usb (2024-12-12 09:50:25 
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/doc-2025-01-rc5

for you to fetch changes up to 55e8704402350d06e8ebf244515d96c36a3bacf5:

   doc: cosmetic: fwu_updates: Fix formatting (2024-12-15 02:11:13 +0100)

Gitlab-CI showed no issues.
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23857

----------------------------------------------------------------
Pull request doc-2025-01-rc5

Documentation:

* sending_patches: Fix spelling of "its"
* environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayipN
* remove redundant Rockchip bindings
* fwu_updates: Fix formatting
* coolpi: Fix document style
* board: theobroma-systems: fix feature list in introductions

Fix typos in code comments:

* clk: mpc83xx: Fix typo in "Coherent System Bus"
* efi_loader: Fix typos in enum efi_allocate_type

----------------------------------------------------------------
Andy Yan (1):
       doc: coolpi: Fix document style

J. Neuschäfer (2):
       clk: mpc83xx: Fix typo in "Coherent System Bus"
       doc: sending_patches: Fix spelling of "its"

Jerome Forissier (1):
       doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayipN

Johan Jonker (1):
       doc: remove redundant Rockchip bindings

Leonard Anderweit (1):
       doc: cosmetic: fwu_updates: Fix formatting

Quentin Schulz (1):
       doc: board: theobroma-systems: fix feature list in introductions

Simon Glass (1):
       efi_loader: Fix typos in enum efi_allocate_type

  doc/board/coolpi/genbook_cm5_rk3588.rst            |  11 +-
  doc/board/theobroma-systems/puma_rk3399.rst        |   1 +
  doc/board/theobroma-systems/tiger_rk3588.rst       |   7 +
  doc/develop/sending_patches.rst                    |   2 +-
  doc/develop/uefi/fwu_updates.rst                   |   4 +-
  .../clock/rockchip,rk3188-cru.txt                  |  61 --------
  .../clock/rockchip,rk3288-cru.txt                  |  61 --------
  doc/device-tree-bindings/clock/rockchip.txt        |  77 ----------
  .../pinctrl/rockchip,pinctrl.txt                   | 157 
---------------------
  .../thermal/rockchip-thermal.txt                   |  68 ---------
  doc/device-tree-bindings/usb/dwc2.txt              |   4 -
  doc/device-tree-bindings/video/rockchip-lvds.txt   |  77 ----------
  doc/usage/environment.rst                          |  11 +-
  drivers/clk/mpc83xx_clk.h                          |   2 +-
  include/efi.h                                      |   2 +-
  15 files changed, 26 insertions(+), 519 deletions(-)
  delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3188-cru.txt
  delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
  delete mode 100644 doc/device-tree-bindings/clock/rockchip.txt
  delete mode 100644 doc/device-tree-bindings/pinctrl/rockchip,pinctrl.txt
  delete mode 100644 doc/device-tree-bindings/thermal/rockchip-thermal.txt
  delete mode 100644 doc/device-tree-bindings/video/rockchip-lvds.txt
