Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47833E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 22:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3445801E7;
	Fri, 13 Dec 2024 23:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UdgM/QkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6FE8021A; Fri, 13 Dec 2024 23:56:05 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E9D80141
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 23:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8f916b40bso34355346d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 14:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734130561; x=1734735361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2Sf88O80WnPLLq1IugldXD8b+FGX75n5JSSbHxpxBw=;
 b=UdgM/QkJqkAlLaDQi4jiylQg947T15mzw07/rdI0qJMu28RPLMrHgtOpR0FzHyngWa
 XVCWHZ6CUs7lEtCpsJznQb6eOInTus+zCYTcRhvC4T/wb4EuIg6z9h65gwdQEhPRR+u3
 X3zAjQLLtvTxvrL8aYMtQYvWP0G9yfsemp7GWp02FhMQL2ga0w0O5IlZvtDTgR1AV8M5
 VK0E6BmBaPBMuJgjLHrarRty7/fw+RqKedLFexvt7rnZLysDKYcYKAzr+xd7gf4+HJSj
 TiJ9nBasXmXoUyQ2T1aAmtJZEFFaqtxXKOOH8hUxO1PKY+fw4lS7u1mQ+UUkwzqTjxUz
 TgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734130561; x=1734735361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2Sf88O80WnPLLq1IugldXD8b+FGX75n5JSSbHxpxBw=;
 b=UEqxvUOh8UeaBxBxjNzhlhpyltqaBfWCG5XEtjsTDkVTOFWvwuJ3Px5NTjEDql+P5v
 Z6aXZw7MgtR0Iyn1iJzNQlJC91coh4A74K4a3UULcbUuKdj8KlCbKpsQFb8e2nxH7yDo
 +fuCD1t8FWxEjFfoJU66lWhX6/9Xwc9/8FIHF0YComvD4loyUZPbQ9vlOtIH5foB273C
 oyxbqMkBQcMmy96bH7fEmv8TenKrlGuvahiKAxZZp9MoS7FL2GB1v5+Fy/81EScfRaoP
 pkJfGaL2dKxTSKm1tM8H1JGwB/mXL3jRIGJO2NhpLNVIPcFfhcDb28MV6t0LIbNjsQvm
 oHwQ==
X-Gm-Message-State: AOJu0YzqZ8Lb4VwrkjakXupj4g74nG5rm93VSAH35zhQOW2d4uTWH4V/
 rJjZEXG+ChxB8UFHyyVJRZk5hzQN6KfrwHwxpNbDfBXX9lp6dojXHScPLLMnrYO+fs5NFJ5tJD8
 3
X-Gm-Gg: ASbGncvPIILhkK+bGOXFTXXTbNaq/RLgT929ggmnGB6PsgnVEuQPD3NI3qf+12EgqmF
 VOsvSij3gbFbvVXh0yywtnWzfnMX6r+RUuB3EkPBefVx2bQFVTlLnY5t1+a0wUJcL6KYMy1qYI2
 YRdo2iAqX5B9x5ukeyWr9bGKiGRWngLb/8PuJU9DeC7Ru9XKFMqMFq0Jf8kf2XOVY0nnInS1G67
 zsl4cnf2I/Le3PncITe1gNwdcOb9xBbAcNB8rkZ1K1HfitoRZs7DN+4TUfknnL+vHWrtO+ZBg5G
 G/BLrNVIX3xKXI7D69X15QJhRhi8AAp1EKgLnNqj2MLTZgMFy88wdGk=
X-Google-Smtp-Source: AGHT+IGtAUzN+JbS8EIGqKHx8JXC77rW7ZAq9ky1wdXngVEOO0ni+TAi9PiwF0/0nJ0Q1BWzusAM9A==
X-Received: by 2002:ad4:5767:0:b0:6d8:7db7:6d88 with SMTP id
 6a1803df08f44-6dc8caa1257mr77217316d6.28.1734130561721; 
 Fri, 13 Dec 2024 14:56:01 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd366196sm2084106d6.80.2024.12.13.14.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 14:56:01 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH 2/2] tpm: get tpm event log from bloblist
Date: Fri, 13 Dec 2024 14:55:40 -0800
Message-Id: <20241213225543.392282-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213225543.392282-1-raymond.mao@linaro.org>
References: <20241213225543.392282-1-raymond.mao@linaro.org>
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

Get tpm event log from bloblist instead of FDT when bloblist is
enabled and valid from previous boot stage.

Note:
This patch depends on:
[PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/tpm_tcg2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 7f868cc883..acaf0acb88 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -19,6 +19,7 @@
 #include <linux/unaligned/generic.h>
 #include <linux/unaligned/le_byteshift.h>
 #include "tpm-utils.h"
+#include <bloblist.h>
 
 int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 		      u32 *pcr_banks)
@@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 	*addr = NULL;
 	*size = 0;
 
+	if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) && !bloblist_maybe_init()) {
+		*addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
+		if (*addr && *size)
+			return 0;
+	}
+
 	addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
 	if (!addr_prop)
 		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
-- 
2.25.1

