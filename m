Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA88C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E6181DCC;
	Wed, 19 Mar 2025 04:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354361;
	bh=6GW+8T62/wMpdX73faY0Lkf38hRZNfz5ZToFYuCnBWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OS3ZLM/8pdRCLkBlHXgk8UWcYxHzVoa/t7+5qLJi6MpR8n6FJMECnJPS0ymmlpcq3
	 BUtjPf2nasd7xTJxWNvL1KPVBEBv/pfK6uEprk1G0WFpWnsj/7uoaaoiiGW0iCFSr8
	 UJso09BFsc44ne7cOAkM4LzZ1aDTlxRfL4cfG90bkE/0AQtWsRXvzAGIhXTAdJVZ//
	 QpK9ZCLAh4A7+eEf14Vf3yJcWlgpDltKJta7s2nBnyB/iT9gdWTkZEqFNxE/jFNv4j
	 85tLkTm9TLco4uHzq4K0647DOa2YIKYdIvU+ZSwyUCQ2DALGA3xysNrGLJlrZgioBv
	 ARC5myLWFn8bQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1853681A04; Wed, 19 Mar 2025 04:19:20 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11FCB81026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Y8fYsw/S"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AF11B101E91C3; Wed, 19 Mar 2025 04:19:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354357; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=6GW+8T62/wMpdX73faY0Lkf38hRZNfz5ZToFYuCnBWE=;
 b=Y8fYsw/SZSWs0aMrsC7vFJ9o0J6yQbu1fZQCXIkKI6OwZm4h6GYzzjh27GMSxgVnjpLPCQ
 OWxh2tKit2ak8y9KazxakYxqBN5QBClClHI90YCvNp22d0XQD1ZACu3tBHDpbx1YXTcFPL
 HzWWSBhRF2xtwOYTXOhmpqoDYsZ1nSI1wvrIuuD4IwSz9BCafXVFjsKxsLzqKnTv+abPYw
 w8FhDHYg8MlNcFHaAnZnzJ4A2b8FLXgr4/4c+QTBs9qZANoLoKY/UVdU0jLR4AZx8UoF/0
 ICAoaA6ow3yPcSewkYwnm6+pQoMN4FN5Vf/TtTkKfW+5vJdyESV3zxwxwrDo4w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 03/24] clk: clk-mux: Use struct udevice instead of struct
 device
Date: Wed, 19 Mar 2025 04:17:13 +0100
Message-ID: <20250319031852.233537-4-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Use U-Boot specific struct udevice instead of Linux compatibility
struct device in clk-mux registration.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
 drivers/clk/clk-mux.c        | 2 +-
 include/linux/clk-provider.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 9507a779525..e2331a07840 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -159,7 +159,7 @@ const struct clk_ops clk_mux_ops = {
 	.set_parent = clk_mux_set_parent,
 };
 
-struct clk *clk_register_mux(struct device *dev, const char *name,
+struct clk *clk_register_mux(struct udevice *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 59f9c241b84..f27878ae6fa 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -242,7 +242,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags);
 
-struct clk *clk_register_mux(struct device *dev, const char *name,
+struct clk *clk_register_mux(struct udevice *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-- 
2.47.2

