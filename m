Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D055C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE6688B9B;
	Thu, 15 Aug 2024 22:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k2KMBXFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5CD88BC8; Thu, 15 Aug 2024 22:26:06 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38FF788BA4
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f921c40f2so46995639f.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753556; x=1724358356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YI4bJWyLCxGwlWZWxGOuXlqr4nvTB4tkyAOeLVUpIRk=;
 b=k2KMBXFb5i9aYt1QJl8sKJPYi/z2NIhESdWRq9dsRhAzV6XsC3Yyosn1N3NV6Ne4XV
 4Ry6qHdUNlTmSzhLva0eyY7zUkAcTMiO1v8tGsUWZbcVgYaeIzg9HeAvhQFp8P6+mDDk
 81g89c37Z9U7jNcKryuw3tqSpv8zFNoJLDh2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753556; x=1724358356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YI4bJWyLCxGwlWZWxGOuXlqr4nvTB4tkyAOeLVUpIRk=;
 b=pLkx7n5U2KzREAaIPMaRmTigUzvwgauUcS5221V7Uk39m12rHcVnKo9u796K30kU6n
 Ie5A0ws367AImJZUJAa8zn4/J297LQrlgTDTwHsF/cw46JPp1rM6uS2jolkK60N52ExO
 ULfHEIJwqG1ufYB5LCP0WHy9grbSHL3+N6Y+ygCYmrYRQn8zoxNtlN8La78YHuMJudKH
 id3vMRJqXOrPiy13SY/QFZ9/PsZBBJToIVBdBFGYDke825IWd9f44KOaIxSSGG2yUMDf
 QHejoHD26AN5mYHiwqq+mH7V3TYdSfU01ijTCh1baUHdQXDy7Ql51y2JBeHatg+cZSRK
 8Hgw==
X-Gm-Message-State: AOJu0YwkE1IbX8EtiqV9CB/joUSvIVBY1ECLksMURuOSsalGeFVdU/X6
 pGmBiK/wztJzYh8GJvbgPjHRi8yGL/KHlFxoZX3ug0cEeIELziI+GbhGMP//z1BLkqzolH5B8e0
 A7Q==
X-Google-Smtp-Source: AGHT+IHAMwNaRXVqbdNy1V/UMVnU+oUj1kRBXz9Odh0fuJ/4HU+a+YJxWo0AHgl45Ce5GcxWIjZcRw==
X-Received: by 2002:a05:6e02:1945:b0:39b:3651:f148 with SMTP id
 e9e14a558f8ab-39d26d644c1mr10007665ab.21.1723753555643; 
 Thu, 15 Aug 2024 13:25:55 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/24] sandbox: Implement reference counting for address
 mapping
Date: Thu, 15 Aug 2024 14:25:28 -0600
Message-Id: <20240815202535.767869-18-sjg@chromium.org>
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
index 3e1c0dd583e..51ce40e7f08 100644
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
index 6b50473ed41..e7dc01759e8 100644
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

