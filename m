Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6856C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 09:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F67A82B0F;
	Tue, 17 Jun 2025 11:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k2IBE64E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9471A82BF6; Tue, 17 Jun 2025 11:22:45 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B7F81760
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 11:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c85so8304762a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750152163; x=1750756963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=And5IXllQMQiJCVu2OuX65FRnDgHuQi4o3XwDZn1CZk=;
 b=k2IBE64EygGYHmUljubAmMjQy9qd+13nclRTqiuTVl1y2PnJKSkz2CQrg6xDPD4+3R
 6M86jQdlnaMX8sqjDdWlGE/+1RcNthsQ5qwzwi0inFIQ+9odJnEuCah9WR3mIUeN9Dwj
 NxKobCbSmakNsw/zTVFBI6QLOs+nKlG/0tBEGpij9KMwhzgPwuOXJNUEVkfk3Zqt4Kzx
 5Mt8hTePucFPtUYc4gvo6OEWQ5QPk9FWMmhd5XaX84tx6nm9MFFylgAfxoSDf/y8ca3L
 cusVl4Tk1r+0L8ufu4AnSB/wjkf15vBTbPAVP1eW7/GyYvqlgyLyGNUEK0twIfpie+uV
 gcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750152163; x=1750756963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=And5IXllQMQiJCVu2OuX65FRnDgHuQi4o3XwDZn1CZk=;
 b=Q/GVRMabNpGIiuiQO8D3ZAJpifzbShrnpT7soyrjsP9AMF+cPpc60TAAsx+udKjwOL
 JHQbmFSIMksFL67SHtQA1wcjDzkpiyqIqbYnQSLvvZuEQBOaemGbdoDLr7B3IjyAyEiT
 rSO4Ye/GyzclB3K86AZSRuBeiu/7LgKNkq5tSBDHdMDdNiep/abQxC1ZLJlyCpykhzaZ
 ZWlcV376oXNeq6Uxsg/lMePQEDzvIxwuFz7A4glyPyqda2e3r4YH2IOdsPzmNPTFVnKS
 Q4QL8dIxDArB5b7EF8rCRwQ0jJkbRtbOVHmaeAmdqd7JHfu+MHNbH0YxVI1k9XQJFnDR
 qr1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1HnUvKX+OO1FzS9MI6RcFpkS15eqOTyUqiIeXPVIXyaHjaRz0QMQHKWr8KL/PGz7Cghh0FZM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj9JtA4JRR63yYOIYsTA5+/+iTcSzZkJFZ5CIDmdEy2ImAIgut
 8jsO/FA2KwpJcrl9hXBiQpvp5SUnt/dagADKEgtybtuXxENfP85C7wr6qDSGUxwsGhc=
X-Gm-Gg: ASbGncsjgSomfcWUnnzDVGCqi2SjN2u4ExUc9FiPsSkB0BmUG4ur9xkTBOlJU2dN8Lt
 RKv9svTrgVdAF8Nh0AHzSKaX+0h9d/lrDghW8YVBdGYqyzYPUuvN+vg3wb5Rf2J3UYUfR0OOkxV
 kSXNc9hGsbNVuPVAe5ZL6dFDqPLQYrRkVYvBWw62M2n+gyzt9yQzjl+XBa2JN+Z8bTa7x1bc1WX
 6E10ahbouq4LPbZprHjU2E+32wpdf1JBn8uyilJmt2LDsSIADMEq8KGLybiHLJpNV1xP1CVfFDn
 +LSDG2lCOQ29zQiBTlZ+7v15z3u9I5ODosPxS20Lz1WgDa5abkEzFFdZx2163x9rd3Ir1TdTf41
 Vq5C2n5ex8waMRKdA/wG0/f/9SbDfgA/fTm4IXsG1XKXDiPFIhfU=
X-Google-Smtp-Source: AGHT+IG3CzvAkbvEBugHaTfDmVj/UcqyFdU4CHUbmLMEE1NNn4ZoDtzzTOCM7YhVK+qDo+SyxMjd1Q==
X-Received: by 2002:a17:907:72c9:b0:ad8:8529:4f83 with SMTP id
 a640c23a62f3a-adfad449c2bmr1085622566b.39.1750152163009; 
 Tue, 17 Jun 2025 02:22:43 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adfbfc777c9sm525010766b.118.2025.06.17.02.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 02:22:42 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] kbuild: Update Makefile.extrawarn to 5.1
Date: Tue, 17 Jun 2025 12:22:23 +0300
Message-ID: <20250617092231.2467748-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Since we are updating our kbuild system to 5.1, add the relevant
clang changes from upstream

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.extrawarn | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index f687515fc799..7df62263bc42 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -67,5 +67,14 @@ ifeq ("$(strip $(warning))","")
 endif
 
 KBUILD_CFLAGS += $(warning)
+else
 
+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
+KBUILD_CFLAGS += $(call cc-disable-warning, format)
+KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
+KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
+endif
 endif
-- 
2.49.0

