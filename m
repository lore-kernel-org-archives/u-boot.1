Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83142C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0E688E83;
	Wed, 21 Aug 2024 18:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="muTPStuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C661F88E5F; Wed, 21 Aug 2024 18:20:09 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BFB88E70
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7093abb12edso4955377a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257204; x=1724862004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNwW+7/q7pc/YAhpcLz0YXcrNs98e/n8OGnO3AVFwOo=;
 b=muTPStuRf0+WlW8fuSiUBLIDXvGelHEaNvAlITKJ3zIaEP7nlQ1yNgPjeIlL2CzWE2
 6IU3UIu90cWrrBDx4PAK1SjoPxMsPpDUGQhxwnrQfQHrr4+nFY019fdrrP6dLpy/iyuG
 FVUr0ThVhtGWIkQ0apAdYqmQ+l0Wjmu3TMoDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257204; x=1724862004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNwW+7/q7pc/YAhpcLz0YXcrNs98e/n8OGnO3AVFwOo=;
 b=NKLgOx3C3MYrvJYVWbmRF2M56bLiR5iA01P84jggy9lQ355BaEtC7CD3N89DgTwkCi
 m3UbURFdpk+89nnfeHPyU/Ogb3Y6tVn47U4/GthJ/tq1U2ZR+95koSgQYFQiF1wF/rXf
 W+psPeAFkRHN95erjbSrUAGZhfR5Wv0jNzddRyhecfR0CZx+ZyWCAeWqE7inXPGp/ylY
 PDYfxKu3+6iUkdAhbs1+7fZLH+ZsNZyhlUe8ubAtRAcNfkb3PtrWxs4McqlypPb+ZOMe
 dhkjDgg3ueOECpBrVCGkmJAHeYwO+YCHnyMCzwAd52CllMxBzwSjyaiZMkUcT2ioLF9Y
 aJVA==
X-Gm-Message-State: AOJu0Yy9fe/bRZAhsYD9jxvvQES1CEK2VTjqMXngYG79U70EwvpkC1P7
 g9vehkEJwzHoDunWhSEy0U9TUkW3Moj+Env7si6vFE9KqlxE1orAfqyJm58R1zSpL6vdTcI9rpA
 =
X-Google-Smtp-Source: AGHT+IH4MslvoRKfZdKYyn3ZJaqxnn33Ax2RB/I9CuUpJfXrNI5nkuRPCgC6Oqq5JG8RI4I08bs3mQ==
X-Received: by 2002:a05:6830:2b26:b0:709:425f:e6d3 with SMTP id
 46e09a7af769-70df85d943bmr3505129a34.7.1724257204527; 
 Wed, 21 Aug 2024 09:20:04 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 32/35] global_data: Remove jump table in SPL
Date: Wed, 21 Aug 2024 10:19:24 -0600
Message-Id: <20240821161927.695717-33-sjg@chromium.org>
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

SPL builds don't use the jump table since they cannot run apps. Drop
it, moving it together with boardf.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/freescale/ls2080ardb/eth_ls2080rdb.c |  2 +-
 common/console.c                           |  3 ++-
 include/asm-generic/global_data.h          | 10 +++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/board/freescale/ls2080ardb/eth_ls2080rdb.c b/board/freescale/ls2080ardb/eth_ls2080rdb.c
index 44d9782d729..7fc4fecf774 100644
--- a/board/freescale/ls2080ardb/eth_ls2080rdb.c
+++ b/board/freescale/ls2080ardb/eth_ls2080rdb.c
@@ -12,7 +12,7 @@ DECLARE_GLOBAL_DATA_PTR;
 int board_eth_init(struct bd_info *bis)
 {
 
-#ifdef CONFIG_PHY_AQUANTIA
+#if defined(CONFIG_PHY_AQUANTIA) && !defined(CONFIG_SPL_BUILD)
 	/*
 	 * Export functions to be used by AQ firmware
 	 * upload application
diff --git a/common/console.c b/common/console.c
index 30ddefef6b1..f39821385bb 100644
--- a/common/console.c
+++ b/common/console.c
@@ -189,6 +189,7 @@ static int console_setfile(int file, struct stdio_dev * dev)
 		/* Assign the new device (leaving the existing one started) */
 		stdio_devices[file] = dev;
 
+#ifndef CONFIG_SPL_BUILD
 		/*
 		 * Update monitor functions
 		 * (to use the console stuff by other applications)
@@ -206,7 +207,7 @@ static int console_setfile(int file, struct stdio_dev * dev)
 			break;
 		}
 		break;
-
+#endif
 	default:		/* Invalid file ID */
 		error = -1;
 	}
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 46763ef36bb..bd1069f572c 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -51,6 +51,11 @@ struct global_data {
 	 * @fdt_blob: U-Boot's own device tree, NULL if none
 	 */
 	const void *fdt_blob;
+	/**
+	 * @cur_serial_dev: current serial device
+	 */
+	struct udevice *cur_serial_dev;
+#ifndef CONFIG_SPL_BUILD
 	/**
 	 * @jt: jump table
 	 *
@@ -58,11 +63,6 @@ struct global_data {
 	 * the jump table is passed to standalone applications.
 	 */
 	struct jt_funcs *jt;
-	/**
-	 * @cur_serial_dev: current serial device
-	 */
-	struct udevice *cur_serial_dev;
-#ifndef CONFIG_SPL_BUILD
 	/**
 	 * @boardf: information only used before relocation
 	 */
-- 
2.34.1

