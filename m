Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACF7CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F05C360D69;
	Fri,  2 Oct 2026 13:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d2NzbSmrwNB2; Fri,  2 Oct 2026 13:23:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D93CF60C2B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947384;
	b=iOZBnNU5O/aVKoYkt8GvSyyRgf8ZoR14Gxjs1qFhds4ITOzg/V75eh6zDsBXTvRAF4g5
	 Izh4zNYtHJP9KEsznqU4Uii2UFCmmQs0xjtYnYOXaYN7OE5lym8m64JFal1oMdLx7eNFW
	 1yeV40IDbt63ifVbVscOnDlKbjX9+Y7nFBFkDm8+t4x8Na1aPB9p/p2DnCFnWLU5ms3Ec
	 olJJaIGd7PRlzsxaIirmDLk+JpE62cUgbS6E7uuvjf0EaYmMXQeD5ewhQqCuS3GU3QDTW
	 zffYitsD6YWV4Dhx+JQJC6AdkNvm1d12cCqADUxjGMQNMOM5FLksJRJR8K0NG8Zkecw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kFUVYwFTO4+/3IKw9DHwNwmXh4H0LqBDbW8HxttV0SQ=;
	b=SCvYE3aXkWuF8Xr2W/Wco6JwFJSCNzYGA/Q2kvPEZTOGwZ4jSR3qbjPxZAK5w/bcHWa0
	 KmeLN/Y2goITaHgpPqAAuautpFuR0ND0RDCIem9CnxS5T0/U5BqI+H0j2GgJp04rckmOQ
	 IrF9zjIDYzT9qak5K9lasLyF5esRGm4kaDLaV2o9BrFugev2H2vLZrtUyUUaPZzNUuI+u
	 DLEgJemTQ+OAxPT7571OVCfyk9Xp0rig7oSC+AvYlsqcN3sHKrqVM/wzsaBJTdRmV3v9/
	 u9PtBDjRZDqqHCWrn+4KF4FfYePiYTuBdKx+vyzHrUwIhAXFpfIFuZdpbOAU1W11Ktw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HQLDYfrj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947384;
	bh=kFUVYwFTO4+/3IKw9DHwNwmXh4H0LqBDbW8HxttV0SQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eYaIxOh5Avnun+6H74pkcRUp/ki/7KsGSWH/ZHI7nxtkC1ZIUBUv75CorxVwhSes2
	 CCp2MtcofptHwq8jVM9pxqWlb4OccnYUtsru/m62NAikUFGq/dTC9dBdRGXB5UpUSN
	 fBNinqhEB7ZVq05riPw+qXL85REBGQyQ4qHh851bXWlz98qmF3TopxJmB0cDxBkskj
	 CUmRmhnMZZfNCjshcc54LY/Ofvzqu/2UtEM4ewIi8SmbwhQOvdEWsbos+uLB0bVEZn
	 vE6WjAfeQWyaVZIP5IXneBBJK67LPgmFBfb32Ki6cqD69XrMF1jmfNMNdekDVWeRvg
	 lWjTCt/f3saSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D93CF60C2B;
	Fri,  2 Oct 2026 13:23:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 028A1435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD4BB60B5E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfIC8gicV-W7 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 98B2B6069A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947378;
 b=bdSDFnbBvUSEwnN+vUdbd7UzA7ExoRljvxyvV5h+fUoxWQ3DNV7UTf5+MDfYdoVxE1Xf
 KU1QzREXW3Box0t0Z9MmFSVq6LPiKylYuyntcWMxGrdGXNHNLeeLpbwdAStWCAeqrr62Q
 XHv4pRs6gNVru7xs8iMBG+F1V0RGcBlBwsTK9NUJKVeb0DAYqKhhZ53OjGurAKENW3whl
 RiqErRxeruXPOR9EaNweLwf26Vw8feMjNuD1BZjiS1p4FV0hiz7+yXOqhzk7d3O2QNy/s
 opNXjE8LRdQCjjhYQFiNZ3mWBYK5xT/5Sn2D4dxxbRaUvkcA7md9ldwjgz0+MOkLNUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947378;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=kFUVYwFTO4+/3IKw9DHwNwmXh4H0LqBDbW8HxttV0SQ=;
 b=TRMcWLEKzc4KYvtK8M8g9WlWj+3GYBLbWYl7lRk3El9Z4mqPnat/tLNkcIavyhwxhnBy
 fj7Ow0ilWVXd5G8Bea8i7D0wzRBE2mdkPjGoJxOnZf5h74Gzjv7NlH9wHCSDsPOrGA9a9
 XL3cSuJRCHt0a4/AKUCJxp1maJ9ztQ38h8WjtQ4h2+HqeozO2Wd0bEdJ4muIhbWL1/C9K
 cv9/w4kRO6953Xgna6GfOWKiLTxNfwwUnvy4IDIL/F+mlD4YJF1MhWuVMN8S3sWa5Bjfv
 5djdQHzTZlpGWmw9EJvwgqQcow3yUOulDWxjHymDvzDTwISPNK9L/TSvLrAgH6EWh+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HQLDYfrj; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HQLDYfrj
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98B2B6069A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:57 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b0f4efe31so1066491f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947375; x=1791552175;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFUVYwFTO4+/3IKw9DHwNwmXh4H0LqBDbW8HxttV0SQ=;
 b=HQLDYfrj3yvzBr4V60e/PKcTzpAujZsb9ZXX77ATkRSyremq6L26gu4N5V8dgiA3oE
 FwOz1d1YchN3ZNjmAqjrsjRQnhK/alBTar/ftSdEWNtIQkhDz1C6GIzM1Aw7LzRglEjB
 KKcqcAMy0kMlSQD3C7T99DEb/0Q12SCVaNtRGDR7dyyVfbAMj3mKl48YuLAqyJN3q2hf
 ++VDs8ou7vKZ2thNsyykxlB7e9ws96Q9B7PVfZxpMboKOZkTctWn0s4SOEQXb4Va3nwA
 cMQ9JA64W62avwyt8mKSg2SqDJSd5xjm3XYxH1HF+EX1JfBDIJ6bPt9DCg5RWHsy7cth
 M2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947375; x=1791552175;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kFUVYwFTO4+/3IKw9DHwNwmXh4H0LqBDbW8HxttV0SQ=;
 b=na1Nt97vAOPb6DfbRvxOK/acSIWA8rSEIa1K4uBz7EorB8NSjGBzd5P1WU2VKxtVnS
 /mJSAUNRP3n454Z4XZVdwybNoMxZ+p6tfAE2+9T3iCDz1iL1/wvHDXeNVA1LuSlTEpwb
 YsbAzN9GuvHFSbsDTEw7SsCiaRNBmQrI5DUUxElKjoGenLOxZwEZsfHT9Vindc011uJa
 IgISae6DsV5ZmgFV4f8emz34yQZKQsx6Pzwub7PDrB715L6dj+782kFbJgFNvCpflW9l
 ntXj2o7SKX2xyJKIRtaNUJxo1IfnsFYmUKg69UqOGgURYZghPmKW2LExwh9SWptK4ofa
 jKvw==
X-Gm-Message-State: AFq9FYLaXdogF9aJVRQEr8U+ri+53ad911d3iEizkvwdx4V9svW/sRIq
 vIujVg/h+CApWb4jj2Zo45EoIdQHoc4U/iD2J8esps8WmpruLgMUPCCZvw1STsPdvlc=
X-Gm-Gg: AYBFou3ZtdI0T7lH3ddK9bheDKH5cN92tpTINDqb3QFFbuLb3av1H+up+KA8bzKpqlY
 osPd34GVw/tjzN4W6NjYhQaw7eYJWtPKsCbGmyNmCTWjfPMsk5v9nYjhn7ziO6EQYJzWy8Jl2Tj
 UtnwRXL8nZIVdRGGlSG1gQ4C/PRh2Oruh0/Bvx/fZAoX/VcDcT/2TfBcwhNtl7+0tnhcZ85QFkd
 o/WnPEu51y0jy/Lq5xgT7ZJRKNk2w9Kcn+2AQ6NFp8UenhotAG8bY1jiA6Yp0Cb64/nzG4Qk5n4
 K28GOpz1SLJ6EEH5szxFHbMq9VyHpbMKDC/N7cAacJH/nj8JWLK0sNSl+RvLxrG2q7Jk/a1h8fN
 SLBGCxaX0A+bG+Xzs+skz7+iLfV88Bv+uF6lpuEw/c0Y+iCi1HBV9CbXXW8MDhI41QT7sbQ8csX
 yl4TXF07BtAZKECUxkNUWhPUgw+NfYPUn7Ao8taIOLtAj+GuMyfv/D249aQ0jAuQrxG1uA8WfVd
 CODMpgTVi7CWAUHfsir+XX1BOttIwMCdQvGwVZOW0U5CR6hx9XyQQ81OG0xUL1tjCZ+lPtxmblu
 zGMlaP0cbB0SuUzMvAu/NBp9ayT3fo+rcPWQr3+qSZm57QlA8MBDocI=
X-Received: by 2002:a05:6000:4553:b0:488:8751:e78e with SMTP id
 ffacd0b85a97d-48b1270e6e6mr3307680f8f.16.1790947375073; 
 Fri, 02 Oct 2026 06:22:55 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:22:54 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:39 +0200
Subject: [PATCH v8 05/12] video: mediatek: add merge component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-5-2a6de7cf2a88@baylibre.com>
References: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
In-Reply-To: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
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
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=7923;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=dfXwoJx9RJSuy1o7oLSgXI52ih77+Acg4+R6TSDzcS0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHWGUg58yB7TGLSd2GZDKx8jLF435bSRPPgFAHWBa/Mq8rH6bGCbzHkSLhRpQUEGu/xHjW7ywXs
 3TV4HIsjP/wY=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

The merge block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. With two inputs it combines
them side by side into one output; with a single input it only buffers
that input through its SRAMs.

A merge declaring "mediatek,merge-fifo-en" additionally uses both SRAMs
as a FIFO, which needs the DRAM latency thresholds to be programmed so
that the block does not underrun.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_merge.c | 155 ++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_merge.h |  49 ++++++++++
 2 files changed, 204 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_merge.c b/drivers/video/mediatek/mtk_disp_merge.c
new file mode 100644
index 00000000000..d7502c28a55
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_merge.h"
+
+#define DISP_REG_MERGE_CTRL		0x000
+#define MERGE_EN				1
+#define DISP_REG_MERGE_CFG_0		0x010
+#define DISP_REG_MERGE_CFG_1		0x014
+#define DISP_REG_MERGE_CFG_4		0x020
+#define DISP_REG_MERGE_CFG_10		0x038
+#define SWAP_MODE				0
+#define FLD_SWAP_MODE				GENMASK(4, 0)
+#define DISP_REG_MERGE_CFG_12		0x040
+#define CFG_10_10_1PI_2PO_BUF_MODE		6
+#define CFG_10_10_2PI_2PO_BUF_MODE		8
+#define CFG_11_10_1PI_2PO_MERGE			18
+#define FLD_CFG_MERGE_MODE			GENMASK(4, 0)
+#define DISP_REG_MERGE_CFG_24		0x070
+#define DISP_REG_MERGE_CFG_25		0x074
+#define DISP_REG_MERGE_CFG_26		0x078
+#define DISP_REG_MERGE_CFG_27		0x07c
+#define DISP_REG_MERGE_CFG_36		0x0a0
+#define ULTRA_EN				BIT(0)
+#define PREULTRA_EN				BIT(4)
+#define DISP_REG_MERGE_CFG_37		0x0a4
+/* BUFFER_MODE: 0 - no fifo, 1 - SRAM0, 2 - SRAM1, 3 - SRAM0 and SRAM1 */
+#define BUFFER_MODE				3
+#define FLD_BUFFER_MODE				GENMASK(1, 0)
+/*
+ * ultra threshold in units of pixels, the recommended values are
+ * 6 us and 8 us worth of pixels at 594 Mpixel/s.
+ */
+#define ULTRA_TH_LOW				(6 * 594)
+#define ULTRA_TH_HIGH				(8 * 594)
+#define DISP_REG_MERGE_CFG_40		0x0b0
+#define FLD_ULTRA_TH_LOW			GENMASK(15, 0)
+#define FLD_ULTRA_TH_HIGH			GENMASK(31, 16)
+#define PREULTRA_TH_LOW				(8 * 594)
+#define PREULTRA_TH_HIGH			(9 * 594)
+#define DISP_REG_MERGE_CFG_41		0x0b4
+#define FLD_PREULTRA_TH_LOW			GENMASK(15, 0)
+#define FLD_PREULTRA_TH_HIGH			GENMASK(31, 16)
+#define DISP_REG_MERGE_MUTE_0		0xf00
+
+/* CFG_30 (0x088, "12 bit lsb off") is not present in the upstream driver */
+#define DISP_REG_MERGE_CFG_30		0x088
+
+/*
+ * The DRAM latency thresholds that keep the merge from underrunning while it
+ * buffers a line through its SRAMs.
+ */
+static void mtk_disp_merge_fifo_setting(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_36,
+			    ULTRA_EN | PREULTRA_EN);
+	mtk_disp_comp_update(dev, DISP_REG_MERGE_CFG_37,
+			     FIELD_PREP(FLD_BUFFER_MODE, BUFFER_MODE),
+			     FLD_BUFFER_MODE);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_40,
+			    FIELD_PREP(FLD_ULTRA_TH_LOW, ULTRA_TH_LOW) |
+			    FIELD_PREP(FLD_ULTRA_TH_HIGH, ULTRA_TH_HIGH));
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_41,
+			    FIELD_PREP(FLD_PREULTRA_TH_LOW, PREULTRA_TH_LOW) |
+			    FIELD_PREP(FLD_PREULTRA_TH_HIGH,
+				       PREULTRA_TH_HIGH));
+}
+
+void mtk_disp_merge_config(struct udevice *dev, u16 l_w, u16 r_w, u16 h)
+{
+	struct mtk_disp_merge_priv *priv = dev_get_priv(dev);
+	u32 mode = CFG_10_10_1PI_2PO_BUF_MODE;
+
+	if (priv->fifo_en) {
+		mtk_disp_merge_fifo_setting(dev);
+		mode = CFG_10_10_2PI_2PO_BUF_MODE;
+	}
+
+	if (r_w)
+		mode = CFG_11_10_1PI_2PO_MERGE;
+
+	/* input 1 and input 2 sizes */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_0, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_1, h << 16 | r_w);
+
+	/* output size */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_4, h << 16 | (l_w + r_w));
+
+	/* no pixel/channel swap */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_10,
+			    FIELD_PREP(FLD_SWAP_MODE, SWAP_MODE));
+
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_12,
+			    FIELD_PREP(FLD_CFG_MERGE_MODE, mode));
+
+	/*
+	 * CFG_24 is the merge SRAM0 size and CFG_25 the SRAM1 size. In merge
+	 * mode input 1 goes to SRAM0 and input 2 to SRAM1; in buffer mode the
+	 * single input goes through SRAM0 and then SRAM1, so both hold it.
+	 */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_24, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_25,
+			    h << 16 | (r_w ? r_w : l_w));
+
+	/* merged sizes of inputs 1 and 2, only used in merge mode */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_26, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_27, h << 16 | r_w);
+
+	/* 12 bit lsb off */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_30, 0x0);
+
+	if (priv->mute_support)
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_MUTE_0, 0x0);
+
+	/* enable */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CTRL, MERGE_EN);
+}
+
+static int mtk_disp_merge_probe(struct udevice *dev)
+{
+	struct mtk_disp_merge_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	priv->fifo_en = dev_read_bool(dev, "mediatek,merge-fifo-en");
+	priv->mute_support = dev_read_bool(dev, "mediatek,merge-mute");
+
+	return 0;
+}
+
+static const struct udevice_id mtk_disp_merge_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-merge" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_merge) = {
+	.name	   = "mtk_disp_merge",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_merge_ids,
+	.probe	   = mtk_disp_merge_probe,
+	.priv_auto = sizeof(struct mtk_disp_merge_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_merge.h b/drivers/video/mediatek/mtk_disp_merge.h
new file mode 100644
index 00000000000..74ed5c6f5b1
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MERGE_H
+#define _MTK_DISP_MERGE_H
+
+#include <linux/types.h>
+
+#include "mtk_disp_comp.h"
+
+/**
+ * struct mtk_disp_merge_priv - private data of a merge component
+ * @comp: common component state, must be the first member: the shared
+ *	  component helpers cast the private data of every pipeline component
+ *	  to struct mtk_disp_comp_priv
+ * @fifo_en: buffer the input through the merge SRAMs, from the
+ *	     "mediatek,merge-fifo-en" property
+ * @mute_support: the merge has a mute control, from the
+ *		  "mediatek,merge-mute" property
+ */
+struct mtk_disp_merge_priv {
+	struct mtk_disp_comp_priv comp;
+	bool fifo_en;
+	bool mute_support;
+};
+
+/**
+ * mtk_disp_merge_config() - configure a merge component
+ * @dev: merge device
+ * @l_w: width of the left input
+ * @r_w: width of the right input, or 0 when there is none
+ * @h: height of both inputs
+ *
+ * With a right input the two inputs are merged side by side, otherwise the
+ * single input is only buffered through the merge SRAMs.
+ *
+ * A single input with no fifo just goes straight through, one pixel in and
+ * two out. The HDMI pipeline never takes that path (merge3 has a right input
+ * and merge5 declares mediatek,merge-fifo-en), so it is untested and only
+ * here for a future single-pixel user.
+ */
+void mtk_disp_merge_config(struct udevice *dev, u16 l_w, u16 r_w, u16 h);
+
+#endif /* _MTK_DISP_MERGE_H */

-- 
2.55.0

