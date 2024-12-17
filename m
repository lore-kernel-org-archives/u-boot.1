Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4362E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BC3802E3;
	Tue, 17 Dec 2024 20:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pc3dHzXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB5280291; Tue, 17 Dec 2024 20:47:17 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A87080107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so2600465a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464834; x=1735069634; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IcNXh8btDIi21vWQ3yxrp0KX/npRSDBsMmpVUiocmzE=;
 b=Pc3dHzXbIlhPpj+Fz08+Q5T7PdXZ6oiYHkRN5TciK0r144f7vDDf9uHJOFIRUX9CDl
 a035OFqKY9zEOvZPxk14XdiVVLVJuwWFopdbWiN2xncKwXOH2hBXwvXX5weVem38XNVg
 7b/Qj5skAiKJ5H9ud1u+dNl3Juy7GbglHBwSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464834; x=1735069634;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IcNXh8btDIi21vWQ3yxrp0KX/npRSDBsMmpVUiocmzE=;
 b=lDsK+LqA8gH9/0zWFsRAbrmgcIaqtaCdAcLmTa/GcBBvEYE2aHt9lLxn6BpsMBnezE
 +anU2JSwtGXIl9BKsPU/v8pZI2PNJutxVal2sXQfW16tRJ8ipYeFDc9ozebRO3jwAMiM
 uAPgBOohX5BxWcVX8K6J5XVK+cSyNLCOoOXQQRp0umoQwzft1sehAbrD0pUYchnZSyMJ
 4MSZbdb2W2MGHB8nnxzkI02g1RJZy4jH2OpWeGOMCBUdLTS3/0iTEMzPWd3WqBpGwNaq
 QfmhVnFrTSiKyX5SlO3ivMmjlgEbPAkj5cVqOIv/qBdEMUe/cUeO2+Ekcb6tONgZ5V+k
 D91g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaqMWEwDohBdFVScMnk1Yr8r/MbiZkcy0/MX9ZzN4xT+A+rOgvOCqz45UBDnyIm6LdkV2VjBQ=@lists.denx.de
X-Gm-Message-State: AOJu0YycUcQctvRzCCkXxfLToslEVXfJ/RDLNyhEOUOYT811+zcu+YVR
 2EI/DEVyHeT9hargPK++ZqnE94Wc69dN2gIe7Vmp6qX3wAV/0GWzHUeArYYNAJokpq3xW97XRhv
 saS8VU7mLqyxyZT2+vvZn4CHCVpQdS5M6xkJu
X-Gm-Gg: ASbGncv9YE8GNKFmbSsldOT4LyrdruWiJykv1zGm6TBqh2nDqf5IGXW3diBtNNiLgPk
 kH7CQHGOEj/35IkBhAg8btj02FKI2s7hD2WzCOEQ=
X-Google-Smtp-Source: AGHT+IHHTNQa2orButZkRfo6mqzxasKODcWFwnh6sdyEBo4mH0TJPcusNwTfCEUgz2ulbOHcuK1mGWOWNQELZvm5xAU=
X-Received: by 2002:a17:907:3d8f:b0:aa6:3223:19e6 with SMTP id
 a640c23a62f3a-aab77eda8e7mr1840233366b.60.1734464834444; Tue, 17 Dec 2024
 11:47:14 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 13:47:12 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-20-sjg@chromium.org>
References: <20241211135418.563803-20-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 13:47:12 -0600
X-Google-Sender-Auth: CfZGjDMuF4cv-YK8RTAbAHddbgs
Message-ID: <CAFLszTiQdBAev2ciiQ5s_h7E3Q4X1+P8EACAKmZjMvnJahCXyA@mail.gmail.com>
Subject: Re: [PATCH v5 19/23] efi_loader: Update to use addresses internally
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

This collects together several v3 patches into one, to avoid any
temporary test-breakage which would make future bisecting difficult.

For efi_memory, the efi_allocate_pool() call uses a pointer to refer to
memory, but efi_allocate_pages() uses an int. This causes quite a bit of
confusion, since sandbox has a distinction between pointers and
addresses. Adjust efi_allocate/free_pages_ext() to handle the
conversions.

Update efi_add_memory_map() function and its friend to use an address
rather than a pointer cast to an integer.

For lmb, now that efi_add_memory_map_pg() uses a address rather than a
pointer cast to an int, we can simplify the code here.

For efi_reserve_memory(), use addresses rather than pointers, so that it
doesn't have to use mapmem.

In general this simplifies the code, but the main benefit is that casts
are no-longer needed in most places, so the compiler can check that we
are doing the right thing.

For efi_add_runtime_mmio(), now that efi_add_memory_map() takes an
address rather than a pointer, do the mapping in this function.

Update the memset() parameter to be a char while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Combine the various pointer-to-address patches into one

 include/efi_loader.h              | 13 +++++------
 lib/efi_loader/efi_bootmgr.c      |  3 ++-
 lib/efi_loader/efi_boottime.c     | 37 ++++++++++++++++++++++--------
 lib/efi_loader/efi_dt_fixup.c     |  4 ----
 lib/efi_loader/efi_image_loader.c |  3 ++-
 lib/efi_loader/efi_memory.c       | 38 ++++++++++---------------------
 lib/efi_loader/efi_runtime.c      |  3 ++-
 lib/efi_loader/efi_var_mem.c      |  6 ++---
 lib/lmb.c                         | 10 +++-----
 9 files changed, 57 insertions(+), 60 deletions(-)

Applied to sjg/master, thanks!
