Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26714C2BB3F
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8538386EE5;
	Thu, 16 Nov 2023 02:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eyazTMVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A349586EE5; Thu, 16 Nov 2023 02:35:33 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 246338724E
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35950f04d98so1219395ab.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700098529; x=1700703329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=01ALPTyV2poyhlsonWxr8PMeWQ/giCZrZPyPrWBbeWI=;
 b=eyazTMVIMfgRRx4qXQ69XMTqGzhuKXMiLl8RykqR7fY0uzKyRfKh6Pg+5NdGfxNWsY
 TlNFwS/1DnMUPz1XkdIEo9jRU/8y3Crgnlhta9HX2NNZG/sg858pCYf6XHehNoEdNhDx
 UniM0iNbOdWVt/HKX5VAd4Xtjm7fXrh23ZQL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700098529; x=1700703329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01ALPTyV2poyhlsonWxr8PMeWQ/giCZrZPyPrWBbeWI=;
 b=RuH4ahXNP6qt8S9xblRFBaIQtMiWIVcDWQe0WtvGOQmULtNPwERD90Ai22d4DoaJYZ
 yqz1DMwlYeqhN9DPEeD+DNcb525QpD6RUXFDUCnU2T653c3Gfrw4DqbFJYMc1VEL8ya7
 VjJfkwMYJWHIBZFL2vFBCWLRWSepJG/gKMQhun0rSLWZRnqgeRXjN2uNVto4aWCc2rsD
 sfcIwhboj28wk42hPsJKVbMteVD2Pe3WHJkcdq2KTQ7C7+JqpO8TKAw7MLnu/BshGf9L
 y6adkWlc5W22RKRDQ/QoWS+kxRFt5NQpyPUC2/PCostamslcIt9Uhf0UvUb7MpL3hec1
 M6YA==
X-Gm-Message-State: AOJu0YzVOa+WXN8IUrvwx2ClZfMI4eUs36kxTrJi1OdwIgXZplXVkyCi
 mKV2+kNmVwa8dTdbBMbcHsIfYAg/1j5m2HSXX37mFA==
X-Google-Smtp-Source: AGHT+IELMoPPI5eWlMP6vym7aRKzsz+JT+aPbV0cVtWelgHgry9zDhyG4gJR2DzGVrPAmyOuZALqKg==
X-Received: by 2002:a05:6e02:15c5:b0:357:a01f:35f0 with SMTP id
 q5-20020a056e0215c500b00357a01f35f0mr20091740ilu.19.1700098529658; 
 Wed, 15 Nov 2023 17:35:29 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z35-20020a0293a6000000b0042b530d29c3sm1332798jah.164.2023.11.15.17.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 17:35:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] bootstd: Avoid freeing a non-allocated buffer
Date: Wed, 15 Nov 2023 18:35:23 -0700
Message-ID: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

EFI applications can be very large and thus used to cause boot failures
when malloc() space was exhausted.

A recent changed fixed this by using the kernel_addr_r environment var
as the address of the buffer. However, it still frees the buffer when
the bootflow is discarded.

Fix this by introducing a flag to indicate whether the buffer was
allocated, or not.

Note that kernel_addr_r is not the last word here. It might be better
to use lmb to place images. But there is a lot of refactoring to do
before we can remove the environment variables. The distro scripts rely
on them so it is safe for bootstd to do so too.

Fixes: 6a8c2f9781c bootstd: Avoid allocating memory for the EFI file

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported by: Simon Glass <sjg@chromium.org>
Reported by: Shantur Rathore <i@shantur.com>
---

 boot/bootflow.c     | 3 ++-
 boot/bootmeth_efi.c | 1 +
 include/bootflow.h  | 5 ++++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 6922e7e0c4e7..1ea2966ae9a5 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -467,7 +467,8 @@ void bootflow_free(struct bootflow *bflow)
 	free(bflow->name);
 	free(bflow->subdir);
 	free(bflow->fname);
-	free(bflow->buf);
+	if (!(bflow->flags & BOOTFLOWF_STATIC_BUF))
+		free(bflow->buf);
 	free(bflow->os_name);
 	free(bflow->fdt_fname);
 	free(bflow->bootmeth_priv);
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index ae936c8daa18..9ba7734911e1 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -160,6 +160,7 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 	if (ret)
 		return log_msg_ret("read", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
+	bflow->flags |= BOOTFLOWF_STATIC_BUF;
 
 	set_efi_bootdev(desc, bflow);
 
diff --git a/include/bootflow.h b/include/bootflow.h
index 44d3741eacae..fede8f22a2b8 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -43,9 +43,12 @@ enum bootflow_state_t {
  *	and it is using the prior-stage FDT, which is the U-Boot control FDT.
  *	This is only possible with the EFI bootmeth (distro-efi) and only when
  *	CONFIG_OF_HAS_PRIOR_STAGE is enabled
+ * @BOOTFLOWF_STATIC_BUF: Indicates that @bflow->buf is statically set, rather
+ *	than being allocated by malloc().
  */
 enum bootflow_flags_t {
 	BOOTFLOWF_USE_PRIOR_FDT	= 1 << 0,
+	BOOTFLOWF_STATIC_BUF	= 1 << 1,
 };
 
 /**
@@ -72,7 +75,7 @@ enum bootflow_flags_t {
  * @fname: Filename of bootflow file (allocated)
  * @logo: Logo to display for this bootflow (BMP format)
  * @logo_size: Size of the logo in bytes
- * @buf: Bootflow file contents (allocated)
+ * @buf: Bootflow file contents (allocated unless @flags & BOOTFLOWF_STATIC_BUF)
  * @size: Size of bootflow file in bytes
  * @err: Error number received (0 if OK)
  * @os_name: Name of the OS / distro being booted, or NULL if not known
-- 
2.43.0.rc0.421.g78406f8d94-goog

