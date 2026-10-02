Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA84CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A211081367;
	Fri,  2 Oct 2026 14:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0mF-vBLV_hX; Fri,  2 Oct 2026 14:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4A99481355
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949701;
	b=LO2LSxHEiGKrc3PKsatL2gNCR3scz0P+wKyYdTMujoxRjsQ5pSvXaUYl5qS8YPJEehqA
	 22Yp4M0LNq2Ksr33xNpGEPZhsHydTiLn8u9Cua8Mb1KYLtgq8jCMFIw/91hmzL0VKbpSx
	 VVdxhwZPP5kRgRCbzYwxXIiyw8OwDa/DW/jUMCl+FSKT0GUSTzHS6AIwk9EkpiMZf7u0Q
	 57NajivQjnQdpFWyCfO4qLgR9ssX4PN4dCELjqdGXrYYKC5hc0CP2ryvOui3CGbDsf4tC
	 Uu4ShCvZyVowKXpCTbz6GDhITlVRXeeZgY6jo6+ZR++mxpvudbF+kLgxY+G0Z9BF/qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9ZYZQ4ZK+NAQzNEVmwI7x0sg0RKtQ2t3IUDQzMxLmnw=;
	b=NDbUKPU9Do08Ytmz/8+sg5DLKWJSCp0TLsBMoElWh+5W5XrfZX6ohkneaQ76mNFKY66r
	 JO2lYVs4trRVZRMRWDodanr4Sa7Gn3UrHA0V34DAFlsUk7j9aauXmJihrPNivnL/EqsyV
	 6nS5Cubk6yn1PwfMNnARHMbfymBPcLQUn1Rhy67EbtQaY78vgT5ySxtW2bDGr7LENJyKt
	 y0XLgqbjQCyzVCuylC4WZP/jvUjK/NhSqf6lQLzAc5MnPd0RQqqlRP2R9ah05J1PcNjbH
	 G5m140F2xRZ9oAXC4p7NqmD8hO4SmGjrG+66sLiKbHdbi7zYCTGZjxXfLgZ+JUvbNrg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gwIu37U2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949701;
	bh=9ZYZQ4ZK+NAQzNEVmwI7x0sg0RKtQ2t3IUDQzMxLmnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HoV3ZeYnFIcDjcGKfo+DvyxaIAt72BUSAxu/qHurlNX2L2J50K96GoznyKiyOQ62f
	 0qxNGl7gEsa8MsrGQmk0yivdSlhDnWOApjgQx/T5+O7AGhDPfAJdQWvR3y86m0ubZj
	 WIdsMwLmYTbK56itGSQe+5iFA0alNsFWhNiaaADOPcDrwgruTTFugcZWkftD07BZBa
	 KXD7SxFMuD5HJdlhLPSGarbFos8u1sLHsSzd0uAEXI41yprZVfy/mvMdtkHWupATKh
	 I2SVHet5J0mGHdx3WT1m++lJ8C1zqvi/djRf0XUIkPdR4Qu7Er+9giSdMMR/R/8C/x
	 UNPHLivGBacoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A99481355;
	Fri,  2 Oct 2026 14:01:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 535DD2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3951681367
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QO1BwCE4j72l for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0600881324
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949696;
 b=enWHLivR/QcEjJehllA6wTevqnfjNC2xzYnjjZGE12vxR7ZLvlYLRBQoNs4DEnMTdhfv
 cUgYm1p6hue9hhqwX/XaTsKQabA+lDPh0sG6Z3uEPKX5Teamz/ZcUgn9fEWQskzUfbbK1
 kckDx5S702aKpYiEzbHCXB07LtIp2xgC3KlD9hcPwNnNZQxbNMgjcJUebX9vFxRTERm7E
 pvxTAKuesvPSYhlSSKX1e/JIO/9QKKhqkxJ7gijRM7KjNUbxQan7d6/kt8DbMLckw3c9H
 5XT4hQxTwl+grR2qhvXqJac4DURcK3QmRawnRbhgSGOBuRd7VyxUIUniPTwFtT6r1RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949696;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=9ZYZQ4ZK+NAQzNEVmwI7x0sg0RKtQ2t3IUDQzMxLmnw=;
 b=pkUbCa83TXhSQkL+ocXGxmL6xhMBeDgjWedcLpraBOFmuASFm+AprCit1mS1bF3jV1vp
 Oi6JR1ew4VCAN8K49ZcVKCAP0uWosx4KqQVxzz56DGYt77OiRws3oueKgIMRpKvzaNN0n
 6c1lMGl9DB++3M7ooDUyY7PhfTBkceS8SBmUDrs/6sRJkQOXVi0Ju/PW3yOmYJfw/KHL5
 1GkLW/Qz/S9FcZJWMM/1d7B2VCdn6DVrSsbb5SLgo8D+WjDjkl1keB+W1x3bw6UACB5L5
 BsedJHwtMMtqqFlCid4KCnhDz01khT+DFc5WFvAN7PJIccWLC2pdCOJKUNxtKMXIVTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gwIu37U2; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gwIu37U2
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0600881324
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:35 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so695665e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949694; x=1791554494;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ZYZQ4ZK+NAQzNEVmwI7x0sg0RKtQ2t3IUDQzMxLmnw=;
 b=gwIu37U2+MaIb+gAjp882yapobSA/p0OhLXpZCOxzOd0nNHDNrSYP+9pI/W0JX1SHB
 L5k5pqGjieAM/TKZbcJ+6NG+AyzvJcWC9trsjBWvIbiDapaZMvv4dTdWZi9X1tOv4SKi
 hC0gQF7nFEZD7aF7KhwBMUCRguWFXROS0At0n+drpaFHyhpaYBaxOfYA2/5jx5BPy3vb
 HfdfNjeMCl5ayN6Ksd1kD/UoaIdyu279w3WSWiD5FLxKSqcAN75kfr5PPxzazeiSJyfy
 UecDOGe+cv1YPxRVBKKhlK7baNbP2y70kdGKmE/pZprVd2pAruARglFjq+kT2WCiCeyB
 zsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949694; x=1791554494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ZYZQ4ZK+NAQzNEVmwI7x0sg0RKtQ2t3IUDQzMxLmnw=;
 b=ceTr7rdzlozZLV9M9a7/fSo45ErHvnAxjMjM5r6FZUwl4ZkPJ6KTU+3zFZpWLbSu6Z
 zvaFktQ4tc7vFy68DrtawLszjRb9HaEk16zAcoGpuL1RI6IXgaqKC3K7RZQkBcgkn2s4
 KtHYRgBKUm2TySzFSfcAnWHiRk2kmqFEnNmJ3RizNLuwOVP3XQ5tcuvNDmU/jhUnPdqT
 wk53di4LfV/DLsf5Pxiikp1lY+v7MWZevxv0QMjxcA5UFPaFJxZZczD5Desuqrk2dhXc
 0E1OvC01pG1EKBbKztXAZm8r0NDLZE88zLCFJmlBPRvMAq/nqlOX8a585sKFMRjO+4Gl
 42gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF0VEsqu2n3ErQR1sN5GDMO79IJ6R95atPBXgCOYobR2riNdlBa7LAanpmES18wHiaGh6F5yc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mVZlaRb6xNiV7H2BH0AEGkHg4HhC+FQEOQ9CrqYkpzeH0D6NQ1
 jG5refNnOSwiL91lwXdjXV3H0hk+n0y5vf66MS+ZzZW4jAGlE8EgdOVvDbtKPT2DyNM=
X-Gm-Gg: AYBFou1TzMYRRWEwMLd9QTfvCcBHejAUOFEYh2wrOfOtnyljkV9yDO/dHo854x2zFfa
 /4PXi9uqbEnCNH9mx/RQfe0Oe9mXkO6/0+68lrnOEF4z9v47BZu4bBdlnyU+syLM6y44l794UL4
 jrZB2+Hi7T/jYP11VPFoJ2a7slqLX2QRRicKSQShBN2Vfe6dWH33glhhQN6tdrdn9gCpxS3JmUu
 dvI7vTSDnSj2C2BkK0jwMPb6z6APFOaViWRag6ZWNGzaFntOuTh6a0YYF42ryM6KV59b62hSsZ9
 k0p7KcGEWSyuW0a3vbKL80MDjHSX13jsyI78pYNdVhX8MmqXuTczbfFWA6gZsdS24r4RfgGKWx8
 yVp0VIM/0XQyurzvU0tU7nHKMqnBk91NLzIOK/7WyI0fB/Uo5Jtp3EuzdRInpxbM1wuo2kTTKDk
 ugFW51gCg6ZkyTAN7EnozwWh09Fs7WT7dYRA9kSn33jWCazJ93IhI+14WkZHPGbp1rBzMaZkJCX
 fEAL7fKoktO4Z79y9ewkywEUWKDerk0nJNZrvPkSPMhv+//oowaFgiV8BbuIEsxDJnEQE2gneeE
 5wEVwMJylBp3XY1IKJdvlUkxAXWJpmJsvEvilV6zWdGtkIgcNcXvo5c=
X-Received: by 2002:a05:600c:3508:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-4a02744dcbemr53083425e9.0.1790949693591; 
 Fri, 02 Oct 2026 07:01:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:04:01 +0200
Subject: [PATCH v2 10/13] video: mediatek: mtk_disp_mutex: add the DSI pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-10-9e435457b90c@baylibre.com>
References: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
In-Reply-To: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

The mutex serialises the components of a pipeline on the same frame: it
holds the list of the modules started together and the source of the
start and end of frame signals driving them.

Extend the driver, so far only used by the MT8188 HDMI pipeline, with the
DSI pipeline of the MT8365 and the MT8366: the overlay to the DSI,
through the colour pipeline on the MT8365 and straight out of the rdma on
the MT8366. mtk_disp_mutex_ovl_dsi_enable() calls the SoC one,
mt8365_mutex_ovl_dsi_enable() or mt8366_mutex_ovl_dsi_enable(), and
fails on a mutex without a DSI pipeline.

Two compatibles are added, "mediatek,mt8365-disp-mutex" and
"mediatek,mt8366-disp-mutex". Neither node declares a generic fallback,
so both SoC specific strings have to be listed; they also differ in
the module indices, in the DSI0 module bit the MT8366 needs, and in the
shift of the end-of-frame selector (6 on the MT8365, 7 on the MT8366).

The MT8365 mutex has no clock of its own: as in Linux, a "no_clk" flag of
its driver data says so, and its probe then only maps the registers.

The driver includes <dm/device.h> and <dm/device_compat.h>, for the
dev_err() it now uses, instead of <dm.h>.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mutex.c | 133 ++++++++++++++++++++++++++++++--
 drivers/video/mediatek/mtk_disp_mutex.h |  11 +++
 2 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
index 571d4c8b672..af8e7032a01 100644
--- a/drivers/video/mediatek/mtk_disp_mutex.c
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -6,7 +6,10 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/read.h>
+#include <errno.h>
 #include <linux/bitops.h>
 
 #include "mtk_disp_comp.h"
@@ -16,8 +19,8 @@
  * Register layout of one mutex instance @id (as in the Linux mtk-mutex
  * driver): the block packs the per-mutex registers 0x20 apart. SOF holds
  * the start/end-of-frame source, MOD0/MOD1 the attached modules 0-31 and
- * 32-63. The offsets are index-based so a future DSI helper can drive a
- * different instance/controller.
+ * 32-63. The offsets are index-based so the HDMI and DSI helpers below can
+ * drive a different instance/controller each.
  */
 #define DISP_MUTEX_EN(id)	(0x20 + 0x20 * (id))
 #define MUTEX_EN			BIT(0)
@@ -48,6 +51,49 @@
 #define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
 #define MT8188_MUTEX_MOD_DISP1_DPI1		38
 
+/* The MT8365 and MT8366 DSI pipelines use instance 0 of the mmsys mutex */
+#define MUTEX_DSI_ID		0
+
+/* the MT8365 shifts the end-of-frame selector by 6 instead of 7 */
+#define MT8365_MUTEX_SOF_DSI0		1
+#define MT8365_MUTEX_EOF_DSI0		(MT8365_MUTEX_SOF_DSI0 << 6)
+
+#define MT8365_MUTEX_MOD_DISP_OVL0	7
+#define MT8365_MUTEX_MOD_DISP_RDMA0	9
+#define MT8365_MUTEX_MOD_DISP_COLOR0	12
+#define MT8365_MUTEX_MOD_DISP_CCORR	13
+#define MT8365_MUTEX_MOD_DISP_AAL	14
+#define MT8365_MUTEX_MOD_DISP_GAMMA	15
+#define MT8365_MUTEX_MOD_DISP_DITHER	16
+
+/* the MT8366 drives the DSI straight out of the rdma, without the PQ blocks */
+#define MT8366_MUTEX_SOF_DSI0		1
+#define MT8366_MUTEX_EOF_DSI0		(MT8366_MUTEX_SOF_DSI0 << 7)
+
+#define MT8366_MUTEX_MOD_DISP_OVL0	0
+#define MT8366_MUTEX_MOD_DISP_RDMA0	4
+#define MT8366_MUTEX_MOD_DISP_DSI0	13
+
+/**
+ * struct mtk_disp_mutex_data - per-SoC mutex data
+ * @ovl_dsi_enable: set up the mutex of the OVL -> DSI pipeline
+ * @no_clk: the mutex has no clock of its own
+ */
+struct mtk_disp_mutex_data {
+	void (*ovl_dsi_enable)(struct udevice *dev);
+	bool no_clk;
+};
+
+/**
+ * struct mtk_disp_mutex_priv - private data of a mutex
+ * @comp: common component state, must be the first member
+ * @data: per-SoC data, NULL on the SoCs without a DSI pipeline
+ */
+struct mtk_disp_mutex_priv {
+	struct mtk_disp_comp_priv comp;
+	const struct mtk_disp_mutex_data *data;
+};
+
 void mt8188_mutex_config_hdmi(struct udevice *dev)
 {
 	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_HDMI_ID),
@@ -65,8 +111,83 @@ void mt8188_mutex_config_hdmi(struct udevice *dev)
 	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_HDMI_ID), MUTEX_EN);
 }
 
+static void mt8365_mutex_ovl_dsi_enable(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_OVL0) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_RDMA0) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_COLOR0) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_CCORR) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_AAL) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_GAMMA) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_DITHER));
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
+			    MT8365_MUTEX_EOF_DSI0 | MT8365_MUTEX_SOF_DSI0);
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
+}
+
+static void mt8366_mutex_ovl_dsi_enable(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
+			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_OVL0) |
+			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_RDMA0) |
+			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_DSI0));
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
+			    MT8366_MUTEX_EOF_DSI0 | MT8366_MUTEX_SOF_DSI0);
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
+}
+
+static const struct mtk_disp_mutex_data mt8365_mutex_data = {
+	.ovl_dsi_enable = mt8365_mutex_ovl_dsi_enable,
+	.no_clk = true,
+};
+
+static const struct mtk_disp_mutex_data mt8366_mutex_data = {
+	.ovl_dsi_enable = mt8366_mutex_ovl_dsi_enable,
+};
+
+int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
+{
+	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
+
+	if (!mutex->data) {
+		dev_err(dev, "no DSI pipeline on this mutex\n");
+		return -EOPNOTSUPP;
+	}
+
+	mutex->data->ovl_dsi_enable(dev);
+
+	return 0;
+}
+
+static int mtk_disp_mutex_probe(struct udevice *dev)
+{
+	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
+
+	/* the HDMI pipeline needs no per-SoC data */
+	mutex->data = (const struct mtk_disp_mutex_data *)dev_get_driver_data(dev);
+
+	if (mutex->data && mutex->data->no_clk) {
+		mutex->comp.base = dev_remap_addr(dev);
+
+		return mutex->comp.base ? 0 : -EINVAL;
+	}
+
+	return mtk_disp_comp_probe(dev);
+}
+
 static const struct udevice_id mtk_disp_mutex_ids[] = {
-	{ .compatible = "mediatek,mt8188-disp-mutex" },
+	{
+		.compatible = "mediatek,mt8188-disp-mutex",
+	},
+	{
+		.compatible = "mediatek,mt8365-disp-mutex",
+		.data = (ulong)&mt8365_mutex_data,
+	},
+	{
+		.compatible = "mediatek,mt8366-disp-mutex",
+		.data = (ulong)&mt8366_mutex_data,
+	},
 	{ }
 };
 
@@ -74,6 +195,6 @@ U_BOOT_DRIVER(mtk_disp_mutex) = {
 	.name	   = "mtk_disp_mutex",
 	.id	   = UCLASS_MISC,
 	.of_match  = mtk_disp_mutex_ids,
-	.probe	   = mtk_disp_comp_probe,
-	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+	.probe	   = mtk_disp_mutex_probe,
+	.priv_auto = sizeof(struct mtk_disp_mutex_priv),
 };
diff --git a/drivers/video/mediatek/mtk_disp_mutex.h b/drivers/video/mediatek/mtk_disp_mutex.h
index 6b2c8863a20..3b97c7020a2 100644
--- a/drivers/video/mediatek/mtk_disp_mutex.h
+++ b/drivers/video/mediatek/mtk_disp_mutex.h
@@ -18,4 +18,15 @@ struct udevice;
  */
 void mt8188_mutex_config_hdmi(struct udevice *dev);
 
+/**
+ * mtk_disp_mutex_ovl_dsi_enable() - set up the mutex of the DSI pipeline
+ * @dev: mmsys mutex device
+ *
+ * Put all the components of the OVL -> DSI pipeline under one mutex
+ * instance, and start and end their frames on the DSI ones.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the mutex has no DSI pipeline
+ */
+int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev);
+
 #endif /* _MTK_DISP_MUTEX_H */

-- 
2.55.0

