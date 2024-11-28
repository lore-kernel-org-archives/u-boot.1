Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA6AD70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E63A89D21;
	Thu, 28 Nov 2024 20:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bgYepKJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DCE890D8; Thu, 28 Nov 2024 20:13:04 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F139089D18
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71d56fe8240so526096a34.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821180; x=1733425980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bC1ju4zOshKaPOXDswMM9niN6TmgyAtrpZqgtyiyP8o=;
 b=bgYepKJeLa59faIsbFxquZHKcpY1+66YNl9KVeUP6isqCUy2FxYAOZT7MV5Vnfzw8a
 0CWKOXMKLhp0mpciJe8M8z8T8N2B+cLKLj6SaaYSHEvhH5WiZ4GHYOJskF3jZeMcWvOu
 ajPUvs7hLPh1x5e+bltNh6JQm1/GZvYodIjG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821180; x=1733425980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bC1ju4zOshKaPOXDswMM9niN6TmgyAtrpZqgtyiyP8o=;
 b=PlwBYQ/7KMoviGLlWoy14oHyRtzbwab8P0ZucRa+Vo7SstoTwFWPqC8oMceDoEiuLl
 EYmol4+9Ps4I9RKfbXsmgSNfVSi0lKNflUv5KRIWqz2KFIOJXHGcPX0yqohfJ85M27/N
 f4F9AsHQypnGO/4yCTqp5PF5Ri2DqNzsCUkccOSlEeWbwm/u9bmb3Dclbjii0BxrQrsg
 TWrBLqrEUDcKyjIcUmA9Y2P4G42tKaMOnX0F7/ftqx7R+YRX7KEMuwHCcDck9X4FKtv2
 /QhGyoYgCvL7IIWujfVfMwefxV66QMyXHCBZk8CWK7tpaowCGRiI4ZNruTkLmIQSrLrY
 yRlA==
X-Gm-Message-State: AOJu0YwAWTbn9bkDdVSfkoR5wNw/q9tv4+rFCgxTjOoAzOK+NYa+0b15
 /Rnpv39rAT6VCmEYoSCzTDxCPcChOQ01mooAZCt7Mfrjcd2yjHBFqo8SU9H2tQHGjQNCi0lUkeQ
 =
X-Gm-Gg: ASbGncuaJijvaJgeQBL2LQXStSbi53DO3NVeeX03eDeyWlcxk5aRAFSTTnQ52yAOerO
 oiEJKr3UGSt26v93ZvsaquCkH1CDO3iZiCNQ/8n0YsTky24q3W7zirIMDMO0O4GHc8uAlSvjf6E
 MBZFUojzRA7YqNB8EGaMWS7WNcyA65sqeOlhOelEX8dEDsuWJZmHEQNKbUZShOvPy9xL4kC8cWY
 Ss3k1OSxW3b91EnVp7Nvy7qkywxaVMSlG8UUoLp84DN8Q==
X-Google-Smtp-Source: AGHT+IEIHBMzYKp/51vdDRhNRnuqe0H3IHTyQaTWr4J7UoBGl2enTkmPbSsPNqZaIeY1PNhtaD+TIg==
X-Received: by 2002:a05:6830:4114:b0:718:ad8a:e2ce with SMTP id
 46e09a7af769-71d65cbb708mr7558556a34.17.1732821180259; 
 Thu, 28 Nov 2024 11:13:00 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:12:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/28] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
Date: Thu, 28 Nov 2024 12:12:19 -0700
Message-Id: <20241128191244.900006-4-sjg@chromium.org>
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

Simplify a few expressions in this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index f1154f73e05..3b1c7528e92 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 			     (carve_desc->num_pages << EFI_PAGE_SHIFT);
 
 	/* check whether we're overlapping */
-	if ((carve_end <= map_start) || (carve_start >= map_end))
+	if (carve_end <= map_start || carve_start >= map_end)
 		return EFI_CARVE_NO_OVERLAP;
 
 	/* We're overlapping with non-RAM, warn the caller if desired */
-	if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
+	if (overlap_conventional && map_desc->type != EFI_CONVENTIONAL_MEMORY)
 		return EFI_CARVE_OVERLAPS_NONRAM;
 
 	/* Sanitize carve_start and carve_end to lie within our bounds */
-- 
2.34.1

