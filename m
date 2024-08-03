Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5898C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A464388C42;
	Sat,  3 Aug 2024 10:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h6nkRUuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369F388C1F; Sat,  3 Aug 2024 10:33:24 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 449FF88795
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so22326785e9.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674002; x=1723278802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fuUbJOSESbkz3189PHvOrfcEyrvwAT9Q3E5/X0e5IJ0=;
 b=h6nkRUuA1zSOBRvts2aQqhcO32Cy6qxOJIaKnkEsCbAg34HRVFxyh4BzgdRtJFVtId
 +VOQEedHMMOSEPXB6y/RfWt2Px+FQSvkdQCGtRjCEG5xm3h+jMlvEbeRrrZ9xvvVMkgA
 Hk0J08LQIML4FlJ68F7tYx3xfD91XiUjHIjbdixyfQ/IAC9hBqu84sShsjFPuDusqSma
 1R+Wb2p3SYJ+lGeq9GiAMqYWM5qP1nWMzGLT1r9nuuqVlxUNpjnOaIB6aSuLxKSW2Lu4
 4QBnbL5nshDZ2oLdlxcJ/IlKoVgthp54P6/G/85Dz1LQjQtI85o5QQyFtVZWO1YS5+eV
 HXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674002; x=1723278802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuUbJOSESbkz3189PHvOrfcEyrvwAT9Q3E5/X0e5IJ0=;
 b=kVy2sipE4LoaH30jzTs1sealCZ2RClui1aEYu7WadhP3bYTND5Qr0wXAzFN0UkmqsO
 IekoDl/6EuIW/TeMu5lihZM5zWRnnRBg6FOwB2Z6ZFw71t6A9dK4BQ4cKW/7cOnm6BzN
 uBgiUDO7FGCodiGJKaVJMbPXpZToYlHc3Ir63H/tWWZE94OfNXyw+oqwfefRq12b5Hm4
 oIvqw1B9Ur9W5YzJZWKmfDSYHJk+z0jATkDtDkAavZyfQRv9nJSUQM8KjRVo8gEMjWlJ
 2Q+fx86Tsba6mOAbQMRFPyqD51h+p8fgoKLRoUxrl9eS6mZN68iJtVlf6zaeWxKl0uUk
 TCsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVklJa1medeHTIfB16eFAY4tCSZAQz2UVO2QYzLVQAoM1kTb2U6PrqONqEUlhtMPwQtcyw9JbrTF2wLnECQNXAzrLw4Gw==
X-Gm-Message-State: AOJu0YwoC8Q/nZEzNLjedtOFSeujg71R0HHioRMbYLQcmmHXI45Udv5g
 Y3nWRVqrOfavKeA3KHIOWNl5X5PQF0mWKy8UKyxqyVgslViLNwgP
X-Google-Smtp-Source: AGHT+IFSB2G8l7SU+HJaP31qML7pmj4l5Lryqi//xMK/rY0jIbvq7gWjjrwflMp3zKcMONyJ/4G39g==
X-Received: by 2002:a05:600c:190e:b0:426:6327:5a16 with SMTP id
 5b1f17b1804b1-428e69f6157mr37728025e9.18.1722674001596; 
 Sat, 03 Aug 2024 01:33:21 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 02/13] clk: mediatek: mt7988: rename TOP_DA_SELM_XTAL_SEL to
 TOP_DA_SEL
Date: Sat,  3 Aug 2024 10:32:51 +0200
Message-ID: <20240803083305.30697-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803083305.30697-1-ansuelsmth@gmail.com>
References: <20240803083305.30697-1-ansuelsmth@gmail.com>
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

Upstream kernel linux clock include use TOP_DA_SEL instead of
TOP_DA_SELM_XTAL_SEL.
Rename this clock to the upstream kernel in preparation for support of
OF_UPSTREAM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c      | 2 +-
 include/dt-bindings/clock/mt7988-clk.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index e7ef58c4fb9..e2324f40084 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -396,7 +396,7 @@ static const struct mtk_composite topckgen_mtk_muxes[] = {
 		da_xtp_glb_p0_parents, 0xf0, 0xf4, 0xf8, 8, 1, 15, 0x1c4, 30),
 	TOP_MUX(CK_TOP_CKM_SEL, "ckm_sel", sspxtp_parents, 0xf0, 0xf4, 0xf8, 16,
 		1, 23, 0x1c8, 0),
-	TOP_MUX(CK_TOP_DA_SELM_XTAL_SEL, "da_selm_xtal_sel", sspxtp_parents,
+	TOP_MUX(CK_TOP_DA_SEL, "da_sel", sspxtp_parents,
 		0xf0, 0xf4, 0xf8, 24, 1, 31, 0x1c8, 1),
 	TOP_MUX(CK_TOP_PEXTP_SEL, "pextp_sel", sspxtp_parents, 0x100, 0x104,
 		0x108, 0, 1, 7, 0x1c8, 2),
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 88a5cf45ccb..841dd419e75 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -299,7 +299,7 @@
 #define CK_TOP_DA_XTP_GLB_P2_SEL      125 /* Linux CLK ID (60) */
 #define CK_TOP_DA_XTP_GLB_P3_SEL      126 /* Linux CLK ID (61) */
 #define CK_TOP_CKM_SEL		      127 /* Linux CLK ID (62) */
-#define CK_TOP_DA_SELM_XTAL_SEL	      128 /* Linux CLK ID (63) */
+#define CK_TOP_DA_SEL		      128 /* Linux CLK ID (63) */
 #define CK_TOP_PEXTP_SEL	      129 /* Linux CLK ID (64) */
 #define CK_TOP_TOPS_P2_26M_SEL	      130 /* Linux CLK ID (65) */
 #define CK_TOP_MCUSYS_BACKUP_625M_SEL 131 /* Linux CLK ID (66) */
-- 
2.45.2

