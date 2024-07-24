Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CE8C3DA7E
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC6A889F6;
	Wed, 24 Jul 2024 17:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ba1uLhK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C11A88A31; Wed, 24 Jul 2024 17:10:08 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DABE889F1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-38f69f73966so14490545ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833805; x=1722438605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pc4Mqowuk11SZdzwUZTnqJoRUpb3p1nDs5QazF2+/Gs=;
 b=Ba1uLhK4JHhKrVnahtuqGXQVXsFrdxRdfgOE034l5UbIBdC2cB++SzPVGY1JlruNc/
 JP5ztwmXpt1fQb0FqG4XpvfwTY6JtEFFJjdAWSrXAZuNiuUW6Xbwd/lbKHFSVuS8bv8w
 R/7ZhhxoIoaz1iuK8Sn6hMLSUwPUU3mqFumAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833805; x=1722438605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pc4Mqowuk11SZdzwUZTnqJoRUpb3p1nDs5QazF2+/Gs=;
 b=MPZT++ByLyFUUHf8bUa/AmwfPZ+0k9ARb8zQJtW59NRA7Pd318UwrPv9DyekbDsvsZ
 FXxTkfqi2nl7fHp6QOYolbgb74ZlQ6hOtCV5E63NuFm1PsMNRYbPOOAnTLuSTwH7vc9s
 MmQ8IsZ4LhP+nHRwyFVHnjb1J6uuqeVI4iqBT2HgfznsTkXFpZeYbd6VfElaAJMnBG1d
 NhJZYtk6rJYXGQ6EiRXdxghe2o2vJpVY4LYae1k6eQ2kohxcGHzjFQjnGvsuonMp8rtQ
 VJAkW1IpIufNVwLuIy39ogooXAKJ1krNfMb2iDnqRowrCNlt/A7O2Kav4povUeyk3Zc6
 W+sQ==
X-Gm-Message-State: AOJu0YyDrmKA9YFNB8w2ih0E35QGs/OnFqklz4g2OF6QxLFqRnci5MJU
 2Q8EjNAjugdTb1awBMRhVsDOCHSKWeRx3H0rapxkAr/jVGcAHc+BxGXZYa5gTHIzd514tYFvSfI
 =
X-Google-Smtp-Source: AGHT+IGo+Lp5GyAXqmu2WXwZf1E3SIlZPoPsWXdi2GKtTz4u75zkrVDLcDYZBJs2DBIjqW7slQ3ncw==
X-Received: by 2002:a05:6e02:12e7:b0:375:dc39:cfd2 with SMTP id
 e9e14a558f8ab-39a1926091fmr27867395ab.11.1721833804044; 
 Wed, 24 Jul 2024 08:10:04 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 30/35] global_data: Move ulong fields together
Date: Wed, 24 Jul 2024 09:09:17 -0600
Message-Id: <20240724150922.2343249-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

Move all the always-present ulong fields next to the others at the top
of global_data

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 50 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 82c74dee161..005c79c6a7d 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -73,6 +73,31 @@ struct global_data {
 	 * environment variables.
 	 */
 	unsigned long env_addr;
+	/**
+	 * @ram_base: base address of RAM used by U-Boot
+	 */
+	unsigned long ram_base;
+	/**
+	 * @relocaddr: start address of U-Boot in RAM
+	 *
+	 * After relocation this field indicates the address to which U-Boot
+	 * has been relocated. It can be displayed using the bdinfo command.
+	 * Its value is needed to display the source code when debugging with
+	 * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
+	 */
+	unsigned long relocaddr;
+	/**
+	 * @irq_sp: IRQ stack pointer
+	 */
+	unsigned long irq_sp;
+	/**
+	 * @start_addr_sp: initial stack pointer address
+	 */
+	unsigned long start_addr_sp;
+	/**
+	 * @reloc_off: relocation offset
+	 */
+	unsigned long reloc_off;
 	/**
 	 * @bus_clk: platform clock rate in Hz
 	 */
@@ -105,31 +130,6 @@ struct global_data {
 	 * @env_load_prio: priority of the loaded environment
 	 */
 	char env_load_prio;
-	/**
-	 * @ram_base: base address of RAM used by U-Boot
-	 */
-	unsigned long ram_base;
-	/**
-	 * @relocaddr: start address of U-Boot in RAM
-	 *
-	 * After relocation this field indicates the address to which U-Boot
-	 * has been relocated. It can be displayed using the bdinfo command.
-	 * Its value is needed to display the source code when debugging with
-	 * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
-	 */
-	unsigned long relocaddr;
-	/**
-	 * @irq_sp: IRQ stack pointer
-	 */
-	unsigned long irq_sp;
-	/**
-	 * @start_addr_sp: initial stack pointer address
-	 */
-	unsigned long start_addr_sp;
-	/**
-	 * @reloc_off: relocation offset
-	 */
-	unsigned long reloc_off;
 	/**
 	 * @new_gd: pointer to relocated global data
 	 */
-- 
2.34.1

