Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDEACCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 13:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FFB0833F6;
	Wed, 22 Oct 2025 15:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DIzIxaxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CADAD8357F; Wed, 22 Oct 2025 15:47:10 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C688323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c4c346bd9so8919524a12.0
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761140827; x=1761745627; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gt56Q90SppOnSrDC3yFGRUeykrqzu9bCyERXpuhriKQ=;
 b=DIzIxaxPE19tWt8v3Ej7VB/a26tFKBjPZb7yX8iDVxnPnZB5qMejrjWLt8HQaZ9Pz9
 shPYIwCrW4pV5kjP+9zaFFBh6/pGxHMVu12c9n8KPtSlTw2w8HJhU65QGRNvjXALbVAg
 NXpTkcdb4aWXO3+qu1TlUWkUPkZo9rL1xCfV+y2PbbMafMg9fDHF9wSVsbvZmSaAHBof
 HWU+iHlKLatdk9uFeeCkqgqRk/nsaIKTkxPfGVns05ZFhSpqtAI1eOMGEfYI1jEgSqfc
 II/Oq9bUYrtzei4SczfFQ7gTLsx8SfdJHkGNYDMTBav4JQu7UaUbGDtBNuZ9vlfiXPi/
 gUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761140827; x=1761745627;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gt56Q90SppOnSrDC3yFGRUeykrqzu9bCyERXpuhriKQ=;
 b=cUcw/jg5vDdha4zbKLj4jamsESFJLFo7eUDHSnT2D45eF/pIbsB1VckixhfFqREesB
 z5dOkchw933t8bR5sZjTEPA7xQCpYjDDiPGFCKa5e62ZuQHZLuBoj8akGvIVRVtng17Q
 STbbZtKCGEkMpfWOT3z2Y3oYrpqEmUns7cqEd4peFbZ+YXS0equM7Y/8Pgrqsbo0pQmt
 YfRTvCcnslh6b4odRKTsWSze4cIaOg+pXIE+0or6kRb/Yy39ZKfvbz8I1iVAu2m11EhV
 MJpBLaRtAKrNqC0UGWD5acw8gL+sk9I/7IRMdrioTI25dZY9BPdJZKk7sqCDrS2hxZsr
 O1aw==
X-Gm-Message-State: AOJu0Yy2aS5uViQqNzAOUwuOBoDMdvI/K1HKWv8boe4qgucz2x+9vFhd
 S7bEZ+YJgnJqQym0cdm05qgQpRZwEJ7e2JNATea72NzBli+R3xo9m9YEmp+TyCl90SMuyf/j7YV
 iE+pTn+E=
X-Gm-Gg: ASbGncu8j4b8zqcx628wThpKUAXYz2S95nUB+FsiA1yhbZXuiMJULT/xF8PX8/YKfEr
 XsfdAAIHg4TNGgLytgjNZ9Q52pO7BTC8caU0ZQxXEaj9W0QKetXUA06qnq8XsCQ4a9OUvIWnwqG
 La7sOSi6vz2PJbAU+nF95MC0iyJOEFfdxHa9LUpTXl3vRAdOSRxrPhO9sx3CZ92TvxbvSJkrvYF
 ow/19O4G8ZGy6gdwbvmBsMr5st0jCAz/UI6eoU+rEiZj5lIyDY3ovfqTkkrvKjj2yplaILxtca2
 ectIANsqsPcdmlUS2f2kGxVWVLYxJsN2OFpg+9lrPTAf1KHTeYsPb5RHF4nRxfhKUhuMe5ACDzs
 d8EyosQh8i6taQ2/aSSaAO8KI5jsjI+DbHK93p3c7mFmGJqh5pQ8zVqhb2HngZXG7XHPkh3wW8M
 qyaqX4/TnWyUaPU83CRw/ksNe87iLPluZuNm0Gh5LLEkQcUjMcU4oQJW+uCdPA
X-Google-Smtp-Source: AGHT+IGvTwa3Zl8/t8Co9/7FqiuiOC4zZO0KK09lUCv1Ac2KV/OFcsXe3Nil8lISUXczkyaGDdZ7Zg==
X-Received: by 2002:a05:6402:2113:b0:63b:f91e:60a2 with SMTP id
 4fb4d7f45d1cf-63c1f6c1fc8mr20091057a12.25.1761140827438; 
 Wed, 22 Oct 2025 06:47:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed50:db7:290:9079?
 ([2a01:e0a:3cb:7bb0:ed50:db7:290:9079])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c48a93998sm11739189a12.4.2025.10.22.06.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 06:47:07 -0700 (PDT)
Message-ID: <308fa89f-6e2c-4804-b806-71fd8bfbedda@linaro.org>
Date: Wed, 22 Oct 2025 15:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-20251022
Content-Type: text/plain; charset=UTF-8
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

Hi Tom,

The following changes since commit 813a0df27a8af587bd25a6a4719f68066b370091:

  env: Invert gd->env_valid for env_mmc_save (2025-10-21 13:18:46 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20251022

for you to fetch changes up to ed6ec8d1ca0658d811df1cc78d06fec4f7f69fc9:

  net: designware: fix bitbang init error (2025-10-22 14:28:33 +0200)

----------------------------------------------------------------
Pull request net-20251022

net:
- airoha: improvements
- Tighten a few more driver dependencies
- designware: fix bitbang init error
- phy: Make driver overloading get_phy_id depend on !COMPILE_TEST
- phy: add paged PHY register accessors
- make dhcp_run() common for NET and NET_LWIP
- dwc_eth_ops: Correct check for FDT_64BIT
- mediatek: mt7988: various fixup + MDIO detach
- phy: aquantia: switch to use phy_get_ofnode(), fix bindings typo

net-legacy:
- bootp: Prevent buffer overflow to avoid leaking the RAM content
- tftp: make TFTP ports unconditionally configurable

misc:
- uthreads: Make use of CONFIG_IS_ENABLED consistently

----------------------------------------------------------------
Alvin Šipraga (1):
      tftp: make TFTP ports unconditionally configurable

Beiyan Yun (2):
      net: phy: aquantia: switch to use phy_get_ofnode()
      doc: bindings: fix aquantia-phy.txt typo

Christian Marangi (4):
      net: mediatek: mt7531/7988: fix broken PHY turn ON/OFF
      net: mediatek: mt7988: restore PHY page on PHY setting exit
      net: mediatek: mt7988: free allocated MDIO bus on cleanup
      net: mediatek: move MT7531 MMIO MDIO to dedicated driver

Jerome Forissier (1):
      net: make dhcp_run() common for NET and NET_LWIP

Jim Liu (1):
      net: designware: fix bitbang init error

Lucien.Jheng (1):
      net: phy: add paged PHY register accessors

Mikhail Kshevetskiy (2):
      net: airoha: simplify rx/free packet logic a bit
      net: airoha: increase the number of rx network buffers

Paul HENRYS (1):
      net: bootp: Prevent buffer overflow to avoid leaking the RAM content

Tom Rini (6):
      uthreads: Make use of CONFIG_IS_ENABLED consistently
      arm: socfpga: Tighten a few more driver dependencies
      net: Add SYS_FAULT_MII_ADDR to Kconfig
      net: Remove BOOTP_VENDOREX support
      net: Tighten more driver dependencies
      net: phy: Make driver overloading get_phy_id depend on !COMPILE_TEST

 README                                        |   3 -
 cmd/Kconfig                                   |   4 -
 cmd/net.c                                     |  36 +-----
 configs/an7581_evb_defconfig                  |   1 +
 configs/gurnard_defconfig                     |   1 -
 doc/device-tree-bindings/net/aquantia-phy.txt |   2 +-
 doc/usage/cmd/tftpput.rst                     |   8 +-
 drivers/net/Kconfig                           |  10 +-
 drivers/net/Makefile                          |   1 +
 drivers/net/airoha_eth.c                      |  40 +++---
 drivers/net/designware.c                      |  12 +-
 drivers/net/mdio-mt7531-mmio.c                | 168 ++++++++++++++++++++++++++
 drivers/net/mdio-mt7531-mmio.h                |   9 ++
 drivers/net/mtk_eth/Kconfig                   |   2 +
 drivers/net/mtk_eth/mt7531.c                  |  20 ++-
 drivers/net/mtk_eth/mt7988.c                  |  92 +++++++++++---
 drivers/net/phy/Kconfig                       |   2 +
 drivers/net/phy/aquantia.c                    |   2 +-
 drivers/net/phy/phy.c                         | 113 +++++++++++++++++
 drivers/power/domain/Kconfig                  |   2 +-
 include/net-common.h                          |  10 ++
 include/net-lwip.h                            |   1 -
 include/phy.h                                 |   8 ++
 include/uthread.h                             |   4 +-
 lib/Makefile                                  |   2 +-
 net/Kconfig                                   |  20 +--
 net/bootp.c                                   |  24 ++--
 net/bootp.h                                   |   4 -
 net/lwip/dhcp.c                               |  22 ----
 net/net-common.c                              |  35 ++++++
 net/tftp.c                                    |   3 +-
 31 files changed, 497 insertions(+), 164 deletions(-)
 create mode 100644 drivers/net/mdio-mt7531-mmio.c
 create mode 100644 drivers/net/mdio-mt7531-mmio.h
 
 CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/27997
 
 Thanks,
 -- 
 Jerome
