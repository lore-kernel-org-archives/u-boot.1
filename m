Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4907FC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAC186068A;
	Wed, 26 Aug 2026 13:09:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-9A8xcb-odT; Wed, 26 Aug 2026 13:09:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749775;
	bh=VnmAOrxupbcLakfZluk3Ez9grCT+CgSTDbWvRv41TGE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D6W/IftGf92aEb3wiQIKXNgK43KJqzEMlKZe6Nd/3PT7+C51zSGHbs8rnenfffBxw
	 eHrU2EAy8VuSGlBXaTtBkmWWgHE6l2gaPlIv+AqKDfBRydK9WAAMJLsTUtbufjBKNU
	 TsdcUs06AA7KJ1FyWkHE8DFsCck3NXIyM8kRkJk8W/qqUP6ZaEBSLklgBBfOA+7e8l
	 knxKRozsh5EXVEt3qm2ots37x+TSD2Pp5a8o61+8m//8U8W5WUR5Vpv7p8wKbJqyro
	 VDoljPcA3otXji3EHEiy4iodWn944vJayK/O/YNmacwX9f+KbNTjVUIFK5zOLpaiL3
	 E9dBFccNJcMsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD9E6605F0;
	Wed, 26 Aug 2026 13:09:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E68B63AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD18D80B6A
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OIbdsDm50tbx for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ETP+0bnC
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56E2F80A4C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:30 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so451165f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749769; x=1788354569;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VnmAOrxupbcLakfZluk3Ez9grCT+CgSTDbWvRv41TGE=;
 b=ETP+0bnCbla6QdZS0NxYtV0HspyqKDyZ9KFgIbaIqc0MtmXHDzZOyJIp4k4J6PDXIK
 9KLp+riGP7TVCBrvjQ1TeKAt/n15LzLoCnUbED5P79E17ncvDYI/X2SMdridXeMZqQ6v
 00oI3QQu6oEVOTacgcdAvQvtQ8JjZzGgrBrmjAgKgcZcrlmivjLH2N5h3nAviLVzBClq
 bWsSo+03ntzz3dvXwrjOSkR0bKtbqc0FHTPPMaZeM+qsynTPfGGiUsvMJfUyUSy2GjKm
 IWCTOLJBB6lnur4QJtu7CyET+O2bEZ6hjk95oZhJF7RfGWTh1WhGANuYi2cQeJiST9M+
 SM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749769; x=1788354569;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VnmAOrxupbcLakfZluk3Ez9grCT+CgSTDbWvRv41TGE=;
 b=DzTdqyd6zVYFTd10LTP+2xzvV//SbkYCft7XILiTrYz4dzsFL9uVkYDTeL58jyl20U
 yCr5gCmW92FblFPiKJNqahW0IpFFLuQLfbbxNk/skSRmM8VR2eoGVnY14IIaXE2xEyLF
 ebhkSdhdE08NCJNk3TiMEVYjRPY5FsgEF09uhW1lNlddFq+zG6l4w0nuvSjGgDzLRLID
 IXv/K8VTIfMERViD603RI9FtwweU2aPnBRIDbbFbB1yTezTHjUFe2of/3nxvSKSnHAEN
 NBnz1xgJS9+5NwHEgrbleZSnDDqNL3SYCLJTzKkTTW3KQqxUbpd7WcEKCcgPvXJltOQv
 MwUg==
X-Gm-Message-State: AFuF++lySnV9hSAC2pMCea/sv1qh+f/P4062gZHsi5wcTuPzIdOE3djB
 1f3BVc1oyibX++sS4xJYYFMpkBjBQSTJZoaY8HTOPve4mar6Kec7GB0HX/KsFarVm7E=
X-Gm-Gg: AR+sD11m6PvSCQuY71yuS+ufsABgSO04bOkp04yegci7RiHKw6xVOuNR5wmqIRj75yL
 ZYMjGYknvv/Std+HBpXBCKsYj3AHFCwFGBLbOHBTLP/YdcBaXdL4yqjDmnzj055RdlFkMa6biET
 ZJdZwmV8IDCKs/SFnFT9fyJ0RNpkyt08apCMn4U5eQ3cmIQCx4KGXvnPFJjp6EatIH8+32ZHoZX
 4i0/8K7+P8jPlHnN1MhDquMDBmZXZ3YexGhbiVhCkpFUcgE3i+cD9nIP+68Q8fIBbJDnuSUmWug
 mKc7jMJ4kHltJI+Zpt+p+2qxSxATNBOgbit6rlDeogJNVlQFwiByzqft1IBlKTE3IoHECelvkzR
 dMMcjZV9ENOxdzvoYT6gdfzzBBkMnDLF6P7i4CnsGe5GJFaIQVNJ3v1FAOyWrleW73qEC2WKjuq
 HtxBgwgs58rrFmjmLL14b2LD9Y2qycPeaV30lQ+YbYvxHjLduxOBal0l2CS23WcB5Kbc/1iXJr+
 LrnZihlGQaLRCtRsz32qyr+Qz1mCWc/1Zefqg81Q/DQz1drhywrPg6lPoc0TRddaP7yrs+hFayG
 KGKZDx3F3Ld0OjsqzvHf/riKoxZ55JE4JT7sEE+w14ALVA==
X-Received: by 2002:a05:6000:4715:b0:482:e2ea:7ff6 with SMTP id
 ffacd0b85a97d-482e2ea82b8mr6863253f8f.4.1787749768662; 
 Wed, 26 Aug 2026 06:09:28 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 00/14] mediatek: add HDMI pipeline support for MT8188
 based boards
Date: Wed, 26 Aug 2026 15:09:27 +0200
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6CMBREf4V07TVtIwVd+R+GRR9XuEZa0yKRE
 P7dgrp2eSaTOTOzhJEwsVMxs4gjJQo+g9wVzHbatwjkMjPJpeIVF6CdgxY9BSgFB+1/VHEOnes
 JrFbSKlNLwS3LM4+IV3ptikvz4fQ0N7TDurs2OkpDiNP2YRRr76uT9X/dKCDntjwYV5XXo+Jno
 6c7mYh7G3rWLMvyBuREv8DlAAAA
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
      arm: dts: mt8390: add framebuffer and splash reserved-memory
      arm: dts: mt8390: add hdmi override node
      configs: mediatek: mt8188: enable hdmi pipeline

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |    1 +
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |    1 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  |   43 +
 configs/mt8188.config                         |   12 +
 drivers/video/Kconfig                         |    1 +
 drivers/video/Makefile                        |    1 +
 drivers/video/mediatek/Kconfig                |   21 +
 drivers/video/mediatek/Makefile               |   16 +
 drivers/video/mediatek/mtk_disp_comp.c        |   68 ++
 drivers/video/mediatek/mtk_disp_comp.h        |   30 +
 drivers/video/mediatek/mtk_disp_merge.c       |  106 +++
 drivers/video/mediatek/mtk_disp_merge.h       |   19 +
 drivers/video/mediatek/mtk_disp_mutex.c       |   63 ++
 drivers/video/mediatek/mtk_disp_mutex.h       |   14 +
 drivers/video/mediatek/mtk_disp_padding.c     |   37 +
 drivers/video/mediatek/mtk_disp_padding.h     |   16 +
 drivers/video/mediatek/mtk_dpi.c              |  379 +++++++++
 drivers/video/mediatek/mtk_dpi.h              |   20 +
 drivers/video/mediatek/mtk_dpi_regs.h         |  113 +++
 drivers/video/mediatek/mtk_ethdr.c            |   76 ++
 drivers/video/mediatek/mtk_ethdr.h            |   16 +
 drivers/video/mediatek/mtk_hdmi.c             | 1102 +++++++++++++++++++++++++
 drivers/video/mediatek/mtk_mdp_rdma.c         |   97 +++
 drivers/video/mediatek/mtk_mdp_rdma.h         |   20 +
 drivers/video/mediatek/mtk_smi_larb.c         |   30 +
 include/asm-generic/unaligned.h               |    7 +
 include/linux/hdmi.h                          |   30 +
 27 files changed, 2339 insertions(+)
---
base-commit: 3fc031686aa1d219a113c5a77c165fd0a656076d
change-id: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

