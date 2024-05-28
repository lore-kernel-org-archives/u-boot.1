Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DB4C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4F98851A;
	Tue, 28 May 2024 16:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="o3W+1eMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F5588520; Tue, 28 May 2024 16:43:19 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5242988511
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB059400FB
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716907394;
 bh=bJshsFppkHMBCuR9Uk4CFjA6Nrp8aQvR3RIHo1fBj+k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=o3W+1eMwjuszgFacUi/cCiXP9jizFMcn7hNQG2xWeSEPPgo3yWKrarb8QiELuqR1v
 dqGHSNPRu6ke0JuPgzzhFsY1RJom3xF4gVFjErygP9McfQrVtoUZQDY7TiPvuCzX70
 CCEG5Pc637UxrlfYL6fajJOp+stIJvZcQFUwjf5eBzGHZB/BnYJYqiyhg8+6AhUCBf
 csU8lGdpz+FNj485rl0Vqy0ZReXJN5MUNIdklZA6AxrDq2ZRRNJyAzcQGRNU/Z26Ih
 Je8aR5cpdBjLTfdr7zpIM8pmxRkuQS2hVLaWtM0GHZXqbBqy+a+855XUlExIgT4Hp9
 lCVOVCESkroKA==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5786cf51b65so493784a12.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907393; x=1717512193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJshsFppkHMBCuR9Uk4CFjA6Nrp8aQvR3RIHo1fBj+k=;
 b=cYy5u+hes3SAyqfUbLHPiRwXKHZnVefq9xUsPgf7DuhPnRZy6o1D1RqOn/XXMqO8M+
 VeXNAW0F++bvj0gsHOS1bsVqMxt6LpQ6wqVOrGDAHYhvDsXc6fP/9OYUMT4AxGS91928
 soz+HvSDlPDbluH+Pijfn6mBS7262QwBukUfFOY/OzrZe3+CbafKsfKBVAvMZ2uiG8vp
 KSlZo+MHf2DMZHP+qNBaFiSE2/2p5Bd2R95xGBmDKK7vHBaEtMjbvBU8EyOAhiAu5Zvk
 ah5046eMYkw7cwjc18FHLpdxwmA5cIHEQiUnLnR03NJ+yKka+LD+OahW5q63GbYknVFD
 xl8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIu8SOawpIT/G5F4pQdG9QsUquCm881Q79kvx9BLp68tU4qXoAH2BC77Nl2Plsy1Gci6Z3ttZaU0UJ5He9/Sh2Il84bw==
X-Gm-Message-State: AOJu0Yx8xjIVSIXPoCB9sviRO/mze8Mm7+DcwFHk+LRqkI7AMvoPwI0H
 LRZt424X2wksuq3FMt+0PyWE7gfoPeOYt88zdtt7FFqlPGUjzeWtTJjqQdQfjKy+GpMfrgpCRFw
 DuZS7ZP16BwtiWPZ9zPcT0wKu7QOfV39UnDmB7iK30w+rFCZVgPEwDIIWZ+ibjJkP2nY=
X-Received: by 2002:a50:d507:0:b0:56e:215b:75c2 with SMTP id
 4fb4d7f45d1cf-578519326f5mr8001665a12.17.1716907393042; 
 Tue, 28 May 2024 07:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYpK3eZkqA3kO5L01jGT4+Wdb9HX9IVQM0fChbhtqZHhtK29kSwQDiy5Ve1PoUMpHVEwubaA==
X-Received: by 2002:a50:d507:0:b0:56e:215b:75c2 with SMTP id
 4fb4d7f45d1cf-578519326f5mr8001647a12.17.1716907392683; 
 Tue, 28 May 2024 07:43:12 -0700 (PDT)
Received: from workstation5.. ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578f47126f0sm4914986a12.91.2024.05.28.07.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:43:12 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 7/8] efi_loader: export efi_load_image_from_path
Date: Tue, 28 May 2024 16:42:51 +0200
Message-ID: <20240528144252.179247-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
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

We can reuse this function to load the device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Move unrelated changes to different patch.
---
 include/efi_loader.h          | 4 ++++
 lib/efi_loader/efi_boottime.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 1b4bc987a23..ab7bed22971 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -664,6 +664,10 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 				   void *source_buffer,
 				   efi_uintn_t source_size,
 				   efi_handle_t *image_handle);
+/* Load image from path */
+efi_status_t efi_load_image_from_path(bool boot_policy,
+				      struct efi_device_path *file_path,
+				      void **buffer, efi_uintn_t *size);
 /* Start image */
 efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 				    efi_uintn_t *exit_data_size,
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 630c5f52c4f..eedc5f39549 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1996,7 +1996,6 @@ error:
  * @size:		size of the loaded image
  * Return:		status code
  */
-static
 efi_status_t efi_load_image_from_path(bool boot_policy,
 				      struct efi_device_path *file_path,
 				      void **buffer, efi_uintn_t *size)
-- 
2.43.0

