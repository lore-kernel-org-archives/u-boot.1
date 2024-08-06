Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE9EC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA2788A5E;
	Tue,  6 Aug 2024 14:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lVG8bakh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C5988A92; Tue,  6 Aug 2024 14:59:42 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F5888A74
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39b38295008so2284745ab.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949171; x=1723553971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fD8V7MuC99ZPI0MThxBqzYxvMsQoXOR3f/GHEbqUSYE=;
 b=lVG8bakh+WH+JMhoJ4YgL0nypBACv3inlCLcHicyd01NbLbec7I8fXfCyniLwKWKCz
 PX08S39EHusxP4FzCA/U085lQWeLaeIrZV0/fVAbma75pTGAcW0HYESW4rmfxJMpb0dm
 +8j4CLWDbKolmjOsq+sdZh1KHfOM0mdnzVNbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949171; x=1723553971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fD8V7MuC99ZPI0MThxBqzYxvMsQoXOR3f/GHEbqUSYE=;
 b=RDomTlVAm2a03G0Tcw2Rbr7dd+HkABeGKXrCVF9cxRXugrHF36IElrJQyZQc4HxkRL
 L6ce5egKky4GW8DEAPlwiswTMhkXP1aYkXdVxUT3oF4pAKu6MgFxWODvs0MMRkOSJElT
 NYVzb40O0Ahi/cWnZoUbPPmYlMQYy8GEk6F2lqM/a2sCad21Wea0pmHMBFCVexJ5on6+
 ICgzandJKR1D2Zb/6gq+e8BJffesQav1PH5s/+7YIv1BzOzFfsRyHBrer5Uaj/DR27t5
 2RZ+eNHy4lp6uCBV1uD2ergOM37z4SrMVPFdWhvtlGN/OVozp/WNAmB7jhSulvutLQbt
 vRuA==
X-Gm-Message-State: AOJu0Yyt/sWwLqwnEjN5hWXW/6YcjEq2BtiNEWJ48ibFO+J8u9yG2vnm
 6zq00mDETUbB4JVqv3W/25hKqVJv9xRPKxi1NCTksVzyqnvf53p20mHbVzJDl6+JuQgMiEsnxts
 =
X-Google-Smtp-Source: AGHT+IG3lnP+tt0XIkU23oV97IZ6BQBZnRWTHhD/666qOZwJpPfdwOhzRDUY7f0I508+xlKO4AitrQ==
X-Received: by 2002:a05:6e02:1b0c:b0:396:e8b8:88d with SMTP id
 e9e14a558f8ab-39b1fb6b4eemr222861155ab.11.1722949170973; 
 Tue, 06 Aug 2024 05:59:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/39] sandbox: Update cpu to use logging
Date: Tue,  6 Aug 2024 06:58:25 -0600
Message-Id: <20240806125850.2316956-15-sjg@chromium.org>
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

Use log_debug() instead of including the function name in the string.
Add one more debug for PCI.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/cpu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 0ed85b354cf..d1500dcf32d 100644
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

