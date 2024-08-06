Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA259C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A80E88A6B;
	Tue,  6 Aug 2024 14:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ae8i5cSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2061588AA4; Tue,  6 Aug 2024 14:59:43 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E2F988A76
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-396675b83afso2150615ab.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949172; x=1723553972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PABb61nryISNosF9k2x01u5rY9Rbyf4Y7MSr0lJDLQk=;
 b=ae8i5cSd5n+9VbTR+XEaTTCokDDKovETCpZAyokYYDY62nPWgQTNFjJd11O9hevnmZ
 i8EFS4sz+zTYbMwxkbQpr6ASqdwYMNW5FGiQIFe1dVQ+xnGyewpHttxeegmDg4EF92wO
 H8Ry3JiXDW1KfZG300+csBf558y2E46fbX8oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949172; x=1723553972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PABb61nryISNosF9k2x01u5rY9Rbyf4Y7MSr0lJDLQk=;
 b=FPu36RADRv6R/InkTcC7W9bX2Od5nGmsJrziY7ZJXAuf8guH+ef4l3gMjNDWBnq6fO
 2u9or2vfuQQ03CSw33b2RQx5PVcPEewToPqRmTSlhnfGcyJRleyBvlshzHgp5uyPYn7Y
 uGrSKjLc5mC/3Ea4SlgSWpbniGVEKVhBWKjlvT18+PMzxrzflp+G4ADAw0PeUDCz8QZM
 4G6shNsX0f5FkGY6eA5GahxkGRjJtAf32V6+mRTFrhkgy0qLJ5V/8sETC2af6RgCXCWx
 DHxg3Rig+sAn+szELmomgRy395lwvYnu9yiy3kOKFeh3gWmy2kUEALjTKLJE+DxoFs3L
 ItMw==
X-Gm-Message-State: AOJu0YxVfTQQ5JmW9YgtJmFNc8o77UNbmtrRuC1JHpg6YXT+KPMIoJMe
 qNJ20lgH/IdP4I9w42CluDDDHEcoVOYl+Y3Yr9q87l5dnSRyD1Vv/HxGxpQINQ2oIrYH75VHUJU
 =
X-Google-Smtp-Source: AGHT+IEZoO+cQvCW0ATr3mmyYk+90td73NCzcerdIt43wJSBS5mGvfgdXy+Kph6I3r21YdEGDIdRTw==
X-Received: by 2002:a92:a30d:0:b0:39a:ea4c:8c26 with SMTP id
 e9e14a558f8ab-39b1fb6de2cmr167527925ab.1.1722949172443; 
 Tue, 06 Aug 2024 05:59:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 16/39] sandbox: Add some debugging to pci_io
Date: Tue,  6 Aug 2024 06:58:27 -0600
Message-Id: <20240806125850.2316956-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

