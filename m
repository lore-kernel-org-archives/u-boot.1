Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F595C61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C16E40CA5;
	Fri,  4 Sep 2026 14:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1f147edf6JPG; Fri,  4 Sep 2026 14:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E7F0540CA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788533261;
	b=eD/guP8sVBXc1APfe3Q5gOPA50kGVUXZnd/GKaJR7AV6tB0rGsNErbsR6unpPLqsv+1o
	 qGtVQUk8ZFI2svuoQktNovu9jh+8KSVEPJZO3EBAHPUJQ7pW09r4d275hZdoSwv6+7gNO
	 VHBalwrQIgarhDH6l7BXrmpRhzpyJZtnfqvX5eaPFPBCS29Yd030o52CFcChGnfn42qqz
	 6VlwQ1C7EfAl/kj9bhc/smrNbO+YnehvhOGdtWwgIKfQA6j73A3Dr5toNpsZ0vqht6eUU
	 sljkXZ9+urePIduTGMcu1slbDPKcWAiXVqvbpXtY8vkPWffhfB0fB4MvbQ/jEbrQypA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788533261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3D1zXYTYeKXWG8XsQvLxBtFuVhu31r+m86obvJWMcc0=;
	b=Bsz5PGon0vgCZ/mxSfZm80n8QXVv+9oWhMWJ3N7WJNHtmV9tM3ggWlFP+aaQtaDbGNuc
	 BGFTCwB9p2iB4TP+qzyUDq/45t+oHADn1yhd7QiDJbLebHh6QoKYv1gUpfGhRqqjjZIy3
	 ukZ0i9k5jYljRdOHnsA+BYT7IL/dYD9qv4KHegsxQx7XViX03aic8dSfJx++izCvMrcGY
	 WfQaiWUhA18/Yaa/xkyyf+BxpuLLrG1jLgCtvhXweO+FLcTmldA7Xt0kF3LqeqjTmS246
	 n5Mo1wVZ3e2CQF2g6K44GE86qaN7s3Lo73BAsnMLCbjGTUCiyRAbWm5N/JCFBH9Um2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788533261;
	bh=3D1zXYTYeKXWG8XsQvLxBtFuVhu31r+m86obvJWMcc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ra7ohNBhd23s6mfXO8JxcFZc+BmTy/PDu/mzNH/f4FH8zh3msegwz8DHLTe/6uTAK
	 Sy7UgAmrp3Xj4y1mnmdFIctdeN4tsmo02+eb2QuDp7uePmz5G1L05GpJovs1nRUBey
	 ddEaf+jgFubdFsBu7pV3tWrA36jFY+c73vAUrU3+bK4tzd42Vsx97UQqJOL9Hs/rV2
	 p22Mn0lRodhtyMnj+y7E1H/AwVo+y6B49kob4Zx2IlPpQ8rmo4dWCXv0KMtFOLeGZh
	 m/ZF3gktwU5cfGfqBBorabXW1ykfvHBJBWXVc4US5Bg6hqYaaq1wzQTRdwdebSZJp+
	 lGSQ7rULEydrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7F0540CA0;
	Fri,  4 Sep 2026 14:47:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 285243DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EB4B811B3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5OEY8WxfHySn for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E20CF8119D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788533251;
 b=gy/YUAcwJ63VNEgVg6As3kambDnqOCC5TPTcXMybx/Hc/IV9MqzzhahD1bFI5ivtbAex
 JlXr3P8+XW0PIIy1sx0UfLsK/qEJJ1a4HzeiXad9hjy8BssOs4p/FyD7dGscbQ4L5JQq1
 R26a8YqbHP+S43i7UoeMqhmmi76fxg8EYuqc+iXnZJrP8BL4mYm93isux6E+nY/RRhBny
 9Euno0pk2y9V8edHBDHqCHwW89eojwTVNBvFudineLx7+oreic9Ay2p7vMzd9+lpEj1xd
 /Dp9jAFSOlDogJAWK96e+BaDulqkschZeOKiLrmcUls3p80gADkerrM6W3SZ+cAnaVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788533251;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=3D1zXYTYeKXWG8XsQvLxBtFuVhu31r+m86obvJWMcc0=;
 b=jzSaw0HDsaR3dDHlWLmFOwDGRkXVxOH5UJNDp88LI8Gv0Nb5J4j5L81JFIG86kFbCUlh
 7CJrxm++QBLx/MUkWGLCKmy210sgHQbEZOlT4/m9T/jqoL+HzdW/s5PI4eqZ21UQQwsNw
 P7S1sUP4c6RJfpeujiw1vjEAoDEEGfqVSYVWUOVH0RBogEKzYbLqhsRdSHm0m4AY4hJAu
 kI+onH1ii1Gm8SSTXZZXL+htLypVX6mn0uZ/k5xEoW4XbbLdrSZujW5TKrBv0jYcjfDXY
 1AZjtoiWEqHUwGu7ZsEz+cMF8cRXI/zE85Thj5+WcuGX6tej+nCPjOzEJGtMMrvZuKQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DBO8TM8M; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DBO8TM8M
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E20CF8119D
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:30 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-48a0ca07c38so1011797b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788533249; x=1789138049;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3D1zXYTYeKXWG8XsQvLxBtFuVhu31r+m86obvJWMcc0=;
 b=DBO8TM8MxAT5os9HqSC6tT4UI3hjaxzH+QoMvLc5YuvjPvfFUuH4Gqznrd4uNNvqkh
 legpvwY9IcCRQct2eDPr6vDkazfKDm1vc7N3/NYUMy/xq6S+Vy/iT49NE2ODr027dFQl
 IO6+gn1Cl0IKSVKbLHPkyBoDRru+F2XD83t+PyxLMGcxdTBU453rxqju+aYHkV39hqm3
 ycOYhtU/cVrfGhYoHs+dw7yQIJxVI58qmicnCtuK/ip1Xo6Zxq3sFOLPOwzCS+/SwHBh
 46dP6o2wb55lbrqw6uYvcMm3lDTd4DIYQBUv3aa+a0XLfFN77O6rq/WrAYlkytHECt73
 /Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533249; x=1789138049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3D1zXYTYeKXWG8XsQvLxBtFuVhu31r+m86obvJWMcc0=;
 b=mOkm8BUhMy8ZZnJutWED8ozHEK0/lTbi6cNT7CyMci45PC/jtOI7Q+sN7qeNvT0EMC
 luGVnCneEKaQJ7NSQ1gwZ7IkmUv28k9IaB92/kXugtLRzlLakwYS85fd/xbUh+YzXctw
 9H/rvoEfeXeR+AD5g+ij6/ZSGU246c1IOLFVRilWWovluuM35LFlTJkME/KJ/XzwJ8cU
 U3DtuWB0kAibBLdxv1fI2No4q7ZGYCfHGvWeLiy2MyvMyx9SczOoLz20LtOSSdZpVsmN
 bE2u9bSCtSqik2OMpvTb1BJi+DQRXUjVR/oeiAD/CVW302KP7KWdG0cFKZFPSg2GG99y
 qhNw==
X-Gm-Message-State: AFuF++nG0KWFIQorlcze5nl77+c+1VUA5G3WmXimvjtasnivbYkhOGxc
 hkkTR5/BWK/sBStMkj5r9SCU/rdFmC13c6VY/txEZ791aHJZQYGHYKbQVGehat4gZfQ=
X-Gm-Gg: AYBFou1b1jxwfdVPHRiiZxwmv52Jbcrgir+l7i/9mAl9qzUiCyqQWd81lEHautHCFjh
 v0X3MCn8sELyOojVvDkIbTBb6sm+rCJJDWQLWl32kMU7Mj1+KlrWFcOljKiXKLEctEorFPdUuwT
 WOMtgn+7kR9e23q4/MG/bgTKBcPci2g3+0ZdcYYS1EsrqyKUUZIUKMAnMNkWD+45gfsK9VzAEzQ
 9z8rpkwO122z8NmnWhuMgWoaYtFPyGGl6Ku5RXCf7xY1F/wkipH7TIdBQikCUeFf/MXsSbNg2gY
 UEMBUSzDgoV+ZLZ59wFbX2XbOgsxuXVxd7FKANgHtUary0Q7YvuOUGjPM2+IMzgTfnhd8mKmujV
 ev0Qq0ciRLaNAOlMu2sbD/8ZPyb3khRSF335ie/Y9RePHcqcFrPFqkobnf0z3Q2L3IfIzYzh+De
 U0A7RxbBf/ZeyN+DJUgxFsYD7QsgBlW/VitcpABnyj0D56VIlfhwKAYeVPoOZs3WvkHA==
X-Received: by 2002:a05:6820:2019:b0:6b1:7251:41d5 with SMTP id
 006d021491bc7-6b6fabe1b66mr6225505eaf.3.1788533248910; 
 Fri, 04 Sep 2026 07:47:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47554935962sm2118988fac.12.2026.09.04.07.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:47:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 09:46:31 -0500
Subject: [PATCH 4/6] power: domain: mtk: add MT8189 power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mtk-power-domain-mt8189-v1-4-ab9d8cd0f01a@baylibre.com>
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
In-Reply-To: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16542;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=JWBP9wcvcuOb7tiqkJabn5577M3ec3VlfTW9fqz6GkY=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmtnktifvt4kdutPljyKhUmnIjOSFuUydsqn4t
 PV8EdBnrzKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaprZ5BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfVgIAJ5UHFZ4m8Z8nKsHD7eNbV+tz6iMKlloPjOYmin
 IGbgtPl4KcBhdKjuT0cRD0+UMrqkXHDS10KNXO5K8VznRDU5tWT/9qY1PCE6k6Rwkptw5M6iBpA
 2gKlitrVELhIdIq2pK2wT49pwHm7NksZKZjIoj5TUM8/lOrmKClAFQtlp8aV37oY+Z+qaOEua/Q
 P+BTSudyb8oHRDOFYw7tGAGhr6I+3+L3pHfJcGzeXejsjtJESrWPqfLU7Xghep/htigbtPRHAxJ
 jHmbBt6MMCpXAyXwO6jVrfQle2jqM5TILKQEs/tnmPncb23EL+acOLPms7wn82+cma/UGkH3RZn
 3mo8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add the SoC data for the MT8189 System Power Manager, driven by the
shared mtk-power-domain code through the upstream
"mediatek,mt8189-power-controller" binding. The domain table is a
transcription of drivers/pmdomain/mediatek/mt8189-pm-domains.h in Linux.

The MFG1 domain additionally needs an EMICFG GALS sleep protection step,
and the ADSP_TOP_DORMANT and EDP_TX_DORMANT domains need SRAM isolation
with an inverted SRAM power-down bit. Neither is expressible with the
current mtk_scp_domain_data, and neither is needed to bring up the
domains U-Boot actually uses, so both are left out with a comment.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8189-power-domain.c | 419 +++++++++++++++++++++++++++++
 2 files changed, 420 insertions(+)

diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index dd14981fca9..66c448033ee 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -20,6 +20,7 @@ ifdef CONFIG_MTK_POWER_DOMAIN
 obj-$(CONFIG_TARGET_MT7623) += mt2701-power-domain.o
 obj-$(CONFIG_TARGET_MT7622)$(CONFIG_TARGET_MT7629) += mt7622-power-domain.o
 obj-$(CONFIG_TARGET_MT8188) += mt8188-power-domain.o
+obj-$(CONFIG_TARGET_MT8189) += mt8189-power-domain.o
 obj-$(CONFIG_TARGET_MT8366) += mt8366-power-domain.o
 endif
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
diff --git a/drivers/power/domain/mt8189-power-domain.c b/drivers/power/domain/mt8189-power-domain.c
new file mode 100644
index 00000000000..a4857bb4c8c
--- /dev/null
+++ b/drivers/power/domain/mt8189-power-domain.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS.
+ * Authors: Qiqi Wang <qiqi.wang@mediatek.com>
+ *          David Lechner <dlechner@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dt-bindings/power/mediatek,mt8189-power.h>
+#include <linux/bitops.h>
+
+#include "mtk-power-domain.h"
+
+/* SPM power status register offsets */
+#define MT8189_SPM_PWR_STATUS			0x0f40
+#define MT8189_SPM_PWR_STATUS_2ND		0x0f44
+#define MT8189_SPM_PWR_STATUS_MSB		0x0f48
+#define MT8189_SPM_PWR_STATUS_MSB_2ND		0x0f4c
+#define MT8189_SPM_XPU_PWR_STATUS		0x0f50
+#define MT8189_SPM_XPU_PWR_STATUS_2ND		0x0f54
+
+/* Infra bus protection register offsets */
+#define MT8189_PROT_EN_MMSYS_STA_0_SET		0x0c14
+#define MT8189_PROT_EN_MMSYS_STA_0_CLR		0x0c18
+#define MT8189_PROT_EN_MMSYS_STA_0_RDY		0x0c1c
+#define MT8189_PROT_EN_MMSYS_STA_1_SET		0x0c24
+#define MT8189_PROT_EN_MMSYS_STA_1_CLR		0x0c28
+#define MT8189_PROT_EN_MMSYS_STA_1_RDY		0x0c2c
+#define MT8189_PROT_EN_INFRASYS_STA_0_SET	0x0c44
+#define MT8189_PROT_EN_INFRASYS_STA_0_CLR	0x0c48
+#define MT8189_PROT_EN_INFRASYS_STA_0_RDY	0x0c4c
+#define MT8189_PROT_EN_INFRASYS_STA_1_SET	0x0c54
+#define MT8189_PROT_EN_INFRASYS_STA_1_CLR	0x0c58
+#define MT8189_PROT_EN_INFRASYS_STA_1_RDY	0x0c5c
+#define MT8189_PROT_EN_PERISYS_STA_0_SET	0x0c84
+#define MT8189_PROT_EN_PERISYS_STA_0_CLR	0x0c88
+#define MT8189_PROT_EN_PERISYS_STA_0_RDY	0x0c8c
+#define MT8189_PROT_EN_MCU_STA_0_SET		0x0c94
+#define MT8189_PROT_EN_MCU_STA_0_CLR		0x0c98
+#define MT8189_PROT_EN_MCU_STA_0_RDY		0x0c9c
+#define MT8189_PROT_EN_MD_STA_0_SET		0x0ca4
+#define MT8189_PROT_EN_MD_STA_0_CLR		0x0ca8
+#define MT8189_PROT_EN_MD_STA_0_RDY		0x0cac
+
+/* Bus protection bits */
+#define MT8189_PROT_EN_INFRASYS_STA_0_CONN	BIT(8)
+#define MT8189_PROT_EN_INFRASYS_STA_1_CONN	BIT(12)
+#define MT8189_PROT_EN_INFRASYS_STA_1_MFG1	BIT(20)
+#define MT8189_PROT_EN_MCU_STA_0_CONN		BIT(1)
+#define MT8189_PROT_EN_MCU_STA_0_CONN_2ND	BIT(0)
+#define MT8189_PROT_EN_MD_STA_0_MFG1		(BIT(0) | BIT(2))
+#define MT8189_PROT_EN_MD_STA_0_MFG1_2ND	BIT(4)
+#define MT8189_PROT_EN_MM_INFRA_IGN		BIT(1)
+#define MT8189_PROT_EN_MM_INFRA_2_IGN		BIT(0)
+#define MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN	GENMASK(31, 30)
+#define MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN	GENMASK(10, 9)
+#define MT8189_PROT_EN_MMSYS_STA_0_DISP		GENMASK(1, 0)
+#define MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1	BIT(3)
+#define MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1	BIT(7)
+#define MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE	BIT(2)
+#define MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE	BIT(8)
+#define MT8189_PROT_EN_MMSYS_STA_0_MDP0		BIT(18)
+#define MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA	GENMASK(3, 2)
+#define MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND	GENMASK(15, 7)
+#define MT8189_PROT_EN_MMSYS_STA_0_VDE0		BIT(20)
+#define MT8189_PROT_EN_MMSYS_STA_1_VDE0		BIT(13)
+#define MT8189_PROT_EN_MMSYS_STA_0_VEN0		BIT(12)
+#define MT8189_PROT_EN_MMSYS_STA_1_VEN0		BIT(12)
+#define MT8189_PROT_EN_PERISYS_STA_0_AUDIO	BIT(6)
+#define MT8189_PROT_EN_PERISYS_STA_0_SSUSB	BIT(7)
+
+/*
+ * The MFG1 domain additionally needs an EMICFG GALS sleep protection step,
+ * and the ADSP_TOP_DORMANT and EDP_TX_DORMANT domains need SRAM isolation
+ * with an inverted SRAM power-down bit. Neither is modelled here: this
+ * driver only ever powers up the domains the U-Boot device tree references.
+ */
+
+static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
+	[MT8189_POWER_DOMAIN_CONN] = {
+		.sta_mask = BIT(1),
+		.ctl_offs = 0xe04,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MCU_STA_0_CONN,
+					MT8189_PROT_EN_MCU_STA_0_SET,
+					MT8189_PROT_EN_MCU_STA_0_CLR,
+					MT8189_PROT_EN_MCU_STA_0_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_1_CONN,
+					MT8189_PROT_EN_INFRASYS_STA_1_SET,
+					MT8189_PROT_EN_INFRASYS_STA_1_CLR,
+					MT8189_PROT_EN_INFRASYS_STA_1_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MCU_STA_0_CONN_2ND,
+					MT8189_PROT_EN_MCU_STA_0_SET,
+					MT8189_PROT_EN_MCU_STA_0_CLR,
+					MT8189_PROT_EN_MCU_STA_0_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_0_CONN,
+					MT8189_PROT_EN_INFRASYS_STA_0_SET,
+					MT8189_PROT_EN_INFRASYS_STA_0_CLR,
+					MT8189_PROT_EN_INFRASYS_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_AUDIO] = {
+		.sta_mask = BIT(6),
+		.ctl_offs = 0xe18,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_PERISYS_STA_0_AUDIO,
+					MT8189_PROT_EN_PERISYS_STA_0_SET,
+					MT8189_PROT_EN_PERISYS_STA_0_CLR,
+					MT8189_PROT_EN_PERISYS_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT] = {
+		.sta_mask = BIT(7),
+		.ctl_offs = 0xe1c,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(9),
+		.sram_pdn_ack_bits = BIT(13),
+	},
+	[MT8189_POWER_DOMAIN_ADSP_INFRA] = {
+		.sta_mask = BIT(8),
+		.ctl_offs = 0xe20,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+	},
+	[MT8189_POWER_DOMAIN_ADSP_AO] = {
+		.sta_mask = BIT(9),
+		.ctl_offs = 0xe24,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+	},
+	[MT8189_POWER_DOMAIN_MM_INFRA] = {
+		.sta_mask = BIT(30),
+		.ctl_offs = 0xe78,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+			BUS_PROT_WR_IGN_SUBCLK(MT8189_PROT_EN_MM_INFRA_IGN,
+					       MT8189_PROT_EN_MMSYS_STA_1_SET,
+					       MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					       MT8189_PROT_EN_MMSYS_STA_1_RDY),
+			BUS_PROT_WR_IGN_SUBCLK(MT8189_PROT_EN_MM_INFRA_2_IGN,
+					       MT8189_PROT_EN_MMSYS_STA_1_SET,
+					       MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					       MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_ISP_IMG1] = {
+		.sta_mask = BIT(10),
+		.ctl_offs = 0xe28,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_ISP_IMG2] = {
+		.sta_mask = BIT(11),
+		.ctl_offs = 0xe2c,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_ISP_IPE] = {
+		.sta_mask = BIT(12),
+		.ctl_offs = 0xe30,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_VDE0] = {
+		.sta_mask = BIT(14),
+		.ctl_offs = 0xe38,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_VDE0,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_VDE0,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_VEN0] = {
+		.sta_mask = BIT(16),
+		.ctl_offs = 0xe40,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_VEN0,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_VEN0,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_CAM_MAIN] = {
+		.sta_mask = BIT(18),
+		.ctl_offs = 0xe48,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_CAM_SUBA] = {
+		.sta_mask = BIT(20),
+		.ctl_offs = 0xe50,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_CAM_SUBB] = {
+		.sta_mask = BIT(21),
+		.ctl_offs = 0xe54,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_MDP0] = {
+		.sta_mask = BIT(26),
+		.ctl_offs = 0xe68,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_MDP0,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_DISP] = {
+		.sta_mask = BIT(28),
+		.ctl_offs = 0xe70,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_DISP,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_DP_TX] = {
+		.sta_mask = BIT(0),
+		.ctl_offs = 0xe80,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_CSI_RX] = {
+		.sta_mask = BIT(7),
+		.ctl_offs = 0xe9c,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+	},
+	[MT8189_POWER_DOMAIN_SSUSB] = {
+		.sta_mask = BIT(10),
+		.ctl_offs = 0xea8,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_PERISYS_STA_0_SSUSB,
+					MT8189_PROT_EN_PERISYS_STA_0_SET,
+					MT8189_PROT_EN_PERISYS_STA_0_CLR,
+					MT8189_PROT_EN_PERISYS_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_MFG0] = {
+		.sta_mask = BIT(1),
+		.ctl_offs = 0xeb4,
+		.pwr_sta_offs = MT8189_SPM_XPU_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
+	},
+	[MT8189_POWER_DOMAIN_MFG1] = {
+		.sta_mask = BIT(2),
+		.ctl_offs = 0xeb8,
+		.pwr_sta_offs = MT8189_SPM_XPU_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_1_MFG1,
+					MT8189_PROT_EN_INFRASYS_STA_1_SET,
+					MT8189_PROT_EN_INFRASYS_STA_1_CLR,
+					MT8189_PROT_EN_INFRASYS_STA_1_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MD_STA_0_MFG1,
+					MT8189_PROT_EN_MD_STA_0_SET,
+					MT8189_PROT_EN_MD_STA_0_CLR,
+					MT8189_PROT_EN_MD_STA_0_RDY),
+			BUS_PROT_WR_IGN(MT8189_PROT_EN_MD_STA_0_MFG1_2ND,
+					MT8189_PROT_EN_MD_STA_0_SET,
+					MT8189_PROT_EN_MD_STA_0_CLR,
+					MT8189_PROT_EN_MD_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_MFG2] = {
+		.sta_mask = BIT(3),
+		.ctl_offs = 0xebc,
+		.pwr_sta_offs = MT8189_SPM_XPU_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_MFG3] = {
+		.sta_mask = BIT(4),
+		.ctl_offs = 0xec0,
+		.pwr_sta_offs = MT8189_SPM_XPU_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_EDP_TX_DORMANT] = {
+		.sta_mask = BIT(12),
+		.ctl_offs = 0xf70,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.sram_pdn_bits = BIT(9),
+	},
+	[MT8189_POWER_DOMAIN_PCIE] = {
+		.sta_mask = BIT(13),
+		.ctl_offs = 0xf74,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_PCIE_PHY] = {
+		.sta_mask = BIT(14),
+		.ctl_offs = 0xf78,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+	},
+};
+
+MTK_SCP_SOC_DATA(mt8189, mt8189_scp_domain);
+
+static const struct udevice_id mt8189_power_domain_ids[] = {
+	{
+		.compatible = "mediatek,mt8189-power-controller",
+		.data = (ulong)&mt8189_scp_soc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(mt8189_power_domain) = {
+	.name = "mt8189_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &mtk_power_domain_ops,
+	.probe = mtk_power_controller_probe,
+	.of_match = mt8189_power_domain_ids,
+	.priv_auto = sizeof(struct mtk_scpsys),
+};

-- 
2.43.0

