Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B74C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2964D80C77;
	Sat, 15 Feb 2025 04:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cJEwX00u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260DF80F3F; Sat, 15 Feb 2025 04:23:42 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E041C80B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce76b8d5bcso23381635ab.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589818; x=1740194618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GxPO5by47JdR6tUb09HUbCR28SjxV/XtSDiR5ZKSho=;
 b=cJEwX00una2mMTu1Rc2LzrRapGuU+gm4Ks5Q15tjIG7U3gLgM5h5+MvqwiwK1Wfqwx
 sX9Jh2tcxtKXqN8IM4bO9rou7BaJ42GxBsThX77gkG6mmD1Io13WZxaJkgXMNpYpWCEF
 bPbdH1Sy10nnRxfcWAi3qtZtVE6AL8jkZajuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589818; x=1740194618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GxPO5by47JdR6tUb09HUbCR28SjxV/XtSDiR5ZKSho=;
 b=DtlLE1FCkqSpeEYnCDRV8jTbOEy+lH0gJEMWD1PsKaIWPD/N8NAL0S359ZUhxd0mLY
 XaREjPIAdThG9jFkGAntC4pytCJJbEkqmsum+XHbVfmrnSuB5ESqjIYLldVxZ81S2rZx
 595KP1EU4hMqMb08TLzq0mkdygdRpQ/qRWN8nnWPiTL4ndPpmfN6HkYqLhV9FGUcCR67
 cCK7MrjMId5OPwWMEMt+r/J09uS8sii9sS/SZ3bNfS+HCl0Vdlre/KkgfdMzUMQlH5jD
 qtk2KevW6lr0MSUkgJUvyFa7YLjS6ocTDX5T0oisAgfotKw5Gz44FbBfgg/mMsGj0Ct3
 kFcg==
X-Gm-Message-State: AOJu0YylTHPL52mdOW2PF/3HuMbJo8Vm1GZA8DrhD2XAAVvNvwvHTJvr
 17DghI/RWCQgZMkrMbgbedL+ej5lYBj+Ap6XZNV90j/jv6te1zg0jZLUOXQ6wOQvWv6/6IHdy2o
 =
X-Gm-Gg: ASbGncs4TyBrSb0boQTATDDZImyWqAOxwKTaHKDvi8uXNmDhFDZurNJYKdcPkHOJsgd
 FkIF3Gj+EFg4eVV1Y/Y67oEedtY8fFBwgGuXxlb/xhi35jRDz+evwSotR9hNxCKx9jVIj65qlAw
 PluwElxT4PNIIOhyKexGNzDJHZ4MIYuRq2AspSqqWTrgpoH31IrV7MC6YDyveyuZ31r53o4MUlW
 THs32CHQddc6PRQPuNrJU2IE0541eLighYrZzUCocxjaejiFzrrHsqlio6arLJjXgTom6zqxIFZ
 7SQcob1ShcfSEhB1Ga5Z5QqW35mFA399tb+gSvgCunWHhCTcbGDX
X-Google-Smtp-Source: AGHT+IFk8chigc1dxQMrfjTjTWX06HuIJtvYfxUf68r7CZHYE0AweB5VKnknrtIhv+7gopWlwiECaw==
X-Received: by 2002:a05:6e02:3103:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3d280771b4cmr16384825ab.2.1739589817704; 
 Fri, 14 Feb 2025 19:23:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 11/29] efi: Tidy up setup of global_data
Date: Fri, 14 Feb 2025 20:22:32 -0700
Message-ID: <20250215032254.4121030-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

Use the available functions for setting and getting the global_data
pointer so that EFI-startup can operate on 64-bit ARM as well as x86.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Mention '64-bit ARM' here, rather than just 'ARM'

 lib/efi/efi_app.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index ff8b62a1e1a..1aa43b511b3 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -77,6 +77,7 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *sizep, uint *keyp,
 static efi_status_t setup_memory(struct efi_priv *priv)
 {
 	struct efi_boot_services *boot = priv->boot;
+	struct global_data *ptr;
 	efi_physical_addr_t addr;
 	efi_status_t ret;
 	int pages;
@@ -86,10 +87,12 @@ static efi_status_t setup_memory(struct efi_priv *priv)
 	 * are very few assignments to global_data in U-Boot and this makes
 	 * it easier to find them.
 	 */
-	global_data_ptr = efi_malloc(priv, sizeof(struct global_data), &ret);
-	if (!global_data_ptr)
+	ptr = efi_malloc(priv, sizeof(*ptr), &ret);
+	if (!ptr)
 		return ret;
-	memset(gd, '\0', sizeof(*gd));
+	memset(ptr, '\0', sizeof(*ptr));
+
+	set_gd(ptr);
 
 	gd->malloc_base = (ulong)efi_malloc(priv, CONFIG_VAL(SYS_MALLOC_F_LEN),
 					    &ret);
@@ -138,8 +141,8 @@ static void free_memory(struct efi_priv *priv)
 		boot->free_pages(priv->ram_base, gd->ram_size >> 12);
 
 	efi_free(priv, (void *)gd->malloc_base);
-	efi_free(priv, gd);
-	global_data_ptr = NULL;
+	efi_free(priv, (void *)gd);
+	set_gd((void *)NULL);
 }
 
 static void scan_tables(struct efi_system_table *sys_table)
-- 
2.43.0

