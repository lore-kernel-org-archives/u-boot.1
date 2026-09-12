Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C9DC79FB6
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED79160658;
	Sat, 12 Sep 2026 12:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWMg5iH0sJOP; Sat, 12 Sep 2026 12:37:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 791A760634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216642;
	b=mJewfJu8szdg4usl54XjK/W5ASCEBMWG7zwIwwNAKplbkQ0kmTl6ssTjaNM93H1pJ9Sj
	 mU+oQNH6XsNdWzaZlmwrpVWZbWQeoxJYGDxpx0CeiQSZEiBZQ4f9UGFft1iHyWR6VjSen
	 d3q48xHwjsK6nQ11yP0yxLhM8suohXxtruS+wFS9CqUpAV1PklRKQsZVhtApveHzy8kM0
	 5TlF23PAxc0/lmTsGu8I42zUWhV7ZXRDr1Mk0kJrwCi9qNZ+o3QkpFszuoF1wi7MwxVeS
	 JCYYifp4DNBFlaWwmlNcrWNO3FjWrgKpDMZIRWIAgLhWa3r+eenkenVbnmLvcflRQfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UKUj60KZ0gvPVXNe8BJnyqMODtlow+vPJftZxMTslJs=;
	b=PoXfgfB0fKbvRgvjYS82AS+zHEUNTjL67ehYCdt7CHJa2PxovwpGOb440wMQS4ovc782
	 G6sxt3lVySGHMHIj8PCYkD/ZtNbjEcz15ZiXaLGF8HtgBjaEINF4zVKPmDKC0CemD03fW
	 JvQdR0t2iDUK+KzYaso/A7ST2MygKdo52y0CVsQSfuFg8cBdvZReo0AANEkYOHilbxkRj
	 /HteLPNL9wC/kKzPl3+Rix+YatxWzUleQ8cTLRtNIF7sAivxbYzS+0DwCY0Dm/Bwk7ed5
	 MJySpothEE0B2Z/XC64DzTpnUOtXfYILgm0KRKQd+B25ZvqLBEAIJ3cN9HohSCKZUTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216642;
	bh=UKUj60KZ0gvPVXNe8BJnyqMODtlow+vPJftZxMTslJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I4G7JXxNTHTpIyrpIKrXwyq+KnQLJsJrC3K1iBz8ivyi+cuLkCLdGaYDyhdVyex+7
	 cNuGfsztM9tWYdTgvfAZE7ET18VyWSFQggkt53a3qXGrSQJteDvCpLqmwjA9EhDj1l
	 I5MJiyHmK4xChMGFZztABvuswCBm66/KabEKzuQTjDsz8vHA4+97I+lrzbO/spaCr9
	 Fyk9GOoeumhPyZd/oECTCwl8JE1yoy5IE8KfZFPagepb4f0dAY4PON0AEX7eXVmKSU
	 BQ88c+Jk2dMjgaCqcQwkiMDjoxltWoWLKJucM/Z+9n5ZNPnXyWJFjB0tuBqyt+LpP2
	 AnkWCr8e6R81A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 791A760634;
	Sat, 12 Sep 2026 12:37:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9176D23F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7762880E70
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oiu_0He2o6BV for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9F37080E6F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216639;
 b=Q3nZCjE/QRbmzUDE6TF5u89UG4GCzMGjwmP1zk17PJdhdsuMMHU2BESGDFdkPRAmwrLO
 n+NaRFZdyRO1+5jLQ0aY6lYkNpPonE/cSkTCtmZ0jGSZoE0bcrN8XDbWtTzExeG7Hi7+i
 x9WOta5pVOpo3zUeAUyOglnzV4bst9eYQSWCP6hUhh00qR86K0rop06WMXBAfnVnXXAr7
 MlZpxMmjkIEd4ky4O1yWWbB9m/YZIdrP1pnl2MdONcvf7nWa7nyQIzTSEfFimbHrj6xIf
 GkB/A8axJZyBNNytTgbfZTljjjMIBGwsIms3WLcOfNtPrOid+1gg5CD0D66HDRFTe3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216639;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=UKUj60KZ0gvPVXNe8BJnyqMODtlow+vPJftZxMTslJs=;
 b=he9vcrwACIXrnTqBcKFqM/MrNs4iAUg2AGZnIAGs43xEASd5RkuGZc55GtpYOBJBvi1l
 IHuiYn9HpZuZ1nJCqNTZwUcJ2gStFuk4uaQ8URfcjob5OOyzco1UxGWC0gtAn52SnH3zJ
 5GabZVlqF6ZcnUjpUK32BEM5AABecHEOTj4QBNTyRgru/yj7UgsyLesw6jzQfngAaL9j2
 t0AAw2IkkmJYUpS6mmdYNTl6Ib2xbsgYmVgcCpvrtxleXUZG+rxDRdiMNeNWYZyRlgFk+
 0tIhD1LZmuzq5xHF1Y8SNfoYtxKKovVyS6rArdkwDxqbcPMocURa/IbEVfNQTcVkf+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=BNy1BRp4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=BNy1BRp4
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F37080E6F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:18 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc4dbcf2b85so298303a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789216638; x=1789821438;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UKUj60KZ0gvPVXNe8BJnyqMODtlow+vPJftZxMTslJs=;
 b=BNy1BRp4DK5N1PN6L70MDwDzytvE5VAROh0GAYC5wvlDBGZJWcBLN1fmfZOo3U26Qx
 0uKk1jIAPbauqCtP27MpRjU+iwo5BKuw2vGVb++y562f12vUqZl4POb4PyOebU5h158f
 BeqVaJDA5f7OvkR5pZkv4m+Lb7uAi8H96TmS8Jab6dR8sw3pk5pFKHaZmSxNTUI2keT+
 ac7Dw5wW959gJOZkLRu0pTyRmpVBNUjSQQ6xiPuZCx+TxtyGrgSscbqkEhmOi63mj7bJ
 7GNuADqoo9f7bt0DISqlCV8TCwxN8A5I+g8HInt73tqQ4NLPiOGUC1oyZrK+F4kR8vJK
 PzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216638; x=1789821438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UKUj60KZ0gvPVXNe8BJnyqMODtlow+vPJftZxMTslJs=;
 b=qWYiEUlJ3QBv+q3oFuX2zf6Px81cYxMAxK34ySZ+s3tFOcNBh3EfssURNlHAD4lg4W
 9f4cXsCT8aBfoPX+iVUKPEk614DwVJIVIijf/WdW4iHa0Adp9fWuzG3t/ZaGjMhKeRql
 CrucbiGzTE4mzJPG/UHwlZ65NmVKFuMtMwBAOt/o+hCm1zsv02ZG6eUWL4pe+5q6QyPV
 At7NmN1sl+84uG7mt1cFnIPOmYwEIDG9SPP7DrvwTbzcBpdZV9TZ94V+blaY3jVKU/WO
 eK66r8SjbDnyYHm4tiIsAstoM52AQ2luuXT7dSaSA28LkLf6TvdV2vivXYAlvd4/lrho
 bfTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKV6r2XGIrBhRqBP/XOfaOrJWSHRk6DuVLrzvX15eGbhjbbI0Egshz74Nc0vvf/vGgrIAXIYs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mWIsWaOzVUnFYXCIDDT9jkzSoBnHfdWY1L9KLvdDSdkzHfi8E4
 SNAo9e4WuRhhfk0LrlQyHapJg/EHsserJxkfmXRMauLHiA9LVzhtqO+0f6a3d3VFXsM=
X-Gm-Gg: AYBFou0yWnuUrkvo7+ZaC6vFOhO93K006UHoT5MbO+i3Ysv32GDesHFPrabtMhDEShP
 Ads17hTx0hl7T+uMD0sdGD1PDOU0F/jaIma06OiNFJe1iku7QDFsALxJx0uilg58MOisx6Q4FdQ
 cbH2gZCKDrSAg3897f5Xq6IpN/+Yhx9HHUxkdBDZQisphFaarw6f4qctG16KUetB2GOvjBHBo0P
 ngMWTNp3NyEx/iBjpN8n1Zpk35aaUbmIt0E24C4hbzUOcyMHU7CDp+dMMachJJcugZ0zQySbvDE
 /qwee6XJxFNVRdtL0uKUQ1l5Hxs5RSHFRvJSdnr2eV52hi3tvAAVLPGQkqya9EcvskxLCThsuFN
 VlTEbJhc/mTJi5o79f0W7/qC8dRDJSYfG7H/OrShiE0IFcepJNIy26t6hDVfkt5qC4FI7n6ksf0
 qDirxT1lMRBPV54xRVpsVIIFhanvt4ntFWj2Z2FWBh5fToOm2T7ZSHHl+2gcL4TsIiCPT70fQUv
 25JQoqhvkWq/vvh84cXCJoPYY2N2O8sAJyTfqFdnPQIZB2/bmAub8hYsqFCe8UwbgHzEjvMQD2I
 XSLxVLOaFfnbD8arIB4ZEp37ErxI3cGgyxI+
X-Received: by 2002:a05:6a20:a123:b0:3da:b089:dbaa with SMTP id
 adf61e73a8af0-3daed46af97mr16094996637.6.1789216637489; 
 Sat, 12 Sep 2026 05:37:17 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13288737c88.13.2026.09.12.05.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:37:16 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 12 Sep 2026 20:36:55 +0800
Subject: [PATCH v13 2/7] mmc: k1: add sdhci platform driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-m4-v13-2-71043b29630f@riscstar.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
In-Reply-To: <20260912-m4-v13-0-71043b29630f@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>, 
 Johan Jonker <jbx6244@gmail.com>
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

Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
implements the necessary platform-specific operations for the SDHCI
controller, enabling MMC/SD card functionality on K1-based platforms.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v13:
- Sync definition values from upstream mmc driver.
v9:
- Disable CMD18 (multiple-block read) for SD cards in SPL.
v6:
- Remove ".data = 0" in spacemit_sdhci_ids[].
v5:
- Remove MMC_CAP_CMD23 as the CMD23 support is now a separate series.
- Use tabs for macro definition alignment.
- Use read_poll_timeout().
- Set pinctrl state based on selected timing mode.
- Add the definition of SDHC_DLL_REG1_HS400_VAL.
- Remove the condition based on quirks.
v4:
- Add bulk release operations on reset and clock.
v3:
- Enable CMD23 in capability.
v2:
- Enable ADMA mode support.
- Use CMD23 for multi-block read/write.
- Move ASR/AIB register into pinctrl driver.
- Correct pinctrl state from "fast" to "uhs".
- Migrate tuning support from the spacemit linux driver.
---
 drivers/mmc/Kconfig          |   7 +
 drivers/mmc/Makefile         |   1 +
 drivers/mmc/spacemit_sdhci.c | 684 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 692 insertions(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 4ee56465c0fe..f3443cc9bed8 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -729,6 +729,13 @@ config MMC_SDHCI_SNPS
 
 	  If unsure, say N.
 
+config MMC_SDHCI_SPACEMIT
+	bool "Spacemit SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  Support for Secure Digital Host Controller Interface (SDHCI) on
+	  Spacemit K1 SoC.
+
 config MMC_SDHCI_STI
 	bool "SDHCI support for STMicroelectronics SoC"
 	depends on MMC_SDHCI && OF_CONTROL && ARCH_STI
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index f4a40ee10d5b..5130b46f29c0 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_ADI)		+= adi_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_SNPS)		+= snps_sdhci.o
+obj-$(CONFIG_MMC_SDHCI_SPACEMIT)	+= spacemit_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_TANGIER)		+= tangier_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= tegra_mmc.o
diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
new file mode 100644
index 000000000000..f5578f38bdd1
--- /dev/null
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Spacemit K1 Mobile Storage Host Controller
+ *
+ * Copyright (C) 2023-2026 Spacemit Inc.
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#define LOG_CATEGORY UCLASS_MMC
+
+#include <clk.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include <log.h>
+#include <malloc.h>
+#include <sdhci.h>
+#include <reset-uclass.h>
+#include <mapmem.h>
+#include <dm/pinctrl.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <linux/libfdt.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+/* SDH register definitions */
+#define SPACEMIT_SDHC_OP_EXT_REG	0x108
+#define  SDHC_OVRRD_CLK_OEN		BIT(11)
+#define  SDHC_FORCE_CLK_ON		BIT(12)
+
+#define SPACEMIT_SDHC_LEGACY_CTRL_REG	0x10C
+#define  SDHC_GEN_PAD_CLK_ON		BIT(6)
+
+#define SPACEMIT_SDHC_MMC_CTRL_REG	0x114
+#define  SDHC_MISC_INT_EN		BIT(1)
+#define  SDHC_MISC_INT			BIT(2)
+#define  SDHC_ENHANCE_STROBE_EN		BIT(8)
+#define  SDHC_MMC_HS400			BIT(9)
+#define  SDHC_MMC_HS200			BIT(10)
+#define  SDHC_MMC_CARD_MODE		BIT(12)
+
+#define SPACEMIT_SDHC_TX_CFG_REG	0x11C
+#define  SDHC_TX_INT_CLK_SEL		BIT(30)
+#define  SDHC_TX_MUX_SEL		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_CTRL_REG	0x160
+#define  SDHC_PHY_FUNC_EN		BIT(0)
+#define  SDHC_PHY_PLL_LOCK		BIT(1)
+#define  SDHC_HOST_LEGACY_MODE		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_FUNC_REG	0x164
+#define  SDHC_PHY_TEST_EN		BIT(7)
+#define  SDHC_HS200_USE_RFIFO		BIT(15)
+
+#define SPACEMIT_SDHC_PHY_DLLCFG	0x168
+#define  SDHC_DLL_PREDLY_NUM		GENMASK(3, 2)
+#define  SDHC_DLL_FULLDLY_RANGE		GENMASK(5, 4)
+#define  SDHC_DLL_VREG_CTRL		GENMASK(7, 6)
+#define  SDHC_DLL_ENABLE		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_DLLCFG1	0x16C
+#define  SDHC_DLL_REG1_CTRL		GENMASK(7, 0)
+#define  SDHC_DLL_REG2_CTRL		GENMASK(15, 8)
+#define  SDHC_DLL_REG3_CTRL		GENMASK(23, 16)
+#define  SDHC_DLL_REG4_CTRL		GENMASK(31, 24)
+#define  SDHC_DLL_REG1_HS400_VAL	0x92
+
+#define SPACEMIT_SDHC_PHY_DLLSTS	0x170
+#define  SDHC_DLL_LOCK_STATE		BIT(0)
+
+#define SPACEMIT_SDHC_PHY_PADCFG_REG	0x178
+#define  SDHC_PHY_DRIVE_SEL		GENMASK(2, 0)
+#define  SDHC_RX_BIAS_CTRL		BIT(5)
+
+#define SPACEMIT_SDHC_RX_CFG_REG	0x118
+#define  SDHC_RX_SDCLK_SEL0_MASK	GENMASK(1, 0)
+#define  SDHC_RX_SDCLK_SEL1_MASK	GENMASK(3, 2)
+#define  SDHC_RX_SDCLK_SEL1		FIELD_PREP(SDHC_RX_SDCLK_SEL1_MASK, 1)
+
+#define SPACEMIT_SDHC_DLINE_CTRL_REG	0x130
+#define  SDHC_DLINE_PU			BIT(0)
+#define  SDHC_RX_DLINE_CODE_MASK	GENMASK(23, 16)
+#define  SDHC_TX_DLINE_CODE_MASK	GENMASK(31, 24)
+
+#define SPACEMIT_SDHC_DLINE_CFG_REG	0x134
+#define  SDHC_RX_DLINE_REG_MASK		GENMASK(7, 0)
+#define  SDHC_RX_DLINE_GAIN		BIT(8)
+#define  SDHC_TX_DLINE_REG_MASK		GENMASK(23, 16)
+
+#define SPACEMIT_RX_DLINE_REG		0
+#define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
+#define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
+
+#define SPACEMIT_TX_TUNING_DLINE_REG	0x00
+#define SPACEMIT_TX_TUNING_DELAYCODE	127
+
+struct spacemit_sdhci_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+	struct reset_ctl_bulk resets;
+	struct clk_bulk clks;
+};
+
+struct spacemit_sdhci_priv {
+	struct sdhci_host host;
+};
+
+/* All helper functions will update clr/set while preserve rest bits */
+static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val,
+					  int reg)
+{
+	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
+}
+
+static inline void spacemit_sdhci_clrbits(struct sdhci_host *host, u32 val,
+					  int reg)
+{
+	sdhci_writel(host, sdhci_readl(host, reg) & ~val, reg);
+}
+
+static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr,
+					     u32 set, int reg)
+{
+	u32 val = sdhci_readl(host, reg);
+
+	val = (val & ~clr) | set;
+	sdhci_writel(host, val, reg);
+}
+
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+static void spacemit_sdhci_set_rx_delay(struct sdhci_host *host, u8 delay)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_CODE_MASK,
+				  FIELD_PREP(SDHC_RX_DLINE_CODE_MASK, delay),
+				  SPACEMIT_SDHC_DLINE_CTRL_REG);
+}
+
+static void spacemit_sdhci_set_tx_delay(struct sdhci_host *host, u8 delay)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_CODE_MASK,
+				  FIELD_PREP(SDHC_TX_DLINE_CODE_MASK, delay),
+				  SPACEMIT_SDHC_DLINE_CTRL_REG);
+}
+
+static void spacemit_sdhci_set_tx_dline_reg(struct sdhci_host *host,
+					    u8 dline_reg)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_REG_MASK,
+				  FIELD_PREP(SDHC_TX_DLINE_REG_MASK, dline_reg),
+				  SPACEMIT_SDHC_DLINE_CFG_REG);
+}
+
+static void spacemit_sdhci_tx_tuning_prepare(struct sdhci_host *host)
+{
+	spacemit_sdhci_setbits(host, SDHC_TX_MUX_SEL, SPACEMIT_SDHC_TX_CFG_REG);
+	spacemit_sdhci_setbits(host, SDHC_DLINE_PU,
+			       SPACEMIT_SDHC_DLINE_CTRL_REG);
+	udelay(5);
+}
+
+static void spacemit_sdhci_prepare_tuning(struct sdhci_host *host)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_REG_MASK,
+				  FIELD_PREP(SDHC_RX_DLINE_REG_MASK, SPACEMIT_RX_DLINE_REG),
+				  SPACEMIT_SDHC_DLINE_CFG_REG);
+
+	spacemit_sdhci_setbits(host, SDHC_DLINE_PU,
+			       SPACEMIT_SDHC_DLINE_CTRL_REG);
+	udelay(5);
+
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_SDCLK_SEL1_MASK,
+				  SDHC_RX_SDCLK_SEL1,
+				  SPACEMIT_SDHC_RX_CFG_REG);
+
+	if (host->mmc->selected_mode == MMC_HS_200)
+		spacemit_sdhci_setbits(host, SDHC_HS200_USE_RFIFO,
+				       SPACEMIT_SDHC_PHY_FUNC_REG);
+}
+#endif /* MMC_SUPPORTS_TUNING */
+
+/*
+ * Reference: PMU_SDH0_CLK_RES_CTRL (0x054), SDH0_CLK_SEL=0x0,
+ * SDH0_CLK_DIV=0x1. The default clock source is 204.8 MHz
+ * (pll1_d6_409p6Mhz / 2).
+ *
+ * During start-up, use a 200 kHz frequency.
+ */
+#define SDHC_MIN_CLOCK (200 * 1000)
+
+static void spacemit_sdhci_phy_init(struct udevice *dev,
+				    struct sdhci_host *host)
+{
+	u32 reg = 0;
+
+	if (dev_read_bool(dev, "no-sd") && dev_read_bool(dev, "no-sdio")) {
+		/* MMC card mode */
+		reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+		reg |= SDHC_MMC_CARD_MODE;
+		sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+
+		/* Use PHY functional mode */
+		reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_CTRL_REG);
+		reg |= (SDHC_PHY_FUNC_EN | SDHC_PHY_PLL_LOCK);
+		sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_CTRL_REG);
+
+		reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_PADCFG_REG);
+		reg |= SDHC_RX_BIAS_CTRL;
+		sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_PADCFG_REG);
+	} else {
+		reg = sdhci_readl(host, SPACEMIT_SDHC_TX_CFG_REG);
+		reg |= SDHC_TX_INT_CLK_SEL;
+		sdhci_writel(host, reg, SPACEMIT_SDHC_TX_CFG_REG);
+	}
+
+	reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+	reg &= ~SDHC_ENHANCE_STROBE_EN;
+	sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+}
+
+static int spacemit_sdhci_set_vqmmc_voltage(struct mmc *mmc, int voltage)
+{
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	int ret;
+
+	if (!mmc->vqmmc_supply)
+		return 0;
+
+	ret = regulator_set_value(mmc->vqmmc_supply, voltage);
+	if (ret)
+		return ret;
+	ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
+	if (ret)
+		return ret;
+#endif
+	return 0;
+}
+
+static void spacemit_sdhci_set_voltage(struct sdhci_host *host)
+{
+	if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
+		struct mmc *mmc = host->mmc;
+		u32 ctrl;
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		switch (mmc->signal_voltage) {
+		case MMC_SIGNAL_VOLTAGE_330:
+		case MMC_SIGNAL_VOLTAGE_180: {
+			bool to_180 = mmc->signal_voltage ==
+				      MMC_SIGNAL_VOLTAGE_180;
+			bool ok;
+			int voltage_mv = to_180 ? 1800000 : 3300000;
+
+			if (spacemit_sdhci_set_vqmmc_voltage(mmc, voltage_mv))
+				return;
+			if (!IS_SD(mmc))
+				return;
+			if (to_180)
+				ctrl |= SDHCI_CTRL_VDD_180;
+			else
+				ctrl &= ~SDHCI_CTRL_VDD_180;
+			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+			mdelay(5);
+
+			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			ok = !!(ctrl & SDHCI_CTRL_VDD_180) == to_180;
+			if (ok)
+				return;
+
+			log_err("%d.%dV regulator output not stable\n",
+				voltage_mv / 1000000,
+				(voltage_mv / 100000) % 10);
+			break;
+		}
+		default:
+			/* No signal voltage switch required */
+			return;
+		}
+	}
+}
+
+static void spacemit_sdhci_set_clk_gate(struct sdhci_host *host, int auto_gate)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SPACEMIT_SDHC_OP_EXT_REG);
+	if (auto_gate)
+		reg &= ~(SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON);
+	else
+		reg |= (SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON);
+	sdhci_writel(host, reg, SPACEMIT_SDHC_OP_EXT_REG);
+}
+
+static bool spacemit_sdhci_is_voltage_switch_cmd(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	u32 cmd;
+
+	if (!IS_SD(mmc))
+		return false;
+
+	cmd = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
+	return cmd == SD_CMD_SWITCH_UHS18V &&
+	       mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180;
+}
+
+static int spacemit_sdhci_wait_dat0(struct udevice *dev, int state,
+				    int timeout_us)
+{
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	struct sdhci_host *host = mmc->priv;
+	u32 tmp;
+	int ret;
+
+	ret = read_poll_timeout(sdhci_readl, tmp,
+				!!(tmp & SDHCI_DATA_0_LVL_MASK) == !!state,
+				0, timeout_us, host, SDHCI_PRESENT_STATE);
+	if (ret)
+		return ret;
+
+	if (spacemit_sdhci_is_voltage_switch_cmd(host))
+		spacemit_sdhci_set_clk_gate(host, 1);
+	return 0;
+}
+
+static int spacemit_sdhci_get_b_max(struct udevice *dev, void *dst,
+				    lbaint_t blkcnt)
+{
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+
+	if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
+		return 1;
+	return mmc->cfg->b_max;
+}
+
+static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	u32 reg;
+
+	spacemit_sdhci_set_voltage(host);
+
+	if (spacemit_sdhci_is_voltage_switch_cmd(host))
+		spacemit_sdhci_set_clk_gate(host, 0);
+
+	/*
+	 * Set TX_INT_CLK_SEL to guarantee hold time at default speed,
+	 * HS, SDR12/SDR25/SDR50 modes. See SDHC_TX_CFG_REG (0x11c).
+	 */
+	reg = sdhci_readl(host, SPACEMIT_SDHC_TX_CFG_REG);
+	if (mmc->selected_mode == MMC_LEGACY ||
+	    mmc->selected_mode == MMC_HS ||
+	    mmc->selected_mode == SD_HS ||
+	    mmc->selected_mode == UHS_SDR12 ||
+	    mmc->selected_mode == UHS_SDR25 ||
+	    mmc->selected_mode == UHS_SDR50) {
+		reg |= SDHC_TX_INT_CLK_SEL;
+	} else {
+		reg &= ~SDHC_TX_INT_CLK_SEL;
+	}
+	sdhci_writel(host, reg, SPACEMIT_SDHC_TX_CFG_REG);
+
+	/* Set pinctrl state based on selected timing mode */
+	if (IS_ENABLED(CONFIG_PINCTRL)) {
+		switch (mmc->selected_mode) {
+		case UHS_SDR12:
+		case UHS_SDR25:
+		case UHS_SDR50:
+		case UHS_SDR104:
+			pinctrl_select_state(mmc->dev, "uhs");
+			break;
+		default:
+			pinctrl_select_state(mmc->dev, "default");
+			break;
+		}
+	}
+
+	if (mmc->selected_mode == MMC_HS_200 ||
+	    mmc->selected_mode == MMC_HS_400 ||
+	    mmc->selected_mode == MMC_HS_400_ES) {
+		reg = sdhci_readw(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+		if (mmc->selected_mode == MMC_HS_200)
+			reg |= SDHC_MMC_HS200;
+		else
+			reg |= SDHC_MMC_HS400;
+		sdhci_writew(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+	} else {
+		reg = sdhci_readw(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+		reg &= ~(SDHC_MMC_HS200 | SDHC_MMC_HS400 | SDHC_ENHANCE_STROBE_EN);
+		sdhci_writew(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+	}
+
+	sdhci_set_uhs_timing(host);
+}
+
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+static int spacemit_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct sdhci_host *host = mmc->priv;
+	int current_len = 0, current_start = 0;
+	int max_pass_len = 0, max_pass_start = 0;
+	u8 final_delay;
+	int ret = 0;
+	int i;
+
+	/*
+	 * Tuning is required for SDR50/SDR104, HS200/HS400 cards and
+	 * if clock frequency is greater than 100MHz in these modes.
+	 */
+	if (host->clock < 100 * 1000 * 1000 ||
+	    !(mmc->selected_mode == MMC_HS_200 ||
+	      mmc->selected_mode == UHS_SDR50 ||
+	      mmc->selected_mode == UHS_SDR104))
+		return 0;
+
+	if (IS_SD(host->mmc)) {
+		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
+		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
+		spacemit_sdhci_tx_tuning_prepare(host);
+
+		log_debug("TX tuning: dline_reg=%d, delaycode=%d\n",
+			  SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
+	}
+
+	spacemit_sdhci_prepare_tuning(host);
+
+	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX; i++) {
+		spacemit_sdhci_set_rx_delay(host, i);
+		ret = mmc_send_tuning(host->mmc, opcode);
+
+		log_debug("RX delay %d: %s\n",
+			  i, ret == 0 ? "pass" : "fail");
+
+		if (ret == 0) {
+			/* Test passed - extend current window */
+			if (current_len == 0)
+				current_start = i;
+			current_len++;
+		} else {
+			/* Test failed - check if current window is best so far */
+			if (current_len > max_pass_len) {
+				max_pass_len = current_len;
+				max_pass_start = current_start;
+			}
+			current_len = 0;
+		}
+	}
+
+	if (current_len > max_pass_len) {
+		max_pass_len = current_len;
+		max_pass_start = current_start;
+	}
+
+	if (max_pass_len < 50) {
+		log_err("Tuning failed: no stable window found\n");
+		return -EIO;
+	}
+
+	final_delay = max_pass_start + max_pass_len / 2;
+	spacemit_sdhci_set_rx_delay(host, final_delay);
+	ret = mmc_send_tuning(host->mmc, opcode);
+	if (ret) {
+		u8 retry_delays[] = {
+			max_pass_start + max_pass_len / 4,
+			max_pass_start + (3 * max_pass_len) / 4,
+			max_pass_start,
+			max_pass_start + max_pass_len - 1
+		};
+		int retry_count = ARRAY_SIZE(retry_delays);
+
+		log_warning("Primary delay %d failed, trying alternatives\n",
+			    final_delay);
+
+		for (i = 0; i < retry_count; i++) {
+			if (retry_delays[i] >= SPACEMIT_RX_TUNE_DELAY_MIN &&
+			    retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
+				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
+				ret = mmc_send_tuning(host->mmc, opcode);
+				if (!ret) {
+					final_delay = retry_delays[i];
+					log_info("Retry successful with delay %d\n",
+						 final_delay);
+					break;
+				}
+			}
+		}
+
+		if (ret) {
+			log_err("All retry attempts failed\n");
+			return -EIO;
+		}
+	}
+
+	log_debug("Tuning successful: window %d-%d, using delay %d\n",
+		  max_pass_start, max_pass_start + max_pass_len - 1, final_delay);
+
+	return 0;
+}
+#endif /* MMC_SUPPORTS_TUNING */
+
+#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
+static int spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
+{
+	u32 reg, val;
+	int ret;
+
+	/* Configure DLL predly, fulldly, and vreg */
+	spacemit_sdhci_clrsetbits(host, SDHC_DLL_PREDLY_NUM |
+				  SDHC_DLL_FULLDLY_RANGE |
+				  SDHC_DLL_VREG_CTRL,
+				  FIELD_PREP(SDHC_DLL_PREDLY_NUM, 1) |
+				  FIELD_PREP(SDHC_DLL_FULLDLY_RANGE, 1) |
+				  FIELD_PREP(SDHC_DLL_VREG_CTRL, 1),
+				  SPACEMIT_SDHC_PHY_DLLCFG);
+
+	reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLCFG1);
+	reg |= FIELD_PREP(SDHC_DLL_REG1_CTRL, SDHC_DLL_REG1_HS400_VAL);
+	sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_DLLCFG1);
+
+	/* Enable DLL */
+	reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLCFG);
+	reg |= SDHC_DLL_ENABLE;
+	sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_DLLCFG);
+
+	/* Wait for DLL lock */
+	ret = read_poll_timeout(sdhci_readl, val, val & SDHC_DLL_LOCK_STATE,
+				10, 1000, host, SPACEMIT_SDHC_PHY_DLLSTS);
+	if (ret) {
+		log_err("%s: phy dll lock timeout\n", host->name);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int spacemit_sdhci_hs400_enhanced_strobe(struct sdhci_host *host)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+	reg |= SDHC_ENHANCE_STROBE_EN;
+	sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+
+	return spacemit_sdhci_phy_dll_init(host);
+}
+#endif
+
+const struct sdhci_ops spacemit_sdhci_ops = {
+	.set_control_reg		= spacemit_sdhci_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+	.platform_execute_tuning	= spacemit_sdhci_execute_tuning,
+#endif
+#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
+	.set_enhanced_strobe		= spacemit_sdhci_hs400_enhanced_strobe,
+#endif
+};
+
+static struct dm_mmc_ops spacemit_mmc_ops;
+
+static int spacemit_sdhci_probe(struct udevice *dev)
+{
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
+	struct spacemit_sdhci_priv *priv = dev_get_priv(dev);
+	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
+	struct sdhci_host *host = &priv->host;
+	struct clk clk;
+	int ret = 0;
+
+	host->mmc = &plat->mmc;
+	host->mmc->priv = host;
+	host->mmc->dev = dev;
+	upriv->mmc = host->mmc;
+
+	spacemit_mmc_ops = sdhci_ops;
+	spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
+	spacemit_mmc_ops.get_b_max = spacemit_sdhci_get_b_max;
+
+	ret = clk_get_bulk(dev, &plat->clks);
+	if (ret) {
+		log_err("Can't get clk: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&plat->clks);
+	if (ret) {
+		log_err("Failed to enable clk: %d\n", ret);
+		goto err_clk;
+	}
+
+	ret = reset_get_bulk(dev, &plat->resets);
+	if (ret) {
+		log_err("Can't get reset: %d\n", ret);
+		goto err_clk;
+	}
+
+	ret = reset_deassert_bulk(&plat->resets);
+	if (ret) {
+		log_err("Failed to reset: %d\n", ret);
+		goto err_reset;
+	}
+
+	ret = clk_get_by_index(dev, 1, &clk);
+	if (ret) {
+		log_err("Can't get io clk: %d\n", ret);
+		goto err_reset;
+	}
+
+	ret = clk_set_rate(&clk, plat->cfg.f_max);
+	if (ret) {
+		log_err("Failed to set io clk: %d\n", ret);
+		goto err_reset;
+	}
+
+	/* Set quirks */
+	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD |
+		       SDHCI_QUIRK_32BIT_DMA_ADDR;
+	host->host_caps = MMC_MODE_HS | MMC_MODE_HS_52MHz;
+	host->max_clk = plat->cfg.f_max;
+
+	plat->cfg.f_min = SDHC_MIN_CLOCK;
+	host->ops = &spacemit_sdhci_ops;
+
+	ret = sdhci_setup_cfg(&plat->cfg, host, plat->cfg.f_max,
+			      SDHC_MIN_CLOCK);
+	if (ret)
+		goto err_reset;
+
+	ret = sdhci_probe(dev);
+	if (ret)
+		goto err_reset;
+
+	spacemit_sdhci_phy_init(dev, host);
+	return 0;
+
+err_reset:
+	reset_release_bulk(&plat->resets);
+err_clk:
+	clk_release_bulk(&plat->clks);
+	return ret;
+}
+
+static int spacemit_sdhci_of_to_plat(struct udevice *dev)
+{
+	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
+	struct spacemit_sdhci_priv *priv = dev_get_priv(dev);
+	struct sdhci_host *host = &priv->host;
+	int ret = 0;
+
+	host->name = dev->name;
+	host->ioaddr = (void *)dev_read_addr(dev);
+
+	ret = mmc_of_parse(dev, &plat->cfg);
+
+	return ret;
+}
+
+static int spacemit_sdhci_bind(struct udevice *dev)
+{
+	struct spacemit_sdhci_plat *drv_data;
+	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
+
+	drv_data = (struct spacemit_sdhci_plat *)dev_get_driver_data(dev);
+	if (drv_data)
+		memcpy(plat, drv_data, sizeof(struct spacemit_sdhci_plat));
+	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
+}
+
+static const struct udevice_id spacemit_sdhci_ids[] = {
+	{ .compatible = "spacemit,k1-sdhci" },
+	{ }
+};
+
+U_BOOT_DRIVER(spacemit_sdhci_drv) = {
+	.name		= "spacemit_sdhci",
+	.id		= UCLASS_MMC,
+	.of_match	= spacemit_sdhci_ids,
+	.of_to_plat	= spacemit_sdhci_of_to_plat,
+	.ops		= &spacemit_mmc_ops,
+	.bind		= spacemit_sdhci_bind,
+	.probe		= spacemit_sdhci_probe,
+	.priv_auto	= sizeof(struct spacemit_sdhci_priv),
+	.plat_auto	= sizeof(struct spacemit_sdhci_plat),
+};

-- 
2.51.0

