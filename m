Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B88CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07F0560D76;
	Fri,  2 Oct 2026 13:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zxCXqdFGwLLI; Fri,  2 Oct 2026 13:23:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D684860D6A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947389;
	b=Cdbca9S2BsyFRLA8Rx+gHwmSJlhy2DLNzJ5Ivgl/E8wgyTmwyWh5HsgI3J7n8urOg8/G
	 x0EgxrxGu60miXnM+xZZCuldPGgdrF/SQ2EYzlL67t8su63lQi8VbRlW1yx8ufi0ELVrA
	 Cv7B19uMnfJDu2Qa0FYSnppynJZGNp0vTav6cmT0umfA/kRF3757CbTMOt575NqY2foju
	 Mwa9s7gOBBg+ItnTZbaloW6Z8FXLb2RDgDqdYws/k61/1Frsxe3U/Q7yuOxAxZqWVSXf5
	 dkNG+xebrRGHdjTCJdg1SG9ztMoCEOFnoxXvrDP5xLISrz8nPIlZtj33/3t/ExQuBcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SXb5x0M+R3U7lh9cHTVT86+Zv6iNCdE6dGm929NGg28=;
	b=BQgOjvhJcgvD7W3JDiLgDl70po3usDBJTHI2+Yl37/djulM6Q8Bw4A0ws3/2oTE5/s2w
	 +PNuKlLbYCSc2R/4VWIBeXKK63kW2UQIz/LJmRE7NTiLt5LzQgeIkNGNOk7sZICYFRpNX
	 ohUncMOgLdKQOLEixDr1mnJsYZ4o7Nlm0UOrhAx/A0OJqIe9KExvs9oNg87wqJTBBhYG6
	 nnFt+5OTmeJMjCclaRkQ3Pb6IgNGoOs0oH/2m9DExp3nEfl3laXEB9dFdHgOeUej/PmPu
	 6O4kaFdxBM8nwAIuXpEDOGwSPmfxhh6FaKpx5SCqe9I0XSxpypHP2IROoQOS+i0hrFQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947389;
	bh=SXb5x0M+R3U7lh9cHTVT86+Zv6iNCdE6dGm929NGg28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0rodyMZqNkETWlZ769Bv8CxxJvbb9l/uJwAb2/0r1rxPi08j7Kvg0DtzoFJkZGrzw
	 kA1tDf+c//qn14puD1KrT/NC4MfX1MZSMrnULQmuy3b2o7UOYbgCVrFmo2frzdROcP
	 /HlbfAk0lzc2lUFcy/bUIv25DswuNzP/4C/OiEUQKU0giG9ujUq5oEsl4MpWyCwlH8
	 b2Aqlk/AJzx4JuNRSq9oZssGbazQ90JW+ywf6zMbK8PscZm/UcDBZCQrA7Zz6NH3rf
	 sfBbv4TpIE5JQx/+8kwb/UNxH3hiXtCw9Hd+YIWoigdcdoamL8uUmQOMiOIote3RTj
	 TJOsS2JtLNLlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D684860D6A;
	Fri,  2 Oct 2026 13:23:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64C95435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36BB540DC6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8SUV7HK9fWOB for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:23:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9DAD040DBE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947382;
 b=YoXF58zRaoRNO4C5tkNza0dkDqP5QbZD1OhH7yB+nCJq/oPODeaoesprQU9JCz0O5ho2
 Dr7bpWCZAfC9Qu02mkmhoveYdae+oOrxx0Q0o6VOmgW0Dq0f7LeHnfbsrl3c2HtBEiunX
 RgwpAp112Bsr0zGWO4ZxQSh4+CFqIl5/lRZ4xF/Of3NAGwgQlgETe09ixvDVsRN34TwnO
 1osdW99MNWMbXyD635eTf7ropRHNBwP4aMzsogu+YXiATaKGw0CN0+WjC5ABCWXnWE4WX
 qT+/NwI1VpgER+vzDQ55E5ZE2tkoy174XzXPAzVc1FU2hLsxoctfdi0J25uLDx5V7zg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947382;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=SXb5x0M+R3U7lh9cHTVT86+Zv6iNCdE6dGm929NGg28=;
 b=T69qBeTa8lM0WV41kly3706sFkiWKTyaTcz3NAa1fZKynZBg9FN4rUDXGQJqhooljRE6
 sC6Jv9k9KLrl+LBKV+7EVkmBURGcYuIwzPoZ+0HyX76qNXgWuIx0pjGAY12EQ5MhGTByW
 RvdwAcgq9hMokrNXeKePWAGXJjF4SbPefyiQI92qVUjsWnyLFjP8c5J7HK4vvjtQZCYuA
 Hf9OGxFODkvvlWYXjA/fo5Gdp2hA9G60SxPkXMrs8CDcRkaK0uBEYh2HmCKPL7/j1S7+K
 GNblGsOjI2fuhtMrHwEGresIynjnKCCiBf/EAbqRdP1VanOH00AgQmELEgtJvFi1ljg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CNLgahWm; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CNLgahWm
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DAD040DBE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:01 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48affb828f1so2938648f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947379; x=1791552179;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXb5x0M+R3U7lh9cHTVT86+Zv6iNCdE6dGm929NGg28=;
 b=CNLgahWmkeXY/Kj/uISpqjrwX57bq+Cgo/tEFzgD9JPAtGQ1QIoUWw3KsKCCKi0Vbi
 0bxRwW6i67oAruJzNbSbfpHLdRc4i5XHJXcLQztogw5BZVhmR8HcoU4KvqWsvpKMR/QU
 V2wwwRBgagdB+9Jl+u65S9MYKMu0Cri/AiXWVAj3sfDR5lGWx9eloom88/it4yAX0cQH
 U4WyUCbZsFPsevIRpDLgwA43LxizFrUgGI4e6dXb6nhaKtQ2pFjXdCgLdfWIelJu/U21
 7+c/nibE1EsmTMRow9fqwNI/KogCNqcfFI51YQ49Rj8jLied9vCn7Buvn1FH2CJCVfYu
 rFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947379; x=1791552179;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SXb5x0M+R3U7lh9cHTVT86+Zv6iNCdE6dGm929NGg28=;
 b=HYiRpM9ORgW6r2q33gMALxG2PaqOoJcX27AaLo2K7GfGQg2Ao2czXjC6NqA04Twhmw
 8eSliPOp/+rKn9ld1nhM1rHzLs1FvIGAvlbq1ppDAcKjfNWEYYjKEWXKNH/osYoWc23h
 dhkrLZ3d4aySooIdePoGsRT8ZExfvs/NRGayepWP5cuc3vOTOpvPJA3Tz0e5NSEAyO44
 VZva74TnbkshI8m15qjTM+oS4manwJ5GS93qH6Dd2jUsJVZkx5loKDhfoxz83QzpsI8s
 EjLHiPZ95JW17icaUvhppZakR+ufzcxwKmYvV6lh3T2f0j8mc+bANwdW7tUhc4uB81t7
 NjdQ==
X-Gm-Message-State: AFq9FYKG4Pucse+foVA97JKJApCbgqdUdqVMT5WBmaWM2YHDPPLawjku
 Sl5rKiYiacZbkdMUEGDWOukzwn5Lp57CjJO9JykGaRV7ETP1tfTK2lCEqevYFrOwa/Y=
X-Gm-Gg: AYBFou1KHUKrlcgnQD1qciYx3y/oklkgxM+x/0zcsxgicoucl9jXk0RIcNutgpL0HMy
 7aciv8j7gq4BBlTbRu/1dOSilGcERy2rVDO/d1IQdw7fm3jb+XxnQw8VtnWgcQBLu6IBxBStPgG
 BZ+wj2CKRlcyYEobJmpAKUyI5o17QyPjuUihfkBkZFhSI2tSlTRlLropaZ9Hyuxiiw8J2YDM198
 KISBpSN0kCVcmm+t2oHSJccuis5/RLlkzDjKuFFLD2SW847DUVj/LSLN2EejJNLIOh7ZHhzrsOx
 Zz79YRWqL/f3c7zSJS9wSSRfuYeZoklt95dYoJrBdQrxK+2sf+GnE9sZNLQzhKqzYAm2e+sUF4d
 nDJuQN0j2M6eJM/V2oWAgkmpnnyyLTd8yMIS5dbfAVb+tWr/+5S8KJ7oB9hZUdPlhS5l/Im0a9f
 +4vojWubLlgv0dF1yUHUDpJpVlzGh2YxBM/J8ZioQkYQNWL5+9pADn4sovs8Hu4EDPlQq8gom5G
 Ifp3SW4yByhh57pmZzU83U66cgf+1ZYxIu+q9OEuA69zBgllzYnvKDK1H0WcJWo/yHgSJcpL8NU
 JXSAnycdeL7KsU7RmlplJzY15usL1rlxtVs9xOHgjQK3SnubpR3oxlE=
X-Received: by 2002:a05:6000:60a:b0:48a:fe3b:2d99 with SMTP id
 ffacd0b85a97d-48b1276809fmr5358089f8f.47.1790947379203; 
 Fri, 02 Oct 2026 06:22:59 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:22:58 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:42 +0200
Subject: [PATCH v8 08/12] video: mediatek: add mdp rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-8-2a6de7cf2a88@baylibre.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=8481;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=dVdlwf/T0Ja+wSgJO4VpVv10RSEOqnrJeAXCoj0bkMo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QETM/anNnyhTWrAeoGaUj6Pc6UzwQh57OYQBbr5AoqgiMY2CC1yMx+wecPq3KEFhIoqmxHhiEIF
 /k/5GIgQB1w4=
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

The MDP RDMA is the DMA engine reading the framebuffer on some
MediaTek SoCs, such as the MT8188. Two instances are used, each
reading one half of the frame; the second one starts at the middle of
the line (apply_offset).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_mdp_rdma.c | 185 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_mdp_rdma.h |  36 +++++++
 2 files changed, 221 insertions(+)

diff --git a/drivers/video/mediatek/mtk_mdp_rdma.c b/drivers/video/mediatek/mtk_mdp_rdma.c
new file mode 100644
index 00000000000..2f1e5922442
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video MDP RDMA Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_mdp_rdma.h"
+
+/* MDP RDMA registers (see Linux drivers/gpu/drm/mediatek/mtk_mdp_rdma.c) */
+#define MDP_RDMA_EN			0x000
+#define FLD_ROT_ENABLE				BIT(0)
+#define MDP_RDMA_CON			0x020
+#define FLD_SIMPLE_MODE				BIT(4)
+#define MDP_RDMA_GMCIF_CON		0x028
+#define FLD_COMMAND_DIV				BIT(0)
+#define FLD_EXT_PREULTRA_EN			BIT(3)
+#define FLD_RD_REQ_TYPE				GENMASK(7, 4)
+#define VAL_RD_REQ_TYPE_BURST_8_ACCESS		7
+#define FLD_ULTRA_EN				GENMASK(13, 12)
+#define VAL_ULTRA_EN_ENABLE			1
+#define FLD_PRE_ULTRA_EN			GENMASK(17, 16)
+#define VAL_PRE_ULTRA_EN_ENABLE			1
+#define FLD_EXT_ULTRA_EN			BIT(18)
+#define MDP_RDMA_SRC_CON		0x030
+#define FLD_UNIFORM_CONFIG			BIT(17)
+#define FLD_SRC_FORMAT				GENMASK(3, 0)
+#define MDP_RDMA_COMP_CON		0x038
+#define MDP_RDMA_MF_BKGD_SIZE_IN_BYTE	0x060
+#define FLD_MF_BKGD_WB				GENMASK(22, 0)
+#define MDP_RDMA_MF_SRC_SIZE		0x070
+#define FLD_MF_SRC_H				GENMASK(30, 16)
+#define FLD_MF_SRC_W				GENMASK(14, 0)
+#define MDP_RDMA_MF_CLIP_SIZE		0x078
+#define FLD_MF_CLIP_H				GENMASK(30, 16)
+#define FLD_MF_CLIP_W				GENMASK(14, 0)
+#define MDP_RDMA_SRC_OFFSET_0		0x118
+#define MDP_RDMA_TRANSFORM_0		0x200
+#define MDP_RDMA_SRC_BASE_0		0xf00
+
+/*
+ * Source format 2 is named after its byte order in memory, B, G, R, A, as
+ * the datasheet does. That is the same encoding as DRM_FORMAT_XRGB8888,
+ * which Linux' rdma_fmt_convert() maps to RDMA_INPUT_FORMAT_RGBA8888: its
+ * name only records that the alpha byte comes last, the R/B order being
+ * selected separately by FLD_SWAP (left clear here).
+ */
+#define MDP_RDMA_SRC_FORMAT_BGRA8888		2
+
+/*
+ * Fields used by this driver but not present in the upstream driver, named
+ * after the datasheet:
+ * - MDP_RDMA_EN[23:4] INTERNAL_DCM_EN: dynamic clock gating of the RDMA
+ *   internal blocks, all enabled out of reset (0x00fffff0)
+ * - MDP_RDMA_TRANSFORM_0[15] BITEXTEND_WITH_ZERO: extend the LSBs with zeros
+ *   when converting 8-bit data to 10-bit
+ */
+#define FLD_INTERNAL_DCM_EN			GENMASK(23, 4)
+#define FLD_BITEXTEND_WITH_ZERO			BIT(15)
+#define FB_BYTES_PER_PIXEL			4
+
+/*
+ * DRAM request settings, as programmed by Linux'
+ * mtk_mdp_rdma_fifo_config(): 8-beat burst reads plus the ultra/pre-ultra
+ * high priority requests that keep the RDMA from underrunning at high pixel
+ * clocks.
+ */
+#define MDP_RDMA_GMCIF_CON_QOS \
+	(FLD_COMMAND_DIV | FLD_EXT_PREULTRA_EN | FLD_EXT_ULTRA_EN | \
+	 FIELD_PREP(FLD_RD_REQ_TYPE, VAL_RD_REQ_TYPE_BURST_8_ACCESS) | \
+	 FIELD_PREP(FLD_ULTRA_EN, VAL_ULTRA_EN_ENABLE) | \
+	 FIELD_PREP(FLD_PRE_ULTRA_EN, VAL_PRE_ULTRA_EN_ENABLE))
+
+int mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			const struct display_timing *timing,
+			unsigned int pitch, bool apply_offset)
+{
+	u32 width = timing->hactive.typ;
+	u32 height = timing->vactive.typ;
+	u32 offset = apply_offset ? ((width / 2) * FB_BYTES_PER_PIXEL) : 0;
+	u32 fb;
+
+	/* the RDMA source address register is 32-bit only */
+	if (plat->base != (u32)plat->base) {
+		dev_err(dev, "framebuffer base %#lx is above 4GB\n", plat->base);
+		return -EINVAL;
+	}
+	fb = plat->base;
+
+	/* the stride register only holds FLD_MF_BKGD_WB bits */
+	if (pitch > FLD_MF_BKGD_WB) {
+		dev_err(dev, "framebuffer pitch %u is too large\n", pitch);
+		return -EINVAL;
+	}
+
+	mtk_disp_comp_write(dev, MDP_RDMA_EN, FLD_INTERNAL_DCM_EN);
+
+	/* DRAM request type and ultra thresholds */
+	mtk_disp_comp_write(dev, MDP_RDMA_GMCIF_CON, MDP_RDMA_GMCIF_CON_QOS);
+
+	/*
+	 * Set the source format. U-Boot's 32bpp framebuffer has no alpha
+	 * channel and the mixer blends this layer with alpha disabled, so
+	 * FLD_OUTPUT_ARGB is left clear as Linux does for such a source.
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_CON,
+			    FIELD_PREP(FLD_SRC_FORMAT,
+				       MDP_RDMA_SRC_FORMAT_BGRA8888) |
+			    FLD_UNIFORM_CONFIG);
+
+	/* no framebuffer compression */
+	mtk_disp_comp_write(dev, MDP_RDMA_COMP_CON, 0x0);
+
+	/* set base address */
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_BASE_0, fb);
+
+	/* stride comes from the framebuffer line length */
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
+			    FIELD_PREP(FLD_MF_BKGD_WB, pitch));
+
+	/*
+	 * each of the two RDMAs reads one half of the frame: size and
+	 * clip cover half the width, and the second RDMA (apply_offset)
+	 * starts at the middle of the line
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_SRC_SIZE,
+			    FIELD_PREP(FLD_MF_SRC_H, height) |
+			    FIELD_PREP(FLD_MF_SRC_W, width / 2));
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_CLIP_SIZE,
+			    FIELD_PREP(FLD_MF_CLIP_H, height) |
+			    FIELD_PREP(FLD_MF_CLIP_W, width / 2));
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_OFFSET_0, offset);
+
+	/*
+	 * Simple mode, plus the downstream way of feeding the 10-bit
+	 * pipeline from 8-bit data: BITEXTEND_WITH_ZERO zero-extends each
+	 * component, instead of MDP_RDMA_CON's FLD_OUTPUT_10B used by Linux.
+	 * Only one of the two is needed; do not switch to FLD_OUTPUT_10B
+	 * when re-syncing with Linux.
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_CON, FLD_SIMPLE_MODE);
+	mtk_disp_comp_write(dev, MDP_RDMA_TRANSFORM_0,
+			    FLD_BITEXTEND_WITH_ZERO);
+
+	/* enable engine */
+	mtk_disp_comp_write(dev, MDP_RDMA_EN,
+			    FLD_INTERNAL_DCM_EN | FLD_ROT_ENABLE);
+
+	return 0;
+}
+
+static int mtk_mdp_rdma_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	/* the RDMA is a DMA master: it feeds from an SMI larb */
+	return mtk_disp_comp_get_larb(dev);
+}
+
+static const struct udevice_id mtk_mdp_rdma_ids[] = {
+	{ .compatible = "mediatek,mt8195-vdo1-rdma" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_mdp_rdma) = {
+	.name	   = "mtk_mdp_rdma",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_mdp_rdma_ids,
+	.probe	   = mtk_mdp_rdma_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_mdp_rdma.h b/drivers/video/mediatek/mtk_mdp_rdma.h
new file mode 100644
index 00000000000..63061d034a4
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video MDP RDMA Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_MDP_RDMA_H
+#define _MTK_MDP_RDMA_H
+
+#include <linux/types.h>
+
+struct udevice;
+struct video_uc_plat;
+struct display_timing;
+
+/**
+ * mtk_mdp_rdma_config() - configure an RDMA to read one half of the frame
+ * @dev: RDMA device
+ * @plat: video uclass platform data, holding the framebuffer base address
+ * @timing: display timing, giving the frame size
+ * @pitch: framebuffer line length, in bytes
+ * @apply_offset: read the right half of the frame instead of the left one
+ *
+ * Each of the two RDMAs of the pipeline reads one half of the XRGB8888
+ * framebuffer and feeds it to the mixer.
+ *
+ * Return: 0 on success, -EINVAL if the framebuffer is above 4 GiB or its
+ * pitch is too large
+ */
+int mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			const struct display_timing *timing,
+			unsigned int pitch, bool apply_offset);
+
+#endif /* _MTK_MDP_RDMA_H */

-- 
2.55.0

