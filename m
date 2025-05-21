Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0541C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FF482FD2;
	Thu, 22 May 2025 01:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pvlj2irL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1777282FED; Thu, 22 May 2025 01:01:48 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAAE82FC5
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-404da7584adso2980807b6e.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868502; x=1748473302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MFjR6kYe/JaYG5oqXBcr/s5aPiXySyuwBHki4378vIw=;
 b=pvlj2irLWtpvt3V+hMBe5YN/bQAeAx/IKmH+bfYkS7yhfcJjCJGlc4HwkS21n5LM2G
 B7BmA7/My0ggHzQ3wNjXJNeXsokeTUPnyDqaUth98tL3NDwXjj+UKhruzJwNtQjEDt+7
 hZCwEnG2E1L+RZG7KeVfo2cs4pNvWQrInf4v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868502; x=1748473302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFjR6kYe/JaYG5oqXBcr/s5aPiXySyuwBHki4378vIw=;
 b=A1W/mbHXfKjIdfRb4KZvzxO11HzMR2I+zwVEACCly4YEVj7r4ZWEYTCpq57XPB2Xfa
 MKOiTN++WIo7Bw0KfSxdTLHZx8qTyWVb+ciDZdmoFXLsUnZQ2N6Klly6ZCUE0OL7lCmF
 TYCCxrZKgfvGH2gokWCnLgwHn4RPuHY6Xs/PqH7m7qEJAZfTINiKJbS2AKW8XptLNmJk
 /JNZYWSE8KhljyAu3BwACRjdMnQjTUp3EbO4gaLIrg6Msl2MPQyBleXkrnVtupZ2gqjM
 wXDaqiHaNhu68JRon9k8sEgpguEtCQEyp7piIBwlgQ3Eg0JH/yBzhZGh3j52wfhVvvP3
 Hy0g==
X-Gm-Message-State: AOJu0YzugnK7F3rN8rWZmrqMUF2IApCcce6frhdHgFCqJZgz8pm0agLh
 9dX8j3QpV1+2PBYUtqQobmAf0fTrA91WMSZrPr10I3d81JKr6loPZPGrUs8PCVZbLFYLkfVqxmU
 lk1wLo1Y=
X-Gm-Gg: ASbGncsU4dOp2A5ncqy/l+f6p94YEGuaUE2x2nN44FjwyEg0vDF42IQQAF+sGRVLeBM
 XiF6TzNUWyykpsVXXwu5douM+p0FWkwxJ4byRbcCfF461ye5g7r3QA9t/7sE3RkyQ3YNs+Fm/CK
 NQomIkKkMSkMc1sPd3UPMdNCuvJhc6ilW1aZE8CVT/1rXCGJBUn8ALe1skoAP2kTRQpTCrW+olv
 gmGeN8bnJIBuO2caQQKOsrEf+/gGdXCwPTjVj6LAUMgSnJ9MSbXsVgHn9dcKEbXJHhcZsGvN0qQ
 3P2O+XCwzT6xRpgLXsFI+7yn04X1lpQMAzVgjcDIdkSzF+4MVAbAYM7bTRpKcaroFdvjuSP5RMm
 4s3kbiCm2j1zZeDk=
X-Google-Smtp-Source: AGHT+IGeoZAhT5vs9gR5GyEUpT/W3FCF2ZjMcDPdLId+K1iqKrR08rh0wmDNWCbXBxng/xp2Ea6Wiw==
X-Received: by 2002:a05:6808:6c8b:b0:3f8:e55c:16d6 with SMTP id
 5614622812f47-404d87fe3c5mr14695008b6e.28.1747868502534; 
 Wed, 21 May 2025 16:01:42 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 13/17] include/fat.h: Audit include list
Date: Wed, 21 May 2025 16:51:18 -0600
Message-ID: <20250521230119.2084088-14-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <asm/cache.h> so remove it. However the file
common/spl/spl_fat.c does need it, so add it there.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/spl_fat.c | 1 +
 include/fat.h        | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index f426a068ff96..8b7cafa7291e 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -16,6 +16,7 @@
 #include <errno.h>
 #include <image.h>
 #include <linux/libfdt.h>
+#include <asm/cache.h>
 
 static int fat_registered;
 
diff --git a/include/fat.h b/include/fat.h
index ca97880de12d..bdf430f70675 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -11,7 +11,6 @@
 
 #include <fs.h>
 #include <asm/byteorder.h>
-#include <asm/cache.h>
 
 struct disk_partition;
 
-- 
2.43.0

