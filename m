Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B0BCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F13283807;
	Fri, 26 Sep 2025 17:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uGvszAZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9218C83824; Fri, 26 Sep 2025 17:31:36 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CDA8380F
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-4247cfc66a3so10520105ab.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900692; x=1759505492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dn3HRDn8jjDJokwY3UbU+gp5j1bijL1Z5L3t6fIyWGA=;
 b=uGvszAZ1ANttF+/YN8KEGL+BU9L3j/2gdOwxvYA9r+nE47FXtzTCn2M7xIp6ZQ+0La
 tsVA7hMyjmSODJLIecNTEs12iUc59/IK4kR2MFTQltia696RlCQXD3ZPG37tuj/+GQcW
 OUa43+kjS+A77nsmitdHlE1rDOpSMgKbEEP4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900692; x=1759505492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dn3HRDn8jjDJokwY3UbU+gp5j1bijL1Z5L3t6fIyWGA=;
 b=Yj9WnvxUKDt2P1t5PMlqTmPNCYGeImazKgUhN+EPo0MIlH8TD6p5PUR5QHN129gJIK
 cn253FX+Df3vpDqfa8L1uT5Q4t+bNcQsbdtRFV6As8ZdWgmZ388kxY98yYuGduFg3GNO
 q2dZsdZYXpEZ942LZLrVzT442kTn+UeL4rrz4D993+aqhg8/bJrQL8XhvfSrYDTMkkWe
 Ue5Tkbpg0B0sKywnBJpFQJ7ur+8iD79DKE63r/el9rID2xTH4vLB1M0DbZrP9LEcTW0B
 T0FruVEDk2WBHwyKeV0tNwiTmmshM2wU0767k//wTNQgD7yobNMzqRirH70AQI7y0rPj
 uAIQ==
X-Gm-Message-State: AOJu0YyKtEcPv+LuSlo5n045yqgFvt597gohJrzQNDHmJQfQfI6H6YVg
 VTY232TLiftUNd2UJ4VjHV3UVeptH+PFkIzYOdlFOPHwrVO1XHf4oqb0wG00VI26Ba66xWnKcCu
 b/wJGKW4=
X-Gm-Gg: ASbGncsWiMOQoplljtnhSHMu+CxJ3rQrbeNGTHNhTnJ0XVDND+S00nGXfMfgjJCD44r
 xFYKHtDT8xggAqnLmDxEUEHy445By6Gz/+TAhSNsBzOB3mjAeELrrLgS6Cc2r3gTBZ5nAHvX4fH
 wIzWdd7pZDNLptsEHod8dYNaDJiWw4HZdLuQUsPMB7i/KWL5XZ60e3tYGx6eczzFAhDADKo+FhQ
 LsBkYBXxEdBUXUdLcgEN244S8sJ8cd0u+ZhuXSaWtIzSUme4pNBEiQ7/lscyrd7Z9NjERhj7+RW
 NG6P9dvd89/bC596eMQiQFyKQyVpzG2bdYGaIakiHOqcqi4n7icY8wUqwZ+6FaH7F7uqh3GrC1K
 PlWQpt4/CvFv7fFmIISxzrJI2l0I5aLgXFpUPw43w3LVmFiXa6MQJFevupZY=
X-Google-Smtp-Source: AGHT+IECOWS8Bi8sZ6GqFNvdzUTxBojk+gghNzSIA0ITszifPhMS0+ibrCqy029P7KhtOGhoNbE+Ug==
X-Received: by 2002:a05:6e02:b2e:b0:426:c373:25f2 with SMTP id
 e9e14a558f8ab-426c3732ademr63655015ab.1.1758900692114; 
 Fri, 26 Sep 2025 08:31:32 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bc68e3dbsm23459235ab.15.2025.09.26.08.31.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] common: Make MMU_PGPROT depend on !SANDBOX
Date: Fri, 26 Sep 2025 09:31:30 -0600
Message-ID: <20250926153130.3680817-1-trini@konsulko.com>
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

While MMU_PGPROT is currently only functional for arm64 it can be
extended for other real platforms as well. It does not however make
sense for sandbox to enable and create dummy functions for. Make this
depend on !SANDBOX.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 1c340710a33d..30bf225362ee 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -938,6 +938,7 @@ config STACKPROTECTOR
 
 config MMU_PGPROT
 	bool "Enable RO, RW and RX mappings"
+	depends on !SANDBOX
 	help
 	  U-Boot maps all pages as RWX. If selected pages will
 	  be marked as RO(.rodata), RX(.text), RW(.data) right after
-- 
2.43.0

