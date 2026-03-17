Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578EEFD877D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B998435B;
	Tue, 17 Mar 2026 15:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DTPQPqpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6928435B; Tue, 17 Mar 2026 15:24:17 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA9384332
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso49670905e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757455; x=1774362255;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTJBWF7wDqtAefJqlDpSephy2XVmWIkEFcuMtgxG8Fo=;
 b=DTPQPqpV89b3gKHN7jD3aE4UV9Exz/x/kr1+vgpPtaeyoRalRc6M8E2ENbUHmqDZDF
 yOaVMcmIBGADwblRv5uJapTCeArkq5iGstevJ1kaw5BQUDPsm95A5nIIApkJMcLgWBW6
 TWi6tuG7kmfaDMQVAAMWVOt90k/jDPIt4w9C7xRytG7cwP6Z6JYZcye7LHnviEEWw0se
 t5CFPA6wgylJWmfKO2BdVsk6t/Yjx//0zKq9IV8OVr0hGHcWUiLikttUVrFQs+QGZkVE
 qMdsQo5YGF69Myg1DuyJ9mRw4HaOBPIiXxADwB3eNyt3rgJBzxjKEN5N7PBSb8AuGhub
 HvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757455; x=1774362255;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTJBWF7wDqtAefJqlDpSephy2XVmWIkEFcuMtgxG8Fo=;
 b=I1XxvTGv62s/JWfhBChmuIFytTO4PGVCiPn8GyAAzbmF77lTJnbArdm1n9PI7IvpiR
 xxxqBX7SClOppOBy0Tqvmu8NvQN2tFDV+IH2/8dTgRQQTw8mavzpL37vAsDtaALVGVQZ
 4rPNNygpAN5uIuBNATrJBD19t1tf1fS3knDjzAkfCe3dn/B0+BiUWgpHICA5MEzfIR8u
 eqZQaoha0/t6sU5H24onIt06HDFLqJl4JrYvAWPOyOrkBg1LUjs3d9JgxPkwZRfMaWzI
 ozueDC5sxdUtqzEevPyMXuWx+mVZGxXgPWxQwNFEL5zSPZNnIn9+CSYpSTYzHrP5f/AQ
 D0Yw==
X-Gm-Message-State: AOJu0Yx63c58omV02mSuZdWhnSHElC3T5t6bS4vBgfAiHrvdsij+ZNkx
 qPjfBsT3Hak/8e3VppcHcb1CEjhnbrNXLK2HVbAGFYWPvuv59e5wf+jNy0R6EVDM6YU=
X-Gm-Gg: ATEYQzxdWogjJKAQHWf7HYkP9M9kAWYPuIIec6iVMSbimlMEfTzSVFqCw4c38QiBw3C
 nYFiuXZCT67dTlO0rhCHH6717Gb16SV7/nhG2a/ydLU2SY1/O9Dg1y+gVA09lgYSdjTcDiVyyHN
 ARKGeegtPmmFAneULbrVBtiZoiuiDdeBncIxZXAWsK/NN9o5NbEWXqSYqwMPYSBkat75a1Fig03
 LdnglKy90rO7g1+Po9/lU0CwHCkIkHXBbuMPykbYWywqA86eMQurdooayHyaGwLTyMhGIhkZ3tc
 FiW6995aykybm1K/n+ADNVSHthc9QpUaRbFzvhSen9sjxB6Mo8Hi08gRtVytqd/gdwgwDWCNPKv
 3cPaSfNT61o+ytfXLOw1AJKnF1RiEKTdEVRxF+upTgPgW6kwReAJoS+CzecHHFHE7DahddAj3/j
 sZg5T4/wq+VouN+Vr0hin9S6ar84U+5DP11fXdxWQt6jcI+LqWx6pYCrjhhbfr66R1e9WGznUoA
 xxaPNEHLJmvtPUMQ8fErRvixy6TrOFF2eQpVUhDqCMzqZpz/2EP4dlvCiqFNnFaz+yYSQfkDEJl
 ovDp9QA=
X-Received: by 2002:a05:600c:4f54:b0:485:3b5b:eb8 with SMTP id
 5b1f17b1804b1-485567052b8mr291039845e9.26.1773757454978; 
 Tue, 17 Mar 2026 07:24:14 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 00/11] MT8195: add ufs support
Date: Tue, 17 Mar 2026 15:24:18 +0100
Message-Id: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MQQqDMBCF4avIrDtgEiK1VyldmGa0s1DTmaQUx
 Ls3VJffg/dvoCRMCrdmA6EPK69Lhbk08HwNy0TIsRpsa7vWGYNzvpre4xAjllFRS0qrZPTOU6A
 YgrMO6jkJjfz9h++Pw0LvUvv5HPf9B+8HvQV9AAAA
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
Julien Stephan (11):
      power: pmic: mtk-pwrap: add MT8195 support
      power: pmic: mtk-pwrap: use tabs for alignment
      drivers: phy: phy-mtk-ufs: cleanup headers
      drivers: phy: phy-mtk-ufs: use tab to indent defines
      drivers: phy: phy-mtk-ufs: use clk_bulk functions
      drivers: phy: phy-mtk-ufs: disable clk in power_off
      drivers: phy: phy-mtk-ufs: do not alloc priv with priv_auto
      drivers: ufs: ufs-mediatek: fix phy handling
      drivers: ufs: ufs-mediatek: implement clocking
      drivers: ufs: ufs-mediatek: add MT8195 compatible
      configs: add new defconfig for mt8395_evk_ufs

 board/mediatek/MAINTAINERS       |   3 +-
 configs/mt8395_evk_ufs_defconfig |  33 ++++++++++
 drivers/phy/phy-mtk-ufs.c        | 128 ++++++++++++++++-----------------------
 drivers/power/pmic/mtk-pwrap.c   |  59 +++++++++++++-----
 drivers/ufs/ufs-mediatek.c       |  38 ++++++++----
 drivers/ufs/ufs-mediatek.h       |   2 +-
 6 files changed, 160 insertions(+), 103 deletions(-)
---
base-commit: d31f96cac1e25153779c44f1fe014978f9b06032
change-id: 20260311-mt8195-add-ufs-support-535ebedbb323

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

