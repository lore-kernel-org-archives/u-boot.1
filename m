Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43EAC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E59C8851D;
	Mon, 10 Jun 2024 11:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="m6vl4jyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C978812B; Mon, 10 Jun 2024 11:11:18 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F8C884FB
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D98653F91A
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010674;
 bh=g4XFqtKRLxLW6+UA2cTiH0Cp5GK4n1YZXGpbaH8uFU4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=m6vl4jybeszNVoV6ICH5+B0lAMjTIWhTDdIY05ctO66BMWh7H2h/FpTsBwz6sQ9gc
 sol467g6Zv7SpIWGA10KKNulbJEaTR5phS0xC1+BAA05Q82nm2RuCgvgLiXW5zCOxm
 q4Qa84gbizhQphIgAJO5MISkeb9zUMPkTjFmk4IiV3gIiBpNC1YFyikKlthaFxWqMg
 l7gK4RAx/LtzbqRoHrbMip+wR8gcOSBKIk4tnZv8P5/W+/hydSYhM8UOcPGDfyrK8A
 bAEIca6/83Pyzna1KXImpejd0MACtyhqgZlyzY7kdMFYTM3tOkmTA++YnFvifmu9lZ
 PycEcHMv8Elgg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421292df2adso26977835e9.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010673; x=1718615473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4XFqtKRLxLW6+UA2cTiH0Cp5GK4n1YZXGpbaH8uFU4=;
 b=d5ahF/zyBD3g3trALEQOWYFuRGRnHS2krRqfaWPMZLRmbWFEhxubE4kGc/E/mJSwG/
 5034MNDVlnP0K5KZ5nLfaISQ2FgkGK0KCtiP/gKJrDUfBGqDW74WE/2ZpODkF3brmz2H
 SturdPZiKBpaeFr8OtY5nznUL7OoCOyFpl/QMUAzWrW4HqAFd7uz6YshA5tMIlg1OSB8
 riMnz6Ha+GdL4UGVV41RkEoL8vv68Rq1jbnxcpSfqMXcieuSg5dPp0OnjZqkjgyMLr44
 uQSEOSpyaVyXqkvKBpXgXfKq/pcUKOu5x32y2IHbWkRn+Gjzo3gXC6yHkk42hzbtvsZE
 t1Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkWe8Ftji3rXFqXEAl7ASeMlabfMMZoetPDQ69is5Qet2zcMvAALQSxStJcaBU8QGhve4q8PmLHBLMo7GmRnZmFwLrsw==
X-Gm-Message-State: AOJu0YxetvKWKqTvsw6iljlCwyf/b0kCfs8tG2YUO29nshVvXi5FFo1n
 BhHExuxqWUc3LUr9R5xRbUgFN7zZVLtBerhkFkpd1Z3XRJk9lrnxWROC1uwg7+1o4bn800YHRmF
 SDNkBvIJp0jVKhryTMpJUhvJF2EimeiDmG0nW3JhWSNa6WxbKrdVuJ+/5TjMSlut0RF4=
X-Received: by 2002:a05:600c:3b08:b0:421:bb51:d605 with SMTP id
 5b1f17b1804b1-421bb51d71dmr22211615e9.6.1718010672906; 
 Mon, 10 Jun 2024 02:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoLA3psHaWowA7I0+LzmQWNxGr/yP9VrTrsUSoka9sSlfn+n70xy25gh6hg6ZBcSozxPF4cw==
X-Received: by 2002:a05:600c:3b08:b0:421:bb51:d605 with SMTP id
 5b1f17b1804b1-421bb51d71dmr22211435e9.6.1718010672659; 
 Mon, 10 Jun 2024 02:11:12 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:12 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 7/9] efi_loader: export efi_load_image_from_path
Date: Mon, 10 Jun 2024 11:10:55 +0200
Message-ID: <20240610091057.64463-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	No change
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

