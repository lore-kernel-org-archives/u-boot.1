Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71FAC982C5
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 14:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 891F560837;
	Wed, 16 Sep 2026 14:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AlfgYwSbn042; Wed, 16 Sep 2026 14:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 84EA3607ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789570643;
	b=Pa0UakoxVRgx8pOuso4joCbYzXB6a6SuZu4NRmMKSeYIaO8PZzqoZJEJX7KI36HNIa/b
	 cRnqVc0jPVWbSemf4sLl+1N+KePG/zQdl2K6gX73+K0ZgaRKGhdF/txGGMvAYZf3gOyOu
	 lVrSUG80TiWKHVMz9T4fXfe5ZrtRKsjYr5HWnOgTrVU4vCSNPCSMkhl9i3IAfQ0DXwPow
	 KMWv0iUDWzc2/VASoA/U5vZt3U0qCYPSF6QBuQsFWhd3FlbzKKfUfreL6/DHnWjcBVFEj
	 hJ2ZStzScGgfwbsw+fcq0hUpnplEvuZ/G4j6yKUgoLwbLn+g2Y3v18/zRWq9Kih31Tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789570643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3qf/3hef7IzRQO6Q6b9QGoZYFB18gXVF94MVO8k0fX0=;
	b=V5mFufWExS8t6Tgzod6J0YlKa6S1xsAxd52jSYRlc87dxlfDD1wG9ZZAlDhk5WDyEefT
	 Dz2/sRqXdLzQvVICokWPhgpHM3ZZxBj9aki1baJuojwoATQ2q5rhpVP1vHp7lEIA0cHdx
	 1CEK3H3waZphPE6ROKhAMQq/I4UyBirakiiEMg00bB/2JQHAF3ertlZoQw89SHLWhuV33
	 pdHfkVSCdomxpCbbkdYDSXnxH6dga8XqONWxAVTLMKUCha8AI5440/LOg0YNoEa5wKl/Q
	 FHLBbqryIWvvBPGwIZiQuShZPNzxW6UVwDBo0kSVNAs7nfQeULzX3Mv2EhxA6kGmQog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789570643;
	bh=3qf/3hef7IzRQO6Q6b9QGoZYFB18gXVF94MVO8k0fX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eu2YUAJhIyQKTywZbN9YVa59t0Gq5Ly3DviUkM09yB06MjNYAo2jfXSJ9YY2A0u+w
	 j81BRjtewXYZMoRdSuCxoy5SYxtTFFDLtr+pQvebBioaaxaxLOHcHVT1ODhVtugBuy
	 9Uio4TMcqCQ2acZDO9cBbO7Jn5wHYX3Zy4VxJA+404zosOK5bEPFLjS1hw19ThYyy3
	 eP+OK1hu/PUip3etdf87bBECTZu4t3SB+UyZsS8NBcPbfHy/0l1TxF9feyHvLXXuvF
	 K6XemIHNwKjiUrzkq5IKKN+BpFapYUE+pceK2Z+DKf13TRNUjNSCtNF13EAFttNyeH
	 kbhsusZW3dqGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84EA3607ED;
	Wed, 16 Sep 2026 14:57:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DC88388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43C0E4074E
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jv19wRq9bctd for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 14:57:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 16D9740744
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789570636;
 b=E89A/o6Kl0Hm87/jWaSONHfLmSIGplHAW6a0DBvs2VpLe9nA1c56q0I3vOjQy16h0FMB
 +I7ijeVUxdEbUMZYchNacuaCV8PDw7pJlWFKa7DojTmYVN52/uh2AZfLGFX66G3Wh2hMZ
 DN4KmuiCxln9gFIJxUjv0cTbjoSOM8J9pdwp9LdSKD7CWt9YLnz8W7KPIREP9Q6RnwLqm
 7i569m+yJTEPj+DB1ib/gagHKjrnj2F6ZJcwfWSOG+I3C/OPSHCM7sQHTbkpwDlgDaRmL
 ps9Ibirv4aAZT1wXPcCE0AQHgeYQcsXcAjPhyPwBhTsQ2+oUd5Mk+IFYUta7dQ9IZAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789570636;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=3qf/3hef7IzRQO6Q6b9QGoZYFB18gXVF94MVO8k0fX0=;
 b=qp8ygiLQELyk7uMg9sV/0nFQH8jaF0TchANph93A0gaj4QFDzWMpyv6K2YaFp5Rv3pbM
 /MAesc2m6My/Fl75ssmAtmgG5eUsADWe0gIEhTKx/Agu2LXXHEecMGDNhHKABdAdGVwJE
 0R5Kdl/Kx23XNrh6ihtAnha5Gpco9yZPopgnCw28lXks7ONILxhBtXGPwV4I95y2gO/8k
 TRWGApyek/Pabq1C2pTGKpg6yn6QWyoUzzLM0nFSbFBYRYPygJwg9b+VCCdkyvJlul3vG
 YhPypjWSetu35ouJJcBcYE84suAI08yFn9wKEKjxbH/6IUXxD4sS3WEkxa+9/7Bboxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZRs4jIEZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZRs4jIEZ
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16D9740744
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:13 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so6566595e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789570632; x=1790175432;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3qf/3hef7IzRQO6Q6b9QGoZYFB18gXVF94MVO8k0fX0=;
 b=ZRs4jIEZd8HnBWlAv955kY+92ZSF9Gz5BRjSEzq6f/8mqx2yzk+5DU+fwAONQvbLZh
 BbZ9B90NZVvdloSlhhtMYZssTopsQUFved5qPJb6/1eojNy99L41jzgfKqKF5NyNJ0ax
 a+37WQLUqxTzYyRWjU4oprvTO/GTXoIDghl42Tdc22eJTD7HTpViUOemJ7MhOCKKZkMZ
 m+pLygCTaj6ywRo6Qk/16lwcdMmebvkZN3fJLNdgAzZpIaN6foEcB4NPE8Da+jwGrF5h
 vqHil+KfvgsMyl8sIPxhKv1xyBoss8BecHDaMn6C1Y60EwWjolRRZAog3Pn8u9MKrI29
 Icdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789570632; x=1790175432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3qf/3hef7IzRQO6Q6b9QGoZYFB18gXVF94MVO8k0fX0=;
 b=oRzw3gNzi+UGf+RvPkBsjnQImYa4VuriX5DFY8/xdCFU93Z0wdmOxY4HlgIW/RNa4Z
 r7nnwHcAXpSIztuSRq9Tep3eLPe7faQEVxIlzHorxDatmAg/d0zwiA7aENU9Guz4JvPQ
 cCh17wJQ4w8wF0inw/21h/yYeNUekazVksz3VpwBUmBMy2mYdloC0RU4/nIuduAxlN4T
 43i5AZEixlg7mlDwsC4bPxMkZx/Zp8KclPFGuKTEvj65/EK2glRhO8Pz63EGYy4OeYJQ
 skto5lNDYn4eE0w6j9eqJORXLGa1zhk/AlvjSHxmhHurUEI+FL7VRPUcnyLeEVwo4yj2
 ctfw==
X-Forwarded-Encrypted: i=1;
 AKwUvByImDlJtU4cffnoDWyQg77eJJ5qtvc1zw04SqQ3feDAwQKML+A/Qadj79UW11UNJ98XVCepU60=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nitMc5ss4sPE8dsWjuXMhpMkZnC23Mfdq61gJ6AItYaW0P3SnD
 dBi0WYHZtmkLWMfvb4QmzXgvELjQ0auhuxKst84bejxK/Kv2eVetRwAUXvuMvytAYuw=
X-Gm-Gg: AYBFou1w1T2FSSawWQd8fvO5IwKy3M3/PPmOjhxU2lo3Ab1n39n7SRlpJbjeZbl1zJv
 gcvqGZcDDjypn2cd3Oj7edNBOGFyFemn2kiDbCB02Cl/aaXtgj53cYd0q0s4Nvlm55QSnRJgk17
 nlc7LOZk3znXS29IXIjhEfc8HqwtK5RCn7UtHgF82VWybdvsHQtfeAHSua3PlOdj2zTHn5GYZI1
 0LmTEkYknhX1lhaFoE1rRSreosG3yuoZHW5g6/iMsOfSEgTdU0KQyOo+5TZczsYL/5/IVqida+y
 yEQKY2Qiy5ZcqSIptq7ma7Y8qoqyF4503xxmKjO91JsNe1APamk66k9fbECY+l0kNs9Vvt7gair
 hrTudGlXSmFeiyXAPddVQEZci8i+VW99sdglnTHxGnD1KPrJZL/9mtaYHfxvlZNoAt0glm+gxzt
 zHdxJWwM4/R1XbbqGWmrN8qNgD6dGbEeSM+1GjLAQ1FkUuI2Pi2u6wg0bTpbrYjt4xqSs3sC7d2
 rHtKMkbgkquHftvAmT4dR9QdbofRp/fovRNLI1/4He5a7vbxsRjBphEc+y3HVhyUUktRIPypc5w
 cBpVOuO1gB06r1+Hj4u0sEXoSjDzV/0g2fJtHCWltGv31En4XK1AXAk=
X-Received: by 2002:a05:600c:8a09:20b0:49f:bc0d:2e9 with SMTP id
 5b1f17b1804b1-49fbc0d032dmr29366335e9.0.1789570631419; 
 Wed, 16 Sep 2026 07:57:11 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd0a4e68sm122355e9.2.2026.09.16.07.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:57:11 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 16 Sep 2026 16:58:09 +0200
Subject: [PATCH 2/3] power: domain: mtk: add MT8365 power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mt8365-add-power-domain-v1-2-b768d71b895c@baylibre.com>
References: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
In-Reply-To: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
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

Add power domain support for MT8365.

The domain tables and bus-protection sequences mirror the Linux
mt8365-pm-domains.h data available at commit  ffeebf7587f5
("pmdomain: mediatek: Convert all SoCs to new style regmap retrieval")

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8365-power-domain.c | 233 +++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+)

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
index 00000000000..a7d2cfff1d7
--- /dev/null
+++ b/drivers/power/domain/mt8365-power-domain.c
@@ -0,0 +1,233 @@
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
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1			BIT(2)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S			BIT(6)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB		BIT(13)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB		BIT(14)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0			BIT(21)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG			BIT(22)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0	BIT(10)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1	BIT(11)
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
+				MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1 |
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
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(BIT(25)),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
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
2.55.0

