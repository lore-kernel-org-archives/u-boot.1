Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76944CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44AAE60BD3;
	Fri,  2 Oct 2026 14:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GTHt-ClU-06t; Fri,  2 Oct 2026 14:01:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E45F360894
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949677;
	b=gxXS989VhF60piO39YA/k25kLRkGJ6a6/5861+hLgHgNdKSVuKz7Q0RLzPztRUQ5hfHQ
	 35a/5d3XHGnRhgGF5fyxcpVOs0R0grGxOdkt/sD2HffhpdYmadYB7jJzZ/IKpMC2Of7hn
	 HI5zWd7MsDk83PJLN5UFzKgQPAmj+lCLdxEm14VwLHoj3nRd74L5b3+eTBZGxAaAKI8Vv
	 ahK2Nj+cagk2cphL9r2vUq6V7+VdELwWVs1Rlh3jQiTwTP0JrDlPPsrQ6kHJdZZteHIEc
	 AELy4dM1Z3mMEmQ7yYagOOCA3ZLDR4Kg0cXCrW2GtgLv0sO9D6FZi/5h6kocEt+k8Gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9w0rTM7Wu/fiTQq8ZdXIGVsDq7KNt9CBGWDpugXjIHU=;
	b=cay63QjVactFmY0hcqgH3H5RFAJX1Ifr2pp28S1WuyaD4Y1gSkxj1ep1IYUOl4sH2ShM
	 Fw9mKxzzXiTubCS2vrRAK+S5GBWkvZFE+3f/EaXwijS/yFsnE8leJgeJNvJZh+yYrzY2r
	 WNvXYVoitYmp5KWP7+elHZgNeC6iW+mIxKS48pwsNe9kcI7puCX27h0iw9Vq38ccF03hG
	 vwI8W+AYP0EAjUqLO47exbQuaXneiZplXHnYAZb/rML7DaIySCayo3WXwDsiCRcNlrVUa
	 8YQbbwu1EV4030E349r43/CoDZF6ztIhK27QzOCq1Db/txeli2vi0UdlQ6b0lByL0Xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949677;
	bh=9w0rTM7Wu/fiTQq8ZdXIGVsDq7KNt9CBGWDpugXjIHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vduysfs4GN1WWB6R2jYZ3YlYoTraFPvfmKm73CsECKXdzYWcVzCoAo1FeHwoVtH72
	 ZfYEMQv3IQB4mSK2OT/mFwN64dGgFDFAzxvU33az+rVQRalTsOod+Ae2AytIj+0sw9
	 HlsZnAJipt1KOND23QXDp1eMLsK1hBbOnNxBhVqMwGS/vg7hSFNNZEup19/+/pArLK
	 4LAoGb4uogn4REkP/UgsOClLmJuaKF32hI1UazpZf3Cd8s986Ug4BsQ7YREyQ8Javk
	 dl1sHxh/D8tFXFpgW7MxD+VwK7Iy3Bxt1bwI8Tx28vRLbQUEVi6hg7vnGzfanxv0qy
	 Jhl2sQ2MdUROQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E45F360894;
	Fri,  2 Oct 2026 14:01:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05886263
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF67D40D94
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4V4gIAmL8S8 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F7CE40D87
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949674;
 b=SUjVWqqFoEQJ9guIgoEcvUlpq+GJ3QawFEsyCA84azV52J6MFhvUfz5GmkHSndSzsXg5
 7J5uf2/jDoVgvs6eb7y3n2kWChzcXxjB9TFRj2OqAbinQ3AVUBf6s9/1RMd0MlKzeDkUP
 Efziw8hcCNiWdajYrXvLWD8kXegilZr4jBjbrCgB/1mtqvmNrA14foylrkGSdtZSQurL6
 6+Oe09Mdigkm7vXhAFfP15tdC3h73yq8G7zBtBbLCHRDYCy6kneY9z5Kfzz5bwiZnw5Cn
 luI7eN4bv8ZXMhGQyqZlViP7nBA9xXevpmzuDnWqKmt8yV56rsonoYvd1P3yOWmh7Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949674;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=9w0rTM7Wu/fiTQq8ZdXIGVsDq7KNt9CBGWDpugXjIHU=;
 b=IhgEShgJ9y7rSzJO59o9m0cg0jzq/gafbWIS14Dsmgc9JJvhMnUa46bnn0dA2a/vbVNe
 0olvDyh4wUSF4HESElirAsYM3y6thobmHMPP4lEFyjIF6V9fAMvfShIaEASYNJTKCdw4h
 jkrax1nsbk1meR3GNUhmeIWI2spW7Dalirp87YDlN6cGHnNyyXp9Dmb+kk3tgFgL1KhsK
 kK5XIHaRElzgXQq8rfYjywq2xI455lMG+l1IYg5gbXbrgzBBvv99TfQ8USoF8xgbO0WDY
 kk4c0ffvPZoGCNDfJVDmeomDHLBgv52IjH0T6iwrcANxAyFYnYEgSrQ7tCDuwl5I1JQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gh7yNJi+; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gh7yNJi+
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F7CE40D87
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:12 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a0977b9c20so882235e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949671; x=1791554471;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9w0rTM7Wu/fiTQq8ZdXIGVsDq7KNt9CBGWDpugXjIHU=;
 b=gh7yNJi+EBtowq9XzgMVM1Qo1ABhBj/txKxKIlGrxPpUpjhDOFm7HjDfwAEafpFBAi
 sQKGuW05Iu06O1FWmARjmu6M0Pi6EGDvPnbKft0JRrrjQQlXWLafkbPb0IU5+C+2kDK7
 jEqQ6ju4Yc+c8YU7d8WTAkQlOIjXjK1H6w1v0vXyAZDamju9aAD+gbzVrEeECWcII4K+
 8iTnpzKjnHRXuZuoOrI3nS2+Z+QcDdEhQAmZDXnYtV5cfRkQXLQcL6+yEUEAx97cRBWj
 2uB8m2ueYbTacpKocwXv+I+Q5i1AysR7BbpJQPZ1wAe51lvMJS4RHdLkDi0SXdrrsE0J
 4b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949671; x=1791554471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9w0rTM7Wu/fiTQq8ZdXIGVsDq7KNt9CBGWDpugXjIHU=;
 b=q0KMTYKZlV1zfEaEFF1m6xp2CPyCtzTDcdvZDf7V24GJQamIx7XlWDpbI8aHOyrNSI
 i87mno0a1Kf9sEqNl9+CZr1Ho8Ko7FG+bGHAJTknVuVaSU8QfP2E+ihCcBO3baWsrtU8
 D1PNXBiU5W4/NgV/WOhMZNT9cqJuZ2awGDyP/cK+u0+Xh+VU5kXL4XU93e27H6eqqgwV
 gjls5bhjMNUAFQtEcG1/a3Hu/la+qmJ3kly5z1jeOofUo+zWFLy0N1itapW3CjwkcZBi
 Uw4M0Bl6dmasQAUy/mLbGvFYM1xN0OJh4gE+cV0681uAXAqzPywa4OoZp6rWNf1IFA33
 N23Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByKhHVPrmfnzt10UyVa1TtWqMwmOYzU6F863vINhyVA4WHyOfush2FIp4vtdIW+VSIcROLIGqs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k5+HAJrhqQD2pQxSjmmQfw2Brc2qx2D44raOznmMoNKIrpFTNO
 +MeGi/ma+sMsiq8bdhqZayICBVtXGtn47WfaGQOjKGkXPqmI2DKr3iGNzQZDk5yyMlM=
X-Gm-Gg: AYBFou1eGwnQDqH03LRSZA5ME0mAT4T0GqHdwnZcULt/Ykg16lE8aiAdi58VJrIanwF
 wrgaSnmg5XKYkflW5yky4EtnQexglVii3Fu5TArt4O2uHmGP5K5DwCBBmmQNWPY6dPB6IiRVqeg
 QnQrMinzmcTN2C2HE9F9l034hWkrOy8JpvSNBq6SrU8+Wj9rBR8+lJchzx4Qv4LhWQL4rYF2NpI
 JqR5kcsX+4dKNHLqs8Hkvt5imBFdvlBCFQwLwSTu4HNxR+d0GWZIN3YFFxcOBeSSDSmuch2VIHL
 QVAjxa5LZ+Axt9inlf87F0frfqOcoDKMqVCdZVV9GmZcOdEfCuDmBtQ+jfgWo9PMLkBB3jv4/Gi
 UODZErmJx6H/61+SQLNjPclGksg643Gk5nsTKt2KbsjdY2ImMQKeWrA4oaHxLOI+WkQPE8HLZke
 kBd6bJgvaSHuK1DxIc64f0bSYMR9yvUa2I7ZXtpykEfoJk3yqkUgLk8df0Hk7YQahuIltFm1zBS
 5G4tgFB1tIJGNZ539m9BIRLWhnte8v+qlrKzKIJUIQtdb0N1qSxylELq2Ve+kXCKfHkHi7QbGKR
 Ii0KXhgf5CxkFXbqFpt5nv5qD7qF3g4FxFjOdemBcj73bVZ08XmhClQ=
X-Received: by 2002:a05:600c:4ec6:b0:49d:1cc7:5ec3 with SMTP id
 5b1f17b1804b1-4a02756637cmr53150865e9.9.1790949670108; 
 Fri, 02 Oct 2026 07:01:10 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:09 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:03:52 +0200
Subject: [PATCH v2 01/13] memory: mediatek: mtk-smi: support smi_common and
 the larb ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-1-9e435457b90c@baylibre.com>
References: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
In-Reply-To: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

The DMA masters of a display pipeline reach DRAM through an SMI local
arbiter, and the larbs themselves through the smi_common block behind
them, whose clocks must be ungated as well. Drive it with a second
driver in the same file, found through the "mediatek,smi" phandle of the
larb, and reference count both: several masters share a larb, and
several larbs share an smi_common. A larb whose smi_common has no driver
here, or no node, is not an error: its clocks are already on.

U-Boot has no IOMMU driver, so those masters address DRAM directly: add
a helper switching one larb port to physical addressing, which the
overlay calls once its larb is ungated.

Four compatibles are added:

 - "mediatek,mt8186-smi-larb", the generic fallback the MT8365 larbs
   carry behind their SoC specific string, so a single entry covers
   every SoC reusing that larb generation,
 - "mediatek,mt8366-smi-larb", which the MT8366 larbs carry on their own
   as that SoC is not upstream yet. They are the MT8188 IP, so they
   reuse its data, and with it the secure monitor call taking the larb
   ports out of the IOMMU,
 - "mediatek,mt8365-smi-common" and "mediatek,mt8366-smi-common" for
   the smi_common driver. Neither node declares a generic fallback, so
   both SoC specific strings have to be listed.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/memory/mtk-smi.c | 157 +++++++++++++++++++++++++++++++++++++++++++----
 include/mtk_smi.h        |  20 +++++-
 2 files changed, 161 insertions(+), 16 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 4531d416861..28f026c3ed9 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -1,24 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * MediaTek SMI local arbiter (larb) driver
+ * MediaTek SMI local arbiter (larb) and smi_common driver
  *
  * Copyright (c) 2026 BayLibre, SAS.
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <errno.h>
 #include <linux/arm-smccc.h>
+#include <linux/bitops.h>
 #include <mtk_smi.h>
 
+#define SMI_LARB_NONSEC_CON(port)	(0x380 + 4 * (port))
+#define MMU_EN					BIT(0)
+
 /*
- * On the newer larbs the mmu_en bits of SMI_LARB_NONSEC_CON live in the
- * secure world, where "the mmu_en bits of LARB_NONSEC_CON have no effect",
- * as the Linux driver puts it. Which ports of a larb go through the IOMMU
- * is told to the secure monitor instead; U-Boot sets up no page table, so
- * it asks for none, and the DMA masters use physical addresses.
+ * On the newer larbs the mmu_en bits above live in the secure world, where
+ * "the mmu_en bits of LARB_NONSEC_CON have no effect", as the Linux driver
+ * puts it. Which ports of a larb go through the IOMMU is told to the secure
+ * monitor instead; U-Boot sets up no page table, so it asks for none.
  */
 #define MTK_SIP_SMC_CONVENTION		(IS_ENABLED(CONFIG_ARM64) ? \
 					 ARM_SMCCC_SMC_64 : ARM_SMCCC_SMC_32)
@@ -28,6 +32,24 @@
 							   ARM_SMCCC_OWNER_SIP, 0x514)
 #define IOMMU_ATF_CMD_CONFIG_SMI_LARB	0
 
+/*
+ * The SMI local arbiters gate a multimedia subsystem's access to DRAM. Linux
+ * handles them as part of its SMI/IOMMU framework (its mtk-smi driver);
+ * U-Boot has no such framework, so this minimal driver only ungates the
+ * clocks of a larb and of the smi_common block behind it, on behalf of the
+ * DMA master sitting in front of it.
+ */
+
+/**
+ * struct mtk_smi_common_priv - private data of an smi_common block
+ * @clk_bulk: clocks of the smi_common block
+ * @enable_count: number of larbs that enabled the smi_common block
+ */
+struct mtk_smi_common_priv {
+	struct clk_bulk clk_bulk;
+	unsigned int enable_count;
+};
+
 /**
  * struct mtk_smi_larb_data - per-SoC larb data
  * @port_sec_ctl: the port mmu_en bits are controlled by the secure world
@@ -39,20 +61,20 @@ struct mtk_smi_larb_data {
 /**
  * struct mtk_smi_larb_priv - private data of an SMI larb
  * @clk_bulk: clocks of the larb
+ * @smi_common: smi_common device behind the larb, if handled by this driver
+ * @base: larb register window
  * @data: per-SoC larb data, NULL when there is none
  * @enable_count: number of DMA masters that enabled the larb
- *
- * The SMI local arbiters gate a multimedia subsystem's access to DRAM. Linux
- * handles them as part of its SMI/IOMMU framework (drivers/memory/mtk-smi.c);
- * U-Boot has no such framework, so this minimal driver only ungates the larb
- * clocks on behalf of the DMA master sitting behind it.
  */
 struct mtk_smi_larb_priv {
 	struct clk_bulk clk_bulk;
+	struct udevice *smi_common;
+	void __iomem *base;
 	const struct mtk_smi_larb_data *data;
 	unsigned int enable_count;
 };
 
+/* the MT8366 larbs are the MT8188 IP */
 static const struct mtk_smi_larb_data mt8188_larb_data = {
 	.port_sec_ctl = true,
 };
@@ -81,19 +103,84 @@ static int mtk_smi_larb_bypass_iommu(struct udevice *dev)
 	return 0;
 }
 
+static int mtk_smi_common_enable(struct udevice *dev)
+{
+	struct mtk_smi_common_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* several larbs sit behind one smi_common, only the first ungates it */
+	if (priv->enable_count++)
+		return 0;
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		priv->enable_count = 0;
+	}
+
+	return ret;
+}
+
+static int mtk_smi_common_disable(struct udevice *dev)
+{
+	struct mtk_smi_common_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->enable_count || --priv->enable_count)
+		return 0;
+
+	ret = clk_disable_bulk(&priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+
+	return ret;
+}
+
+static int mtk_smi_common_probe(struct udevice *dev)
+{
+	struct mtk_smi_common_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+
+	return ret;
+}
+
+static const struct udevice_id mtk_smi_common_ids[] = {
+	{ .compatible = "mediatek,mt8365-smi-common" },
+	{ .compatible = "mediatek,mt8366-smi-common" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_smi_common) = {
+	.name	   = "mtk_smi_common",
+	.id	   = UCLASS_MEMORY,
+	.of_match  = mtk_smi_common_ids,
+	.probe	   = mtk_smi_common_probe,
+	.priv_auto = sizeof(struct mtk_smi_common_priv),
+};
+
 int mtk_smi_larb_enable(struct udevice *dev)
 {
 	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	/* several DMA masters can sit behind the same larb */
+	/* one larb feeds several DMA masters, only the first ungates it */
 	if (priv->enable_count++)
 		return 0;
 
+	if (priv->smi_common) {
+		ret = mtk_smi_common_enable(priv->smi_common);
+		if (ret)
+			goto err;
+	}
+
 	ret = clk_enable_bulk(&priv->clk_bulk);
 	if (ret) {
 		dev_err(dev, "failed to enable clocks: %d\n", ret);
-		goto err;
+		goto err_disable_common;
 	}
 
 	/* as in Linux, only talk to the secure monitor once the larb is on */
@@ -107,6 +194,9 @@ int mtk_smi_larb_enable(struct udevice *dev)
 
 err_disable_clks:
 	clk_disable_bulk(&priv->clk_bulk);
+err_disable_common:
+	if (priv->smi_common)
+		mtk_smi_common_disable(priv->smi_common);
 err:
 	priv->enable_count = 0;
 
@@ -128,30 +218,71 @@ int mtk_smi_larb_disable(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "failed to disable clocks: %d\n", ret);
 
+	if (priv->smi_common)
+		mtk_smi_common_disable(priv->smi_common);
+
 	return ret;
 }
 
+void mtk_smi_larb_port_set_pa(struct udevice *dev, unsigned int port)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+
+	clrbits_le32(priv->base + SMI_LARB_NONSEC_CON(port), MMU_EN);
+}
+
 static int mtk_smi_larb_probe(struct udevice *dev)
 {
 	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
 	ret = clk_get_bulk(dev, &priv->clk_bulk);
 	if (ret) {
 		dev_err(dev, "failed to get clocks: %d\n", ret);
 		return ret;
 	}
 
+	/*
+	 * Not every smi_common block is handled by this driver: where it
+	 * isn't, its clocks are already ungated by the time the DMA masters
+	 * run, so having no device for it is not an error.
+	 */
+	ret = uclass_get_device_by_phandle(UCLASS_MEMORY, dev, "mediatek,smi",
+					   &priv->smi_common);
+	if (ret == -ENODEV || ret == -ENOENT) {
+		dev_dbg(dev, "no smi_common device: %d\n", ret);
+		priv->smi_common = NULL;
+	} else if (ret) {
+		dev_err(dev, "failed to get smi_common device: %d\n", ret);
+		return ret;
+	}
+
 	priv->data = (const struct mtk_smi_larb_data *)dev_get_driver_data(dev);
 
 	return 0;
 }
 
+/*
+ * The MT8365 larbs also carry the generic mediatek,mt8186-smi-larb
+ * compatible, which is the one matched here. The MT8366 ones only have
+ * their own, as that SoC is not upstream yet.
+ */
 static const struct udevice_id mtk_smi_larb_ids[] = {
+	{
+		.compatible = "mediatek,mt8186-smi-larb",
+	},
 	{
 		.compatible = "mediatek,mt8188-smi-larb",
 		.data = (ulong)&mt8188_larb_data,
 	},
+	{
+		.compatible = "mediatek,mt8366-smi-larb",
+		.data = (ulong)&mt8188_larb_data,
+	},
 	{ }
 };
 
diff --git a/include/mtk_smi.h b/include/mtk_smi.h
index b0166b37538..d4a22745d5e 100644
--- a/include/mtk_smi.h
+++ b/include/mtk_smi.h
@@ -15,8 +15,11 @@ struct udevice;
  * mtk_smi_larb_enable() - ungate an SMI local arbiter
  * @dev: larb device
  *
- * Enable the clocks of the larb so that the DMA master behind it can reach
- * DRAM. Calls are refcounted, so several masters can share one larb.
+ * Enable the clocks of the smi_common block behind the larb, if any, then
+ * the larb ones, so that the DMA master in front of it can reach DRAM. On
+ * the SoCs where the secure world owns the port mmu_en bits, also ask the
+ * secure monitor to keep every port of the larb out of the IOMMU. Calls
+ * are refcounted, so several masters can share one larb.
  *
  * Return: 0 on success, or a negative error code
  */
@@ -27,11 +30,22 @@ int mtk_smi_larb_enable(struct udevice *dev);
  * @dev: larb device
  *
  * Drop one reference taken by mtk_smi_larb_enable(), and disable the larb
- * clocks when it was the last one.
+ * clocks, then the smi_common ones, when it was the last one.
  *
  * Return: 0 on success, -EINVAL if the larb is not enabled, or another
  * negative error code
  */
 int mtk_smi_larb_disable(struct udevice *dev);
 
+/**
+ * mtk_smi_larb_port_set_pa() - switch a larb port to physical addressing
+ * @dev: larb device
+ * @port: M4U port index within the larb
+ *
+ * Take the port out of the IOMMU, so that it issues physical addresses (PA).
+ * Without an IOMMU driver the DMA masters address DRAM directly, so their
+ * ports must be taken out of the translated address space.
+ */
+void mtk_smi_larb_port_set_pa(struct udevice *dev, unsigned int port);
+
 #endif /* _MTK_SMI_H */

-- 
2.55.0

