Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5612FC624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82398811A0;
	Fri,  4 Sep 2026 13:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kP42Nv_d32fx; Fri,  4 Sep 2026 13:50:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD6648119F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529818;
	b=l2t9QuPXS0TfZZLLVwM9uatdj7wbBo0f6l94HY4QvUr5YT+VE1YXn0XxflNlCx241sUW
	 qDb6GHPV8Ca4S2crRN61UuIiFpgDAJnOvhPO7pBkN1cJkD5MdIQGKH4Ai1E4Dw9CXOLso
	 dNOIFoP9S9nOqnJ7HKzzCQJeLKPdCFdmiAQjZr3h8+Doub3PCdaSOQrO6LIWbj7RDxF3W
	 +OOgw7fdCZwXULfP8MB+JguObb0dZlV37hz4Nw2wKY6ThnukC35k26gAnnK2menNfJu01
	 ihW/WYOJuWQ5rh+KsHc8NYmuqRMvENtZd/cu4r48g1iwszPZoT3pe8IKvsQpL/sCmcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ADaUn60kvLPdolUbsND7vyfQaLJG8Wkd/g8cYOJP3EM=;
	b=YU91/oLhv0SFz+kvXf9lesyW9VoWY7MAOI0Jb6vpCYFr9v4p03s3y8SDpY1NJsrnkCHf
	 93Gohvrehz7l94ObxkaNrW1Q0T9gUTHJ5nBMyv67d2PvOxMo9t4sTp86XGNwZSlJS6HTN
	 45wHx9OqDEew1h5k//WeDnZF3u+Klw+hRgHtgzhh5ekH801wncGwx5K8OVQaA97FLa2j/
	 aDdHzEAlA2Ucq8AQRl0/QKKjWMNHkNB/OZvBkpetXMuhc3jzlScep9qlgxh1ZFo20DO6T
	 N4gzHUDkP8U5WncE/LjDeFmifbLMb5yGJN3d20zxDy7SIp2BySpkzagcgcYrtSIHQRA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529818;
	bh=ADaUn60kvLPdolUbsND7vyfQaLJG8Wkd/g8cYOJP3EM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYPo5v8In2luas8ubIg9Y1/a9SBTxE7HSBWM+S1yeDCvPqosp0xQcS5a9GBHveETa
	 7SjMAZVts04a/bm0lJPjq1zoJXrvWyaDFWL4SwqYO0/yMHSAfbjifKb51AY24Wpq5u
	 Fvcakc9OFVSYixfO9JkYm+grgQSqLTYQokcCZ9Ze5xLkr35jFa2bAeXrh1RC7ZQqFT
	 CEVRhhVJ42x/5xob5HeChCIJCdaJAPlp8AFykYPtIvXtone7YViWJwdNrwzZskh/89
	 sQvy/nApChsHZPc3l3AqlWpH3pykFF2BZmz+5UOUmEjF/YHj8T9ycg0ZNpdSqdrXQq
	 b2+TqSZwmIw5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD6648119F;
	Fri,  4 Sep 2026 13:50:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF0C43DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0B7360BD6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZ_NXFscWkHH for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A8D5760BBD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529813;
 b=Rs7N0dMDafhbrpxDA/geAjUatrU2dbah+8F/C4mDEyZHtk18ABsPwB5PZaEIJ52T/iPR
 +i76a9HDRHsLncw3CNWMFC0Li4v2XVU1j3pu0NMCeTt+Abu0f+22ysxwxSdVRppwBGVVL
 982d4wzsxV2jGfaIZ5+2kdzzVcmOxN5eZkQ5OGLK4JHFVxu6t86nNQ5mJHqWp2clL7mDo
 6bKxkLCeJQpzNPEBp8HVVpO3vCHK5dppTC6I/IkaF9LKhVS/ltNsZJZHJt+ZZCtlwQPvr
 i+tTWkSNh64ErjEQw/YhrWRkjF7jFtLeFUazCFcXR4rrOSeWipPYUX84FkRZGzSYUPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529813;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ADaUn60kvLPdolUbsND7vyfQaLJG8Wkd/g8cYOJP3EM=;
 b=F388BIkNSJwCkT6s5/Sds674lbckrNbYcUqanV7XNGpUzm3w+ZZiiKEGGPsHzxAM1L5k
 t+CDsemL81/Z6gbYE2Iv4VCNzpbBjCQswPo/4vt09nEswNVlusDVHF92KuJGARQKNPi0Z
 Cp40kwt+kgTlrvu8fovJIYgJ64Md1CYDWyoAJlCymAE79wsHF7OMv8TckqM+VtOGppKrn
 kL2WE5MT9L8Xq3OniVZQUBQ//vHlJ4PafBbkHnh4qqqQITLN72UYZvNvLcDyriUVe6Drg
 fV+5Pn6OsrZy8IH9SP+hdqXkFP5KnTY8dMNYCHNpi49Y13vRHBlyp05czo+XE9aKfuA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="V2/Ll8qP"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=V2/Ll8qP
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8D5760BBD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:12 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48444ec4fe2so651113f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529810; x=1789134610;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ADaUn60kvLPdolUbsND7vyfQaLJG8Wkd/g8cYOJP3EM=;
 b=V2/Ll8qPBM23pLNn3ZGC8ROSCcYDrzxlYCuNaCH4mTGISLH9+0vtxaCLmBUIqB26e+
 Oel1mI6WJ3KhiG6IMW3WlT3aYevOOvUu9XOrfOTQTVI0dXMw0kFWpdXQaHMjhB9RoORB
 hVJA3dN6uS/n+Ti9tQUw0xEQU5QCRusbXuO6F7pIhShQQ7g0MATdGarEydq2Pre45148
 3VwiQX8agcT4TouMohIMgxz6uW4mNrct7ZrTvUN2lmUEbnnQCP2V3ZybwaQKO0alXMdS
 TXBJaPpT6S9KN7EbscEXsVR9+qgBQzLEpbB2Lfr0TYTCPozgaEfQPk+lcNUa8EsQs/gS
 g+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529810; x=1789134610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ADaUn60kvLPdolUbsND7vyfQaLJG8Wkd/g8cYOJP3EM=;
 b=ig8dvqjq70PXmFt5hQjB0k28tXwVkoMbdw/ffg9V+nqsNyG6PHYt4kXtmNs7BT82Iq
 XDChZc7CsBvGT2B4Mg09b0T9WHUna2T36BSVtDB1sI60EUhkXhwWVpW0dBVvTDnyLkGo
 ALSeu+glUqaghqGiPMkg4B4kb0WhL/e9iK8C5HJUG7Sy25vxK9O9tKYuq8m1r5SKoQr6
 OINH9ufBpo7jr+TEjeUNV/ezl1RGUJkpxwqQyAWGcWffC79vcDA6i2Gy+4qxtgdq3/TN
 YD/7BKzLOeuwEP6LdMJApY/4gEQWceYARpjSd16gU73E9mH4Lne5rGqq4C5910JWtWAI
 EqLA==
X-Gm-Message-State: AFuF++m034QjOKTmhdMN4Sx0Bw+nzhwDwdRnSUFEK+i+BSs4uw8FQxPb
 CWlcGSH0PAE0relUfXLw0yKhhY0EyLigOfDEImLnd15mU6wBmn7Qet0oTSZi9fEzJis=
X-Gm-Gg: AYBFou2ySBflLEfi4TUFf9imQm/pHUwsk0xBJDDYXaLD5ikPwTlJgoz5nsxCbku0PSc
 lJN+hqUc5YK78uM1rRrY2X1uL7RSRii7NCRTqqC5vks62/xdB6IpEDJVOOcgcFbkImI6lYhSZgw
 zsjAC/VotSVlVSyytwdN+1ba4CzNrL7KNLFqeyZZ/43HkvI3YFRsvVwX2QdOtNG421UzQr+xH72
 V1CPLCUb0jPSo1FD6uLhEG6KkDhM6ehdv4gDJVu/2fNnvu3RU+UbjVThcOy+MZJd9QBl+3G0JaF
 /9lKb1Wn6IESRzM4RgxKuchEO9SNWLF+hrGHjZ0YYD3SmpRSPONsj23EFgcBaVCLlIpJdLN46BT
 8ziXPpu5VoxmX/HPw8Ojuhc3iHoWVWPn4319fzgzu8U60jz0u/Qdm0S4Ard/LIEHZrVgMOMgS+F
 E7SOgHVgiEDgBzR2jDyy77bbhasEX4c+0v4GYvqE/tl+f9vqL2NIH7bNmZr+UqLs8rekCip/tK/
 sd2tS1/gcha7k/ojX5N62pIi6vnC/KuWT1FhGR7aoqPwipR8FyWd99F4Hf93XFhEulPkq/sDTzh
 sEQihPTPu6oXPchV5s1dZimiFH8gNO63h7pRU1w=
X-Received: by 2002:a05:6000:4819:b0:482:fc30:a1b4 with SMTP id
 ffacd0b85a97d-4858704686dmr13384701f8f.5.1788529810098; 
 Fri, 04 Sep 2026 06:50:10 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:09 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:08 +0200
Subject: [PATCH v5 02/13] memory: mediatek: add SMI larb driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-2-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
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
 Anshul Dalal <anshuld@ti.com>
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

The SMI local arbiters (larbs) gate a multimedia subsystem's access to
DRAM. On the MT8188 the display data path feeds through the VDO1 larbs
(larb2 and larb3), whose clocks must be ungated for the HDMI pipeline to
reach the framebuffer.

There is no dedicated SMI larb driver upstream, as Linux handles the
larbs through its SMI/IOMMU framework (drivers/memory/mtk-smi.c). Add a
minimal U-Boot driver that ungates the clocks of one larb, and export
mtk_smi_larb_enable() and mtk_smi_larb_disable() so that the DMA master
behind a larb can tie it to its own lifetime.

The larbs are not video devices: they serve every multimedia master
(display, video codec, camera, MDP), so the driver lives in
drivers/memory with its own Kconfig symbol rather than being built as
part of one master's driver. Every "mediatek,mt8188-smi-larb" node
binds, which is cheap, and a larb is only probed once a master asks
for it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/memory/Kconfig        | 10 ++++++
 drivers/memory/Makefile       |  1 +
 drivers/memory/mtk-smi-larb.c | 71 +++++++++++++++++++++++++++++++++++++++++++
 include/mtk_smi.h             | 17 +++++++++++
 4 files changed, 99 insertions(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 5f029fd3e70..52b0104e2f0 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -20,6 +20,16 @@ config ATMEL_EBI
 	  driver. Doesn't provide an access to EBI controller. Select
 	  this option to enable the NAND flash controller driver
 
+config MTK_SMI_LARB
+	bool "MediaTek SMI local arbiter driver"
+	depends on ARCH_MEDIATEK && DM
+	select MEMORY
+	help
+	  This driver ungates the clocks of the SMI local arbiters (larb)
+	  found on MediaTek SoCs. A larb gates the access of one multimedia
+	  subsystem (display, video codec, camera, MDP) to DRAM, so the larb
+	  feeding a DMA master must be ungated before that master can run.
+
 config SANDBOX_MEMORY
 	bool "Enable Sandbox Memory Controller driver"
 	depends on SANDBOX && MEMORY
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index d5f5b073672..ee7bd9a9ea1 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -1,6 +1,7 @@
 
 obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_MEMORY) += memory-uclass.o
+obj-$(CONFIG_MTK_SMI_LARB) += mtk-smi-larb.o
 obj-$(CONFIG_SANDBOX_MEMORY) += memory-sandbox.o
 obj-$(CONFIG_STM32_FMC2_EBI) += stm32-fmc2-ebi.o
 obj-$(CONFIG_STM32_OMM) += stm32_omm.o
diff --git a/drivers/memory/mtk-smi-larb.c b/drivers/memory/mtk-smi-larb.c
new file mode 100644
index 00000000000..bb96c7b912b
--- /dev/null
+++ b/drivers/memory/mtk-smi-larb.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek SMI local arbiter (larb) driver
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mtk_smi.h>
+
+/*
+ * The SMI local arbiters gate a multimedia subsystem's access to DRAM. Linux
+ * handles them as part of its SMI/IOMMU framework (drivers/memory/mtk-smi.c);
+ * U-Boot has no such framework, so this minimal driver only ungates the larb
+ * clocks on behalf of the DMA master sitting behind it.
+ */
+struct mtk_smi_larb_priv {
+	struct clk_bulk clk_bulk;
+};
+
+int mtk_smi_larb_enable(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+
+	return ret;
+}
+
+int mtk_smi_larb_disable(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_disable_bulk(&priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+
+	return ret;
+}
+
+static int mtk_smi_larb_probe(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+
+	return ret;
+}
+
+static const struct udevice_id mtk_smi_larb_ids[] = {
+	{ .compatible = "mediatek,mt8188-smi-larb" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_smi_larb) = {
+	.name	   = "mtk_smi_larb",
+	.id	   = UCLASS_MEMORY,
+	.of_match  = mtk_smi_larb_ids,
+	.probe	   = mtk_smi_larb_probe,
+	.priv_auto = sizeof(struct mtk_smi_larb_priv),
+};
diff --git a/include/mtk_smi.h b/include/mtk_smi.h
new file mode 100644
index 00000000000..6b17b152cb7
--- /dev/null
+++ b/include/mtk_smi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek SMI local arbiter (larb) API
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_SMI_H
+#define _MTK_SMI_H
+
+struct udevice;
+
+int mtk_smi_larb_enable(struct udevice *dev);
+int mtk_smi_larb_disable(struct udevice *dev);
+
+#endif /* _MTK_SMI_H */

-- 
2.55.0

