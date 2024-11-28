Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A506D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A381C89C67;
	Thu, 28 Nov 2024 16:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eVTWn8+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8B4893D7; Thu, 28 Nov 2024 16:47:47 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C9D89CEB
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ea48624a2aso484898b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808863; x=1733413663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bC1ju4zOshKaPOXDswMM9niN6TmgyAtrpZqgtyiyP8o=;
 b=eVTWn8+W6ofgG/euAt7cqzN1mdKXOyKC+PwAXx0dTRwtCGViZk5AcIyQhHmxtiMTPo
 8AUGi23jC+OXPCDdM/Pf46iOgkCVLvXUqDYU+apSeyk4V+r6vOeowmAJP7OfAvJUd2yd
 kpJycIx1hFl/o5OrMQEDhenKpJeMfQlBfPS38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808863; x=1733413663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bC1ju4zOshKaPOXDswMM9niN6TmgyAtrpZqgtyiyP8o=;
 b=NdSTaV0esLxY0vG25lvamRaCQf2gV78Uppr3fwdvRr2B8QGHLR3jD9LJzZFE/+UPjM
 wRR30TSJ68QqSHZv+o67wS2Nva2pzZzPXKkp+0zrGEr5TCRU0v/cbgu3uxHNcTYbfePK
 41TlDR/k2w/yAQ4MnYIwkyNl8Pp3JyoH5p1jIuTbdRZRdMwJlLG3gQPZHuohYbf1etFr
 Re0JDuG1csoV7N8avHAdqX/W6IX1mz05fTiTKL7N+Yi3+icCV3pS2ZnnlL2Xho+bjUcP
 xebhmYSrezSb7tpf4mPyWqBBfhFY4cqnHc8hdGyelR+CXyIfHDNkInDOOtFtzssEMfWZ
 Ojtw==
X-Gm-Message-State: AOJu0YzOtBfY0yXFgfvpvptgNFckMkTTDyO0ZTZ3sEsJEcRLy8qPrfCX
 tDkWCtjEHpNjIfj2budw4SAxLVJlLDlgYBdb7+h0/9H8x4uiyDk6cHLVzK6PFDQdkkr4cm/8qYw
 =
X-Gm-Gg: ASbGncsS5HlPGmoXAsQ/8j30qsfL2RzKF2IR6jZzCdWBhnMrU8qGqSxkCSmX5wDrIDe
 HTdbyh+6qGEdWfeGOI9yFLWGzJZIgFplEZPDhsr2yhp4T1srAmPb0+/bE34QuCN4IClutQ0L2NP
 vt8tHiiw+Ayc8cULPlYp5c+Cvoh1W+MhWx+EOK4wrXj7SpSzt2Zx0kdserpJEtuxfe59g3onAO0
 kIDt+f+W6w5FDkH1G+2MhfKz6vEgQG6KP1CvfTUjhffdQ==
X-Google-Smtp-Source: AGHT+IEFQMUud8DV8AvcJpZ7fqgbxuyItKo+FLMAVQVxrShvEkEAa7DLJH9tNHkFsUn175RQYMiEjw==
X-Received: by 2002:a05:6808:1801:b0:3e6:1a1b:e4dc with SMTP id
 5614622812f47-3ea6dbc9d95mr5312126b6e.18.1732808863311; 
 Thu, 28 Nov 2024 07:47:43 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/28] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
Date: Thu, 28 Nov 2024 08:47:02 -0700
Message-Id: <20241128154727.771871-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

