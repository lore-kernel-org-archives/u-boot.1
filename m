Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B72910775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5871283E16;
	Wed, 18 Mar 2026 17:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KayHYGbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D5A68352B; Wed, 18 Mar 2026 17:50:55 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77BF8352B
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439b94a19fdso7512f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852651; x=1774457451;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BcsoXayVDioZfQ0j+ptf/V43ESEi7dX/W0uXk2YH0B8=;
 b=KayHYGbNrqIA/YLgZJrUwAUlpEhcYvLxoNFdOcQ9WzIj9kURf9aqkFEhB5YxMCgqUf
 8NvxzRsxsWF4SMYMdH6AG6MQ7JeMmE+c/bE1A9fmhXr43GUrpX27JeIXIC+K7dVKCFEy
 qXpqqm7I/ZyN3dnGQWv95+HNiTWd08SxUquW3SxMXjsn0alSnC4FlnEZlQIcpVexYylh
 9gOfS1yY554Co+V7YGiTq7R7W2qWOY22tPU8fVn6ZNV9+WPnfkxIeV8NL1/hYXdR/8Sq
 Y0eSIyrPmPSwmfd157w25gZwQqVvkWFo2pWuRIcSQwyUxSQk8uK5JqLD+/l63wQfGLUy
 NCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852651; x=1774457451;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcsoXayVDioZfQ0j+ptf/V43ESEi7dX/W0uXk2YH0B8=;
 b=bBIT57rV5WSQePEkC9ALqgokOKTeTUKe/H2v8yx94pQjDcbkiEPcor7DLOn6kl2AAV
 +RDvSg2GmSgD4fHyN3OMonj8g4MkK9jmBwGtGsN/pCXoPpg+xI65FME9LZaaH3eGQsxo
 XiaJCzmbs0ifQEnTGOp4BoUZ5O1JfCZXu1VVNfmRkP2f1/tzszNn33m84/8FouyP3og+
 0wE3fvKjLtD3GYE0+qhQ72em/Ss9tXAxo+UEBIPaZ5Cs8OqkDS4bYoIB0dWVHQKm+75a
 44MgM09b2CtaGa+YEjBW//z8r93Rh1eUB4bVaKDZrDSM43m7FwRIhmREwXRbMIoRUzUq
 Bs9g==
X-Gm-Message-State: AOJu0YxYOFXs76FlG3ibZxyljWZu9mbW/ZsLewvA6fm4MB0hokzBoVf+
 1lq4ODGvpz4h2lx022LVox+SyS/Gboqt7yIclsAuT3N4oPVdEnb5QBfMj2xifc3no+g=
X-Gm-Gg: ATEYQzxigpdXc810YK5CBTxP/617ztoQUZGB0iFUG1EnHc+/NFrYE7vRUrGR0SdXupD
 QeUUlqnjECHaOYBTr44RjPnip/Xtbi6Dv2cMvPvMu6KwefHLsEoJWsJtIu7fxYSGU8S37PJ8VMr
 ZHKpHqMlP785aCa3filo8U1901mVKfU+MN2v9gE3homlLsUtttyhwLKOL2Alo39qYAcSjOjSgsT
 nEtubjnlIjfyOv5fTcVgNuZmpnMwbAD3nROKh2BpZnwaOlJMbjdgEFGGYuOmW+qLonkukIkSNx6
 NomfZv+CbKnwNSVVGmS1IxPAd/ON7/KTK3N+jwNxZb2uobOT0Z7teVf0cj7WUU7IDMqseWxpILl
 zRX7gNOlSZph1TkoOfW43eB/L5GOyW5T9fop3FxI3AniooHpqw+KHTL2rfKPairvy1ToJdMdFLu
 vDk02amtb7Xr5mgfT1ORsMxUO1lIrbIn4Suk+lYAut9pmM6T14sFMkBiPe1S+xoy2jFe7ysKxZP
 2A730enCdGhqRjKtmSuiQw5KKmHyk0R9vXjURvn8fsjVyY9oPSxgSDUnoQ/byd+MR58sbLCYGC7
 JMVtBSk=
X-Received: by 2002:a5d:64c3:0:b0:43b:47bc:c147 with SMTP id
 ffacd0b85a97d-43b527cc553mr7235366f8f.45.1773852651259; 
 Wed, 18 Mar 2026 09:50:51 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/9] MT8195: add ufs support
Date: Wed, 18 Mar 2026 17:50:52 +0100
Message-Id: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQy2rEMAxFfyV4XRW/8phQSv+jzMK2lIyhjlM7C
 R2G/Hs9mdl0UbQQV0hHV7qxTMlTZn11Y4k2n32cipAvFXMXM40EHotmksuGKyEgLJ041WAQYR0
 y5HWeY1qgVjVZQmuVVKwMz4kG/3OAP88Pneh7LfzlUWTWZAIXQ/BLXwktXcdr1C13yGVJQjfYY
 MuNOblaStRoROPu6EA5m8NYX709fXWQaDKBYKTJR0AaXJwGP2bYBJTQujRJreXAP6y5fnmb6LU
 sf2d3cxefl5iuxxM2cbh7ctv/7i1YDi22SpDTqjP0B8vO+77/AjMTjbRcAQAA
X-Change-ID: 20260311-mt8195-add-ufs-support-535ebedbb323
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

This series adds ufs support MT8195.
I also include in this series some cleanup on phy-mtk-ufs.c phy driver
and ufs-mediatek.c mediatek ufs driver, and pmic support for MT8195.

UFS boot has been tested on a MT8395_EVK board.
To enable ufs boot, we first need to erase mmc partitions.

The configs in config mt8395_evk_ufs are the minimum configs needed to
enable UFS. This has been validating with the following commands on
u-boot (extra configs needed for non generic configuration):

=> scsi reset

Reset SCSI
scanning bus for devices...
mediatek-ufshci ufshci@11270000: Failed to get PHY: -19.
mediatek-ufshci ufshci@11270000: [RX, TX]: gear=[3, 3], lane[1, 1], pwr[FAST MODE, FAST MODE], rate = 2
  Device 0: (0:0) Vendor: MICRON Prod.: MT064GASAO2U21 Rev: 0203
            Type: Hard Disk
            Capacity: 4.0 MB = 0.0 GB (1024 x 4096)
  Device 1: (0:1) Vendor: MICRON Prod.: MT064GASAO2U21 Rev: 0203
            Type: Hard Disk
            Capacity: 4.0 MB = 0.0 GB (1024 x 4096)
  Device 2: (0:2) Vendor: MICRON Prod.: MT064GASAO2U21 Rev: 0203
            Type: Hard Disk
            Capacity: 61016.0 MB = 59.5 GB (15620096 x 4096)

=> part list scsi 2

Partition Map for scsi device 2  --   Partition Type: EFI

Part    Start LBA       End LBA         Name
        Attributes
        Type GUID
        Partition GUID
  1     0x00000080      0x0000047f      "bootloaders"
        attrs:  0x0000000000000000
        type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
        guid:   1614eda4-a234-4789-a6e8-328dcb7c46e8
  2     0x00000480      0x0000087f      "bootloaders_b"
        attrs:  0x0000000000000000
        type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
        guid:   20435df4-5b1e-4361-8157-6ce997561c6a
  3     0x00000880      0x0000287f      "firmware"
        attrs:  0x0000000000000000
        type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
        guid:   24dad941-6425-492e-9d1c-118a52af67ba
  4     0x00002880      0x0000487f      "firmware_b"
        attrs:  0x0000000000000000
        type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
        guid:   547e79be-8019-45a9-8d28-b127607a5019
  5     0x00004880      0x000048ff      "dramk"
        attrs:  0x0000000000000000
        type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
        guid:   d267a4ba-68b3-415d-92d5-f977848c8c6e
  6     0x00004900      0x000049ff      "misc"
        attrs:  0x0000000000000000
        type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
        guid:   ce1e2472-6342-4220-9f8c-b9bfac4827cf
  7     0x00004a00      0x000069ff      "bootassets"
        attrs:  0x0000000000000000
        type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
        guid:   60581d1e-088a-4137-8be2-f3d2ee6cd187
  8     0x00006a00      0x0000cdff      "EFI_system_partition"
        attrs:  0x0000000000000000
        type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
        guid:   08ddd30a-cbce-49ae-b5c1-ded897018d2e
  9     0x0000ce00      0x0000edff      "kernel"
        attrs:  0x0000000000000000
        type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
        guid:   0334e60c-ce99-4652-a8f0-1088b4716b65
 10     0x0000ee00      0x00068587      "rootfs"
        attrs:  0x0000000000000004
        type:   b921b045-1df0-41c3-af44-4c6f280d3fae
        guid:   6244fcea-b124-44f5-94a4-c1c38946bd90

=> scsi dev 2

Device 2: (0:2) Vendor: MICRON Prod.: MT064GASAO2U21 Rev: 0203
            Type: Hard Disk
            Capacity: 61016.0 MB = 59.5 GB (15620096 x 4096)
... is now current device

=> load scsi 2:a ${scriptaddr} /boot/fitImage
21005248 bytes read in 47 ms (426.2 MiB/s)

=> source ${scriptaddr}

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Add dependency on [1] that rename the genio defconfig
- rename mt8395_evk_ufs_defconfig to the new name
  mt8395_genio_1200_evk_ufs_defconfig
- introduce mt8195.config to avoid duplicating mt8395_genio_1200_evk defconfig
- Added new reviewed-by by tag
- add missing clk_enable in ufs driver and fix error path
- remove pmic commits from this series. As suggested by David, this
  driver need some rework and deserve it's own series. UFS still
  works, since previous bootloader stage is already doing some
  initialization
- Link to v1: https://lore.kernel.org/r/20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com

[1]:  https://patchwork.ozlabs.org/project/uboot/patch/20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com/

---
Julien Stephan (9):
      drivers: phy: phy-mtk-ufs: cleanup headers
      drivers: phy: phy-mtk-ufs: use tab to indent defines
      drivers: phy: phy-mtk-ufs: use clk_bulk functions
      drivers: phy: phy-mtk-ufs: disable clk in power_off
      drivers: phy: phy-mtk-ufs: do not alloc priv with priv_auto
      drivers: ufs: ufs-mediatek: fix phy handling
      drivers: ufs: ufs-mediatek: implement clocking
      drivers: ufs: ufs-mediatek: add MT8195 compatible
      configs: add new defconfig for mt8395_genio_1200_evk_ufs

 board/mediatek/MAINTAINERS                  |   4 +-
 configs/mt8195.config                       |  24 ++++++
 configs/mt8395_genio_1200_evk_defconfig     |  26 +-----
 configs/mt8395_genio_1200_evk_ufs_defconfig |  13 +++
 drivers/phy/phy-mtk-ufs.c                   | 128 ++++++++++++----------------
 drivers/ufs/ufs-mediatek.c                  |  40 ++++++---
 drivers/ufs/ufs-mediatek.h                  |   2 +-
 7 files changed, 123 insertions(+), 114 deletions(-)
---
base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
change-id: 20260311-mt8195-add-ufs-support-535ebedbb323
prerequisite-message-id: <20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com>
prerequisite-patch-id: 76f64e540256592f97d1b274e6072dde36fee2f9

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

