Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1B9C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B915E88C87;
	Sat,  3 Aug 2024 13:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HGoRXHif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C7588C6D; Sat,  3 Aug 2024 13:13:07 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321C088CBF
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3687fb526b9so4472907f8f.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683584; x=1723288384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YgRtonaE8hCd+bWdqCbKl0gWqVY8uZ649lUm7hnNMxE=;
 b=HGoRXHifB81ofo9yyyplBtKqGG25NL2HMQzQnGfu369lGY4btWpTEAmvHP1N4KAPo/
 Hi9wPPDyXHXuVTIMcGCfg9FGEuDoBwdb65t++iSCtQMtr/vXiH4zhWmgnkMAaw1aS7cC
 p1jmxD2bItfc4R8vFDioP0m/tnQn37dJRCtUm5QtluO4tCwovpXPvLsYoWaSmJf+L9bB
 usyl3xBMl3bsB9eGzCqhnqGX8ZTqcdQjZKepa16HMsON55ET29jsWuC3Sz4nG5qGBOdS
 Yftahz4k/d9wyiG+EdjFu1uhpWa02bu4HUNJZ8jaT+mu2o3GwATjDPc4c57DNVMfhoku
 x+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683584; x=1723288384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgRtonaE8hCd+bWdqCbKl0gWqVY8uZ649lUm7hnNMxE=;
 b=XMsRIeszm5EzZrzF0VRj4j43QCSCj8fRHray9DMbIrBXWirBinsfffr7p0H9xYUt18
 DKVZtixskJimhTpSLQIO7b1or2rXzuCQRlkyVqk04UkkDaKLrFyzzXjH0e582CGS7vVs
 eKT8hkuSOabnKaLAQpTE1Il+d8faBeQfaa3COVl/R/hRe6m1xOVC0iwmjiT5AtVzCExz
 N82lmchB8/rzIf/WUhuuB63T5FGwQsKQL1DxUFEeCIbVC5OYFz28vMF3Ohce7NIuHOSh
 zBjsHa4U5roKZHvoFcZ2uqpy9ZVF6DytDEJqz690QYVMzrSJNcnSGXU3ZrG9xyxPCEQn
 JHSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdfmC55weeLz1OlbzYIT0gwjNZMZvHH4mkwpbjYYOB1/S3ghw5BzFGbCSHUhiCHCb5VC60YM4=@lists.denx.de
X-Gm-Message-State: AOJu0YwfAPLmMCLwBiF5W6pYB2IaTYm1s1p2CuFIK+sb+jZVBGmsWyyn
 sh27rc5aUfRl60OEZOQ0JdF79LJJXoQ22RPS58WOGjUH0IrKPxYg
X-Google-Smtp-Source: AGHT+IGEYseUTfHHAs0zZdsvhRtoyvSernVu8PRv/sRT0T4xVXHbzTB0W/zhiazi2V+nVOOItDg9RQ==
X-Received: by 2002:a5d:42ce:0:b0:36b:a3f1:eb with SMTP id
 ffacd0b85a97d-36bbc1d2e59mr3550272f8f.53.1722683583600; 
 Sat, 03 Aug 2024 04:13:03 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:03 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/8] clk: mediatek: mt7622: rename AUDIO_AWB3 to AUDIO_AWB2
Date: Sat,  3 Aug 2024 10:43:20 +0200
Message-ID: <20240803084329.1688-3-ansuelsmth@gmail.com>
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

