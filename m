Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254DCC83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60AAE83542;
	Fri, 18 Jul 2025 03:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tGud/EK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E6E8354B; Fri, 18 Jul 2025 03:15:27 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FF083526
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-41b6561d3e6so963320b6e.1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801324; x=1753406124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=htjG+ZkS8YqUrlPx3TWHUwKugSDUfiZya7SQhH2CVns=;
 b=tGud/EK7Iq4b2oeCA4ovklzar5vVTb2n89irVeYkqBAuLZJKj82t9golRcINfAOEli
 VIvRwIzZxB1B9Vy7zGMxdi4u/o1hcTZG9cszdGngLJ5QsLbP8XeyOW+hHmlgYepECN2Y
 FT+ko9UIbNRPilKFKBDvgQb777IumcPXRzCmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801324; x=1753406124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=htjG+ZkS8YqUrlPx3TWHUwKugSDUfiZya7SQhH2CVns=;
 b=ob7vI4swHx0I9Q9DqjgFjiJ7AhhmJ/+n0ifvQ8FGT7aTxjhu0LdfY7s+9jD0XaPpj7
 rrt+AHGTHhvTYN7cQBU0sNCDNBauA+65Y9p5WHP+sdhRODCP4GWsDqJlRLLFX+cFucTV
 VIzxxDleN4aUyg7W3xrdA6Wz+xUewzTJWqaZfwsVug5owOPsHdlzUuoM81REFW89b5QV
 VTXKZxYgh2bLgeE6vVvEZQlONrYKmOo852pJUvkttSj86KG35yh2fJnZ8ApmQBnp0JOj
 M8q+v2AXmwPnOXWWgY5MtHE4qi6rnW6M+dYQA3KqhDpUnNkHewCv5BHgK4SA+8mZg6F8
 t2GQ==
X-Gm-Message-State: AOJu0Yze5S59nelx6sgBi54SLpEzrq1ReHX+IIvjcTcHLQ5yf34tWzy4
 SgHqUevfCfcWFlCtG2DD23V9KotbLBLZSTNplxy8VjPVMyhL8hI+0mZ9IDv8irxX0BY+1Rkp1lG
 zXnOV3lo=
X-Gm-Gg: ASbGncudXyN0GoLanqUKTCvO05Bsv9G8w3YdD8bJJD03MnfrfAgXsynk8/yKfzmkdsw
 kYvYg3htGMDi1l9y20sx99RrM5ol3RatcWWK0SaWtUUE/2sdhqYaE7s/+yVqUctHmGRHoW2q+/o
 ylxlGmahi+uN1pV8NIBkrji3M2lHDuuW8bdkmQhYk2zP6xQWES6LKGp6fApVVssvCu2DoyFFXJ9
 kLdMbiRbwhbnn2UzcJHl4FJqHNYwc1l9ai3yVtogfv8FYadukD/SGaofawVfixNB4+hh6ll90zC
 DBnzUqSwhF9jwLs5I+CRI/sY6F7aplbo0LHrt1K7Pylt6P15yovxB3ULICvfTsRrUPr1DiFtvlf
 +qKmeQx35sXMHpujvUhLtOuI94b2MgpVhmI+kuAu+BQDGCzeg1vAAVu0qccE=
X-Google-Smtp-Source: AGHT+IE+2DpuAUuzWC1XTIIccyn/f0GSrwLjvHXsjhI/dIstEiHZ3/VVgRAp2tYp0bTe83vM6FRuNQ==
X-Received: by 2002:a05:6808:320c:b0:401:e8b5:4e4a with SMTP id
 5614622812f47-41d032fb094mr7242905b6e.1.1752801323911; 
 Thu, 17 Jul 2025 18:15:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41fd10c25d1sm88509b6e.9.2025.07.17.18.15.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:15:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] pci: Add missing <linux/sizes.h> to pcie_iproc.c
Date: Thu, 17 Jul 2025 19:15:21 -0600
Message-ID: <20250718011521.1333839-1-trini@konsulko.com>
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

This driver references the SZ_ macros while relying on an indirection
inclusion of <linux/sizes.h>. Add the missing include directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/pci/pcie_iproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie_iproc.c b/drivers/pci/pcie_iproc.c
index 360ef1b011f2..a6ed01891782 100644
--- a/drivers/pci/pcie_iproc.c
+++ b/drivers/pci/pcie_iproc.c
@@ -13,6 +13,7 @@
 #include <dm/device_compat.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
+#include <linux/sizes.h>
 
 #define EP_PERST_SOURCE_SELECT_SHIFT 2
 #define EP_PERST_SOURCE_SELECT       BIT(EP_PERST_SOURCE_SELECT_SHIFT)
-- 
2.43.0

