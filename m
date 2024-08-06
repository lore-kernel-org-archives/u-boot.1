Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF876C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7812688A84;
	Tue,  6 Aug 2024 14:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g67W0dbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E87A87EED; Tue,  6 Aug 2024 14:59:43 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E2E688A75
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-81f86fd9305so31581439f.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949172; x=1723553972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JDcuIscF5wgiLJjHTiPEuI4FmxfpmI6CWa95GVDpKU=;
 b=g67W0dbXMhN2V5KamIzflAU4fpu+JDntS0iuoHSofpOBMAmS5iF3GC1fQikXohKeGK
 rgkFiWTTv9rJLTBJQqSdZa0xNaEm8fI1Is2YbhUKEFSLwljTcU01BCY354yNImxQJCsw
 U5VcxTBUGdVRyVuokbpIfSshVVvGAUj4bErG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949172; x=1723553972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JDcuIscF5wgiLJjHTiPEuI4FmxfpmI6CWa95GVDpKU=;
 b=wiz1ScYXgrY7yb2+Rpbkgh0xjOgqQQf5iHR+CtcmS2m1BPE9vZpqvXn6FbDT8fkeg+
 bJQxwpE4iG1WZ4nRMp205Loa71jtE+H0vur+u8xwXA6i0mzbhVYJhuHFskceMqiaoup1
 lWPu+OF1zkiED+vFoGJyzCiQfv6aamaZ6cMRWSoxY4Vjn6rS8zJGGuPFrE0jYZFZwlqF
 LwtER9eIJicKp5J8i1ZxCT1aSb/AUQGRECQZWq+NR7lF/3PdOP2xi2TtqAcjH/hQvQ+2
 68wYM0Bb3QbVkH+Yu4UenK+UcnNY3nRrka95+4TK5mPjac/KRPi73XMezqhJ2rkndyMI
 6Ciw==
X-Gm-Message-State: AOJu0Yy5k3UxfiuFNbkH89YQHIPgkb6KI1XDQ+3h0w5B9hg7z+v6xtjr
 yNvFxbO5lZVyNWK7Lglfp4p4Uw+dsLb62r9B3gmRYe2/y0S+VjiiAfFZV20OV/O+4ylZz3MkHlc
 =
X-Google-Smtp-Source: AGHT+IFhAFoSrHSr0kbiH3c26rGBsPWAFsSStCntXLFobV9/Gh1J/Por7PnudQTLjSf5JzNf9sBGdg==
X-Received: by 2002:a92:cd46:0:b0:39b:d2f:78e7 with SMTP id
 e9e14a558f8ab-39b1fb988f0mr170471845ab.7.1722949171714; 
 Tue, 06 Aug 2024 05:59:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/39] sandbox: Unmap old tags
Date: Tue,  6 Aug 2024 06:58:26 -0600
Message-Id: <20240806125850.2316956-16-sjg@chromium.org>
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
index d1500dcf32d..ac00be16cd7 100644
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

