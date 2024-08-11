Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38316C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2619988A31;
	Sun, 11 Aug 2024 16:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mI4KATS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90EDA889CB; Sun, 11 Aug 2024 16:52:47 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36BC888A3A
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39aeccc6377so13280535ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387964; x=1723992764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PABb61nryISNosF9k2x01u5rY9Rbyf4Y7MSr0lJDLQk=;
 b=mI4KATS/gsGY7+OBQZidrqtfeLN5TPJ9OBwZwQucHyHHgNdNgcto4NcC3pSwb/VdNC
 9qiZ4rQobfIkp0zmsyqCI0aVH4xrw12YMPL//Zqa2b9Eo+ok6VeTTiqoVlIfdQn/Ag5B
 bBuPWMCoYaJZG/LArB2dQMz9gsgnpytny0ZCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387964; x=1723992764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PABb61nryISNosF9k2x01u5rY9Rbyf4Y7MSr0lJDLQk=;
 b=rqUWBE/oyk2JYL4+7mBcY6ip8UHPMXbPr4XOVcxeFn4J4pT4hsICfjkiXC5Yz8mqYG
 aMgWYdrdYWLwrwAhTXtP2pQVx1N6a0v3UYhIAtmYVxFErOTKnEw/168+johbXbYNs5M6
 eD6P4u6uCNy806cKzpdLQZn+sY11+eiSMkN1O13hyant5t26r4zoop0G/1oNsUJkvGsr
 rZzRWgIIn80n2aq3XOrGaoUePT+oNRaKRWNdtE4op8hMeUlbB5Q6G4DJIpqw/7aH0K9n
 unyzlN5MpxbVZoaXNA8doOfzD/JRLBTmWai/lbusnPMHXj3cJ4HCIZ/2XduTdiTpygZK
 Hl7w==
X-Gm-Message-State: AOJu0YwB4l3hynUxLZXTHv27YdB4GxEgzuEZb95q0hqI6UCQlcCwozGB
 gT6jKEGy8m3rgOAAnffsqq757ol107EVexQDlNnsYRaTUbw7Q59S1CZOOEgqo2IDi1agV37vrjA
 =
X-Google-Smtp-Source: AGHT+IFQrSW5owH3q1yk0YAbyjHGthIkGNHtHGL9EKUlGg2vmNMwaJlnsKbpanO71797Z+UyEIcIQA==
X-Received: by 2002:a05:6e02:2193:b0:381:a2f9:90fe with SMTP id
 e9e14a558f8ab-39b74b59215mr83533215ab.12.1723387963939; 
 Sun, 11 Aug 2024 07:52:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 16/40] sandbox: Add some debugging to pci_io
Date: Sun, 11 Aug 2024 08:51:45 -0600
Message-Id: <20240811145209.4191404-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

