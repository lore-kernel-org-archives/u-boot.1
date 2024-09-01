Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D30C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9C088A12;
	Mon,  2 Sep 2024 00:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UnaTLmcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F9A88A12; Mon,  2 Sep 2024 00:27:10 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EAD889A0
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-82521c46feaso155891739f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229626; x=1725834426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YI4bJWyLCxGwlWZWxGOuXlqr4nvTB4tkyAOeLVUpIRk=;
 b=UnaTLmcu1ZfjPNhCNUjBQmu96hv5LhzoKuRxGX3guTekLnM6qrUq/icRFS4bpzE65h
 lZBtoucXsdpeXzhS2pt3Djhw7gKaVQdOiYZHXtKDVYVxCAEeWraPFV3kYCKBXsP1tSM7
 N9cx605Y5gjsbz/3Kks2bxq25tSflvT9tEM44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229626; x=1725834426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YI4bJWyLCxGwlWZWxGOuXlqr4nvTB4tkyAOeLVUpIRk=;
 b=WO48qHZ85yXlQ65TFcpVEZ9/GHLMQjDi+vpbXIxKGK1xdBJgq8OhUO7gvtHFVCZ6En
 hXi93fv7Qf1y4xic2Az02t6yzAI89rzAlCUrPQozSn13eTqmfwjkeja3+RTZYZ0BOrh+
 2Twa8B6cN14sNHGcsd7utE41oc8Nr9iR/9b/gvsmralwTWfj6uW3RD4uObUvDjU1CnYt
 J/NDbreDGxvxocNO98NckU4UkjPydlaTYk4b81EtWM9J2rBQIiAVpqxBlsLcgwHcVAZ0
 T/o3TuyEWNDPluNnQGFSUiPHe78QwHMiw+RsLASZ5ZeqUrhyJOGmXwIuz2pOJ2q7P8I6
 vRSQ==
X-Gm-Message-State: AOJu0YzN0ebm5E5NCgpjDRsc6Uyrto7a8DFEdj/lMOSqyxNkZ44Uss4f
 U+sEmNroM+bnFcS23D0BVCh6zLxXJC3LUI2bWFWgZZM+GuY2EhxGONiL7kL2fpPR4GA9fwCD9kk
 =
X-Google-Smtp-Source: AGHT+IEHRRkU/6P6lcQC2R+cqnecTH99/dGrresJEuvjjzb0WfJKHsX0QXmb0UXSUGlEgqIVhjAvjw==
X-Received: by 2002:a05:6602:6119:b0:82a:4ca6:41e6 with SMTP id
 ca18e2360f4ac-82a4ca64386mr226387639f.13.1725229626283; 
 Sun, 01 Sep 2024 15:27:06 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 16/23] sandbox: Implement reference counting for address
 mapping
Date: Sun,  1 Sep 2024 16:26:27 -0600
Message-Id: <20240901222634.460873-17-sjg@chromium.org>
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

