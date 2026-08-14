Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3FAC5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B53581573;
	Fri, 14 Aug 2026 14:57:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b0CAC4WGji5b; Fri, 14 Aug 2026 14:57:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31D6881569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786719429;
	bh=99GNvgirlndrJjQNkfx6+8R51CPCz0kCPk1aCivJde4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PZwA+doAzFYWa1MgaUF4NXdHgbZG5vUVg6w/t9aF7xOO1ZTgrn2pWG1Ju8on/iEkq
	 h3chDX+BDSCvYhRUdLQBTNc+2ZuBDDr53pRwvxm7ognTpYNnwAdm1h+DToMOaVgGpg
	 1l+xWrgAMEypCCjnHRlmgN3tn396IScEPhd6dGslbi+5SwFlpIYjn2zKggT/b7teSx
	 1x8HNidx0y7eqt8ioBOfwUU0OaVEPpKMoz7qbEsiFMQtBdCS+Kqb7LMEOjna9YPrN8
	 EXFxCEGgkmaa0GwjCKK1xbMnRYqagNf0SyaxxG+gBiEW4GrtNNIYlUjwkr5r+kM5bb
	 YUL34SP6ZiW+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31D6881569;
	Fri, 14 Aug 2026 14:57:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 611082B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F2CB8148B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykwtLih5F7vn for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:57:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9E1D28149E
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E1D28149E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SvxoFAT9
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E1D28149E
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:03 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7ee4399c423so840746a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786719422; x=1787324222;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=99GNvgirlndrJjQNkfx6+8R51CPCz0kCPk1aCivJde4=;
 b=SvxoFAT9ZdfdscaFvLdiVBGm4IWXijMLMXTHXRNy0UF6ZiBQTTwnnJM6BZQuNwODDl
 4dzeWX0FC8uAYJaCrcwVFWZFV5kcErfllrs7cgysK4kLuI205s7LB5UokmR3IYi0KzJs
 RpvDe/ZN7599uRFf4uzwXpzMHx79Tg3lYqStksevJRpEaIsaTilFLtvm4Dtgaxrlr8Es
 BNf4rIw5stJ8sUGjBGfaMZCeViNIIE+vNEEI2rdWmAde54/Kbnib/yMlbL5UBQq1aUGM
 IWM9ad6RKM/GWEOuFlmjj/2NeclOE5qYTCgkW6xhr4wPHcmHwUUjHML6d5SkirZf/zLf
 gWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786719422; x=1787324222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=99GNvgirlndrJjQNkfx6+8R51CPCz0kCPk1aCivJde4=;
 b=r39tcHyHispm8qbcTmCApPeiQZrMmNGM5040QkKdxgt/im4YDOvaIYVChtpYV7zfTf
 aUF/4MsK+j4rqR7COi/iZ+vr5KGpQvEX5OVbkatyfC9cFvYYjqC+1HteUMW875ResJKt
 bLrpcAprOBNBEV7L4f6+DYAaTG64Yot55OoRWx+DVWYijxMMsky8QSw1ry51QSikCSVE
 hfDRlfUyR/0tcphEwqAZ2RZNnJiYhSI6Q41l+MBikCZK57lC1CBeRekESiTqWsMIJhml
 I/MtneIu/vV/0q0JMSvJlcSRgXiXSLac7awD5X2lKSXHVkk8FCy08rovR5jxWPLuW0FF
 r71A==
X-Gm-Message-State: AOJu0YxSETU7UZbuHwIKxmaackhcn7Lj6E659ZxVmtJDnCUgGsqPIExK
 iAxWumQ2gp9pneu+XUQ3JL1s3QMW1yuNwSPkcEP5TwNu+d3O4NoXmR1IXAMsKKArhv0=
X-Gm-Gg: AR+sD129AgKkVvFUpgi/A14ytYT0M6WcBF9ZS+NggB6rX/8Q4u6Ew/ecJ5lamIP7q8C
 E95ishUuOUn4C+XLWDK4pcFdeJHEqmK5VR7qsSVCwIMzOGmPrHFJRjsLSdnyiQPXeXZv/qOaKSF
 6p1qh8ICXTC74TcBqGGnt/J2GzWeqjHgc3Brtf8hkYibgnFlZpnk1JYOHbOiiq7QTPZm3EisHOK
 0XjpwseGUj/5YCMMU09JsnVtcZVfnibYGdeZWb2LVS+ksc+4WgcqcoULTVSRLpul9iCtXpLwh2z
 AtHoTHxoT7acUTiwfB9lVd4l5DjtDakwQECPeIwa7mtMILY8U777cjhRMzYl3tRCLK7jHJ3Hpgp
 qNbeUQkPghKniTaRQc1neM/UH+0pV3F2Wxp+D7hfPvN5w+wqbF9VKMBsmIu5YgORHotsPAtqXV4
 sXvhP4oF0Svl5Ihag0mVDotdOle1lEwKLOjZVYFMQ7f/i+7YH4CWLPD4fotZiIWzh08Q==
X-Received: by 2002:a05:6830:6d4e:b0:7e6:e022:4b44 with SMTP id
 46e09a7af769-7f3de6e96e7mr5827499a34.15.1786719422486; 
 Fri, 14 Aug 2026 07:57:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e8668831sm1065949a34.22.2026.08.14.07.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:57:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 14 Aug 2026 09:56:23 -0500
Subject: [PATCH 3/4] dt-bindings: power: add mediatek,mt8366-power.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mtk-power-domain-mt8366-v1-3-6a0bb4a766bb@baylibre.com>
References: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
In-Reply-To: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Irving-ch Lin <irving-ch.lin@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QiPUm46eolTGoe4mOvMcPgWIZPhM98hqKkxKw3DAwaE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfyyuImb+XYffIfFn8Wpgjz9d1FUzYBBac/Csg
 tPd2qQ0SyOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan8srhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AATEH/2rle0LnueCGjb4gQ/Zv9uG3vm332C6INM+h/mD
 Pdlfjimgce8+tMnUuBXBg7wkLZaFb0xF+mgxhKMGIrFyf45jRzeehZTg1hGY1k5LWSWvS+fpA7W
 XTbWocoOa1n9nGuWSNNqBbXFOeh6yQKrrWOPviTgyvrMD4m1YSmt8oESwsLdrbhtXB5VC/kKNR6
 o1IkXl0xsCgMyntWgofc3u16u1R1BGrhK4bYRmZAyAs1JuUrCDQPo2HFOqayCPTpongUcGRjdO9
 fs7pbWlZ2giJ4Kxoxx2Qrf+g6VcKmw33G5uqkdCea6YhMi8qhTgM+To5qCsuivNyJp98BXfOaJy
 84nQ=
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Irving-ch Lin <irving-ch.lin@mediatek.com>

Add mediatek,mt8366-power.h for mt8366 power domain binding. This is
coming from downstream Linux since upstreaming of MT8366 has not
started yet, so we will have to carry this for a while.

Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
---
 include/dt-bindings/power/mediatek,mt8366-power.h | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/dt-bindings/power/mediatek,mt8366-power.h b/include/dt-bindings/power/mediatek,mt8366-power.h
new file mode 100644
index 00000000000..a09bcd01d05
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt8366-power.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ * Author: Irving-ch Lin <irving-ch.lin@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8366_POWER_H
+#define _DT_BINDINGS_POWER_MT8366_POWER_H
+
+/* SPM */
+#define MT8366_POWER_DOMAIN_CONN			0
+#define MT8366_POWER_DOMAIN_MFG0			1
+#define MT8366_POWER_DOMAIN_MFG1			2
+#define MT8366_POWER_DOMAIN_MFG2			3
+#define MT8366_POWER_DOMAIN_MFG3			4
+#define MT8366_POWER_DOMAIN_VDEC			5
+#define MT8366_POWER_DOMAIN_VENC			6
+#define MT8366_POWER_DOMAIN_AUDIO			7
+#define MT8366_POWER_DOMAIN_CAM				8
+#define MT8366_POWER_DOMAIN_CAM_RAWA			9
+#define MT8366_POWER_DOMAIN_DISP			10
+#define MT8366_POWER_DOMAIN_DP_TX			11
+#define MT8366_POWER_DOMAIN_PCIE			12
+#define MT8366_POWER_DOMAIN_ISP_IMG1			13
+#define MT8366_POWER_DOMAIN_ISP_IMG2			14
+#define MT8366_POWER_DOMAIN_ISP_IPE			15
+#define MT8366_POWER_DOMAIN_MMLSYS_SHUTDOWN		16
+#define MT8366_POWER_DOMAIN_EPD				17
+#define MT8366_POWER_DOMAIN_CSI_RX			18
+#define MT8366_POWER_DOMAIN_VADSP_AO			19
+#define MT8366_POWER_DOMAIN_VADSP_INFRA			20
+
+#endif /* _DT_BINDINGS_POWER_MT8366_POWER_H */

-- 
2.43.0

