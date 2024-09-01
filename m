Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345B0CA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E488788C53;
	Mon,  2 Sep 2024 00:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V0U5AhIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75F488C01; Mon,  2 Sep 2024 00:27:08 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E8688A12
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-82a10bd0d58so99202439f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229625; x=1725834425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PABb61nryISNosF9k2x01u5rY9Rbyf4Y7MSr0lJDLQk=;
 b=V0U5AhIh+vEs0nKkvNEz7/hn7vkMarDqlthlDhu7S+9xyrPmN3sycKh9ezrbuzSZ6h
 XkJGI5WPnBIDPNvH0hn0N5c4EENlh9TXxiz/Hmz8/aACqTXpbDQQMMyWGjdcxfJW1Lkd
 YD5rLot2quGlyC7BLdqiNpr1lRze1G8sNffD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229625; x=1725834425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PABb61nryISNosF9k2x01u5rY9Rbyf4Y7MSr0lJDLQk=;
 b=XvW1Wn168p/7xrY/xcFbzf/ed6qiwIHsx0edIPWs+GAYzYzhW7vhVAcV4/bjdAdkkW
 iJsg58sreOe/52rHmxjXPV7NYBWOrNXqXys7YHYSZD1yNqc83xX6CbJaZrU5wBAitHST
 kqwEmwWg9sa13YQvxqbs4bXfYg6l/66rywzgYV5vmv0y+1+IKtXbWxrcmgCmxw83wuXJ
 cRQbw2/UUc/Hpv2H+wR0t/am3P46b+6jxixJmVBbd+i5Vwwqzc1ujWaoajvfzj4O5jNV
 UQfZB93zTIETH9O7aGR1U6LJNxc5ninq1t4eaIcigD9H7MY32PDthYY70K3G0oDt4nzn
 6iOw==
X-Gm-Message-State: AOJu0Yw2L4T3jAf5KF65VzhDfXwR+GSqgbXcDWn1IX9lg7b1SDPMPAm1
 UoWGCwGkbi7z1TH57DNSsgFX9Jz3nIvyl4uv/OgDLX+4pfR0Bh6yR9BTxIcSfV6UXpF+KpOXZqk
 =
X-Google-Smtp-Source: AGHT+IHcbgtb50I6TIvlUu18B7lzE/nOGI1Y20aBy397FTMcAQrgQ/6DaxT/1yDC0nWrrIUGixEPmg==
X-Received: by 2002:a05:6602:2b04:b0:82a:20d6:5d28 with SMTP id
 ca18e2360f4ac-82a26a24483mr562505039f.3.1725229624840; 
 Sun, 01 Sep 2024 15:27:04 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 15/23] sandbox: Add some debugging to pci_io
Date: Sun,  1 Sep 2024 16:26:26 -0600
Message-Id: <20240901222634.460873-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

Add a little debugging to this driver. Convert the existing debugging to
use logging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/lib/pci_io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/lib/pci_io.c b/arch/sandbox/lib/pci_io.c
index 6040eacb594..5eff7c7d65d 100644
--- a/arch/sandbox/lib/pci_io.c
+++ b/arch/sandbox/lib/pci_io.c
@@ -8,6 +8,8 @@
  * IO space access commands.
  */
 
+#define LOG_CATEGORY	UCLASS_PCI
+
 #include <command.h>
 #include <dm.h>
 #include <log.h>
@@ -31,10 +33,11 @@ int pci_map_physmem(phys_addr_t paddr, unsigned long *lenp,
 		if (ret)
 			continue;
 		*devp = dev;
+		log_debug("addr=%lx, dev=%s\n", (ulong)paddr, dev->name);
 		return 0;
 	}
 
-	debug("%s: failed: addr=%pap\n", __func__, &paddr);
+	log_debug("%s: failed: addr=%pap\n", __func__, &paddr);
 	return -ENOSYS;
 }
 
@@ -66,7 +69,7 @@ static int pci_io_read(unsigned int addr, ulong *valuep, pci_size_t size)
 		}
 	}
 
-	debug("%s: failed: addr=%x\n", __func__, addr);
+	log_debug("%s: failed: addr=%x\n", __func__, addr);
 	return -ENOSYS;
 }
 
@@ -87,7 +90,7 @@ static int pci_io_write(unsigned int addr, ulong value, pci_size_t size)
 		}
 	}
 
-	debug("%s: failed: addr=%x, value=%lx\n", __func__, addr, value);
+	log_debug("%s: failed: addr=%x, value=%lx\n", __func__, addr, value);
 	return -ENOSYS;
 }
 
-- 
2.34.1

