Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EEBC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B550788B5B;
	Thu, 15 Aug 2024 22:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g9B6s7K2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF2288BC0; Thu, 15 Aug 2024 22:26:05 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5C488BAE
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso47315739f.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753553; x=1724358353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GU3G0qlXd2GDT1N3EisU4gxjskpK1YtUBWVmLnEdRo=;
 b=g9B6s7K2D/7L6d9rfGOhk45Kwq/tGGX0x8U0PXd1PWsB1iEVKI0+KWbE0wKyFX9ykD
 FR4ZqhbbBz5fLnVAcYzugRCZkaINF43f5/8uAeHk4vtkN817C6PHoIguZwhpi1p9lGEH
 Eajx9CnWhYumgWsPADoFJVJf1YVp+JAfaoRvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753553; x=1724358353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GU3G0qlXd2GDT1N3EisU4gxjskpK1YtUBWVmLnEdRo=;
 b=WwHo2G4/nZKefRgTRKiIKU/HHZik4aeMi+fhDBKML+pvbhOTDO4sRiGEIBjmivi7iw
 5Y2hf76iOZ8AlDAVAH2jcUw776A1WQlmcCiWN1oYQakcZJ0h5/PgyzeSP/JPkX0qmBOH
 bV4hlCXBM9z64jVax7yuOeaWLlOtPjwHXAm3PoPqc0gn6HQXNRIz7+v3X/DezROtqPQP
 wP7/bvWQl4shocdLwXPaseh1uqWGGloHWWE5RHxAi5l0nmNMK5DBURqucvDhtTw7iCAU
 J25u/ONpwbNsbuzXwr14s6WZn2TrvhNKXAy5fc1lLAeIcxRavd2IsFXYkFZEDnam4gHW
 1NeQ==
X-Gm-Message-State: AOJu0YzzVrZYuuT2NaSJ+ziJbKh4mVFjsXhHm88F9VHO0SeGF4Cy+3vB
 m69R1AWwxLOYJicF6LD6z7UQahKTzO2Fp5hDSIO4j3Q0gnStEQafz/SH44CgyPuk8S+80QBMtbL
 0OQ==
X-Google-Smtp-Source: AGHT+IGBL0GQd1Q92psMzkvCwTHHUEhZ43jg62kUvPQABlTOldCMGTKDgGJbvupJ3zRC5cU+gs4wOg==
X-Received: by 2002:a05:6e02:1c4b:b0:375:8b0e:4434 with SMTP id
 e9e14a558f8ab-39d26d0d1ecmr15252395ab.16.1723753553222; 
 Thu, 15 Aug 2024 13:25:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/24] sandbox: Update cpu to use logging
Date: Thu, 15 Aug 2024 14:25:25 -0600
Message-Id: <20240815202535.767869-15-sjg@chromium.org>
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

