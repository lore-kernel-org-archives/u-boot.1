Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E90D6911A
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 577A389D61;
	Thu, 28 Nov 2024 16:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l1rPjv7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6247F89D62; Thu, 28 Nov 2024 16:48:16 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A670589877
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea4f9825f6so493871b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808891; x=1733413691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJfjj+hch6G344+fNVo0t0ATt3AlcMwbbCRF37cqoHc=;
 b=l1rPjv7o2/DdV8sswO5C9Bt0iQfvTj62vc83qMBKcDa+RSjnNA0rUDDP2CYgkCvpro
 niauA8Qyi2/bjPFtmJDljsfWHVe53yzOPa/ajjwm9umNtyVwGAtF0/uDRX7ObcsA/SoZ
 4Cs0jJYUO5oxwBaEebE3YB241pQE1BJMxrN+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808891; x=1733413691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJfjj+hch6G344+fNVo0t0ATt3AlcMwbbCRF37cqoHc=;
 b=NSMuHeVEfnwWJoBmKK2k/quJpbQuITK6fPk7dWGd7J5rLryHj/gcfg8jLv7CP4hNgA
 1e4aI0R9DzUpDCLFUNyKE32Jbm3QdPRbbiFEN0ckXUsKnWS1RafTEqS4WG+CMuu+yxA3
 Ho6E8m3f0oKTSBlQwoFm7OTziv6xeVGf4JSHOu4pDHgowHxZR79b4q4L8og/IlPvb4ZX
 ESNOHyQY+w9mz05o/9c1B/rEzhBWNIMv1I2eQCHY6R7jaECykBh7zNMT6zeLmfxhfZdc
 +ZF2wau9GPfhDDit+pcs8iVYji+ZL2FzWqXF3/AgzxUjvADmlOV6y9iSgnCvUHtjeTNp
 YssQ==
X-Gm-Message-State: AOJu0YxWfAtPNsdBtkcbdKIPdrMDKFJhWgL2qqQ+13dlLVDlYep9E1A+
 E47OTkY0H6HDTgvlz4Xg9aUDBT0Eh3bDAQ2df4esC+snKD5HDCe+Y4x1sAOB0P12AljXam8TUTg
 =
X-Gm-Gg: ASbGnctkbz5FaWe5pv2lr6KMlDtb66JhoaISKHCUGymaaxipd2ErTG54HODCI0PUROj
 Ujuw8AeA98rgPkDpjVv4wkgOh2g2ImmNtFLEJw9S6AN+MiJYNH8MRBIxwFPv+5RLIB88y6Bkpad
 dDmHybJOTnOVSpYXwUax3T++E4+asF1ykNgGJgOJVVyKCCiy/ES3cPBqmm7zPrgbkXfTp4tZEJ1
 phaik1ru9xC9VPMUM9vcxpE40Awhmf8fLfv8ack1mDF6g==
X-Google-Smtp-Source: AGHT+IES+bLBF79UiM14NSWTqMimT4ym50TDpDGIsrl0BVS+RY2g8UK57bTE6fV7F/fpwDV2HruCUg==
X-Received: by 2002:a05:6808:2018:b0:3ea:4c54:51f3 with SMTP id
 5614622812f47-3ea6dbd2df0mr8357103b6e.16.1732808891569; 
 Thu, 28 Nov 2024 07:48:11 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/28] efi_loader: Use the enum for the memory type in
 priv_mem_desc
Date: Thu, 28 Nov 2024 08:47:12 -0700
Message-Id: <20241128154727.771871-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

