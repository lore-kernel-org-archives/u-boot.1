Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE27CC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893268897D;
	Wed, 24 Jul 2024 17:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mUpakHgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 493D688A30; Wed, 24 Jul 2024 17:10:08 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2899C889DA
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-819c1f53617so202895739f.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833805; x=1722438605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dx98GpL7OtOQnVwbZSDT5Sr4CK0z+gnPKMcHmQUVQLs=;
 b=mUpakHgxGFt+Qah+iA9Mq/XtUlZBPl+FoW3vDvV4ffTVYijfsv3RJANDgpKgL+QPw5
 vokEM75XWTmHUS+s4Hka7X7kvnXI7N2+XDk7j/wHKNdtyiy0i3mmIMU9oeNoVRkeWHYI
 BMiuJXNOLOfaN+Y4hhwXBUAKcG3ZukvgVzx2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833805; x=1722438605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dx98GpL7OtOQnVwbZSDT5Sr4CK0z+gnPKMcHmQUVQLs=;
 b=DJzlA2ksYUkZAxaSJHX8NK6e1KWQW0tOSUhjyAfD5bAI01yZp5H6heyvXkq4CvjAhq
 KCcypXSnV6ql7CfDNPchoSZdPkuWxr91Ei3O6ds2q9MNrNAk1iLCqaxtdKV6zW+I4KH9
 tlLh4+ndCa2hD7SE/pI7i9sO4kKvr7OaHF8GAXgGsyaTSKxg2A4ggvvQL+FVwj5Ex81l
 obT2f2eqetFahp492cEElLHkTZxI3F1YXn2g8ifPw7gitS3/lFrb86RvDXrxL6U16elp
 hwtnMB32NXlFPzYXWw0TlaghGutajtxU9XYYPh3cJKJP9kgb+OnP5T959H7XZNNdhoME
 cKqQ==
X-Gm-Message-State: AOJu0YxzkoKYeYo7ihbN03Ztd/FWsy0BPJwrUB6S7mtYvglTDJPl9UGJ
 AAssskw5lUSyDCA7PDYvmB13JA5nsBdKkfZtiofljFwGWt8G3ltharQ5mTZW3Z/D03Vy+p+pgrw
 =
X-Google-Smtp-Source: AGHT+IGyxSI6cUcCxkhAJsaDL9ICcJE3N85OseofsD6pcaK9bk1vOFNkRanI/SO5/CSiyzUqPOc4Ug==
X-Received: by 2002:a05:6e02:17ce:b0:397:2dcd:80e5 with SMTP id
 e9e14a558f8ab-39a194d8668mr30164495ab.27.1721833804746; 
 Wed, 24 Jul 2024 08:10:04 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 31/35] global_data: Move pointer members together
Date: Wed, 24 Jul 2024 09:09:18 -0600
Message-Id: <20240724150922.2343249-32-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

Collect the pointer members near the top of global_data to help with
alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 38 +++++++++++++++----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 005c79c6a7d..f6d1ee1d57a 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -42,6 +42,25 @@ struct global_data {
 	 * @bd: board information
 	 */
 	struct bd_info *bd;
+	/**
+	 * @new_gd: pointer to relocated global data
+	 */
+	struct global_data *new_gd;
+	/**
+	 * @fdt_blob: U-Boot's own device tree, NULL if none
+	 */
+	const void *fdt_blob;
+	/**
+	 * @jt: jump table
+	 *
+	 * The jump table contains pointers to exported functions. A pointer to
+	 * the jump table is passed to standalone applications.
+	 */
+	struct jt_funcs *jt;
+	/**
+	 * @cur_serial_dev: current serial device
+	 */
+	struct udevice *cur_serial_dev;
 #ifndef CONFIG_SPL_BUILD
 	/**
 	 * @boardf: information only used before relocation
@@ -130,33 +149,14 @@ struct global_data {
 	 * @env_load_prio: priority of the loaded environment
 	 */
 	char env_load_prio;
-	/**
-	 * @new_gd: pointer to relocated global data
-	 */
-	struct global_data *new_gd;
-	/**
-	 * @fdt_blob: U-Boot's own device tree, NULL if none
-	 */
-	const void *fdt_blob;
 	/**
 	 * @fdt_src: Source of FDT
 	 */
 	enum fdt_source_t fdt_src;
-	/**
-	 * @jt: jump table
-	 *
-	 * The jump table contains pointers to exported functions. A pointer to
-	 * the jump table is passed to standalone applications.
-	 */
-	struct jt_funcs *jt;
 	/**
 	 * @env_buf: buffer for env_get() before reloc
 	 */
 	char env_buf[32];
-	/**
-	 * @cur_serial_dev: current serial device
-	 */
-	struct udevice *cur_serial_dev;
 	/**
 	 * @arch: architecture-specific data
 	 */
-- 
2.34.1

