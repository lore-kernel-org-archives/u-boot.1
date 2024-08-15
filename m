Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09580C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1DB588BCD;
	Thu, 15 Aug 2024 22:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cReI0ORI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C5588B99; Thu, 15 Aug 2024 22:26:04 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3910988BA7
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39d210237feso2930865ab.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753555; x=1724358355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PABb61nryISNosF9k2x01u5rY9Rbyf4Y7MSr0lJDLQk=;
 b=cReI0ORI38lULIzEuM/5g3JvCgxdcz63qJOxtr+ta1LJp1cG6qdRHoz36wjnQkVWNN
 N9MdfrfRuCoaKz4ij4tWrEZkqg+vLYhKfX+XmxmjSoR258DipTulTLU2/63D+Eknrokg
 u/GIjhA1BA2LMQVLrK3yAkh2XO2o8pJ61EQ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753555; x=1724358355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PABb61nryISNosF9k2x01u5rY9Rbyf4Y7MSr0lJDLQk=;
 b=fDe95OmVvrAhIiYmrTEMpj9+LBB7u75VXCjl3is1j8AUuUohdlLadKMwW4V815zeVl
 pm6xJNbB1G0I5/dRoNDP9aILW5Tt7JDyT2cSxS4uUOgHOsjhBB6J3Co9AT/6v0E1n78q
 5+j1CURHPAXgei3qphAP3Ibq2YQGjK/3gdbp4osPIuybf3uEK2SVLk5G7MAAORH6l7fH
 AstqjXXoyAeGr0IoN26KdSUO5/++cRYYwsIw+HugYze5flaeCHnn14wXFXBoY7pyX+mi
 1mDMS17iJ3aIOc76N8/89F3uqtK990prkpLvGaCOJgfKwU3czJI/IWkI5Gl675SRLJal
 FxdQ==
X-Gm-Message-State: AOJu0Ywn5CjG0TKXbj85msySwQLG3f4OLIRKk6RF3OCk+NHYIhGhjx5e
 J8MvokkuJNbEzIqERzqc1gWPol/I+Q4ZwSyiC5a9P5j151ksfe/+SIG8Z8T9vh6dF5cP4of3P55
 eDQ==
X-Google-Smtp-Source: AGHT+IGyDynSW0VRu3FTflL+elXEpspQ6Ymaf1zpqu5D7RxQHfY7d4IWpO4YEbLNcrgYuqSelnpHCA==
X-Received: by 2002:a05:6e02:1648:b0:39b:968:85e4 with SMTP id
 e9e14a558f8ab-39d26cde81amr12999495ab.6.1723753554828; 
 Thu, 15 Aug 2024 13:25:54 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 16/24] sandbox: Add some debugging to pci_io
Date: Thu, 15 Aug 2024 14:25:27 -0600
Message-Id: <20240815202535.767869-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

