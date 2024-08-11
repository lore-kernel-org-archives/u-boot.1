Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96351C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83CDE88A21;
	Sun, 11 Aug 2024 16:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jbo3bdTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6679588A2F; Sun, 11 Aug 2024 16:52:48 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B4488A13
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39b3754468eso12825325ab.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387962; x=1723992762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GU3G0qlXd2GDT1N3EisU4gxjskpK1YtUBWVmLnEdRo=;
 b=jbo3bdTJWB9bG9jXF1L3r31rK0Hast/bPUHBGNlKlw2x5oAAZtq/IHwlrc6UhLZLBW
 fdcv4oYALzSya9bvACM7WG2tdleHrqq2XqhgBhwDumOPxrCNbtDy4uEY0ONwv1udJMHV
 DDFdlX2J3otTBYywbQbiFnem+3pXyHmbRbW68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387962; x=1723992762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GU3G0qlXd2GDT1N3EisU4gxjskpK1YtUBWVmLnEdRo=;
 b=msW+puiHRQ8VmxO2XjMfhMWObb1VRxBEnMFOARyTyb3/Qy9+5vUGEUpo64C9FxKzCq
 y0zmFKWdQWBgmmdyampYwDqQvga7GDIGozCp2y3Jaqdj+aggBY2bN1v67qHMFcYoqlwK
 tzaEc1mW+zJlv8TdFxY86BAYfcr8sW6t0d31ttcaOqqKRFvNu7AmY7SwFqDC7GYhnRyC
 /0sLpickCfKamnD/Eph6gEM/JXgfXyLdq8pMpTu3va/kxe8HVCGHi7R0LNm+R7gBVl4o
 3vm+4xLujplDiU3n0LVqMm4b531bkZjNtPwGmw0+FLc9odI8+LRYTD8HRrcyQK/B6s4+
 9H/w==
X-Gm-Message-State: AOJu0YxIsVoiqmYycOwLZ1/Y9W9IZI75t7VyDL8yICVISkWcbOHV4fSf
 m4KnrMeMAYcqODAkUpnVmCgOljEmQxo9zwDY8mWzXmn/+GoY0K9WS6FfQzh82m9gxOmszVnt5fU
 =
X-Google-Smtp-Source: AGHT+IEWkBAq7aBvOD/tZl/SQkxo91/p13p3nb69Y1b/XjrIUvSWnvuEdpsyLaAz+GvoTPFk3FLlVQ==
X-Received: by 2002:a05:6e02:1fc5:b0:397:6dfc:993a with SMTP id
 e9e14a558f8ab-39b7a449735mr81228095ab.21.1723387962446; 
 Sun, 11 Aug 2024 07:52:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/40] sandbox: Update cpu to use logging
Date: Sun, 11 Aug 2024 08:51:43 -0600
Message-Id: <20240811145209.4191404-15-sjg@chromium.org>
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

Use log_debug() instead of including the function name in the string.
Add one more debug for PCI.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/cpu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 4f15a560902..8eb055d6837 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -109,8 +109,8 @@ void *phys_to_virt(phys_addr_t paddr)
 	state = state_get_current();
 	list_for_each_entry(mentry, &state->mapmem_head, sibling_node) {
 		if (mentry->tag == paddr) {
-			debug("%s: Used map from %lx to %p\n", __func__,
-			      (ulong)paddr, mentry->ptr);
+			log_debug("Used map from %lx to %p\n", (ulong)paddr,
+				  mentry->ptr);
 			return mentry->ptr;
 		}
 	}
@@ -130,11 +130,12 @@ struct sandbox_mapmem_entry *find_tag(const void *ptr)
 
 	list_for_each_entry(mentry, &state->mapmem_head, sibling_node) {
 		if (mentry->ptr == ptr) {
-			debug("%s: Used map from %p to %lx\n", __func__, ptr,
-			      mentry->tag);
+			log_debug("Used map from %p to %lx\n", ptr,
+				  mentry->tag);
 			return mentry;
 		}
 	}
+
 	return NULL;
 }
 
@@ -156,7 +157,7 @@ phys_addr_t virt_to_phys(void *ptr)
 		       __func__, ptr, (ulong)gd->ram_size);
 		os_abort();
 	}
-	debug("%s: Used map from %p to %lx\n", __func__, ptr, mentry->tag);
+	log_debug("Used map from %p to %lx\n", ptr, mentry->tag);
 
 	return mentry->tag;
 }
@@ -174,6 +175,7 @@ void *map_physmem(phys_addr_t paddr, unsigned long len, unsigned long flags)
 			       __func__, (uint)paddr, len, plen);
 		}
 		map_len = len;
+		log_debug("pci map %lx -> %p\n", (ulong)paddr, ptr);
 		return ptr;
 	}
 #endif
@@ -218,8 +220,8 @@ phys_addr_t map_to_sysmem(const void *ptr)
 		mentry->tag = state->next_tag++;
 		mentry->ptr = (void *)ptr;
 		list_add_tail(&mentry->sibling_node, &state->mapmem_head);
-		debug("%s: Added map from %p to %lx\n", __func__, ptr,
-		      (ulong)mentry->tag);
+		log_debug("Added map from %p to %lx\n", ptr,
+			  (ulong)mentry->tag);
 	}
 
 	/*
-- 
2.34.1

