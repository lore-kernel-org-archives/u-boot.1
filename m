Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B46C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034308209D;
	Fri, 14 Mar 2025 22:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QCIg+gnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A548207A; Fri, 14 Mar 2025 22:56:06 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93DC1820A0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso1926245e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989362; x=1742594162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smOmwzgFZwd5TuZNpf2g+cWTwWJAVBKSC38OcsVOuEk=;
 b=QCIg+gnAvyDIX3KTzVbCex4sCsf17MoH0aO/RfOrT6/JJV0P6DDRUCxtWxzq8/iR8p
 sdMvtrg91LCj46gLLrm+wJz/l8LpuCuQZfMOrtdxmQ/+rKM1Q50C3OUvxIKHcKk5hxex
 sYaiGto/58wyQRBvoe+akupGmdvIiS0B2XgtL7qAtHa8yMimwO5CfUFXlpdNZMgvddBz
 6AXT1FX49b+hN3QKK2fIOooAMtF4egxMtDWzeiY8KxkoFAY/EJ8jfpNdJJBgu5N6Zr6B
 WtxDmxryAiSj+aDjL2YIAAIyOaPzAbwY2eK9s4Kl65Y+0ObKWpKoDwmQoG+dBDKwzb3K
 rHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989362; x=1742594162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smOmwzgFZwd5TuZNpf2g+cWTwWJAVBKSC38OcsVOuEk=;
 b=DevvB+EWZzEltV4p6ZYBwjjSVAsP7lKVThgWM5VMgcUA8tq6PH+OTbgriUuEJe2WV+
 s+EhsSWAoraI0cPiahwHNjAnChFL42OsYm75KG+HUQSgomjcPvDIQ6qdly3aGtSf0xLB
 0OYgFdgJmeIXDZ7T7AErhtu/M8scv4feMFso7I+E1fXRUJuCrcTJqgXeKVG9QuZ2jQCO
 EXvQblqRYietgx3fIf+mIXvvDJ9aGUWe1McAAjsXaK3l31OGflfgM7PMRbQiG69EnfUN
 nJJR0nPcgIrF8mmgYiVwgmMPRp78rIMeYenxI5MN/mNt2kMguHx1YQ6iR4YfEK43rOfl
 Lo9Q==
X-Gm-Message-State: AOJu0YzLCGwknSk02FlGXEH6cdeve340mTuiCBkmd8tgCJf/9W1dvdKN
 zt1wlYaqEtA8zVIWolPc+B1zue/GL64WY9Gbn9zlsbLJm3cjRqxyt4RukhHnaor2t31zjxw/ZWE
 Q0qg=
X-Gm-Gg: ASbGncvjw3jcnSMm88DabGedg7GgsDQd8TexEw4NDvcTeU4try8/ogMkoG91dzBkaeA
 wj6q8D6ZrSUtYMuxjyKhJr+K3CzRlL5z+4fydVQEYJs3JqDlm4p3J3qRpky424qEaoRjJ3nljsd
 dQ5EVpgTMoMFjCHXRDb9FTDSyabs4ziMLIvgfIMuO8jq2Fr7ySiOw/O/zA1IDPnw4TxhmZRKEQO
 Jo3W7H2YUP9s2Vvj3WBsad/sBRr2rzCVIVP8c8kUcyyN8JAPwPA1GUqXaA95kKirn+cwQonm7xQ
 qoPtvAZcdOvlqCjqWEt0NoY4Ie2zBA3SvdkZdhtNi+GzKsHzAt8Gew==
X-Google-Smtp-Source: AGHT+IEWYs/T2/j2UMTLdnbpBg3RE+Ja5qG0rVAwZtA63l/SfVhvYIUfskoK4WWevS5Tltp8+XRFFQ==
X-Received: by 2002:a5d:64cc:0:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-3971f9e53bfmr5639963f8f.46.1741989361883; 
 Fri, 14 Mar 2025 14:56:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:56:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>, Simon Glass <sjg@chromium.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Marek Vasut <marex@denx.de>,
 Romain Naour <romain.naour@smile.fr>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 10/12] net: lwip: allow DM_DSA=y when NET_LWIP=y
Date: Fri, 14 Mar 2025 22:55:12 +0100
Message-ID: <20250314215525.579655-11-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

Now that the DSA tests in test/dm/dsa.c are compatible with NET_LWIP,
remove the dependency of DM_DSA on NET.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/Kconfig | 1 -
 net/Makefile        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e683c18cad7..eb53c5f0ca8 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -48,7 +48,6 @@ config DM_DSA
 	bool "Enable Driver Model for DSA switches"
 	depends on DM_MDIO
 	depends on PHY_FIXED
-	depends on !NET_LWIP
 	help
 	  Enable driver model for DSA switches
 
diff --git a/net/Makefile b/net/Makefile
index 7c917b318c0..88adc549acb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_NET)      += arp.o
 obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_CDP)  += cdp.o
 obj-$(CONFIG_CMD_DNS)  += dns.o
-obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
 obj-$(CONFIG_IPV6)     += ndisc.o
 obj-$(CONFIG_$(XPL_)DM_ETH) += net.o
@@ -39,6 +38,7 @@ CFLAGS_eth_common.o += -Wno-format-extra-args
 endif
 
 ifeq ($(filter y,$(CONFIG_NET) $(CONFIG_NET_LWIP)),y)
+obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
 obj-$(CONFIG_$(XPL_)DM_ETH) += eth-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
-- 
2.43.0

