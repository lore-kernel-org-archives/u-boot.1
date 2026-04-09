Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DB7EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E416840B0;
	Thu,  9 Apr 2026 15:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HculJbkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7196184120; Thu,  9 Apr 2026 15:33:21 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C4DF84099
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so13041955e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775741598; x=1776346398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tYNIvtNuD6q5x12kmcmLHf15a4szn/0QjmU9A8sZ55Y=;
 b=HculJbkJCwDAbILI5MyxQTD9AJGbs2zFU9hBAquCQ0EvY2stqza0WVG7RE9ASbbUAa
 7G/NwjCNDLeaCKKZSZdafoHy4Js6/0HRZ/Ro79h/4Tl6wtEg9ih+kQzQBADgwY/BDbWa
 Kxpu8GXwky1bxB/cx1ECeX5LVeQvgEtzyXPS8BhaoqxmjVKK0YVqVMsWTb+jrDBrjqoh
 zWRkUcylvWqpEKtXUkurDApDV/imbpysQnfhr7Q89lw2EUMBfWj6V1B1/a3AKyVYFiJo
 ccg4bF/JV/mIajjzEQKkB7zpk9qx7evvLEe2oLMnMBuGVvZBzdDiM5x0t67UTK7douiN
 wlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741598; x=1776346398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tYNIvtNuD6q5x12kmcmLHf15a4szn/0QjmU9A8sZ55Y=;
 b=ZsHd7mzVeGHyg0chniniDjxbbh99NCAjItN5rJn9648/kE1UyA+DIBEta3x79GQbGl
 rxYUlwrieADtVaK65GbZBKYnBUw2qyJX0iGgi3+9gOHipJ1fgrJItyxS8x2wc4BhOrzi
 O/WjaBTFKc++CSVEGguZW/NYbmB+nvjAsQ4G4RBXYAtOGcu/gwDxNdZv3f/n9B/LWVWy
 Cm3Rly/ZHuFWzR/5EFIwYsAXNrEEv3R6FMPyhZkzKsyosCuLN6qGNhEmjlxNtINb1kef
 OGjbOQZiYlekqsrFF7gn667RLwUgmhiMk4JIiz/IVHa1AAqRAyniWKfO2YeX0RymgpHR
 LAWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD3xi9WtMhNm587pCmuL2nZxHrv0cdm8LDq98KcJHQULp8n3ph8kshVr7GAR6d2sqa5cnZE3c=@lists.denx.de
X-Gm-Message-State: AOJu0YyJt9lm8dnCOIyKXI0gSW3KniNUpEMbNgqmth9xxEESZjsp+T4L
 h3S2X4fdmlo8ivei86434l5TvvyhZ1j9LcCvVdKKuHWB3BZsN09jILxV
X-Gm-Gg: AeBDieuftrxEug5xivNn322JjOg+a495bKAXEDUKmOs1tp+DOZisBpTDOpHwdxfCOrL
 aY0j1U1TT5U/j4k5OGwNjq2lao41da7mk0jivlxSb0Uzq03iReFksoqRBSJSGgan/lAA/tOsDBp
 cThKzx10W05e2T4BqW6As1Vk9vX1bx4B7/TCajxaudZCgj/WnSQ1TnmtBavBbJ9YDgkauwuEDTs
 wvPOdh9BgziEQLE6qepYdzDGM+sWzUq8lKeoVqDo97cEIkwobZF+BOng/0NejK/1sx/o2/k3Iev
 CieboaLVHWFckxI2PvpWLLzMm7qfGIyrYMip4E+6empmBodg/+orZwVYqTH0N1oigSPtZOMrznn
 p0vEAgllMyaZ+lTIyFuRc4NVHAk11iLuJBuU1q+q574qykS+pczmqMDvHN4P4B/QIgdSLvuAHnS
 fkTCJPUpmV64PPkawpbmZOWJOoHNH2/e4tnwA4/JFLDx8doFOsGGZDaGWOy1WJvngoO3n1JsCY9
 7Fhq8Zguw==
X-Received: by 2002:a05:600c:8710:b0:485:5ba3:37d8 with SMTP id
 5b1f17b1804b1-488996b0589mr401152455e9.5.1775741598149; 
 Thu, 09 Apr 2026 06:33:18 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-61-192-155.retail.telecomitalia.it.
 [82.61.192.155]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488ccf9b919sm52876215e9.0.2026.04.09.06.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:33:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v6 0/6] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Thu,  9 Apr 2026 15:32:56 +0200
Message-ID: <20260409133303.31875-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series mainly rework the FS loader to permit reading firmware from
container that are not exactly a readable filesystem.

Also splitting out the generic firmware loader infra from the
filesystem-specific code will make adding new loader types easier.

One scenario is when a firmware is shipped in a FIP container as
a generic blob with an UUID.

FIP are mostly used on ARM in the context of ATF.
In such context U-Boot is loaded as BL31 and the PHY firmware
can't be stored in the FIT image for the kernel as U-Boot should
not depend on the presence of the kernel to correctly enable PHY
for Ethernet port.

To handle such case the PHY firmware is stored in FIP with a
predictable UUID.

One example is with Airoha 8811H firmware where the FIP can
have a blob with UUID "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2".
(generated from command "uuidgen -n @dns --md5 --name en8811h.bin")

With these example DTS entry:

fs_loader0: fip-loader {
	bootph-all;
	compatible = "u-boot,fip-loader";
	phandlepart = <&mmc0 0>;
	partoffset = <0x100>;
};

mdio {
  en8811: ethernet-phy@f {
    reg = <0xf>;
    firmware-name = "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2";
    firmware-loader = <&fs_loader0>;
  };
};

And PHY driver using the get_fw_loader_from_node() and the
common request_firmware_into_buf() it's possible to
load the PHY firmware transparently by just declaring
the required entry in the DTS.

get_fw_loader_from_node() is implemented to actual get the
loader from DT. This was something that was already in mind
from when the FS loader was implemented but then it was
never implemented in favor of a single loader per device.

The first patch is a minor fixup for something that probably
won't ever happen.

The second one is a good reworking of the FS and FW loader
moving the internal struct to a dedicated header. (this is
really to enforce what drivers should use and what
driver should not mess with)

Then there is the request_firmware_size() new OP to get only
the size of the firmware. Useful for case where the firmware
size is not always the same and change across different version.
(the patter might be get size -> alloc buffer -> get firmware).

Then the FIP loader as a basic parser of FIP. This only
read the FIP header, loop all the entry and search for a
matching UUID. If nothing is found then no firmware blob.
Very simple implementation.

This is being CI tested on [0]

[0] https://github.com/u-boot/u-boot/pull/884

Changes v6:
- Rework to generic FW loader UCLASS
- Account for firmware offset in FIP loader
- Add UBI example in documentation
- Improve variables order
Changes v5:
- Fix unment dependency for config flag
- Move request_firmware_size before FIP loader
- Add documentation patch
- Improve get_fw_loader_from_node() implementation
- use min() instead of custom MIN()
- Fix handling of some return value
Changes v4:
- Rebase on top of next
Changes v3:
- Add review tag where possible
- Check blk_dread ret
- Generalize mount_ubifs with generic_fw_loader_ubi_select
- Fix some typo
- Drop useless ubifs umount (nothing is mounted in FIP)
Changes v2:
- Better handle header include to fix compilation error
  on some devices
- Fix typo for ubifs fix commit

Christian Marangi (6):
  misc: fs_loader: fix ubifs not unmounted on dev_get_priv error
  misc: fs_loader: reorganize and split to FS loader and FW UCLASS
  misc: fw_loader: implement generic get_fw_loader_from_node()
  misc: fw_loader: implement request_firmware_size() OP
  misc: fw_loader: introduce FIP loader driver
  doc: dtbinding: Update documentation for Generic Firmware loader

 .../misc/{fs_loader.txt => fw_loader.txt}     |  29 +-
 drivers/misc/Kconfig                          |  16 +
 drivers/misc/Makefile                         |   2 +-
 drivers/misc/fs_loader.c                      | 326 -----------
 drivers/misc/fw_loader/Makefile               |   5 +
 drivers/misc/fw_loader/fip_loader.c           | 544 ++++++++++++++++++
 drivers/misc/fw_loader/fs_loader.c            | 230 ++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c     | 192 +++++++
 drivers/misc/fw_loader/internal.h             |  82 +++
 include/dm/uclass-id.h                        |   2 +-
 include/fs_loader.h                           |  47 +-
 include/fw_loader.h                           |  42 ++
 12 files changed, 1141 insertions(+), 376 deletions(-)
 rename doc/device-tree-bindings/misc/{fs_loader.txt => fw_loader.txt} (60%)
 delete mode 100644 drivers/misc/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 create mode 100644 drivers/misc/fw_loader/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/fw_loader-uclass.c
 create mode 100644 drivers/misc/fw_loader/internal.h

-- 
2.53.0

