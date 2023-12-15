Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5057FC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D391B87C64;
	Fri, 15 Dec 2023 21:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJ+KDyab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67FBB87C75; Fri, 15 Dec 2023 21:52:31 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7C487C50
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4259c7dfb63so7006891cf.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702673548; x=1703278348; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=853Ldboy94OQjwVeGtpB7Gc/0ixdxbntMJtzzogOIaw=;
 b=BJ+KDyabTQv/7BPyPlIcnZ/1AUQl/WJUkKmNFyMrNoIzYpArJEd8bC7ZZe1kmuBib0
 U2bPlhszHi9BZSsXnS1DBKdXB+Is/GWgv8NxY10jd4VQKH3xGpzxnVHAYXHIO8HuH3zp
 VE2LlneKPrhrJa64ssjqrZPx+aSDWo2scQSQqiQ1XODk1n16WrDr2pPITJhduYOeDxL8
 52lv+kk8K6Sc/FhmaR+fry47vGPsTTmc+bteoCLuMchc7aRbOHm1xsNcyrX7Z5mol8e3
 35rtTgqvInTAX/tF+lmL49VP/C8BQ201LAYmBPx0YZW8L6l+JNiulbFp4Nw0MMbxHT4D
 VvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702673548; x=1703278348;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=853Ldboy94OQjwVeGtpB7Gc/0ixdxbntMJtzzogOIaw=;
 b=WOzhjrHdZeGhs8AYuwciOEWO8hMN6mqcO22/hRIOH80VqmiytfExsfxUweA6OJhPnk
 twiP6VbvytBkkJb8e1HKW0QcSl9FjxOnG5E7LJ62aU+8H9cBApqT1GbJUx84f/HSZiTA
 xHkfC0QpFn7fLd4kQ/PeHZ+lhqlykHEMYbQPBL85XKuzpc15twXMp+i67MwEmzNs+aZP
 0SDzEnfjKXGJK31N+3zYdvPiDhtIms8fDnKTMTFsyZr8Q4MJhqMCLr8AVR3M52uYiH+F
 trLOknJ12U5mFdybnnXy1y+DaPB6MYrN6+TtxxXAYpuDFVSpG1K7eb64kHYNT1ng8eX6
 jAEA==
X-Gm-Message-State: AOJu0YynlOv/tOI0qK5cYXQMLtVzSwl/z6g8d0uHYlzImEHjsEMLl9yC
 cLr7Y/Qvuu5oe9XC/xslK1UaKk2QOFuyow==
X-Google-Smtp-Source: AGHT+IGm6ElUPp9LtvSrfZx4bztSSQZ1B8X92gFU5X2iwGAm1f5DU8fNk4EHgKAYm6nWtHh6mzbLoA==
X-Received: by 2002:ac8:5bce:0:b0:425:a28f:ddd8 with SMTP id
 b14-20020ac85bce000000b00425a28fddd8mr14035012qtb.137.1702673547824; 
 Fri, 15 Dec 2023 12:52:27 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 bb38-20020a05622a1b2600b00425b3fd33f2sm5732837qtb.90.2023.12.15.12.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:52:27 -0800 (PST)
Message-ID: <30d112d0-3952-5b40-5689-a0abfc37f989@gmail.com>
Date: Fri, 15 Dec 2023 15:52:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jim Liu <jim.t90615@gmail.com>, Igor Prusov <ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
Subject: [GIT PULL] clock changes for u-boot/next
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

The following changes since commit fa3f19aa56c519d6345cc774187b7a8fdc053d71:

   Merge tag 'xilinx-for-v2024.04-rc1' of https://source.denx.de/u-boot/custodians/u-boot-microblaze into next (2023-12-14 13:27:11 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-clk.git tags/clk-2024.01-next

for you to fetch changes up to 652d8d4561a34fc71d9bcb6ad2b0035d2c4189c1:

   clk: nuvoton: add read only feature for clk driver (2023-12-15 13:05:55 -0500)

----------------------------------------------------------------
clock patches for u-boot/next

The main thing in here is Igor's conversion of soc_clk_dump to a clk_ops
member. There's also a write-protect feature for nuvoton clocks.

Signed-off-by: Sean Anderson <seanga2@gmail.com>

----------------------------------------------------------------
Igor Prusov (8):
       clk: zynq: Move soc_clk_dump to Zynq clock driver
       clk: ast2600: Move soc_clk_dump function
       clk: k210: Move soc_clk_dump function
       clk: amlogic: Move driver and ops structs
       clk: Add dump operation to clk_ops
       cmd: clk: Use dump function from clk_ops
       clk: treewide: switch to clock dump from clk_ops
       cmd: clk: Make soc_clk_dump static

Jim Liu (1):
       clk: nuvoton: add read only feature for clk driver

  arch/arm/mach-zynq/clk.c               |  57 ---------------------------------------------------
  arch/mips/mach-pic32/cpu.c             |  23 ---------------------
  cmd/clk.c                              |  13 ++++++++++--
  drivers/clk/aspeed/clk_ast2600.c       |  83 +++++++++++++++++++++++++++++++++++++-------------------------------------
  drivers/clk/clk_k210.c                 | 104 +++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
  drivers/clk/clk_pic32.c                |  37 +++++++++++++++++++++++++++++++++
  drivers/clk/clk_versal.c               |   9 +++++---
  drivers/clk/clk_zynq.c                 |  52 +++++++++++++++++++++++++++++++++++++++++++++++
  drivers/clk/clk_zynqmp.c               |  22 ++++++++++----------
  drivers/clk/imx/clk-imx8.c             |  13 ++++--------
  drivers/clk/meson/a1.c                 |  58 +++++++++++++++++++++-------------------------------
  drivers/clk/mvebu/armada-37xx-periph.c |  20 +++++++++++-------
  drivers/clk/nuvoton/clk_npcm.c         |  15 +++++++++++---
  drivers/clk/nuvoton/clk_npcm.h         |   1 +
  drivers/clk/nuvoton/clk_npcm8xx.c      |  12 +++++------
  drivers/clk/stm32/clk-stm32mp1.c       |  31 ++++++++--------------------
  include/clk-uclass.h                   |  13 ++++++++++++
  include/clk.h                          |   2 --
  18 files changed, 288 insertions(+), 277 deletions(-)
