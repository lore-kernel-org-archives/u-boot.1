Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C69C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97EE88A7F;
	Sun, 11 Aug 2024 16:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C4K2fIWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3A588A13; Sun, 11 Aug 2024 16:52:48 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2DD88A31
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-396cc82f6d7so12024695ab.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387965; x=1723992765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YI4bJWyLCxGwlWZWxGOuXlqr4nvTB4tkyAOeLVUpIRk=;
 b=C4K2fIWqpPSANZMAAKzKiK8G9phMAcSpgKsizSc9t5MQYWPFcNulj1KyNsNip42vxd
 X8MZ+022KCuC+/faSKj6CZYTnhrZu+e5SmY3LczdmTioluesH1jkQ5tU9VhH9vsKWnef
 Ivx9VpuMv1wtruaEmcHKKj6ea7fPoe5qxBo0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387965; x=1723992765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YI4bJWyLCxGwlWZWxGOuXlqr4nvTB4tkyAOeLVUpIRk=;
 b=gV3KrLeGcDNwHzHA9+mnwyFaBeOuUvNIWR2TftmpAnspKu0/cSvRkCdycqTcMdXz7A
 WoHg1krNqy4VJ5wDbkt2uIBzPT+9eYlcOioLxk/NYUWH/iGP+XwGICVJ8sDEfbseu98v
 QeY50ik85fr4ZsWK8BvR7VWHcVEg6jiyCAB5ciQqiUhT9QKro5l+hhfpnz/Ekujntanz
 OPkrnwTs8Gm4DQ1pML8fUNuDFZLyy8Nm+bN7jWhcwH64ytAMz7YeIed9leNabUoZDpE3
 hvq28WHaldhjZ1tM1RUlTVu8ljz0W/rNhuCKybtNCzebWkiTblaEKfdx4D197bcwb3NN
 Opsg==
X-Gm-Message-State: AOJu0YywfFkNio4hm/fgR0lAc+c+CZrJ41HBVC6j+VP0Z6I9VRv+a9PN
 Nl5wJvofehu8nU5wCJBLtSpse/JIptY29Ec8NKYPGDZRzxb9LH+1D5FPpNWL05c6Smdh5zoHQFM
 =
X-Google-Smtp-Source: AGHT+IFyZtLae4vxxKJweAG/4JeXpbxVVywFlc8He5pQuzTMe6TPGfDOjVYQIFdeH2+DR6cN4AcLLQ==
X-Received: by 2002:a05:6e02:216d:b0:39b:3244:a355 with SMTP id
 e9e14a558f8ab-39bd8c459a3mr75935215ab.11.1723387964602; 
 Sun, 11 Aug 2024 07:52:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/40] sandbox: Implement reference counting for address
 mapping
Date: Sun, 11 Aug 2024 08:51:46 -0600
Message-Id: <20240811145209.4191404-18-sjg@chromium.org>
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

