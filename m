Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7A9C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA21988BBC;
	Thu, 15 Aug 2024 22:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YpL4ccFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62FE88BC8; Thu, 15 Aug 2024 22:26:06 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6542088BB2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39d20c4be31so2881565ab.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753554; x=1724358354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KempVwTGPJGo0sivKvaUCUHvMMsZ7czBFCqaB5M1H0M=;
 b=YpL4ccFNbCd1Vh4vXcv3YYKL4knc+1NJqadlzLb+KVTx6G9J51wwP+BvepkQ1R9I4b
 vAgnLp1U9dP/sEuL39EiHvA05qC8/KyaN3j3FZs0h1eX685EjXhvVa/2vXzxhNn7e+4o
 e0lvExfNOdokUFHM0uhe5y2VlRUVuKsj6NVdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753554; x=1724358354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KempVwTGPJGo0sivKvaUCUHvMMsZ7czBFCqaB5M1H0M=;
 b=dIRqqgj3MXmfGmaomJ8v6pwM2uKu5AoyuYIoJl9wbC9occMnS38lN2Oj3tUrt2BOeW
 Pqo8RujUgTL+VxzkR0EaqN+NhGbXO/gz70b6P0xXEmUobZbsqwcWtnF1afHk86cwi/kA
 ouqs+08xH7hRgWUG2BBZ2NRMeIfu236gqNlsVleLcR7pqaCtM/lfVoN2AhoN9I/UrlKE
 0mvVLz7aPiByQgA7SJ5giCC/nFUKm06qz4GvnVOg4vShfjwLBYwkrBBOF6Wi+gtNLiNA
 8RZ58O26VGA/G2uQHT5KyW4i3dR2yFB4l3CcJGjFa8kGUMPRk+IMGo1jzb83V2BTB6tI
 b6fA==
X-Gm-Message-State: AOJu0YxmgviomsMzgm5blmoqzrFIt/P+jYSgtFvjYj4eGvdmBtFsGu58
 A/t8zxGpngewWYbbDL3y9h79rXFQ1LkRP+EYWgxYIce23kpXCqV3UAfvtatakr9TlyRQcNcXju0
 6uw==
X-Google-Smtp-Source: AGHT+IGtvQ79jOnaXL0MOY/rwnQO7UIUChtoBLgMv0R5qVCw5CmEyCcCIhdJcXhif/dhnhpQeTDi5g==
X-Received: by 2002:a05:6e02:138b:b0:39b:28c0:9427 with SMTP id
 e9e14a558f8ab-39d26cee4f7mr12223885ab.8.1723753554041; 
 Thu, 15 Aug 2024 13:25:54 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 15/24] sandbox: Unmap old tags
Date: Thu, 15 Aug 2024 14:25:26 -0600
Message-Id: <20240815202535.767869-16-sjg@chromium.org>
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

