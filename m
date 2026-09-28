Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A7CC9832F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1766160603;
	Mon, 28 Sep 2026 09:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8pvYhLUSjSM; Mon, 28 Sep 2026 09:17:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3E2426067D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587072;
	b=IJBC3U4OLOUgPzVVRgml5cn/QVVcK1XprH16NTpt4E4pLmXqXlaUx0geAwYetCmE+k86
	 Y4/gqqPu0feTQeRswzN7ZUlZ/oH+iPk8Lj84jGz/Cae9VHplWbCXifON/jVLQGLwTsn0v
	 Cme1KLXqDDwQexhhPG9NVwOf2gmcKldZs4WT1r0z/G/N5m/xrFYqEfMxR+mZ13TyMane4
	 mkQzDYem9sx46YXiViYz63ztEJ7aMjQFVv3RaNVUTC7Guatw/M6C1VI43gckTTwpw8Iao
	 S+n5PSkVYtMOxzNY76qDqffS57E+yDbQeHd5DOJzxUNqoRBKbUWKIWi5BjVCSBBhLXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587072;
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
	b=HxTvdQOQu3Kdhzfj+l06JVDHkYK2lzhHJdq1TiwnuN9l3zQbw9vQ47UWNdN4PyBzN905
	 88MWTqatOjiBe2K+XOYAWXSESHKrT41XikFg/innwSs4GiZHPiEDVbyeTw4MgLuZK/atN
	 60LESoSyq2LvX77JjMZTxXV6XYk5mnAmdabzw3cNHMD/Zqtn54aj0KauicPVxRx1JktPN
	 iwaM4u1m0OxN7Rh4DFWktn2OZFXdFQs/Jo41t3iQGjfCk7UNJS8uykbtFmFazruYu0nb/
	 9fbxKew9S0SK9YZODJDtorZCdRtPRZl1d7k9ljwN/6C48+hv4Kxgmv+2HN71EbyD0IA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587072;
	bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5EZ4DZq4Su7zxu3m5sA60r2oZLRXf4DF8iQe3kK3avelJ9CLm1bWjIZMqD6e09kr
	 oIE+Wz1tArr26FjLTV7vdvhttCpCRvigv/3d7Xu0xicJ2ldLu0pWtOGMX0MwP3eWk4
	 TmqjFyZwvFwM5ZsUeyJixvFX2/pjub/fho2kwbOzCDxWjI62ONvMaGmEvIrZpDp8lh
	 TnvF97sbRjeLqoKU4cKOjBbV9YjhbDavXEQZMS6KJvv66K4SqV7jpyN6tWjFu3iBd7
	 yLV+LlIoCfztlBCg05J2yC9tkkJ4BQgm90a96NzfBkICZvMSAcuU/kLrzwm6EcluEJ
	 1zAUFHFrfUFMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E2426067D;
	Mon, 28 Sep 2026 09:17:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56D8672
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42DCA80DE6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0MSxMPd5lcp for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB09280971
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587063;
 b=NEvaEep5ofK7yjimHSeMXNmVEYXhFRZgiWNV0cMi+HoF4BGcG+nu84HSue8FK4CulZwS
 /YXBguBBqJQ1PSNlrCHlCLyTl12ePeLlC3KmheiwLL1DrgUY4dmz9uzBG9VHOxblunY8G
 lJ8VPIztIbM+PqTTTLFm1kNifP08r2rZUsR/GUxfBqwS75xHo7OkHSOQmIVThcNTx+RGQ
 itZKXQqqX2C0d71F6ETG3RMdbmsI3k2OezFcjvKdrVXzlZDAiX82Udt6vRZ5p6esXrUsa
 At/XlMF6+DFMZrfrKF6bkMTD9GOs2TsLuwJWNjLSiRWaJiCgWfJ32fWaWvctAAKEIiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587063;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
 b=kZD7CTJLiQVYH0bbcGC1R4I0WuYCPgFIYmQrzf/ieK8zsDoClQ5oJVmNh8G9oOuhPfpZ
 vPxvL/8k8ucAq8TqLlXhVzrosvU30yNHp8Gj9FEbyz0dtN30LJHGD94jVDbiNnqD+eoOw
 f++KbKNOe6IZ+6b8dp04RE8X0jWvGOzBcd1mnbOdnt1MpSCw5d3Z0Va8wDDVMap93oIPZ
 EPAUqlUzk3+DHPKzOXwzlt8qCi69Xof5eJ25up/PF9E4sAQG6W7uOaN75vIAusP2u97Va
 8jowWCjKATmAERpPE20iESmeuVhdMG3LMWN6A4iZOHqjAoHrBrec4R6QmOpoZL9RjZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PO3EclA1; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PO3EclA1
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB09280971
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:42 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so2340983f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587060; x=1791191860;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
 b=PO3EclA12TGt/ogmhsUSGhFTW+i2Ri/pXpt7qdS+6HWwCjnyQLrKFBUx/WUXK83Mff
 OdC7Aw69hgQVQLFq0mdkEU2H5voya/ojZuLeZ+6tMy51yAOhGLbo2bQjF0T07pJI/P+h
 EzLHI2QXJL/9VuktGd9UnSsQdcflkBL7O6KrpCP9quf4sU4pdS/wZEq4ui/upOqtHicQ
 tFsubhOu+PIF4XONvo34+hzxAgEm6jEqyQXx8+RdF7QvLKo+vQVWzULw1GRnGIe/1Nvf
 J2WdYiEwEiTyACCidY4We6H2nESdSqo5EmW2e3AquwtTifTUu/XaeOWoG0Rfqy4f3DlI
 UFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587060; x=1791191860;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lUER9Vae2MZpD0YvLoKn0fNfgYmQD0+P3bvJnhlp2PE=;
 b=2eXN4yIvHm/eZm1wJtNqODFa7o0yk6owbd0QTktP5DHqNgy5E0/68njb+eEmvcAs8s
 oIk4UqoReQAtqid+1+qzqlrPL4s3Xp0RXrViyMVzMRnzFae7TYT/ElGyBvWohWwXEKrT
 JJi9X+jQH1MKeuuWxvdh3Y/fZNcMPviEcIkDudK9reZ2wK+s4GLKd0KFjUJ4aV2bw05K
 UDiOKqMfn72AAxE4bqNkwti4ipTaLyJvn0ioqYFuda0lX6JlJXj4pE2aBF08QXaRY3Gi
 bKYyJq5Y4cg6AyfoKwPgsnloHhB9Twk8Zdsa2lxF2Yuw32RASRsXpi/kckRuZKpEmg0R
 mtBQ==
X-Gm-Message-State: AFq9FYL0mmA/HxuIrva1XonFdaLCJZeaa8PmBIzrBw32YNopZzSEpjsN
 yU7qj458nsGtTItUjppIXFRcEoYJTQHEWNQh05+J3Dc0VkfRUCtakqBLuV0F8K2N5FA=
X-Gm-Gg: AYBFou1WpeV67k73yolAgcfb9nHclnuq8UwiZF5Y110MfSEla1M3vuoN/99C9oaL4/w
 dpHKnVyUTHWH3hTy4taM93BlAILb0jvWu+tJPjI1Y9Bk5o6mI6qqN1RYTwbSTqANNZcy4Fb/KId
 zReFm4WSzbWVjJN/n5Fbv444pWrByQ0vpkBI2PAuHLtr4DucK9Fxw0ZzS9LBmG0FLusX8is7RdR
 KLk1LnobK2Vz1BgGA266C2njQAu3p6yR/mHTj32LqAMSBt/xYEcaugcAcxtdkilNtR+LzACe1e+
 tVpC/dyxc00dTXnfKfZzAjwKGKYqmiVuHvggsRakq58R9Vnr3vXOM5BjJHQv4MGrG8bDmtjziSY
 w7vwlattHUnNGpuxlQSlQb4IXLxH54pPk5FygFsCNh1chiGeUqaXkBrkvwy61o4Y6w0B0mqBxhN
 SvatlP2LBYOZeXKR1xSCy7ry/A2+GB7YLbwcwDZqwqYPARUMWSDADboL9Au5ZuLF2Pvn/kwX0DQ
 4B98ww3v/S0DR92sf3I3fg3yHU2YOJRT8qqlwaQ6WTDsgAS6WicV42lcyQtVPfK7tI+N8BaM2gI
 CL/x7juFOCDQ6hHCIZbPqfTmwfBXmM/HgOkBIlcfIByp005DO7gOoWRF1SPOQH2E9A==
X-Received: by 2002:a05:6000:2dc7:b0:488:890f:6f4b with SMTP id
 ffacd0b85a97d-488890f71e0mr12744830f8f.10.1790587060166; 
 Mon, 28 Sep 2026 02:17:40 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:39 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:41 +0200
Subject: [PATCH v7 06/12] video: mediatek: add mutex component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-6-ee4a61a8ac1d@baylibre.com>
References: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
In-Reply-To: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
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

