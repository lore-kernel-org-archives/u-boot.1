Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D88E85367
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F53883DC9;
	Fri,  3 Apr 2026 15:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZT2t6LNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2909183CF5; Fri,  3 Apr 2026 15:52:17 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D0A83642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486ff201041so18945105e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224334; x=1775829134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=c5pl+pqJuImQHWyIGgd9nOw/+G5uiuyC0P5x1XkwVOo=;
 b=ZT2t6LNvxvD/eZwdCc3gdL9g6EDWPS+f4udSvC0oSOp/fP3c4LWxIUgXvIG+8avydJ
 v/CjoveKxFgxbxueBYKh5pi20rWeXDcZk/MqGTIkMdgjockP4w1uykI4S8WqRlsCW0NI
 Q15StUiwJSFA/PTL5JNH0lxiY524fgoUSby1hrUdZeufb5H2M6LVH2czSS8JsVYay/wk
 GuxOdq1i1m0IzC48Lsnc/+id3lPctSv27Im5mus1i7Bkl6C8VCdAhAni4cwo0sze/Yur
 GFoL5zBIlPV2n6B4H9X59pqZWeHpWEBN7YPQ8YC/cSc7wXTaQmIKFaacBMFD6N0bQEpA
 DApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224334; x=1775829134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c5pl+pqJuImQHWyIGgd9nOw/+G5uiuyC0P5x1XkwVOo=;
 b=BMRD3EMEU8KgXtHre6G6+Q2P0NBf9nqbRkoRcww719FGrJJh3ZyExP+up5YDrt8Lty
 IKehCydwQP8FZYWSRsiwuwkinz8/9rNcwmTyGU16z+RLbhHvDcpSkPZYRJaUk/mpsBk1
 Te1in/DD2z0TdRvCx/BNbcWCuEn4yQaWIe8Sovd69D7XmUH7SwoRjrY25CRVomUWJqJi
 qj1mUn17rfjmYyfU2pL8hx2wXdxDWDtmrbHO2qR1zWVBd1SzBqUMHJ9/u8ZyZ/Jcff4f
 v3C9lDeHgH2BRU5H9RxIkdElMok+ogIFukGQwWzR3DJwMYVmtHvZh0MNzQFhD5MdH3MP
 fBeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFqMQSNVabiHhYruwhCxJuJIlwQ1R2KMaRVhLORz796TEViMf7J8SzO9FLCmGLFXWEqc/WZiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyAEMoq4fz5BvvR9dRcVcW3EdTZXA2sji1PpMN9LxEXHLf090nQ
 YGkbJfgzZ8IwfHjuZhzesqwhmQ1hEKMd0h+DUOZLpkqxvftPIX1Gnb7A
X-Gm-Gg: ATEYQzy9yzTbHRJZ5bHMUxQcAs+rD5kvgTGsfwKDfWk/DXjc0pbnC2SQRz345dHzBs1
 s+5VVf1TRj5Sq/Z2i54DDSuw/1wmQlkMZtg5fI0ESGM4T92eI9mgE8sdolZsnjVyCwaxns6nt2K
 zwJe6HS1h6ZDdqqReKfnHpFX/pVo6giEC6gX/Cjve5XoHkgW4kNPqga5nTjnM/CixZi/pShU2L0
 LB/XmAaBXA3EgA4c6QaU4IBCedqpvWtaxTY24u58DmmJg+zNdzBktHPBR4yMc3cx/XvkmLERodH
 1PrCZGMk+OZsZG6J7jC0dQ7AQ44g/QGGXZhi10TnjmPYkE3u+QFLRT6zJJVJR35yrDWObu7l2RW
 pAe3ErCNXghlCue33aaDiPGFWAYP51HnPyiRnVd/Wz4HLPgsoSAnrZacm+YOFwPBMO6GSjM2fcQ
 5WPjjpXaOFfUCm16ib7Ea047s=
X-Received: by 2002:a05:600c:5292:b0:487:1826:d89b with SMTP id
 5b1f17b1804b1-488996ecd1cmr53568995e9.9.1775224333850; 
 Fri, 03 Apr 2026 06:52:13 -0700 (PDT)
Received: from Ansuel-XPS24 ([217.202.87.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4888a7162cesm196732895e9.13.2026.04.03.06.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 06:52:13 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 0/6] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Fri,  3 Apr 2026 15:51:57 +0200
Message-ID: <20260403135205.26979-1-ansuelsmth@gmail.com>
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
  misc: fs_loader: reorganize and split to FS and FW loader
  misc: fw_loader: implement generic get_fw_loader_from_node()
  misc: fw_loader: implement request_firmware_size() OP
  misc: fw_loader: introduce FIP loader driver
  doc: dtbinding: Update documentation for Generic Firmware loader

 .../misc/{fs_loader.txt => fw_loader.txt}     |  15 +-
 drivers/misc/Kconfig                          |  16 +
 drivers/misc/Makefile                         |   2 +-
 drivers/misc/fw_loader/Makefile               |   5 +
 drivers/misc/fw_loader/fip_loader.c           | 578 ++++++++++++++++++
 drivers/misc/{ => fw_loader}/fs_loader.c      | 193 ++----
 drivers/misc/fw_loader/fw_loader.c            | 196 ++++++
 drivers/misc/fw_loader/internal.h             |  64 ++
 include/dm/uclass-id.h                        |   3 +-
 include/fs_loader.h                           |  47 +-
 include/fw_loader.h                           |  43 ++
 11 files changed, 983 insertions(+), 179 deletions(-)
 rename doc/device-tree-bindings/misc/{fs_loader.txt => fw_loader.txt} (77%)
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 rename drivers/misc/{ => fw_loader}/fs_loader.c (59%)
 create mode 100644 drivers/misc/fw_loader/fw_loader.c
 create mode 100644 drivers/misc/fw_loader/internal.h

-- 
2.53.0

