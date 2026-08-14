Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD91C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C0DF60866;
	Fri, 14 Aug 2026 22:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ohIIDHqxldjw; Fri, 14 Aug 2026 22:07:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 016ED605F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786745251;
	bh=OOLf+3T2msg7R2OAJKRvjXuXHaBeHtGq371mSq9t8DM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zaOFBDd5XeNguz5KOF+RFnqATh3XKDRmKxlBOnYo6cL/wzcTOQRyyvllSrrovgqAO
	 gAqnzsRHB5gHfwGKufVpm2RUZgCSRyG5VZ7NryJwnGTLdeoQ2uwVMrN5SHCIcZ3MFP
	 jsNOd+A4A6ZrVaSjcVySOldTDS2rhB2ECuihlNCWlVaun8bVg5ihFQV1152vsoGHOE
	 wBmX/DwYF9qDOmt5mYsfIRnBjVXUAgXM/ST0gSdZxX7v635D/2B0+tZbqg/3ZoAVQu
	 wbMQb4h6hNQZdwHM+EMJUwJzcxTuhRmVzEoNyvG0CN7qn5JWsMAbrAe0bXAws+H0jP
	 RfvHkuMUFF71Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 016ED605F3;
	Fri, 14 Aug 2026 22:07:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A4E22B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C731409D7
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tA_yBh4T7pjV for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:07:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 79C7E40080
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79C7E40080
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=S37DIN0S
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79C7E40080
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:07:29 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so1616454a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786745248; x=1787350048;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OOLf+3T2msg7R2OAJKRvjXuXHaBeHtGq371mSq9t8DM=;
 b=S37DIN0SmXB7OS82e4kvVpYXI3WRGh1mYYHp1ylc2N9gWzMStIw9xoz2wi7as83dyA
 J6+UWHl6S/FzUYA1lVYHbBRdtCg2NuiFgrMmj9gNOdAMH8YDMRi5pNp1SU6s78uuTkRe
 ZI/MNuEPlCvlRrbZn5E2r3IXS/vmPnFEnD0C0di9Exj/Tam+Kg4XdMEJqWdwdgsEPCEz
 d0KWc2t6pk7rjjNTXh0Lwnv2/atVmzhR5yoaRxT4jaBBtLORxRogOGRe5YKyNHCw3Xba
 UdKb3tfW8dTxIraArKp15HabZIVezBqkiCKiQAt9fm+WBdjVT/ZiOPhm6OljN9ob7ZFM
 16og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786745248; x=1787350048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OOLf+3T2msg7R2OAJKRvjXuXHaBeHtGq371mSq9t8DM=;
 b=A65nAGHuzaROK+vrwkL1HMnR0SGpcjU8dDaNoVCbPUsf2PG9dR3/EUNVH34sSll/AZ
 /75l1KZr2vdxAUrdfA+PeNSvIK85UFcLjXEalSPnhPj6CEmGj3qaBKKBSYa7vjhZkvxt
 Zb0Jhy+yBf23xEOVrGGrdx5wHxd/kBMRCjfQAYnTFiE5HM4CJjgQLW2UerhyhMj4dmCR
 T5nUvjDqOtxIENMWQkO5U16XjSPOIMDITDSqt1cE9dGaiN5lpdE5d/kFVxz6dTKrqlJH
 YsfaZHB7u4xP2qAWpfBq7qIH0z+66LVdHTlBfubviNsfWuKhvIBpaYUV/fVMi7pG4muJ
 xDdw==
X-Gm-Message-State: AOJu0YwORKxhK6KITkKJv4hUchbQ5jq/G/tiKmlcWMCgwQrodmSH8mXy
 HAsDbrQOUk541IUra3BAsiijzkOxIjNy/29KjIqGrafdyr/Cbl3EJwYkQm4R7A==
X-Gm-Gg: AR+sD10t5FWFeL/62Bc/17YiblNctHKZW+BXUf9sBrwjaA9kjKph9jcnssCEvXB21fe
 1LZTGu6ErjpgB3XibOdznJ5VsXGvsD8H2t2ZwbD5I2Rvc7UTLnP4YPWEwqqTMLnG2ewN52NcHju
 xz4N5LNUd/GZcCj1/LEBIo7JBDijWMs0lHeXalKfGewvYrNs7nQB23N31GvPq5ukVKzGyVdqzoy
 o8INGV2955PT3E4WemZHCDQbSg/FALjgKp6ZiyrzurZibRD8o6jxY3bCITweoOquGtsFmnKU9WT
 cWji48tlMQzkMygO2x6DNdHgE6NdooDeMkAF332BPFvZmdnoCtCGYJyURZxIGA3iSlSMmOYXXq0
 K8ckz8ZfiTCqIgi4kCWTDrbgdu9oGUcYBC1b3IPj5IW0enpMDbHi5OPJf2ZYD2N4o1mj9P5MeRh
 Gy8GrjQS5lZqL0PKumUoS5a4YRVfKhFuBAKp7P8K0XQuUIK4SJypsnFC0x3BVfxt1PqIcbGuE31
 r/0V6061s3wf+wj51H5v4nH6V/sT5Ju5/HD
X-Received: by 2002:a17:90b:3908:b0:381:5bd6:eb19 with SMTP id
 98e67ed59e1d1-3933e74e1bbmr9677757a91.18.1786745248346; 
 Fri, 14 Aug 2026 15:07:28 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:7e80:dfc:24c2:3bdc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03d4sm7121278eec.15.2026.08.14.15.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 15:07:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, franz.schnyder@toradex.com,
 frieder.schrempf@kontron.de, mehmet.fide@screeningeagle.com,
 stefan.eichenberger@toradex.com, S4210155@student.rmit.edu.au
Subject: [GIT PULL] Please pull u-boot-imx-next-20260807
Date: Fri, 14 Aug 2026 19:07:23 -0300
Message-ID: <20260814220723.1677460-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit d3e8597e46b635ec556a057bc42f0b0859654bdf:

  pytest: fix out of bounds access to bad_pattern_ids (2026-08-13 22:14:05 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260814

for you to fetch changes up to 817664148ebd584a55a4f482d198fe6ae595d079:

  configs: toradex-smarc-imx8mp: enable SPL_SYS_MMCSD_RAW_MODE (2026-08-14 16:21:23 -0300)

u-boot-imx-next-20260814
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/906

- Several fixes for long-standing Vybrid issues.
- Improvements for imx6dl-sielaff.
- ADD SPL Quick Boot support for several Toradex boards.
----------------------------------------------------------------
Franz Schnyder (1):
      toradex: apalis-imx8: select QP/QM device tree from OTP fuse

Frieder Schrempf (3):
      ARM: imx: Support detection of ECSPI recovery mode on i.MX6
      board: imx6dl-sielaff: Remove board_boot_order() workaround
      board: imx6dl-sielaff: Enable environment on SD card

Mehmet Fide (5):
      gpio: vybrid: read and write the GPIO block, not the PORT block
      serial: lpuart: test the receive flag, not the FIFO counter
      toradex: select EVENT for TDX_CFG_BLOCK
      colibri_vf: restore the pre-2017 text base, the BootROM refuses the low one
      doc: board: toradex: add the Colibri VF50/VF61 page

Ngo Luong Thanh Tra (1):
      arm: imx: hab: validate HAB M4 event length before memcpy()

Stefan Eichenberger (4):
      board: toradex: verdin-imx95: add SPL quick boot autosave support
      board: toradex: smarc-imx95: add SPL quick boot autosave support
      board: toradex: aquila-imx95: add SPL quick boot autosave support
      configs: toradex-smarc-imx8mp: enable SPL_SYS_MMCSD_RAW_MODE

 arch/arm/include/asm/mach-imx/sys_proto.h     |  1 +
 arch/arm/mach-imx/hab.c                       | 12 +++++
 arch/arm/mach-imx/init.c                      | 75 +++++++++++++++++++++++++++
 arch/arm/mach-imx/spl.c                       |  7 +++
 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c | 30 +++++++++++
 board/sielaff/imx6dl-sielaff/spl.c            | 22 --------
 board/toradex/apalis-imx8/apalis-imx8.c       | 34 ++++++------
 board/toradex/aquila-imx95/spl.c              |  4 ++
 board/toradex/common/Kconfig                  |  1 +
 board/toradex/smarc-imx95/spl.c               |  4 ++
 board/toradex/verdin-imx95/spl.c              |  4 ++
 configs/aquila-imx95_defconfig                |  2 +
 configs/colibri_vf_defconfig                  |  4 +-
 configs/imx6dl_sielaff_defconfig              |  2 +
 configs/toradex-smarc-imx8mp_defconfig        |  2 +
 configs/toradex-smarc-imx95_defconfig         |  2 +
 configs/verdin-imx95_defconfig                |  2 +
 doc/board/toradex/colibri_vf.rst              | 66 +++++++++++++++++++++++
 doc/board/toradex/index.rst                   |  1 +
 drivers/gpio/vybrid_gpio.c                    |  8 ++-
 drivers/serial/serial_lpuart.c                |  9 ++--
 21 files changed, 245 insertions(+), 47 deletions(-)
 create mode 100644 doc/board/toradex/colibri_vf.rst
