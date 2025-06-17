Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAB2C7115A
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BC682CBB;
	Tue, 17 Jun 2025 12:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TqkZvvie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E009680C83; Tue, 17 Jun 2025 12:07:45 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD6C82B20
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so3057705f8f.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154863; x=1750759663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/ySdy1n6AgDC7NIfoWPUsAgLrYrc7+o/jJcNrR0Sb4=;
 b=TqkZvviegCv6LQ0BVPAMmy337HLEsO6H3bVqGvhKzJ+ZVPvbtQ8419o5wy+0FL4f0R
 sKWW+2HvsyArrnMCjcOOaxlHWkgjMrdhB+W02ONxjRlczOjtVivieKSZlLZMDh8okESg
 80SSjINEp4roO8Te8S/AZ5YQ+wp4uZMe4uJqP4A3dMGeCArpnAMNUnxPYyBeOiRHYTRX
 orZuUOn9teg0xV0tJeX8S8EHpwrXDfPQGTTaGcL95WyYNK4HZq4SFyj97nMQwTQPu4or
 bt2jzUv1ymSpbBERnfKGXHniEXzDcBcio1tO0FGksOHhzWI73+xU+FMb097BELkXIzed
 18QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154863; x=1750759663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/ySdy1n6AgDC7NIfoWPUsAgLrYrc7+o/jJcNrR0Sb4=;
 b=qVMgbIhwTZRnpgHvbRQ5S/iafgy1chc5l7RM7M3ZZ4TXMFt3wBVf30zNiUk9RqKfEW
 sQGPRWa+Mu99Qqx/qFT0qLphx05bf/s0FZyyNAWcRuU/ejdbDkHmmNlmZswB4zWAsyE8
 bzedK0W7elKihXVWPrrlP1J0Y649/GSOeelJlcamOIIJ0dxYv6sK2rgSfIK5ohwtNX8x
 TkTht/ze2MvdkLy8pHcMPWMZlwd4SJYe3vHl5M7YN8nsliL1YPn/mAW6KmbsgRXwutHg
 k320bow1aRDzMacxOA0Yl5rk3ICkqS6i6NQE3NLMAMNAkOUvZKiRBFGO+7pEQ8bTQ78u
 SAiQ==
X-Gm-Message-State: AOJu0YxLX2rtn+ucYFB/iXeC62alAu4RsiW17rqca7jicuujWr3RlF70
 pp5V81du2RjI0Bynw7MW1FagZX/pVUrIhyVGuINRhxpdylV3P7316jjzjQhxm46yz6kMB5SQJqD
 3RvxT
X-Gm-Gg: ASbGncvlBBQIXIBuZ7r31SDkHau4hcyWY7aMVHfxdiZ+4tbUU5p3SMS1d5ZAWcmMwuu
 8b3lFPs7/7m7RGSe4Nn5whgLb3rYFk8ffvCFGB8rJtfQvll3GKsVhq8qTgHEJavVKL0Cx55Ju66
 0/RWKABs5RRw6lUExga2Fzd/wzcWhqyxsR5/BGIXcxWLvAnfkqCdlFq70FbV5HZMlcpn4HmvYw7
 aGKxfZUa8gMv5rWh/UKmEvsggVfamVcyf3JflSnuRC4xOSDJ5lqJRzEAbckZ9/0zAkMyvvXN/Db
 GN6ZOobSHjFYGlS3o6T7C9Mm316ygtD7MMiicIE2ZssZuDmJrytWVgHtI87RdgZ5WZPGbyc=
X-Google-Smtp-Source: AGHT+IH7uHW0JAgxsIL2EAD2T+fYsHdOt5Y1GSnQd3RZVoHOVnMVZ2qyVtuU2TvYv8AQgGEjrPcrGA==
X-Received: by 2002:a05:6000:1887:b0:3a4:e393:11e2 with SMTP id
 ffacd0b85a97d-3a5723a22d6mr10853294f8f.34.1750154863177; 
 Tue, 17 Jun 2025 03:07:43 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:42 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/13] lwip: remove net/lwip/eth_internal.h
Date: Tue, 17 Jun 2025 12:03:51 +0200
Message-ID: <20250617100720.2544758-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

net/lwip/eth_internal.h is not used. Remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch

 net/lwip/eth_internal.h | 35 -----------------------------------
 1 file changed, 35 deletions(-)
 delete mode 100644 net/lwip/eth_internal.h

diff --git a/net/lwip/eth_internal.h b/net/lwip/eth_internal.h
deleted file mode 100644
index 87561d5b214..00000000000
--- a/net/lwip/eth_internal.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2001-2015
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- * Joe Hershberger, National Instruments
- */
-
-#ifndef __ETH_INTERNAL_H
-#define __ETH_INTERNAL_H
-
-/* Do init that is common to driver model and legacy networking */
-void eth_common_init(void);
-
-/**
- * eth_env_set_enetaddr_by_index() - set the MAC address environment variable
- *
- * This sets up an environment variable with the given MAC address (@enetaddr).
- * The environment variable to be set is defined by <@base_name><@index>addr.
- * If @index is 0 it is omitted. For common Ethernet this means ethaddr,
- * eth1addr, etc.
- *
- * @base_name:	Base name for variable, typically "eth"
- * @index:	Index of interface being updated (>=0)
- * @enetaddr:	Pointer to MAC address to put into the variable
- * Return: 0 if OK, other value on error
- */
-int eth_env_set_enetaddr_by_index(const char *base_name, int index,
-				  uchar *enetaddr);
-
-int eth_mac_skip(int index);
-void eth_current_changed(void);
-void eth_set_dev(struct udevice *dev);
-void eth_set_current_to_next(void);
-
-#endif
-- 
2.43.0

