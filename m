Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280FFCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83634848BA;
	Tue, 16 Jun 2026 21:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="doBiijAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F2D848D1; Tue, 16 Jun 2026 21:18:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA94848A2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 21:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so48517365e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781637533; x=1782242333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PFah7SDnFb7jcAq1/XfPdTAgRJo11WKLku2YiZJ7xOA=;
 b=doBiijAPAEEyrhmnU7IedzMLW6CAY6+aTbcOFcrSv6h08l3Yas30g6jyVx0+M/wXrQ
 YD9lrMxMr5bk1RCJaUHPT7hg+YGMibRW/CPPNZMbk2U7qC/1UXsolHA9aUnqFzrcCSAo
 gjiu4WsbAIPNlD9fQXLRsP9QGoABn0mVbfyJ6kktAgzodfvN3/LXN7Z6alnYYM+6PUC+
 ncYsHaJhgcphVYLtLGAzd+jGgopBgru5zxfH1WV5x01vixXyqquw5S+vVJ9RjHDAVVc1
 glNKjXuKHRv1Onhd9K9wSOiP0IgT7k+oI0ZNOQ/oQNzvrgSfvOUtuqUf+Lx+91y9UQZ9
 umIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637533; x=1782242333;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFah7SDnFb7jcAq1/XfPdTAgRJo11WKLku2YiZJ7xOA=;
 b=Ni9k1YMBDIRTrMzXw9NyKufqhOoVf3h4N4YQOtJgpl7pgvm+deMQB+s+9mynuLbhBH
 pTvMgm+KKbnadoGilg5svsuffLv3r+ANChYCnxciAvoh9wjHIu+Fq6fW7mmvHW6WpuAs
 UGxLRegtil/QL+oy8qNJdEbEiuHRTF4vi2VxjROXNBJHo8/EhC8CN1Y4FlMcyHv0RFeR
 2wbtaS0Ls4VXAWFAB3DdJTDzsmxrXM+PKTyvX+BYcUIVejxYVr9uaIveK3z0i/amK8JL
 n2vkRvOxKVc1gjWiLNT+h+mDHbtMlOCF9Ii9AIiV9oMb12kMG6xwwytsECTgdtVY4xue
 iEKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KigEKSYJdepgTYfyTdeN4w9G0H9W7h060S+gbdZ76sam7/2n4j7zspo4Bj2CrhWSWtP9PpHA=@lists.denx.de
X-Gm-Message-State: AOJu0YxjoVZ/XTb41hRTTmpmRaKWbVP7gzSBrBFncOouwMp8Tofk3f30
 1Uzq5aFJYM26+J1eDQNyJ5pRjLdIPBb/xLkDzMYEV8RFLQEOl2Ti9oK+
X-Gm-Gg: Acq92OEgjobXSeA0WKP9yoS8KI19I5rlnSNxyvPSvBJk1x7hDd0AZNyXQto+R4i+Gma
 DUYrRWVkOvWHR2dRjg/tkQNa7YV9YhBQCiclrky5fveaknBUp+WU+RDIB3+98ictihYStua1SZF
 9m23JCV1XFApQ8HttTmq3nt0+RqkvGylhigrgfr8VZJAhtSsk/X/CDUQfCHuqhVh96Cn0s2IsBf
 Toba9VnEha3HPd+0IZNsggeoNV8wRjpMb+Yksp7br4Acgxx7tdtAVOqQxcAGk4WadlHm+8Lrlun
 Kg2VEiPcf4INNSRpy0MFy11gDBQ6N95d6QfrVX67eCpCYDVWoWZMKBOcAYcRFpceTZM1YBvvHsi
 9uoa9Bn4CwrrklEqt7KrDLMtZWjPViCtCHKsTfzuuxe3XnTJfJuDo9fNa5kXhciMXSW1X32MKRd
 GR7LwZwosOisncPHs6DW8OPV8b2rt8grnJqNbghsLPDtmyn+7TabeqL7g=
X-Received: by 2002:a05:600c:609a:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-492333a991fmr14446195e9.9.1781637532703; 
 Tue, 16 Jun 2026 12:18:52 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4922f9cd140sm91326895e9.0.2026.06.16.12.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:18:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Randolph Sapp <rs@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v7 0/7] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Tue, 16 Jun 2026 21:18:35 +0200
Message-ID: <20260616191845.6182-1-ansuelsmth@gmail.com>
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

Changes v7:
- Add tests
- Rebase on top of next
- Fix compilation for vpl
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

Christian Marangi (7):
  misc: fs_loader: fix ubifs not unmounted on dev_get_priv error
  misc: fs_loader: reorganize and split to FS loader and FW UCLASS
  misc: fw_loader: implement generic get_fw_loader_from_node()
  misc: fw_loader: implement request_firmware_size() OP
  misc: fw_loader: introduce FIP loader driver
  doc: dtbinding: Update documentation for Generic Firmware loader
  test: dm: Add test for FW Loader feature

 arch/sandbox/dts/test.dts                     |  20 +
 configs/sandbox64_defconfig                   |   1 +
 configs/sandbox_defconfig                     |   1 +
 configs/sandbox_flattree_defconfig            |   1 +
 configs/sandbox_noinst_defconfig              |   1 +
 configs/sandbox_spl_defconfig                 |   1 +
 configs/sandbox_vpl_defconfig                 |   1 +
 .../misc/{fs_loader.txt => fw_loader.txt}     |  33 +-
 drivers/misc/Kconfig                          |  16 +
 drivers/misc/Makefile                         |   2 +-
 drivers/misc/fs_loader.c                      | 326 -----------
 drivers/misc/fw_loader/Makefile               |   5 +
 drivers/misc/fw_loader/fip_loader.c           | 544 ++++++++++++++++++
 drivers/misc/fw_loader/fs_loader.c            | 230 ++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c     | 204 +++++++
 drivers/misc/fw_loader/internal.h             |  82 +++
 include/dm/uclass-id.h                        |   2 +-
 include/fs_loader.h                           |  47 +-
 include/fw_loader.h                           |  42 ++
 test/boot/bootdev.c                           |  34 +-
 test/boot/bootflow.c                          |  12 +-
 test/dm/Makefile                              |   1 +
 test/dm/blk.c                                 |  41 +-
 test/dm/fw_loader.c                           | 112 ++++
 test/py/tests/test_ut.py                      |  18 +
 25 files changed, 1373 insertions(+), 404 deletions(-)
 rename doc/device-tree-bindings/misc/{fs_loader.txt => fw_loader.txt} (58%)
 delete mode 100644 drivers/misc/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 create mode 100644 drivers/misc/fw_loader/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/fw_loader-uclass.c
 create mode 100644 drivers/misc/fw_loader/internal.h
 create mode 100644 test/dm/fw_loader.c

-- 
2.53.0

