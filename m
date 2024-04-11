Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6D1CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 05:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA91987F6E;
	Thu, 11 Apr 2024 07:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="VjXdxbpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 859E787FED; Thu, 11 Apr 2024 07:16:54 +0200 (CEST)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CDB87F52
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 07:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712812611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DWMnMCTR0ngZSaL4TK+zK3N8eLb1jwZT2InrkG1A08k=;
 b=VjXdxbpt/K+wm0LtBIeOOAN2boAVNLQ0B3K52bAitXge80XRANyNWkr6D5bfpER5JwjN09
 5TpjgmmCG2f8p+x++dRXL+TGK1z8zZedMAdYN+jPpq505NxIbdEOFp6n88pGZ1BjfDWURT
 qAMWCcIu9yIYHtFoQmzsWpDIGcRvdNGGa+3q/cxKa5TnBVcQ2xBQ5EE83zXxzatawjLcIg
 tdOZoWjZSY2vJTOCbNSFPFz5hUwuhZFoGPJaHI2n29TDiZB4vM5WGtlDOCm7YxMMpaeMpJ
 jZeQapziMeIScBq43ARWl5tv7ONm7sdE7JzspCWfBihLyF9atvS3bdBaJZVqNg==
From: John Watts <contact@jookia.org>
Subject: [PATCH 0/2] sunxi: Support UART1 and UART2 on the T113
Date: Thu, 11 Apr 2024 15:14:14 +1000
Message-Id: <20240411-t113serial-v1-0-41ff858a1235@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKZxF2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ND3RJDQ2OQnsQc3USzVMvkRIsUCwsTCyWghoKi1LTMCrBh0bG1tQD
 /bBYeXAAAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712812467; l=704;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=P/kvU/lEw3q/HCOqlgobogI+sRJn7aoVpOEP9hOAVu0=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAsfTTp89pBDjvpAX0UN92xBT
 AQ96Kh5QQIcsSVBCemjQpJqt5M/S9IyuBk5Tf8SPVVBQqELuEvg0z2Y4+3FhCDwUAAOmi
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

The T113 supports UART1 and UART2 on PG and PD pins respectively.
Add support for these in U-Boot so we can use them.

Note: I'm not entirely sure if the PD pins should be default, they
overlap with the LCD pins. I am however using this on a real board.

Signed-off-by: John Watts <contact@jookia.org>
---
John Watts (2):
      sunxi: Support UART1 on the T113
      sunxi: Support UART2 on the T113

 arch/arm/mach-sunxi/board.c | 9 +++++++--
 include/sunxi_gpio.h        | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 777c28460947371ada40868dc994dfe8537d7115
change-id: 20240411-t113serial-a6e9ca8d8848

Best regards,
-- 
John Watts <contact@jookia.org>

