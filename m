Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3458EC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E8B871A1;
	Sun, 12 Nov 2023 16:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RzhGYlFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1599387203; Sun, 12 Nov 2023 16:28:04 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F305287185
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7b006f7c473so78955039f.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699802880; x=1700407680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1AyIuy5pB+FvvmVhFPd9ZvAuxNbhgat38ELE/YhOOI=;
 b=RzhGYlFqaD5+AxPWQi52vt/yOnCabEk/KSjxxdvA3H2Y1Ukv4IUD2f0G35FzpOwNkz
 y4se9FBZI9QPKwv1Jxo7fmbgd5epVyw9pueqL6/uQYYOmucU701IENdA69toWvZLBxV4
 7u4GEO0AtfLpkg/2Ulj03oslLbrWjxU6+A6Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699802880; x=1700407680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1AyIuy5pB+FvvmVhFPd9ZvAuxNbhgat38ELE/YhOOI=;
 b=dbw4MmQ/HBr6A2siDieUOPJF/kpL3gNmnjdXPMfpQvD13RZ1tOkXpGrECTrBt0dZlH
 2qcrTPNoaxXTGXL77/ey3TjmWeZlSQnEW4BtWG1L21aNvroKieynWwAbpPTJIUGAWjsZ
 Fqxn1doABLnmPpWbqCl3fRP76/SCwsgpZhGvN6Wrf6L9IDrIHDyhQQYE47pOjIdhPU2F
 InLJyeKpAIurszWHgUbgjo0iNjiASvAzFAx/BdH7f0LnZo1aypLyqq7mf814n4ONGecS
 c8yVN1QmMNuhx4EzVffx+Lb+Lv2HxgGdDaynDhOA3jfbWj4DzM/5XM6Cm8YD5Rg0UGU2
 am+A==
X-Gm-Message-State: AOJu0YxeuOKqydU5Z/Avbj3yVqsSTJHqFM/g72hB+ws6R48WXRcILeFz
 8nD3oad1BNjTZlRgG1W+VxReAXTviWnSGvG7l7J0sA==
X-Google-Smtp-Source: AGHT+IFyoVYry/Xj3he+pKJKT6nNioArcOOmM6VkiQLThIaSomuJ3tCBv5mXzAKELtu5aIvlwAQqCg==
X-Received: by 2002:a05:6602:2e12:b0:79f:e9ac:f60a with SMTP id
 o18-20020a0566022e1200b0079fe9acf60amr6815821iow.20.1699802880500; 
 Sun, 12 Nov 2023 07:28:00 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 76-20020a6b144f000000b0079fdbe2be51sm1226241iou.2.2023.11.12.07.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:28:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Dhananjay Phadke <dphadke@linux.microsoft.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH 3/7] fdt: Improve the comment for fdt_shrink_to_minimum()
Date: Sun, 12 Nov 2023 08:27:46 -0700
Message-ID: <20231112152754.130399-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112152754.130399-1-sjg@chromium.org>
References: <20231112152754.130399-1-sjg@chromium.org>
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

Add a bit more detail about what this function does.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/fdt_support.c    |  1 -
 include/fdt_support.h | 12 +++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 09ce5828659e..510ad24a999d 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -722,7 +722,6 @@ int fdt_record_loadable(void *blob, u32 index, const char *name,
 	return node;
 }
 
-/* Resize the fdt to its actual size + a bit of padding */
 int fdt_shrink_to_minimum(void *blob, uint extrasize)
 {
 	int i;
diff --git a/include/fdt_support.h b/include/fdt_support.h
index d967118bedf0..791258ec7eff 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -242,13 +242,23 @@ int ft_system_setup(void *blob, struct bd_info *bd);
 void set_working_fdt_addr(ulong addr);
 
 /**
- * shrink down the given blob to minimum size + some extrasize if required
+ * fdt_shrink_to_minimum() - shrink FDT while allowing for some margin
+ *
+ * Shrink down the given blob to 'minimum' size + some extrasize.
+ *
+ * The new size is enough to hold the existing contents plus @extrasize bytes,
+ * plus 5 memory reservations. Also, the end of the FDT is aligned to a 4KB
+ * boundary, so it might end up up to 4KB larger than needed.
+ *
+ * If there is an existing memory reservation for @blob in the FDT, it is
+ * updated for the new size.
  *
  * @param blob		FDT blob to update
  * @param extrasize	additional bytes needed
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int fdt_shrink_to_minimum(void *blob, uint extrasize);
+
 int fdt_increase_size(void *fdt, int add_len);
 
 int fdt_delete_disabled_nodes(void *blob);
-- 
2.42.0.869.gea05f2083d-goog

