Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7111099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B8FD8413A;
	Fri, 20 Mar 2026 21:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eOLGUXvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48FE84082; Fri, 20 Mar 2026 21:53:51 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 815928410D
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d75ed779bfso1862854a34.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040028; x=1774644828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=48qAtqSUoNnZGK5UW5Cs8pwJ+KePIL1y6v64xjcsiws=;
 b=eOLGUXvEtywZ0K7gAidjfXjedD7fThSiTRKSSL8wO2TUxnLypmy1px789DD9F7aGXr
 /UFgOrxuOZ3u/On+XnK4D2e8DDEQjIh9fSkThlOYWM5sszb1JBnubzKsJ2h+teA1e2NF
 RQfNjHVY8ZriNUhDluCO0vHfMV7qnKIgtz2b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040028; x=1774644828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=48qAtqSUoNnZGK5UW5Cs8pwJ+KePIL1y6v64xjcsiws=;
 b=EoowIoobwLRajxfydooZeX9DQvqVVxpNSAOqrKEh2Mzps2lOXz9ln6teIKtmLEUQRQ
 sFI7W3R1n6pTM89U+3y0l1LvvhtFELhuzCJa49UgRToVG5+/d4M+g7oTrR+lyVRLiHmp
 TKaP5kVf1KGx7J0SjZJRi3lLISf4r8Jx4kXCysaQ5MFS5uU0RgAkKMOHMqcZ2Aj67JMv
 nVve6lgFLTjbi+FTLx6J9BBwl2XXuXpMFzC1PN5URreZwblajIdihRFTJfVuyBCC4zx1
 /Wcepvme3BDEY1QhaOV9LI9dAnzob7+EZ5r7M5g4SlLWLkhAkzQuV9CTNlkaVQwxkLiN
 tT0w==
X-Gm-Message-State: AOJu0YwKzKFDKx/jjfeqVYVbFM8YB9g/+Q+CU/ZGAdL0MwWRrYSh/tld
 rLDVkwPxj6HoRllwsWnMY3zVUZDWPJWLUOE95TlvQ1uG6Wge4xIJMw11ALOkYjCiSNjrBamBiKE
 f3evfolo=
X-Gm-Gg: ATEYQzwz9HCCSpvMLsU0JXUpci0H9b/Lvtx4+oNr4HDTMDigJ6HAk8LrXIoUqFT9gh7
 +fsjLat2p2j3C81/LqnVTURK+B1P4kW5V92AiQWTaMhazD2D0xl1GpUdqzULqU+M8iqZKPTLrdN
 ZXMensSNgZgNAOcZ6z1moQSQwX1/Xglvbqw8ThtWnf4aq9mpASzOsYS05S9N7D55zRRTmMp8OYx
 efSzozzBpDJx2Iv4UzuN8oJTReZ5Epj26Iz3nx01kyt6DzJe6BxKTYfnhbgVG8gbYHJYnMIgIsv
 Cg9gJSNe8qiINRsVJhPjKq7zefWVfJ8jXc89bXcbdGNXi+L9Gi31655Zgr65Ffy21jujZeRUGdf
 2VzulkWbSOi89E+4EKpToxkBPyTcdIlZ47xPhacsx5A8dESeE7El23qHuf5DYhmAHe6lF8RwUep
 WYo0ihC7g/QcVo6cHLbJ7AxiOaZUFJX45HZufcxo7MBXkVBCj3C5SU1qGzdRPCYXbkKi+4JVKxg
 Qcn0XFB8OZ2CUbd1c6nC1HhLXRG4/anE7Us90SZKDN2jnmfTMI=
X-Received: by 2002:a05:6830:6f83:b0:7d7:cc53:c457 with SMTP id
 46e09a7af769-7d7eafa6482mr3003771a34.17.1774040028265; 
 Fri, 20 Mar 2026 13:53:48 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac1747csm3052081a34.8.2026.03.20.13.53.47
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] clk: Add missing dependency for SANDBOX_CLK_CCF
Date: Fri, 20 Mar 2026 14:53:46 -0600
Message-ID: <20260320205347.3789062-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order to build SANDBOX_CLK_CCF we need for CLK_CCF to be enabled, add
that as a select similar to other drivers.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c88931c8ec4d..c2da7b3938b6 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -185,6 +185,7 @@ config SANDBOX_CLK_CCF
 	bool "Sandbox Common Clock Framework [CCF] support"
 	depends on SANDBOX
 	select CLK_CCF
+	select CLK_COMPOSITE_CCF
 	help
 	  Enable this option if you want to test the Linux kernel's Common
 	  Clock Framework [CCF] code in U-Boot's Sandbox clock driver.
-- 
2.43.0

