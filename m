Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F311C61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FAA940BE4;
	Fri,  4 Sep 2026 13:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1Q_qx28r6YG; Fri,  4 Sep 2026 13:50:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9C56240BE0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529819;
	b=H23OZ/tZrVGB2eheD+GXk14uVElCbqDaycrRjCWW/gAxOXy+OpH/v6PZgOtSanelMmyC
	 0CIe3R9KEfZIsgE7Q4Rl6zjeMKzS9M6ut5FRfP1nNkKexhikaf/CgIq4Y86EtsnaqR5vH
	 guAL+ZbATfLrFv1PH6/PyWy7dtOLbcbe9RLrSeF2raDL0exeGM3wGVo1ue7MnP3Cw3izF
	 Bs7XwXowXXUhTr2yW/XQwaJDwVYOvCI2bNdjl0wZDGPiIOudgIreAr9mWFcviV7aW9Eqq
	 5NRlFU7QU2p1Tse1vgziPXgqaChKjzVnRuTpSMNdX/u2ocD9av6vIUIPYSK3y5IkFTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529819;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NhGEeojdueHzw1RyQY8BH8GeYRm6hgFaQl1e3DiDLOA=;
	b=ISAND42s2Epl0B80ioTBPheRFCZMVXHzOx0t5HXQeivMY+G9J7RB5sMoYzC/riLWfxHz
	 w4msy49x0OmD7J36GbO4RTmGm3qX0eryijQH8olMonFZ1NFtb0JaCnV8m2x6bXDQRGGrj
	 c/vwyEnXo4r4vc/oNQ0/IGEJBPCplfcC1eWSfsqnpxxTCAtAVT9PPRKpbPndKKsVm8dOS
	 on4rT8/AAFfAzXD9r8hgSG6n8/YlZI/mu50fqZfcnzZe8m53JcYN/7mIdj9tvJCla2v6M
	 TQLPsMQot4b4NTR2lGWKSCGdNlLOoX+RG2WWtthEb+P6YhsA0Pz+AEuOPRi8Q2at4Cw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529819;
	bh=NhGEeojdueHzw1RyQY8BH8GeYRm6hgFaQl1e3DiDLOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SE9hj2aKdVNJ+txJzg9ILlyeAUi+0fmO45lM6eMQ7SkVyEcryGAK5akkh0x0PxT2m
	 f6x9QP0xo4azEnWbfOujUa/b/OlZXel7loCK8Srbw7XWO91XgirYktKr6trvKuPSj7
	 gHI2M2bOB4WKbVCG5fWtlIbdfi3FeqcMMwGcL7yUIGJ2zi2YizCY433T2vLKVhuNSB
	 S82v9/soSkbsJRj/D6Lsx2tsq5zr5ZCxOgKTDmDN7uC1z4MSYbPCZdZpCVk0q/NSVj
	 OanEXefc72/ZOeZYyc2mEq2n8peKH5I65aP755vsCB6FgCt/41owDsZsaQTNI68Jjd
	 XNnW2NozGQHJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C56240BE0;
	Fri,  4 Sep 2026 13:50:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 44B8110E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36DE060BD6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id so_hpnRR8L65 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1440760BBD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529816;
 b=nk65FsGFr1pDu1CVxfh/kzTJ1ozh217m3ThK4k6IpzQ1i7DtEDO/tb48h7d1PZ75EpiY
 Q0g9PwvThnQmS7lj/8VhZbWMDNmV6wZ8+3+/t/oZrEOmzTgfUrt+L7R/dS9k51Zwm3Cwe
 TYtlrUQazc3Abrzu+iotHJnMghfLkkqxT+vSbO6IqnuCr0k827RlouAzhvrhKa4YdfFsX
 Was+bP6hgIDu4SR8ARV4dP+XQ5l5iKIfPud3X7Dme9zNjBVeCplVRTGFL0SZNrxh1oILs
 rHRoLtF4jr/PtF6y9+8wiZpkmhrsKAHLfY0iyYZz1k1RWP4Fldkfwfug7v1iN1Ob95A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529816;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=NhGEeojdueHzw1RyQY8BH8GeYRm6hgFaQl1e3DiDLOA=;
 b=hcIqMXQ3AgoAiB1V2fqpoUwZz11Wl0vBNqwGlCGQmCXhX51xluxKPRBt4oQqAQk8LQYw
 Xtzwc+jqcQJf06JpiuWi1UShO+34EyGiTcN/ISEs2yDly5/JUFNEjhEHSCRPcxpfMS7mA
 acxrJScVL9OnKrVCFEDWi+kB80YkRPPkngdCIlZ/t0QZGjVPrf4WFuzWMJfWVIbT4nByC
 W3NP0st6lK0IIO9/RWYTkgPbc0JtzOQPQQPLJCrt8pPyBBtvFeA/YQfWJ71eh2NP/Wy7z
 Q5M3eG5S4pTeljrzVSsdSZnnK06RxxGPg+Z5aKjFQNJ7+QUxCs7rMrr4W5SsSfT6DjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=c5sVcsiu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=c5sVcsiu
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1440760BBD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:15 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso10086665e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529814; x=1789134614;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NhGEeojdueHzw1RyQY8BH8GeYRm6hgFaQl1e3DiDLOA=;
 b=c5sVcsiu2t3S6dQuTwqa/iUqTIyezlqzBXq7H40TmMiI2j6uHlrsVz7iuPzlOMuIuD
 Wvmu40Yh4cOo5JMyCY54sQloSgJE5ePQIoux+IGIkg9tEIIOdDAK5pv425M29UhYPQ3y
 23/NgFbwJYrlxrF2wt73szH+JAkpqC0HW6CFxMvJYSiVCUX7QB8CQAWbTNlmaSFdHza7
 l1hLcAcBE8hxeu45K6w+SCpCxCRDiZqOmBbQck5YZ9zVkssLqLKA+vZ07j5nYJbjBfgM
 dX2YM+IAHO/Deik6Jt7rGcjh+qCQ1+b2BdnqlWXw93XEVGytGZdZrSk84hZoo4ZzA+4Y
 2zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529814; x=1789134614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NhGEeojdueHzw1RyQY8BH8GeYRm6hgFaQl1e3DiDLOA=;
 b=SUnfh9OwAzjZgYS14URVa/darPbL2jQzFzvw+sq6ZLQAs2TrRiViGDWFKNQAyUrqBp
 M3VrhfDT1ESc1OZF6OS8+4aWDh0So5UqVOLjV/EP5BaK4o6pfObkT1motjH/PyyDMbaH
 6R881g0OidYfcpqybMLIFqxPshhUPfy84pGf+JSS4DkMePX/Tp8Xh65T+3x3fVx30r+P
 coIWZAax1ki/1H89EybA1KRFOoQQmjjsfqf5NF5DSIVfatmvMfmbQXdLxOP9Okm+/TXm
 gtaTq7YYK1nmFjVh3JEroVYEEIPHCQ8lKrA0iXGa6HKca3I7IRteMs0Vk2nvZTG4dVD5
 6TFg==
X-Gm-Message-State: AFuF++lORMVCHvAbek2RW1ARRZyUrGWdaFnqqS3EjLkwQ11ivAmsEnJF
 C3RDevfKKLq76qlyBHnGq6xLZqMu8RVzuR0+Gw5F6ZYHOsYYjmVJeeuWssdRIOYSztE=
X-Gm-Gg: AYBFou0eb4y9Rw/UTjPb5lxdEVfwE+kczXuwv95/qjwLWTcmPCLhfbvx0G1E2ceCZRV
 9V0JKZ+2EzLNAQshnlnpIoJETeFtJAWePmk1FI1z3DIaBDIFpqc3xykE3MFlk+uA9ukLrV0BHLH
 3dChMAysujiIzM6zROdvy0kqFs+WVYpFjEL74FxMObD1rROU7QVRUlQXr+gHQset0xxCfmeTHm+
 Wfb/kvb8UzVhwlItlIVEbwWxEvFmJVlBIRZnu7Gj7kSow430g8xEMY7T8GJ5fmCNzu9xwmKeLNz
 rh/YCVQaWQXR1gF7aS+PpVvQVMHFaVd7uckenrJQeYnh3YDY9+SBhlzAkqoQp/E8YvpvOOdXJ6c
 C85lunCH5rTLwMQbha+xSEjPwPN4Dr3qw01ggiGwzGB/WyhKTf/QfRQmtkZhU1swYjU/bI2sFYa
 oZNsya+ablKT7/ceF83ihmItV/XAl87adz4baMRUWysUtyTLUkQgz3a9JNxhMAzuqL7wegpofOE
 4eDMvMDgPpK9VVg2LXM5bC6zzTKq6/fp22RhYsl18RrYFg3y48x5O3yrJ1JGx0SQJhJ2Ria0szI
 d0ALkGeqFxt+I9lnayS1WprM8ZLyyISxQSsOSK8DKviHCipQFlI4Lw==
X-Received: by 2002:a05:600c:3485:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-49cf825c119mr114688265e9.16.1788529813681; 
 Fri, 04 Sep 2026 06:50:13 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:13 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:11 +0200
Subject: [PATCH v5 05/13] video: mediatek: add merge component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-5-dd9dde2f972e@baylibre.com>
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

The merge block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. With two inputs it combines
them side by side into one output; with a single input it only buffers
that input through its SRAMs.

A merge declaring "mediatek,merge-fifo-en" additionally uses both SRAMs
as a FIFO, which needs the DRAM latency thresholds to be programmed so
that the block does not underrun.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_merge.c | 162 ++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_merge.h |  25 +++++
 2 files changed, 187 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_merge.c b/drivers/video/mediatek/mtk_disp_merge.c
new file mode 100644
index 00000000000..b40e247d8f3
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitfield.h>
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
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_37,
+			    FIELD_PREP(FLD_BUFFER_MODE, BUFFER_MODE));
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_40,
+			    FIELD_PREP(FLD_ULTRA_TH_LOW, ULTRA_TH_LOW) |
+			    FIELD_PREP(FLD_ULTRA_TH_HIGH, ULTRA_TH_HIGH));
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_41,
+			    FIELD_PREP(FLD_PREULTRA_TH_LOW, PREULTRA_TH_LOW) |
+			    FIELD_PREP(FLD_PREULTRA_TH_HIGH,
+				       PREULTRA_TH_HIGH));
+}
+
+/*
+ * Configure the merge for a @l_w x @h left input and an optional @r_w x @h
+ * right input. With a right input the two are merged side by side, otherwise
+ * the single input is only buffered through the merge SRAMs.
+ *
+ * A single input with no fifo just goes straight through, one pixel in and
+ * two out. The HDMI pipeline never takes that path — merge3 has a right input
+ * and merge5 declares mediatek,merge-fifo-en — so it is untested and only
+ * here for a future single-pixel user.
+ */
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
+	/* unmute */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_MUTE_0, 0x0);
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
index 00000000000..54248633ac1
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MERGE_H
+#define _MTK_DISP_MERGE_H
+
+#include "mtk_disp_comp.h"
+
+/*
+ * @comp must be the first member: the shared component helpers cast the
+ * private data of every pipeline component to struct mtk_disp_comp_priv.
+ */
+struct mtk_disp_merge_priv {
+	struct mtk_disp_comp_priv comp;
+	bool fifo_en;
+};
+
+void mtk_disp_merge_config(struct udevice *dev, u16 l_w, u16 r_w, u16 h);
+
+#endif /* _MTK_DISP_MERGE_H */

-- 
2.55.0

