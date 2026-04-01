Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CB0D2ED0A
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F888410C;
	Wed,  1 Apr 2026 16:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KV+P/Wdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CCF8410C; Wed,  1 Apr 2026 16:15:36 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3184284020
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887d4c6234so23069365e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052933; x=1775657733; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JxcERJ3UaiRl1vXO0KA5cEnHfc4xtMelhah9KPin2lI=;
 b=KV+P/WdmQVr0wMEukAOh163JU75AzZ3EOklAsSsaTocihrIsMLtZ78zVC/JHGY2D0N
 mIRmpCtqaQvxskSiO491lcx0cRwoohYHcR61mEGpV506vbSibgSyITAXrsHNwOBPcxGY
 +gntXWjOwGyfuYt4HzQ0i+Maz49hTWh/UbKkK8VWYMkQzsquUyFEE3CcrYFlU9B1U8GC
 3/P/XCm6/nAL10T+RDuKpfs4qAAlQ9l457iFZpXGrgFeql99z4VSSPDsQc+SmgQW5NDT
 wixQWldOHbE2yjp65vfeyY5HXftq5u7b4f6bvIIBWtmnRxzugTfGyaX12CUg6nO/k0Bg
 Cgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052933; x=1775657733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JxcERJ3UaiRl1vXO0KA5cEnHfc4xtMelhah9KPin2lI=;
 b=OF9HEi2Ewky5+ARuwiLiQPV0Sit9CDMZvQxrH58j42+ln0hwjlpMR9KzL1iX2pvWDW
 VkeqE8545HjiKcSIEeOm0N1jnP4kn18st517p+dUt90XjYfIcItGWxok+1uZ48f8gFc+
 CddpHPzmdN8uYHD6aqp3JjK5LbgqulFoTgbEhq4Ur55fA/XxAz9B8tAbUFBvoXK1yt+u
 /wno65iwehfmmQ5zc8WM5i7yWrG7szIGbNHFSTh4rYLPbe7ibZ2DgRjL6tUIpgahZAf4
 v7WJZyid9FNywapja6gbaBq3GmDLydSZn6RdKd8CFwetsj0MDNhFWGd8hW7akCGJVV3E
 wrZQ==
X-Gm-Message-State: AOJu0Yw9Zx6NoJJGp11ylU1OzKes3GcELGIswbJBHb4QPASKO8oVzLLG
 mW+Z9Gb9kbmmwByqczAwIkdkedrsJiM3F+SFpPxPOqUbntLRLKCuV/N577zK9YOeQRw=
X-Gm-Gg: ATEYQzw3R501R5GcPwruizPNfjF1YnTxxKNVaO3SK1wNYKvFbrgdMY7qLFCDiUT0mEW
 mQ6JEenxYhA7zRWD8UqqdhTiW5jyuFv1AmxglH5yWWFP0Y1A9vomKHfiQPxdKAWesWlLlhbgeWh
 tDaLGqbrHVs+7p6V7cntSDARI7UHys9O7iGLbv6d5UN64TDWe1L6G6VcYCg7deKhAgyCt5JYy25
 Gjtcsu+/uzjxU1WBYvW3+8pkEhlLORpge5Fic1mwu+bGy+ePjmL6sUG3/k6zz9f2UhmZf3ltgA3
 zKXNeKwKivt+uQL4J+e87HtyuKxNtbBjMf5jxRdb/uC1LoroBodr61Blftw2XEHtcHsPXWIx+l0
 Vao+fzHc9yr43l5XHYh0hOOews+/Nr8oWuTsMf81ip92oU8msSx6gNjgbj284a9zkDqHzxxr0k5
 FRXI0ah/qWKGVuinEM2oBa5SeTaJcSiw7PE+ppNgrXHFfWbDAFAI8nT7274geym170VkHMuw8A6
 2T6s/U=
X-Received: by 2002:a05:600c:c04a:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-4888358b94cmr47722215e9.14.1775052933519; 
 Wed, 01 Apr 2026 07:15:33 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:32 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:23 +0200
Subject: [PATCH v2 07/11] compat: add dev_name()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-7-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=1W3i+V3HK8nbQuiQS6Y9/UsTMCP1WFM11jOshCSCYko=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGlWrOE9J3Lfmbtg1NfSzb3bYbabDPY8TOpclfb0wm
 Y29WM2+o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzk1AdGhrbPsw0+8Gi2PpAO
 iGM998+CQc1vgvcDW3WJw7ekl9ffa2Jk6F397Xsqk5T4qywmu78fGd+fTxHPbd25YurMO5Nm2DC
 ZPQQA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This function just wraps udevice->name.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/device.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
new file mode 100644
index 000000000000..e76635cfde9e
--- /dev/null
+++ b/include/linux/device.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * device.h - generic, centralized driver model
+ *
+ * U-Boot: compat header derived from Linux
+ *
+ * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (c) 2004-2009 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (c) 2008-2009 Novell Inc.
+ *
+ * See Documentation/driver-api/driver-model/ for more information.
+ */
+
+#ifndef _DEVICE_H_
+#define _DEVICE_H_
+
+#include <dm/device.h>
+
+/**
+ * dev_name - Return a device's name.
+ * @dev: Device with name to get.
+ * Return: The kobject name of the device, or its initial name if unavailable.
+ */
+static inline const char *dev_name(const struct udevice *dev)
+{
+	return dev->name;
+}
+
+#endif /* _DEVICE_H_ */

-- 
2.51.0

