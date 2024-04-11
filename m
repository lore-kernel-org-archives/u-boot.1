Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD73DCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 05:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F1C881CA;
	Thu, 11 Apr 2024 07:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="zjWHCWZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9686C881D6; Thu, 11 Apr 2024 07:17:10 +0200 (CEST)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com
 [95.215.58.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B549C881CA
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 07:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712812628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Qxil1bnFkUeSyDkfIuK9Z7fhMpknNsiBwNHye1rBJ0=;
 b=zjWHCWZYwJDfIvUY+1Xh3P6NoQvdKm4ogRw+WQ1B3Xg5dF7E4+FpFrfx/y0FfbcSVvvgDr
 ZUccSy14IxEQLbykZUlxccl7tyExjXkRVJY8wrzog+G6DxUcTYv36yt9/Tn+Dvi1bpnUXP
 ouSiZmzQxQWg3EXwI9dB3vV2eOiY8n1K6LHA9OqQEaF1N1rUbPgDcopb+h5OhZkpsZFsv+
 /geIFi6iMLaijcR7okQ8p0JN9lLAnlkMDDlT5/3r57wdt+2SguUZ4aCsKw0x22ixiAxfce
 9eESi/61LSBDSUvZir/9yUxtqeVP/vQMka+hoSjmxgduFjQup/9znbTfoJAAIQ==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 15:14:15 +1000
Subject: [PATCH 1/2] sunxi: Support UART1 on the T113
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-t113serial-v1-1-41ff858a1235@jookia.org>
References: <20240411-t113serial-v1-0-41ff858a1235@jookia.org>
In-Reply-To: <20240411-t113serial-v1-0-41ff858a1235@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712812474; l=1061;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=+FUlr9TN+kfwRWZPs9WSWNK7/SvPA9B8x7vV9ewyQZc=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAwUud9Ma5JFQ0AsT/OFFv8ny
 NyKATfmhgdJ3EiexBc5UJWChxGWWfDrdxriJUd6dA5L8JmNxIMHj3L93irTMMCgUAAOmm
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

The T113 supports UART1 on pins PG6 and PG7, add support for it here.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/mach-sunxi/board.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index f4dbb2a740..f5da50b43a 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -174,8 +174,9 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(2), SUN8I_GPL_R_UART);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(3), SUN8I_GPL_R_UART);
 	sunxi_gpio_set_pull(SUNXI_GPL(3), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN8I) && \
-				!defined(CONFIG_MACH_SUN8I_R40)
+#elif CONFIG_CONS_INDEX == 2 && ((defined(CONFIG_MACH_SUN8I) && \
+				!defined(CONFIG_MACH_SUN8I_R40)) || \
+				defined(CONFIG_MACH_SUN8I_R528))
 	sunxi_gpio_set_cfgpin(SUNXI_GPG(6), SUN8I_GPG_UART1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPG(7), SUN8I_GPG_UART1);
 	sunxi_gpio_set_pull(SUNXI_GPG(7), SUNXI_GPIO_PULL_UP);

-- 
2.44.0

