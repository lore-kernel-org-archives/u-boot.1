Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A758C88E40
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 04:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB3F980EB0;
	Sun, 13 Sep 2026 04:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BGjuiCDopIGa; Sun, 13 Sep 2026 04:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 395CD80EA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789273411;
	b=LiPkvRr5RqTsQmEsX2kCjKzSRBibFpExjmvy3RZPnK/zGhXWYABwkNJlUOyw3sCbQK7N
	 kDK+QX4GSSvOn3h04kN6nu8m6G+bOzNMV8KxToBKWFptz9tt5ph7qWTHSPfaV0vYN1eM7
	 Q5ADXFUy7fnkC8/JvR+3B41Dt5eYbGYz2pkvJfJ8kT8qGl0uSzeW6kyPeZQ8woVHp8+Xe
	 T2Y0rj3qJ+BK1/by+r/A/aU24wmLMp2IzaZLutJyKEj6QnU6M7Q2EJzS7by17hNtl2sZk
	 j0W+mgBssQpLXRh7f0uRu6tmMmiCOJSI9lffR51UoKDXJDoPHehr0fhCZefOdfpp+8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789273411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iWydIhFOFzXYqCZCesagWwMDIbk7S1/IsFCA0pQwAt0=;
	b=sxvt66+0ezfATQXdOdit9LHKY8TInlSLm2MmEFX4mAPS9k26cOfoRhLoNS7gP7K7/YfY
	 ohud41qy1pV1h9tF9oePqWOpHsbJ76b6NK/czZo4JqdiOWqX3cYNpLlmKyhkVASfWgGg+
	 gI87SMD+9CAA1d4/cRpAeX/Q5bKVeHM680YwSjeYUvreitlltXl8H5bf6EnxmsaiX0o2M
	 Qegyzs5NtRGqmO6+QckhxO2tADECat0ACzxyPUk4lti3G5UmeQJCldbFOoBbsLmhnBl6D
	 7plLuij2izZKVdmX1nv9/9Bccs9S+EZtU3kr0uf6JS9IH+d5ANx1wUY+vUAAmYDbFJw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=C9p3HWOm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789273411;
	bh=iWydIhFOFzXYqCZCesagWwMDIbk7S1/IsFCA0pQwAt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RjLajhKrfRdUTWQw/5umhHPwphbtffpw+ivrHdREkBj71N7zBep54/p8qP7SmyVN2
	 3FN2DOPp+DZsbGMK5Jv1K067mJ4bg+3akKS4KNG0DOTfIWpRr5gRyd5GqQZJPkjY+Z
	 VK8t17mCpM5Gh2NdetlaWlK4O2gzT423DShYVJehuU+GOaDBPhtLSwzK/Wphlj4ECj
	 kWEK4434JjZLE1g0TZ8imp/Ca26xpC44o3Ptmzv839pZl+kYDRyZgug8NJnj75I+6y
	 /HYnqUC2Po0NIGfnBA/XpSfG0QJnFdPW80l256neQUdSAZJQ77rKJ6UXy3kA3CxhyV
	 oUBopbui7Y73A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 395CD80EA9;
	Sun, 13 Sep 2026 04:23:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51F1C2D0
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4366A80E85
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UR7Lb9cccxXt for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 04:23:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B795E80E79
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789273407;
 b=TNioOh4ZU3FqzrAR9km0DPep2YQQQ80XbXhdiSsEaZFPciCTzGSUKu01YKmfZTGhPRKd
 ERNF2FGdi1BukelYaEaACALbqT7gqJ+CW8h7CB7dea7fl2hCB+Ts9bvW79yU2a6HA+yrR
 MJAXaZG/rW1F0uwH3cDO+z0x7vEREA9UCrAg07g+ZSElHYqBqTl2d6S5dp5BM86uwzufb
 YDz2ObPHZuNq/TyaANuGZSTwp/pI9G8neVP2mnovZChgot+EyL22VYkPxofJG8W3EFJYO
 vsv2TseCfIPLFJLArBYASmuAufUH10m4LrF8vlRaURn1ynyf8TQhesxkJx2eiRIiNaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789273407;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=iWydIhFOFzXYqCZCesagWwMDIbk7S1/IsFCA0pQwAt0=;
 b=fmdiYkGuh7PTMvRvP9S2tOMrtMCxGEnQhuAQK5fADbW4HnxrvVXd+zn4HptwgbcXrUN2
 aA+Rsn6xfW3SaQ1YKX+7CEVBJqM91sTmAgBBksVK5AabyMkeeUiQ+icA7PCzCMhlssO+i
 NGYIx42bF8dAynhFQsj2q2rgj2GqGcL0+tItJJwkHU2/k6VcqWKxZAy6/Eew5mO3BxdEM
 Z38iIwlG+9mb2BGp2a2vyS3qNO+pEmFzqSOSC/fsIneIWKG3bzr7VSRF9sY/RXuGKWYIg
 vKqm7NyrqVVqqtW3B2EpXniKhpMjWzhswqYG9F8ZJ/s6OsZdKKekDoRbKb7nBDijAgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=C9p3HWOm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=C9p3HWOm
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B795E80E79
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:27 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2dcff8f44f2so33109025ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 21:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789273407; x=1789878207;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iWydIhFOFzXYqCZCesagWwMDIbk7S1/IsFCA0pQwAt0=;
 b=C9p3HWOmneqIOzbVppf3GYZyD7yflx7CtFDb4urOEPHIc1moYVnEQe0WqFgDl9uuFa
 TjCEIqVa1znUPrkmSfGCKsVq/tZR4EWecu+qGDnygivYz86SegYh4pTqEdnNWb2cVPsP
 EItGx8F3gKnXnTJBIZMrh3DhMfITwlXb+zNO+K8i6NlWswJAdT756oD3PaDUWTJhn61B
 uFExJXagKgSjc0IroSHQyHRRRnZmh+u22vLo084djYbkRkyQEMoSjXERq7ztiGeRCUrv
 6EMA1wd///7hZQGUyZNsmxBKfsXzIHbYIwYNnn2QbDpxjWvGnsM0bYBTYVw5Z7gQXvLN
 KEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789273407; x=1789878207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iWydIhFOFzXYqCZCesagWwMDIbk7S1/IsFCA0pQwAt0=;
 b=FFHqiFJ4yquo8gMZjsOnDqvimqIq5SBHhkDLKDviA5Bj0iI3Brbc48HUrtRKtFVEpS
 HuV/KLNOvzj2UmqnRjSyM4Jhhm2YlENyHJjCfuDbb/jXMStnp6bfjd65tewHzZyzplaB
 pCrasYOU7btDCSZ62kulfTMr/n36N4frp1WyuR0vreclfKKr70IKiuV828PO6xaOg2pu
 tkXeFrk9mKI+vPsFq4x3dt1zu/GHTrPPjzh83PCRMLH58fex5rnP1WS1JclAwH/F35AN
 uHzimQFyp1ceR38foFxXzC+i1aFtrmcMbuZ+P540mSwHE/ofcuCGcdxZULYtd25qbPYj
 +xRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPRPP4wzotddry835RoPHtwTQWKsryDCIr8hJDRF5FUqTOP4tDcP0UxoO2erzzc+eG76bnyvk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lGYqZc1dfwR0FvFiDXbGRbRbn6WGJpWrf8Rl395QiRUDa303DQ
 YQ2l9qIj9vUtOaoHaFVa/1ijcd0WfPMEFf5ugtDyyy4nc1wn7YcoOuxXrDwGbwnlWF8=
X-Gm-Gg: AYBFou2Te3F0u9D8/85dnXweqhHk1XMyBZVhmkv1utGg4gsF+bjY2VeTgKstAXOPlL8
 9Wb8bUCAQofOYt2W4g3/iPLfPPYRhEiEG+IxxROgM90ALyWd8D0hFcCzS6t+Dco/TH+N67A1PeG
 VZaZGCGOlKWbCFCABynr0IVvAIQcZkCc3k2AaGJ6MEiMWRXjapcpkpGnPHxhUBq4uF+DYU4g0t1
 x9roBL+9FqUE2Fbk9fLv8wYedoVeUnU4mkb2wy8uTTVxA3R7eSrxoiTK8aXyGDqa8Ihd2Q/IzAY
 X7WcuHE/dTHTwmT3vI24XSXOcpKFSXPegZnHHjrXZVPyn9D6BlS6QY3VOW4v67J4SizmrUFiJ4j
 /1F8czBNARNIXgG2RSJ3ir/eVezYDTpa9rzfB3PP+hU3iTmYz1IZuITLv073EflfSTrenpzDrmi
 g4wR+ZMfkId5hqvxK5AIbY89R7TmbSYshndMP+//YTHsuAcA3P6Rihnf7bzgvJQkUY3xHoTMRsK
 xeiGB0sHcpCkiDlfTHO82QOJcrCkt9yFfdgGrBBLMDWBpzAtpxXEJv405tk9MWERVDnHx7fhud9
 8N6Aels1ESgN+d63Gtqmgm3sthYtvyoGAri9
X-Received: by 2002:a17:902:f546:b0:2dd:40cb:a04c with SMTP id
 d9443c01a7336-2dd40cba291mr135588995ad.19.1789273406815; 
 Sat, 12 Sep 2026 21:23:26 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm19389409eec.15.2026.09.12.21.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 21:23:26 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 13 Sep 2026 12:23:10 +0800
Subject: [PATCH v2 1/4] phy: spacemit: add K1 PCIe/USB3 combo PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-pci-v2-1-4fa1a8b5de06@riscstar.com>
References: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
In-Reply-To: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Scott Bambrough <scott@riststar.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Siu Ming Tong <smtong@axiado.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15.2
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

Add PHY driver for Spacemit K1 SoC supporting:
- Combo PHY (PCIe/USB3) with auto-calibration of RX/TX termination
- PCIe-only PHY (2 lanes) using combo PHY calibration values

The combo PHY calibrates at probe time, and the result is shared
globally so PCIe-only PHYs can apply the same termination settings.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 drivers/phy/Kconfig                |   1 +
 drivers/phy/Makefile               |   1 +
 drivers/phy/spacemit/Kconfig       |  11 +
 drivers/phy/spacemit/Makefile      |   1 +
 drivers/phy/spacemit/phy-k1-pcie.c | 492 +++++++++++++++++++++++++++++++++++++
 5 files changed, 506 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 6262380a60a0..6c5816e67a78 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -369,6 +369,7 @@ source "drivers/phy/ti/Kconfig"
 source "drivers/phy/qcom/Kconfig"
 source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/starfive/Kconfig"
+source "drivers/phy/spacemit/Kconfig"
 
 config PHY_COMMON_PROPS
 	bool "Common PHY properties support"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 19cf95759e57..3256e8bad8d6 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -51,3 +51,4 @@ obj-y += ti/
 obj-y += qcom/
 obj-y += renesas/
 obj-y += starfive/
+obj-y += spacemit/
diff --git a/drivers/phy/spacemit/Kconfig b/drivers/phy/spacemit/Kconfig
new file mode 100644
index 000000000000..3c47601c1fd4
--- /dev/null
+++ b/drivers/phy/spacemit/Kconfig
@@ -0,0 +1,11 @@
+config PHY_SPACEMIT_K1_PCIE
+	bool "Spacemit K1 PCIe PHY driver"
+	depends on PHY
+	help
+	  Support for the Spacemit K1 SoC PCIe and Combo (PCIe/USB3) PHYs.
+
+	  This driver handles both the combo PHY used for port A (which
+	  calibrates RX/TX termination values) and the PCIe-only PHYs for
+	  ports B and C.  The combo PHY must be enabled even if port A
+	  is not used for PCIe, because it provides calibration values
+	  required by the other ports.
diff --git a/drivers/phy/spacemit/Makefile b/drivers/phy/spacemit/Makefile
new file mode 100644
index 000000000000..3496c099cdf3
--- /dev/null
+++ b/drivers/phy/spacemit/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PHY_SPACEMIT_K1_PCIE) += phy-k1-pcie.o
diff --git a/drivers/phy/spacemit/phy-k1-pcie.c b/drivers/phy/spacemit/phy-k1-pcie.c
new file mode 100644
index 000000000000..e54742a2a9c2
--- /dev/null
+++ b/drivers/phy/spacemit/phy-k1-pcie.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Spacemit K1 PCIe and PCIe/USB 3 combo PHY driver
+ *
+ * Copyright (C) 2026 RISCstar Ltd.  All rights reserved.
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <errno.h>
+#include <generic-phy.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <reset.h>
+
+#include <dt-bindings/phy/phy.h>
+
+/*
+ * Three PCIe ports are supported in the SpacemiT K1 SoC.
+ *
+ * Port A (combo PHY): 1 lane, can switch between PCIe and USB 3.
+ *                     The only PHY that can auto-calibrate RX/TX termination.
+ * Port B (pcie-phy):  2 lanes, PCIe only.
+ * Port C (pcie-phy):  2 lanes, PCIe only.
+ *
+ * Calibration values from port A are used to configure ports B and C.
+ * Port B/C must not probe until port A has completed calibration.
+ */
+
+/* Offset between lane 0 and lane 1 registers */
+#define PHY_LANE_OFFSET			0x0400
+
+/* PHY PLL configuration */
+#define PCIE_PU_ADDR_CLK_CFG		0x0008
+#define PLL_READY			BIT(0)
+#define CFG_INTERNAL_TIMER_ADJ		GENMASK(10, 7)
+#define TIMER_ADJ_PCIE			0x6
+#define CFG_SW_PHY_INIT_DONE		BIT(11)
+
+#define PCIE_RC_DONE_STATUS		0x0018
+#define CFG_FORCE_RCV_RETRY		BIT(10)
+
+/* PCIe PHY lane calibration */
+#define PCIE_RC_CAL_REG2		0x0020
+#define RC_CAL_TOGGLE			BIT(22)
+#define CLKSEL				GENMASK(31, 29)
+#define CLKSEL_24M			0x3
+
+/* Additional PHY PLL configuration */
+#define PCIE_PU_PLL_1			0x0048
+#define REF_100_WSSC			BIT(12)
+#define FREF_SEL			GENMASK(15, 13)
+#define FREF_24M			0x1
+#define SSC_DEP_SEL			GENMASK(19, 16)
+#define SSC_DEP_NONE			0x0
+
+/* PCIe PHY configuration */
+#define PCIE_PU_PLL_2			0x004c
+#define GEN_REF100			BIT(4)
+
+#define PCIE_RX_REG1			0x0050
+#define EN_RTERM			BIT(3)
+#define AFE_RTERM_REG			GENMASK(11, 8)
+
+#define PCIE_RX_REG2			0x0054
+#define RX_RTERM_SEL			BIT(5)
+
+#define PCIE_LTSSM_DIS_ENTRY		0x005c
+#define CFG_REFCLK_MODE			GENMASK(9, 8)
+#define RFCLK_MODE_DRIVER		0x1
+#define RFCLK_MODE_RECEIVER		0x2
+#define OVRD_REFCLK_MODE		BIT(10)
+
+#define PCIE_TX_REG1			0x0064
+#define TX_RTERM_REG			GENMASK(15, 12)
+#define TX_RTERM_SEL			BIT(25)
+
+/* PHY calibration values */
+#define PCIE_RCAL_RESULT		0x0084
+#define RTERM_VALUE_RX			GENMASK(3, 0)
+#define RTERM_VALUE_TX			GENMASK(7, 4)
+#define R_TUNE_DONE			BIT(10)
+
+/* PMU register offsets (shared APMU space) */
+#define PMUA_USB_PHY_CTRL0		0x0110
+#define COMBO_PHY_SEL			BIT(3)	/* 0: PCIe; 1: USB 3 */
+#define PCIE_CLK_RES_CTRL		0x03cc
+#define PCIE_APP_HOLD_PHY_RST		BIT(30)
+#define DEVICE_TYPE_RC			BIT(31)
+#define GLOBAL_PHY_RST			BIT(8)
+
+#define APMU_CLK_GATE_MASK		0x3f
+
+#define CALIBRATION_TIMEOUT_US		500000
+#define PLL_TIMEOUT_US			500000
+
+/* Global calibration value shared across PHY ports */
+static u32 k1_phy_rterm = ~0;
+
+struct k1_pcie_phy {
+	void __iomem *regs;
+	void __iomem *apmu_base;	/* only for combo PHY */
+	u32 pcie_lanes;
+	bool is_combo;
+	struct clk_bulk clks;
+	struct reset_ctl_bulk rst;
+};
+
+static bool k1_phy_rterm_valid(void)
+{
+	return !(k1_phy_rterm & ~(RTERM_VALUE_RX | RTERM_VALUE_TX));
+}
+
+u32 k1_phy_rterm_rx(void)
+{
+	return FIELD_GET(RTERM_VALUE_RX, k1_phy_rterm);
+}
+
+u32 k1_phy_rterm_tx(void)
+{
+	return FIELD_GET(RTERM_VALUE_TX, k1_phy_rterm);
+}
+
+static void k1_phy_rterm_set(u32 val)
+{
+	k1_phy_rterm = val & (RTERM_VALUE_RX | RTERM_VALUE_TX);
+}
+
+static void k1_combo_phy_sel(struct k1_pcie_phy *k1_phy, bool usb)
+{
+	void __iomem *pmu = k1_phy->apmu_base;
+	u32 val;
+
+	val = readl(pmu + PMUA_USB_PHY_CTRL0);
+	if (usb)
+		val |= COMBO_PHY_SEL;
+	else
+		val &= ~COMBO_PHY_SEL;
+	writel(val, pmu + PMUA_USB_PHY_CTRL0);
+}
+
+int k1_pcie_combo_phy_calibrate(struct udevice *dev, struct k1_pcie_phy *k1_phy)
+{
+	void __iomem *regs = k1_phy->regs;
+	int ret = 0;
+	u32 val;
+
+	if (k1_phy_rterm_valid())
+		return 0;
+
+	/*
+	 * Initialize the APMU control register: set RC mode, enable
+	 * clock gates (bits 0-5), deassert PHY global reset, then
+	 * release the PHY hold.  Without this the PHY registers are
+	 * not accessible and reads will hang.
+	 */
+	val = readl(k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
+	val |= DEVICE_TYPE_RC | PCIE_APP_HOLD_PHY_RST | APMU_CLK_GATE_MASK;
+	val &= ~GLOBAL_PHY_RST;
+	writel(val, k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
+	val &= ~PCIE_APP_HOLD_PHY_RST;
+	writel(val, k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
+
+	/* Put the combo PHY into PCIe mode for calibration */
+	k1_combo_phy_sel(k1_phy, false);
+
+	/* Set refclk override + clear CFG_REFCLK_MODE */
+	val = readl(regs + PCIE_LTSSM_DIS_ENTRY);
+	val |= OVRD_REFCLK_MODE;
+	writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
+
+	val = readl(regs + PCIE_LTSSM_DIS_ENTRY);
+	val &= ~CFG_REFCLK_MODE;
+	writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
+
+	val = readl(regs + PCIE_LTSSM_DIS_ENTRY);
+	val |= FIELD_PREP(CFG_REFCLK_MODE, RFCLK_MODE_DRIVER);
+	writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
+
+	/* Configure PLL: select 24MHz reference, enable 100MHz output */
+	val = readl(regs + PCIE_PU_PLL_1);
+	val &= ~(FREF_SEL | REF_100_WSSC);
+	writel(val, regs + PCIE_PU_PLL_1);
+
+	val = readl(regs + PCIE_PU_PLL_1);
+	val |= FIELD_PREP(FREF_SEL, FREF_24M);
+	writel(val, regs + PCIE_PU_PLL_1);
+
+	val = readl(regs + PCIE_PU_PLL_2);
+	val |= GEN_REF100;
+	writel(val, regs + PCIE_PU_PLL_2);
+
+	val = readl(regs + PCIE_PU_PLL_1);
+	val &= ~SSC_DEP_SEL;
+	writel(val, regs + PCIE_PU_PLL_1);
+
+	/* Start PHY init + force receiver */
+	writel(0x00000B78, regs + PCIE_PU_ADDR_CLK_CFG);
+	writel(CFG_FORCE_RCV_RETRY, regs + PCIE_RC_DONE_STATUS);
+
+	/* Wait for calibration to complete */
+	ret = readl_poll_sleep_timeout(regs + PCIE_RCAL_RESULT,
+				       val, val & R_TUNE_DONE,
+				       500, CALIBRATION_TIMEOUT_US);
+	if (ret)
+		dev_err(dev, "PHY calib timeout, RCAL=0x%08x\n", val);
+
+	if (!ret)
+		k1_phy_rterm_set(val);
+
+	return ret;
+}
+
+static int k1_pcie_phy_init(struct phy *phy)
+{
+	struct k1_pcie_phy *k1_phy = dev_get_priv(phy->dev);
+	void __iomem *regs = k1_phy->regs;
+	int ret;
+	u32 val;
+	int i, lane;
+
+	/* If combo PHY is configured for USB 3 mode */
+	if (k1_phy->is_combo && phy->id == PHY_TYPE_USB3) {
+		k1_combo_phy_sel(k1_phy, true);
+		return 0;
+	}
+
+	/* For combo PHY, ensure it's in PCIe mode */
+	if (k1_phy->is_combo)
+		k1_combo_phy_sel(k1_phy, false);
+
+	dev_dbg(phy->dev, "init: combo=%d lanes=%u rterm=0x%02x\n",
+		k1_phy->is_combo, k1_phy->pcie_lanes, k1_phy_rterm);
+
+	lane = (k1_phy->pcie_lanes == 1) ? 1 : 2;
+
+	/* Apply rterm calibration value: LSB to RX_REG1 */
+	for (i = 0; i < lane; i++) {
+		val = readl(regs + PCIE_RX_REG1 + PHY_LANE_OFFSET * i);
+		val |= FIELD_PREP(AFE_RTERM_REG, k1_phy_rterm_rx());
+		writel(val, regs + PCIE_RX_REG1 + PHY_LANE_OFFSET * i);
+	}
+
+	/* Disable RX_RTERM_SEL for all lanes */
+	for (i = 0; i < lane; i++) {
+		val = readl(regs + PCIE_RX_REG2 + PHY_LANE_OFFSET * i);
+		val &= ~RX_RTERM_SEL;
+		writel(val, regs + PCIE_RX_REG2 + PHY_LANE_OFFSET * i);
+	}
+
+	/* Apply rterm MSB to TX_REG1 */
+	for (i = 0; i < lane; i++) {
+		val = readl(regs + PCIE_TX_REG1 + PHY_LANE_OFFSET * i);
+		val |= FIELD_PREP(TX_RTERM_REG, k1_phy_rterm_tx());
+		writel(val, regs + PCIE_TX_REG1 + PHY_LANE_OFFSET * i);
+	}
+
+	/* Enable TX_RTERM_SEL for all lanes */
+	for (i = 0; i < lane; i++) {
+		val = readl(regs + PCIE_TX_REG1 + PHY_LANE_OFFSET * i);
+		val |= TX_RTERM_SEL;
+		writel(val, regs + PCIE_TX_REG1 + PHY_LANE_OFFSET * i);
+	}
+
+	/* Set CLKSEL_24M on lane0 */
+	val = readl(regs + PCIE_RC_CAL_REG2);
+	val |= FIELD_PREP(CLKSEL, CLKSEL_24M);
+	writel(val, regs + PCIE_RC_CAL_REG2);
+
+	/* Toggle RC_CAL_TOGGLE for all lanes */
+	for (i = 0; i < lane; i++) {
+		val = readl(regs + PCIE_RC_CAL_REG2 + PHY_LANE_OFFSET * i);
+		val &= ~RC_CAL_TOGGLE;
+		writel(val, regs + PCIE_RC_CAL_REG2 + PHY_LANE_OFFSET * i);
+	}
+	for (i = 0; i < lane; i++) {
+		val = readl(regs + PCIE_RC_CAL_REG2 + PHY_LANE_OFFSET * i);
+		val |= RC_CAL_TOGGLE;
+		writel(val, regs + PCIE_RC_CAL_REG2 + PHY_LANE_OFFSET * i);
+	}
+
+	/* Configure refclk as driver mode, override */
+	val = readl(regs + PCIE_LTSSM_DIS_ENTRY);
+	val |= OVRD_REFCLK_MODE;
+	writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
+
+	val = readl(regs + PCIE_LTSSM_DIS_ENTRY);
+	val &= ~CFG_REFCLK_MODE;
+	writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
+
+	val = readl(regs + PHY_LANE_OFFSET + PCIE_LTSSM_DIS_ENTRY);
+	val |= OVRD_REFCLK_MODE;
+	writel(val, regs + PHY_LANE_OFFSET + PCIE_LTSSM_DIS_ENTRY);
+
+	val = readl(regs + PHY_LANE_OFFSET + PCIE_LTSSM_DIS_ENTRY);
+	val &= ~CFG_REFCLK_MODE;
+	writel(val, regs + PHY_LANE_OFFSET + PCIE_LTSSM_DIS_ENTRY);
+
+	/* Set driver mode for both lanes */
+	val = readl(regs + PCIE_LTSSM_DIS_ENTRY);
+	val |= FIELD_PREP(CFG_REFCLK_MODE, RFCLK_MODE_DRIVER);
+	writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
+
+	val = readl(regs + PHY_LANE_OFFSET + PCIE_LTSSM_DIS_ENTRY);
+	val |= FIELD_PREP(CFG_REFCLK_MODE, RFCLK_MODE_DRIVER);
+	writel(val, regs + PHY_LANE_OFFSET + PCIE_LTSSM_DIS_ENTRY);
+
+	/* Configure PLL: select 24MHz reference */
+	val = readl(regs + PCIE_PU_PLL_1);
+	val &= ~FREF_SEL;
+	writel(val, regs + PCIE_PU_PLL_1);
+
+	val = readl(regs + PCIE_PU_PLL_1);
+	val |= FIELD_PREP(FREF_SEL, FREF_24M);
+	writel(val, regs + PCIE_PU_PLL_1);
+
+	/* Enable 100MHz reference output */
+	val = readl(regs + PCIE_PU_PLL_2);
+	val |= GEN_REF100;
+	writel(val, regs + PCIE_PU_PLL_2);
+
+	/* Disable SSC */
+	val = readl(regs + PCIE_PU_PLL_1);
+	val &= ~SSC_DEP_SEL;
+	writel(val, regs + PCIE_PU_PLL_1);
+
+	/* Set PU_ADDR_CLK_CFG for both lanes */
+	val = 0x00000B78;
+	writel(val, regs + PCIE_PU_ADDR_CLK_CFG);
+	writel(val, regs + PHY_LANE_OFFSET + PCIE_PU_ADDR_CLK_CFG);
+
+	/* Force receiver done */
+	val = CFG_FORCE_RCV_RETRY;
+	writel(val, regs + PCIE_RC_DONE_STATUS);
+
+	/* Wait for PLL lock */
+	ret = readl_poll_timeout(regs + PCIE_PU_ADDR_CLK_CFG, val,
+				 val & PLL_READY, PLL_TIMEOUT_US);
+	if (ret) {
+		dev_err(phy->dev, "PLL lock timeout! reg[0x08]=0x%08x\n", val);
+		return ret;
+	}
+
+	dev_dbg(phy->dev, "PLL locked (combo=%d, lanes=%d)\n",
+		k1_phy->is_combo, k1_phy->pcie_lanes);
+
+	return 0;
+}
+
+static int k1_pcie_phy_exit(struct phy *phy)
+{
+	return 0;
+}
+
+static int k1_pcie_phy_of_xlate(struct phy *phy,
+				struct ofnode_phandle_args *args)
+{
+	struct k1_pcie_phy *k1_phy = dev_get_priv(phy->dev);
+
+	if (k1_phy->is_combo) {
+		if (args->args_count != 1)
+			return -EINVAL;
+		if (args->args[0] != PHY_TYPE_PCIE &&
+		    args->args[0] != PHY_TYPE_USB3)
+			return -EINVAL;
+	}
+
+	if (args->args_count > 0)
+		phy->id = args->args[0];
+	else
+		phy->id = 0;
+
+	return 0;
+}
+
+static const struct phy_ops k1_pcie_phy_ops = {
+	.of_xlate	= k1_pcie_phy_of_xlate,
+	.init		= k1_pcie_phy_init,
+	.exit		= k1_pcie_phy_exit,
+};
+
+static int k1_pcie_phy_probe(struct udevice *dev)
+{
+	struct k1_pcie_phy *k1_phy = dev_get_priv(dev);
+	struct ofnode_phandle_args apmu_args;
+	bool is_combo;
+	int ret;
+	u32 lanes;
+
+	is_combo = (bool)dev_get_driver_data(dev);
+	k1_phy->is_combo = is_combo;
+
+	k1_phy->regs = dev_read_addr_ptr(dev);
+	if (!k1_phy->regs)
+		return -EINVAL;
+
+	/* Determine number of lanes */
+	if (is_combo) {
+		lanes = 1;
+	} else {
+		u32 count = 0;
+
+		ret = dev_read_u32(dev, "num-lanes", &count);
+		if (ret == 0 && count == 1)
+			lanes = 1;
+		else
+			lanes = 2;
+	}
+	k1_phy->pcie_lanes = lanes;
+
+	/* Get APMU base for combo PHY (for mode select + calibration) */
+	if (is_combo) {
+		ret = dev_read_phandle_with_args(dev, "spacemit,apmu",
+						 NULL, 0, 0,
+						 &apmu_args);
+		if (ret)
+			return ret;
+
+		k1_phy->apmu_base = (void __iomem *)ofnode_get_addr(apmu_args.node);
+		if (!k1_phy->apmu_base)
+			return -EINVAL;
+
+		ret = clk_get_bulk(dev, &k1_phy->clks);
+		if (ret)
+			dev_warn(dev, "failed to get clocks: %d\n", ret);
+
+		ret = reset_get_bulk(dev, &k1_phy->rst);
+		if (ret)
+			dev_warn(dev, "failed to get resets: %d\n", ret);
+
+		ret = k1_pcie_combo_phy_calibrate(dev, k1_phy);
+		if (ret)
+			dev_warn(dev, "calibration failed: %d\n", ret);
+	} else {
+		/*
+		 * PCIe-only PHYs need the calibration value from the
+		 * combo PHY.  In device-tree order the combo PHY probes
+		 * first, but handle the case where it hasn't yet by
+		 * explicitly looking it up.
+		 */
+		if (!k1_phy_rterm_valid()) {
+			struct udevice *combo_dev;
+
+			ret = uclass_first_device_drvdata(UCLASS_PHY, 1UL,
+							  &combo_dev);
+			if (ret)
+				dev_warn(dev,
+					 "failed to probe combo PHY: %d\n",
+					 ret);
+		}
+
+		if (!k1_phy_rterm_valid()) {
+			dev_err(dev,
+				"calibration value not available; "
+				"is the combo PHY enabled?\n");
+			return -ENOENT;
+		}
+
+		ret = clk_get_bulk(dev, &k1_phy->clks);
+		if (ret)
+			dev_warn(dev, "failed to get clocks: %d\n", ret);
+
+		ret = reset_get_bulk(dev, &k1_phy->rst);
+		if (ret)
+			dev_warn(dev, "failed to get resets: %d\n", ret);
+	}
+
+	dev_dbg(dev, "probed (combo=%d lanes=%u rterm=0x%02x)\n",
+		is_combo, lanes, k1_phy_rterm);
+
+	return 0;
+}
+
+static const struct udevice_id k1_pcie_phy_ids[] = {
+	{ .compatible = "spacemit,k1-combo-phy", .data = 1UL },
+	{ .compatible = "spacemit,k1-pcie-phy", .data = 0UL },
+	{ }
+};
+
+U_BOOT_DRIVER(k1_pcie_phy) = {
+	.name		= "k1_pcie_phy",
+	.id		= UCLASS_PHY,
+	.of_match	= k1_pcie_phy_ids,
+	.ops		= &k1_pcie_phy_ops,
+	.probe		= k1_pcie_phy_probe,
+	.priv_auto	= sizeof(struct k1_pcie_phy),
+};

-- 
2.51.0

