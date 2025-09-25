Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B12ECAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75630835A2;
	Thu, 25 Sep 2025 22:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pMqepZCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB2A833ED; Thu, 25 Sep 2025 22:51:31 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5188349B
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-74542b1b2bcso1190842a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833488; x=1759438288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qr39/Y2A0yZqCn8PQrboQKEdldZVDHbaCQ/UOcbTpLI=;
 b=pMqepZCuy8s+W6sEb4RIK2nzUP+v851HSRS5FZpQkKYCKcudWFwkdAfOXtdLStXBBC
 3o6J6HrgYKwYl4Ov/CPvyHfjDiJ1tRr3c1rX5IloL2670tbNLbbI7xeQlkFNwIMKdqcf
 lvXSfynvwKhWPjf2EPdyUD7l0svoH5fKUt7lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833488; x=1759438288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qr39/Y2A0yZqCn8PQrboQKEdldZVDHbaCQ/UOcbTpLI=;
 b=KiczOoSkkJSICNJSvGsm1DNvuqUoRYDxGPXjCyRgDpMqIJx4apUWDJ2/kxzSQxskNS
 xCx8cxZTg6HU56kcBaGskCRpjwttDEJShrjahRwUKFE7Zk0BmGDwDx/rajYCmgDTIIgd
 kPMNBGxx9eZJbXIk1reqOqD94DKwp8Xbz3RHzskdinXvgW818cJyg4b92OO5rCV9Xot1
 q0ixGMvNULCSc8gNvsKFt0tSR/vlPpF9v+2ThhcXmK/OWB3DBeBTllpAGlRAqvEmPsKA
 alk/mqn4vWmQOmTPnEVWtlIr5Gx+PUnv8EV7rvj2diJGOxNZ6zCqqv2flpw9c3YTi2af
 cc6Q==
X-Gm-Message-State: AOJu0Ywd3mdOTJ3cWcsrQk7hayWlycVTwTIrMxOXmN0HqEwBTFkx+nu0
 YGIviTGq+L7G+RSIeUhnNsSUG0y4WABrgvW9BROCol1wcOtOyjzQ90I2dwJ38WlTntLrwbRQFkE
 FokjzB90=
X-Gm-Gg: ASbGncv4f7rH1g+ZVfG3E7SswSBR2PhSWUTSRJ+FzcjRDKx+cGWPp0jHR0BiEIkuI/v
 b9NhSrIVxv40kxK1iIzrftqBDNbs1isbt7gqrChP8V2LEDR6fIisTaJsIe/cRlTAjaa4AENhmEY
 gwmwyGNxNKmIIYI+A7kv7I5vRfzAuUry85PP1YGnfKfBl9LEzVbkJw319AUAkoQxEl03MaXo+Xj
 UJyIZMbPCFwESLBzNhWTGmn2cVptXPkMfT/9LqPg+Vo036DTxhDAomCSeTIO+jvGB4ubweTyM8L
 A6ZttKGGsABBb4HwirGLAUvajqD4qu+DqFMqPq/sIHzLsz3MFKEbqQ9KQmtqUb2Vdy/Yb8s+bF4
 ntIWbK69DO+L5238915sd5c2rKCYxkwLemivbrUgj7Laay4pDWj9sNZNP4pI=
X-Google-Smtp-Source: AGHT+IG8U3c6bf7H+Q2qmfsZUjZCdzGyBSi8PJYoXIRVdGcjVmbnYLKbin85BS5tx8JS6BJk5uX1HA==
X-Received: by 2002:a05:6830:700c:b0:757:b8ad:c2ac with SMTP id
 46e09a7af769-7a044fa2326mr3634610a34.17.1758833488515; 
 Thu, 25 Sep 2025 13:51:28 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a7d7983a47sm174457a34.2.2025.09.25.13.51.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:51:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] NXP: Make RAMBOOT_PBL only be valid for PowerPC or ls1021A
Date: Thu, 25 Sep 2025 14:51:26 -0600
Message-ID: <20250925205126.3561919-1-trini@konsulko.com>
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

Only PowerPC and LS1021A platforms can make use of RAMBOOT_PBL. Add the
dependencies to the symbol.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 780889023e10..eff05948b3a1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1093,6 +1093,7 @@ config SYS_RAMBOOT
 
 config RAMBOOT_PBL
 	bool "Freescale PBL(pre-boot loader) image format support"
+	depends on ARCH_LS1021A || PPC
 	select SYS_RAMBOOT if PPC
 	help
 	  Some SoCs use PBL to load RCW and/or pre-initialization instructions.
-- 
2.43.0

