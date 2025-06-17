Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA2BC71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F6B82CF4;
	Tue, 17 Jun 2025 12:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PhiUrv9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 077E582C87; Tue, 17 Jun 2025 12:07:48 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F9580C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so4642355f8f.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154865; x=1750759665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcXN/O0sngamvLKoUvDh3jJG0AbZo2sR4TdOddPYPg0=;
 b=PhiUrv9JRZ9/ltrsR6GcTLc6sFcnnFUo+t/UkxYVMAC2dg243Acx/xRu6jhM78AIqr
 gA60fX/6AuiE2TXdpgB3QxQGZaleQoNGl63uYVgDD4tK1AqvcaV11RHIMXwLiajKDu+C
 0RTmVuoRi5XLyZf1oMHciq5JyolcQfI/64ut+cHZOFiPfbPct1SoxtEbxwulCMnZxjeq
 DgjW1Xm16dfDZOyztkAJP9+w4mnyDi8jRJQY9XrmuhTP5KqafrNhnLz22lunppgCMNWq
 Z5qw1AWAyZM0fPF8b/uitF47K7M2PUXIMyxDN+ZTNGqLpS9NXIMfYm4ny6M8IjskEWez
 +ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154865; x=1750759665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcXN/O0sngamvLKoUvDh3jJG0AbZo2sR4TdOddPYPg0=;
 b=qmmheS5hZjYb9vKlzMx/mwf/rQbqRnsYuEllxlMkO4EN9rvZnw9q8ILroKv+6QG6Cp
 S9HusV6B63xK0P1J9NZC5+vh92vCF4MmTtG0jlAFbebzdUTrMbM9fzS0Eh3b7AVWdFJs
 79cTe/vBx8m7axJgjm3z3mebW1sH6ofJy4+v6vWK3j46pOxGSkEmnpj8Ej2H7v6glQ48
 zU0uR9sbqF13lWpT6nE7nVXB5QeYkXsfHZEx4b2c2S0W0xdcEPF5vMVuoAQZPBJ/yWz8
 vy6cfQPY+xtsvBozVhIsfMOEAgCDYVKJCsHJ+nUd/dY3o9sh23dJ7zcN25DJoI3qlVwz
 ni7w==
X-Gm-Message-State: AOJu0YysllkVTqOqRNzxnzefws5KfHplRhdmwt1ZHyxo3TzqnnJ5J0rv
 fM2e2sJfbShyckRBnhNXl1zg01LnLlmk/F5X599uG/oSW61m6RHuF3aw0EqeAijNDn8PtNe6zs0
 GGBEw
X-Gm-Gg: ASbGnct/t0j0ZMtFk0jBRjnwPBXLrmVoyP83PbEDal9+k37SZrwbLduzUNzFisZemHh
 FIyQJvVbUo/RqkOhrdkh4PUx/nZFi9g8lEsd5RRld3149AGigf7tNJSFvDbBQZnJ2NTJSVTK2S2
 A3Tq2GsX9WB2oIhq1uUOskD7aY8UD6EoNldeVF/tsAD4qV30eZyuCfhx+LpTiwAh1i5ZOCTV+mO
 Z6wbgU/8kM9+tb2oZILaMejCFhaRHWl9l4kcS/wzisMD2PSk3ijf1hcaWEOCrYCL6MxN560FVuK
 aULE8LHdj0WnwosU854OlyzTuggbSP9qEDGj+HESc6g1p3YHZzZ0TUIXBuS5wcuBQFilF5o=
X-Google-Smtp-Source: AGHT+IHdoKl4FF4ZsLYhrI+c8ufZNztTkT23bvnaw/FSttSfqWpS2izSm2WaRLNNlXYz/LFcXezfUg==
X-Received: by 2002:a5d:5f8f:0:b0:3a4:f439:e715 with SMTP id
 ffacd0b85a97d-3a572398eb0mr10700916f8f.9.1750154865176; 
 Tue, 17 Jun 2025 03:07:45 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:44 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/13] lwip: move net/lwip/ping.c to cmd/lwip
Date: Tue, 17 Jun 2025 12:03:53 +0200
Message-ID: <20250617100720.2544758-4-jerome.forissier@linaro.org>
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

Prepare to split the ping command from cmd/net-lwip.c by moving the
implementation from net/lwip/dns.c to cmd/lwip.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v3:
- Move this patch before "lwip: split cmd/net-lwip.c into one file per
  command". Drop a change recommended by checkpatch (uint16_t -> u16)
  which would better be submitted separately, since the purpose if this
  patch is to move code around, not to modify it.

Changes in v2:
- New patch

 cmd/lwip/Makefile        | 1 +
 {net => cmd}/lwip/ping.c | 0
 net/lwip/Makefile        | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {net => cmd}/lwip/ping.c (100%)

diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 6c4ab58d06b..da79b64b5c2 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_CMD_DNS) += dns.o
+obj-$(CONFIG_CMD_PING) += ping.o
diff --git a/net/lwip/ping.c b/cmd/lwip/ping.c
similarity index 100%
rename from net/lwip/ping.c
rename to cmd/lwip/ping.c
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 255c7d018b0..97299d9b542 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,7 +2,6 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
-obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 
-- 
2.43.0

