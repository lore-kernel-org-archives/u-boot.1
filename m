Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F23F357AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A17483E9F;
	Tue, 24 Feb 2026 15:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mhzd3TWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE19083EBA; Tue, 24 Feb 2026 15:26:31 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B0C83E96
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45ee8823e2aso3195686b6e.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943188; x=1772547988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uNn8Hc0/O12D7lFhnhWytDDywwCZlY2GYaQWxhK/W8=;
 b=Mhzd3TWq+6q46ijsOBIsZ7LEMWmjLwPj0N69UC/GXNALAFYeey6DnavZvon95NfyQF
 MXO7iGrnzt6+DGvUUgHjNYuA1I01iM+aPEOU7kZQLOZ77pL4k9xkn7Qq9yzZcqfeN4qh
 ES0mZmXVr8Z6aYjaLtdQSF95Q8x+WfM/ElbjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943188; x=1772547988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3uNn8Hc0/O12D7lFhnhWytDDywwCZlY2GYaQWxhK/W8=;
 b=CjvxWpQQKwZ6fVvk8EQikOHoxgH1z6HpMgtt0C0BC9bXcSV3ZMgXf6rNjkZb6tgYgG
 VusyEFoWlcPje5TtVYyfJPoMR47z2rwFBYDar/Wq3eF1c2WxidvSr6ehVVxPIpP4YkqS
 q5GnRTV2CmeIlPsokTi9DjQNITD11xpgz7qhVCtvPPdFvfGv1iKOQgfsDC5C/ofIpjWN
 t2CFghmZLaIL9eRk/yBRd6eD3XtOQK8YAA/DQuG+chDIqeNiirVpe4ekAhZdNHxDIsbQ
 yZ1RnmdKWMUe/zu+vURWjQC82SGRYu09u3dU1g0YuZ0vaLRH430frycRenkXjVL11bA4
 kGyg==
X-Gm-Message-State: AOJu0Yybzbh6XNX0fYoFGsh7MpkvvjaZETyjPa5Dui72XgTmv/uik3XI
 FWBRk7u6MEdjrnHi6mYIAZIFoVZ9G69LKOazoZCpArHlBIBm5hliMLItgMLR6MKHgN+pfF5NFS1
 xnQM=
X-Gm-Gg: ATEYQzxNzvu0uSlAAXg7UXVu26/JGK9mgM32W2ZYYHnC9oL/nImG1uUrbBcvlQn6VId
 RwxqxTphNs9EUDo8UEerAXftQs0Tbb9vH+O3w2KQ2fE8nGu4XhzJT6Y8MmWT/MXjitNWQpAdI2f
 DdgrjF410OgUEHwyDjeUS9+SJGfxB7OrRELqcHUVSx5lkFOA9NFHz1pVTKrRqvHxi3yCIlqyQSv
 kSaYkgMcHOdmUUbtonLSSjD7vPZlCAXLwaZ3Ia26eZOESJSvsOm/B1Hof2ev38PIHMDwQBkb87b
 49S0fGPJ80MD/Yz94dTRzn/hJ3XS2I41ho3XXFgTikbREwbIalzyeSJhWzQ8ZW3k/Y3zD26JlVZ
 Kb9gXH1FECFrrUIx4PjG083VV6V9AprTcsZXsRFcD8XNhSATAe/WBLbhZQu/ZpTjlMd4TMLmoh2
 BC4LkX+acCpZzM1HigY1hlMdx1xLodBw==
X-Received: by 2002:a05:6870:c0d4:b0:415:2295:c45e with SMTP id
 586e51a60fabf-4157ac7c0a4mr7534409fac.18.1771943187765; 
 Tue, 24 Feb 2026 06:26:27 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>
Subject: [PATCH v2 4/9] bootstage: Add some missing dummy functions
Date: Tue, 24 Feb 2026 07:25:46 -0700
Message-ID: <20260224142553.1608883-5-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224142553.1608883-1-simon.glass@canonical.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
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

Neither bootstage_fdt_add_report() nor bootstage_report() has a dummy
double for when bootstage is disabled. Add them.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 include/bootstage.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/bootstage.h b/include/bootstage.h
index 528d0ca0614..62fb99110f0 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -435,6 +435,14 @@ static inline uint32_t bootstage_accum(enum bootstage_id id)
 	return 0;
 }
 
+static inline void bootstage_report(void)
+{
+}
+
+static inline void bootstage_fdt_add_report(void)
+{
+}
+
 static inline int bootstage_stash(void *base, int size)
 {
 	return 0;	/* Pretend to succeed */
-- 
2.43.0

