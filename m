Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785A6D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AAF488D5B;
	Fri, 18 Oct 2024 16:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bmvxNuIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE3088E33; Fri, 18 Oct 2024 16:52:07 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DFD188B9E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83ab3413493so59255039f.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263124; x=1729867924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esPCzC2cK4gDmwRFjwhJUIWDyQpAFkTzw3Vv71U8m1Y=;
 b=bmvxNuIJJvHHbVP09+LgoF8RWNTBPcaqtcH9dXetmvOBko9rpxamJtfYgmRrby+PHu
 dtayTSuPAhafQfAUmOadiHyDObfdLZ+zDE+Q88DefpM+lyraeL3pTsNudAo1ep/TBC97
 RvH8W+tTzqL4HVn4Gck7YntxbAUbWi5SVnmLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263124; x=1729867924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esPCzC2cK4gDmwRFjwhJUIWDyQpAFkTzw3Vv71U8m1Y=;
 b=JS4enXnaImWLtmgcoadAO51oo2FMYmV+/m0Gdsk4U46SzlenH6lDpQJTCuyoQRYiCA
 9weyFr3ei8JBX12QPelE8byKW/4xcJDvU33giqCMWLJlpEE1B6dyYzZxRLpheEfB+Y1o
 SHIwIjn4Xd7ql/oV8kQuB0Ex6ob1+6Cx0OXULOsz2rm1hikIzkN31m7Ou7CeSmkgQjbW
 iwnaWDCZatROPDZsCcS+n1jIxGLYE84lvBQRlJ3IzUIeUEFtzoanxZC8nblZ4Miar9+j
 L6SAJLv+c35YTcVyJOM9gLksJXioV1RCC9p0M9y8JceRACJvdsKYdWowq+Ufc66uWX9X
 grSA==
X-Gm-Message-State: AOJu0YwMx9XjPRqnCS8+zjRU989LkOQAuzP0dpbX/k2uP3gF31AiGjvp
 Z48U0nJ6d28jvS55FnaN/9C0btua+cYZYbeSpOQfeCLwbyW8GC/lK4c8x7oFe+N2DqF/Fpr8/0I
 =
X-Google-Smtp-Source: AGHT+IEmrM+25CbOiDkrPv48Ygl1zOjc1VYfcCVlKkEkTE1O4fRuBKBUyk7XtkSOpvbN+4XrnLSp2w==
X-Received: by 2002:a05:6602:641e:b0:83a:9f64:6c75 with SMTP id
 ca18e2360f4ac-83aba5b8c1bmr209320539f.3.1729263124027; 
 Fri, 18 Oct 2024 07:52:04 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5adf1sm450573173.3.2024.10.18.07.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:52:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH 2/6] efi: Make efi_run_image() static
Date: Fri, 18 Oct 2024 08:51:53 -0600
Message-Id: <20241018145157.3918429-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018145157.3918429-1-sjg@chromium.org>
References: <20241018145157.3918429-1-sjg@chromium.org>
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

This function is not called from outside this file and has no entry in
the header file, so mark it static.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_bootbin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a0ab677ee1a..eb9b9c4afe0 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -141,7 +141,7 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
  * @source_size:	size of the UEFI image
  * Return:		status code
  */
-efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
+static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 {
 	efi_handle_t mem_handle = NULL, handle;
 	struct efi_device_path *file_path = NULL;
-- 
2.34.1

