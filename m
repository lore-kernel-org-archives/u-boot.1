Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1907ED59D6B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F52789A7C;
	Mon, 25 Nov 2024 21:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cBOJE35g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DA689A73; Mon, 25 Nov 2024 21:45:16 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5357089251
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a761c7c4fbso17229445ab.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567512; x=1733172312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YM9TtiaIB0Ney66vXds8cpmze1Xt4dBZ8efIgObeoo=;
 b=cBOJE35gkpZ9Pb8GdGEyIt8A1YMp3BOfijMnFczDZTiJprNfMr+/Q6Lsq3dBW4gGwD
 yOg1J5XnohFyKTwu99uoczDXL75J81YKniFMPHsgAHXsR6/RNBROTmfb0MAiCTQ3/Nd2
 13DxwKTfXri1C4vgL1/Jcilyfcnci36ToLHoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567512; x=1733172312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YM9TtiaIB0Ney66vXds8cpmze1Xt4dBZ8efIgObeoo=;
 b=k1BsHHXYemBOMnVUUm559WAtEsgV7VYRIgIMAxsfXVKes503j7ZjMoRXLyG+ltr8kt
 gbhMXPGdfM57w8JXbElergDCffhucRvjGag1WmVYJOoxjZwMmMh3fFt+/FqS/3yQf9/k
 /ifW8MvO/bZHY9/X+VOZNE0AZfYDamX7oGt9naQsUx54YsAZ9vXw4RX3yty+Vts+lzp8
 HK605kJsnmZV5ivbKuf2I5ZBGQnIFoTVl76u/eTnck9KSAYi1qyXD89zzlB2197ZVLrx
 qqgNF0wc7kNPNaGBI5fIfQlHCBJvet+P6ffgkLSkYGfTIC/ffzSYk7DCWql3c4skNrgW
 S+tg==
X-Gm-Message-State: AOJu0Yx1yFRthpwhyob9I+zvEsXlZro26j73Dad7SCmqSHC3Y4OWN9mf
 rve7kkiQMkynzsynyHp1TjEmeGkh5Lzw6s+j1iK+4+2HJISchYB1DHXia5a1RloASUDBaUF51ZI
 =
X-Gm-Gg: ASbGncuv0REmpeNRgnshOHBRJthJ5Q/rTdFMYFzIdt/ckNBuXYWwvj7+TMFW5SoffKu
 h3wj/CVL7lVkFR52C9t5u3wHMXilH9bVZGC6XgST+aueTZHpuC0zhMMBpvrjJcj36dd/h0ASOcD
 FumCTAPZz4t8fJVfMI3taOVwDkZ7gxs0zw+dQIb6U0vEkj9iGKbWpOiNtuGlBEXZODKX/OOeBhu
 Y+YXdlFwYUXK2gHlDY4Tg8lrFZ3MlekF6MX3T/7Si/pc2I=
X-Google-Smtp-Source: AGHT+IEVOptpTie27Oa+eWe0ju3V+IJAirWNnxwyCjHeYjX5YNrdZdVw7WWBZmxG2i3+tLgqfKkqoQ==
X-Received: by 2002:a05:6602:6010:b0:83a:a96b:8825 with SMTP id
 ca18e2360f4ac-83ecdb2f0e2mr1645639539f.0.1732567512548; 
 Mon, 25 Nov 2024 12:45:12 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 01/13] efi: Define fields in struct efi_mem_desc
Date: Mon, 25 Nov 2024 13:44:40 -0700
Message-ID: <20241125204456.1525752-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
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

There is quite a bit of confusion in the EFI code as to whether a field
contains an address or a pointer. As a first step towards resolving
this, document the memory-descriptor struct, indicating that it holds
addresses, not pointers.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/efi.h b/include/efi.h
index c559fda3004..6f48c6569d5 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -273,6 +273,21 @@ enum efi_memory_type {
 #define EFI_PAGE_SIZE		(1ULL << EFI_PAGE_SHIFT)
 #define EFI_PAGE_MASK		(EFI_PAGE_SIZE - 1)
 
+/**
+ * struct efi_mem_desc - defines an EFI memory record
+ *
+ * type (enum efi_memory_type): EFI memory-type
+ * reserved: unused
+ * @physical_start: Start address of region in physical memory. Note that this
+ *	is an address, not a pointer. Use map_sysmem(physical_start) to convert
+ *	to a pointer
+ * @virtual_start: Start address of region in physical memory. Note that this
+ *	is an address, not a pointer. Use map_sysmem(virtual_start) to convert
+ *	to a pointer
+ * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
+ *	bytes)
+ * @attribute: Memory attributes (see EFI_MEMORY_...)
+ */
 struct efi_mem_desc {
 	u32 type;
 	u32 reserved;
-- 
2.43.0

