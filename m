Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36B0C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D81D188E78;
	Wed, 21 Aug 2024 18:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HftfjwEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778F888E65; Wed, 21 Aug 2024 18:20:09 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3273D88E7B
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-70cb3eb4461so372897a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257204; x=1724862004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1nDsHUYkYE84Z0B2mh1jdgW3YLV67Zg2xUBPNLIpfs=;
 b=HftfjwEt51FDq7qFqk54pIh/GKYLIpujCgIrUM/Ld88YkGtVfhQD8d8dQo4Tp340r4
 ZvqZgWZDfp3fYWcmhKN9xerm4xU2aNH/DlvQCZGpGNgi02dt3gsOvamKSClOD8Humhya
 Lq8au25jdHuRPfQVogpxcoddHNNF6fp+PI8Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257204; x=1724862004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1nDsHUYkYE84Z0B2mh1jdgW3YLV67Zg2xUBPNLIpfs=;
 b=Rre/vS+beHteQbPpvdEgWK/gmEJJoyoj+FQ8d8LiGecA2Lu5jMHemFE3EFDi6P7Bba
 VYFCTfI5swZYPX7NCI9oMh+9EErMZZJmdNwHfP43rxwlxDG4XRYlJj+uPe+jnYqG+XGN
 Lj+jbVzLfVhF1oTdDYoUPQumjMf/Hs/clxTPHkNEtoxyRKd5XMnp6Z8WWE0CzzYCAmsu
 +Y3JWWT7Bl9Dc6jVGnuE6j6Ffkl5zhlap+aI+3GS7bAltFSrIIqB9ONgrspFGYx/tV6X
 RQ7rmEjh9cmvZe++TGhFfFXB7pkni2u1Fm7bby0ZY/C4CcVRKKbja2Sg0PHxfHiedzDd
 YI6g==
X-Gm-Message-State: AOJu0YzEYPHoQmor6YPpCC5fFzg8F+SqSBoS0Ej2EML3UbeqvZ/cllcF
 sc4NfdBTDGbncFM1/nYHVxjstIdqFcp47lGZCuDkRZANDoSNA9T41QxPWYl7S462B9To2ncE/Oo
 =
X-Google-Smtp-Source: AGHT+IGv4k36ayaT9s1Zgv8JzgSzKqUXigtF8i9UWJq6xYFRz12f5GG657poRwa2w9D+LlFhwb4fYA==
X-Received: by 2002:a05:6830:6d8a:b0:709:3e6c:a7d5 with SMTP id
 46e09a7af769-70e01baa798mr65367a34.14.1724257203769; 
 Wed, 21 Aug 2024 09:20:03 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 31/35] global_data: Move pointer members together
Date: Wed, 21 Aug 2024 10:19:23 -0600
Message-Id: <20240821161927.695717-32-sjg@chromium.org>
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

Collect the pointer members near the top of global_data to help with
alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/asm-generic/global_data.h | 38 +++++++++++++++----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 073cadb1096..46763ef36bb 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -43,6 +43,25 @@ struct global_data {
 	 * @bd: board information
 	 */
 	struct bd_info *bd;
+	/**
+	 * @new_gd: pointer to relocated global data
+	 */
+	struct global_data *new_gd;
+	/**
+	 * @fdt_blob: U-Boot's own device tree, NULL if none
+	 */
+	const void *fdt_blob;
+	/**
+	 * @jt: jump table
+	 *
+	 * The jump table contains pointers to exported functions. A pointer to
+	 * the jump table is passed to standalone applications.
+	 */
+	struct jt_funcs *jt;
+	/**
+	 * @cur_serial_dev: current serial device
+	 */
+	struct udevice *cur_serial_dev;
 #ifndef CONFIG_SPL_BUILD
 	/**
 	 * @boardf: information only used before relocation
@@ -131,33 +150,14 @@ struct global_data {
 	 * @env_load_prio: priority of the loaded environment
 	 */
 	char env_load_prio;
-	/**
-	 * @new_gd: pointer to relocated global data
-	 */
-	struct global_data *new_gd;
-	/**
-	 * @fdt_blob: U-Boot's own device tree, NULL if none
-	 */
-	const void *fdt_blob;
 	/**
 	 * @fdt_src: Source of FDT
 	 */
 	enum fdt_source_t fdt_src;
-	/**
-	 * @jt: jump table
-	 *
-	 * The jump table contains pointers to exported functions. A pointer to
-	 * the jump table is passed to standalone applications.
-	 */
-	struct jt_funcs *jt;
 	/**
 	 * @env_buf: buffer for env_get() before reloc
 	 */
 	char env_buf[32];
-	/**
-	 * @cur_serial_dev: current serial device
-	 */
-	struct udevice *cur_serial_dev;
 	/**
 	 * @arch: architecture-specific data
 	 */
-- 
2.34.1

