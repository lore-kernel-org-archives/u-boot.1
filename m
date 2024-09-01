Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DC8CA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9225488C23;
	Mon,  2 Sep 2024 00:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J6fI4aS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 342C988C01; Mon,  2 Sep 2024 00:27:07 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2971788B16
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-82a29c11e53so134631339f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229623; x=1725834423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KempVwTGPJGo0sivKvaUCUHvMMsZ7czBFCqaB5M1H0M=;
 b=J6fI4aS1oSNsj4fn+u1aTE0RsJzj0/S6CVB4NIPIusCof6zCn5fSGP1KowKLW0plfG
 WSSLNXN8uue10sPrMjHnO8fDwAx+0cjoNGIV/i9y+PmKnHBxba07uXJtuRy2+jAX0VFt
 C/TxDsnuQz17pfIcSOpjm24mq7cYreCJr+MHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229623; x=1725834423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KempVwTGPJGo0sivKvaUCUHvMMsZ7czBFCqaB5M1H0M=;
 b=cJWl4ROXLDzs9DBxgVAqiIrpPIvnce956NgFImaqHKHroGLoGde+OKhQQitnqKOuCM
 B8f6lhG2hLN9Zk+H1EdhAqAkmV/UMUktykN46sKR5zK+xm9AERAwtLeqbAH0ETB8u5ni
 WMP/pCeaWvguTwZs7iIdgacyNe1ssdpqdIw1ldZ4aHLkgvR96sYxuLcYy12Gptd20tte
 D8oZ8RXgv10ty++Dkid4Fc8xvJlc7Mb4+Yrhqdwf07U6Wno3ffhuxB9J5nQFJgmZK2uv
 4k9VhI6TSX4K+8837v/G9VvC1IGLls77FCqcz2nHZk2KDLpRPrpQMMAI8Z/5CaJ3b1FK
 O6ug==
X-Gm-Message-State: AOJu0YydJGRyFl/OEvRsCXxZCEqN8NHySMaML6oWPhUmzKnwFiFZ7UDz
 65tiq5xp6s92bvch1MpG1MGdFiWjERAs0UxM1dUF9ys0q4shKeptJ94URVdzurvP6rd1iMH6Ueg
 =
X-Google-Smtp-Source: AGHT+IGheSBYqrv2hgD6G3mzd10hXqmNq0C4ql6kFlGRzu91vJ2W5rCt8fenuUTyg7wABnV2LaaNgg==
X-Received: by 2002:a05:6602:2b8f:b0:82a:35e7:c24b with SMTP id
 ca18e2360f4ac-82a3750427amr611883439f.7.1725229623692; 
 Sun, 01 Sep 2024 15:27:03 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 14/23] sandbox: Unmap old tags
Date: Sun,  1 Sep 2024 16:26:25 -0600
Message-Id: <20240901222634.460873-15-sjg@chromium.org>
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

So far unmapping has not been implemented. This means that if one test
maps a pointer to an address with map_sysmem(), then a second test can
use that same pointer, by mapping the address back to a pointer with
map_to_sysmem(). This is not really desirable, even if it doesn't
cause any problems at the moment.

Implement unmapping, to clean this up.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/cpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 8eb055d6837..3e1c0dd583e 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -185,12 +185,28 @@ void *map_physmem(phys_addr_t paddr, unsigned long len, unsigned long flags)
 
 void unmap_physmem(const void *ptr, unsigned long flags)
 {
+	struct sandbox_mapmem_entry *mentry;
+
 #ifdef CONFIG_PCI
 	if (map_dev) {
 		pci_unmap_physmem(ptr, map_len, map_dev);
 		map_dev = NULL;
 	}
 #endif
+
+	/* If it is in emulated RAM, we didn't create a tag, so nothing to do */
+	if (is_in_sandbox_mem(ptr))
+		return;
+
+	mentry = find_tag(ptr);
+	if (mentry) {
+		list_del(&mentry->sibling_node);
+		log_debug("Removed map from %p to %lx\n", ptr,
+			  (ulong)mentry->tag);
+		free(mentry);
+	} else {
+		log_warning("Address not mapped: %p\n", ptr);
+	}
 }
 
 phys_addr_t map_to_sysmem(const void *ptr)
-- 
2.34.1

