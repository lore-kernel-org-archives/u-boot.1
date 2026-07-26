Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06B0C531C9
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 13:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55B3C4066F;
	Sun, 26 Jul 2026 13:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDbhGPazNJa8; Sun, 26 Jul 2026 13:12:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 675BD40663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785071544;
	bh=OBe7EeKsas0csVXF1NjphFR7vUvfREpXf1MX7PyrWUg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fTUwqMyFdaIDVqBunbXKbZdD22jJUTqbJmAU0bZt2UGrqaVyG8QcI6Tt0G4oZyyB7
	 e+NlTQGXLa8hqPlXxYpovN1UougEJXeGqgndXgbaj0oPsKHSSufBrELNfsg+u36rHM
	 GPMUP4wWsgh2r/vzmRjK/P7tUqnHQA29Go4pzGi7clLw763aFT5xXCXBMkPz5fUI4R
	 SJjabKSEXD+9bQeobyqJc/Ol06H9cMNepx5lXLH70CbsvIWUmOg9zOXXWErHM6ENjP
	 QTxFPwS0bqRM//bWMJ5rgq6iyv6yDRX46dZQAsqNDzJz0hRpZcnlVuvVCzXFcgR04y
	 3PUOwknlUvUew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 675BD40663;
	Sun, 26 Jul 2026 13:12:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA33A3B1
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFA0A80C64
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYZh4s8fTkUW for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 11:57:20 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=bhargavdas100@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D7C8A80C59
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7C8A80C59
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7C8A80C59
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8C4844F6; Sun, 26 Jul 2026 13:57:18 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32418005D
 for <u-boot@lists.denx.de>; Sun, 26 Jul 2026 13:57:15 +0200 (CEST)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so1861722a12.0
 for <u-boot@lists.denx.de>; Sun, 26 Jul 2026 04:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785067034; x=1785671834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OBe7EeKsas0csVXF1NjphFR7vUvfREpXf1MX7PyrWUg=;
 b=BFPCZZWH2igIQKOVIEDzaBmtnZUZzOBPoi4MWKW1YnhzgIItvL5IaCE/9G0Vq79ojJ
 id0amieoh2Nzsxg3LrM72ZlRqHS1vn7LWOaxkPRSy05CbL+fwFr273bBng26QzJ3Mo6p
 KEJ0zr/59oiZr5WQHDJsxvwhzKcan9x/PNma1zwvX9GASmScrWw15sebAXJ8+J4R//d8
 u2tLFpsNm8D+5Pkl7wjbc982zor1gCE9w9rdkwnB9i1gUH3VfiKZ7mlxysUx0RwMy8Bc
 ITt/E6LRU+QyaN1y1IRQ625N8bSGM4FIcCzg4Q7/ecj+guxrT+SKkpCJAHKAeC0p4Oh8
 9mGQ==
X-Gm-Message-State: AOJu0YxjVt36eeLUyO+gfUtJWJO7Tkausc43NshirQRdtmHRoKp2+2sY
 fSrcxRqGoduZgW/luMs5/h45wXJr5dygGv3uJ3vnIgguxmQMIbW6EV9kp+2iEKrL
X-Gm-Gg: AR+sD10muWNkC4BfvxKb2BAV9kkd7JkTwjwpy3gAmNa7FX8cNLb+JbBswbT0sGwbpt0
 rbDXkWX7p3zfnca1MQEcgooghrqcDmZvbrXhFQVYMzJ3SsRDrftqWyRx1xL6zYozJJALPr96nFD
 YX6py+N0EstiggyEBXEsJIJiqLpQU0vEcl9J2XTz+tZ4QIJOmDTGvXasi5LJAI+Sy8cdVetOOS7
 6Brw5DKQW5UyIUQnOPm/OT0Oz4bqavEduKFD4C5/g22ZqLXtBRfBxZke7DLlqhTXZ0pBElMgfeY
 VEKrZCBR3qA0jqbzFbObiA/duejBpr8ltpZWopr0kk4nhCY7ZrkdpVoxZM/AfSw4x7dTLJI6PgR
 PUcuHd7yKldjaVj/A6UGzkS7QpZmlwpZrzAEfiRTcJo2hwpQqKtZQ8PKt/qO+uf636u/DYBCB9E
 YZqOOWofoDWRcrrnJdoVbS/wSnGhl5Rw==
X-Received: by 2002:a05:6a21:4584:b0:3c3:89cf:f43 with SMTP id
 adf61e73a8af0-3c67dd6a0a1mr3799584637.30.1785067034104; 
 Sun, 26 Jul 2026 04:57:14 -0700 (PDT)
Received: from bhargav-Legion-Y540.. ([49.207.202.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a67f3sm20811168eec.29.2026.07.26.04.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 04:57:13 -0700 (PDT)
From: Bhargav Das <bhargavdas100@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	bhargavdas100@gmail.com
Subject: [RFC PATCH 0/3] Add initial Raspberry Pi Pico 2 / RP2350 support
Date: Sun, 26 Jul 2026 17:26:45 +0530
Message-ID: <20260726115702.15397-1-bhargavdas100@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 26 Jul 2026 13:12:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785067034; x=1785671834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OBe7EeKsas0csVXF1NjphFR7vUvfREpXf1MX7PyrWUg=;
 b=gI+XSrPyWPWH/0dfFjaAyG1Mo478ARKRhwNcHSBnyeSwRNACz0cu182bgKksGffB30
 J0bgocLoHXQt1PTIx23On+8DFhZnkBtOvorNrOzvh7FGmMeoMo2XJSVJPtz6j0FhKCdR
 AHlAyxVfoPJ09cFLDt6lSiW+aZbnSf1GEvvGL+eMk69lZAX2u0QpLUBRxadOtwuIZCm4
 WlKDRKTdyDTFf5hsAE5AjkvMN3SV0mte9fwlWKg7wDxzCPAi5WL8KWs3+WOa+D6WOzmH
 JWulVRjCDAHAFFDgK/BKMqwln5Zfu2bQgDZsL3aGlj4KmkDG0gA6XbUwF4CQEv3Tfw7X
 sKbQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gI+XSrPy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bhargavdas100@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gI+XSrPy"; 
 dkim-atps=neutral
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

This series adds initial U-Boot support for the Raspberry Pi Pico 2 board
and its RP2350 SoC, only the dual-core Cortex-M33 support is added.

Sent as an RFC to get feedback on the overall approach before polishing
further.

Status as of this RFC:

  - UART1 console works; UART0 is not usable yet. Need to investigate.
  - Boot-tested on both Pico 2 and Pico 2 W boards.
  - `make sandbox_defconfig` passes with patches applied.
  - This series selects CPU_V7M for RP2350. RP2350's Cortex-M33 core is
    Armv8-M since there is no CPU_V8M support in U-Boot yet. Is CPU_V7M
    acceptable as a starting point with CPU_V8M as a later follow-up?
  - RP2350 has no device tree in mainline Linux yet, so patch 2
    hand-writes rp2350.dtsi / rp2350-pico2.dts locally, and
    rpi_pico2_defconfig uses CONFIG_OF_EMBED rather than
    CONFIG_OF_UPSTREAM.
  - board/raspberrypi/pico2/ is added alongside the existing, unrelated
    BCM283x Raspberry Pi boards under board/raspberrypi/. Is this
    directory placement acceptable given the SoC is unrelated, or should
    it live elsewhere?
  - Some functions and structures such as `struct rp2350_clocks_regs` is
    defined but not yet used.
  - misc_init_r() sets a fixed value for the "serial#" environment
    variable. This runs after relocation, so a successful env_set() here
    confirms env works post-relocation.

Flashing procedure used for testing:

    picotool uf2 convert u-boot.bin u-boot.uf2 --family rp2350-arm-s --offset 0x10000000
    picotool load u-boot.uf2 -v -x

Bootlog:

    U-Boot 2026.04-rc3-00070-gbabf6d42fec7-dirty (Jun 23 2026 - 01:55:20 +0530)

    CPU:   Raspberry Pi RP2350
    Model: Raspberry Pi Pico 2
    DRAM:  520 KiB
    Core:  5 devices, 5 uclasses, devicetree: embed
    MMC:   
    Loading Environment from nowhere... OK
    In:    serial@40078000
    Out:   serial@40078000
    Err:   serial@40078000
    RP2350>

Bhargav Das (3):
  arm: Add RP2350 architecture support
  arm: dts: Add RP2350 device tree
  board: raspberrypi: Add Pico 2 support

 arch/arm/Kconfig                          |   7 +
 arch/arm/Makefile                         |   2 +
 arch/arm/dts/Makefile                     |   1 +
 arch/arm/dts/rp2350-pico2.dts             |  30 +++
 arch/arm/dts/rp2350.dtsi                  |  32 +++
 arch/arm/include/asm/arch-rp2xxx/rp2350.h | 307 ++++++++++++++++++++++
 arch/arm/mach-rp2xxx/Kconfig              |  58 ++++
 arch/arm/mach-rp2xxx/Makefile             |   4 +
 arch/arm/mach-rp2xxx/image_def.S          |  23 ++
 arch/arm/mach-rp2xxx/rp2350.c             | 261 ++++++++++++++++++
 arch/arm/mach-rp2xxx/u-boot.lds           |  94 +++++++
 board/raspberrypi/pico2/Kconfig           |  15 ++
 board/raspberrypi/pico2/MAINTAINERS       |   9 +
 board/raspberrypi/pico2/Makefile          |   3 +
 board/raspberrypi/pico2/pico2.c           |  83 ++++++
 configs/rpi_pico2_defconfig               |  29 ++
 include/configs/rpi_pico2.h               |  48 ++++
 17 files changed, 1006 insertions(+)
 create mode 100644 arch/arm/dts/rp2350-pico2.dts
 create mode 100644 arch/arm/dts/rp2350.dtsi
 create mode 100644 arch/arm/include/asm/arch-rp2xxx/rp2350.h
 create mode 100644 arch/arm/mach-rp2xxx/Kconfig
 create mode 100644 arch/arm/mach-rp2xxx/Makefile
 create mode 100644 arch/arm/mach-rp2xxx/image_def.S
 create mode 100644 arch/arm/mach-rp2xxx/rp2350.c
 create mode 100644 arch/arm/mach-rp2xxx/u-boot.lds
 create mode 100644 board/raspberrypi/pico2/Kconfig
 create mode 100644 board/raspberrypi/pico2/MAINTAINERS
 create mode 100644 board/raspberrypi/pico2/Makefile
 create mode 100644 board/raspberrypi/pico2/pico2.c
 create mode 100644 configs/rpi_pico2_defconfig
 create mode 100644 include/configs/rpi_pico2.h

-- 
2.43.0

