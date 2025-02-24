Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B15AC021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFCE810F2;
	Mon, 24 Feb 2025 06:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E3u65hjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B778104B; Mon, 24 Feb 2025 06:56:26 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13ABF80F0E
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fcb6c42c47so6147033a91.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376582; x=1740981382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdmn+Nb67dTbvoAHFj1HXV2hjRKdCRhdJ0ksckbHwkc=;
 b=E3u65hjUIY0h6KJyxxU/ErwkrlqYd1WHQVAEULYu2UQMK33MVinEwAplEGp9oiZb5n
 DkX7hw3BCyY5vHdwSsWUyTvqDG7TquRgIPFWBgZ6cx/AN6LgnV+U3REizqwiTfwjend/
 kCHGS4fzFmKb5HsF+hLqkiqnCuV3yATGDq3ubwsmBAKKHkTsEPsS4Yste+ke/PAljUoI
 HKduDkdNMtbjSm4AeNAzuX3AQ2X9WAQM9HTL1nEXCKZ/wj08tUGLK/QHui2DpUIDB1Ng
 9QwF4pcMmAp11iXx1FGZzaWh+f54/PsTMqQHbZ0BcTj+vlqfsaYhgqRWDg8FwLhLJsFR
 6dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376582; x=1740981382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdmn+Nb67dTbvoAHFj1HXV2hjRKdCRhdJ0ksckbHwkc=;
 b=NMvLSp+sesvQC9PGlCSk/C2BKeNvij3lItbhQiIP6BGmowid7Wqh5Nw9GEk53iVS/1
 AeKlpFF5UXaqtXLXo72pI/W2dzTyLb1jWGJl2eJ3Svym37om1L15BP3G4BHiAt4LWyMn
 VKvfTzfd2FoIlkeLtiRl5M37zfzq8kj/2sCJSd5X08id4OzT4ZXCd1I84HI53cJsdqfT
 bCk6HI45/ogOUm4fLTdwTCYi7awBPQ5cdFNFflEa12S6uoDaD2Ti4yJh2j/frohKVjqc
 gFb76EVUmf1eBLArQNByxnCPet3TzBYBTInSC6whcsJEWGHF0uFZLDi5WCgvgDCSO7yh
 1tIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8wX1S2q2ZaQZ4QK3YZsURoj/O4Gilm/7JRI6Qjy6oAUHKKoSGWZrtJV6dOWgVHZ3nKb1wXcc=@lists.denx.de
X-Gm-Message-State: AOJu0YwFbEkFOGdqLkTavXMFrebqVCVzGN804ELczk3yn2hfp7oAzjso
 iIVn9jjIteMOqBdBhWVAqpWPddbEOyw5Mg14QaHMljZGAQg2pWz1Cp39JxKvtf0=
X-Gm-Gg: ASbGnctcBjDaXkUr8Jx1XpvBwzdNXKONZNUethvB1jYnu4RA5X6qIJvxIYSeM2A8G4s
 lkuz2iYnkKrn3vQci+PLUr7wLwVJqQXsAXH8SL/0n7VTu+u0/b4Ds4L8q0IFDc0+74Bsj6CE8db
 fBz7Y+43VVxEPjXFS+XjDlRFhMAyLGrBOYbFV8Ai4zwVLdNJPoce3Frnq3FTrFmACYdibEzeA/2
 gvjTUVAwrNruQeUxrn4v/5ODU32AHi0B8RhuycN7OP5/KMCTyJfPMaf8/nE+LBZ1IWGKTpeSdbp
 97dexQn3KE6lmXMSzkavIfEpgD1kJVFM+zgMMw==
X-Google-Smtp-Source: AGHT+IEh8/h0DjYKfKn0SreBkMCtwYrP8hIRQ6nOiH18MJuKe+5Fl3HhGyHvxBllqlq3VbB0nKTIQA==
X-Received: by 2002:a05:6a20:4306:b0:1ee:d631:fead with SMTP id
 adf61e73a8af0-1eef3cb8e26mr19991077637.19.1740376582579; 
 Sun, 23 Feb 2025 21:56:22 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:21 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 17/17] scripts/Makefile.lib: efi: Preserve the .dynstr section
 as well
Date: Sun, 23 Feb 2025 21:55:24 -0800
Message-ID: <20250224055524.1334929-18-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

This section is required by .dynamic and llvm-objcopy will exit with a
fatal error if it is not also preserved in the output.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 18993435eae..275c308154b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -513,8 +513,8 @@ $(obj)/%_efi.S: $(obj)/%.efi
 	$(call cmd,S_efi)
 
 quiet_cmd_efi_objcopy = OBJCOPY $@
-cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data -j \
-		.dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc \
+cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data \
+		-j .dynamic -j .dynstr  -j .dynsym -j .rel* -j .reloc \
 		$(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
 
 $(obj)/%.efi: $(obj)/%_efi.so
-- 
2.45.2

