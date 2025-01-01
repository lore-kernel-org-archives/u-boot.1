Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE54E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A2B8042F;
	Wed,  1 Jan 2025 23:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Imz4qv0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D678B803CC; Wed,  1 Jan 2025 23:22:12 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB01803B7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2165cb60719so147949915ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770128; x=1736374928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Y4L1nNiM9iqlK8TB33MqbWcdZ5+BGiu142cFJatQ80=;
 b=Imz4qv0lB192suO8/DyX2uLM12p0biPrh0KgXY3B3X0gxikVHMJ0t/cfbu1bBEMRFb
 yxqZr3evN3+G/xWblpbywxuYsvmcdO7p9DNTkyCeFwJs9puvmkysMeTBMMNw3Qmt9qZC
 Iazq1c1ZCTjk9uy1xhyjMKPGfSbBSjbmRcbSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770128; x=1736374928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Y4L1nNiM9iqlK8TB33MqbWcdZ5+BGiu142cFJatQ80=;
 b=sITtZXfutdVaWBvOXRaZ6XRI3vUNBu/DTzPmBu0gej3k1BAYwsPL+zsIzlOyDOMit+
 9z69/z37DoFtgAN9zV5oT/dlVheMPEv0BaKBWvp3zyy72fYgGJCJ5bfkdKpaEA/YhCjK
 3VzRje8ZuRPANAC7Gyne2Y293R/xLX/PV7z8CkXaGq2J7VXHW3i6kXPtgdFKtZ/SuDr3
 KIeEY0gOFfOZNthuvXvbOWdCwq5bmifoxtn0iYGW94/BIqdXUIEurreHga5xPo6r1Epo
 nkOdddx1HZXXZ28QHkGKR8S/rdNpj9utskTvfPhITYwgESMkX5QIUUT6TvS9iwxF0o3J
 jRwg==
X-Gm-Message-State: AOJu0YzHmE+ZMf2M93cYy1JqV4SXJaJ955DuMb2lHKdPuxrU4GjurhJ+
 T2VrvEDvnQmhjrurKwHSqG3MMbnJ99tZm+NMhiiMHoYlJACIRUl5XghAHGq6tXb95Lr+I2AzrV4
 =
X-Gm-Gg: ASbGncs2Hu0URlPNinHv++535DqIRXMsARRTE7QitR1UEzPRrRdUEuNx2+r6u+NoQlB
 YfClT3iZjjJuvLx+XIUQizi4inNocfmSUm/JI8cIbDRk/YcppqRx7MFi2BnGmCp1M0udg8y+uVk
 Tcv/CVv2j0ndzmuqYg0t0LcusFT7HR8HQ0YJIkbmAiZL9cBaxJ3QnZEawcfq07SQfLsRsSFUaa5
 oTADf9WOBVNy1VHJNaAVAK2UHhTm6nV10NFIDD7FCGxBPGuUyyxvcQ=
X-Google-Smtp-Source: AGHT+IGEkLJfkvtaKbWzhps1TnjwMBaKfLDE61FSe0+s2ivxYOnb/Ehb5qdc14jTj4hGthDVIzBqoA==
X-Received: by 2002:a05:6a20:c88e:b0:1e1:cc93:f109 with SMTP id
 adf61e73a8af0-1e5e07ffd6fmr72528648637.29.1735770128588; 
 Wed, 01 Jan 2025 14:22:08 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 43/67] upl: Add RAM to the memory region
Date: Thu,  2 Jan 2025 11:09:29 +1300
Message-ID: <20250101221003.1944600-44-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Indicate the address and size of RAM in the UPL handoff.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_common.c | 22 +++++++++++++++++++++-
 include/upl.h     | 12 ++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/boot/upl_common.c b/boot/upl_common.c
index a5a1da9cb57..e60f22f47e0 100644
--- a/boot/upl_common.c
+++ b/boot/upl_common.c
@@ -136,6 +136,7 @@ int upl_add_graphics(struct upl_graphics *gra, ulong *basep, ulong *sizep)
 
 int upl_create(struct upl *upl)
 {
+	struct upl_mem mem;
 	ulong base, size;
 	int ret;
 
@@ -148,7 +149,14 @@ int upl_create(struct upl *upl)
 	if (IS_ENABLED(CONFIG_X86))
 		upl->addr_width =  cpu_phys_address_size();
 
-	/* no reserved memory */
+	memset(&mem, '\0', sizeof(mem));
+	alist_init_struct(&mem.region, struct memregion);
+
+	ret = upl_add_region(&mem.region, gd->ram_base, gd->ram_size);
+	if (ret)
+		return log_msg_ret("uar", ret);
+	if (!alist_add(&upl->mem, mem))
+		return log_msg_ret("arg", -ENOMEM);
 
 	ret = upl_add_serial(&upl->serial);
 	if (ret && ret != -ENOENT)
@@ -181,6 +189,18 @@ int upl_write_to_buf(struct upl *upl, ofnode root, struct abuf *buf)
 	return 0;
 }
 
+int upl_add_region(struct alist *lst, u64 base, ulong size)
+{
+	struct memregion region;
+
+	region.base = base;
+	region.size = size;
+	if (!alist_add(lst, region))
+		return log_msg_ret("uar", -ENOMEM);
+
+	return 0;
+}
+
 void upl_init(struct upl *upl)
 {
 	memset(upl, '\0', sizeof(struct upl));
diff --git a/include/upl.h b/include/upl.h
index aef23ad8e8e..5ddcd990de4 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -416,6 +416,18 @@ int upl_create(struct upl *upl);
  * Return: 0 if OK, -ve on error
  */
 int upl_write_to_buf(struct upl *upl, ofnode root, struct abuf *buf);
+
+/**
+ * upl_add_region() - Add a region to a memory-region list
+ *
+ * Adds a new entry to the end of a list
+ *
+ * @lst: List to add to (struct memregion)
+ * @base: Base address of new region
+ * @size: Size of new region
+ * Return: 0 if OK, -ve on error
+ */
+int upl_add_region(struct alist *lst, u64 base, ulong size);
 #endif
 
 /** upl_init() - Set up a UPL struct */
-- 
2.43.0

