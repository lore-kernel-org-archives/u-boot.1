Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1D0C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 14:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83393803DF;
	Thu,  5 Jun 2025 16:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="yjkunNmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FD618091A; Thu,  5 Jun 2025 16:29:40 +0200 (CEST)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1507B80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 16:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-604f26055c6so4387147a12.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1749133777; x=1749738577;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aQQeMzxMcH4UxpGxGdpd5cR/uT/3UYR49rcQndKx7k=;
 b=yjkunNmohFh0VpePsnFsgxTxHccuEQnJY9Yh8llvwuC9AGcLpY6yXHrGUizPqEx/r+
 S/ApdXELS4XsSLacyIFmMmqrjt8yBwA2Jx9dURu152ZK523ryOu6h/iBWfT7EBWq6IUT
 se6XqxZtnxu7tSTRpgvzhp65GrjGzpljF0SnjUFw6gxHvU5t51XCsU/ExulKQ5Kx2Cyx
 ggufctx7yheb6k9udPKFXn2knH5oFEyZWMNa6N9LKbDL+lrUlSq4EOCWZkssevHZS9QJ
 vtZsvaWyPc2+NyaGczWKUevtmwI4mY5AjAqOWHCIwVtgXp3vPYQl7Zzf2Gg3AqBG0Ajd
 qCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133777; x=1749738577;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1aQQeMzxMcH4UxpGxGdpd5cR/uT/3UYR49rcQndKx7k=;
 b=WDxUQQ15MRWAGUXbWuXjzx45R6A/qmt7rHpHnGyD3ZDyvpsLmtU0Dh5md59m0toB3u
 Weu9An2342ivQE8FXYVvbiCt2Aec88hFv/lUwbTsDhBpEKbG+p2YGdEOBgWUM84KWmGm
 jwZInNVw2LBHkJJyBUPXvObb1b+vrutLI8itqK7FX6MouFBngsP2JmFutE/K0qdwuGmZ
 j3WqU+TAq6Z6fpWzktYlneRSQIN89Ao4y5EieL6dPOS0GZ9hGRB5QFW/IQ1R3GJ2UuLY
 ZDjVJdbuKx3+HBmne/JSnv63t/bQN0PoscIaRogTzBZ1yRb2IZLagUc2Ss8CYPx3/iEr
 K1vQ==
X-Gm-Message-State: AOJu0Yyquissb2GNhK8uLL/TzrPvIC8U/+cp6KYv+TydQ53DlGH5HoCJ
 XbjeJ5s6WzNVCid64ALu39HsS6Ap3ZxpCqwZNw42tOwBJjerf4UZZWHtSc9CJplJme1rYoqk+pV
 SclAWNfLCV7uWsg==
X-Gm-Gg: ASbGncvGbhl6Cbr1uTLyBhq5tmfwi6zlrzxAfs4RvSZ1LjBmAxZt4LVfxG8l8vgiE76
 BwgMwKk+LZgHMJzr9Ur4im1thsTS9XUriEGuagcYrdsze+4ndWoAAgUr/d5Wv1xhT6CNF+Ip+40
 saU5lNujM0qC9Sn8VpxVbjUUh0Zm7sXH8yqya/6Z8libl5fgz+6zwoxzXCheStMwC4IeQR0ents
 xC1vDku/qTM4m/yxiom9OI5ECphSFaFbzC1H/nOZZ8FqGQqusqwCjgzf/Pvl+DdIlv9GEcLpSNf
 sc+EtAPHM/XZAAqXyjoaakoVjV+WnbZA0Mpf9nSI+0/JowgrIyDVDpZQsEpg8sdRFmBg+25ydHN
 zRA==
X-Google-Smtp-Source: AGHT+IG3TwlAjPJfYIj7aGV1CNb9UbnbaZQbD0SuCkHedtpw/75DlJkG8wymgzKq+y4Kp2D15ZHOHg==
X-Received: by 2002:a17:907:3d05:b0:add:fa4e:8a6a with SMTP id
 a640c23a62f3a-ade07606d5emr368738566b.10.1749133777237; 
 Thu, 05 Jun 2025 07:29:37 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7ff080sm1287825166b.11.2025.06.05.07.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 07:29:36 -0700 (PDT)
Message-ID: <8ab256b6-7469-4d14-878c-ec379943fa3e@monstr.eu>
Date: Thu, 5 Jun 2025 16:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx patches for v2025.07-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
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

please pull these fixes to your tree. CI is not showing me any issue with them.

Thanks,
Michal


The following changes since commit b22a276f039f818d5564bec6637071cfc8a7e432:

   image: android: fix ramdisk default address (2025-05-30 13:44:05 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.07-rc4

for you to fetch changes up to 77b053502f396e83f6a0ea38d747d6836dc501f0:

   usb: onboard-hub: Fix return type for regulator APIs (2025-06-04 10:24:16 +0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2025.07-rc4

usb:
- Fix regulator handling

net:
- Fix MII clock handling

phy:
- Fix GTR line logic for sgmii

pci:
- Fix pcireg_base logic

fpga:
- Fix change handling in intel_sdm_mb driver

----------------------------------------------------------------
Frantisek Bohacek (1):
       phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift

Martin Kaistra (1):
       net: gem: ignore tx_clk if MII is used

Naresh Kumar Ravulapalli (1):
       drivers: fpga: intel_sdm_mb: Flush cache before FPGA configuration

Padmarao Begari (1):
       usb: onboard-hub: Fix return type for regulator APIs

Venkatesh Yadav Abbarapu (1):
       pci: zynqmp: Fix the pcireg base

  common/usb_onboard_hub.c      | 12 +++++++-----
  drivers/fpga/intel_sdm_mb.c   |  7 +++++++
  drivers/net/zynq_gem.c        | 14 ++++++++------
  drivers/pci/pcie-xilinx-nwl.c |  7 +++++++
  drivers/phy/phy-zynqmp.c      |  6 ++++--
  5 files changed, 33 insertions(+), 13 deletions(-)


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

