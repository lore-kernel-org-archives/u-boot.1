Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A0FD70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE93C89D6E;
	Thu, 28 Nov 2024 20:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P9GdBzS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E3C89D35; Thu, 28 Nov 2024 20:13:26 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD8189D14
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71d4182b2cbso433822a34.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821202; x=1733426002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJfjj+hch6G344+fNVo0t0ATt3AlcMwbbCRF37cqoHc=;
 b=P9GdBzS5ZXgxdr+QgZYG8eoyVYYZ9aGv7fnwqNKy/jcrMvD9D88gT84hEpCICk4OBb
 W0NTpfRKKDxqSpFlBjQLihokjE/TJ/M2sIvMNkTwfntjKC7saH04IaqnoVDSpryldavg
 V3ez0IQKd2h26L0dF1Dq4RYOe23xW54UmyB0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821202; x=1733426002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJfjj+hch6G344+fNVo0t0ATt3AlcMwbbCRF37cqoHc=;
 b=KBNtK9i6WS0n5bVeAbQ2gRbNXkosUynELuay0mmLVeHbzSIjJYh9EsuBpubR86NtsV
 C1kZw+pjYIAjl02fGEXorb6uUIEzmvpUS9AZK4rQxTyqQQj9isgldqCnjNQPVMTMYYR0
 52JoMPa+TzCwDl3guX9/w3ryTBFCgrI1nkQAhqGRhBXkqv4Wtzehq+fvQnYFx2lREJvC
 KMs+CuZzVyKHoodVjybgDeICII7OFJodwg2u9RYpCnsRGppoaOIIWkCyzXs/CULLo4jo
 DG7Eu4qO8pC0yxtRj42PCfdnK3D4F5bTHMH4GQLp17zZt7HtGD1ArjxhRGOYw2UnBkY+
 Aa+Q==
X-Gm-Message-State: AOJu0YxgxyugZaWFDhrDNAskk/YXtbno+AIa+9vtY5LaCk7jt154SlIA
 QtWmxDWEU3tqacS1ZTYMOB7qN+Nglx3QV8AfXGIoGX5D6dUOVKjCrkJcQJCF0KlvVAX4mx9jqFc
 =
X-Gm-Gg: ASbGncu4Mlz+4oO93MWhxLjprktScBiPa786cqAuP2fF5S88+BsRnB/LwsO77DMimCu
 ux92oUwk0Sqnkprqio78L0MWeoEwvFKphncz6/ZIGN0+iGtu3kJiLDcosbDLNJdiMiCsX//JSNT
 gwmWc8V2JIA8FrOviMDRHeof3kvCjdvJ3jZrtZXnR70AmcZxesxDnCksqB5uE/vS6qYKyhKD3VB
 Q+QNlr+Zp3HD9zhBI58r43eY1jXFbiiY8q5CZFdJrUnIA==
X-Google-Smtp-Source: AGHT+IENW99ejVSlca9QPspC8QJ1tYGVaG5l9lwvYJiyuHncwer3FNXy2NWKT1ytkz52GBXvpMkSMg==
X-Received: by 2002:a05:6830:3898:b0:71d:5209:5cec with SMTP id
 46e09a7af769-71d65c7e4b8mr8536138a34.3.1732821202007; 
 Thu, 28 Nov 2024 11:13:22 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 13/28] efi_loader: Use the enum for the memory type in
 priv_mem_desc
Date: Thu, 28 Nov 2024 12:12:29 -0700
Message-Id: <20241128191244.900006-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

We can make use of the enum now, since this struct is not exported to
the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 81e40fc923d..83f2e32b9a4 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -34,14 +34,14 @@ efi_uintn_t efi_memory_map_key;
  * EFI application, other than through calls to efi_get_memory_map(), where this
  * internal format is converted to the external struct efi_mem_desc format.
  *
- * @type (enum efi_memory_type): EFI memory-type
+ * @type: EFI memory-type
  * @physical_start: Start address of region in physical memory
  * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
  *	bytes)
  * @attribute: Memory attributes (see EFI_MEMORY...)
  */
 struct priv_mem_desc {
-	u32 type;
+	enum efi_memory_type type;
 	efi_physical_addr_t physical_start;
 	u64 num_pages;
 	u64 attribute;
-- 
2.34.1

