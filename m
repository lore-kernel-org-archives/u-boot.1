Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7889AC02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114218076E;
	Mon,  3 Feb 2025 10:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ruEcw9Tt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F3F807E1; Mon,  3 Feb 2025 10:12:15 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1604A8076E
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-254.46.114.pool.telefonica.de
 [46.114.108.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B219641EBA; 
 Mon,  3 Feb 2025 09:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738573931;
 bh=LtSevCMQNVU3u7ViI2HW5xUWx73FCLC0SwnxRZmuk7Y=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ruEcw9TtK4UUenEkVbz3fJEK/Q+CUP18Sn5i1OvLLtmc1z2F7tBR+OKsy3bgZC0jP
 HwdiMsYYFahVhaNJcHFFnpj+muGigAqzCegQ0l6z2bcv3OhTmzqpowRL+qt+cOH26A
 C/7Ue1wGV7T17bnZgVbfso7M72T3hEQgI7ZxRbXjRyLPvX+sbKfyttyCPZWVhVV54J
 MrBRmvw7bEfzGFmAMhFWruF5S1jzTRX3Bgu1PQnngU4rhbmVrUgXhUEK0eHWyYtdlr
 b0eSneoJXF0cBJsC+eXDRL4L1B/SmeMR+MOrkRc84+Hk8JfbgVXsvPmGlpnbY/mGgT
 RlR0Ur7r4nQCQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/4] net: use strnstr() for lwip_strnstr()
Date: Mon,  3 Feb 2025 10:12:02 +0100
Message-ID: <20250203091203.47590-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
References: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
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

Using strstr() instead of strnstr() creates a security concern.

Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---
v3:
	no change
v2:
	no change
---
 lib/lwip/u-boot/arch/cc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
index de138846358..6104c296f6f 100644
--- a/lib/lwip/u-boot/arch/cc.h
+++ b/lib/lwip/u-boot/arch/cc.h
@@ -34,7 +34,7 @@
 	       x, __LINE__, __FILE__); } while (0)
 
 #define atoi(str) (int)dectoul(str, NULL)
-#define lwip_strnstr(a, b, c)  strstr(a, b)
+#define lwip_strnstr(a, b, c)  strnstr(a, b, c)
 
 #define LWIP_ERR_T int
 #define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))
-- 
2.47.1

