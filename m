Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99765C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB4C88A05;
	Sun, 11 Aug 2024 16:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EoObErIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86746887E8; Sun, 11 Aug 2024 16:52:47 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8359B88A37
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39b3a6a7941so12993265ab.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387963; x=1723992763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KempVwTGPJGo0sivKvaUCUHvMMsZ7czBFCqaB5M1H0M=;
 b=EoObErIgdMCLK2qQK2Ymj71l/QgYmRhxY/UOjSEPDUFtA4wyJ02xjnz6fTbRF6N5mX
 Y6hJsg8OAD8DGtXxwLwn3vXJvCrjVzAAaoEH+15/FtZd5tzvKzENQf64QeFtaCyQl/Ct
 jyb5B0DVVE3nohx6wGmeUlu27U8jmhDqiVmi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387963; x=1723992763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KempVwTGPJGo0sivKvaUCUHvMMsZ7czBFCqaB5M1H0M=;
 b=WdelGCZYyTLV8hdtAxpnv454vMgnMa1bb/mfnI468iLuCPKNaRdNHrfZ91DNVBaE9C
 /DE3YgQi+ehu1odrGTkLX0Dh7/+6YLO6WCaJ3+I4jAD+/x40DR7aC9+kdODhNbnYt5Xg
 w3qko0VD9b5yL1LG0D/RTfxJ0pkQROVomV86TiyYF8Qc5/oU3qoiKZGr+8sUG8+Ue44A
 i4qDrxG2Wy9ozqz7CVp8kYBlmgifF3bsg8ECx3me4/ziBnDzQqhzAPTfm7C1cWnyxTqp
 5DvgUXr6ycl7PSXO2ktv5m0VscxV/XOI9avgq27jasO2Lgt9bgUf5dvJxdddELatzhCj
 fzaA==
X-Gm-Message-State: AOJu0Yz33XVK58A2nz9dPjqh89Z3nd3g9g5lNn6g8JP5BWbc5CkZIbjA
 yvzxobaDPqOLyKvYNA3eU9I7236aGJHC3awOwUSmxEIISvqF2SZvUvgkq6nacla2XlgdRtAk5N4
 =
X-Google-Smtp-Source: AGHT+IHj2h8S+zmLuTloZxcnLO9WAz4RJi48U7NI5SiCHh06FqELYVTom6QVTr6L2ALoTH2YqFqgeQ==
X-Received: by 2002:a05:6e02:1d01:b0:39a:e990:d0e with SMTP id
 e9e14a558f8ab-39b7484f668mr83160915ab.1.1723387963238; 
 Sun, 11 Aug 2024 07:52:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 15/40] sandbox: Unmap old tags
Date: Sun, 11 Aug 2024 08:51:44 -0600
Message-Id: <20240811145209.4191404-16-sjg@chromium.org>
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

