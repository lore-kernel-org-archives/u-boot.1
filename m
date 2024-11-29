Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25571D70E1A
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 05:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B41893A3;
	Fri, 29 Nov 2024 06:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R4gBamew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF171893A6; Fri, 29 Nov 2024 06:37:55 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D04B89397
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 06:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21285c1b196so13495165ad.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 21:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732858672; x=1733463472; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dTVRg65Krx58El4Z9GaI2OBLfLZtXpfWQN9YHnLiWpU=;
 b=R4gBamewPjOt9GpmFOMsts+zVlyyX79RqosiGcOEj/KO5V8W9lZ+mCkZgQKwMGvNnL
 1MMEW79zdSHmjpCcqX9nzgLHRhghCSL9djhp1Wq7C4EpMHv2EfzoEoPqNiBoKArhdtzD
 17Ow+mlpTHguHKXDWmujYnIIzNtYgR4wwd2o1novHCgUNc3fUxnQW3S2mDlcg58uHpye
 /jzhxog7sNGyeqbmKSR5mnV1mnqXnZp0uEuT5/jOzAopNek23j2q6TZjYwa8uDFr0w58
 /LWmdz29BQCTJcgXcvx9zUAkuLiHrhafIE5iJmvQ6iyEPKOnI316mYku6nV/7nKwSFnt
 gvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732858672; x=1733463472;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dTVRg65Krx58El4Z9GaI2OBLfLZtXpfWQN9YHnLiWpU=;
 b=RTh9ztpIo++2WKvlbcefqIu0kvkV1FZd/9yLk6c6IbE3Lg3a3DubB1YFEhfGUWsDjq
 sVwcuboUlK3elgp3eRHo7A5QCFMcZEfm0DXXjKxq0CZSeexeRX9hNgKhl3BVlmgXIUfe
 BIsfiElp5yth5B/8CGCX6Rc9RTdbPUGvCiWfciMyRSwWRsRI3V5OMSC9O1p46COkorsW
 qctpmJ/u4jyN5uiAYIHqfVozZqw0JedsgT50NuC554Dsaxky0m0jWYtLb1h0LQTvuRWJ
 GLlhLWfv3+dTmRM0zR3MrQkcOV5ryiYNgLHNby4CFhgO2C4Cw59OBfXkW7wtIV2Tlw2D
 4R2Q==
X-Gm-Message-State: AOJu0YwamS/gXLqoqqNPwHlu2n40SEapG6mFY6TJAaDlPQ25KrCawnx6
 YAekAKH9BlUhnXNooh0hqGRsTawt7n5ND79TS4l/mWiY3ADnDveZ
X-Gm-Gg: ASbGnctBzRtHJ2Gm7XyBKkdPEBJYd1AcJF0OPn7ZDm5WGg8WqmNK2TQZdLPGyHbVmfG
 sDlyATCsVkAxaYPDWpQ2DRNo+Dj5Ns0IpooLxJqZeyYwfNXtwqnpKpBRfAd6G6XbYNiV/PB3P/T
 7990X052ClPQBC6V+BffM4NsLyk5AMR5+SE+fNeDfAtw6Tpxk6VKzTcyV2z7Ishf4ugp5j7QZVR
 /KTxdCaHsNOQx6GIhv251H+YgULd0gXPaon02QVtUENRXRwQ1XD9o8ay4Dc5IWOQ678ORNiuA1/
 dUijqO5Fb8u46XtpnGw=
X-Google-Smtp-Source: AGHT+IEN/0j/QkPMmt4oNOD+ginGVSIUL9rwEcNY/bewZ38RlyvSr7LWwU/TCnq7HwAmK3xgXL4jXA==
X-Received: by 2002:a17:902:d507:b0:20c:7ee8:fc3c with SMTP id
 d9443c01a7336-2150175b496mr123921345ad.22.1732858669549; 
 Thu, 28 Nov 2024 21:37:49 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f2345sm22901415ad.17.2024.11.28.21.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 21:37:49 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Subject: [PATCH v4 0/2] riscv: spacemit: add support for bananapi-f3
Date: Fri, 29 Nov 2024 13:37:38 +0800
Message-Id: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJTSWcC/12Oy27DIBREfyViXSKeNnSV/4i6uMAluWodu+BYr
 SL/e4nTRdrljHTOzI1VLISVve5urOBClcZLC+Zlx+IZLifklFpmSigjpVR8ovh+nXiYKGuujIW
 ghAseDGvIVDDT16Y7vj1ywc9rs86PkgWoyOM4DDS3FRGbwPa+NyEF4XPOoGVK2NmUcufRJrQaA
 7u7zlTnsXxvTxe5yX5P6b+nFskFVxqsczFaLbvDaQD62LfVTbToZ9j8g3WDvQNjnVAQev8Mr+v
 6A3B8TRwxAQAA
X-Change-ID: 20241112-pickup-bpif3-245ab208b9a4
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Padmarao Begari <padmarao.begari@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, 
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732858662; l=2625;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=g/Mh5FLMGo7HcyYwnAgEo4RyjQoy+GkTrQcm/uNVVOk=;
 b=bgb2IgfEDOa08s6PKBEdUosQlMQ128sg8FhwY/qtwNq8HfliN1YDqeSfxzPrAa0I42GiURWVv
 RWEmEezlYf4ALOwYozAsmbsJXePuyG9+w545fEudN63iUWAUhPBYtJx
X-Developer-Key: i=pericycle.cc@gmail.com; a=ed25519;
 pk=Wd3eEYWh1pNETTTXjX4aeanCWrr201iLaYYW5G1BdbU=
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

Banana Pi F3 board is a industrial grade RISC-V development board, it
design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x USB
3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.

This patch introduces fundamental support for the Banana Pi F3 board,
encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
operate in serial console mode.

Changes in v4:
- Change uart compatible in k1.dtsi in v3, cause related driver in not implemented in u-boot.
- Update doc, show how to validate the patch.
- Update maintainer, remove kongyang cause he lefted.
- Link to v3: https://lore.kernel.org/r/20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com

Changes in v3:
- Add base commit
- Clear redifinition warning while building in UART_IIR_ID
- Change underscore to dash in bananapi*f3
- Update maintainer
- link to v2 https://lore.kernel.org/u-boot/20240718043329.1500-1-seashell11234455@gmail.com/

Changes in v2:
- Change license to GPL-2.0-or-later
- Add memory node for dts
- Add ft_board_setup function for kernel memory init
- Use default prompt
- links to v1 https://lore.kernel.org/u-boot/20240714150828.736-1-seashell11234455@gmail.com/

Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---
Kongyang Liu (2):
      riscv: spacemit: bananapi_f3: initial support added
      doc: spacemit: bananapi_f3: document Banana Pi F3 board

 arch/riscv/Kconfig                     |   5 +
 arch/riscv/cpu/k1/Kconfig              |  18 ++
 arch/riscv/cpu/k1/Makefile             |   6 +
 arch/riscv/cpu/k1/cpu.c                |   9 +
 arch/riscv/cpu/k1/dram.c               |  54 ++++
 arch/riscv/dts/Makefile                |   1 +
 arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
 arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
 board/spacemit/bananapi-f3/Kconfig     |  25 ++
 board/spacemit/bananapi-f3/MAINTAINERS |   6 +
 board/spacemit/bananapi-f3/Makefile    |   5 +
 board/spacemit/bananapi-f3/board.c     |   9 +
 configs/bananapi-f3_defconfig          |  20 ++
 doc/board/index.rst                    |   1 +
 doc/board/spacemit/bananapi-f3.rst     |  86 ++++++
 doc/board/spacemit/index.rst           |   8 +
 include/configs/bananapi-f3.h          |  13 +
 17 files changed, 750 insertions(+)
---
base-commit: 40c45a57974bdb09fffa31dde65ddf69e5de53eb
change-id: 20241112-pickup-bpif3-245ab208b9a4

Best regards,
-- 
Huan Zhou <pericycle.cc@gmail.com>

