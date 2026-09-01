Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD02C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE47E60746;
	Tue,  1 Sep 2026 14:38:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAARIDUy2K1M; Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273533;
	bh=jKfJKPeG3DsZKTNVGuXFkwsT6gRaWKHVqqM4uYu6s3c=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IO2Snx2TDQDhMAaYPVvgHkth/SVFPBwqRtJ157MnV1LNBSy3HUaTRUW3ExQJUAVQ7
	 at++H64LQQBM1a4bEO8ontvcEg4ycwSx+9Rk0IdRoBnkZL4UsKcFdYby0CS8Dcolpm
	 p152gFXbZFSXNiCGApllU2qesVDrgpzbbl2YdotpIv9bLwIQ33kCxLWqlEE6nAfdpy
	 M6UiS+1tnz8PXRpi28Z28f3pW/YHZhVsQpPLZKiNtV2+C6OsQCXhorclER9ZzPrR0m
	 jgO0U2p3hAxReGuf+ramdiEwpxmudsEoQYNfX+SapRBt086wYM5BFklH2jaIOwd12l
	 kTVMLCy6tzLoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90127606F2;
	Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E0A4C363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6592406D4
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tPjW7ij-mFwD for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HmOq9gV+
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12945406C3
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:48 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso10691995e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273526; x=1788878326;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jKfJKPeG3DsZKTNVGuXFkwsT6gRaWKHVqqM4uYu6s3c=;
 b=HmOq9gV+C8uGhMv632zdNUr02nbECLJty3xeaG8/Jsk2AYoG+AzqX5vudDyRf5Jera
 UR1568RzbXb8jsDfKzTG+vGRenJbMXsm8GHr4Annx+sRCq3R8UYA2cCSzkNqJ70j3J5K
 4z0B18FtrRSKZ5J36E2+XKEPvyMjDXtp/OxkyANi4CeR36sCNKW7A8gu5JnUyR1C/L8d
 IJkqAihQ0nI/lXGaKkfdwtZKuGyfUowa7QiOznarb7bJpSrno5Bz734eYIbUv90npSUn
 56ZQ6mcvg0s6f3urtcfpyFyxsx/LOxE7jLPMrK2Rz3Lbrl38pko2gCKN3KA7YK/sLM4n
 oUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273526; x=1788878326;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jKfJKPeG3DsZKTNVGuXFkwsT6gRaWKHVqqM4uYu6s3c=;
 b=BTbe3qQvMRAoGfnfJPYPdH9zNAIos8veCai3XMqbS8rzddY5uiVngx/UrD7ksYlUb/
 lmWPCUnjqFyEJ6JhkcdKzQN6OHzVRc3oboPqL3PYRy3NPCQ8WWc6/j3osa9hbBwOMGNh
 KOg/q0noomXYpVNIYR0GxkuRLES0B4Kf1WR6RA2BPW/KKssUwmZyNi5WlvgMM0xXLs2E
 MPeHJmMfVpR5LwmlBpmgBtIVb0C5OZdNqF5BnyUMHfpGUk2Z3luP6sLIqAHnIKBZoZmR
 EHHLXgvyMl742e7SUctI0mRKV7xRk7iYo/qk8wcK8AvYxbrQ6uEBy2VDW3g/Owkgoirc
 zVYQ==
X-Gm-Message-State: AFuF++khsldJURiHCU6IAfwYpyIR+r3sxD3CyfhDAbNdFdb/JY62f2jj
 JpVKPjLcuIentlJ9ZqbuH3LTnu24JWa6Q5vReK4mqz1DMZ5A7csvPjPh3M9mX4PVi6Y=
X-Gm-Gg: AR+sD13q74WbVsXaoCDcsL4Yjq02Zw1ZNKyNqYj8alMsfWgHyKIpMw/CSD3LrdYM6g/
 PfiQQAJdTnZNAgqxr1uOd/p86lpQ1i2x4MP2TkC2oVOoRVboDDs/JL2xZM7yZj/WMsWHNe8EwSm
 Z+iiPk9CbEkBfgYGEktSbSNtsFz+LFD6PmsfjWHRumCyaCbe0avDlfeg/tZzrD5iMi06KPM0bRt
 huGSiaCVCf0NEe8yk9hEMilJfNus5h5D3zSz8cM6jJQrstFZUQn+oCuyWMrb2wSMmPKVLjoCwP3
 biH14+2yqJgkSeyz9KF/YhDUYSDNA8y5dPHrNz6gbxFd5SvekrTbGgacnW4/75Oqxhj/xlDnj5M
 tke/Pdlp85/PgplsNURsDwymnXUqdMvCB4rfsAqjTOKcdNIHmW8pGd0VBl8/u1Lw4tGMAMbmv4F
 VM70n2xaJfdnqEfv6f6qApN0NrhCXm7ztA2mORKF7ezyXeQcvd6ChB1x1Jr7DM96KVAMalFVFMh
 JfmcA2/f5gfMTIypmqP1SZUx04zcApa54jmQF8iqw09p7AefyV9goAvHiQkGA5RmnapPTiTDcHo
 EfpWZ1LtXxfP3CDt03M6h9Sk6HF/8VAca9nAxfFrf0KsXDi4bu0ZkMA=
X-Received: by 2002:a05:600c:c08b:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49b92027118mr477940435e9.6.1788273526097; 
 Tue, 01 Sep 2026 07:38:46 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v3 00/14] mediatek: add HDMI pipeline support for MT8188
 based boards
Date: Tue, 01 Sep 2026 16:38:46 +0200
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ6CMBAGX4X0bE1bpVRPvofx0J8trBEwLRIJ4
 d0tqDHxosfZfJnZkUQICJHss5EE6DFi2yTYrDJiK92UQNElJoIJyQrGqXaOltBgS3POqG7eVDB
 GK1cjtVoKK40SnFmSNNcAHu9L4nh6cryZM9hu9s6LCmPXhmH5oefz7pUT6neu5zTdbb41rsj9T
 rKD0cMFTYC1bWsyF3vxcSoh/3CK5JQKjOHG88L5L+c0TQ9szvG7OQEAAA==
X-Change-ID: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
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

This series adds HDMI support for MT8188 based boards, such as the Genio
510 and Genio 700 EVKs, in order to display a boot logo over HDMI. It
builds on top of the HDMI PHY driver [1], the DDC (I2C) driver [2], the
clock series [3] and a clock fix [4] already sent earlier.

The drivers here, were inspired by the corresponding kernel driver, but
were largely modified, mainly because U-Boot has no DRM framework and
the goal is only to display a framebuffer. The HDMI driver locates each
pipeline component through phandles in the hdmi node and programs them
directly. The framebuffer and splash screen live in dedicated
reserved-memory regions.

The video pipeline looks like this:

        reserved-memory (framebuffer, in DRAM)
                       |
          +------------+------------+
          v                         v
      mdp_rdma4                 mdp_rdma5      two DMA read engines,
     (left half)               (right half)   each fetching one frame half
          |                         |
       padding4                  padding5      (bypass)
          |                         |
          +------------+------------+
                       v
                  vpp merge (merge3)           recombine the two halves
                       |
                       v
                 ethdr mixer (ethdr0)
                       |
                       v
                  hdr back-end
                       |
                       v
                  vpp merge (merge5)
                       |
                       v
                     dpi1                       timing generator -> HDMI TX
                       |
                       v
      ddc/i2c ---> hdmi tx controller
    (read EDID)        |
                       v
                   hdmi phy
                       |
                       v
              hdmi connector ---> sink

  mutex1  : hardware SOF synchronization across the pipeline
  vdosys1 : routing muxes (SEL_IN/SOUT) wiring the blocks above

The series adds the HDMI TX controller (UCLASS_VIDEO), a set of shared
display-component helpers and the individual pipeline components (mixer,
merge, mutex, padding, rdma, vdosys1, dpi1), and the device-tree glue
and config that enable the pipeline.

Tested on  Genio 700 EVK: the U-Boot splash logo shows up on an HDMI display.

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com/
[2]: https://patchwork.ozlabs.org/project/uboot/cover/20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com/
[3]: https://patchwork.ozlabs.org/project/uboot/patch/20260715-mt8188-add-clk-add-display-related-clocks-v2-1-0aaf7accaeb0@baylibre.com/
[4]: https://patchwork.ozlabs.org/project/uboot/patch/20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v3:
Across the whole series
- Re-based every register definition on the mainline Linux kernel definitions (upstream names, values and
BIT()/GENMASK()/FIELD_PREP()) instead of the downstream U-Boot ones.
- SPDX fixes: GPL-2.0 / GPL-2.0+ -> GPL-2.0-only on all new driver files, Makefile and Kconfig; relicensed
include/linux/hdmi.h to MIT (it's a partial port of Linux' MIT-licensed header) and added the full MIT permission text.
- Bind on the generic mediatek,mt8195-* fallback compatible (shared IP) rather than the SoC-specific mediatek,mt8188-*:
dpi, ethdr, merge, rdma.
- Makefile/Kconfig header cleanup: copyright set to BayLibre and the obj- list sorted alphabetically.

Per patch
- display pipeline component helpers: reworded the commit message (probe and enable sequence).
- ethdr: use the kernel's parameterized MIX_L_SRC_CON(n)/MIX_L_SRC_SIZE(n) macros, drop the unused *_CK_EN defines, add
BACKGROUND_RELAY to the datapath write; keep the downstream-only L2 select bits behind a comment.
- merge: rename registers to the kernel's DISP_REG_MERGE_* / MERGE_EN; keep the downstream-only CFG_30 behind a comment.
- mutex: make the register offsets index-based (DISP_MUTEX_*(id)) and rename the helper to mtk_disp_mutex_config_hdmi()
so a future DSI user can reuse it.
- padding: rename registers to the kernel's PADDING_CONTROL_REG / PADDING_ENABLE / PADDING_PIC_SIZE_REG.
- rdma: use the kernel's FLD_* fields with FIELD_PREP(); take the stride from the framebuffer line_length instead of
recomputing it; error out if the framebuffer base is above 4 GB (the source-base register is 32-bit), add larb configuration.
- dpi: import mtk_dpi_regs.h verbatim from the mainline kernel and adjust the driver to the upstream names (DPI_RET,
DPI_INPUT_2P_EN, DPI_OUTPUT_1T1P_EN); keep the one downstream-only matrix value (MATRIX_SEL_RGB_TO_BT709) locally.
- include/linux/hdmi.h: MIT relicense (see above).
- hdmi driver: move the register defines into a new mtk_hdmi_regs_v2.h imported verbatim from the mainline kernel;
correct VID_DOWNSAMPLE_CONFIG to 0x8f0 per the MT8390 datasheet (mainline has a wrong 0x8d0 — a separate kernel fix was
sent); remove the dead deep-color code path (the driver only ever drives 8 bpc); drop the unused length argument of the
infoframe helpers; check the RDMA config return value; resolve the vdosys1 syscon via ofnode_by_compatible() instead of
a U-Boot-invented alias.
- dts (reserved-memory): drop the unused splashscreen carveout, keep only the framebuffer region; retitle the patch to
"add framebuffer reserved-memory".
- dts (hdmi override): drop the U-Boot-invented vdosys1 alias (resolved by compatible now) and larb2/larb3 aliases
now resolved using iommus and DT directly inside rdma component.
- configs: use CONFIG_VIDEO_LOGO (show the U-Boot logo) instead of CONFIG_SPLASH_SCREEN, since upstream lacks the
plumbing to make the splash actually work — this also keeps CONFIG_EXPO enabled and drops the now-unneeded CMD_BMP /
BMP_24BPP.
- Link to v2: https://patch.msgid.link/20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com

Changes in v2:
- Add a common `get_unaligned_le24()` helper for reading 24-bit little-endian values, ported from kernel
- Add a common `linux/hdmi.h` header with HDMI colorspace and colorimetry enums, based on the corresponding Linux header.
- Refactor the HDMI driver to use the new common HDMI definitions and unaligned access helper.
- Rename the mixer component to ETHDR and configure the ETHDR before the remaining display pipeline components.
- Add the SMI LARB components and configure the VDOSYS1 routing directly from the HDMI driver.
- Switch display component lookup from phandles to DT aliases and add proper error unwinding for component clocks, HDMI PHY power, and clock resources.
- Refactor HDMI register access and InfoFrame handling.
- Improve HDMI mode handling, YUV420 downsampling, TMDS scrambling, deep-color handling, and InfoFrame generation.
- Move framebuffer/splash reserved-memory definitions to the Genio common U-Boot DTSI and add the corresponding HDMI override node for MT8390/Genio EVKs.
- Drop the dedicated MT8188 VDOSYS1 pipeline component and its corresponding DTS node, to avoid having 2 nodes with same reg address.
- Remove the unnecessary `dm_scan_fdt_dev` bind hook from the HDMI driver.
- Link to v1: https://patch.msgid.link/20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Carlo Caione <ccaione@baylibre.com>

---
Julien Stephan (14):
      video: mediatek: add display pipeline component helpers
      video: mediatek: add ethdr component
      video: mediatek: add merge component
      video: mediatek: add mutex component
      video: mediatek: add padding component
      video: mediatek: add rdma component
      video: mediatek: add smi larb driver
      video: mediatek: add dpi1 component
      asm-generic: unaligned: add get_unaligned_le24()
      include: linux/hdmi.h: add HDMI colorspace and colorimetry enums
      video: mediatek: add new hdmi driver
      arm: dts: mt8390: add framebuffer reserved-memory
      arm: dts: mt8390: add hdmi override node
      configs: mediatek: mt8188: enable hdmi pipeline

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |   1 +
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |   1 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  |  26 +
 configs/mt8188.config                         |   6 +
 drivers/video/Kconfig                         |   1 +
 drivers/video/Makefile                        |   1 +
 drivers/video/mediatek/Kconfig                |  21 +
 drivers/video/mediatek/Makefile               |  16 +
 drivers/video/mediatek/mtk_disp_comp.c        |  78 +++
 drivers/video/mediatek/mtk_disp_comp.h        |  32 +
 drivers/video/mediatek/mtk_disp_merge.c       | 108 ++++
 drivers/video/mediatek/mtk_disp_merge.h       |  19 +
 drivers/video/mediatek/mtk_disp_mutex.c       |  67 ++
 drivers/video/mediatek/mtk_disp_mutex.h       |  14 +
 drivers/video/mediatek/mtk_disp_padding.c     |  40 ++
 drivers/video/mediatek/mtk_disp_padding.h     |  16 +
 drivers/video/mediatek/mtk_dpi.c              | 383 +++++++++++
 drivers/video/mediatek/mtk_dpi.h              |  20 +
 drivers/video/mediatek/mtk_dpi_regs.h         | 247 +++++++
 drivers/video/mediatek/mtk_ethdr.c            |  72 +++
 drivers/video/mediatek/mtk_ethdr.h            |  16 +
 drivers/video/mediatek/mtk_hdmi.c             | 894 ++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_hdmi_regs_v2.h     | 267 ++++++++
 drivers/video/mediatek/mtk_mdp_rdma.c         | 159 +++++
 drivers/video/mediatek/mtk_mdp_rdma.h         |  20 +
 drivers/video/mediatek/mtk_smi_larb.c         |  30 +
 include/asm-generic/unaligned.h               |   7 +
 include/linux/hdmi.h                          |  49 ++
 28 files changed, 2611 insertions(+)
---
base-commit: 677a768c91b2baaefdf09633d1fdb5c9f758674f
change-id: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

