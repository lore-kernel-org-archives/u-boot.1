Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CA0CA5FA7
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D19980EC6;
	Mon, 28 Sep 2026 15:07:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQtnz_73shNE; Mon, 28 Sep 2026 15:07:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C5CE480E31
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608060;
	b=oDW6W4WoNRqPJ+qs5p305WmGajy7HA22u5gSqIUuGFeZ3FS/t5NIXS5NdcNmidsMQV7S
	 eIkjhXV3cB3Uc+cKaEHHkz+zhIrZ++Ja1SKhbZUK8Fy4i1dbCihdITWErzRI5OAQAsP3q
	 f5rdl4Cou0ZVeNXK3KUQLDFHbXU4c6IacAmuAyLjp+tvK/Bk1V+JneyjKwq0jvT0Y0VC0
	 5n2f8mgWhxoELbMcLApBTJbACwz2GOOQgofilByxBvKyQs8ytYY+cq7Z6EcIqzxulmP8G
	 MobCHhLPkxuHG8yovk8VTru2Hu37cKy7x7cfISYE2D+MYGJ6mccd+jcVPHHEQpr7oSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4Zef1f1woJdZQahoDHW4KMcaXHOIdrA8mycAr1Is4Lo=;
	b=qd7ai2yiR7jhBkJhbT8XZ46LSJDFetcTxgKe5R1iaVY2xxClAcsFd+5bbKGUZn3Ug2np
	 PqvY8jnGzb4zFXfKXsJO+cSVvQp68RqwyhPZ8lv1u0K6eTPYL0PcVPGv/1/pXVGBA5aJJ
	 FXSUFw3daOlovAYeyK9GFAkmvmkA/2BkmnN3hTu6Qx97qeV4bNk+/AfOb1UuM5ZsK0Vb9
	 JKaZbYD5xNCN1yHtbLScE1zEfxm35gBU1ZhlFpFhdh6wD6U9GDIW9gi6dOkhdUuIcjgJg
	 d81g4G2WWUu4UIrXEGYa4jLERaujLFNBPf/v8BiBSe/vV0kIchhPxv5C6HmXwqxBe8w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608060;
	bh=4Zef1f1woJdZQahoDHW4KMcaXHOIdrA8mycAr1Is4Lo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QAQiQJgT4epwI7YYEm2zpFk7egChHWvdlnsUs1pe915BvXr/KFUjFu43kqoW5bIRO
	 h8CS2gaD8+t7rwIXMOCt434pD8pHKk0/+EU8luLfVPCEFOpun5QWpBRH2y3PhxUDCG
	 qlUqTR1cZvxi5WVxjvXkzsCU6TLuq5yj9mpk3hq0lFLt7oraijmmPvvNlJKYDA2v61
	 HgpTpfbUodKMncxhP4OaOYV4Q4Z5K2sLTZvkx8yquba18cZzMhUqIexovr2Xi4D/uE
	 smYvzNoVW6rUYoPgHWB7J5hRsfwoMxUHg1GKZh4ZQKbCjF4JH4v2IH4rsGyZvRHrcd
	 5f6HyLNvmsZaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5CE480E31;
	Mon, 28 Sep 2026 15:07:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1333E3A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04EDD606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6fNg9SNppkJj for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:07:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E7E23606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608058;
 b=FxIV/b+1EQgR6egDdlyULxE6AL802VISImvqOcmxVDLVEAe3pejqZAgPemKN8dJ8RoP7
 Eidc9Q5Z2HP1oJrzUawGku0oweaale9LDK2Ik2a9yH1/AWPj+YcTO2V9vtrjUNuYZoqnN
 wLqE7Qmce63ToYZOBCfqkbXV+Fi+L8jZyEopNJglrS7MSMR/EetBZ1y8Ig/uLRvzwMynk
 epiSxyEEF1nHnl9q2po/K758pxFPAw55f3VlMJuQUDX7AqkBteqEi0sgnvm8XAUiLeJHR
 acKzGSBsh8NMQQgT9ckFT8f10U3S/seru1rJmJfNkH+yF25NvzGEn+XmSzOPbdlKNfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608058;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=4Zef1f1woJdZQahoDHW4KMcaXHOIdrA8mycAr1Is4Lo=;
 b=JhnqABAY8Ch2DnRyJcJV/1v+StKODPMCBQID1NqHB/ZTr9mrdtJwntxhRcAV2MnzUjxo
 UXtgOAtw5UL7E7nIyeelrCTLVAuI3vnEcTRn2TvRrUP6h+O8myEtZsXEGRC/zcyq7DM11
 5TQPVKzm2M/Yf+hX0pGL6E77/zTlOzysk9vH2a/Po925znUMzhzllXzpSg3nB4YoIxyqG
 ziWnT6pdqf67HWS6M9PAwX3Hevjf5v6XDbhj5fqD2TUw/D4GOiFS531/lPOE5HuNO9MT6
 yArPk3Ad5DRZydWHUlCn8R85sAbsNZE8u19VyasUYeYcw06eN/hEKqNTkIcd/uUjX/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AlfPofsw; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AlfPofsw
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7E23606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:35 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso19235985e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608053; x=1791212853;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Zef1f1woJdZQahoDHW4KMcaXHOIdrA8mycAr1Is4Lo=;
 b=AlfPofswR9v7WWwNUESHLFkR2+Ym1uqaRj0jRoucN4bm737fbxiIOY+y/wVfCJkcuc
 3F+HAKdQfXGqL3WT/pwPZXQlj9sk3vrrTvFg62xHxEYTue8x9TGARStdgRtXO69jcTsG
 LXECkXUw4yjok5VtVG5XEuEENKglUXLbJOfxMwaRF9Wjc+LQMChwH6PLQmODtL/Pif+B
 sZKMAfs1Jk7RkYS9ggeFf9sPyAEI2xDYSU2CGMCGuRFAv6/MZF66r2GvuuMIesekvceD
 ERxd77Kv0At6LqYkwVrNYFoxwDy//fV0YYsP2QIfZY7acs2MYmJ+FqgHSRoDm/nIA7KF
 5U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608053; x=1791212853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Zef1f1woJdZQahoDHW4KMcaXHOIdrA8mycAr1Is4Lo=;
 b=DPG3NMZOpTNP4Il/oxIL2/ZUVGExEkmS92SKI27jXA4pSZ54/aJ2PJdWJS1i0C7Dfp
 cvk3sKkDgy23s7ckY9Qm6sSeqBQLwRUTXO8V4NY10d9C1gciFkzgCZH8emgTXuoYvulZ
 dTShkTCqyXmlu6mn4NRWOMvffOix6DJaFdZTZB8JlU4IXsygB41n0/1WW7fEwDcPsLM6
 CSyIG9RgMZJkyuE0CMQStp6DlvK1ltAOsxZkz9pstJro8U2yhjfDwtd0ubLcJKDgqs7z
 c6Y4zmYWko+hsvfiwU4xGgbIGO2BrXweFV84pU4R9XpnGO2YwloKZLLUNk8fAJ0Lj/36
 2ijQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMc7Shz8OhmRzI9yL2+B0vjxAOBpEqNPJ1fkjo2txXMBK2XXp205C3HFdpL3Bl8Z9kYslDoQU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mmRDlxiNRnY0STElORZP/OMZxCxZnpn/ATF7kXXrXbj289uvpH
 J/2+muyo0KoXn30GPdK2tOD4iI/Tavj+8pvyYUMWJnLyVgZKrCTNqHzCt/BirY1VhnM=
X-Gm-Gg: AYBFou3ASWxF9VUM5DusxHoGDRlxrM8lVg5ZxXhhHDEzmxYoJSBqxaDfVfREvmtPvBj
 zHTtBKv2OYIqOtxIrNDs8+W7hnJA3YVjOwyXTuxXop9JlLCITytynwbUnV3mb+Ebed1e6OjPw8D
 vBeu88RAh+QpjyexZCDBUW+UEvVSNCDs5cc0iYyOsh6V9LQQ7fxGno7HsMQ+R+xTO3zPkTtwcfq
 WfEQKETV0OJyiCWCRyzIieRu1wc7hC3D02J+mDIla5nw0FiuFEgKM/Ku+x5llylg2ZVEvqFcIQC
 UiI2U22rp5QT9zikxq1G8Up15eOuPmL5K1PoXyxBV9DycPAW5parCVA5igPW4eGmYZFX0DlpUh8
 HJQrf06sOaikJB8/4DAgGFwdS9cAT9va979QuBh4IEM+3jhl/VJFhxvqEr/dkBURTEUkCn/uBqs
 HGxRJn7lV4WVDdK0i3oZVffyf1kpKiZlNQefhu3jWi7FgEW0qxXQe1Cd2wGqEmhYDMfZphCFtLk
 V7Dx/3aE93sFy99mddMX2hz5j70pJhEJdZGngj7LN8xWdgc7pmsex3WtewLgEB8wxxe2H7j7GM4
 VhUcLEYfnkU6++5dXcG+HbpLZB3x4QLqZW0ycacUpf+/gWOqp8vsF1c=
X-Received: by 2002:a05:600c:3b1b:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49fe66c8a1emr256129515e9.2.1790608053391; 
 Mon, 28 Sep 2026 08:07:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:07:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:46 +0200
Subject: [PATCH 09/13] video: mediatek: add ddp component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-9-212f51b1742b@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
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

The display data path (ddp) is the set of muxes of the mmsys register
space routing the components of the video pipeline into each other.

Add the route needed to bring up a splash screen: the overlay to the DSI,
either through the MT8365 colour pipeline or straight through the MT8366
crossbar.

The muxes have no device of their own: they live in the mmsys syscon
window, which the DSI driver maps and hands over, so no compatible is
added here. The MT8365 offsets and values are the ones of the Linux
mt8365_mmsys_routing_table; the MT8366 ones come from its downstream
mmsys, that SoC not being upstream yet.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ddp.c | 130 +++++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ddp.h |  22 +++++++
 2 files changed, 152 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ddp.c b/drivers/video/mediatek/mtk_ddp.c
new file mode 100644
index 00000000000..6f6e7626189
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ddp.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Display Data Path
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+#include "mtk_ddp.h"
+
+/*
+ * mt8365-generation mmsys: the path is built out of direct muxes, one
+ * register per input or output. The offsets and the values are the ones of
+ * the Linux mt8365_mmsys_routing_table.
+ */
+#define MT8365_DISP_MS_IN_OUT_MASK			GENMASK(3, 0)
+
+#define MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0xf3c
+#define MT8365_OVL0_MOUT_PATH0_SEL				BIT(0)
+
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL	0xf4c
+#define MT8365_RDMA0_SOUT_COLOR0				0x1
+
+#define MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN	0xf50
+#define MT8365_DITHER_MOUT_EN_DSI0				BIT(0)
+
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN	0xf54
+#define MT8365_RDMA0_SEL_IN_OVL0				0x0
+
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN	0xf60
+#define MT8365_RDMA0_RSZ0_SEL_IN_RDMA0				0x0
+
+#define MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0xf64
+#define MT8365_DISP_COLOR_SEL_IN_COLOR0				0x0
+
+#define MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0xf68
+#define MT8365_DSI0_SEL_IN_DITHER				0x1
+
+/*
+ * mt8366-generation mmsys uses a multi-stage crossbar instead of the simple
+ * direct muxes above.
+ */
+#define MT8366_DISP_OVL0_BGCLR_MOUT_EN			0xe24
+#define MT8366_DISP_OVL_BGCLR_MOUT_MASK				GENMASK(1, 0)
+#define MT8366_MOUT_OVL_TO_BLENDOUT				BIT(0)
+
+#define MT8366_DISP_OVL0_OUT0_MOUT_EN			0xc10
+#define MT8366_DISP_OVL_OUT0_MOUT_MASK				GENMASK(2, 0)
+#define MT8366_MOUT_DISP_OVL0_TO_DISP_RDMA0			BIT(1)
+
+#define MT8366_DISP_RDMA0_SEL_IN			0xe04
+#define MT8366_DISP_RDMA_SEL_IN_MASK				BIT(0)
+#define MT8366_SEL_IN_DISP_RDMA0_FROM_DISP_OVL0_OUT0_MOUT	0x1
+
+#define MT8366_DISP_RDMA0_RSZ0_SOUT_SEL			0xe00
+#define MT8366_SOUT_DISP_RDMA0_RSZ0_TO_OVL_PQ_OUT_CROSSBAR1	0x0
+
+#define MT8366_OVL_PQ_OUT_CROSSBAR1_MOUT_EN		0xc78
+#define MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK			GENMASK(5, 0)
+#define MT8366_MOUT_OVL_PQ_OUT_CROSSBAR1_TO_COMP_OUT_CROSSBAR4	BIT(4)
+
+#define MT8366_COMP_OUT_CROSSBAR4_MOUT_EN		0xd80
+#define MT8366_COMP_OUT_CROSSBAR_MOUT_MASK			GENMASK(5, 0)
+#define MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DSI0		BIT(0)
+
+static void mtk_ddp_mask(void __iomem *base, u32 offset, u32 val, u32 mask)
+{
+	u32 tmp = readl(base + offset) & ~mask;
+
+	writel(tmp | (val & mask), base + offset);
+}
+
+static void mtk_ddp_ovl_to_dsi_color_pipeline(void __iomem *mmsys_base)
+{
+	/* OVL0 -> RDMA0 */
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
+		     MT8365_OVL0_MOUT_PATH0_SEL, MT8365_DISP_MS_IN_OUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN,
+		     MT8365_RDMA0_SEL_IN_OVL0, MT8365_DISP_MS_IN_OUT_MASK);
+
+	/* RDMA0 -> COLOR0 */
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN,
+		     MT8365_RDMA0_RSZ0_SEL_IN_RDMA0, MT8365_DISP_MS_IN_OUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL,
+		     MT8365_RDMA0_SOUT_COLOR0, MT8365_DISP_MS_IN_OUT_MASK);
+
+	/* COLOR0 -> CCORR0 -> AAL0 -> GAMMA0 -> DITHER0 -> DSI0 */
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
+		     MT8365_DISP_COLOR_SEL_IN_COLOR0, MT8365_DISP_MS_IN_OUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN,
+		     MT8365_DITHER_MOUT_EN_DSI0, MT8365_DISP_MS_IN_OUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN,
+		     MT8365_DSI0_SEL_IN_DITHER, MT8365_DISP_MS_IN_OUT_MASK);
+}
+
+static void mtk_ddp_ovl_to_dsi_crossbar(void __iomem *mmsys_base)
+{
+	/* OVL0 -> RDMA0 */
+	mtk_ddp_mask(mmsys_base, MT8366_DISP_OVL0_BGCLR_MOUT_EN,
+		     MT8366_MOUT_OVL_TO_BLENDOUT, MT8366_DISP_OVL_BGCLR_MOUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8366_DISP_OVL0_OUT0_MOUT_EN,
+		     MT8366_MOUT_DISP_OVL0_TO_DISP_RDMA0,
+		     MT8366_DISP_OVL_OUT0_MOUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8366_DISP_RDMA0_SEL_IN,
+		     MT8366_SEL_IN_DISP_RDMA0_FROM_DISP_OVL0_OUT0_MOUT,
+		     MT8366_DISP_RDMA_SEL_IN_MASK);
+
+	/* RDMA0 -> COMP_OUT_CROSSBAR4 -> DSI0 */
+	mtk_ddp_mask(mmsys_base, MT8366_DISP_RDMA0_RSZ0_SOUT_SEL,
+		     MT8366_SOUT_DISP_RDMA0_RSZ0_TO_OVL_PQ_OUT_CROSSBAR1,
+		     MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8366_OVL_PQ_OUT_CROSSBAR1_MOUT_EN,
+		     MT8366_MOUT_OVL_PQ_OUT_CROSSBAR1_TO_COMP_OUT_CROSSBAR4,
+		     MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8366_COMP_OUT_CROSSBAR4_MOUT_EN,
+		     MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DSI0,
+		     MT8366_COMP_OUT_CROSSBAR_MOUT_MASK);
+}
+
+void mtk_ddp_ovl_to_dsi(void __iomem *mmsys_base, bool has_color_pipeline)
+{
+	if (has_color_pipeline)
+		mtk_ddp_ovl_to_dsi_color_pipeline(mmsys_base);
+	else
+		mtk_ddp_ovl_to_dsi_crossbar(mmsys_base);
+}
diff --git a/drivers/video/mediatek/mtk_ddp.h b/drivers/video/mediatek/mtk_ddp.h
new file mode 100644
index 00000000000..4c74456c746
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ddp.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DDP_H
+#define _MTK_DDP_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * mtk_ddp_ovl_to_dsi() - route the mmsys muxes from the OVL to the DSI
+ * @mmsys_base: mmsys config register window
+ * @has_color_pipeline: go through the color, ccorr, aal, gamma and dither
+ *			blocks, rather than straight from the rdma to the DSI
+ */
+void mtk_ddp_ovl_to_dsi(void __iomem *mmsys_base, bool has_color_pipeline);
+
+#endif /* _MTK_DDP_H */

-- 
2.55.0

