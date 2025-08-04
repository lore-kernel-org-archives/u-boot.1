Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B761FC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567718403F;
	Mon,  4 Aug 2025 23:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U+/ntarl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679B283D40; Mon,  4 Aug 2025 23:57:34 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A730983FED
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3e40d16e218so31274485ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344649; x=1754949449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A98y+Q2OyeieeMJ8o5oICuIhBlbgyoQzaz2/aabsbrs=;
 b=U+/ntarl7Vms3fc9a8grCtr4PCQLfxXjoxqOIRvT5NkguizjZGGkhkJMv+F7/0O7Ts
 ucfMWzC4XzWhbGFhtuF8nuhgnHC/PMrlH6TDCDujO+GXMD2Fic3Bve+O2Rmpej00ph1Y
 2S2rMj16cpM/O+s5t7jd4YGbSrHFk0xLx0g5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344649; x=1754949449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A98y+Q2OyeieeMJ8o5oICuIhBlbgyoQzaz2/aabsbrs=;
 b=GHR/lozfxOlslAFLQjQSKzJDVP9wOzhy8fVD3uegyfSRF9VdThkjMycdGxL/woWcMF
 WKhEMZ0ndKS9QKrGoTbT7h6pdjP2rxgb/1omyJcC/fap5KSjhR6UPbLkrhqzzZ7z2ebX
 +22vt/Y4xdwbBdLhl/BZgjNi6J/ErdCnLu+JYSnYUaU3TJE1RdbSOMY1vGGR63NpjDay
 iT6Z4r2teaMFSFVeQhWhtvprmoTju8nLmp4/YCMmRjSt4dtbI7ha+Z4CB6E/wYMZjErd
 WPfOUaXdIklELS2shmLhF5yLQBFv+KSfwSZNs0euch65m4kOc3panuHG3xDqbcmJi1ZG
 3ayg==
X-Gm-Message-State: AOJu0YwcN558+4UUThaNnCSB1cMdABKuqy0Hr7Z/8Ml494EcDsWL2Cz4
 HSprZYfmT5ezQ2QZK0Uqp1QZpvvhzUHsOktVDOXI1D2jc9Ormxzysvs0DzpIYXgpTGRdqmUAzqb
 y35QuxK0=
X-Gm-Gg: ASbGncs6AcUedKozNgJSbTGgbO90RpzrxJTd/Hpm5OEvIIIKtl5KcZKC5NAsHmXblL5
 KlUCBqbtWiCnHnMd5d8sAZ90bt4nCulfgAoek6VHocl6mawxUlT4+2LhhtxIP4t/JpeHvs7hQKm
 RZzNTJLTnhLb20nggJ/V0g8XcVNCgaACOwe/zOkaDC4CofDiliNS0FlWOE6afWlHfGyb9F210bm
 M3JMN0b/fu/BL2vojjQCcpj0uSK5R3L+koSTvkZ5sT58FihMtT5mruzD8LdxlzN8pKgo+bDKzUX
 aZOvOzb8IIYhPsPbwIZbFLuMjyzJICC8mcz+Yc7tUrKnhHhYlXe2VvjlnyT7YGZkX20NwAFYosC
 mZyOfGrPyt64erJIcmr4NAuXD20qEdp/srS1vjluW8q8PRktx8N/V+5o4rU6XIuT6rHvt
X-Google-Smtp-Source: AGHT+IHnQufWMeWY2g36Rrjhhh9Ue/HuvOtC/EdjtK18zLYRDDi+W7c1vJcyb8nXzNy+QLvA0oPH8A==
X-Received: by 2002:a05:6e02:2513:b0:3e3:c356:f5a6 with SMTP id
 e9e14a558f8ab-3e4161c842fmr180741305ab.17.1754344649376; 
 Mon, 04 Aug 2025 14:57:29 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sysreset: Tighten some sysreset driver dependencies
Date: Mon,  4 Aug 2025 15:57:19 -0600
Message-ID: <20250804215719.1413106-10-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215719.1413106-1-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
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

The MPC83xx sysreset driver cannot build without access to some
architecture specific header files. Express that requirements in Kconfig
as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/sysreset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 67edf004205c..0181f6cd5819 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -283,6 +283,7 @@ config SYSRESET_TPL_X86
 
 config SYSRESET_MPC83XX
 	bool "Enable support MPC83xx SoC family reboot driver"
+	depends on PPC
 	help
 	  Reboot support for NXP MPC83xx SoCs.
 
-- 
2.43.0

