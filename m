Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245E2C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1CD880FA9;
	Wed,  2 Sep 2026 14:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANpPMaE_BehM; Wed,  2 Sep 2026 14:17:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358606;
	bh=E/0zfH+b/PORYmHDK+GsBzrZ+B993FwrMyo2sncncqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FHGjBjAokbFF8v3rjGN1Z+jbwCJNbO8HkCMzEn59TF0zpxkvgZ+rucNU1GtyUNo4/
	 pJ1n10mSUEmRKvr6s5F0GCF7rB6gFDiu3I1S6AErkQ2g6aYMLb8r2QGB/SwB8bV7dl
	 8CTOIgf3OFLnYeP/xETnkaUjXUXfTddooayJZC9ryJTIwZ/ZahawxP5BHWacXc/pmN
	 KdoHS8/lnAwhpb5AaQW0b0kYFYjDT3e0aHHrqf2UfOjnUqv8bktrcdTTECXcz6yGIT
	 g9+wF83wb4nAPfm2BzofVjTx3Gz+DpM3gg1md4vuV61MxH90dyzuJsEYyWA1q/qK0L
	 HNIJ9T/I5whhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 981E680F6B;
	Wed,  2 Sep 2026 14:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF7BB465
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3DFE80FA9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KdPUKpvvwdsT for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NyU2hqdn
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 395CD80F59
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:31 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-482f9309813so1115928f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358590; x=1788963390;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E/0zfH+b/PORYmHDK+GsBzrZ+B993FwrMyo2sncncqU=;
 b=NyU2hqdn8N9GzLQoHX4X8iBHMKXYzsxR130OxFzcJVpKnv2ZqfEjH0LnQiE1dD40kZ
 IVdlfpTMcrqsX2WHOLO82zJR2DZWBEAEwf6AVNT+jrkj46B61nLYmi0CuELBth9osn19
 quVTNl/saihKcvEBzWqjM58ZzH3IGksYxWMaWQxfKodPVDSHkHdovLKy9w0FksRREibC
 QgMMmBSn8ax+WJLlfZC6LWTLwD+d5n39HoGdk2sBgCsBt9UeFM+qV6oiBVaxfPoXKe41
 6vJgHTvSynXm0d8I/DZkVVwsaEGvU1f6gJVJme6g0KTvI64uG8/17I1zftCYJYTS3vLR
 tE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358590; x=1788963390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E/0zfH+b/PORYmHDK+GsBzrZ+B993FwrMyo2sncncqU=;
 b=UDWrV730YZSXYeFpUice7YJhHgl1a8wpLggpKWh0a6KUiyAxpuRnEbZ7X3jOWSWkER
 aqgzACfrV6bboN/Y2rH/X9Gg/PUR1tAqbvAGlW/sFG/LOKJeVRys0PcyHKRL261l61ms
 xbLs8lHCCHKD85DypfOnVhJVuQvH6llh9YHSn9Ez/ZZ8CwUNuTwnnQt3z79wZJdnEvtt
 dkzbwYCzwN6unnujXD8GAUfdMP4yVQmm5sNIqui2yND6iNqjukRRMT4eOSbJU12+f5F/
 WtCdFG2rX3txHvP/3WMIWZv26I32ShPcjZFv5pgFhtZ3phvWogPv4Pd6UzZc4ryfRGu8
 BM0Q==
X-Gm-Message-State: AFuF++luOeh45Mjq3sTUZq8YtV5I+5IKQ/uysQMtKW64fSQe12D8WYWV
 a+1XWi8qDjqhK250qQniWRq7Fi9FO8lUfcs5X0F184vj1QEZs1xGSw0kx//Lskq8r6o=
X-Gm-Gg: AYBFou2KYyto55Oqr1KoEgJgQ4dUvUsNxatZAwPbC1B9b9/gGtJnm8bVfHSIJSfXmkb
 9xkCxeFlj3E0h2xeuB8QPX9uQ9Xe9sA3ISAuwnwTeCT8rDmSTaneYvLXaIr89bEy0ITcDlyMx94
 SmCbMRysz8fgx3z1JqGkFQzX/4WxaQyhOKWRuG9D7HRxuDkOW89/ZtYesALx0gUeQz4Tq+blrbD
 /8mGGfKG2CYKS3hgDutPm+/Hko703HNsAxtn0poD1bIAd+d+jdaJr2dNwIBeUYZfygFP+76q006
 qRnhTZJSXVRweWMzZUBQUzrIM16KPOGDikuZLshCT9gtRkKNIAUZtZueHjBwNvBHvN5bnO9GVCU
 AiHr0q7mz2Q+CoJ/rzogbOt1XvkJ66hW5a504prSrmoPO1PSbK4O6X7owptTWkUmNuLz2x63Gu0
 IAktrnc0PEKCKbrLhYDqivgdS2LyHJLx1kRKWqwhiVw06CgM9ELBfCgX0YXBLfzl2ADOVMEZt3S
 +/5tHcMpAAf+IlK/lD7aEx6PInEVlJfBMPZiO7uIhyZ6k2uBg6p8tquOug0+/gtrxpQoKf4TzJU
 oqT+6OAVxalzVOhtib1QJaQJi9o7ZRiHjUaL8N2AsdvY3g==
X-Received: by 2002:a5d:5f45:0:b0:47f:c648:e280 with SMTP id
 ffacd0b85a97d-484913b8052mr9121610f8f.18.1788358589840; 
 Wed, 02 Sep 2026 07:16:29 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:15:57 +0200
Subject: [PATCH v4 07/14] video: mediatek: add smi larb driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-7-7c3b4f068a56@baylibre.com>
References: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
In-Reply-To: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
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

The SMI local arbiters (larbs) gate a subsystem's access to DRAM. On the
MT8188 the display data path feeds through the VDO1 larbs (larb2 and
larb3), whose clocks must be ungated for the HDMI pipeline to reach the
framebuffer.

There is no dedicated SMI larb driver upstream, as Linux handles the
larbs through its SMI/IOMMU framework. Add a minimal U-Boot driver that
binds the "mediatek,mt8188-smi-larb" nodes and ungates their clocks,
reusing the display pipeline component helpers for the register window
and clock bulk.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_smi_larb.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/mediatek/mtk_smi_larb.c b/drivers/video/mediatek/mtk_smi_larb.c
new file mode 100644
index 00000000000..9e4440ce294
--- /dev/null
+++ b/drivers/video/mediatek/mtk_smi_larb.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek SMI local arbiter (larb) driver
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+
+/*
+ * The SMI larbs gate a subsystem's access to DRAM. They have no dedicated
+ * driver upstream (the SMI/IOMMU framework handles them), so bind a minimal
+ * driver that just ungates their clocks, reusing the display component
+ * helpers for the register window and clock bulk.
+ */
+static const struct udevice_id mtk_smi_larb_ids[] = {
+	{ .compatible = "mediatek,mt8188-smi-larb" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_smi_larb) = {
+	.name	   = "mtk_smi_larb",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_smi_larb_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};

-- 
2.55.0

