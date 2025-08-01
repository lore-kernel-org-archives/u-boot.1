Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967E0C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 10:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BCD839E8;
	Fri,  1 Aug 2025 12:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zRrGps3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E59839F0; Fri,  1 Aug 2025 12:34:22 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6117383612
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 12:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61592ff5df8so1842097a12.1
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754044458; x=1754649258; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+s+aCMc+tgkXaTLzkGLzKDMDJZCsB+tbOyY5tfecpc=;
 b=zRrGps3nu6Nla+Y94wxwdyenpKHlL524hYenTvGQ0z7mw8/eBO1316HisWfe6js8PJ
 Xwh5pp/5p6+XfK8GtbKpJnje04W6zfxg0d7LVGOpZDSD4cMHyPlhbSmMtRd1BlOzImQE
 qkrjAl7P+H21aB6fNQmyvhE8JVX0hJg3YNyPCHiRwAc2nCM0ZmM3Gn9ya93EAsxaRQt0
 124pFfUMUbzeba4AMKIrlaSgVJhm5YtSzNO1lMWmE2rKoHoznYX/wqnOQK5gRdEOkO9c
 2uT8hp60abzmG49Z+YHhoipOoxW2yT66bABV0Nct06oze4LX8ukOENuw+GTjd7JLEoPU
 yfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754044458; x=1754649258;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R+s+aCMc+tgkXaTLzkGLzKDMDJZCsB+tbOyY5tfecpc=;
 b=fPWzZLnCaz1rUfXxj+8AYAzxA1xhF4GuhUBX1J7B+wHG5zDMX+v/P9fo27elDgopjA
 aKx6Sq/f6W0SUSQ/eOvTFdrSnywk4aOd8/7o7oE49b3uLN6aXkLqh5013EZb3d88Yl7E
 a9kyEAxKoy2YBtC4l0jMyYvo6Pjpg80j8d22zIG4laIZkv2ehUdirLQCD3b9XRL9RTlD
 MtPxX+Pe2Jq/p7VgsDcVupFixnApHBu8IpTJj/DCjd9Atm4Ei0PHr8st9lpT8TyoPXGR
 ax98jY5LMd3ZEqwNb33/7hvsa3ziuJoiS0DKYGDd4JyPNm01W1j9FYP0cxXHJpjuEeWA
 Jq5A==
X-Gm-Message-State: AOJu0YxxsEDIRbI1Tgc7IcAsb7ews+qdg6yN6IrKs3G1dKjbZKvGMyqR
 B3+agw4h36fTJTKlDsg/MZ+P2P8ialpZKdIG2mOKdYnZTb6UqbxctK9troHkE29+gl0=
X-Gm-Gg: ASbGnctk2qEwS1CaytOUxmOM6/YQ2pMUK/8Fr8c14DYJzmD0oF4owJ7Pt2nWLndJsIE
 Mxoq2xZg+aJVgGNZO+50C1dX2BY1+RtEg7FYJOzoAho709bOGHLoD+Fp/7FUyZz102c56L4DifQ
 RH0w6hsrw/aM6x6BsQtmdGSuTg3fO7ZLgT9Z5Vvn1p9QVbhhZWDyJHdZaIpRb0FYVXRJ+Tw+q9H
 OjGT6kqXVR+P6ChsTO1PYutJAgtTgs4vNCZyAwbsUQXZcufjK0hVEc4Wa/OzaM6TDghjhVPBrJk
 sMdd8txXdyIz2Pagx+i1qH8SBIuGLVzGekoquJLQCEw37HVtf4hmBmQc0IUgnkvyejWqTRE4iyY
 I/FHWDmoThNok9ZxIvFyOhH8mXh87rxgjOAo5C5DRDTeGV4xDy2CgX/MH+/xzPpb9Tl7eYQ8PWD
 fCOw==
X-Google-Smtp-Source: AGHT+IHXGsqL5smw3cQsCaUOP/wM8XldkuU54vaDQBqjmvNeTYP21mP04Uwouj28VmK1ADUGyXljZg==
X-Received: by 2002:a05:6402:278a:b0:607:116e:108d with SMTP id
 4fb4d7f45d1cf-615cdddfdb4mr1883529a12.21.1754044456871; 
 Fri, 01 Aug 2025 03:34:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f372:9752:cba2:6958?
 ([2a01:e0a:3cb:7bb0:f372:9752:cba2:6958])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8fe7944sm2560383a12.33.2025.08.01.03.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 03:34:16 -0700 (PDT)
Message-ID: <fd7715fe-1d52-4b29-9a6f-bd0f36de0416@linaro.org>
Date: Fri, 1 Aug 2025 12:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Please pull net-20250801
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

Hi Tom,

The following changes since commit f5e968a28e7cdc2c4365f5a382e02f074ee03fac:

  Merge tag 'u-boot-stm32-20250731' of https://source.denx.de/u-boot/custodians/u-boot-stm (2025-07-31 10:04:32 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250801

for you to fetch changes up to 5a4bfe38775ad5febf9b9fc58f0432f786a3d5d5:

  net: phy: Support overriding Auto Negotiation timeout with env variable (2025-08-01 10:42:22 +0200)

----------------------------------------------------------------
Pull request for net-20250801

net:
- Support overriding Auto Negotiation timeout with env variable
  'phy_aneg_timeout'
- Add missing virtqueue_kick() in free_pkt()
- Remove bcm281xx ethernet driver
- Tighten some network driver dependencies in Kconfig
- Add <cpu_func.h> to some platforms
- Fix a debug print in ftgmac100.cA
- Add parentheses around PSEUDO_HDR_SIZE

net-lwip:
- Fix build error with CONFIG_LWIP_DEBUG=y
- Remove eth_init() from net_init() as it is called later
- Simplify net_lwip_eth_start()

net-legacy:
- wget: Fix comparison of unsigned variable
- Incorrect macro used (TCP_0_NOP instead of TCP_1_NOP)

----------------------------------------------------------------
Andrew Goodbody (3):
      net: Add parens to macro PSEUDO_HDR_SIZE
      net: Incorrect NOP macro used for test
      net: wget: Fix comparison of unsigned variable

Christian Speich (1):
      virtio: net: Add missing virtqueue_kick in free_pkt

Jerome Forissier (1):
      lwip: provide a sntp_format_time() function

Siddharth Vadapalli (1):
      net: phy: Support overriding Auto Negotiation timeout with env variable

Tim Harvey (2):
      net: lwip: simplify net_lwip_eth_start
      net: lwip: remove eth_init from net_init as it is called later

Tom Rini (4):
      drivers/net/ftgmac100.c: Fix a debug print
      net: Add <cpu_func.h> to some platforms
      net: Tighten some network driver dependencies
      arm: bcm281xx: Remove ethernet driver

 arch/arm/cpu/armv7/bcm281xx/Makefile       |   1 -
 arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c |  24 -
 arch/arm/cpu/armv7/bcm281xx/clk-eth.c      | 142 -----
 doc/usage/environment.rst                  |   9 +
 drivers/net/Kconfig                        |  52 +-
 drivers/net/Makefile                       |   2 -
 drivers/net/bcm-sf2-eth-gmac.c             | 976 -----------------------------
 drivers/net/bcm-sf2-eth-gmac.h             | 222 -------
 drivers/net/bcm-sf2-eth.c                  | 274 --------
 drivers/net/bcm-sf2-eth.h                  |  65 --
 drivers/net/fsl_enetc.c                    |   1 +
 drivers/net/ftgmac100.c                    |   2 +-
 drivers/net/hifemac.c                      |   1 +
 drivers/net/pfe_eth/Kconfig                |   1 +
 drivers/net/phy/Kconfig                    |   5 +-
 drivers/net/phy/aquantia.c                 |  10 +-
 drivers/net/phy/phy.c                      |   7 +-
 drivers/net/qe/Kconfig                     |   1 +
 drivers/net/ti/Kconfig                     |   3 +
 drivers/net/xilinx_axi_emac.c              |   5 +-
 drivers/qe/Kconfig                         |   1 +
 drivers/virtio/virtio_net.c                |   1 +
 include/configs/bcm_ns3.h                  |  12 +-
 include/net/tcp.h                          |   2 +-
 lib/lwip/u-boot/arch/cc.h                  |   9 +
 net/lwip/net-lwip.c                        |  15 +-
 net/tcp.c                                  |   2 +-
 net/wget.c                                 |   2 +-
 28 files changed, 76 insertions(+), 1771 deletions(-)
 delete mode 100644 arch/arm/cpu/armv7/bcm281xx/clk-eth.c
 delete mode 100644 drivers/net/bcm-sf2-eth-gmac.c
 delete mode 100644 drivers/net/bcm-sf2-eth-gmac.h
 delete mode 100644 drivers/net/bcm-sf2-eth.c
 delete mode 100644 drivers/net/bcm-sf2-eth.h

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/27248

Thanks,
-- 
Jerome
