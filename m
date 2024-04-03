Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9202DCD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4254883A6;
	Wed,  3 Apr 2024 17:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Tcc7YgWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E24881B7; Wed,  3 Apr 2024 17:34:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E79883A4
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 189953FB74
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712158459;
 bh=ebYQc9b3+JdWs7txc0B3H0KJz+rQ5EfcdggNH6JPoXM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Tcc7YgWfxuxNIjC9mWQh8yhhxuqJU4Uz3kTN+OnSVIDcflfcHjnKuTif0woCn6yZ0
 CRVWipw/pZKXi6sOkNc2reOoa5H6lL3zPxs0Zl+/cj6BWxexpHhZ4jJndMjJ9C9+Kh
 IRHqiXzBLnAhoHIFrdiSpQ3eh6lhUJBFo5NKsOAwnQ4+HWy67iPa62wwQvNEuEcaTP
 OyuRbi2nwtLhjd1v0rL8ppIPbvJc/CaqoqMcpraW0Y4TtEE80uhtNaicS2olnbb57N
 RxoE6/KgUbMv+Jr5bjozT/Sl0RBmnDxGEqcQwKssR2uNqhjbOTFEpfV9BzWayRazCw
 GRLXMoY6xQ0Rw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3418412a734so4020012f8f.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 08:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712158457; x=1712763257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebYQc9b3+JdWs7txc0B3H0KJz+rQ5EfcdggNH6JPoXM=;
 b=vuvjvL/V0gnFCk/C4iKUMMl0oeK1lzL3AHq4vReVunRQHqa5cHSp/6Gr928nV5Ww/Y
 9M0AFZa2o+Bpao65Bz3VKLICCZJ7y1mPS5bmkfxDvWpUbM8yZFJTmyQr5JxF1q4vjZCY
 WIo3OXw6h+b9XtA+dI3+X99ZMQeKXKy5U98ff/f/aUfNj3UVzRSE51eEaIUq7tDUoVgb
 t13vyegjFiA/CLO6c0wY1nzwOKFhqNgQkZAyf8c+f8BU/vuJZTcYerThyDE+kLaKad6A
 g47zdtysOxcz2pet+YQKh5s46xMrjPWyVRgnpcu3GaObosn91wMA0kHd+ntRsmlqJ2w2
 gDIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGC8Z+n6FYzd1NRjObFK2rrOF+kqzlH5JVaTVloqHXB9UYcHU2MvTGVSJUmRKbm+eZ9P33FMrmKmujFDvsCq9APTDSNQ==
X-Gm-Message-State: AOJu0YzxGOXdXp0NUbupki8RalgF2nr9fvoksrwNqmg9zk9tHy9FbmqP
 i7TJ/KnVfzJ9WTGAVBPsVvZKq0vcHtKwv2QtE7kGyjVeIcIHXn9FViee0TqvoIAOxi9dSAzObJw
 woh0TTFmr0RBwCY4g7eV3xwHZbFrTOh5fe1CHIbRJy7QODhI1yoxZ0RHJPT/K5wr5uhc=
X-Received: by 2002:a05:6000:250:b0:343:8d1b:b121 with SMTP id
 m16-20020a056000025000b003438d1bb121mr1545215wrz.48.1712158456800; 
 Wed, 03 Apr 2024 08:34:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs9yGgXK21aP/LMxKjTRV3KuTeO5usuMHhQu86ePJ4EXwR28e85KwZY7EBja7Ir5zFXyxCSg==
X-Received: by 2002:a05:6000:250:b0:343:8d1b:b121 with SMTP id
 m16-20020a056000025000b003438d1bb121mr1545202wrz.48.1712158456462; 
 Wed, 03 Apr 2024 08:34:16 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 cs2-20020a056000088200b003418016b04csm17585710wrb.76.2024.04.03.08.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:34:16 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] efi_loader: handle
 EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS
Date: Wed,  3 Apr 2024 17:33:35 +0200
Message-ID: <20240403153335.96971-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
References: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
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

We don't yet support EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS for file
based variables, but we should pass it to TEE based variable stores.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi.h                 | 3 ++-
 lib/efi_loader/efi_variable.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index 62cfb993d2e..c3c4b93f860 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -507,7 +507,8 @@ extern char _binary_u_boot_bin_start[], _binary_u_boot_bin_end[];
 				EFI_VARIABLE_HARDWARE_ERROR_RECORD | \
 				EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS | \
 				EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS | \
-				EFI_VARIABLE_APPEND_WRITE)
+				EFI_VARIABLE_APPEND_WRITE | \
+				EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS)
 
 /**
  * efi_get_priv() - Get access to the EFI-private information
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 48ad813d79b..e09a5e7ccb2 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -235,8 +235,12 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	if (data_size && !data)
 		return EFI_INVALID_PARAMETER;
 
-	/* EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS is deprecated */
-	if (attributes & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
+	/*
+	 * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS is deprecated.
+	 * We don't support EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS.
+	 */
+	if (attributes & (EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS | \
+			  EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS))
 		return EFI_UNSUPPORTED;
 
 	/* Make sure if runtime bit is set, boot service bit is set also */
-- 
2.43.0

