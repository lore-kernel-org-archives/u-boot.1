Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C620C61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F716811F1;
	Fri,  4 Sep 2026 13:50:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rMYXUxHOYbZV; Fri,  4 Sep 2026 13:50:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 64466811EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529832;
	b=bBcqoCMn+WYTVlmIijT9SLA0LwsXDwhj4jf98IOgiMVoxahNBtIAmRRrYVW/ZCHXvxbj
	 Ubby8iPB73RKAsLM3Y7C9gLsVjOV2idj3wDqUILBciPmJ3KvbktA8B8V0jzeWQWt2goKx
	 OCBGn8rJ+gvSMMZWZuvtN94uz/d2ebWCE61s++Jspvf/BgRZ7VhSz5KjmUFEbuEs/DZmO
	 iAl8FZo/wqLUz2zZQgdkY5hurD8e1b+KWXGiL3krZn8vy1LmrbyGy+Oqoj/6zU2m3knoG
	 Xj1oyLEEUy4OaCYy2jH7r9sW7Bqcjcr0rraGkl87Sax3rDaisB8qb4WPq2EBMyqnxcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pxsX1Pzf+OV25JXPP4AXa0ul4j61CBt4FO6pSt20Uug=;
	b=q651NUzXPESZa/EzxxsgHm1U9n5GfihDLOtsDjqocYRVUxF78W9/m02CDxaesUYVpjrN
	 mcvA4ToDHjByA4WuS6buAKKNRU1pnU4X9KIoSMsn1PJwlNT2wycI8nxWPgbyTwLLzG5Wl
	 2iKhzQGUxRByQQXSIQT99MANpvIP4zRInenDHg/iZSoa8btiafVnkfyaJH2/E31PYogFP
	 TSDj8neN9lhB+SCTb2PnXKHMxd41Uw10Ow4Ipa7q9njZG/lFGdhZ49/YR1RPXUmN3iMo6
	 uEXwIcLdReHvHRSyiR0HbPbOvxF9D8YDJHgVm/sJNY+75dhyv3ir4QYGKuHxxSUuP/w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mMLMZwWr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529832;
	bh=pxsX1Pzf+OV25JXPP4AXa0ul4j61CBt4FO6pSt20Uug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=It0QMFTYsxfAx/huE9/T8jMh+XhNX7iNtV1rktHEWSm+fgyCtam3OwvEv4TZkuFy5
	 ToFVur4ds7e29lUuxUqR5WQXCvT8qbuHRWKrVQPgg4M0g9SaUf+X52zCTDEqsxXVBJ
	 evlFZarevWMs12X7TVD2k1bkgj8yIrLC47HsKwQfAXpNvrQG+hcZ7RNv4byvapewZk
	 OkpSo+c9Zo42KOcCv479Lz4/Dg6gcwQ/q2yBbG9HgeXV2TGVK0p/8laZsbNc90XmQa
	 M5coAFeCyZd7QntrjhXdPTMhynOwoYc/5OVnUFjGm56w4UQesStf2U0GmzGbn2yLLH
	 xzAu6SBve29/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64466811EE;
	Fri,  4 Sep 2026 13:50:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D992A118
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C96E6811AC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OOEkMdg850lF for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2974A811A1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529817;
 b=Pe4dcYjRKf+4F00XbFvYlYjkJ7rPtUvMkV/vUUCMigAdOST7AGo/WkttU3Cxb7yqDhS8
 42wfufEHTM9Mg8R3UmVtmxz1pmjko11UL8a60lYOuA627CMYCwaD7I5rQbK6saTaNttRs
 J31GgmUtiUO2dTc8lZ/RWVpDLhtP+KYYGIxepvwV9OjvJHLlqzSyIjkcNezLCOuB3CgQI
 SPOBHjlgGjBPj0IINO2jXKPnbYmPRcZf+O49q0b9AatopifXrQDFAp5BpLspgvj4/z9QD
 1UNutubUMo9/rR6rxws4J6+3UU3G9tk5PqjOrbXCmn7lozlBFIOy9QAOgGoe/ETYF2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529817;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=pxsX1Pzf+OV25JXPP4AXa0ul4j61CBt4FO6pSt20Uug=;
 b=tIH6rBpg+Xtin7fyR8EClPVgvnvG3PceaSFJUY/cA6vEJ3TpWYtTQcta1zD2PsrwQMwD
 t3UNh42RGoVhPbjzFHiBd3NJU/CLJDyE7IKsXZ7Z/1YiC1KWrB4j2wV3ZH+D2VLasFlOK
 BDlIE/QKi9sp06QeYqsJridtu4CCOjH2Fo7TW0ute+u5OiForRmak3dIAgHBCU3WmV6il
 vtRyFlau1mXIoHKuc3uw4yX7nZHdofsx5c1uADUXZxuiF26PwM+pFKSCTBaps/OGBH0kj
 6vj4l26bV6USnBXNzVrTescJVMsnAc4hjOf6Lv677gAac1gX8bvGpTN0NNWmCbrszIQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mMLMZwWr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mMLMZwWr
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2974A811A1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:16 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so10839625e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529815; x=1789134615;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pxsX1Pzf+OV25JXPP4AXa0ul4j61CBt4FO6pSt20Uug=;
 b=mMLMZwWrjYOC+GTvWVsAHOYODHiaw8dmmjiQk7NSDVduXIx3//3WIOP77pi4g86Lb4
 EQXzQ2LfgGRhzdQwB16b4wPJst8R3jlShlchlnqPmOzFWzLMHVpN0nbvxjJo3S1DAvZq
 FvCL+baZ9wntJTcSwavJfZ+kLmAEQ9X09MLnFtHX3anhO97rq1PpZwCnCOPcYzurRwTa
 SIN2ETFMgdapfEsIAvcafpuvNtDRWgblvO7W8iORb70oHrZuEefWAFGy801hqjIoeFg+
 ijjo8Ac7tQlBdkMCaKVmFt1QfNRKin6US6jT3y/QVxnVNDHuRtaDsmY0GjaAFwO5yLKo
 udnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529815; x=1789134615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pxsX1Pzf+OV25JXPP4AXa0ul4j61CBt4FO6pSt20Uug=;
 b=ADaOlnPxRmxwMMahwstFWPaqKlz3OSJGfOOC9YZLJCj+tBos5NnYhUt08+p18yRjiA
 fVUqLNOzQjAJv134f5WjKWui7El/t7oMj2Ztm5L4b95RaZLosQdiHe8oQ7DL5QCMJXjA
 8jr3YyIXGJISukT1DZJ/93pXJ8P+Bh4cADaMCGUMMNLEIg3WArn1hCVv45DiPsj4N0Fc
 tP/pv9zpolrHX12PhZIXAFsQP0KY0xnw0RpBIPEqGFdvBEhwF9GFf486CL7s9Jdy4UCO
 Z1pyxZBmdeaUFmJBgnMFsYBUop4GEQ9dZ7W0g14ZFrIwXE+/LbVOlm2Y6ku6umI81TuX
 tG4Q==
X-Gm-Message-State: AFuF++l2awJP2xrUfFVdOHWmOJJ6Q+30No3D0Q++jxejpev/TXyPNLEm
 3sAGBVf2GCXljwVzizmpc9aT7d5dpPIiRF75d+/UpjpEkOsE/XNB+vOtG8eHcLg1lXc=
X-Gm-Gg: AYBFou33uj6HmqzfzeH1PPzR3nhZnWKVqUHT86F8+9gOOy41B2jOnwpefKLbUgMxGw5
 QsE8oB1UHy+aUl+j4wLaJFkFdT+yx6pEvokf5nIVfY2vxIytWz7bo8EqoDpzLW4gs2Ez8ZyyVv7
 J4LMKcUujBmTzIxJkp9bxehqJ99Cxw377OMOR5k90aWjnTSwBYct01F9SOEp3K0QB8ZVHbXBNds
 u9O28RvGpU6zrDRlSoqr6BKfxUi5Q3wh7xYFu0Qw8nVUOZENbYqfGY7mwgWYeSGmNXy2TO02fhX
 0ER7zz3Bu6PCqHQQmwu7cxGCidv9zhneB9LTYJEVM5h9JAzenHXHg7nRE3KR+BbLoZJPup7RLML
 FCDDrmkjTOh0mlSB9DIeZGBYtKllb3BJF/1oMEDePtN9T2schGsWrpPjlyxBZfJ7bpf+/AzfFnF
 YZ8XwKlCRZ4sq/47QiZdPFTtLeo4QZ2JgYWAyieRIpanYJSusIlUqr17cEtcsZLI4rhYKF00882
 DG706F4sSit947BzmS4HQITJRNiJS59krWIeukOApTYIDMVzJwOrCzDe+z9ZbNtYwf5+THe899V
 sE5oUV4aYsbtvgXSrTwNE6d80jdp/8vFl38YiSeAYHI=
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6c:be0b with SMTP id
 5b1f17b1804b1-49cffd457a4mr3653455e9.17.1788529814669; 
 Fri, 04 Sep 2026 06:50:14 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:12 +0200
Subject: [PATCH v5 06/13] video: mediatek: add mutex component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-6-dd9dde2f972e@baylibre.com>
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

The display mutex synchronizes the components of the video pipeline
on some MediaTek SoCs, such as the MT8188. Only the modules of the
DPI1 pipeline are attached to mutex1; the module bit indices follow
the Linux mtk-mutex driver (MT8188_MUTEX_MOD_DISP1_*).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mutex.c | 68 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_mutex.h | 14 +++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
new file mode 100644
index 00000000000..ab846898afe
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video Disp Mutex Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_mutex.h"
+
+/*
+ * Register layout of one mutex instance @id (as in the Linux mtk-mutex
+ * driver): the block packs the per-mutex registers 0x20 apart. SOF holds
+ * the start/end-of-frame source, MOD0/MOD1 the attached modules 0-31 and
+ * 32-63. The offsets are index-based so a future DSI helper can drive a
+ * different instance/controller.
+ */
+#define DISP_MUTEX_EN(id)	(0x20 + 0x20 * (id))
+#define DISP_MUTEX_SOF(id)	(0x2c + 0x20 * (id))
+#define DISP_MUTEX_MOD0(id)	(0x30 + 0x20 * (id))
+#define DISP_MUTEX_MOD1(id)	(0x34 + 0x20 * (id))
+
+/*
+ * The DPI1 -> HDMI pipeline uses mutex instance 1 of the vdosys1 mutex
+ * controller. Module bit indices are as in the Linux mtk-mutex driver
+ * (MT8188_MUTEX_MOD_DISP1_*).
+ */
+#define MUTEX_HDMI_ID		1
+#define MUTEX_SOF_DPI1		0x5
+#define MUTEX_EOF_DPI1		(MUTEX_SOF_DPI1 << 7)
+#define MUTEX_MOD0_MDP_RDMA4	BIT(4)
+#define MUTEX_MOD0_MDP_RDMA5	BIT(5)
+#define MUTEX_MOD0_PADDING4	BIT(12)
+#define MUTEX_MOD0_PADDING5	BIT(13)
+#define MUTEX_MOD0_VPP_MERGE2	BIT(22)
+#define MUTEX_MOD0_VPP_MERGE4	BIT(24)
+#define MUTEX_MOD0_DISP_MIXER	BIT(30)
+#define MUTEX_MOD1_DPI1		BIT(38 - 32)
+
+void mtk_disp_mutex_config_hdmi(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_HDMI_ID),
+			    MUTEX_EOF_DPI1 | MUTEX_SOF_DPI1);
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_HDMI_ID),
+			    MUTEX_MOD0_MDP_RDMA4 | MUTEX_MOD0_MDP_RDMA5 |
+			    MUTEX_MOD0_PADDING4 | MUTEX_MOD0_PADDING5 |
+			    MUTEX_MOD0_VPP_MERGE2 | MUTEX_MOD0_VPP_MERGE4 |
+			    MUTEX_MOD0_DISP_MIXER);
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD1(MUTEX_HDMI_ID), MUTEX_MOD1_DPI1);
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_HDMI_ID), 0x1);
+}
+
+static const struct udevice_id mtk_disp_mutex_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-mutex" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_mutex) = {
+	.name	   = "mtk_disp_mutex",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_mutex_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_mutex.h b/drivers/video/mediatek/mtk_disp_mutex.h
new file mode 100644
index 00000000000..ce600e0521f
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MUTEX_H
+#define _MTK_DISP_MUTEX_H
+
+struct udevice;
+
+void mtk_disp_mutex_config_hdmi(struct udevice *dev);
+
+#endif /* _MTK_DISP_MUTEX_H */

-- 
2.55.0

