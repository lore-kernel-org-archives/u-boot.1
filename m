Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5C4D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7779E895F3;
	Sun,  1 Dec 2024 16:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HE+Lmztc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF5F589287; Sun,  1 Dec 2024 16:25:56 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C2F895F3
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-84183532291so130543339f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066749; x=1733671549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTJHOva0M45l9DQJ5JOlBUIy/T58CVGe2ig2AnkYEwY=;
 b=HE+LmztceV8HjY9RclwzQAaboGTWfUR/eb76496mSFqWdvp7dDNQpWuLhN8SETWInO
 JPIX+PDRpY/kfhp4TcVfiWcs/T9hEB2RBhCRuoFsdb2k1ZzOVOJiFZPxoauJ8MWyymlH
 5K1QBhFXciIsN9K+vfzVP0ScWlYzgVDNIWHkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066749; x=1733671549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTJHOva0M45l9DQJ5JOlBUIy/T58CVGe2ig2AnkYEwY=;
 b=jaVA7PmA9e4USUpYS842sGnqVMKW39k4DW+ovqUSaVC+wx6z3DeCTxi7iyIQsMPWiq
 1U8rOdXuEG/fbTshLAR3AdtjXwWnSevl87+GnusFOFCW1bTWuNK+swflg9xqD8vwrkm+
 BiqUQ2nrDh12lFf9GxqnvZpV/A3qcr9ZUbRHKBx+c/U7gukVlqd08BF7zb0QH8rwyF6u
 IW05FxbzgW4t7bDNAIBJEcoS60NRELF0dsbVWz6Ccat97JEs4My+TbvT7jhXId1pKsq6
 WyxV/eRVEoVT9SgQn+j+ZP2zf0xXvxZXTFEb+5UuoMyYM2gX25A/3ByFojvQChsAbwAB
 xppQ==
X-Gm-Message-State: AOJu0YwWGHGcZTrPToopq2g5YKDK2/Jr87ZI40VtdENIu8XA2N5OAcBk
 IYzhYOCqdjEFedLe7fSTFqlO6z9UjkfM17DcVJv/mgUNtocjp4VZ2bZ7MHOiSM4CAyI9TjyTmts
 =
X-Gm-Gg: ASbGncvCYhGuCEBoISVgjhs6Ll2ZjGXbIaJhzc23Vs8CEfLEnUgJxRKJ1rp+F1C59+S
 hJjBrNMCVIo4I7DTpu3R3Uja2l0UHTd4gds6KfeFd3WGbTCHD+/NjSwKInKYAdDPmerezWwZs66
 ILzBeWD5Ah4ojewbbOYwo4UJMLVq8S+z62O7kJhm1BJ8w4BEt9E2HnKj1SKLRRY7RpH8d9Y6/5c
 Gnmy0Up7sj1sXG1dixymja6KfAui/iSBepjGeNrIb+S
X-Google-Smtp-Source: AGHT+IFaklJ9l+S37bQMw7frSV9dcK5pcrFcczz/BiCzREgfq0WQcrQyemT8Qrkq8uRuGZRkKEs6pQ==
X-Received: by 2002:a05:6602:148a:b0:843:ec18:82e2 with SMTP id
 ca18e2360f4ac-843ed031abcmr1982421639f.8.1733066749420; 
 Sun, 01 Dec 2024 07:25:49 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 13/25] efi_loader: Use the enum for the memory type in
 priv_mem_desc
Date: Sun,  1 Dec 2024 08:24:32 -0700
Message-ID: <20241201152505.1666789-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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
2.43.0

