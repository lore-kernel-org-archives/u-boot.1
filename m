Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550A6C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5FE88C3D;
	Fri,  2 Aug 2024 21:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CaGIDBF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3EE88C0F; Fri,  2 Aug 2024 21:52:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E18088622
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so58191745e9.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628318; x=1723233118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YgRtonaE8hCd+bWdqCbKl0gWqVY8uZ649lUm7hnNMxE=;
 b=CaGIDBF4Lmjz78PzRIfvvEAEYWstSaZAtLtsgRKJhEFHaV9x6Sp/zufFmiHounJ5bn
 58iLuHLNKQDFuLkNEuLkzy7kLn1ZgzgIodkpThOYq9YPTZeXGM7mSTvHPDJdMsms95qe
 3NFHlKwCmGy22iMn+s3UlJDJMhO/i9VwI42ob6zTTzvCwHcEGMwQuna0tnu3VF05m7Px
 wmAQrOkgaqDa3sLh9ga8VDJVZ+xqrnfsEJWpyZwClPk2EgqyF0qUaJ42PBCJr0URinba
 2F956v8founG/4lVN3l6JLS2d4KfQjpEO2w7cYiZAz8TbJ2djh8VNBHFA5OYEMbdJVyk
 KiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628318; x=1723233118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgRtonaE8hCd+bWdqCbKl0gWqVY8uZ649lUm7hnNMxE=;
 b=LmB1Dw6nV4RE8HnEkxiKx4kikjnQ2O2Db/VyNrnXOgNZONnULqiuJytuud0KxTd5UI
 u6Jmv71mmbD1XUSykQRPSOOHJQITPGPvB5CzkiP6s+XCd5wXaS8qmBA22ohg0tU8QRMK
 E+VPE7Ep/LnOfk7ozFMkzmlJjxfG69xzt9uvnPS0KGybuuLhUfPI6Wagum/d6UNR9IFo
 geApNUFUXLJLROD3uQ/hFBI5DczrINcIAYp086Wr9/eRloo47Zq19JXNf1u7AUZGJBNY
 zN8FeP4eOo1ZjUv5MMz34EigGZfRz1S33HphFi7pgRqz3t1ckCkVVeTn0M3j6omdyFYt
 b94Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGZGxl0vU2aGCUxf/3oxQN2GTJfwu5RqrndHTqrqd9cp5kd6/zK80NBsQXixyQU0xeTF8695kO4lZ62WnaPEsL2BpnLA==
X-Gm-Message-State: AOJu0YxAmBBdJYEMBOHUxna49dTgDUkLxWAan65LfqxOk8rHtcFtL5aQ
 vOSG3kN8KuPz5+EBBJFELcdL9abKK/hmggvsYXgw/b1jfpX+kcA+
X-Google-Smtp-Source: AGHT+IENK1p0+M6m1ookQW2qNU3829RsRzDwlHhXfH2YhNB8G2mO2cDYpsiyR0zhGKHOg7bDzN+aCg==
X-Received: by 2002:a05:6000:cc8:b0:367:8909:197b with SMTP id
 ffacd0b85a97d-36bbc181e5fmr2745000f8f.61.1722628318478; 
 Fri, 02 Aug 2024 12:51:58 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d03fsm2643344f8f.91.2024.08.02.12.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:51:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/8] clk: mediatek_ mt7622: rename AUDIO_AWB3 to AUDIO_AWB2
Date: Fri,  2 Aug 2024 15:48:26 +0200
Message-ID: <20240802134835.24006-3-ansuelsmth@gmail.com>
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

Rename AUDIO_AWB3 to AUDIO_AWB2 to match upstream linux naming in
preparation for OF_UPSTREAM support.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/clock/mt7622-clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 76fcaff0e42..78804f40307 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -206,7 +206,7 @@
 #define CLK_AUDIO_DLMCH			31
 #define CLK_AUDIO_ARB1			32
 #define CLK_AUDIO_AWB			33
-#define CLK_AUDIO_AWB3			34
+#define CLK_AUDIO_AWB2			34
 #define CLK_AUDIO_DAI			35
 #define CLK_AUDIO_MOD			36
 #define CLK_AUDIO_ASRCI3		37
-- 
2.45.2

