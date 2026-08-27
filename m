Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCB3C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 06:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E62A406A5;
	Thu, 27 Aug 2026 06:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qpLnpO_aB6CU; Thu, 27 Aug 2026 06:08:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787810926;
	bh=p1kh1Cmb2IVR79WJpLubr2WxVrsVvtG5s0v3ncyVzXw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Aj9K1yXq+p93uTT5WLmjvYfxISbDNLWsdZSQMhBJmrhn6QD3XwqIQSunTbVs6IBJQ
	 HFbiyi01+lWDkh73qNnEog65L4tItfGUm/sSnlfloqjhWSuLuzAa74p81YuH3VBH76
	 hlZhpYl3ftzdChrjTX7rWAlviWuH5ONxYeIkwStG1zvmV2K6gJN7/AJBw+QC6X4MlC
	 VVhikmrcAkYk47RqLJMmxvHaFD3EngmuLWf5YRu7RBSv78K6wFhiv6YoYnkQV1HbYK
	 aOpU/53Da12YmPbxMmB/MB4b5S/koy+ku+JzifA0rrj+u4OQulyAjoCQk2GgeazQ8A
	 E4HK6+AR6SzWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64D084069A;
	Thu, 27 Aug 2026 06:08:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33285334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 228F580C36
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:08:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lY00NDLOSOEM for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 06:08:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=NFLabMnE
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55ABB80C2D
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:08:41 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49b0dbfbf7bso4845895e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787810920; x=1788415720;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p1kh1Cmb2IVR79WJpLubr2WxVrsVvtG5s0v3ncyVzXw=;
 b=NFLabMnEO4mnHcJcZkBa4TCP9YPOOEH7UXPHGhIg+FAWRwzI7p480byU48B0b8fgn+
 ag9VFjHRLDz8idZSVCWqeJgYYpGFC25WLPFEOArp5voBznDq5QeHlqP6+3Xogrt0l7i+
 kFMUj/F7b8738IAEp/uhhRwvDLD7Qv2+dBYO7awLuSHPowchrXvbvkx0cAf6WBIj+9EL
 mI+obdPqTFabk4kxIvFxr2uhvOugvrA/wNhsPvGFrrsAR8j5qSGQj8v5Ut+s5LZFxSp/
 9kzT0nudKql+HwzbJJ8uSeBhrYab5bvlZJK/qDqKerbuZ4V+8ssaPRkOE+KRJxssX2bx
 01xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787810920; x=1788415720;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p1kh1Cmb2IVR79WJpLubr2WxVrsVvtG5s0v3ncyVzXw=;
 b=fyIjeChAsvG4PCap0NGMWerRn9MIRAqP/8ronbgBu9lALoehK6hVsPs7vkOq0AVdxF
 Rj/9e4SeK4WDrbOZoscApggPpdf+KtEpTKQV1t56uu0GPDwcrCpjZ+02u2TgPPuaGOsJ
 Te4zqXb/mcc5cycnCJyCnMKMT9wj+nk0BIBwmQbeQeSHhPC+9imSk3ErPaWWZoopXdb6
 nXZnFbrIculcvBRHOGG0U2qxoLN9VS0Ww+Ec+eTTNAKLhiF4zNa7Pwfh/qNW3aYhCu7m
 RUX4sYX4rTyv6pnHPBNEpxgBjTlGwiYnjoeO5bLUjBH4wA+OXViUSIp3khqjWX638890
 k5RQ==
X-Gm-Message-State: AFuF++lrmEgf2VJGjZM6Rpid7pWf5FzrqNK6XumSQvFRW6hdZZUzzxe4
 Mv7dSKPwQ0V3FUF1JRBl/ZCYh8ffKy4VnhiKZajJenR7M/76vpWRIs6jFokyTVaYH4U=
X-Gm-Gg: AR+sD1189mDGmr9h+fTcq/KpvUHdutkOffkMIDGKTWWLAAfO/Qg/ZCvJ08dYgKkRaga
 pvPBiUCfGgaYXwHFzYUiQYWm7lqCB/YnDNnP/nOsE+EInrCC2gEO1Ee5rOmfGQqjjwWZPVuOGme
 5pIrfLKAXTNuXB2/7fdozc2r+kUT8j5Uw03cpnC5NMt1b25l2LXj4kQtkmNZpLmq5o2+4l+g32p
 z+IKGHaeupNklQs6Ho+N1ccrVW8X4BhlMQJaS62mIS8zAQ3NgKTL3Q7T7finWLhWFVL+yV+tg+N
 jtw7XFBHYOSFHM4RHJvB4hfYnmgJHpyT4cV01NTRsfU4KikZ3V5oMFxwWJzM4Oh+z3bSmnhfXMq
 c9y4Ma1/3ec66nwjcRfElrNvYqmyvZBhDiZ1hnRhMmtyRZ3oM2O6sLjrvAa+pmkhb7fdV0A6xS/
 q0d/iFm6qtWIfhEdTfBwJpd7JwkOmb2X4vEe99QI74lBcldHDGmtkWbm6DVjihWslcv9eltLjBE
 +ASZORC/x3kYuqp+35BLOfZb10VGwjYqWhwbv7l/KYxzH4bL1LN
X-Received: by 2002:a05:600c:8518:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-499dc6e998cmr143896685e9.3.1787810919475; 
 Wed, 26 Aug 2026 23:08:39 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6119sm6643929f8f.34.2026.08.26.23.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 23:08:38 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 10:08:32 +0400
Subject: [PATCH] disk: part_mac: Remove the Apple Partition Map driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-drop-part-mac-v1-1-c81ede492be7@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMPQ6DMAxA4asgz7UUMpiWq6AO+THUlYDIgaoS4
 u4EGL/hvQ0yq3CGttpA+SdZ5qmgflQQPm4aGCUWgzWWzNMSRp0TJqcLji4gUewbMr6OrwZKk5R
 7+V+/7n07r/7LYTknsO8HcAuF+nEAAAA=
X-Change-ID: 20260826-drop-part-mac-66df760b1d97
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, TsiChung Liew <Tsi-Chung.Liew@nxp.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Kostya Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mario Six <mario.six@gdsys.cc>, 
 George McCollister <george.mccollister@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, Daniel Golle <daniel@makrotopia.org>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Johan Jonker <jbx6244@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=37847; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=+OH9WeJooXGBYRanejlEXgx2bR4veOlzf4qWSI6CX2U=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1X0nxaGs8dy3CgZ/prKW63SK9tf6V7W6/H750l3Iyv
 FUR/DGwYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKk2smdkuBLA1Vx+kV/M7OJVo/Vl1ZVvBNfZxX5cML9oh7D+JteUMwz/nU0T03M
 LBd1n6SizMkZX/p7CNX1mb0XI/wImB/OMNTFcAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The Apple Partition Map predates Advanced Format media by two decades.
Apple never extended the format to cover 4 Kn logical blocks, has since
withdrawn its documentation, and has shipped GPT on its own systems for
almost as long. There is therefore no specification left to follow for
the one property that matters here: where a partition map entry lives
when a block is not 512 bytes.

U-Boot's implementation reflects that. All three entry points read one
block into a buffer sized after a 512-byte struct, so they smash the
stack on any device with larger blocks, and part_test_mac() runs during
partition probing on every block device. Sizing those buffers correctly
is easy; deciding what the driver should then parse is not, and guessing
at a layout Apple never defined helps nobody.

Nothing in tree depends on the driver either: it has no test, no
documentation and no MAINTAINERS entry, and the sole reference to
PART_TYPE_MAC is its own partition driver registration.

Drop it. Anyone who needs Apple Partition Map support for emulated
hardware can bring it back along with a test.

Link: https://patch.msgid.link/cb50976b-917f-4843-8b0d-dc2a32e59d65@canonical.com
Link: https://patch.msgid.link/20260825194528.GB523975@bill-the-cat
Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
CI passes all green:
https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1094
---
 README                                             |   1 -
 configs/M5253DEMO_defconfig                        |   1 -
 configs/bayleybay_defconfig                        |   1 -
 configs/chromebook_coral_defconfig                 |   2 -
 configs/chromebook_link_defconfig                  |   1 -
 configs/chromebook_samus_defconfig                 |   1 -
 configs/chromebook_samus_tpl_defconfig             |   2 -
 configs/chromebox_panther_defconfig                |   1 -
 configs/clearfog_gt_8k_defconfig                   |   1 -
 ...conga-qeval20-qa3-e3845-internal-uart_defconfig |   1 -
 configs/conga-qeval20-qa3-e3845_defconfig          |   1 -
 configs/coreboot64-no-spl_defconfig                |   1 -
 configs/coreboot64_defconfig                       |   2 -
 configs/coreboot_defconfig                         |   1 -
 configs/cougarcanyon2_defconfig                    |   1 -
 configs/crownbay_defconfig                         |   1 -
 configs/dfi-bt700-q7x-151_defconfig                |   1 -
 configs/eDPU_defconfig                             |   1 -
 configs/efi-x86_app32_defconfig                    |   1 -
 configs/efi-x86_app64_defconfig                    |   1 -
 configs/efi-x86_payload32_defconfig                |   1 -
 configs/efi-x86_payload64_defconfig                |   1 -
 configs/galileo_defconfig                          |   1 -
 configs/minnowmax_defconfig                        |   1 -
 configs/mvebu_ac5_rd_defconfig                     |   1 -
 configs/mvebu_crb_cn9130_defconfig                 |   1 -
 configs/mvebu_db-88f3720_defconfig                 |   1 -
 configs/mvebu_db_armada8k_defconfig                |   1 -
 configs/mvebu_db_cn9130_defconfig                  |   1 -
 configs/mvebu_espressobin-88f3720_defconfig        |   1 -
 configs/mvebu_espressobin_ultra-88f3720_defconfig  |   1 -
 configs/mvebu_mcbin-88f8040_defconfig              |   1 -
 configs/mvebu_puzzle-m801-88f8040_defconfig        |   1 -
 configs/qemu-x86_defconfig                         |   1 -
 configs/renesas_rza1.config                        |   1 -
 configs/sandbox64_defconfig                        |   1 -
 configs/sandbox_defconfig                          |   1 -
 configs/sandbox_flattree_defconfig                 |   1 -
 configs/sandbox_noinst_defconfig                   |   1 -
 configs/sandbox_spl_defconfig                      |   1 -
 configs/sandbox_vpl_defconfig                      |   2 -
 configs/som-db5800-som-6867_defconfig              |   1 -
 configs/theadorable-x86-conga-qa3-e3845_defconfig  |   1 -
 configs/theadorable-x86-dfi-bt700_defconfig        |   1 -
 configs/turris_mox_defconfig                       |   1 -
 configs/uDPU_defconfig                             |   1 -
 configs/x250_defconfig                             |   1 -
 configs/x960_defconfig                             |   1 -
 disk/Kconfig                                       |  14 --
 disk/Makefile                                      |   1 -
 disk/part.c                                        |   3 +-
 disk/part_mac.c                                    | 237 ---------------------
 disk/part_mac.h                                    |  81 -------
 include/part.h                                     |   2 -
 54 files changed, 1 insertion(+), 389 deletions(-)

diff --git a/README b/README
index f740188a4bb4..7060bc5ac0cf 100644
--- a/README
+++ b/README
@@ -309,7 +309,6 @@ The following options need to be configured:
 
 - Partition Labels (disklabels) Supported:
 		Zero or more of the following:
-		CONFIG_MAC_PARTITION   Apple's MacOS partition table.
 		CONFIG_ISO_PARTITION   ISO partition table, used on CDROM etc.
 		CONFIG_EFI_PARTITION   GPT partition table, common when EFI is the
 				       bootloader.  Note 2TB partition limit; see
diff --git a/configs/M5253DEMO_defconfig b/configs/M5253DEMO_defconfig
index e3b1f114e1b4..406cf2ed4935 100644
--- a/configs/M5253DEMO_defconfig
+++ b/configs/M5253DEMO_defconfig
@@ -23,7 +23,6 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/bayleybay_defconfig b/configs/bayleybay_defconfig
index 29b92c554977..bda46854bc2a 100644
--- a/configs/bayleybay_defconfig
+++ b/configs/bayleybay_defconfig
@@ -44,7 +44,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index e8ea3bb7dd10..c2c9f276e75c 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -71,8 +71,6 @@ CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
-# CONFIG_SPL_MAC_PARTITION is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent interrupts linux-name acpi,name acpi,path u-boot,acpi-dsdt-order u-boot,acpi-ssdt-order"
diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index b853051ae5e1..133c18e33aa9 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -50,7 +50,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_samus_defconfig b/configs/chromebook_samus_defconfig
index ab7b8c95f8e8..c1776439c2b4 100644
--- a/configs/chromebook_samus_defconfig
+++ b/configs/chromebook_samus_defconfig
@@ -49,7 +49,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index fd515ddf676e..3475d494a5c4 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -65,8 +65,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
-# CONFIG_SPL_MAC_PARTITION is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_ISO_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
diff --git a/configs/chromebox_panther_defconfig b/configs/chromebox_panther_defconfig
index affba7f72a8a..fae4155ca405 100644
--- a/configs/chromebox_panther_defconfig
+++ b/configs/chromebox_panther_defconfig
@@ -41,7 +41,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/clearfog_gt_8k_defconfig b/configs/clearfog_gt_8k_defconfig
index a945d59d498e..ff1c6ed76aa3 100644
--- a/configs/clearfog_gt_8k_defconfig
+++ b/configs/clearfog_gt_8k_defconfig
@@ -38,7 +38,6 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig b/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
index 2dd8b1b57e48..b7ad1e6e4de8 100644
--- a/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
+++ b/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
@@ -51,7 +51,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/conga-qeval20-qa3-e3845_defconfig b/configs/conga-qeval20-qa3-e3845_defconfig
index 07b66b31a04e..8d72d32fb30d 100644
--- a/configs/conga-qeval20-qa3-e3845_defconfig
+++ b/configs/conga-qeval20-qa3-e3845_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/coreboot64-no-spl_defconfig b/configs/coreboot64-no-spl_defconfig
index 11c72d9049d9..989d18887cb6 100644
--- a/configs/coreboot64-no-spl_defconfig
+++ b/configs/coreboot64-no-spl_defconfig
@@ -30,7 +30,6 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_SOUND=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index abd874d68df8..f5c105fcffcc 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -34,8 +34,6 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_SOUND=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
-# CONFIG_SPL_MAC_PARTITION is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 3fa7b517af41..4a644a2aac22 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -34,7 +34,6 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_SOUND=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/cougarcanyon2_defconfig b/configs/cougarcanyon2_defconfig
index 57c8ff78d0c7..64426267bc0c 100644
--- a/configs/cougarcanyon2_defconfig
+++ b/configs/cougarcanyon2_defconfig
@@ -37,7 +37,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/crownbay_defconfig b/configs/crownbay_defconfig
index 1457212ab678..2153382b383c 100644
--- a/configs/crownbay_defconfig
+++ b/configs/crownbay_defconfig
@@ -40,7 +40,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/dfi-bt700-q7x-151_defconfig b/configs/dfi-bt700-q7x-151_defconfig
index 24e62e5f0ce2..ea2aac524caf 100644
--- a/configs/dfi-bt700-q7x-151_defconfig
+++ b/configs/dfi-bt700-q7x-151_defconfig
@@ -45,7 +45,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/eDPU_defconfig b/configs/eDPU_defconfig
index e227dba5a421..a97c5005e501 100644
--- a/configs/eDPU_defconfig
+++ b/configs/eDPU_defconfig
@@ -40,7 +40,6 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 9a1db537a8be..71065e16201f 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -28,7 +28,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_EMBED=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 8b2be2d49979..273304bd8740 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -32,7 +32,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_EMBED=y
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 19d966820ad7..b036077fd4dc 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -33,7 +33,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 5621d14bcc1c..3aff0d54088d 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_INTERFACE="scsi"
diff --git a/configs/galileo_defconfig b/configs/galileo_defconfig
index ec416d46e066..541e7e49dc7c 100644
--- a/configs/galileo_defconfig
+++ b/configs/galileo_defconfig
@@ -36,7 +36,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/minnowmax_defconfig b/configs/minnowmax_defconfig
index 000eebce3a86..e5b885d52522 100644
--- a/configs/minnowmax_defconfig
+++ b/configs/minnowmax_defconfig
@@ -50,7 +50,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/mvebu_ac5_rd_defconfig b/configs/mvebu_ac5_rd_defconfig
index d8d67ec3c95e..63adbd333c86 100644
--- a/configs/mvebu_ac5_rd_defconfig
+++ b/configs/mvebu_ac5_rd_defconfig
@@ -36,7 +36,6 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_UBI=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_GATEWAYIP=y
diff --git a/configs/mvebu_crb_cn9130_defconfig b/configs/mvebu_crb_cn9130_defconfig
index 409e51e7be07..9573f4640be7 100644
--- a/configs/mvebu_crb_cn9130_defconfig
+++ b/configs/mvebu_crb_cn9130_defconfig
@@ -38,7 +38,6 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_MVEBU_MMC_BOOT=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/mvebu_db-88f3720_defconfig b/configs/mvebu_db-88f3720_defconfig
index ff0f412b6d09..2fe3ad518ec8 100644
--- a/configs/mvebu_db-88f3720_defconfig
+++ b/configs/mvebu_db-88f3720_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/mvebu_db_armada8k_defconfig b/configs/mvebu_db_armada8k_defconfig
index 7f99aea5810b..140f8592b5ef 100644
--- a/configs/mvebu_db_armada8k_defconfig
+++ b/configs/mvebu_db_armada8k_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/mvebu_db_cn9130_defconfig b/configs/mvebu_db_cn9130_defconfig
index 34acaa499ef9..a41cbe5dbee2 100644
--- a/configs/mvebu_db_cn9130_defconfig
+++ b/configs/mvebu_db_cn9130_defconfig
@@ -39,7 +39,6 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index 9f5eda244ac6..bedf7d08a251 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -43,7 +43,6 @@ CONFIG_CMD_BTRFS=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_FS_UUID=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
index 16e0e54f657d..f4e31dd98b8b 100644
--- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
+++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
@@ -42,7 +42,6 @@ CONFIG_CMD_BTRFS=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_FS_UUID=y
-CONFIG_MAC_PARTITION=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
diff --git a/configs/mvebu_mcbin-88f8040_defconfig b/configs/mvebu_mcbin-88f8040_defconfig
index e91f9606211c..eb428680cd7b 100644
--- a/configs/mvebu_mcbin-88f8040_defconfig
+++ b/configs/mvebu_mcbin-88f8040_defconfig
@@ -38,7 +38,6 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/mvebu_puzzle-m801-88f8040_defconfig b/configs/mvebu_puzzle-m801-88f8040_defconfig
index 673f84d2da85..77ccc87d8db2 100644
--- a/configs/mvebu_puzzle-m801-88f8040_defconfig
+++ b/configs/mvebu_puzzle-m801-88f8040_defconfig
@@ -43,7 +43,6 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index dd0056ed4d01..4dd6a78e38e1 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -39,7 +39,6 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_INTERFACE="virtio"
diff --git a/configs/renesas_rza1.config b/configs/renesas_rza1.config
index 10d817f03a77..0a6806e08133 100644
--- a/configs/renesas_rza1.config
+++ b/configs/renesas_rza1.config
@@ -29,7 +29,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_HUSH_PARSER=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MAC_PARTITION=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_OF_CONTROL=y
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 2e37374d6465..144f5baf577b 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -102,7 +102,6 @@ CONFIG_CMD_CRAMFS=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_SPAWN=y
-CONFIG_MAC_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 5c97418783fc..c6edd9d24237 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -153,7 +153,6 @@ CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_STACKPROTECTOR_TEST=y
 CONFIG_CMD_SPAWN=y
-CONFIG_MAC_PARTITION=y
 CONFIG_OF_LIVE=y
 CONFIG_DEVICE_TREE_INCLUDES="sandbox_scripts.dtsi"
 CONFIG_ENV_IS_NOWHERE=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 4ad2bb016738..c12ffc8669de 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -76,7 +76,6 @@ CONFIG_CMD_AES=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_TPM_TEST=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 076be6586cf5..5c5d96984e6c 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -112,7 +112,6 @@ CONFIG_CMD_TPM_TEST=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 3b6d18d7d76e..e403d8a89c4b 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -90,7 +90,6 @@ CONFIG_CMD_TPM_TEST=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 363d73cf0307..c7df8571663d 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -103,8 +103,6 @@ CONFIG_CMD_TPM_TEST=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
-# CONFIG_SPL_MAC_PARTITION is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
diff --git a/configs/som-db5800-som-6867_defconfig b/configs/som-db5800-som-6867_defconfig
index 4d9f6348f360..ced096556d5f 100644
--- a/configs/som-db5800-som-6867_defconfig
+++ b/configs/som-db5800-som-6867_defconfig
@@ -45,7 +45,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/theadorable-x86-conga-qa3-e3845_defconfig b/configs/theadorable-x86-conga-qa3-e3845_defconfig
index 1f386cfb23ec..ed3b1939af1c 100644
--- a/configs/theadorable-x86-conga-qa3-e3845_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845_defconfig
@@ -45,7 +45,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/theadorable-x86-dfi-bt700_defconfig b/configs/theadorable-x86-dfi-bt700_defconfig
index 87db7812328c..8bb4d79ec0f4 100644
--- a/configs/theadorable-x86-dfi-bt700_defconfig
+++ b/configs/theadorable-x86-dfi-bt700_defconfig
@@ -43,7 +43,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
index 9a00716e4a01..2ef4b07a45da 100644
--- a/configs/turris_mox_defconfig
+++ b/configs/turris_mox_defconfig
@@ -48,7 +48,6 @@ CONFIG_CMD_AES=y
 CONFIG_CMD_HASH=y
 CONFIG_CMD_BTRFS=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_OF_LIST="armada-3720-turris-mox armada-3720-ripe-atlas"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/uDPU_defconfig b/configs/uDPU_defconfig
index 7c83ff17b9c0..e3cabab62e12 100644
--- a/configs/uDPU_defconfig
+++ b/configs/uDPU_defconfig
@@ -39,7 +39,6 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/x250_defconfig b/configs/x250_defconfig
index 2a56edf62ff3..1b5384bfb911 100644
--- a/configs/x250_defconfig
+++ b/configs/x250_defconfig
@@ -41,7 +41,6 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_UBI=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/x960_defconfig b/configs/x960_defconfig
index f03bca376aee..a21fa2483bec 100644
--- a/configs/x960_defconfig
+++ b/configs/x960_defconfig
@@ -41,7 +41,6 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_UBI=y
-CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/disk/Kconfig b/disk/Kconfig
index 672ad46a48f2..35b6c68be379 100644
--- a/disk/Kconfig
+++ b/disk/Kconfig
@@ -6,7 +6,6 @@ config PARTITIONS
 	help
 	  Partition Labels (disklabels) Supported:
 	  Zero or more of the following:
-	  - CONFIG_MAC_PARTITION   Apple's MacOS partition table.
 	  - CONFIG_DOS_PARTITION   MS Dos partition table, traditional on the
 	  Intel architecture, USB sticks, etc.
 	  - CONFIG_ISO_PARTITION   ISO partition table, used on CDROM etc.
@@ -36,19 +35,6 @@ config TPL_PARTITIONS
 	  partition table types shold be enabled separately. This adds a
 	  small amount of size to TPL, typically 500 bytes.
 
-config MAC_PARTITION
-	bool "Enable Apple's MacOS partition table"
-	select PARTITIONS
-	help
-	  Say Y here if you would like to use device under U-Boot which
-	  were partitioned on a Macintosh.
-
-config SPL_MAC_PARTITION
-	bool "Enable Apple's MacOS partition table for SPL"
-	depends on SPL
-	default y if MAC_PARTITION
-	select SPL_PARTITIONS
-
 config TEGRA_PARTITION
 	bool "Enable Nvidia Tegra partition table"
 	select PARTITIONS
diff --git a/disk/Makefile b/disk/Makefile
index 2248a659f8be..09bc4a7d6d75 100644
--- a/disk/Makefile
+++ b/disk/Makefile
@@ -12,7 +12,6 @@ endif
 
 # Must have BLK or SPL_LEGACY_BLOCK to support partitions
 ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
-obj-$(CONFIG_$(PHASE_)MAC_PARTITION)   += part_mac.o
 obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   += part_dos.o
 obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   += part_iso.o
 obj-$(CONFIG_$(PHASE_)AMIGA_PARTITION) += part_amiga.o
diff --git a/disk/part.c b/disk/part.c
index 4923dc44593c..b77ad848fd32 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -312,8 +312,7 @@ void part_init(struct blk_desc *desc)
 
 static void print_part_header(const char *type, struct blk_desc *desc)
 {
-#if CONFIG_IS_ENABLED(MAC_PARTITION) || \
-	CONFIG_IS_ENABLED(DOS_PARTITION) || \
+#if CONFIG_IS_ENABLED(DOS_PARTITION) || \
 	CONFIG_IS_ENABLED(ISO_PARTITION) || \
 	CONFIG_IS_ENABLED(AMIGA_PARTITION) || \
 	CONFIG_IS_ENABLED(EFI_PARTITION) || \
diff --git a/disk/part_mac.c b/disk/part_mac.c
deleted file mode 100644
index dd3ce0be832b..000000000000
--- a/disk/part_mac.c
+++ /dev/null
@@ -1,237 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2000
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- */
-
-/*
- * Support for harddisk partitions.
- *
- * To be compatible with LinuxPPC and Apple we use the standard Apple
- * SCSI disk partitioning scheme. For more information see:
- * http://developer.apple.com/techpubs/mac/Devices/Devices-126.html#MARKER-14-92
- */
-
-#include <command.h>
-#include <log.h>
-#include <memalign.h>
-#include "part_mac.h"
-#include <part.h>
-
-/* stdlib.h causes some compatibility problems; should fixe these! -- wd */
-#ifndef __ldiv_t_defined
-typedef struct {
-	long int quot;		/* Quotient	*/
-	long int rem;		/* Remainder	*/
-} ldiv_t;
-extern ldiv_t ldiv (long int __numer, long int __denom);
-# define __ldiv_t_defined	1
-#endif
-
-static int part_mac_read_ddb(struct blk_desc *desc, mac_driver_desc_t *ddb_p);
-static int part_mac_read_pdb(struct blk_desc *desc, int part,
-			     mac_partition_t *pdb_p);
-
-/*
- * Test for a valid MAC partition
- */
-static int part_test_mac(struct blk_desc *desc)
-{
-	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
-	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
-	ulong i, n;
-
-	if (part_mac_read_ddb(desc, ddesc)) {
-		/*
-		 * error reading Driver Descriptor Block,
-		 * or no valid Signature
-		 */
-		return (-1);
-	}
-
-	n = 1;	/* assuming at least one partition */
-	for (i=1; i<=n; ++i) {
-		if ((blk_dread(desc, i, 1, (ulong *)mpart) != 1) ||
-		    mpart->signature != MAC_PARTITION_MAGIC) {
-			return (-1);
-		}
-		/* update partition count */
-		n = mpart->map_count;
-	}
-	return (0);
-}
-
-static void part_print_mac(struct blk_desc *desc)
-{
-	ulong i, n;
-	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
-	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
-	ldiv_t mb, gb;
-
-	if (part_mac_read_ddb(desc, ddesc)) {
-		/*
-		 * error reading Driver Descriptor Block,
-		 * or no valid Signature
-		 */
-		return;
-	}
-
-	n  = ddesc->blk_count;
-
-	mb = ldiv(n, ((1024 * 1024) / ddesc->blk_size)); /* MB */
-	/* round to 1 digit */
-	mb.rem *= 10 * ddesc->blk_size;
-	mb.rem += 512 * 1024;
-	mb.rem /= 1024 * 1024;
-
-	gb = ldiv(10 * mb.quot + mb.rem, 10240);
-	gb.rem += 512;
-	gb.rem /= 1024;
-
-	printf ("Block Size=%d, Number of Blocks=%d, "
-		"Total Capacity: %ld.%ld MB = %ld.%ld GB\n"
-		"DeviceType=0x%x, DeviceId=0x%x\n\n"
-		"   #:                 type name"
-		"                   length   base       (size)\n",
-		ddesc->blk_size,
-		ddesc->blk_count,
-		mb.quot, mb.rem, gb.quot, gb.rem,
-		ddesc->dev_type, ddesc->dev_id
-		);
-
-	n = 1;	/* assuming at least one partition */
-	for (i=1; i<=n; ++i) {
-		ulong bytes;
-		char c;
-
-		printf ("%4ld: ", i);
-		if (blk_dread(desc, i, 1, (ulong *)mpart) != 1) {
-			printf ("** Can't read Partition Map on %d:%ld **\n",
-				desc->devnum, i);
-			return;
-		}
-
-		if (mpart->signature != MAC_PARTITION_MAGIC) {
-			printf("** Bad Signature on %d:%ld - expected 0x%04x, got 0x%04x\n",
-			       desc->devnum, i, MAC_PARTITION_MAGIC,
-			       mpart->signature);
-			return;
-		}
-
-		/* update partition count */
-		n = mpart->map_count;
-
-		c      = 'k';
-		bytes  = mpart->block_count;
-		bytes /= (1024 / ddesc->blk_size);  /* kB; assumes blk_size == 512 */
-		if (bytes >= 1024) {
-			bytes >>= 10;
-			c = 'M';
-		}
-		if (bytes >= 1024) {
-			bytes >>= 10;
-			c = 'G';
-		}
-
-		printf ("%20.32s %-18.32s %10u @ %-10u (%3ld%c)\n",
-			mpart->type,
-			mpart->name,
-			mpart->block_count,
-			mpart->start_block,
-			bytes, c
-			);
-	}
-
-	return;
-}
-
-/*
- * Read Device Descriptor Block
- */
-static int part_mac_read_ddb(struct blk_desc *desc, mac_driver_desc_t *ddb_p)
-{
-	if (blk_dread(desc, 0, 1, (ulong *)ddb_p) != 1) {
-		debug("** Can't read Driver Descriptor Block **\n");
-		return (-1);
-	}
-
-	if (ddb_p->signature != MAC_DRIVER_MAGIC) {
-		return (-1);
-	}
-	return (0);
-}
-
-/*
- * Read Partition Descriptor Block
- */
-static int part_mac_read_pdb(struct blk_desc *desc, int part,
-			     mac_partition_t *pdb_p)
-{
-	int n = 1;
-
-	for (;;) {
-		/*
-		 * We must always read the descritpor block for
-		 * partition 1 first since this is the only way to
-		 * know how many partitions we have.
-		 */
-		if (blk_dread(desc, n, 1, (ulong *)pdb_p) != 1) {
-			printf("** Can't read Partition Map on %d:%d **\n",
-			       desc->devnum, n);
-			return (-1);
-		}
-
-		if (pdb_p->signature != MAC_PARTITION_MAGIC) {
-			printf("** Bad Signature on %d:%d: expected 0x%04x, got 0x%04x\n",
-			       desc->devnum, n, MAC_PARTITION_MAGIC,
-			       pdb_p->signature);
-			return (-1);
-		}
-
-		if (n == part)
-			return (0);
-
-		if ((part < 1) || (part > pdb_p->map_count)) {
-			printf("** Invalid partition %d:%d [%d:1...%d:%d only]\n",
-			       desc->devnum, part, desc->devnum, desc->devnum,
-			       pdb_p->map_count);
-			return (-1);
-		}
-
-		/* update partition count */
-		n = part;
-	}
-
-	/* NOTREACHED */
-}
-
-static int part_get_info_mac(struct blk_desc *desc, int part,
-			     struct disk_partition *info)
-{
-	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
-	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
-
-	if (part_mac_read_ddb(desc, ddesc))
-		return -1;
-
-	info->blksz = ddesc->blk_size;
-
-	if (part_mac_read_pdb(desc, part, mpart))
-		return -1;
-
-	info->start = mpart->start_block;
-	info->size  = mpart->block_count;
-	memcpy (info->type, mpart->type, sizeof(info->type));
-	memcpy (info->name, mpart->name, sizeof(info->name));
-
-	return (0);
-}
-
-U_BOOT_PART_TYPE(mac) = {
-	.name		= "MAC",
-	.part_type	= PART_TYPE_MAC,
-	.max_entries	= MAC_ENTRY_NUMBERS,
-	.get_info	= part_get_info_mac,
-	.print		= part_print_mac,
-	.test		= part_test_mac,
-};
diff --git a/disk/part_mac.h b/disk/part_mac.h
deleted file mode 100644
index b2ee086bb6fe..000000000000
--- a/disk/part_mac.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2000
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- */
-
-/*
- * See also Linux sources, fs/partitions/mac.h
- *
- * This file describes structures and values related to the standard
- * Apple SCSI disk partitioning scheme. For more information see:
- * http://developer.apple.com/techpubs/mac/Devices/Devices-126.html#MARKER-14-92
- */
-
-#ifndef	_DISK_PART_MAC_H
-#define	_DISK_PART_MAC_H
-
-#define MAC_DRIVER_MAGIC	0x4552
-
-/*
- * Driver Descriptor Structure, in block 0.
- * This block is (and shall remain) 512 bytes long.
- * Note that there is an alignment problem for the driver descriptor map!
- */
-typedef struct mac_driver_desc {
-	__u16	signature;	/* expected to be MAC_DRIVER_MAGIC	*/
-	__u16	blk_size;	/* block size of device			*/
-	__u32	blk_count;	/* number of blocks on device		*/
-	__u16	dev_type;	/* device type				*/
-	__u16	dev_id;		/* device id				*/
-	__u32	data;		/* reserved				*/
-	__u16	drvr_cnt;	/* number of driver descriptor entries	*/
-	__u16	drvr_map[247];	/* driver descriptor map		*/
-} mac_driver_desc_t;
-
-/*
- * Device Driver Entry
- * (Cannot be included in mac_driver_desc because of alignment problems)
- */
-typedef struct mac_driver_entry {
-	__u32	block;		/* block number of starting block	*/
-	__u16	size;		/* size of driver, in 512 byte blocks	*/
-	__u16	type;		/* OS Type				*/
-} mac_driver_entry_t;
-
-#define MAC_PARTITION_MAGIC	0x504d
-
-/* type field value for A/UX or other Unix partitions */
-#define APPLE_AUX_TYPE	"Apple_UNIX_SVR2"
-
-/*
- * Each Partition Map entry (in blocks 1 ... N) has this format:
- */
-typedef struct mac_partition {
-	__u16	signature;	/* expected to be MAC_PARTITION_MAGIC	*/
-	__u16	sig_pad;	/* reserved				*/
-	__u32	map_count;	/* # blocks in partition map		*/
-	__u32	start_block;	/* abs. starting block # of partition	*/
-	__u32	block_count;	/* number of blocks in partition	*/
-	uchar	name[32];	/* partition name			*/
-	uchar	type[32];	/* string type description		*/
-	__u32	data_start;	/* rel block # of first data block	*/
-	__u32	data_count;	/* number of data blocks		*/
-	__u32	status;		/* partition status bits		*/
-	__u32	boot_start;	/* first block of boot code		*/
-	__u32	boot_size;	/* size of boot code, in bytes		*/
-	__u32	boot_load;	/* boot code load address		*/
-	__u32	boot_load2;	/* reserved				*/
-	__u32	boot_entry;	/* boot code entry point		*/
-	__u32	boot_entry2;	/* reserved				*/
-	__u32	boot_cksum;	/* boot code checksum			*/
-	uchar	processor[16];	/* Type of Processor			*/
-	__u16	part_pad[188];	/* reserved				*/
-#if CONFIG_IS_ENABLED(ISO_PARTITION)
-	uchar   iso_dummy[2048];/* Reservere enough room for an ISO partition block to fit */
-#endif
-} mac_partition_t;
-
-#define MAC_STATUS_BOOTABLE	8	/* partition is bootable */
-
-#endif	/* _DISK_PART_MAC_H */
diff --git a/include/part.h b/include/part.h
index 15daacd7faaa..c62b0efe57a4 100644
--- a/include/part.h
+++ b/include/part.h
@@ -23,7 +23,6 @@ struct block_drvr {
 
 /* Part types */
 #define PART_TYPE_UNKNOWN	0x00
-#define PART_TYPE_MAC		0x01
 #define PART_TYPE_DOS		0x02
 #define PART_TYPE_ISO		0x03
 #define PART_TYPE_AMIGA		0x04
@@ -34,7 +33,6 @@ struct block_drvr {
 /* maximum number of partition entries supported by search */
 #define DOS_ENTRY_NUMBERS	8
 #define ISO_ENTRY_NUMBERS	64
-#define MAC_ENTRY_NUMBERS	64
 #define AMIGA_ENTRY_NUMBERS	8
 #define MTD_ENTRY_NUMBERS	64
 #define UBI_ENTRY_NUMBERS	UBI_MAX_VOLUMES

---
base-commit: f252d228be2b2d180737ad0a851f91749273cbd9
change-id: 20260826-drop-part-mac-66df760b1d97

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

