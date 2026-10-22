Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F8606A31D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BABLeBo8;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N21dHqKl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A89680599;
	Thu, 22 Oct 2026 14:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5CPPVgih9dp; Thu, 22 Oct 2026 14:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D81080DBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677819;
	b=m70dS4yttuoi5PrvDqR9shZoLkjF5nYaJU5jw+ZSwBZfwY86abgzJhZCJag4S3+Or95Y
	 nWDB8xFnTY9e1SP2HWZ+2ywKT6R9OccU9W0Vaqx1dzSbUDG+uA+pcTxGPic1JixaXsgyn
	 3ZN1I/7NYu8p1drYOnLf6SAXOoRywfIfvizPguwd4L8fZ9sZGTC4kBiGIFhsnbjRFoJIn
	 Pjj8y4ScRWEoCd+9YdIlrrZMPEIwMR7C8NRcgYLoqaigawJqauEYvFf7k1qCvrmX6UdxN
	 L0aWPYnpr4NfNaVk3oD5NxD09hVC+x7D4IGZpWtRLCfRUFRxMRYKWfDxylSByWcAqlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677819;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1Ran0bEU4c8O6OGiFQMy6g1srnTKFaaE0cuCE/cYbCc=;
	b=qh31nuTQ3jzfCjamvmww4hhy3CXgqt31yhakBbR+Q25fiIJnIUzEIBS6DZeXd2oEVA2Z
	 Kg0tMzcaq7l/tX+dzcViMF3Oae2xtlyeMn+XdneL42cVN6kREd5w/AzrkZM0uFU0rVO3I
	 0KM1eWFDMLCI6gfHaSGF5z8ghp+0EjIquiXW0V6lsvVH6DoPqeA27euJy1eA6vEBeER4b
	 M/DPZt4uMKdOCCSZXrK9mAUVRjO7zZmPknkLWZMjL1UIwOTjWktHHFHA/V4ZD1fbi6CI1
	 Q1bOp/u8wu+LnM3OmnOa+ZEzAjH+I9h6oMEH2DcsD28wcaWfwNOShDdoD80XhmQlRQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N21dHqKl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677819;
	bh=1Ran0bEU4c8O6OGiFQMy6g1srnTKFaaE0cuCE/cYbCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BABLeBo8YDYFN56bwvykwsn41D5SrsOqIh+3uIAGxPiuIurRs7zSSuzm8sIuFkQOr
	 EYIjSfCsS95oLaadOzeberx77CG16kLKCd/g4n4SvgYI9VYxfskFR7FL3XH7BKAqzo
	 +v5l62f56+ZCRiTVDF4wmeSRmorKLCMGE8XLfoE5cQEq9/gAiydZSdIaIIYHPjtjMf
	 8eSrIriqTgSKOJ0Gg4mqGbY8GQx/seyozDAwwGAAtH3N5GBDJCCA+2tyJUuO63SLtb
	 gM5O4rlPFipTiYY1nJfsw41KC6AIeHux+aT2vJXLvvgGHHw+I26FJh2YDotucofwh8
	 kNcf6a/ggwJgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D81080DBA;
	Thu, 22 Oct 2026 14:03:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FBA823A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D0E480DBA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zAuD_JX_-DHC for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3457580D66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792677811;
 b=mAtk/2y9fz38bIno437wm+8SY3isChE4yAdvUb06NBW/rbj1GAQoT7EBqoXIOx5sVTBd
 6Hw/yuTy5Gz5zUw6Z1ISJJHCS7VSp0XgY4VMyiWwen6dUDMkaJGZrp9QbaoN3uhP6BoXb
 80nimis6xI7FZ2e15dnpgidLOwhymskn1sEYlW5C0MLsPVwwNoHOiD7Y0rrvT0P1ZrVoH
 okCl6cMSFOtEMTMixTD/qh38ccyk0gkwjnMkKVePRmOTtcNNf/1eq51OdTKZYIqzu7li9
 6G3vzu0NIrECyXDwCEtL7S1Ir8Bg1dO9pvSRLt9AnQvHyp+S2GMOKSUhq/7IbvYxY5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677811;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=1Ran0bEU4c8O6OGiFQMy6g1srnTKFaaE0cuCE/cYbCc=;
 b=g2VCwTrmuCcZRealtpbbdU4/aNG7xGyFQ0qAyHgSoECdi8gwkpFjss3TbUOMT/u+Bql2
 GzuuDRsADbT0ZLvuIdpgISh/kt2gSagKFpgAUrKrmpGB1AiXo99NJookn1znLGRRNZfbG
 DGaZ203xrQaWXZjcvTubl6bLB5EAFGbK2A7ch5BN55868sQ8Xw2FAdgZgDeCrNDTVrpRT
 0U+hHnOalnd0RbzKkinilDuC3JXHT+z48o+/iFhE2zeR4Sz47CGJ218D0/LuuN7qoAqX6
 AHbDcFg2qFUi6sWmHK0vq/Lb5+36auaHWEaOxzdf3/cj537KlT0WPiwFJlxIfWdf23g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N21dHqKl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N21dHqKl
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3457580D66
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:30 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso20016955e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792677808; x=1793282608;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Ran0bEU4c8O6OGiFQMy6g1srnTKFaaE0cuCE/cYbCc=;
 b=N21dHqKlX9JhJTuoKk8UMEMcDdR5vkEH7jP1PAtDFmBLfJhXOQIVboW3o83Hmv3g4j
 A16sJQAe+sT5h337ytH9zUn0po4ojjUmF1rG6oRoiNt3LCgvb/JmOVdHMof9BKCYkIEM
 sPgQDEZ59kA3BwEh0GUfmgUvBAansqdt0nZ0jsceW7a7xcz62ytt2VX+s7Q9w95fQaH3
 wPic85Vz6aaCrCI4QsbvWYPbfNW4uJAyP7kftmRggwuzif8opvcymYsjcleXDWpvUstv
 ZuiueBl9MuMxJ0JPr9j6/SEQ4ejdcQXpyHXMhlT/R+pspSFU3HqouOXcVHqJxyzfM6N9
 uIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792677808; x=1793282608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Ran0bEU4c8O6OGiFQMy6g1srnTKFaaE0cuCE/cYbCc=;
 b=VxcaUR1gFGtKzJq7kQ+0wWhTmvnw/qgfo9C8Wpdaj4HgqQkK6WJUfPsPiNH7Y4nMyG
 ronqwTqTyK/OafE/YfjSrpfNIs3qKeWyN4FpcDutpWbwVoFj9ImeYRhD7eG/7FXKimNs
 07hbrqzubAQqkfFwMzi+bLf9GHu+e2A3w6UKqbr84GyKFEktoxtmBGmlftkgnARv0wXH
 QIXrBGBc/gVZfUGA3m7J9jFDdJuHRMr3dC5pabvidv/MCVi9TR040XzeXjk7BRsK4vC3
 tOLX7++buYAcJRzIzOAwTIQlR3N6Vdm53hEDuDTKoo4FGH6GG73iAxlhMS6zCg4xe4l4
 2QPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0H7HzUV5zj4WpwMuxvYei7OjCg6zfCrKcm4bc9NDQXZ8zjfJgPf1JLR2/hfK3RiH7Dq866O4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJdca334sEMqq6C9tiSR5l6UzwJXn0OLv3UC+vQgUuq1NoTNip3
 mxktYkTlKvPSaRmS7zKisCvLhaN/f/Y//CMStODU7RwNqp8tzubYkSIPeT+nsGEq+5M=
X-Gm-Gg: AYBFou0ubLpi/grIKp9C2NLSsebz543HU0i3KFfnZTbT+RS1lBRN0sXWVtfbJRws3Zr
 TfhjpnGxxR3gh8EkWSOKM1l9bOAiah6kDpPWJHjM2koR9BDI9YPLMBHlHbdh7/pcrz3MPzykc/P
 dOXE2N1eBbs07WWpkR3WRUC5QfzrqHgGp8aumnC+EdaW7GWM9ydz9hj/NhgQ7JhJHSpzZxevPkj
 W2LhcA5TFLKKiyIdlwEDWQx+KT+nsoEblFa8VcK8YTmIayz8E4/8qb5K8LFOSYvBBSyaF8GhG19
 kzcmFB1B4xbHMmI6JH2C0zM4nAxImrxQtuCkgtcPsW5VFHJJXFuE26QtZWkqJIlrFbxX/RwOzYs
 IUpZYRity2qkbZi7IyQpaxl9wTJ3QkrZCkWSRshiMIc9kv1s5qKXN/BSS5SVZitcfanaAKXcMHn
 yPLQEOtTKwhFU6Ibcv/Z4e0AH0cjF9hLMTXeflBbthQHGHidlricwu7ksc1vW9qdTuAZGpkWTLI
 LpPQMhxkTc7gIIyaNQ/USHeoEyu0Hx2IKDVWVEoWH6hvseTn+/MfwuEdwtCFqF+YGHeG53AdR7A
 Upk4sWEzvkjssi0doqLVTU5HXamvr2yNwKZ0YDHz/aSzo3lK3JzDnZUoqX7QjjFiZ48/TL193Sj
 80vH+EtrU1i09ZAZjDQHYq7+trur3i/CqsSka
X-Received: by 2002:a05:600c:6748:b0:4a2:1a:a122 with SMTP id
 5b1f17b1804b1-4a2001aa387mr94614455e9.9.1792677807321; 
 Thu, 22 Oct 2026 07:03:27 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-f269-609e-a542-3b36.rev.sfr.net.
 [2a02:8434:7c41:c701:f269:609e:a542:3b36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b66f6bsm102604335e9.15.2026.10.22.07.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:03:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 22 Oct 2026 16:03:45 +0200
Subject: [PATCH v3 2/3] power: domain: mtk: add MT8365 power domain
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-mt8365-add-power-domain-v3-2-90b82ec1e7fa@baylibre.com>
References: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
In-Reply-To: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add power domain support for MT8365.

The domain tables and bus-protection sequences mirror the Linux
mt8365-pm-domains.h data available at commit ffeebf7587f5
("pmdomain: mediatek: Convert all SoCs to new style regmap retrieval")

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8365-power-domain.c | 236 +++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 66c448033ee..3b816ed3bed 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_TARGET_MT7623) += mt2701-power-domain.o
 obj-$(CONFIG_TARGET_MT7622)$(CONFIG_TARGET_MT7629) += mt7622-power-domain.o
 obj-$(CONFIG_TARGET_MT8188) += mt8188-power-domain.o
 obj-$(CONFIG_TARGET_MT8189) += mt8189-power-domain.o
+obj-$(CONFIG_TARGET_MT8365) += mt8365-power-domain.o
 obj-$(CONFIG_TARGET_MT8366) += mt8366-power-domain.o
 endif
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
diff --git a/drivers/power/domain/mt8365-power-domain.c b/drivers/power/domain/mt8365-power-domain.c
new file mode 100644
index 00000000000..460d6758703
--- /dev/null
+++ b/drivers/power/domain/mt8365-power-domain.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dt-bindings/power/mediatek,mt8365-power.h>
+#include <linux/bitops.h>
+
+#include "mtk-power-domain.h"
+
+#define MT8365_SPM_PWR_STATUS			0x180
+#define MT8365_SPM_PWR_STATUS_2ND		0x184
+
+#define MT8365_INFRA_TOPAXI_PROTECTEN_SET	0x2a0
+#define MT8365_INFRA_TOPAXI_PROTECTEN_CLR	0x2a4
+#define MT8365_INFRA_TOPAXI_PROTECTEN_STA1	0x228
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_SET	0x2a8
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR	0x2ac
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1	0x258
+#define MT8365_INFRA_TOPAXI_SI0_CTL		0x200
+#define MT8365_INFRA_TOPAXI_SI2_CTL		0x234
+#define MT8365_INFRA_NAO_TOPAXI_SI0_STA		0x0
+#define MT8365_INFRA_NAO_TOPAXI_SI2_STA		0x28
+#define MT8365_SMI_COMMON_CLAMP_EN		0x3c0
+#define MT8365_SMI_COMMON_CLAMP_EN_SET		0x3c4
+#define MT8365_SMI_COMMON_CLAMP_EN_CLR		0x3c8
+
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0			BIT(1)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M1			BIT(2)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S			BIT(6)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB		BIT(13)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB		BIT(14)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0			BIT(21)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M1			BIT(22)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0	BIT(10)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1	BIT(11)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG			BIT(25)
+
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0	BIT(16)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1	BIT(17)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST	BIT(18)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST	BIT(19)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV	BIT(21)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP			BIT(2)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST	BIT(20)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB	BIT(24)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO	BIT(27)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M	BIT(28)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M		BIT(30)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S		BIT(31)
+
+#define MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S			BIT(6)
+#define MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1			BIT(5)
+#define MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED		BIT(24)
+#define MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED		BIT(14)
+
+#define MT8365_BUS_PROT_INFRA_WR_TOPAXI(_mask)			\
+	BUS_PROT_WR(INFRA, _mask,				\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_SET,		\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_CLR,		\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_STA1)
+
+#define MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(_mask)		\
+	BUS_PROT_WR(INFRA, _mask,				\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_1_SET,	\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR,	\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1)
+
+#define MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(_port)		\
+	BUS_PROT_WR(SMI, BIT(_port),				\
+		    MT8365_SMI_COMMON_CLAMP_EN_SET,		\
+		    MT8365_SMI_COMMON_CLAMP_EN_CLR,		\
+		    MT8365_SMI_COMMON_CLAMP_EN)
+
+static const struct mtk_scp_domain_data mt8365_scp_domain[] = {
+	[MT8365_POWER_DOMAIN_MM] = {
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = 0x30c,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M1 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1),
+			BUS_PROT_WAY_EN(MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S,
+					MT8365_INFRA_TOPAXI_SI0_CTL,
+					MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED,
+					MT8365_INFRA_NAO_TOPAXI_SI0_STA),
+			BUS_PROT_WAY_EN(MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1,
+					MT8365_INFRA_TOPAXI_SI2_CTL,
+					MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED,
+					MT8365_INFRA_NAO_TOPAXI_SI2_STA),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S),
+		},
+		.caps = MTK_SCPD_STRICT_BUS_PROTECTION,
+	},
+	[MT8365_POWER_DOMAIN_CONN] = {
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x032c,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV),
+		},
+	},
+	[MT8365_POWER_DOMAIN_MFG] = {
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = 0x0338,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M1),
+		},
+	},
+	[MT8365_POWER_DOMAIN_AUDIO] = {
+		.sta_mask = BIT(24),
+		.ctl_offs = 0x0314,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(12, 8),
+		.sram_pdn_ack_bits = GENMASK(17, 13),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M),
+		},
+	},
+	[MT8365_POWER_DOMAIN_CAM] = {
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0344,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST),
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(2),
+		},
+	},
+	[MT8365_POWER_DOMAIN_DSP] = {
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x037C,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S),
+		},
+	},
+	[MT8365_POWER_DOMAIN_VDEC] = {
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x0370,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(3),
+		},
+	},
+	[MT8365_POWER_DOMAIN_VENC] = {
+		.sta_mask = BIT(21),
+		.ctl_offs = 0x0304,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(1),
+		},
+	},
+	[MT8365_POWER_DOMAIN_APU] = {
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x0378,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(14, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 15),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST),
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(4),
+		},
+	},
+};
+
+MTK_SCP_SOC_DATA(mt8365, mt8365_scp_domain);
+
+static const struct udevice_id mt8365_power_domain_ids[] = {
+	{
+		.compatible = "mediatek,mt8365-power-controller",
+		.data = (ulong)&mt8365_scp_soc_data,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mt8365_power_domain) = {
+	.name = "mt8365_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &mtk_power_domain_ops,
+	.probe = mtk_power_controller_probe,
+	.of_match = mt8365_power_domain_ids,
+	.priv_auto = sizeof(struct mtk_scpsys),
+};

-- 
2.56.0

