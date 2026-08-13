Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C465C5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4593140CEB;
	Thu, 13 Aug 2026 20:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29QMAsUVmItq; Thu, 13 Aug 2026 20:18:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EDF140CFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652287;
	bh=n2jDLRSzkXA7xsuOFzdT1DdArC9NNkhSztcv8H+qzfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ydLh3r2Vd46/WW1tpeFJDZjp83hzvH6Gkf+USbb7WCeUragHtcXCDcaCZc4h0uFjn
	 o296PY0Y0w9dM2XlpCMTJNFsRC7IQ1+MnN6d/2c4T/j3ke2xIVdJyxeO1LLuLTFOUL
	 l7TofKctUBrtMXzGlRf2+/xveIMwD/+4ZpVbBa89AtnngwdbF9nJ4k5dgquXeGMTUh
	 O/0mVFnV3UvXvyxkvteAjlC4yh6J6VCaJzShv8eflOR1QYHtT26aRdyMbvdbD/TRIs
	 EhXpoMbPZ8ZPMYsogrNeyNkNiQrnNWzonf7IR/yjTM3Xi39gRWS0cvA1tf4psjZuWd
	 K9xUiMyZ68zOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EDF140CFB;
	Thu, 13 Aug 2026 20:18:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D7511393
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5369340CCC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nGbxUZk4jWl9 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2085740CB3
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2085740CB3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=M0Do5bIF
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2085740CB3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:40 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7eb34c17b96so236625a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651179; x=1787255979;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n2jDLRSzkXA7xsuOFzdT1DdArC9NNkhSztcv8H+qzfM=;
 b=M0Do5bIFVeW1e9taARQFBL5K0WIJCTWLzFOdn7mA6UTnJwOla5h4hrf8TxQW1rGg7b
 /UrNh+erNWg3oGfYCxIQtEuZYVst7ruoW+DDQAWhaTvzJD7ouPNLaNLWeNsOFyrenkgW
 0jbmz/WhkflIBI7I0YHcRxR/x4r2jgtkjm9/YgJZSxu6CbfReH0UfXv79OQh59VB2QeK
 Z3hzm4vkhldMkODZGxMnrI1nPGimJBaRdBt2niVDwYfTl6/Z5TiIHnaeu8kbUAJkuJIk
 P9LZ+ReNjZWfQ+z+EeSW6QeeSjUcyRcNWhostx8tkHjzxYcv2VTgN50ey4HV6t6Q8Jev
 bbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651179; x=1787255979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n2jDLRSzkXA7xsuOFzdT1DdArC9NNkhSztcv8H+qzfM=;
 b=EZmp2/LBuHRHUsuVRBwI3ZjzVR7c8t3vVbdrNW5iGSIQs6AJHekCVgNLDWxSvQ4Fgi
 qE2Xr+IW4IZA3SDAl1q7HK5aY4yKqn4ga7OudeHorWr29qEdGznjnWN6MuQCE1JW32oG
 nGeWeH/SdCMoB1CBV7nfbLInJOd0VuT32Ap/MZ/JAgVHb0Bw1R8Z2yto9zB05b1ROkMr
 Fet1fVyn0Bis+b6UkLBiaoc2vKqhTF9Setlem4A2dtW84WbJCQU/rK2je9p0cJFjIfoK
 wrimpUG//29d3JXmsCA8rUbNB/9XPuhHJyFAvEfu8yD/7wjE0ZowUhGp3kfp4EDhj2rh
 FJTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDRTA+v5tDB0vt78+IPfo4Pcq1JB2hOdli0hrnkgd1G4hrKGuK/KGCxJB2TdDq0qo14z7jZrg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwQagjKzrgDxb9tq232Fl0+Ywb5litLWiUoaiLXKabOuw7B1Tbp
 z6LFXKCOIZWTTwD243vVc2gCfdicfGNuRUnx9zzQnbNBXDU49IoBFxDF
X-Gm-Gg: AR+sD10wi+7pqGJpl6vvHrlQdJ1vUtUwVZ5f9zwcLr4EOXd7v9A+2YVNqernxx5bADe
 NkxGU2jz0RjOmIat6zZKimV7sAubqhUvsqI9FM8LahDyYa3zZ6vOkWMCisdEKYsyTZaJDJJzQLd
 XxbjyndOkBZ7AiwrADs5t9ujQ8KMSl+76KobhzNBybqGa2oqiBC5qxJbpUUe+/LDKUioTWdg3wo
 LxMsb/XAvNKAIX1sxhGASTMrEXMeCuEPqnEfnBkuf/zbOuSinmYOE5QgQQH5f8KscyIL62G3qXv
 BNROk/u9XI2q2sN7svuoS7RNyx2C7OLIz7GGpCGmpAGLSnbcYFAWzA6JOfDGU/cxJKhGTlYAH7u
 QQ/Imj6pRworA7iBpTL7lnfuP6HXF10DX0FnN6qh+q7M7MkKKNxvPTAXrpT5IHRYP5wMiY+H4XQ
 v9YBKeb/QeTWHQJ9luDzNWtNWTBqVzsywBmfuTxLw5azJLjzw0zB9dsgVCkdKgZKM2fkhkBK8xG
 7xlPShVuNBUhdZzLRiKFkKz+dahRkNnHz1AxZEJsRDburOwA20pk7NHnVe6KFqNPo72OtKhauPI
 3W9PK5uWv3kFBratFqVyVlyotvFYLdGr3jGSJFQrk573uWjiarz14Uo9FIGYETk+SNTHprqI3g/
 3Wu8BrSECvrm89PP66aSIkTKwZws=
X-Received: by 2002:a05:6820:81d5:b0:6b0:4ac8:3c59 with SMTP id
 006d021491bc7-6b0d61625b7mr953468eaf.12.1786651179014; 
 Thu, 13 Aug 2026 12:59:39 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:59:08 -0600
Subject: [PATCH v7 15/15] crypto: allwinner: add sun8i-ce hash driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-15-593fcd8479fd@gmail.com>
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 20:17:42 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Allwinner sun8i Crypto Engine includes hardware hash methods. Add a
UCLASS_HASH child for the sun8i-ce parent so FIT hash verification can use
the accelerator from U-Boot proper and SPL.

Support MD5, SHA1, SHA256, SHA384 and SHA512 with both one-shot and
progressive operations. Progressive updates buffer partial blocks, submit
complete blocks, feed each intermediate state back through hash input-IV
mode and retain the total message length for final padding. Keep the full
64-byte SHA384 internal state while returning its 48-byte digest. This
allows discontiguous FIT configuration regions to be hashed without a
software fallback.

Build the final hash padding in the driver. Stream directly addressable
input through bounded 64 MiB zero-copy tasks and word-unaligned input
through a fixed 128 KiB repack buffer. Keep heap use independent of input
size while word-aligned cacheline offsets remain zero-copy. Retain the
fixed task, padding and result storage in each progressive context to avoid
repeated allocation across updates.

Map input, padding, optional state and a cacheline-rounded private output
through the parent DMA objects. Keep the descriptor output length limited
to the algorithm state, then submit hash work on the dedicated completion
channel through the shared task-session API. Keep one session across every
continuation chunk while retiring each task before releasing its mappings.
Release mappings in reverse preparation order after the session retires.

H6 and H616 use bit-sized hash task lengths, so keep each submitted chunk
within the 32-bit task descriptor field. Feed the watchdog from the shared
CE polling path while waiting for hardware completion.

In SPL, only advertise hash algorithms selected for that phase so
SRAM-constrained builds do not accept wider algorithms unless requested.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Add progressive init, update and finish operations
  - Buffer partial blocks and reuse CE intermediate hash state across updates
  - Retain the full SHA384 internal state across progressive operations
  - Allocate fixed progressive job storage once per hash context

Changes v4 -> v5:
  - Use the parent's explicit close-on-error blocking helper to populate
    descriptor transport fields and abort failed chains before callers
    release their DMA mappings
  - Replace the algorithm switch and separate size lookups with one table
  - Derive bounded padding without adding near the input-size limit, and
    validate input ranges and descriptor-length arithmetic
  - Replace the payload-sized word-unaligned bounce with a fixed 128 KiB
    streaming repack while keeping word-aligned cacheline offsets zero-copy
  - Split large direct input into bounded 64 MiB tasks and use one
    continuation loop and one CE session for direct and repacked input
  - Carry intermediate state through hash input-IV mode
  - Use shared cacheline-safe DMA mappings and round private result storage
    to complete cachelines

Changes v3 -> v4:
  - Consolidate algorithm selection and invariant task sizing
  - Use the dedicated hash channel and shared task-session path
  - Return -EOPNOTSUPP for unavailable algorithms

Changes v1 -> v2:
  - Reject oversized bit-length hash tasks  (suggested by Simon Glass)
  - Feed the watchdog during CE polling  (suggested by Simon Glass)
  - Drop the post-operation schedule() call  (suggested by Simon Glass)
  - Bounce only word-unaligned input
---
 drivers/crypto/allwinner/sun8i-ce/Kconfig         |  26 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile        |   1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c |   6 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 483 ++++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |   5 +
 5 files changed, 521 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
index 49686d07aa3..c53c38cf5d6 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Kconfig
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -40,6 +40,32 @@ config SPL_SUNXI_CE_AES
 	  Engine found in Allwinner H6 and H616 compatible SoCs. This can be
 	  used to decrypt FIT images before loading U-Boot proper.
 
+config SUNXI_CE_HASH
+	bool "Allwinner sunxi CE hash"
+	depends on ARCH_SUNXI
+	depends on DM_HASH
+	depends on CLK && DM_RESET
+	select SUNXI_CE
+	help
+	  Select this option to enable hash calculation using the Crypto Engine
+	  found in Allwinner sunxi SoCs. The driver supports MD5, SHA1,
+	  SHA256, SHA384 and SHA512.
+
+config SPL_SUNXI_CE_HASH
+	bool "Allwinner sunxi CE hash in SPL"
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	select SPL_DM_HASH
+	select SPL_CRYPTO
+	select SPL_SUNXI_CE
+	help
+	  Select this option to enable hash calculation in SPL using the Crypto
+	  Engine found in Allwinner H6 and H616 compatible SoCs. FIT image
+	  hashes can then be calculated by the hardware accelerator before
+	  U-Boot proper is loaded.
+
 config SUNXI_CE_ECDSA
 	bool "Allwinner sunxi CE ECDSA verifier"
 	depends on ARCH_SUNXI
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
index 753ea827a0d..5baf65e40ec 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_$(PHASE_)SUNXI_CE) += sun8i-ce-core.o
 obj-$(CONFIG_$(PHASE_)SUNXI_CE_AES) += sun8i-ce-aes.o
+obj-$(CONFIG_$(PHASE_)SUNXI_CE_HASH) += sun8i-ce-hash.o
 obj-$(CONFIG_$(PHASE_)SUNXI_CE_ECDSA) += sun8i-ce-ecdsa.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 4ce1ee70c14..201e9203bf1 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -679,6 +679,12 @@ static int sunxi_ce_bind(struct udevice *dev)
 			return ret;
 	}
 
+	if (CONFIG_IS_ENABLED(SUNXI_CE_HASH)) {
+		ret = sunxi_ce_bind_child(dev, "sun8i-ce-hash");
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
new file mode 100644
index 00000000000..43f1be7c706
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#define LOG_CATEGORY UCLASS_HASH
+
+#include <dm.h>
+#include <limits.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <u-boot/hash.h>
+#include <u-boot/md5.h>
+#include <u-boot/sha1.h>
+#include <u-boot/sha256.h>
+#include <u-boot/sha512.h>
+#include <linux/kernel.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_HASH_MAX_BLOCK_SIZE	SHA512_BLOCK_SIZE
+#define SUNXI_CE_HASH_MAX_DIGEST_SIZE	SHA512_SUM_LEN
+#define SUNXI_CE_HASH_RESULT_SIZE	ALIGN(SUNXI_CE_HASH_MAX_DIGEST_SIZE, \
+					      ARCH_DMA_MINALIGN)
+#define SUNXI_CE_HASH_MAX_PAD_SIZE	(2 * SUNXI_CE_HASH_MAX_BLOCK_SIZE)
+#define SUNXI_CE_HASH_REPACK_SIZE	(128 * 1024)
+#define SUNXI_CE_HASH_DIRECT_SIZE	(64 * 1024 * 1024)
+#define SUNXI_CE_HASH_IV_INPUT		BIT(16)
+#define SUNXI_CE_HASH_BLOCK_SIZE		64
+
+static_assert(IS_ALIGNED(SUNXI_CE_HASH_REPACK_SIZE,
+			 SUNXI_CE_HASH_MAX_BLOCK_SIZE));
+static_assert(IS_ALIGNED(SUNXI_CE_HASH_DIRECT_SIZE,
+			 SUNXI_CE_HASH_MAX_BLOCK_SIZE));
+
+struct sunxi_hash_job {
+	struct sunxi_ce_task task __aligned(ARCH_DMA_MINALIGN);
+	u8 pad[SUNXI_CE_HASH_MAX_PAD_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 result[SUNXI_CE_HASH_RESULT_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 state[SUNXI_CE_HASH_MAX_DIGEST_SIZE] __aligned(ARCH_DMA_MINALIGN);
+};
+
+struct sunxi_hash_alg {
+	u8 method;
+	u8 block_size;
+	u8 digest_size;
+	u8 state_size;
+	bool little_endian_len;
+	bool available;
+};
+
+struct sunxi_hash_ctx {
+	struct udevice *dev;
+	const struct sunxi_hash_alg *alg;
+	u64 total_len;
+	u8 tail[SUNXI_CE_HASH_MAX_BLOCK_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 state[SUNXI_CE_HASH_MAX_DIGEST_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	struct sunxi_hash_job job;
+	size_t tail_len;
+	bool state_valid;
+};
+
+static const struct sunxi_hash_alg sunxi_hash_algs[HASH_ALGO_NUM] = {
+	[HASH_ALGO_MD5] = {
+		.method = SUNXI_CE_METHOD_MD5,
+		.block_size = SUNXI_CE_HASH_BLOCK_SIZE,
+		.digest_size = MD5_SUM_LEN,
+		.state_size = MD5_SUM_LEN,
+		.little_endian_len = true,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(MD5),
+	},
+	[HASH_ALGO_SHA1] = {
+		.method = SUNXI_CE_METHOD_SHA1,
+		.block_size = SUNXI_CE_HASH_BLOCK_SIZE,
+		.digest_size = SHA1_SUM_LEN,
+		.state_size = SHA1_SUM_LEN,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(SHA1),
+	},
+	[HASH_ALGO_SHA256] = {
+		.method = SUNXI_CE_METHOD_SHA256,
+		.block_size = SUNXI_CE_HASH_BLOCK_SIZE,
+		.digest_size = SHA256_SUM_LEN,
+		.state_size = SHA256_SUM_LEN,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(SHA256),
+	},
+	[HASH_ALGO_SHA384] = {
+		.method = SUNXI_CE_METHOD_SHA384,
+		.block_size = SHA512_BLOCK_SIZE,
+		.digest_size = SHA384_SUM_LEN,
+		.state_size = SHA512_SUM_LEN,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(SHA384),
+	},
+	[HASH_ALGO_SHA512] = {
+		.method = SUNXI_CE_METHOD_SHA512,
+		.block_size = SHA512_BLOCK_SIZE,
+		.digest_size = SHA512_SUM_LEN,
+		.state_size = SHA512_SUM_LEN,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(SHA512),
+	},
+};
+
+static const struct sunxi_hash_alg *sunxi_hash_get_alg(enum HASH_ALGO algo)
+{
+	if ((u32)algo >= ARRAY_SIZE(sunxi_hash_algs) ||
+	    !sunxi_hash_algs[algo].available)
+		return NULL;
+
+	return &sunxi_hash_algs[algo];
+}
+
+static size_t sunxi_hash_pad(const struct sunxi_hash_alg *alg, u8 *pad,
+			     const u8 *tail, size_t tail_len, size_t len)
+{
+	size_t block_size = alg->block_size;
+	size_t rem = len % block_size;
+	size_t len_size = block_size == SHA512_BLOCK_SIZE ? 16 : 8;
+	size_t pad_len, len_off;
+	u64 bits;
+
+	pad_len = tail_len + (rem < block_size - len_size ?
+			       block_size - rem : 2 * block_size - rem);
+
+	memset(pad, 0, pad_len);
+	if (tail_len)
+		memcpy(pad, tail, tail_len);
+	pad[tail_len] = 0x80;
+
+	bits = (u64)len << 3;
+	len_off = pad_len - 8;
+	if (alg->little_endian_len) {
+		bits = cpu_to_le64(bits);
+		memcpy(pad + len_off, &bits, sizeof(bits));
+	} else {
+		bits = cpu_to_be64(bits);
+		memcpy(pad + len_off, &bits, sizeof(bits));
+	}
+
+	return pad_len;
+}
+
+static void sunxi_hash_fill_task(struct sunxi_ce_priv *ce,
+				 struct sunxi_hash_job *job,
+				 dma_addr_t iv,
+				 dma_addr_t src, size_t src_len,
+				 dma_addr_t pad, size_t pad_len,
+				 dma_addr_t result, size_t state_len)
+{
+	struct sunxi_ce_task *task = &job->task;
+	u32 total_len = src_len + pad_len;
+	u32 sg = 0;
+
+	memset(task, 0, sizeof(*task));
+
+	task->t_common_ctl = iv ? SUNXI_CE_HASH_IV_INPUT : 0;
+	if (iv)
+		task->t_iv = sunxi_ce_desc_dma_addr(ce, iv);
+	task->t_dlen = total_len * 8;
+
+	if (src_len) {
+		task->t_src[sg].addr = sunxi_ce_desc_dma_addr(ce, src);
+		task->t_src[sg].len = src_len / sizeof(u32);
+		sg++;
+	}
+	if (pad_len) {
+		task->t_src[sg].addr = sunxi_ce_desc_dma_addr(ce, pad);
+		task->t_src[sg].len = pad_len / sizeof(u32);
+	}
+
+	task->t_dst[0].addr = sunxi_ce_desc_dma_addr(ce, result);
+	task->t_dst[0].len = state_len / sizeof(u32);
+}
+
+static int sunxi_hash_run_chunk(struct sunxi_ce_priv *ce,
+				struct sunxi_ce_session *session,
+				struct sunxi_hash_job *job,
+				u32 method,
+				const void *src, size_t src_len, size_t pad_len,
+				const void *iv, size_t state_len)
+{
+	struct sunxi_ce_dma_buf result_dma = { };
+	struct sunxi_ce_dma_buf src_dma = { };
+	struct sunxi_ce_dma_buf pad_dma = { };
+	struct sunxi_ce_dma_buf iv_dma = { };
+	int ret;
+
+	if (!IS_ALIGNED(src_len, sizeof(u32)) ||
+	    !IS_ALIGNED(pad_len, sizeof(u32)) ||
+	    src_len > U32_MAX / 8 || pad_len > U32_MAX / 8 - src_len)
+		return -EINVAL;
+
+	ret = sunxi_ce_dma_map(ce, &src_dma, (void *)src, src_len,
+			       DMA_TO_DEVICE);
+	if (ret)
+		goto out_unmap;
+	ret = sunxi_ce_dma_map(ce, &pad_dma, job->pad, pad_len,
+			       DMA_TO_DEVICE);
+	if (ret)
+		goto out_unmap;
+	ret = sunxi_ce_dma_map(ce, &iv_dma, (void *)iv, iv ? state_len : 0,
+			       DMA_TO_DEVICE);
+	if (ret)
+		goto out_unmap;
+	ret = sunxi_ce_dma_map(ce, &result_dma, job->result,
+			       sizeof(job->result),
+			       DMA_FROM_DEVICE);
+	if (ret)
+		goto out_unmap;
+
+	sunxi_hash_fill_task(ce, job, iv_dma.dma, src_dma.dma,
+			     src_len, pad_dma.dma, pad_len, result_dma.dma,
+			     state_len);
+
+	ret = sunxi_ce_session_run_chain_or_close(session,
+						  SUNXI_CE_CHANNEL_HASH, method,
+						  &job->task, 1);
+
+out_unmap:
+	sunxi_ce_dma_unmap(&result_dma);
+	sunxi_ce_dma_unmap(&iv_dma);
+	sunxi_ce_dma_unmap(&pad_dma);
+	sunxi_ce_dma_unmap(&src_dma);
+
+	return ret;
+}
+
+static int sunxi_hash_run_stream(struct sunxi_ce_priv *ce,
+				 struct sunxi_hash_job *job,
+				 u32 method,
+				 const u8 *src, size_t src_len,
+				 size_t pad_len, size_t state_len,
+				 const void *initial_iv)
+{
+	struct sunxi_ce_session session;
+	const void *iv = initial_iv;
+	const void *chunk;
+	size_t chunk_size;
+	u8 *repack = NULL;
+	int ret;
+
+	if (src_len && !IS_ALIGNED((uintptr_t)src, sizeof(u32))) {
+		/* CE scatter-gather addresses require word-aligned chunks. */
+		chunk_size = SUNXI_CE_HASH_REPACK_SIZE;
+		repack = memalign(ARCH_DMA_MINALIGN, chunk_size);
+		if (!repack)
+			return -ENOMEM;
+	} else {
+		chunk_size = SUNXI_CE_HASH_DIRECT_SIZE;
+	}
+
+	ret = sunxi_ce_session_begin(ce,
+				     SUNXI_CE_CHAN_MASK(SUNXI_CE_CHANNEL_HASH),
+				     &session);
+	if (ret)
+		goto out;
+
+	while (src_len > chunk_size) {
+		chunk = src;
+		if (repack) {
+			memcpy(repack, src, chunk_size);
+			chunk = repack;
+		}
+		ret = sunxi_hash_run_chunk(ce, &session, job, method, chunk,
+					   chunk_size, 0, iv, state_len);
+		if (ret)
+			goto out_close;
+
+		memcpy(job->state, job->result, state_len);
+		iv = job->state;
+		src += chunk_size;
+		src_len -= chunk_size;
+	}
+
+	chunk = src;
+	if (repack) {
+		memcpy(repack, src, src_len);
+		chunk = repack;
+	}
+	ret = sunxi_hash_run_chunk(ce, &session, job, method, chunk, src_len,
+				   pad_len, iv, state_len);
+out_close:
+	ret = sunxi_ce_session_close(&session, ret);
+out:
+	free(repack);
+
+	return ret;
+}
+
+static int sunxi_hash_digest(struct udevice *dev, enum HASH_ALGO hash_algo,
+			     const void *ibuf, const uint32_t ilen, void *obuf)
+{
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	const struct sunxi_hash_alg *alg;
+	size_t src_len = ALIGN_DOWN(ilen, sizeof(u32));
+	size_t tail_len = ilen - src_len;
+	struct sunxi_hash_job *job;
+	const u8 *tail = ibuf;
+	size_t pad_len;
+	u8 digest_size, state_size;
+	u32 method;
+	int ret;
+
+	alg = sunxi_hash_get_alg(hash_algo);
+	if (!alg)
+		return -EOPNOTSUPP;
+	if ((!ibuf && ilen) || !obuf)
+		return -EINVAL;
+	if (ilen > UINTPTR_MAX - (uintptr_t)ibuf)
+		return -EOVERFLOW;
+	method = alg->method;
+	digest_size = alg->digest_size;
+	state_size = alg->state_size;
+
+	job = malloc_cache_aligned(sizeof(*job));
+	if (!job)
+		return -ENOMEM;
+
+	if (tail_len)
+		tail += src_len;
+
+	pad_len = sunxi_hash_pad(alg, job->pad, tail, tail_len, ilen);
+	ret = sunxi_hash_run_stream(ce, job, method, ibuf, src_len, pad_len,
+				    state_size, NULL);
+	if (ret)
+		goto out;
+
+	memcpy(obuf, job->result, digest_size);
+
+out:
+	free(job);
+
+	return ret;
+}
+
+static int sunxi_hash_process_blocks(struct sunxi_hash_ctx *ctx,
+				     const void *src, size_t len)
+{
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(ctx->dev));
+	struct sunxi_hash_job *job = &ctx->job;
+	int ret;
+
+	if (!len)
+		return 0;
+	if (!IS_ALIGNED(len, ctx->alg->block_size))
+		return -EINVAL;
+
+	ret = sunxi_hash_run_stream(ce, job, ctx->alg->method, src, len, 0,
+				    ctx->alg->state_size,
+				    ctx->state_valid ? ctx->state : NULL);
+	if (!ret) {
+		memcpy(ctx->state, job->result, ctx->alg->state_size);
+		ctx->state_valid = true;
+	}
+
+	return ret;
+}
+
+static int sunxi_hash_init(struct udevice *dev, enum HASH_ALGO algo,
+			   void **ctxp)
+{
+	const struct sunxi_hash_alg *alg;
+	struct sunxi_hash_ctx *ctx;
+
+	alg = sunxi_hash_get_alg(algo);
+	if (!alg)
+		return -EOPNOTSUPP;
+
+	ctx = memalign(ARCH_DMA_MINALIGN, sizeof(*ctx));
+	if (!ctx)
+		return -ENOMEM;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dev = dev;
+	ctx->alg = alg;
+	*ctxp = ctx;
+
+	return 0;
+}
+
+static int sunxi_hash_update(struct udevice *dev, void *data,
+			     const void *ibuf, u32 ilen)
+{
+	struct sunxi_hash_ctx *ctx = data;
+	const u8 *src = ibuf;
+	size_t block_size = ctx->alg->block_size;
+	size_t process_len;
+	size_t fill;
+	u64 total_len;
+	int ret;
+
+	if ((!ibuf && ilen) || ctx->dev != dev)
+		return -EINVAL;
+	if (ctx->total_len > U64_MAX - ilen)
+		return -EOVERFLOW;
+	total_len = ctx->total_len + ilen;
+
+	if (ctx->tail_len) {
+		fill = block_size - ctx->tail_len;
+		if (ilen < fill) {
+			memcpy(ctx->tail + ctx->tail_len, src, ilen);
+			ctx->tail_len += ilen;
+			ctx->total_len = total_len;
+			return 0;
+		}
+
+		memcpy(ctx->tail + ctx->tail_len, src, fill);
+		ret = sunxi_hash_process_blocks(ctx, ctx->tail, block_size);
+		if (ret)
+			return ret;
+		ctx->tail_len = 0;
+		src += fill;
+		ilen -= fill;
+	}
+
+	process_len = ALIGN_DOWN(ilen, block_size);
+	if (process_len) {
+		ret = sunxi_hash_process_blocks(ctx, src, process_len);
+		if (ret)
+			return ret;
+		src += process_len;
+		ilen -= process_len;
+	}
+
+	if (ilen) {
+		memcpy(ctx->tail, src, ilen);
+		ctx->tail_len = ilen;
+	}
+	ctx->total_len = total_len;
+
+	return 0;
+}
+
+static int sunxi_hash_finish(struct udevice *dev, void *data, void *obuf)
+{
+	struct sunxi_hash_ctx *ctx = data;
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	struct sunxi_hash_job *job = &ctx->job;
+	size_t pad_len;
+	int ret;
+
+	if (!obuf || ctx->dev != dev) {
+		ret = -EINVAL;
+		goto out_free_ctx;
+	}
+
+	pad_len = sunxi_hash_pad(ctx->alg, job->pad, ctx->tail,
+				 ctx->tail_len, ctx->total_len);
+	ret = sunxi_hash_run_stream(ce, job, ctx->alg->method, NULL, 0,
+				    pad_len, ctx->alg->state_size,
+				    ctx->state_valid ? ctx->state : NULL);
+	if (!ret)
+		memcpy(obuf, job->result, ctx->alg->digest_size);
+
+out_free_ctx:
+	free(ctx);
+
+	return ret;
+}
+
+static int sunxi_hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
+				const void *ibuf, const uint32_t ilen,
+				void *obuf, uint32_t chunk_sz)
+{
+	return sunxi_hash_digest(dev, algo, ibuf, ilen, obuf);
+}
+
+static const struct hash_ops sunxi_hash_ops = {
+	.hash_init = sunxi_hash_init,
+	.hash_update = sunxi_hash_update,
+	.hash_finish = sunxi_hash_finish,
+	.hash_digest = sunxi_hash_digest,
+	.hash_digest_wd = sunxi_hash_digest_wd,
+};
+
+U_BOOT_DRIVER(sun8i_ce_hash) = {
+	.name = "sun8i-ce-hash",
+	.id = UCLASS_HASH,
+	.ops = &sunxi_hash_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index d5b7edd357d..b7bb899c5f0 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -21,6 +21,11 @@
 #define SUNXI_CE_COMM_INT		BIT(31)
 #define SUNXI_CE_METHOD_AES		0
 #define SUNXI_CE_METHOD_RAES		0x30
+#define SUNXI_CE_METHOD_MD5		16
+#define SUNXI_CE_METHOD_SHA1		17
+#define SUNXI_CE_METHOD_SHA256		19
+#define SUNXI_CE_METHOD_SHA384		20
+#define SUNXI_CE_METHOD_SHA512		21
 #define SUNXI_CE_METHOD_ECC		33
 #define SUNXI_CE_ECC_OP_VERIFY		7
 #define SUNXI_CE_ECC_OP_SHIFT		16

-- 
2.53.0

