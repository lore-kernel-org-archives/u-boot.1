Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1ADC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC0CD81339;
	Fri,  7 Aug 2026 16:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Gbuun2UFHeH; Fri,  7 Aug 2026 16:02:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F28F98130E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786118543;
	bh=sbNz3LhfzkgxFrA1+p8iF0tpKqKuYxCs8Z4qbkP6xu0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m5X5F7P3xHAt4OYkMDc4SifpjX3wIgfAvOyrAY5JhRZYiqffpNXZHuq9pUH6LTQFj
	 M5sPXdiROe8KkIz6GfKUpeV4C2wt9Z/+VEFtLqxWw6hL6lOwLWhYrlaZHn73WODm0w
	 CLH6/2OENGWXsBoYc3yw9Vxy0u2k4m2vrQSmM4yVTANb7fq4GHW2zMxIwLQlgTw6c2
	 z6fvmL7sbeVYw3qhdI45UF8Lp62lq3+2J3h6iAlM1At0rIniKeKjc65Dhgohck5BSh
	 ntJcuFg8XjKMBxAScYuiuWZTG8L0JL5G2g/l6+wVZPEd1fuxLQLrAl5uejR+nYB9GJ
	 1RxsB2dM47ftw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F28F98130E;
	Fri,  7 Aug 2026 16:02:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C5B2198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42591400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDv1wi7tqhI9 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:02:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 95D904008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95D904008E
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95D904008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:19 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6acbbcd3798so2258185eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118538; x=1786723338;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sbNz3LhfzkgxFrA1+p8iF0tpKqKuYxCs8Z4qbkP6xu0=;
 b=ot9uS6IqlXJOEcEAIHEave305bvlGJOFtOxEQwKDLl8exAJdWAEpsdxrYBZwL64fTN
 G008RHppno7bwnBQJD2QxGz8kCPeR50iR0c7YS35zXYLSi+TRKEmYxGQAQUCn2GJoGg8
 DrmfdEo9lcm7t6E4NAeb6jaumszfAVrqGXkO2Vuf1GEMDt8URxVlY1C0IktKSIQtJ+vK
 OyGkETOOrBMCh5iLNXTmlz93fZB6rtiCyAwbMyVCloMQfeKFjhMz96jBl4EIM783MebS
 hkxR3GM8bcPVU3IbFWZF92rhm4nMBX7Yqsv0AYH8AG5T0CLoAgkPC4OxW5M0WQgJ+N6y
 a/pg==
X-Gm-Message-State: AOJu0Yyv3DLRwSEyP/KBEzo+etBxGhwh5N99JKEfHKPJN5xwSg5ZhhOZ
 oSS2rMG9FMT2StLGrQ9fQy+BcasSGHtxpCxUsP2+eUbGfs2sP1GcvkKon4zGm1dfL5Y=
X-Gm-Gg: AR+sD108Xbk5jxU4sZxeyJ2fSCbiP+QMXXf6Gp0IfC6snnvZ2P40ECZ0PjIMXPJQkiu
 GaO5tkb/iS572zrBdrjaKe/J58U7r3e8etIjwil2JesAew14eeqlrviWCm2hKkFShHm0k1JtDI7
 F3xAwO3mUryS10b6lPAgKvSid+9eFPe3wSYvd5/eygwEpceM6wTDsfrKvPQvWu9UA14IMIDzM52
 /8p7X5TcAAM3U7EO5tUyjhyJF7b3N6U6F7W7ClgV7Cgbsynlflm8DzN3sSrsb7LxfjgTXIwsZAp
 NOyTs73WK1ozsRS8xmRQNioj5gm2lGL82fRSCOri+eExN4IQ0Z14KXK2R5CL+XZ0ZeFuFqjnSDA
 XJMbj1xp6mQgRLTVD+cRkr+E3POM+Ve4HK7l9Ma5V1pIdOcKxWdXCXxJkQs8P8kFQx+UQ+zJH8p
 Kmt1vzDUyQSrpLLgrhIxulPLCeqfWAyVvQF0Sj0N2QLW4Tsyl72XU02/XMB4YBjzR0
X-Received: by 2002:a05:6820:198b:b0:6aa:da04:b583 with SMTP id
 006d021491bc7-6b0214e5b78mr5466531eaf.17.1786118537949; 
 Fri, 07 Aug 2026 09:02:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2679993eaf.5.2026.08.07.09.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:02:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/5] power: mediatek: add MT6366 PMIC support
Date: Fri, 07 Aug 2026 11:01:27 -0500
Message-Id: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNzQ6CMBCEX4Xs2ZrSkhU9+R6GQ1u2sio/aZFIC
 O9uwbO3+ZKZbxaIFJgiXLIFAk0cue8SqEMGrjHdnQTXiUFJhbKUhWjHpxhadimgRhS+Ru1Qnmu
 vDKTVEMjzZzfeqh/Ht32QGzfN1mg4jn2Y98sp33r/7VMupPDaarSlyU1xulozv9gGOrq+hWpd1
 y8vpk7rwwAAAA==
X-Change-ID: 20260804-mtk-pmic-mt6366-fd63c609df2a
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=JbM/rDGY8DYAG8HmZfar0APDTDiyY71QwIHJS/1ym3I=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgFfbRwhGNV6qW69x5RlILVa7P/IisNiABl4g
 3PQLcyXscWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYBXxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AgjUH/jo36NPx3atvVN/7Mbt8KscL0gx4VodCx2lSYRC
 Zxr1fEYb1hxvHWPMPMF6+j+bFJjRsQFTq+8oO0186bu0Aswq0DnHzX23RDesxC99irp5sDqiE8j
 O5/ws/TFWNjqk4SMrU2UjlqKBcMo+G2WCXuJIqTSDpw78UdaoJja7/kYn8z8qVFTRBakZl4vol3
 TfhKYyalLRJNS5ilIePsVQ2BG8jTtVSjJVUN1Ont6+V81wsSRLcGHeXmNR8P1X7tmyhZZ/ocSBO
 SoeFTVqJ8zgwK5iMCEe60K/sNWvqThlPmtt/ql199KIpZay5oEmnYXbQWibtl6dBtsta4jcUsGT
 LNgI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786118538; x=1786723338;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sbNz3LhfzkgxFrA1+p8iF0tpKqKuYxCs8Z4qbkP6xu0=;
 b=Pp7Mhb2t9e1H0kn9b3PQgr14PAU+kmfjjtog8Ds47r34piNy+MjEAEZFwTCzW7nwME
 vF2Pus/49R9ZcC3EtfnzlVZLMGJkfJ4EevnhKqCZ2jfRNtB5gxNP0JyZ/2qhiZK0QDDf
 OR2xo/G3WqIpc7ceQlYSQbfsXkwiK7wRLzgcR+95xlYG6JVTD3P3rqM/a2HMeaGhZhbD
 ttYRW+xxxIsCEZ8EV/LsLzGeKz6o0fmqJbECbOIbwL8HhjloIy4ZpKxwD/y+jUPARyir
 AGVSNBgqOa5AkJBc4u6psP5DFMaL/KS9L7Uo4gQRPeWwjTfpSUrz5F7R2A34rPV5/IlF
 Ba9Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Pp7Mhb2t
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

As part of bringing up Genio 360 EVK, we need a new PMIC driver for the
MediaTek MT6366 PMIC. This uses the same PMIC wrapper as other Genio
platforms but the PMIC itself has a different register map, so gets a
new driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Dropped regulator-name and and min/max properties from the dts.
- Dropped last two patches. They will be squashed into v2 of [1].
- Link to v1: https://patch.msgid.link/20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com

[1]: https://lore.kernel.org/u-boot/20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com/

---
David Lechner (5):
      power: regulator: add MT6358 driver with MT6366 support
      power: pmic: mtk-pwrap: fix clock names
      power: pmic: mtk-pwrap: use mt8195 fallback for mt8188/9
      power: pmic: mtk-pwrap: add mt6358 PMIC
      arm: dts: add mt6366 PMIC include

 arch/arm/dts/mt6366.dtsi                   | 168 +++++++++++++
 drivers/power/pmic/mtk-pwrap.c             |  92 ++++---
 drivers/power/regulator/Kconfig            |   8 +
 drivers/power/regulator/Makefile           |   1 +
 drivers/power/regulator/mt6358_regulator.c | 371 +++++++++++++++++++++++++++++
 include/power/mt6358.h                     | 130 ++++++++++
 6 files changed, 722 insertions(+), 48 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260804-mtk-pmic-mt6366-fd63c609df2a

Best regards,
--  
David Lechner <dlechner@baylibre.com>

