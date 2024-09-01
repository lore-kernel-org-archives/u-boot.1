Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05081C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E8688B16;
	Mon,  2 Sep 2024 00:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JAJEd7jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6CBF88BF9; Mon,  2 Sep 2024 00:27:06 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A01288C3C
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-82a3096ae9aso106748439f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229622; x=1725834422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GU3G0qlXd2GDT1N3EisU4gxjskpK1YtUBWVmLnEdRo=;
 b=JAJEd7jznsVKVlkW0UbQjktRgKsDpbufmTidx+Sk07tpwEQ9pUL0fhM7CvSJZKbRLo
 4kY3X2x8XweYgNiC4dmwgG9b7KCj9i4ekj3iCl9/Jk8L7wfeuedp0KfzkmkJPEQhFx+P
 4lD7ziUvuf6cpefh1S9JS588IB9+zW6DyLzZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229622; x=1725834422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GU3G0qlXd2GDT1N3EisU4gxjskpK1YtUBWVmLnEdRo=;
 b=d/t+lnlAbInj/+2CfqO4lsEdX2dgoKoNsGPkLjg68jt6TLqL87w58ARLEhLi7GkfVt
 HN/dIKIDZMngfgO3LOIpNbsZwo5fa0e2cB3NwHf0BzU3iiVq/w1Gb4GyyvgoX9LpLf+B
 yRaR+GzNIeW7tL79Tax+KrtGols/drVMJjm7jq1ihDHTKHdgMLTsBdTIN2rqaQw7KUQr
 +oa4jxpcRVBO6A3txlW3472N42w6YsMzPFhpkt56wWoHDuh+FbdZpEQGe4hKUmaIBhe0
 27bb7JA6hvmk730w7i7TDtCSwPSmF6oWXO4JEV6U5SblmMZzBdLzgPCWMragRnrcYLMT
 BnmA==
X-Gm-Message-State: AOJu0Yzl3uN+JSU4ej5X9WBqFYrk91gSZ/G11zsROYr/yiCk+nMEBqQL
 yXEpVQTgLkaosM47okJVP5ourw5zFPVXHEJbqoIKcX9xsk6ezTWMJt7wKlnozyjMuiBExHpdqZY
 =
X-Google-Smtp-Source: AGHT+IGAIb4bP0gQ++0U209qPuVWNlKrmEg+xQsaALSpJVQE2KJbKnBrSU5TjVK6lg9N3CY9/GMcTA==
X-Received: by 2002:a05:6602:154b:b0:82a:48c5:4d04 with SMTP id
 ca18e2360f4ac-82a48c54f94mr281318039f.6.1725229622554; 
 Sun, 01 Sep 2024 15:27:02 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 13/23] sandbox: Update cpu to use logging
Date: Sun,  1 Sep 2024 16:26:24 -0600
Message-Id: <20240901222634.460873-14-sjg@chromium.org>
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

