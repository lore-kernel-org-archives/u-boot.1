Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE7FD70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB49389D35;
	Thu, 28 Nov 2024 20:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jwMSqf8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B97289D22; Thu, 28 Nov 2024 20:13:44 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B3D89D72
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-29645a83b1bso691395fac.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821220; x=1733426020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r59lnS9ted88mZtiv5di3gMKm6dNWml+RmTdamVb+Jk=;
 b=jwMSqf8qQxFtv6PZS0zOxJS8Y1zZcgRhmBvuKulU1Y+OMBeqsPuo8WF45OU9HnFSe+
 aJUtkN58lEBrV1XaP6RBbuyFovMSG9oGZnY9KnUoJ75T2dbBgObtEXBa+Kv5GNfDTij3
 PaaXDWGI1uhRPz1NVtIBaggQ5drwtUuNQ/kgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821220; x=1733426020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r59lnS9ted88mZtiv5di3gMKm6dNWml+RmTdamVb+Jk=;
 b=VjGk6Sy9SLLsaH59wqqN7GZYrQCMKRVWyNKziNXc0+YDYxcIeqbOGqEOX+J7pjcHnw
 8r7SACJpkCHXn5DVsgUfvrwN0KPbVxpZFZ83YBboLZ7Quv54fkB6VR4wb2meOAnxbPzy
 ok6hc+0UDm0pPVHWmlWqJNgxz5YODkwQJWjfaFYoYUcplgtVWzRVTyXwv3MP+kwHZ4Kn
 rh2ohuMx0nnz+K+HzFp2iYAWWGGvMu6DOR1miBigeO9dxqkj87GYueIQfI28gTPo5JYT
 lOIxM52yaK00CuKp+dshi9NMC0Lj5C2Q5DXh07D1Pog+kA0+PKDqCYIB6IpayJR3v/HV
 wCOA==
X-Gm-Message-State: AOJu0YzauHVBEpfBidO6dPKqfPcNvdA4LDFNB7wuIoPZO6XqbRp1LdzX
 aficEZPYMMzPdsob/pa+yX+J2ZYvt/InlGLkNuuGdUlY9R5EA7lPPm+PjiJZ5B8tFXywQaDnIgE
 =
X-Gm-Gg: ASbGnct1Yv/+rPo8CV5GS+cT6ZHgZ9Vftx8xZC/TafJtZcQcEh5EKjzS8KCLAMIFGE8
 1/R7NyqPuIgVA1ePL3ZkOCK7dOPNprrSOLycrUJymLwaLv3BqWt/q+y79Xtn6z1U+bJOw707a30
 Lrz4Rv9sXVNkQ9oiz3KExA182Qimgk0LIg7IZ4UtsYlS0TYJo6pe0NtEkP4w1OWweUd/sIJ7wJd
 b3jWf9ck7wStgDsVejMACrLlvmmL5abMxJYLvVgS4iZVA==
X-Google-Smtp-Source: AGHT+IGhxrmq76qqRSmqd/IAfPPoBiHFMQb6B/TGQ8jR/hXKva5CwNfyJGtrAU0PxSI3MJFiyRFZig==
X-Received: by 2002:a05:6870:a541:b0:29d:c68e:34d9 with SMTP id
 586e51a60fabf-29dc68e372amr3494238fac.13.1732821220550; 
 Thu, 28 Nov 2024 11:13:40 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 21/28] efi_loader: Use addresses in efi_reserve_memory()
Date: Thu, 28 Nov 2024 12:12:37 -0700
Message-Id: <20241128191244.900006-22-sjg@chromium.org>
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

Adjust this function to use addresses rather than pointers, so that it
doesn't have to use mapmem.

This is fix#2/4 for: Update efi_add_memory_map() to use address

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_dt_fixup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 0dac94b0c6c..72d5d432a42 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -9,7 +9,6 @@
 #include <efi_loader.h>
 #include <efi_rng.h>
 #include <fdtdec.h>
-#include <mapmem.h>
 
 const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
 
@@ -26,9 +25,6 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
 	int type;
 	efi_uintn_t ret;
 
-	/* Convert from sandbox address space. */
-	addr = (uintptr_t)map_sysmem(addr, 0);
-
 	if (nomap)
 		type = EFI_RESERVED_MEMORY_TYPE;
 	else
-- 
2.34.1

