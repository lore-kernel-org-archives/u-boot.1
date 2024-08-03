Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC6CC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A9388CCA;
	Sat,  3 Aug 2024 13:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GYQ8JOIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C8288CD1; Sat,  3 Aug 2024 13:13:13 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4FF88C45
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso4636161f8f.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683591; x=1723288391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lfH4aIp2Pym1F7OWELDXTty+Eh/EwM5/c+LsHcajr/k=;
 b=GYQ8JOIPOcfCUb7OFGOsJao9zhNc8OGdPLar6ZZtgeM87v8Qm1bgqKe2fwyYdw0fz9
 t+x6qZhFMdKW2dUC2bkEn4GBRqo07qgwfIYrHM0Z+dkzVlLsSqUEIu0lFj1Q6ZMnK6WT
 U0rvSCqHxR1KtoYNvPkyWdWmzPg3SJxmhbBZAE+9fCCxXig5Q+UwRkPT0ypxkV5TyWQm
 IDIJpEs47MZMhogoF7FWIdfKdzFG/+erPHRFAPAdnyEtgCzjZT2Uf+knC5cu0fxnyNQt
 VOQTakZNmTL3kVOXRUM5XoZT3WOHkiHyotsc/Hwfz7ugloTZJUZ3CccnSK4vdjeibwwz
 Y6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683591; x=1723288391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfH4aIp2Pym1F7OWELDXTty+Eh/EwM5/c+LsHcajr/k=;
 b=auVWMbtT29K1k157Bx/bn9MJFTwEil3IuXQeKu/5RwMxj1SuLaJffDiaorYiNYtyVI
 aUEcz2bMj2jTm7SEOSNmtKGeAHuCmgsowovJFkVaT1wKS8ekV2tF+NaXZsCPfWQmnDuJ
 IIUEylzX3MD+SMDKMMcylx1c6VtcLxWIDwsitioCcO/3n1aPHMd9kgzrpzVdrk5W7Zeq
 lz7Du1HyG48mh63GSALS/OF2HifOQ+GZ1jWzdjq31atqD2xbVTTkRm3EZTTWxvgxdG/8
 vHUjDSY8yZUFxxclXm+wfct+zz4ssv+G0LVBbk6sPlF7HtOQOc98IjkCi29d35RHiMs8
 QRJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgzWyl1FFCQSa7Wl1P/xomoNHf4fPc+YBdnSfjzftedbkXDsVIF525k9e9nc86N/Fi35mvsDEpkNo5YYD6pMbo+eFM9w==
X-Gm-Message-State: AOJu0Yzl8sHdKDr5dzddW5/aevny4ygR/I3PQ67BLw92BpIsTfsLSs60
 2NTOD5gSc0GeEWNNM1KWINsERxw12TYsZzcgZKOelwHECIohI0a+
X-Google-Smtp-Source: AGHT+IEhC6WZWZm4QILUt8tE6BRY+XN41LOxs/Z1De0E3jf4vaX8AUrbGdkzyku+DQZ5hU7FMtSytQ==
X-Received: by 2002:a05:6000:124c:b0:360:7971:7e2c with SMTP id
 ffacd0b85a97d-36bbc194918mr4166537f8f.54.1722683591298; 
 Sat, 03 Aug 2024 04:13:11 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 8/8] clk: mediatek: mt7622: add missing A1/2SYS clock ID
Date: Sat,  3 Aug 2024 10:43:26 +0200
Message-ID: <20240803084329.1688-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084329.1688-1-ansuelsmth@gmail.com>
References: <20240803084329.1688-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add missing A1/2SYS clock ID just as a reference for OF_UPSTREAM
support. These clocks are not defined and are not usable as current
clock topckgen OPs doesn't support gates.

These special node won't ever be used by uboot hence just add them for
reference.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/clock/mt7622-clk.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index cd11a1c901e..cdbcaef76eb 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -117,6 +117,8 @@
 #define CLK_TOP_I2S1_MCK_DIV_PD		104
 #define CLK_TOP_I2S2_MCK_DIV_PD		105
 #define CLK_TOP_I2S3_MCK_DIV_PD		106
+#define CLK_TOP_A1SYS_HP_DIV_PD		107
+#define CLK_TOP_A2SYS_HP_DIV_PD		108
 
 /* INFRACFG */
 
-- 
2.45.2

