Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF7C624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17E406077E;
	Tue,  1 Sep 2026 14:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NZRQ9o4lkX58; Tue,  1 Sep 2026 14:39:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273542;
	bh=E/0zfH+b/PORYmHDK+GsBzrZ+B993FwrMyo2sncncqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ypc9oE1SHANB5GaPi3gFa3wgkJkjQ88weCXqMCNgCpxulSSLiu4vUxOM9oSIW37sZ
	 ZJQDDnx2NMOlDMdGykUPdEXrAoTXsnzpEnCIOVB68psIgkDoiR3JjKhUjdQtf/XX9J
	 ZpWgPZ7OYNosA7qctFxjNV258ss+k0BWu+Q9Ln9yvObbQT5ztg8dkOB1J/SqN0Fptl
	 Cgbjuy2FTuU1Y43ijNrpsDAjZphMQuTcZ4EewSRYYmXptRGcNx23CBMEV3HQtC0Mgz
	 /XO4Fn2vAagpIK+TpfdSBu6T1trlx1gG7kOTlprEjGbGaJNyKINtsni0Nw8uGdp2XG
	 tbOfr23t6l3Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EBD460765;
	Tue,  1 Sep 2026 14:39:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24098279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DC6460766
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eghgBsxCEtGv for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dQTb0qvQ
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA1C260743
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-484415c8bf2so683010f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273534; x=1788878334;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E/0zfH+b/PORYmHDK+GsBzrZ+B993FwrMyo2sncncqU=;
 b=dQTb0qvQZSAZSUMhVU+XQ4RAn2Awvcj9X3ZpZbnYmNR7w7C8k6KnQvF81XZUG9/ubq
 kcA9+YgTcdG45+qNJ99moCKmU4cmg75Htixy3RMz6/q4qPRr2JW7BuLrpfkdOWTQU8Hd
 Cler1mO4jVlKVqEJp7WnVZrPHatBtdmSWKO+S9w8fVuLuOu5kPlFa4gmzdf1u4/Ju88B
 B2Hd5BDgh5qUCcgxvH46v+fWGstZejREL4+y09ZTEylo3BoO5Zp+xdelQvylNe6L9U+8
 P/7sjUhRfNGV9TK25paGNwfksgYV3K4O55ZTXtk+hwOu4EYEVUaQcQNWewb0nqPWGdsr
 b4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273534; x=1788878334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E/0zfH+b/PORYmHDK+GsBzrZ+B993FwrMyo2sncncqU=;
 b=WDK2ZhMoy/kfsA6WRtwruKtMCZbe32OH7mFlvIAGqcHJnQVx4csXxdgHjCnWdLluYX
 NiJvaorJ4WfEbE9n5AFTy92NEQejrpQCyWauXZdQpTNCT7clYNDzeGq3AZaVENE5Cdyr
 Ct8xu6afDV939ZguEGjCJk5nBr8KqHKsauUDgdUB2BJ+n/g+84DZQxUkIjsgxAvz5bHE
 UeKZMRJW9RKEtAojhaADELkPwHXvEkMeQaQ4PUjkM+CVsQtbSgqfHxDBvJ5KdWX96R3T
 KvKFx6ZYVZnjwMWfEQ0ArQgeqBA0aOSFH9ufVvGYfijvkK9ja5zqDEdKUJ4vlqHwGqjH
 tZRA==
X-Gm-Message-State: AFuF++kAuEnszFXK6/c+C0OgYiDvwrnWN5dDysHs8iKuODPs3BDgeG32
 oY5iQ9pwtDYe9qNC7l8r5fCl+tEWtQC3smW5gWw+WYZKiJOf6WKsUwdbevYGA0XNKhM=
X-Gm-Gg: AR+sD13wPfMk5gEZWZ925THCqAPRCMkJl7IE0uhXEqXXmQ/FiTX2pjlfkx7IY+dXAmh
 k0sv9sb5sQa+V2RPccuE6MsZNA2sxeTMF8LEaQaSWPKWffEBSihgLxF/FRXj7yKIPRpTHvLdj7C
 aXvc6TZu2ceTP6W1Mkqk/dnmzUG2iTYMV+3UB6DC/HZE2bIZBSw8pxPPKvka1ArwqMkYogu0lGP
 ySCcQoBj8xONnwc3Q6K/ebWZd6Bp1d9gyQYeTjbkKmtDqUnvl2HeN+3ZE7NuMemMW+jWGZ+rNbv
 j0+1ubf4tjstVuyYLXMUzo+bH5yu/PPNMWKPv3BZX/ikagovagwdyDHlMPr5rl6/v9IUpIISELl
 ErPNZ46Q8uqifNEwO6srmm3YqVfcxUCBle1xYI8ltr2VbKcfoTw/OVBnbjLdiGmx48+P1w3eQQM
 W0oR/nwQdxKqDDrrWzqo6kVvCR718rvdtLLUDyDZzupKA1VycHEnoo3Z/1vuzikbB+iUybUExvg
 BiAR5ZKRtvMX1jC3IrPVldf8GLX3zjIarHD4PfjPMBBQJL7dlvsJweOo8oy5GzGh+6d4AnCqNTg
 PRe7US5z/obzcEjGOuDfos1E/pe54zZtVYgJKk1kHXMcS4u6P9ELRoM=
X-Received: by 2002:a05:600c:3145:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-49b91c44f6cmr523034745e9.10.1788273532800; 
 Tue, 01 Sep 2026 07:38:52 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:53 +0200
Subject: [PATCH v3 07/14] video: mediatek: add smi larb driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-7-38194a531b9f@baylibre.com>
References: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
In-Reply-To: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
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

