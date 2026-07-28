Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA800C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC2A880EBD;
	Tue, 28 Jul 2026 12:29:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pGj1dbOXIbb; Tue, 28 Jul 2026 12:29:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC81780EFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241774;
	bh=CZU1PYj/7sXGjcr6pyEvcr0ozcq70nOLHqKMyT4n3EQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Apt0Fx2xBiyAKiekQASZ50G8adWRqUJ+r/sjoHKYnycvJW3IFos5EX6nQFGz8h4b/
	 wQwLo5F3rB+VQ3d06nCXi41DliIxQ12d0yIKoQaV6Mj+DhyEWo+YyV16NGZ9TcVGBD
	 97Sf5DKOweGgGV74n0NAPCnJSixp5Ok9LVzrJrX4c+cN4nHKd0y3nngVgxVh4hqC3T
	 42hNk1h/1COZxZibvLVyb0rpEKj1L65K3GdYb2SJCK/fGIpnL7GbwFjr6JaOZHtqR1
	 incgF/yMlEVnkHR3lBWiAjrptAIzxUXEpw9i0DeO3LULudKqlEYZyaFyiU242RPB+i
	 3321RjllUZg0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC81780EFA;
	Tue, 28 Jul 2026 12:29:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CED8194
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03B2F80EFC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJu5XLKw8vXc for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BDBA880EFA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDBA880EFA
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDBA880EFA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:31 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so2013177f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241770; x=1785846570;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CZU1PYj/7sXGjcr6pyEvcr0ozcq70nOLHqKMyT4n3EQ=;
 b=nxty/iwGPV+G5tAfcIV32NmL5uBV6X8xC6907Z26HHtRmycxKZhKnGN231nZfasWPL
 vkdHWy6A7JC0F3jyWDyBWYC4++beu+bPmlJcWGWM47EKEbFMDyXq5uqCEo5VXLsl+zbW
 ysfrmzPA9yQCB3wOWFl+o2ieWdRrB5fEE+YUvRXdnYtmG1HrLYca2yjihsiCZcnTeQfA
 f89mNjA05gSLEQiKU0gqAtXNaA7OnegDFrDsYNQCiYHhNgHMbYuwuCwWRMwLiR6tLYIk
 q9UYLIQn+wNUIPi/8QDi0gE0xpIF4/g91fR32WFsC8dKmmBWPg8mIitsvK99x5cuFl/1
 Unvg==
X-Gm-Message-State: AOJu0YzNGqC9Jj17yhXjxseYsql5HO9NQuID7syTXp/fiXhZk9a1adIt
 cFk7Rx+yJBWjJLuHNWUNqbEJw/FnBin6w2y0w1GyNYNm0vEj98O6NgaJ0UjH3EJlxOY=
X-Gm-Gg: AR+sD12LQ4TRjgMQqiYcsilkCf5p2W9sk+qup234uqBZb5aPYaKbYJ1XEso89Hl6USj
 7FMHyn9r90zCyKGsAQb+q4bJvcclKehjF+XU1UBC3C49Wru+zyiqtmuH3Utj2ix8KlnZqeysVsa
 Qc3NiX8Mxvp22cU5denGAqAvSJ1P1wxbJoZrUlYNRJVWH3dZGOhv+XpqQ9CR+ck6/Def4+GSd+2
 P19wngUNJUDNEZARcGjKZA4XGYNCkOWJlO6afSe8uwwLaIzvCEVYtEtEGr6WSHwLqVyuXqr0wfC
 l58gDiiPAPdDpPSl3PI91zugpZNGVfd4QAUret8/OFSjIJn52/x+gh9WGrAU/ImqXhJ/IhWetat
 jvNbO33rCFOSBTJ++Qb3vjEvq44lzlRNyQQvNyeKLdns4gsIcUXvcWoRANKXstpN9XYIoTcDbWo
 YHA3DixwGlNgVfWxgKom5iNSoWcfm40imoaJphZ4VfzZB23f8oZjxh2KZJHYo7IhAsrqChFgwMp
 E49m97YhRA1qutsMHE9j8L+FnrTBfJXK12IO6Nc8jniOsY3fpv6l4Ey7PSbIgICWBtAHLi0lA==
X-Received: by 2002:a5d:64e9:0:b0:47f:93be:dabd with SMTP id
 ffacd0b85a97d-47fb1f1013bmr2353055f8f.28.1785241769505; 
 Tue, 28 Jul 2026 05:29:29 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 00/13] mediatek: add HDMI pipeline support for MT8188 based
 boards
Date: Tue, 28 Jul 2026 14:29:32 +0200
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXNQQqDMBBA0avIrB2YBIzFq5Qu4mTUKRhLoqUg3
 t20xeXb/L9DlqSSoat2SPLWrEssMHUFPPk4CmooBkvWUUsGfQg4StQFG0Po46WWCKcwK7J3ll1
 /s4YYSuaVZNDPb3F//J23/im8frtwHCdA5Ri3hAAAAA==
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
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785241770; x=1785846570;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CZU1PYj/7sXGjcr6pyEvcr0ozcq70nOLHqKMyT4n3EQ=;
 b=EdTQCjOaAq9poJlyfXH/G7jS6oZvU4sO/g9ZLy+ch0L18lW5i7V6BsvlUhk7jSQbOs
 tj1JjkFzt0lAqZrk8e3f7F7EKZVOmVGpWNE0zFq+yfRjHJkTLpMAT9Umu3QNeFp73W/S
 3ZxwGvrdSenjNc0JlMDmmgyHI9lrLs1UQWQ+ShwVRMvz9po1CC+l5gc49BaF14urGLHD
 wx0sqx+W9zFIOFG8UyXW56hwekrktx8DCq4+P19o9a1XZnklygd4yLSyJCgQlKUIv2bO
 yAMcar4JtWDXkzbzoeQYkVax7XnYRJffnl0ERe1WEbyTW/usXfO50c9M7dtdRSTRgGaW
 nmFQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EdTQCjOa
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
Julien Stephan (13):
      video: mediatek: add display pipeline component helpers
      video: mediatek: add mixer component
      video: mediatek: add merge component
      video: mediatek: add mutex component
      video: mediatek: add padding component
      video: mediatek: add rdma component
      video: mediatek: add vdosys1 component
      video: mediatek: add dpi1 component
      video: mediatek: add new hdmi driver
      arm: dts: mt8188: add vdosys1-pipeline node
      arm: dts: mt8188: add framebuffer and splash reserved-memory
      arm: dts: mt8188: add hdmi override node
      configs: mediatek: mt8188: enable hdmi pipeline

 arch/arm/dts/mt8188-u-boot.dtsi                  |  52 ++
 configs/mt8188.config                            |  12 +
 drivers/video/Kconfig                            |   1 +
 drivers/video/Makefile                           |   1 +
 drivers/video/mediatek/Kconfig                   |  21 +
 drivers/video/mediatek/Makefile                  |  16 +
 drivers/video/mediatek/mtk_disp_comp.c           |  68 ++
 drivers/video/mediatek/mtk_disp_comp.h           |  30 +
 drivers/video/mediatek/mtk_disp_merge_mt8188.c   | 106 +++
 drivers/video/mediatek/mtk_disp_merge_mt8188.h   |  19 +
 drivers/video/mediatek/mtk_disp_mixer_mt8188.c   |  76 ++
 drivers/video/mediatek/mtk_disp_mixer_mt8188.h   |  16 +
 drivers/video/mediatek/mtk_disp_mutex_mt8188.c   |  63 ++
 drivers/video/mediatek/mtk_disp_mutex_mt8188.h   |  14 +
 drivers/video/mediatek/mtk_disp_padding_mt8188.c |  37 +
 drivers/video/mediatek/mtk_disp_padding_mt8188.h |  16 +
 drivers/video/mediatek/mtk_dpi_mt8188.c          | 379 ++++++++++
 drivers/video/mediatek/mtk_dpi_mt8188.h          |  20 +
 drivers/video/mediatek/mtk_dpi_regs.h            | 113 +++
 drivers/video/mediatek/mtk_hdmi.c                | 919 +++++++++++++++++++++++
 drivers/video/mediatek/mtk_mdp_rdma_mt8188.c     |  97 +++
 drivers/video/mediatek/mtk_mdp_rdma_mt8188.h     |  20 +
 drivers/video/mediatek/mtk_mt8188_hdmi_regs.h    | 103 +++
 drivers/video/mediatek/mtk_vdosys1_mt8188.c      |  74 ++
 drivers/video/mediatek/mtk_vdosys1_mt8188.h      |  16 +
 25 files changed, 2289 insertions(+)
---
base-commit: f9e34cbaacfabfc401faf386e4ae1ad88e01255e
change-id: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

