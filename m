Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394A4D49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD20896E2;
	Sun,  1 Dec 2024 16:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VXvCicdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9E58914D; Sun,  1 Dec 2024 16:28:37 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF8A89686
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a7deec316aso7014175ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066909; x=1733671709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3ftNGewdgNBvR0vg1RfbcEPS4mmIcQE2qB8c6s2Ju8=;
 b=VXvCicdMZQDQFvcL5NwpYsP3jw0oa7Kv3ZPwkbFJWxzDFW6HHe76L2iDRzemZmPi9y
 kFwYikuHrDjCPwnRLhDswf11zvbxWfOlwAWxXTaK3qLfe4XZmNIzhJW2Kfb4dvFJRqqB
 3ocMzLel2/mMTrEPkwVqq/FXbLPQpYc5hbGA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066909; x=1733671709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3ftNGewdgNBvR0vg1RfbcEPS4mmIcQE2qB8c6s2Ju8=;
 b=f2/pTGsbQN3ja1B/+XJvXD5/f19j+no+YBsBqMPE/L0mhalj+WN0eS1e9G3je5DTdj
 MsDEyFmm69CnWrD8OgwvPkMQZVgcULW29mopMAjNBu+XMgOYdzHjkWguJ1xmT5meF6C0
 Lhw4r6IstfGtc/vButrWlCZTkLODIzYKB9OoEOH82qH0pdCB0YZbv9TLWS+0HOWEUWGm
 g8Xs/jZ2VjcBswjM+1ysSxe73A8JxPpIiHtFdI0lxY80q6V4754R4/Z7xqcYdMBQwV42
 ZmBja4qBzKhrn+E4j1cu88QzEQ8FLHVOkBUPRJBxjow8ROwv519Qh1dUriO9YPo0ny4u
 wpqQ==
X-Gm-Message-State: AOJu0Yw7z3jU35Y9SpPzH5h+nLN5Pf12YAZOXVhEkfg496WCH/8wDlbz
 X3i50yHrXln3oXet7Zt2zZ2eZZQwr0LjQoT270S1lYPXe7xgdo12XJ+43BYXfu6jU2dseG8if2E
 =
X-Gm-Gg: ASbGncvaALFAx0xEPloUxM4cJjkblra4h05x29xtYJnMWIdxtDCMNgAHNvzUwOlMOTg
 +gsFDBynXqGnqT69OYhHWBwHNEQZvWb8zzgO/uIk0cZhjdiXvzqSYwKYIxJvPV2v/OCphDRJHAZ
 A0/R9DuM5n1YKovr6XgfuxcqymyMi00nfJXRFfvPlTo1mNOM2zmmni8CkJY5lbXwXsFm0g8HC5u
 nvATsZtHzHXKpDT2Jes9DUJuYWyahdQv1L5dlVIhe16
X-Google-Smtp-Source: AGHT+IG0AQ/+22G2CdC19X9OvHXVuS61DraYrdr4NmDHMWqB/gZxwod/fbjPaJB7N/QsAfwbI1lDqQ==
X-Received: by 2002:a05:6e02:2401:b0:3a7:d5a6:1f9d with SMTP id
 e9e14a558f8ab-3a7d5a62424mr111045915ab.9.1733066909548; 
 Sun, 01 Dec 2024 07:28:29 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 5/9] efi: Drop the memset() from efi_alloc()
Date: Sun,  1 Dec 2024 08:28:07 -0700
Message-ID: <20241201152815.1668093-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
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

From my inspection none of the users need the memory to be zeroed. It
is somewhat unexpected that it does so, since the name gives no clue to
this.

Drop the memset() so that it effectively becomes a wrapper around the
normal EFI-pool allocator.

Another option would be to drop this function and call
efi_allocate_pool() directly, but that increase code size a little.

Move the function comment to the header file like most other exported
functions in U-Boot.

Comments were made in v3 that another project uses memset() when
allocating memory, but that is not required by the spec. In any case, as
above, from inspection, none of the users need the memory to be zeroed,
as they fill the entire region with their own data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Expand the commit message

Changes in v3:
- Add new patch to drop the memset() from efi_alloc()
- Drop patch to convert device_path allocation to use malloc()

 include/efi_loader.h        | 2 +-
 lib/efi_loader/efi_memory.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index a67d3827812..a0af0db6262 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -762,7 +762,7 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
 /**
  * efi_alloc() - allocate boot-services-data pool-memory
  *
- * Allocate memory from pool and zero it out.
+ * Allocate memory from pool with type EFI_BOOT_SERVICES_DATA
  *
  * @len:	number of bytes to allocate
  * Return:	pointer to allocated memory or NULL
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index d77243e54b2..76cf908c2de 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -639,7 +639,6 @@ void *efi_alloc(size_t size)
 		log_err("out of memory\n");
 		return NULL;
 	}
-	memset(buf, 0, size);
 
 	return buf;
 }
-- 
2.43.0

