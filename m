Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510C3C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7912488E5F;
	Wed, 21 Aug 2024 18:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HpoICDmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C5488E8A; Wed, 21 Aug 2024 18:20:07 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5584C88E14
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7093d565310so5157103a34.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257203; x=1724862003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+H5RGeQCdLCxKZFwPaaT0GiHF2QEAQHMFOGpbwgSWSM=;
 b=HpoICDmA7keJS+UzYKuI3+5JC1FoEuGV9ttZQ+Ii88cttj74Y/0tEy7aQXixOKr67y
 nIvOeIwhsSAuax/qoHQ2Ni8LGQ2ItUbjuEuaZQ8FWAFweHGJmvfiONX4gvVa8KbYHNBg
 HdY17tBEJevw5LuunPQiuMeP4P38Su39MT08E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257203; x=1724862003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+H5RGeQCdLCxKZFwPaaT0GiHF2QEAQHMFOGpbwgSWSM=;
 b=ekMghnTMIXe82Evatrcx2iFJq7MKLGmEyDRPMGiWdhbGwBXD7b1CQOIA/MDYplJCci
 9zN/yjXZ1PlfDcnmp6RGG9/yAAY++uDe8+wfOd8YxQaoOgCYFpgJhnGGTRK78azchA5j
 4m83bDfaLcz7uQ7sVKpDqvv2SJvZJu8yb2mS1BfBej3+NEtoxH3lRwRNxHvz0xVgSFo5
 ZxcwrdDFcKbdRzt5n1oZZg3SLNXaAvcOvA/eY2U0cH/vkmSdX4NUa6ezXSd2Cb500Hhk
 xUwZyBVXHxsITFnGi6U8L6n3IDjFM6O4uYSv2T/o28oetlybKi7RaDFLLCoCRUps9aDZ
 v2vw==
X-Gm-Message-State: AOJu0YwclaRr9H/MzTZ/dt0r9pVtrHUNSWCQGfSvoSV198fiK4c0mqkc
 uN61E6AQtPL97CtQfA2hO9rEJt6meAP8bmahl3WMWiZr0qQA2cb4+vjx7vRnIQ8ui/mGsqPE1pM
 =
X-Google-Smtp-Source: AGHT+IGvflbycqw0U3PMrboise9zZlQ+VCiEKLl0sXfHvOz9cb7v2qGaWKbW3zjkjdXSxZqmY5+5NA==
X-Received: by 2002:a05:6830:3151:b0:709:409e:528b with SMTP id
 46e09a7af769-70df87099e5mr2582477a34.15.1724257202998; 
 Wed, 21 Aug 2024 09:20:02 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 30/35] global_data: Move ulong fields together
Date: Wed, 21 Aug 2024 10:19:22 -0600
Message-Id: <20240821161927.695717-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

(no changes since v1)

 include/asm-generic/global_data.h | 50 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 774e757b179..073cadb1096 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -74,6 +74,31 @@ struct global_data {
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
@@ -106,31 +131,6 @@ struct global_data {
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

