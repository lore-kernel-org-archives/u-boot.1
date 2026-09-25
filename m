Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADCCC98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D99C81327;
	Fri, 25 Sep 2026 13:40:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qzVnJRHXswZ; Fri, 25 Sep 2026 13:40:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9BB81812FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343648;
	b=NifA6/lHxw0RbMRGQZogqz4RqfhYKqszas5doNF7Q2YTvlxUkDDd8jKN149AF9yEv69a
	 tQbOKWqPj1EdF4Xi9Rs9sJijT5Erq2H4CHmz1zTKmdtRpPuUU98P1pHaicwonN+2aNEaz
	 QYjoytLun5nBesvudq2p/8nqedB9LSDHhUipKLgIT5OPbgJ1sebS58KffmuXV/557uavJ
	 IoZOEyMWY6xhVO3vJarQFa5BqMFDF9ck1wP1R43iwsSOAISVdh7Ef8vDUvxKwGqaKNWBW
	 PdoLErSc4nXNCKDzyMZ+Xws2Xo14Jh2mMZXmHMg7R0ylxLRmwotz7GUwYYHzo3CtYdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
	b=joaJi1TMEzgqBM4hXJtPhD/VhJHoyIBpgxmVvgC/qQggNHJ4TM1Rt0lOIpxJFljwQs9P
	 QB5MMUVUlMeW+junJQsBztFH5jDscuMHxCYoADmh8B4SkGgF+/v38RvbzJzJ/tEL0jRrm
	 Qi+QI+o1rICCTnnavzNdr6otFixgtGD4O8TirCTXWP23YZBNj2brfXZy8aJBeph/HC5T+
	 k94zz3eHpOOSwxdSH2RmrQBn1349BxENbUsqb8mGlt3Exnm4N9qg6iMBtUMnRrFvfqwm5
	 zWuchZnws2h9jFaJRSs/4F9bCWjOomy1Q4jZqhmm3LibYFcFlt1h0CZqcY3LEwn/6Yg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343648;
	bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NwJ7y9AQztaQmBeEmNirWJIweH9nli59J4YFkaD/PkBex5fdBHlRKRQTjFm40zAEu
	 SuULx4ZwuBIF76MU+V4P3hPIK4zQgY9ir+u6QbEbc1Mh/oMdwquDKQT79eB9yw3Ya/
	 6LiXnTahtSp6OzWBdBWieXoHZw4mSHaA512Xwmv0UyRLKEv09mT0gGDMb1IYgT9g5J
	 Xi7d9RMGYHfslolegjs5h8ygcYOkhEMyMJxz+IK4mYU76zjJ/iJsBqmPpt/dkEeWrS
	 /i0dPv17BOShi9anbeM/UgJ+lTBQaK1TF0qTBGcqgYeOUp1VFyOU5GYq8yN/k3F1Q2
	 sXhWHnPyyCrtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BB81812FB;
	Fri, 25 Sep 2026 13:40:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18CF3332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1683C40AC8
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QgV8Dsu4_5o9 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 11EDB40A6B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343637;
 b=FAqXd2EPfdPmvqyooTJcDbsElLH3wqUbro0zytRffknBvsFydImV7E9hShUyjt7unDLn
 WfP0ToTbpeMLEilCYQo5p4mYnsyKHSYHK+NyvwU8r+5dKSytQACFOHrmfbg9Bo9LenuP9
 TcLd8LFMRPeAT4+0IagXcLtS4L+Y7xZ5iak8+rJVfYC2Zf4cmybHtpgPPjnyLj6zLGcTL
 xX+Thcp1z7qQKwNPMmxCGYOY/fmik5JxWjBoY2rcClQpqG6hRIarmQCwrK1b8cuH8U9+j
 GNgfunJBifwkndA6A1ckgqqipduA13FxDfFR/isPZn6eaXrqJJjiPrjLFWgtzW7Avug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343637;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
 b=WfC7e/+rFYkHZy4oKkw3VN0Ee/v15ZBxUvYr0Z3tlh9LaOdV7TD12tGeiqB0Ne4gu2c+
 O/O5DTAOCiJgC/XDZNaxnpYMqTyq++jyf31lP88YgHxwI/PDXQVOl3G9CaRl+BW9nzVRd
 oL/cMxCSXyVl6Nx5L6rR1FXjn7Okz8HNohAGeG78o9oEDNrl7gAah+TMh0aaSUkoqcW+p
 Uk7RpwqOyrSYrem5xRSJZ80iuAKWsq0j+1Q0qIWczNmu9zcJG732Nw0CKflyuNd07GSTA
 RAc13R1ig0unrPAtnx3EWqBT9qI/evHbatuRvbhTmjS/3SAG9YAzfAJEAWummXaSHzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="fQws/lQM"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fQws/lQM
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11EDB40A6B
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:36 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so569891f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343634; x=1790948434;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
 b=fQws/lQMNpTGUo3pGc5smXKuuZ9lEnfceL9s6q1TSBOI4qtY7fPLr1wM6wujdJKKvt
 pWv75dsfZC4w1QW2rnN6Jg5dUC+8/j1lNcXbodZkTTUR+fSZkZOBfopKS0BgkrQIo6Js
 R39WeGibJqPcn3jHrxxZ3ewYea8S5k22Jx89dAQxC1vuJIl/rpMZkyko5YchhgmfHvSs
 Xz2bCpF8O61qwrcNBswkozWdbLenZlzAsIMObBC/fIXc6nF2ZECBcwxr66B2R9J1vnJL
 nLWhJ1o4L70/E3dTX9SsTN+KjhEDlJiPC12MPbJ8KbwwiAcVLQZtPZyDak2hQl+8ZRUI
 vKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343634; x=1790948434;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
 b=wAAB0PoH5fdDXiUea4oBhlKBXRMhRwQVgGlMVsjXXfghmSV2jEv5ZnsSu1T5s/aP6G
 r86WHCYdn1+k96LTtLonqp00Ue6RR1zG6WzQjU4wPRX0kxd2HLfgDZJmlqaTuTuRpyDD
 wYc0gR4NZ8m6EcQ3ZqbL05FyBW1+TjxWA+//r6x9LvqXTQ5KUXhJGVUWHxT2hR1oJj3/
 mL20IeOwhzc8isIU7HMbXLMJhgNVr8Ba1jFBpOm+jsszRgAsnslrJwOsU2oHhK075UQn
 Hf1RS1UE9pYxBmTGrveDntLZADsJmYhGes/JJOQthoB4KEl2A8ZaIOHx55GqM2oHOat2
 lYug==
X-Gm-Message-State: AFuF++l+S5r1lIpZJGPsMOMDJd4+1GRmZBDozUfn0PHVtWLD1+++cFCk
 zoLueQPeWh1aslY3wls5Xdo1idfMBvVRsnsTrH8NpYsys2xVihcvKOlxsDEr/xJPmu0=
X-Gm-Gg: AYBFou3lpnFp2NskZ5NC9/FNVb6yogQBwYva1vEwZgVpmtKNJOLNAu2zKnlUlGsg1Nw
 qR6crtjNW6bkU9dpnr+/ooOLIRohkgdf0iDxMKVZlDHBLbPUpWk4S72o7b+ANNE5pk+kha7ogKm
 5hDrWuFC19VbHdsTWu/Y+58yBoGcvrSKcwctOuBFcUu/qMY+veUCJNwnuXWB6r35ezR8roR40KL
 S3Zkl9pyzhcHBzI93EV7SxwXesdS+jrN+pnOJzvnpOtL/foTTG9dQz3bqDpAkC1PCR/wJULSZJ3
 bU2sSGQkHHTMRyaWX8Pedri9m033FkR7vbJPy4yEE3Oi0m0rnlspAwnP5DWwz2yN5GMfeWzfb2Z
 R6zV6RGqZigHd70t6itP7p/6rXAOaEWtfTwWefzWbHNU7cmDtDlAfVyPzGL/Mz4sCpy6mEfj6FQ
 mHRw+K0wnaWNWFe2xDv5LzKE+NXww4y3nKqqtG+r8WFOJuaiVCMtoH6urJyVPI36qNXWDQ9wx2B
 mIrVAYUvMJJP0WJVdPaa0rtl5Cl6xPpB14/7nH/kiAG6KhrvbiYJvQ9Ot9YQCNyeoDZwggebH7x
 2Toweyr+b57Id+Fwlea3qQ4c+pV+sy31cR3S+5IlUo+xhzSqDJj4f+0=
X-Received: by 2002:a05:6000:400e:b0:487:a0f:7f7b with SMTP id
 ffacd0b85a97d-488716b2a0amr11859982f8f.10.1790343634401; 
 Fri, 25 Sep 2026 06:40:34 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:34 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:04 +0200
Subject: [PATCH v6 06/12] video: mediatek: add mutex component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-6-29e626b213e9@baylibre.com>
References: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
In-Reply-To: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
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
 drivers/video/mediatek/mtk_disp_mutex.c | 79 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_mutex.h | 21 +++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
new file mode 100644
index 00000000000..0e1d2e3ead2
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Disp Mutex Support
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
+#define MUTEX_EN			BIT(0)
+
+#define DISP_MUTEX_SOF(id)	(0x2c + 0x20 * (id))
+#define DISP_MUTEX_MOD0(id)	(0x30 + 0x20 * (id))
+#define DISP_MUTEX_MOD1(id)	(0x34 + 0x20 * (id))
+
+/* the modules are numbered across MOD0 and MOD1, as in Linux */
+#define MUTEX_MOD_BIT(mod)	BIT((mod) % 32)
+
+/*
+ * The DPI1 -> HDMI pipeline uses mutex instance 1 of the vdosys1 mutex
+ * controller. The SOF register packs the start-of-frame selector in the low
+ * bits and the matching end-of-frame selector shifted by 7. The selectors
+ * and the module indices are the ones of the Linux mtk-mutex driver.
+ */
+#define MUTEX_HDMI_ID				1
+#define MT8188_MUTEX_SOF_DPI1			5
+#define MT8188_MUTEX_EOF_DPI1			(MT8188_MUTEX_SOF_DPI1 << 7)
+
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA4	4
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA5	5
+#define MT8188_MUTEX_MOD_DISP1_PADDING4		12
+#define MT8188_MUTEX_MOD_DISP1_PADDING5		13
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE2	22
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE4	24
+#define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
+#define MT8188_MUTEX_MOD_DISP1_DPI1		38
+
+void mtk_disp_mutex_config_hdmi(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_HDMI_ID),
+			    MT8188_MUTEX_EOF_DPI1 | MT8188_MUTEX_SOF_DPI1);
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_HDMI_ID),
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_MDP_RDMA4) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_MDP_RDMA5) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_PADDING4) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_PADDING5) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_VPP_MERGE2) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_VPP_MERGE4) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_DISP_MIXER));
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD1(MUTEX_HDMI_ID),
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_DPI1));
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_HDMI_ID), MUTEX_EN);
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
index 00000000000..76630e6291f
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.h
@@ -0,0 +1,21 @@
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
+/**
+ * mtk_disp_mutex_config_hdmi() - set up the mutex of the HDMI pipeline
+ * @dev: vdosys1 mutex device
+ *
+ * Put all the components of the RDMA -> DPI1 pipeline under one mutex
+ * instance, and start and end their frames on the DPI1 ones.
+ */
+void mtk_disp_mutex_config_hdmi(struct udevice *dev);
+
+#endif /* _MTK_DISP_MUTEX_H */

-- 
2.55.0

