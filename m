Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC7EC44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2922C84ACA;
	Fri, 10 Jul 2026 16:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="oIQJqPri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3101D84AF6; Fri, 10 Jul 2026 16:37:22 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F83084AA5
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493b7612475so8422135e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783694239; x=1784299039; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9A4712cct3a50ImEKPILls8G1KwEmMGMPu0yniob8zc=;
 b=oIQJqPriDRCGp27qlcisr8Ge3/nDace23/gClD07iFpZcJNNlM6Tv2bpJKlPmv61C4
 ZNH5dYuTWkpDictR9/BbovtoP2n2cmo4JGjLBvZQ+cW5knUeltd95aLTTzqp3/ZlELt5
 DxVhUJk4EvOfvXnNHLIXSnFBkR2LmTXdCBgX6qPtBO4WvsThBcqgQIcgZxsg46bRfQEt
 ed+6ScqGi8/Q3nbOOCyPqftpNf1ck+fHD8Sii6hEuyOhRZrNTIxNf+B4XzbMSEUWF9L1
 aqi/GUrOy4vTZGFHuaO83BtDjkdy4FAZDnA3fn555W99VmPbNu982hIzjtZZLvJ/51UP
 tY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783694239; x=1784299039;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9A4712cct3a50ImEKPILls8G1KwEmMGMPu0yniob8zc=;
 b=ANBQIsDJ0Ewjk3T0g8szrp4nps+B0wviuCriz2ARvM/fJA+vLtFDZuEjSRoEyjxbNF
 4xcoxSgOZut9IB9w2dC3MMkYQexa0ebzKtHPHvMX7MDS6CVXM3UNch3CADPdQg7wEfAH
 +muU0xxT5K1uYX6teUga0vudq5vOAbuw+Draxaj1UL8fqtqwy4gAT2aYN6ExbClRfqab
 BSDeEx9nJcsdALkre2XkSn3I8mjRYBFEPgJbg7ECccTBUJycP+r3BVQ2wfD+48bRI1ek
 OKoBcd68CYXbKrkmx1V+nnThOcEkgjlTaswzSSVMRKpgGuP19xd+Du7YZwhtxv74R0Jm
 G3lw==
X-Gm-Message-State: AOJu0YzJHXykPlnuLfT9SACvehGjyBpQkk8dONGmHxg9p0K/mOi4KPYN
 /4u9AuYyWlO0BBsex5THk2+aZDyvgvdynwdhrskmKbD4HxaQzkXvr1cGY7dNGXdqy3Y=
X-Gm-Gg: AfdE7ckEKddreco/cbBECDluWMo7g4Zlz4oGg09C9AmQiQPJoggTN+aFGn4EvwE8HDh
 sdh3cRH1snnguj2X0nlfnSguLGP2cEiBbHFuZq1en2JU9zyAWnIBCMOpM6DemP1pniEGt4PE8WO
 uCHprjeIZcZxeG04yw9caaIjcgPV9rOxjid001V1WIo5dKtRkzsLQx1s/cu9p3fXhszr0Ck9X/N
 I71ujkp9M9GFync3FAViNiXBM74OFg9gunPoj2p/r/v6DnhVQrexxsHXyml6BLZNtvpCueZVONw
 lzbJXKnSAPCmHfEXZ7Xiixf8L79bRSZo9+Sb2BWZrHf9OltG4+ns/D6buw6Bp4SkkqfZVMEmHih
 YtubmOyA+xb5xer5pWeLGdNqMwQH2ACAjoLth5/jR7CoALA0SG1KGbyf6pSzupZ1euIaPiCp0h+
 icKVvlBQhaOLBmB27UwYWYzhoii1B+IF1jK6P+faAOA9UwMHzwWGSI45XvpQ6LnFwC0NdcBKfJX
 rCVkfYuYquUTKRO7zt8DtSTCXgXcjLH7lDz28fQEUZUreXpr/kp9hyLZbt6+f4Lx0SPJeU=
X-Received: by 2002:a05:600c:1c0b:b0:492:4c2e:9613 with SMTP id
 5b1f17b1804b1-493e6864191mr125872195e9.18.1783694238831; 
 Fri, 10 Jul 2026 07:37:18 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccaf1sm253852685e9.2.2026.07.10.07.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:37:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:37:27 +0200
Subject: [PATCH] clk: mediatek: mt8188: add display related clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mt8188-add-clk-add-display-related-clocks-v1-1-6845417f52b5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z3OTW6EMAwF4KugrOsqgWQKrHqPahZ24kxTfpsA6
 mg0d2+AqivrWU/29xCJY+Ak2uIhIm8hhWnMQb0Uwn7ieGMILmdRyvIi35SEYalVXQM6B7bvjul
 Cmnu8Q+QeF973k+0SyJIqjb5pvKtFvjdH9uHn+PVxPXNa6Yvtsj/4a0T+XjNiOWuCMDHYaRjC0
 hZkvEXjL1KxcagbY7BCqlVeKc0KVSUl25L2UwOnhIe+Lf7tpDO/O9y2ZxzX+bTCLbvBxbBxTLA
 pkICajNWNcg35d8J7Hyjya5aI6/P5C2UEK4M2AQAA
X-Change-ID: 20260710-mt8188-add-clk-add-display-related-clocks-02b34af99fd8
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Add display related clock drivers, needed for HDMI support.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Add display related clock driver needed for HDMI support that is coming
in another series.
This series depends on [1], for MediaTek clock driver refactor.

[1]: https://lore.kernel.org/all/20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com/
---
 drivers/clk/mediatek/clk-mt8188.c | 378 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 378 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index cbaea9f0b2e..4444aafc455 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1687,6 +1687,364 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C6, CLK_TOP_I2C, 1),
 };
 
+static const struct mtk_gate_regs vdo0_0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs vdo0_1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs vdo0_2_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+static const struct mtk_gate_regs vpp0_0_cg_regs = {
+	.set_ofs = 0x24,
+	.clr_ofs = 0x28,
+	.sta_ofs = 0x20,
+};
+
+static const struct mtk_gate_regs vpp0_1_cg_regs = {
+	.set_ofs = 0x30,
+	.clr_ofs = 0x34,
+	.sta_ofs = 0x2c,
+};
+
+static const struct mtk_gate_regs vpp0_2_cg_regs = {
+	.set_ofs = 0x3c,
+	.clr_ofs = 0x40,
+	.sta_ofs = 0x38,
+};
+
+#define GATE_VPP0_0(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vpp0_0_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VPP0_1(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vpp0_1_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VPP0_2(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vpp0_2_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+static const struct mtk_gate vpp0_clks[] = {
+	/* VPP0_0 */
+	GATE_VPP0_0(CLK_VPP0_MDP_FG, CLK_TOP_VPP, 1),
+	GATE_VPP0_0(CLK_VPP0_STITCH, CLK_TOP_VPP, 2),
+	GATE_VPP0_0(CLK_VPP0_PADDING, CLK_TOP_VPP, 7),
+	GATE_VPP0_0(CLK_VPP0_MDP_TCC, CLK_TOP_VPP, 8),
+	GATE_VPP0_0(CLK_VPP0_WARP0_ASYNC_TX, CLK_TOP_VPP, 10),
+	GATE_VPP0_0(CLK_VPP0_WARP1_ASYNC_TX, CLK_TOP_VPP, 11),
+	GATE_VPP0_0(CLK_VPP0_MUTEX, CLK_TOP_VPP, 13),
+	GATE_VPP0_0(CLK_VPP02VPP1_RELAY, CLK_TOP_VPP, 14),
+	GATE_VPP0_0(CLK_VPP0_VPP12VPP0_ASYNC, CLK_TOP_VPP, 15),
+	GATE_VPP0_0(CLK_VPP0_MMSYSRAM_TOP, CLK_TOP_VPP, 16),
+	GATE_VPP0_0(CLK_VPP0_MDP_AAL, CLK_TOP_VPP, 17),
+	GATE_VPP0_0(CLK_VPP0_MDP_RSZ, CLK_TOP_VPP, 18),
+	/* VPP0_1 */
+	GATE_VPP0_1(CLK_VPP0_SMI_COMMON_MMSRAM, CLK_TOP_VPP, 0),
+	GATE_VPP0_1(CLK_VPP0_GALS_VDO0_LARB0_MMSRAM, CLK_TOP_VPP, 1),
+	GATE_VPP0_1(CLK_VPP0_GALS_VDO0_LARB1_MMSRAM, CLK_TOP_VPP, 2),
+	GATE_VPP0_1(CLK_VPP0_GALS_VENCSYS_MMSRAM, CLK_TOP_VPP, 3),
+	GATE_VPP0_1(CLK_VPP0_GALS_VENCSYS_CORE1_MMSRAM, CLK_TOP_VPP, 4),
+	GATE_VPP0_1(CLK_VPP0_GALS_INFRA_MMSRAM, CLK_TOP_VPP, 5),
+	GATE_VPP0_1(CLK_VPP0_GALS_CAMSYS_MMSRAM, CLK_TOP_VPP, 6),
+	GATE_VPP0_1(CLK_VPP0_GALS_VPP1_LARB5_MMSRAM, CLK_TOP_VPP, 7),
+	GATE_VPP0_1(CLK_VPP0_GALS_VPP1_LARB6_MMSRAM, CLK_TOP_VPP, 8),
+	GATE_VPP0_1(CLK_VPP0_SMI_REORDER_MMSRAM, CLK_TOP_VPP, 9),
+	GATE_VPP0_1(CLK_VPP0_SMI_IOMMU, CLK_TOP_VPP, 10),
+	GATE_VPP0_1(CLK_VPP0_GALS_IMGSYS_CAMSYS, CLK_TOP_VPP, 11),
+	GATE_VPP0_1(CLK_VPP0_MDP_RDMA, CLK_TOP_VPP, 12),
+	GATE_VPP0_1(CLK_VPP0_MDP_WROT, CLK_TOP_VPP, 13),
+	GATE_VPP0_1(CLK_VPP0_GALS_EMI0_EMI1, CLK_TOP_VPP, 16),
+	GATE_VPP0_1(CLK_VPP0_SMI_SUB_COMMON_REORDER, CLK_TOP_VPP, 17),
+	GATE_VPP0_1(CLK_VPP0_SMI_RSI, CLK_TOP_VPP, 18),
+	GATE_VPP0_1(CLK_VPP0_SMI_COMMON_LARB4, CLK_TOP_VPP, 19),
+	GATE_VPP0_1(CLK_VPP0_GALS_VDEC_VDEC_CORE1, CLK_TOP_VPP, 20),
+	GATE_VPP0_1(CLK_VPP0_GALS_VPP1_WPESYS, CLK_TOP_VPP, 21),
+	GATE_VPP0_1(CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1, CLK_TOP_VPP, 22),
+	GATE_VPP0_1(CLK_VPP0_FAKE_ENG, CLK_TOP_VPP, 23),
+	GATE_VPP0_1(CLK_VPP0_MDP_HDR, CLK_TOP_VPP, 24),
+	GATE_VPP0_1(CLK_VPP0_MDP_TDSHP, CLK_TOP_VPP, 25),
+	GATE_VPP0_1(CLK_VPP0_MDP_COLOR, CLK_TOP_VPP, 26),
+	GATE_VPP0_1(CLK_VPP0_MDP_OVL, CLK_TOP_VPP, 27),
+	GATE_VPP0_1(CLK_VPP0_DSIP_RDMA, CLK_TOP_VPP, 28),
+	GATE_VPP0_1(CLK_VPP0_DISP_WDMA, CLK_TOP_VPP, 29),
+	GATE_VPP0_1(CLK_VPP0_MDP_HMS, CLK_TOP_VPP, 30),
+	/* VPP0_2 */
+	GATE_VPP0_2(CLK_VPP0_WARP0_RELAY, CLK_TOP_WPE_VPP, 0),
+	GATE_VPP0_2(CLK_VPP0_WARP0_ASYNC, CLK_TOP_WPE_VPP, 1),
+	GATE_VPP0_2(CLK_VPP0_WARP1_RELAY, CLK_TOP_WPE_VPP, 2),
+	GATE_VPP0_2(CLK_VPP0_WARP1_ASYNC, CLK_TOP_WPE_VPP, 3),
+};
+
+static const struct mtk_gate_regs vpp1_0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs vpp1_1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_VPP1_0(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vpp1_0_cg_regs, _shift,\
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VPP1_1(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vpp1_1_cg_regs, _shift,\
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+static const struct mtk_gate vpp1_clks[] = {
+	/* VPP1_0 */
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_OVL, CLK_TOP_VPP, 0),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_TCC, CLK_TOP_VPP, 1),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_WROT, CLK_TOP_VPP, 2),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_VPP_PAD, CLK_TOP_VPP, 3),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_WROT, CLK_TOP_VPP, 4),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_VPP_PAD, CLK_TOP_VPP, 5),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_WROT, CLK_TOP_VPP, 6),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_VPP_PAD, CLK_TOP_VPP, 7),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_RDMA, CLK_TOP_VPP, 8),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_FG, CLK_TOP_VPP, 9),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_RDMA, CLK_TOP_VPP, 10),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_FG, CLK_TOP_VPP, 11),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_RDMA, CLK_TOP_VPP, 12),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_FG, CLK_TOP_VPP, 13),
+	GATE_VPP1_0(CLK_VPP1_VPP_SPLIT, CLK_TOP_VPP, 14),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_VDO0_DL_RELAY, CLK_TOP_VPP, 15),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_RSZ, CLK_TOP_VPP, 16),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_TDSHP, CLK_TOP_VPP, 17),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_COLOR, CLK_TOP_VPP, 18),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_VDO1_DL_RELAY, CLK_TOP_VPP, 19),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_RSZ, CLK_TOP_VPP, 20),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_VPP_MERGE, CLK_TOP_VPP, 21),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_TDSHP, CLK_TOP_VPP, 22),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_COLOR, CLK_TOP_VPP, 23),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_RSZ, CLK_TOP_VPP, 24),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_VPP_MERGE, CLK_TOP_VPP, 25),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_TDSHP, CLK_TOP_VPP, 26),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_COLOR, CLK_TOP_VPP, 27),
+	GATE_VPP1_0(CLK_VPP1_GALS5, CLK_TOP_VPP, 28),
+	GATE_VPP1_0(CLK_VPP1_GALS6, CLK_TOP_VPP, 29),
+	GATE_VPP1_0(CLK_VPP1_LARB5, CLK_TOP_VPP, 30),
+	GATE_VPP1_0(CLK_VPP1_LARB6, CLK_TOP_VPP, 31),
+	/* VPP1_1 */
+	GATE_VPP1_1(CLK_VPP1_SVPP1_MDP_HDR, CLK_TOP_VPP, 0),
+	GATE_VPP1_1(CLK_VPP1_SVPP1_MDP_AAL, CLK_TOP_VPP, 1),
+	GATE_VPP1_1(CLK_VPP1_SVPP2_MDP_HDR, CLK_TOP_VPP, 2),
+	GATE_VPP1_1(CLK_VPP1_SVPP2_MDP_AAL, CLK_TOP_VPP, 3),
+	GATE_VPP1_1(CLK_VPP1_SVPP3_MDP_HDR, CLK_TOP_VPP, 4),
+	GATE_VPP1_1(CLK_VPP1_SVPP3_MDP_AAL, CLK_TOP_VPP, 5),
+	GATE_VPP1_1(CLK_VPP1_DISP_MUTEX, CLK_TOP_VPP, 7),
+	GATE_VPP1_1(CLK_VPP1_SVPP2_VDO1_DL_RELAY, CLK_TOP_VPP, 8),
+	GATE_VPP1_1(CLK_VPP1_SVPP3_VDO0_DL_RELAY, CLK_TOP_VPP, 9),
+	GATE_VPP1_1(CLK_VPP1_VPP0_DL_ASYNC, CLK_TOP_VPP, 10),
+	GATE_VPP1_1(CLK_VPP1_VPP0_DL1_RELAY, CLK_TOP_VPP, 11),
+	GATE_VPP1_1(CLK_VPP1_LARB5_FAKE_ENG, CLK_TOP_VPP, 12),
+	GATE_VPP1_1(CLK_VPP1_LARB6_FAKE_ENG, CLK_TOP_VPP, 13),
+	GATE_VPP1_1(CLK_VPP1_HDMI_META, CLK_TOP_VPP, 16),
+	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_HDMI, CLK_TOP_VPP, 17),
+	GATE_VPP1_1(CLK_VPP1_DGI_IN, CLK_TOP_VPP, 18),
+	GATE_VPP1_1(CLK_VPP1_DGI_OUT, CLK_TOP_VPP, 19),
+	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_DGI, CLK_TOP_VPP, 20),
+	GATE_VPP1_1(CLK_VPP1_DL_CON_OCC, CLK_TOP_VPP, 21),
+	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_26M, CLK_TOP_VPP, 26),
+};
+
+#define GATE_VDO0_0(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo0_0_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VDO0_1(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo0_1_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VDO0_2(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo0_2_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+static const struct mtk_gate vdo0_clks[] = {
+	/* VDO0_0 */
+	GATE_VDO0_0(CLK_VDO0_DISP_OVL0, CLK_TOP_VPP, 0),
+	GATE_VDO0_0(CLK_VDO0_FAKE_ENG0, CLK_TOP_VPP, 2),
+	GATE_VDO0_0(CLK_VDO0_DISP_CCORR0, CLK_TOP_VPP, 4),
+	GATE_VDO0_0(CLK_VDO0_DISP_MUTEX0, CLK_TOP_VPP, 6),
+	GATE_VDO0_0(CLK_VDO0_DISP_GAMMA0, CLK_TOP_VPP, 8),
+	GATE_VDO0_0(CLK_VDO0_DISP_DITHER0, CLK_TOP_VPP, 10),
+	GATE_VDO0_0(CLK_VDO0_DISP_WDMA0, CLK_TOP_VPP, 17),
+	GATE_VDO0_0(CLK_VDO0_DISP_RDMA0, CLK_TOP_VPP, 19),
+	GATE_VDO0_0(CLK_VDO0_DSI0, CLK_TOP_VPP, 21),
+	GATE_VDO0_0(CLK_VDO0_DSI1, CLK_TOP_VPP, 22),
+	GATE_VDO0_0(CLK_VDO0_DSC_WRAP0, CLK_TOP_VPP, 23),
+	GATE_VDO0_0(CLK_VDO0_VPP_MERGE0, CLK_TOP_VPP, 24),
+	GATE_VDO0_0(CLK_VDO0_DP_INTF0, CLK_TOP_VPP, 25),
+	GATE_VDO0_0(CLK_VDO0_DISP_AAL0, CLK_TOP_VPP, 26),
+	GATE_VDO0_0(CLK_VDO0_INLINEROT0, CLK_TOP_VPP, 27),
+	GATE_VDO0_0(CLK_VDO0_APB_BUS, CLK_TOP_VPP, 28),
+	GATE_VDO0_0(CLK_VDO0_DISP_COLOR0, CLK_TOP_VPP, 29),
+	GATE_VDO0_0(CLK_VDO0_MDP_WROT0, CLK_TOP_VPP, 30),
+	GATE_VDO0_0(CLK_VDO0_DISP_RSZ0, CLK_TOP_VPP, 31),
+	/* VDO0_1 */
+	GATE_VDO0_1(CLK_VDO0_DISP_POSTMASK0, CLK_TOP_VPP, 0),
+	GATE_VDO0_1(CLK_VDO0_FAKE_ENG1, CLK_TOP_VPP, 1),
+	GATE_VDO0_1(CLK_VDO0_DL_ASYNC2, CLK_TOP_VPP, 5),
+	GATE_VDO0_1(CLK_VDO0_DL_RELAY3, CLK_TOP_VPP, 6),
+	GATE_VDO0_1(CLK_VDO0_DL_RELAY4, CLK_TOP_VPP, 7),
+	GATE_VDO0_1(CLK_VDO0_SMI_GALS, CLK_TOP_VPP, 10),
+	GATE_VDO0_1(CLK_VDO0_SMI_COMMON, CLK_TOP_VPP, 11),
+	GATE_VDO0_1(CLK_VDO0_SMI_EMI, CLK_TOP_VPP, 12),
+	GATE_VDO0_1(CLK_VDO0_SMI_IOMMU, CLK_TOP_VPP, 13),
+	GATE_VDO0_1(CLK_VDO0_SMI_LARB, CLK_TOP_VPP, 14),
+	GATE_VDO0_1(CLK_VDO0_SMI_RSI, CLK_TOP_VPP, 15),
+	/* VDO0_2 */
+	GATE_VDO0_2(CLK_VDO0_DSI0_DSI, CLK_TOP_DSI_OCC, 0),
+	GATE_VDO0_2(CLK_VDO0_DSI1_DSI, CLK_TOP_DSI_OCC, 8),
+	GATE_VDO0_2(CLK_VDO0_DP_INTF0_DP_INTF, CLK_TOP_EDP, 16),
+};
+
+static const struct mtk_gate_regs vdo1_0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs vdo1_1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs vdo1_2_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+static const struct mtk_gate_regs vdo1_3_cg_regs = {
+	.set_ofs = 0x134,
+	.clr_ofs = 0x138,
+	.sta_ofs = 0x130,
+};
+
+static const struct mtk_gate_regs vdo1_4_cg_regs = {
+	.set_ofs = 0x144,
+	.clr_ofs = 0x148,
+	.sta_ofs = 0x140,
+};
+
+static const struct mtk_gate_regs vdo1_5_cg_regs = {
+	.set_ofs = 0x400,
+	.clr_ofs = 0x400,
+	.sta_ofs = 0x400,
+};
+
+#define GATE_VDO1_0(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo1_0_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VDO1_1(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo1_1_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VDO1_2(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo1_2_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VDO1_3(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo1_3_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VDO1_4(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo1_4_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+#define GATE_VDO1_5(_id, _parent, _shift)                      \
+	GATE_FLAGS(_id, _parent, &vdo1_5_cg_regs, _shift, \
+		       CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
+
+static const struct mtk_gate vdo1_clks[] = {
+	/* VDO1_0 */
+	GATE_VDO1_0(CLK_VDO1_SMI_LARB2, CLK_TOP_VPP, 0),
+	GATE_VDO1_0(CLK_VDO1_SMI_LARB3, CLK_TOP_VPP, 1),
+	GATE_VDO1_0(CLK_VDO1_GALS, CLK_TOP_VPP, 2),
+	GATE_VDO1_0(CLK_VDO1_FAKE_ENG0, CLK_TOP_VPP, 3),
+	GATE_VDO1_0(CLK_VDO1_FAKE_ENG1, CLK_TOP_VPP, 4),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA0, CLK_TOP_VPP, 5),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA1, CLK_TOP_VPP, 6),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA2, CLK_TOP_VPP, 7),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA3, CLK_TOP_VPP, 8),
+	GATE_VDO1_0(CLK_VDO1_VPP_MERGE0, CLK_TOP_VPP, 9),
+	GATE_VDO1_0(CLK_VDO1_VPP_MERGE1, CLK_TOP_VPP, 10),
+	GATE_VDO1_0(CLK_VDO1_VPP_MERGE2, CLK_TOP_VPP, 11),
+	/* VDO1_1 */
+	GATE_VDO1_1(CLK_VDO1_VPP_MERGE3, CLK_TOP_VPP, 0),
+	GATE_VDO1_1(CLK_VDO1_VPP_MERGE4, CLK_TOP_VPP, 1),
+	GATE_VDO1_1(CLK_VDO1_VPP2_TO_VDO1_DL_ASYNC, CLK_TOP_VPP, 2),
+	GATE_VDO1_1(CLK_VDO1_VPP3_TO_VDO1_DL_ASYNC, CLK_TOP_VPP, 3),
+	GATE_VDO1_1(CLK_VDO1_DISP_MUTEX, CLK_TOP_VPP, 4),
+	GATE_VDO1_1(CLK_VDO1_MDP_RDMA4, CLK_TOP_VPP, 5),
+	GATE_VDO1_1(CLK_VDO1_MDP_RDMA5, CLK_TOP_VPP, 6),
+	GATE_VDO1_1(CLK_VDO1_MDP_RDMA6, CLK_TOP_VPP, 7),
+	GATE_VDO1_1(CLK_VDO1_MDP_RDMA7, CLK_TOP_VPP, 8),
+	GATE_VDO1_1(CLK_VDO1_DP_INTF0_MMCK, CLK_TOP_VPP, 9),
+	GATE_VDO1_1(CLK_VDO1_DPI0_MM, CLK_TOP_VPP, 10),
+	GATE_VDO1_1(CLK_VDO1_DPI1_MM, CLK_TOP_VPP, 11),
+	GATE_VDO1_1(CLK_VDO1_MERGE0_DL_ASYNC, CLK_TOP_VPP, 13),
+	GATE_VDO1_1(CLK_VDO1_MERGE1_DL_ASYNC, CLK_TOP_VPP, 14),
+	GATE_VDO1_1(CLK_VDO1_MERGE2_DL_ASYNC, CLK_TOP_VPP, 15),
+	GATE_VDO1_1(CLK_VDO1_MERGE3_DL_ASYNC, CLK_TOP_VPP, 16),
+	GATE_VDO1_1(CLK_VDO1_MERGE4_DL_ASYNC, CLK_TOP_VPP, 17),
+	GATE_VDO1_1(CLK_VDO1_DSC_VDO1_DL_ASYNC, CLK_TOP_VPP, 18),
+	GATE_VDO1_1(CLK_VDO1_MERGE_VDO1_DL_ASYNC, CLK_TOP_VPP, 19),
+	GATE_VDO1_1(CLK_VDO1_PADDING0, CLK_TOP_VPP, 20),
+	GATE_VDO1_1(CLK_VDO1_PADDING1, CLK_TOP_VPP, 21),
+	GATE_VDO1_1(CLK_VDO1_PADDING2, CLK_TOP_VPP, 22),
+	GATE_VDO1_1(CLK_VDO1_PADDING3, CLK_TOP_VPP, 23),
+	GATE_VDO1_1(CLK_VDO1_PADDING4, CLK_TOP_VPP, 24),
+	GATE_VDO1_1(CLK_VDO1_PADDING5, CLK_TOP_VPP, 25),
+	GATE_VDO1_1(CLK_VDO1_PADDING6, CLK_TOP_VPP, 26),
+	GATE_VDO1_1(CLK_VDO1_PADDING7, CLK_TOP_VPP, 27),
+	GATE_VDO1_1(CLK_VDO1_DISP_RSZ0, CLK_TOP_VPP, 28),
+	GATE_VDO1_1(CLK_VDO1_DISP_RSZ1, CLK_TOP_VPP, 29),
+	GATE_VDO1_1(CLK_VDO1_DISP_RSZ2, CLK_TOP_VPP, 30),
+	GATE_VDO1_1(CLK_VDO1_DISP_RSZ3, CLK_TOP_VPP, 31),
+	/* VDO1_2 */
+	GATE_VDO1_2(CLK_VDO1_HDR_VDO_FE0, CLK_TOP_VPP, 0),
+	GATE_VDO1_2(CLK_VDO1_HDR_GFX_FE0, CLK_TOP_VPP, 1),
+	GATE_VDO1_2(CLK_VDO1_HDR_VDO_BE, CLK_TOP_VPP, 2),
+	GATE_VDO1_2(CLK_VDO1_HDR_VDO_FE1, CLK_TOP_VPP, 16),
+	GATE_VDO1_2(CLK_VDO1_HDR_GFX_FE1, CLK_TOP_VPP, 17),
+	GATE_VDO1_2(CLK_VDO1_DISP_MIXER, CLK_TOP_VPP, 18),
+	GATE_VDO1_2(CLK_VDO1_HDR_VDO_FE0_DL_ASYNC, CLK_TOP_VPP, 19),
+	GATE_VDO1_2(CLK_VDO1_HDR_VDO_FE1_DL_ASYNC, CLK_TOP_VPP, 20),
+	GATE_VDO1_2(CLK_VDO1_HDR_GFX_FE0_DL_ASYNC, CLK_TOP_VPP, 21),
+	GATE_VDO1_2(CLK_VDO1_HDR_GFX_FE1_DL_ASYNC, CLK_TOP_VPP, 22),
+	GATE_VDO1_2(CLK_VDO1_HDR_VDO_BE_DL_ASYNC, CLK_TOP_VPP, 23),
+	/* VDO1_3 */
+	GATE_VDO1_3(CLK_VDO1_DPI0, CLK_TOP_VPP, 0),
+	GATE_VDO1_3(CLK_VDO1_DISP_MONITOR_DPI0, CLK_TOP_VPP, 1),
+	GATE_VDO1_3(CLK_VDO1_DPI1, CLK_TOP_VPP, 8),
+	GATE_VDO1_3(CLK_VDO1_DISP_MONITOR_DPI1, CLK_TOP_VPP, 9),
+	GATE_VDO1_3(CLK_VDO1_DPINTF, CLK_TOP_VPP, 16),
+	GATE_VDO1_3(CLK_VDO1_DISP_MONITOR_DPINTF, CLK_TOP_VPP, 17),
+	/* VDO1_4 */
+	GATE_VDO1_4(CLK_VDO1_26M_SLOW, CLK_PAD_CLK26M, 8),
+	/* VDO1_5 */
+	GATE_VDO1_5(CLK_VDO1_DPI1_HDMI, CLK_TOP_VPP, 0),
+};
+
 static const struct mtk_clk_tree mt8188_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -1697,6 +2055,10 @@ MTK_GATE_CLK_DATA(pericfg_ao_clks);
 MTK_GATE_CLK_DATA(imp_iic_wrap_c_clks);
 MTK_GATE_CLK_DATA(imp_iic_wrap_w_clks);
 MTK_GATE_CLK_DATA(imp_iic_wrap_en_clks);
+MTK_GATE_CLK_DATA(vpp0_clks);
+MTK_GATE_CLK_DATA(vpp1_clks);
+MTK_GATE_CLK_DATA(vdo0_clks);
+MTK_GATE_CLK_DATA(vdo1_clks);
 
 static const struct udevice_id of_match_mt8188_clk_gate[] = {
 	{
@@ -1719,6 +2081,22 @@ static const struct udevice_id of_match_mt8188_clk_gate[] = {
 		.compatible = "mediatek,mt8188-imp-iic-wrap-en",
 		.data = (ulong)&imp_iic_wrap_en_clks_data
 	},
+	{
+		.compatible = "mediatek,mt8188-vppsys0",
+		.data = (ulong)&vpp0_clks_data
+	},
+	{
+		.compatible = "mediatek,mt8188-vppsys1",
+		.data = (ulong)&vpp1_clks_data
+	},
+	{
+		.compatible = "mediatek,mt8188-vdosys0",
+		.data = (ulong)&vdo0_clks_data
+	},
+	{
+		.compatible = "mediatek,mt8188-vdosys1",
+		.data = (ulong)&vdo1_clks_data
+	},
 	{ }
 };
 

---
base-commit: b5fca5f601e5da4955a3ab815f614e1a1300ec2b
change-id: 20260710-mt8188-add-clk-add-display-related-clocks-02b34af99fd8
prerequisite-message-id: 20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com
prerequisite-patch-id: 68c5aa18eb36d10d12334abef330b86144eaed7a
prerequisite-patch-id: 853ec3fbe33d04e38871f5f156b90a1d1a4cb09f
prerequisite-patch-id: 7fe98e35927153e3e19744492104107aaec498a5
prerequisite-patch-id: 49d38765dc53011d25a98f041ce93d6dce251b77
prerequisite-patch-id: 48eeae79a82161dcda5b59bb07d940709a55ab6f
prerequisite-patch-id: 9af855a2db85b152e48d888d412cd3fbd75b0f9a
prerequisite-patch-id: a6efe0d0069974bbb5c9cf0d7a076faa3f7e13bb
prerequisite-patch-id: dc7618afdc12543fbaafd1562abd2deafeeea576
prerequisite-patch-id: fbf72c0f0314129e23334d2faa8187808285232e

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

