Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB8C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4353D82A76;
	Fri,  4 Jul 2025 23:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jApUvynj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6985282F6A; Fri,  4 Jul 2025 23:50:27 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 573A682063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c14138668so519476a34.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665824; x=1752270624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uc/W5l1bgrU43bcIIXscv3i/6VDZVXo+jmME+2GtXMM=;
 b=jApUvynjzWz3w70Jir2tl3+mBHONmztCe3cZZaZ8M2AjrxF1+Dj10TPnNDNphIpqvf
 2oU6SvuobRNTPtxKIUA3BQ89kU3yNkTk20ETK4vk7jB6OI22vYJO+g3T1fF2/6y5AMMv
 SQ9SiD+JcmBYIIiBpVfPUlrReLEE1Y4YBe288=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665824; x=1752270624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uc/W5l1bgrU43bcIIXscv3i/6VDZVXo+jmME+2GtXMM=;
 b=i5qHuNVvHKNbtnICGy80aIXa/HIJzHcdgg18+U5kUk//mvuTPi4py3NtX+mnfYC5pb
 A/otInQHrOAeYHqXbu1lsHj1ZNPeii08J9KX0ovKJHWg6aWITs2c1EzVAT0qBBcO2agU
 sgrPX1rcWZZJOQR/nbGemyUOorZeH9z5+KKc1pI9Ym8A6SJ+g994FUBHwGdl7CWd7mN9
 BY46d8wbpVIPWbRRFORXvRtr5UCJ17UoHFP6Uds9KoZHtiSA4bZcEeufnWPb3N9vV+tl
 wPRKaP/cureWpMou0NyVmxtkhen8mUBzXJY3iDPAsDF2Rq/DIQP80dYa56zdsi9okR93
 30Dw==
X-Gm-Message-State: AOJu0YwfLtZ1nBX7akS2HZeKADezHHoLAie6ud0+orZCiqfavbnI/Iz1
 rKLHGQvrbMFIIzfZmouPyBSOecZ1AA9HIjyhj2yCjE+UjlYtvjLJf80NIq1Y7Oa9Eg7RWpztTxJ
 sPTPzCCg=
X-Gm-Gg: ASbGnctPmaUXBNnkPZHDN9tgS6K2avZ+O63tTT9+u1HkOZJ/zcBwioUXkAIWb8v9eeJ
 xWSGQspUUHtC+aczXYY6cOOQx9RYnoW0GREf0QAJws/FppS3CN7IoYmQk6CLwdirEMgSwkIyNXq
 8yLTt1r4bJJkKvFEOGot9edrNfQLYdvFHYr8opmyTMWwVzCYkYEv8fvQTUbSY0WF8zt+vACLiiY
 8k+8PaYjlgTVK12+0kOOVpDfAabVHwbxmpIqEUt7GJw0y0jCYOc+qTW/XNpqlOyuPW/aPPbO5oA
 miru3caA/lhxyvjDLbQEihyRIFk3iXpnz2One9nqTkJIoTUa1dsMQ/b5kZv5eHxKvHtjCKAV8yK
 ZpaDtJQWxK7B9WfZlCX3Qm/4=
X-Google-Smtp-Source: AGHT+IEbl0PSnYbHcZOxq/e40hJIsPzsKp21+mCjiaMbNq8+jimtdORyzkF3rsfOAMCv7C2g68l3oQ==
X-Received: by 2002:a05:6870:a413:b0:29e:6f32:6d91 with SMTP id
 586e51a60fabf-2f7b023d013mr207175fac.33.1751665824000; 
 Fri, 04 Jul 2025 14:50:24 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f79020c84asm739414fac.36.2025.07.04.14.50.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:50:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] power: Correct dependencies on POWER_LEGACY
Date: Fri,  4 Jul 2025 15:50:20 -0600
Message-ID: <20250704215021.3419863-1-trini@konsulko.com>
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

The POWER_LEGACY option functionally depends on not having DM_PMIC
enabled, so add that here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Correct commit log (Fabio)
---
 drivers/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index eed65058e667..fd1c871f0dbb 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -15,6 +15,7 @@ if POWER
 
 config POWER_LEGACY
 	bool "Legacy power support"
+	depends on !DM_PMIC
 	help
 	  Note: This is a legacy option. Use DM_PMIC instead.
 
-- 
2.43.0

