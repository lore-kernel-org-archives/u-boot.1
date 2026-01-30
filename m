Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6815DD73EB6
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 03:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34F28418A;
	Fri, 30 Jan 2026 04:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D7Y8OX9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD638413A; Fri, 30 Jan 2026 04:12:27 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B63C8413A
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 04:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso1151408b3a.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 19:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769742743; x=1770347543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WG9bLYeZV7zoJ5m5HM0Ma0BJ0T8dQZBHRqNOf3NqokQ=;
 b=D7Y8OX9RqaWRerPjagD4sXSxQ428qB+VszkftPTBgMkBa676BZJVpUaagVCkDM0+38
 cC5PwOQIf6/SvXhIzg/X6uKaBxcrCqHTz6T/ex1Zc2i3zcAB+qawR6VDRGGOr/RVyWAm
 YA9FlyJgfnpUXCgBTlKLLco1oNOdqUVniJsZVc1wxM27QfSs2qe/yUSuqXlBz9AEVIwC
 lOPJNFToBnE7DTAQjP0Yx2FXE5WwM0TNoqZj9rWk5lrNh1Y6HKkR/1v3QEf1WtzGxxEP
 4qv4tMyzqH2icRGooTgihBA3k447sdUUNuxVHV6CVX4YHH+ckpyKYNtrrEimdf8PEfdG
 uTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769742743; x=1770347543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WG9bLYeZV7zoJ5m5HM0Ma0BJ0T8dQZBHRqNOf3NqokQ=;
 b=EKrrWNx6o1tCOvmlSi2YJjixe/3rYcHcr9MqhREFT8KFa9rM24zlWswg/G3e+P0fp3
 P+ED10jzlZQiO7yY+xeMoQsa1EyaplE+EQHideE690Vou3qVFeq4eW8eEfLwBFpw7sMA
 xnxGuwXAYIX1XElS6UYjhj8lp3vxqHwesDfl/RwYnX20pVewveEabTrpF0t70Ht1aZ1A
 s7fQibAEXJZLux9EBQsR3+1bWq8jSo+9ODCZJHmsS6pJdLZUof9gyQSN6pI+XELZWCPu
 eKYNp1MAaexHskFZtcCpCBYSH8pY+lZFM0wXow1HGZGIrb+uZeCcviW26oBLrBm5hK6V
 bhtg==
X-Gm-Message-State: AOJu0YzA+bNASD5fluk1sQx2MVYB0/Bvo6kBheWQWqqKLu/ehubUmd6r
 vgANIKZau71lEyNyL6GX3iXG1anhRv99aupSQoH1IEHEg1HzvWMakI/OndqDqPsIPtg=
X-Gm-Gg: AZuq6aJ7PLb7cNk672bz8CXzvtF6HCL37FwAf4KD2cmH2gjWmDENsdlVQaW51SEe81H
 L+h4uX3F+upBx01gjBHqnzxIqWQoO5rbI2JRczUJrPjJp4ZXDcy4bHzWmUwL599Yf6SSP5/82TD
 Pm0vl998nshOd/7LdFxl0iT9VgdUuBP27f145TzaQf/UWptSmI/e6WOQACevk4GeEoNQYVJc2dk
 3Hk9YGIXpeiLmglAe2qpPSCBvZDuXkJUzgvsrw+VHYXJeJMBcWKc8bhz//HeEloyynyvgSPI/G4
 1bbFzupFza8rW0KjkbD4m3tJUAUQPqs3V4/oYDfm8hA9FFaV/yg93VEpw0AcJFLUEMMkjJ6N+G/
 6wokj8ZaLSbZHd02iuSvuySYYOTsevzdWpDKXz7zcC8nGwzXFLwIC8Tp410Wdojrfad7U9sKyaL
 FRS17bn1uM06Svhbk59YwGGGZcitr0Ysji9w==
X-Received: by 2002:a05:6a00:22d4:b0:7ab:2c18:34eb with SMTP id
 d2e1a72fcca58-82392069697mr5512272b3a.12.1769742743167; 
 Thu, 29 Jan 2026 19:12:23 -0800 (PST)
Received: from intel-VirtualBox.. ([94.156.205.238])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c54ddcsm6312494b3a.64.2026.01.29.19.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 19:12:22 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v1] Fix unbootable ARMv7 devices
Date: Fri, 30 Jan 2026 11:12:17 +0800
Message-Id: <20260130031217.998002-1-briansune@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The linker script u-boot-spl.lds now
is no longer aligned and -nodtb.bin ending shows
the zeros are not 8 byte aligned. This result in
the Makefile.xpl simply think the previous file
is aligned and do not zero pad. simply fix the
data align to 8 can ensure the -nodtb.bin is aligned,
hence, the formation of u-boot-spl.bin properly align.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/cpu/u-boot-spl.lds | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index c578c3ebf82..18b0f1e7284 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -26,7 +26,7 @@ SECTIONS
 	. = ALIGN(4);
 	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	.data : {
 		*(.data*)
 	}
-- 
2.34.1

