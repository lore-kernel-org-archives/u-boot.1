Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9649C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6877E80F06;
	Wed,  2 Sep 2026 14:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWJLhgx67rvI; Wed,  2 Sep 2026 14:16:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358595;
	bh=vnLtgVMTHg5ZsUeLNux3HrolzkPO+SWrzCTJ6a1mxSQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qmk6I63Epjrq/zzOVrf43Ia+3Y+Ugsioxc1qXAypKKFI5DBndeCMtBy33lJMi7L7w
	 wMUH0xtUPbq/k/8ienXI0KoFQGyjMz5/6MyWBJnhSDzqdWaIZm8N59Ie5htxKKkscN
	 KZJoBccG2w/T1dcLfcRf/rgHLRUbzwK5I9MBdWfs28zNwDi5QHqZpam6m4a7lRB8oV
	 Sq+iOicg4FBubXiy6FG2RnaC9J+RYcZ8bae1sAD2HJUumYPvjy5N4NySgu9De/1t7J
	 mVm8a2cG1yUwIAdnLzDbvTj2eKJ+J+7fN+Nmttgo1HWc3xQjp/q+uk58HpW7N7ZSTo
	 CdlMEg5/CLv7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9ACF080F73;
	Wed,  2 Sep 2026 14:16:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CCA091D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEB96606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhnU0wqkWAXB for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Vwoy3Btm
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39EEB606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:25 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5b4ab0e4da6so1087604e87.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358583; x=1788963383;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vnLtgVMTHg5ZsUeLNux3HrolzkPO+SWrzCTJ6a1mxSQ=;
 b=Vwoy3Btma328Lf6gVi39S3A1dY5QciANuMiSqhyAwjQ5cWWzccEXgaC2q/ZoRJtr5D
 nwR2DEGo/iPBlQqKMp1KP7y+0YX7arqH4xKOmNUNMeukUFIs74rBqgANc5SWqwWgIfhZ
 rz6z/Lh4ck6dnNjqD1vm2xAvLvx/FSn8dw6IGEiw5OZv9bXejKXkezMe3E8sFlw0rwGz
 rn3Hdj2adXA+kyWkty5alRJELOiX4hwruvqUDo/5Y/ZIZua2v5Oo68kxZlzemhAGFcE/
 TLfHcQBklDwMPKjBOh0aE97nijI+X6xt4Lzn2KUjaNeuBtkC+PYSpTXSy3xkWdS94a+K
 y7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358583; x=1788963383;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vnLtgVMTHg5ZsUeLNux3HrolzkPO+SWrzCTJ6a1mxSQ=;
 b=M6Gs/xhkBtPI6lG2Qi9rxXmrIacZ4TE80rt2H6vlcgsHiNdCEU1ip86kUZQgQOtL2K
 s3x3BnvL44eD8Z7W32bH5xG/DaWJ/2AVO4MZbPELwawFVrioCsdi0DdISHlt0wI0kfnu
 WghlcGEBzNSji1YY8oSMCd7Qk5jd1SR5VcbxSIm8yRuLc8X1sKJ84jbNjD6ek84y6xc6
 jg+9ywjnVG8i5VsOZh5ZSs8eaPQ6A/dh9axVyyR6318De41VbCFs4oJwn43talnR8Ihf
 Asw/BFSxvn0uOcAE3u4I1u+6OO3lGAbfb/4gMBpYT1f7RAJlmyuBGC2kIJpS7g2ijuq1
 95Ng==
X-Gm-Message-State: AFuF++lhfUx6ve4Bm9TJtJ5fWdi4rODjnOr0oQcgVQ02l+9hAx1KXe/S
 bWN4VwBvqpK5jsF9mWrrcT4h0iQpp0MoARemqp/mD8ZsqKl2Dp8xSb8ZVcT2O0WU2p394TblOOq
 22R4ozY4=
X-Gm-Gg: AYBFou1pbHyMXOgUORYRheNtNfkd1Oah4yYGrb6MPYy+1jrl2HfUCS7/C0QBkCBwuwi
 RVMYasPfP4y/KhBYq7jG2dktjc7jBHkBu1nuNZh74+yrbB5rjiEGNnd81nUhhKmU5/7ZCSDfFEB
 231pPhMGGetyKw7fC2417ndoT6Ap/iiq/Wj/oyWyOxqm2gHpDj0E4X//gwcEUY80TeMEePA7UFj
 x2EPX1nJ91V0ozYDWaCrR+LsN3H8F38TL53RS5T2bHLQ2hUOK0esWmYGbvxWnOEHrMDg+iEA5pv
 PaWFA0idMD5vt7iVm+G/wMw17TizIgQaNP27yA6ohYu/ggzyud+7ScniY+OpcY4Jn91vRFm9PDv
 diFcsC2SJAqtPK30BBTmAUYzRFnpS312YLesB0x+0bLlWwQNjSgoz6D+vrkCj+owKE86QBxDRN7
 SLbDpa/BNjDScS1umdx9+eM99jXXUXoF4utXWJJ2GGcdsYqAAQM766zGRTyT/jPNcXdd3ZnTcez
 ak25penhNOQ+kczxz9oHVpoaJ9qt2GujWSAfcgO4dmFl5jbLb+oDUFQQxN8Yzk7QPKuVY59rBSl
 THdUtcBVMng544ceSZtV3KbY+zOp4F8+VR5SUV3DoC9M
X-Received: by 2002:a05:6000:260a:b0:482:ea99:6166 with SMTP id
 ffacd0b85a97d-48488df7809mr10175174f8f.7.1788358566721; 
 Wed, 02 Sep 2026 07:16:06 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:15:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v4 00/14] mediatek: add HDMI pipeline support for MT8188
 based boards
Date: Wed, 02 Sep 2026 16:15:50 +0200
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QwWrDMAwG4FcpPs/DchLH6WnvMXawbKXRWJNiZ
 2al5N3ndC2FUliPvxDfL3QSiSJTEtvNSUTKnHgaS6hfNsIPbtyR5FCy0Eob1SqQLgS5o5En2YC
 SbrymVik5hD1L74z2Bq0G5UVhDpF6/jlXvH/85fSNn+Tn1V03Bk7zFI/nGzKse5c6bf+vyyDL3
 Dc1hrbpO6Pe0B2/GCO9+mkv1sasb6bV5glTF9NYQgTsoQ39A7O6md0zb8lVMSsLXe2aCrC7N5d
 l+QXBpI10jQEAAA==
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
Changes in v4:
- refresh config fragment with savedefconfig: remove CONFIG_VIDEO_LOGO,
  correctly place CONFIG_WATCHDOG_AUTOSTART
  that is enabled by default
- reword commit message on patch 13: remove useless mentions to larb/vdosys1 aliases that were removed in v3
- Link to v3: https://patch.msgid.link/20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com

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
 configs/mt8188.config                         |   5 +
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
 28 files changed, 2610 insertions(+)
---
base-commit: 677a768c91b2baaefdf09633d1fdb5c9f758674f
change-id: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

