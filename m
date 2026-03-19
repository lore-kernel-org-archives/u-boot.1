Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75E31091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D6784068;
	Thu, 19 Mar 2026 21:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qA5vvcB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D4A83E36; Thu, 19 Mar 2026 21:02:38 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4005584073
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67c2045c0f7so369429eaf.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950546; x=1774555346;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OoD9LATK4ZuqGD/+oAjgrEKcq/YxBlpMAK8sS5Jqir8=;
 b=qA5vvcB6K25ED0YrZijcIsYeUbf1BEBe2TXuwKjlyq/ZYQ1z9Ty/xfTsG4IbxECzH5
 JC8zVWg6sDgA5FBinpMpmOtRxZ19u5ibfkYXv4rwcy2eYxJkRk12GWT9y6R77xvwJEjg
 K0NnoLACtRLmY1KwhaCbyRgclmDG3jezCivc0Pv99ss2M2SukFxjaaIRj97Y3hawIHpl
 0uT7QFoMgJVzURSG1d10vPL/tIezOCMpdTzFjsSrssatvWW1PDjCLaT+yxGlBz+e5kkq
 gzuDdN7yMWwjxsWBevPks7IUIEM++kaAxPzPKjkfWaBS1hzMFl+VY7WZbeoyIkO2PNfv
 8xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950546; x=1774555346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OoD9LATK4ZuqGD/+oAjgrEKcq/YxBlpMAK8sS5Jqir8=;
 b=ECIkIEszG7hbXJE+69Chk5RsxPSwaU4bczFWp9uMy1ksKqGsAO0nxAS7qOQ53+baYO
 /QaG1EAJV6WBDO5PqDgV82iBnYXskhM/0DWoBznsJ0/BgSodVHD2jacjkJnf5FRwXe4I
 YU7VplWoRYwHLb4uMY+rcOfxkzIYgFuR3bwBCMjHxnlMY+DgIumVnZe1SeU7DTB4ApgZ
 sARsCZ4TYb+XTnqDBXZXMste5CGAIGW5a4bm/4UP6sFy7+Uinj2303yAznPp3NHVS+qz
 07Qc69Du79vVgom46bYFIMtaaLUks6fFtmbYe4PMhtKEmRwz6fHRkJg12VlVq3mqDOZp
 uaCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWXKbSJimbvB4l/30i/rMfngfaMjksyePe3rGnV2/encrKaLISQb182Z1lgTMRcOeN26yrj/s=@lists.denx.de
X-Gm-Message-State: AOJu0YxognkrotHM5PAjpGCJ59qzRFRIcBmjKk72yWTlIhp5XQEfW2U6
 9pvxi3SvvqDIcKo7XB3DjlmV778zwZiiU61Bk1VdFP9gzB33gHXt2misRX8TK2bMpZs=
X-Gm-Gg: ATEYQzwF7H2Jjz8dLzRpkKty9/WhEMS3joeArgJ8K+IFG1evqi3ToXojEk7c/IZThAR
 bMtZAEt/lRVQvQB7q0T9QKz9oGUuk9qx64Hs7jXsNHzOEruXZztvrRf4ZxhmBxwQpj9wrLQgi79
 f2Gj4MMzBN96/KrD90agfz+oSlkKlWQjW+hyjcYcaoaApa5vT+vKIPi4sVYHUKAwh241XlR/CKS
 v6XpC2ODn7D0Oih9QMX580+WmzDhzN92OLP4QTd9sLBbDHc4O67GNdaYR1OKl6fh9c3ziVEFBIN
 papPb7JQXMDax2h9RY87W8uX0asv8X6HfKmV/92qsVCnV6LbJpIKYdY2vH/D1MOcXb8HkeCZUc8
 ioNkBPnu5Uan5FpvFUc8TyIBqI7i3pVFtGU+JzC2TuDmkjkw53SUYX8AZyWdaIh2qdoYMPJN8iF
 jmTp4bxWeo0OfsyTGpyS3umY9B3umv
X-Received: by 2002:a05:6820:1521:b0:67b:bd6e:80d2 with SMTP id
 006d021491bc7-67c22fc9252mr507023eaf.72.1773950545756; 
 Thu, 19 Mar 2026 13:02:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:19 -0500
Subject: [PATCH 16/17] arm: mediatek: mt8518: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-16-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=NiV1cvoWnQYhwlOMZdLM3koVvXfpEB8ZXH7sbJrn9Z4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFYwNH1QjMYJG7WYInZ1zmMfzJw6mCcMr20bI
 LB6tePUEw2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWMBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2T4H/0LzUVpOZ6ASVo3mANOEAlVW7Qs7RrnWYsg5HJ8
 jXcNu+1gfrvYa3YDGqep+U3xeadklFWLDjGwoHzqT7kuWmFbzHEGZshtPnSfSCduA1Xe/bUcdts
 xMHLdYztKrMb5xKvFzN/ntJKYviX4vI5/Li59Hu+Jfq7swpOwJb9ckrEnzVmQuhjTG0VJSNvcpt
 ZUu2i4gM2ZlU2iL2FF2OK8QOnbGLvIvnZ7R4FMwIVa0HOzaCF4EHIwlc+7gqxHYSzXFNsY0hnVt
 E3zVtkt90Ki6hB3XjIivJHAaEmquS6b+uulpHcLtdUfG8/eR1y2Q/wizJky/leXGJ0K8EvUMCwA
 55C0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Drop override of dram_init_banksize() weak function for mt8518. This is
effectively the same as the default implementation, so we do not need
to override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8518/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8518/init.c b/arch/arm/mach-mediatek/mt8518/init.c
index 8fa1346021a..ca64f5d4767 100644
--- a/arch/arm/mach-mediatek/mt8518/init.c
+++ b/arch/arm/mach-mediatek/mt8518/init.c
@@ -33,14 +33,6 @@ int dram_init(void)
 	return fdtdec_setup_mem_size_base();
 }
 
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	psci_system_reset();

-- 
2.43.0

