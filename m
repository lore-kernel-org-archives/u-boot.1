Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C78C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E211E88C4F;
	Fri,  2 Aug 2024 21:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SdXn3iq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8837E88BD6; Fri,  2 Aug 2024 21:52:08 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6E488C59
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-428119da952so55186415e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628326; x=1723233126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lfH4aIp2Pym1F7OWELDXTty+Eh/EwM5/c+LsHcajr/k=;
 b=SdXn3iq1CjCqTBAQI1EI+qNtIrVL8al0reQmlAsDMkHAmqP5R852alLesQXvjv26ig
 EpwVmaQT3IHVA1ys9BPn7i6xaXheFLxXah9risgtOmvbsJspUQeGBPuBZK6tpfx9sj04
 Tj5zeL2gjOwj6SkXKdp9QxziZz62jRWc8mMcIK4D5DeCJkTQjI9pj3eDUzDCJqfNa/Rz
 SHJTSNVdjXv9WLWP5cTzsdjNjdToibRVIHg7I3fZvzvAjl0p/eLKKOQKjzf7lYnpUWyn
 bF/cuW93awlGSeQ6DsLRGdLHaiGQzGEnf5hl2eZMCeoAdgz02L/ttj5I/L2u7P9IqBaS
 uiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628326; x=1723233126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfH4aIp2Pym1F7OWELDXTty+Eh/EwM5/c+LsHcajr/k=;
 b=iEhunz79E3bSuiOPyNA9R5FSPKhnGoaNyL8yMdKQe/v8w9VvOCGEHFvKCg6koDWMGX
 8VlCYznef96gMo+adcrdJQeF6aiHvjgMr7hyaDWhJaP/r4NmpdLUyMrxYhwSfW9uPG/K
 hWquTU8s3edmoW+LqffAHBqCFVxtxN1cfui1px0il4cYs07S47oyWUqI8zftOtDuGqRu
 /Fai+triY5l8a76mMP9MopTQ7WkwW3gv/P3e1X/3uMF6rWwGM1mzTFt6b94cZ1nCd4ZP
 hhDvslnnx8VxiscmUJoIxfVF4N9LR6C0qL0ssJQRdHTai8W02f7cK1MK8aH5VqhF6lrT
 cXJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0AJOXwtjrBta6Vjftw+5c47MN/njQvgya7ruZ5mm6fM+4BYW8m88+fdMWl0zsFijDLm1iYl2InYRMuzePDuAcCMu1WQ==
X-Gm-Message-State: AOJu0YxkbLeGArpUErV06dm/rWI2UBVLkOtxC816dk6hMMLnsBxVkvD+
 YIaTRgigqM+e5vsKwNwHMireix0zD/kymJIEB+Rjaw6bXRLXzhVP
X-Google-Smtp-Source: AGHT+IFfkOwaGRoLsuVYCiZh0c+OkbnZZY1jJizRUUbHfA7VKz358F1siU9HpI6rc69deODy48cpUA==
X-Received: by 2002:a5d:634d:0:b0:368:5a86:c1b7 with SMTP id
 ffacd0b85a97d-36bbc1c22cbmr2774055f8f.55.1722628325579; 
 Fri, 02 Aug 2024 12:52:05 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d03fsm2643344f8f.91.2024.08.02.12.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:52:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 8/8] clk: mediatek: mt7622: add missing A1/2SYS clock ID
Date: Fri,  2 Aug 2024 15:48:32 +0200
Message-ID: <20240802134835.24006-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802134835.24006-1-ansuelsmth@gmail.com>
References: <20240802134835.24006-1-ansuelsmth@gmail.com>
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

