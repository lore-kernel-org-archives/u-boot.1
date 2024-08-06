Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EC8C52D76
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97B588AB3;
	Tue,  6 Aug 2024 14:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WpvXcWO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC5A88A7B; Tue,  6 Aug 2024 14:59:44 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FE0A88A77
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-397052a7b63so1845745ab.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949173; x=1723553973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOUHuchtTBwH4/BNHqqMmw93YjVPOU6kHa455104Otw=;
 b=WpvXcWO+Qi0Ly6bwKr2Or6kjshhoPbBpTc/oCfTzbRJhB8/HBlzyzTBD/OCCZEzYGY
 M1QoPkV3grxYjrqSurmrKCZYfxW2g5VbyCZNfshtbmWhebLBUYvISY3dPpqJGdH4Sw8W
 5StS0Ljg+PrfI48jIjHivdvRwvACyz0m6f4KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949173; x=1723553973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOUHuchtTBwH4/BNHqqMmw93YjVPOU6kHa455104Otw=;
 b=QvNkl47ZDJeEgERDiRQlW3CAqOviZaWzL9GKLsqOsPtyBeuYSiy/Ot+SSK7BQ1fM0L
 LEZsTHH29BpVz5ut1UE4DYtz1iyxssiYgvzN5T0dG8v0T28syZMQ5Htuflcxd9yL5YzR
 nJQfDctq5xzB1e259a7SBwme9BA923h0Kx4U2PMWRBS2l/3R8PHgmRLK7aA8/1sKVqjR
 0rDyfHyXQXhfHoWEmNu668JT8IVUE8s1YZTITKEe5uXkOw6eJpjbV/lH6X1LJCZxJUpW
 Z1PAcIka6ecSPHUChbxz4ZhYfkbjjPDfp7iiHBAPMcZNMlcwvBekDpMYxoNEdfgXbfmB
 AOpA==
X-Gm-Message-State: AOJu0YwMJolf3UiQ2178ma/wuFjThRGARvBNUDSnAhKF2kHVuiS6y319
 MT5rBH0PNjI3cPKQFgNm4j7Vj1mvbI9kl8bTYPdwulITawacmYQXC+2jdIf8Uxd0LxeH8+iKyGY
 =
X-Google-Smtp-Source: AGHT+IH7aX25c7H5CyjtVkZ4zNjKYqu1WQknMVSQ4//cZw4zeR78t1DgXcPrFk+hL77EtkSIYXcdVg==
X-Received: by 2002:a05:6e02:1ca7:b0:397:d503:6216 with SMTP id
 e9e14a558f8ab-39b1fc33e2amr214487425ab.25.1722949173340; 
 Tue, 06 Aug 2024 05:59:33 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 17/39] sandbox: Implement reference counting for address
 mapping
Date: Tue,  6 Aug 2024 06:58:28 -0600
Message-Id: <20240806125850.2316956-18-sjg@chromium.org>
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

An address may be mapped twice and unmapped twice. Delete the mapping
only when the last user unmaps it.

Fix a missing comment while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/cpu.c           | 14 ++++++++++----
 arch/sandbox/include/asm/state.h |  3 +++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index ac00be16cd7..7a4621f7e40 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -111,6 +111,7 @@ void *phys_to_virt(phys_addr_t paddr)
 		if (mentry->tag == paddr) {
 			log_debug("Used map from %lx to %p\n", (ulong)paddr,
 				  mentry->ptr);
+			mentry->refcnt++;
 			return mentry->ptr;
 		}
 	}
@@ -200,10 +201,12 @@ void unmap_physmem(const void *ptr, unsigned long flags)
 
 	mentry = find_tag(ptr);
 	if (mentry) {
-		list_del(&mentry->sibling_node);
-		log_debug("Removed map from %p to %lx\n", ptr,
-			  (ulong)mentry->tag);
-		free(mentry);
+		if (!--mentry->refcnt) {
+			list_del(&mentry->sibling_node);
+			log_debug("Removed map from %p to %lx\n", ptr,
+				  (ulong)mentry->tag);
+			free(mentry);
+		}
 	} else {
 		log_warning("Address not mapped: %p\n", ptr);
 	}
@@ -235,11 +238,14 @@ phys_addr_t map_to_sysmem(const void *ptr)
 		}
 		mentry->tag = state->next_tag++;
 		mentry->ptr = (void *)ptr;
+		mentry->refcnt = 0;
 		list_add_tail(&mentry->sibling_node, &state->mapmem_head);
 		log_debug("Added map from %p to %lx\n", ptr,
 			  (ulong)mentry->tag);
 	}
 
+	mentry->refcnt++;
+
 	/*
 	 * Return the tag as the address to use. A later call to map_sysmem()
 	 * will return ptr
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index c84a1f7060f..8213e61c3ce 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -53,10 +53,13 @@ struct sandbox_wdt_info {
  * be returned, just as it would for a normal sandbox address.
  *
  * @tag: Address tag (a value which U-Boot uses to refer to the address)
+ * @refcnt: Number of references to this tag
  * @ptr: Associated pointer for that tag
+ * @sibling_node: Next node
  */
 struct sandbox_mapmem_entry {
 	ulong tag;
+	uint refcnt;
 	void *ptr;
 	struct list_head sibling_node;
 };
-- 
2.34.1

