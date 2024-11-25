Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE24FD59D6B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C891989A7F;
	Mon, 25 Nov 2024 21:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F9WU1xF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7609B89251; Mon, 25 Nov 2024 21:45:47 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4884089A9C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83b2a41b81cso183880739f.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567543; x=1733172343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjDSKWBcFLOYzxIF2T2aS49nlgPuQb6G/LFjK9nR6FM=;
 b=F9WU1xF197ZMGHvQ1vYG9+YQDAjV15lG8i5C1yL62yB80GaSGS/XIHNWgtmiVUDrtb
 NamY1S6BqqRm3PvpZQQXQwBzxp3KRgVJt8/0mEQXo4mMvOozr4ZFopJRxfHlA17uAA4E
 6B2xtnDCnkdq0xM3C9XV4/VN6oq+AARiCclXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567543; x=1733172343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjDSKWBcFLOYzxIF2T2aS49nlgPuQb6G/LFjK9nR6FM=;
 b=SYcjJIE33ARoyjG8jbV4/tWsiQWK5PDlPxnOfhRQPraoFXTwbvzZQ+hUnJBxnTZyIx
 RmVqtYy2BjtyfBUjjo21+tEdnJlMFQOHjmjGsisBD4afLk8SM1167L4atXB93vSO2oct
 SHHQN9yDbLdARPOjRGnBYwYJAvMnccLJvisRal6egayxf69MoV1ZFd5ACE9OAK0lfqEL
 xOU15Q1wdZhxvH6qnZTop0ypSGhPgO1d11kC6YxHJYClRvDlT6LzAoLSq6DbPenS21Kj
 EopFjYpbnD6LZYDHNMVbGaszOH/ZsjCxGB1LlaaKoKnbTfc4BbWH6UgaY52IQR63iTeW
 Pykw==
X-Gm-Message-State: AOJu0YyPkanzH+IJMVrg4VPa1NPuTRggiBUnvdNVmNx3YbKCTQ73FwGU
 f54bMXWOVfqpWor8lGZNkZt7wq9zP9UJQY8yuE5M7AoXdNXj5DSacOqb54AmokDLWWfDxbRqu4Y
 =
X-Gm-Gg: ASbGncuFHpAWsviLvxhA6/2P6zsBunnfCggs+XuHQmVC1yuHzcVHpK+39ZOSByC+TJL
 o/DG8naaCtiYJm3fyz9beEMImzqDMSYSXJMplei7W4sN6/oUzmv26WadHnsSqB+h2u9UmMq6HDN
 YIRdIfBq5hb0lBNofTdi2QR0MuiQquydw2rPFYep/FezVTIr5o1ugqrl024JL7dY2vZIAeiaYG1
 /qCUoux0NphVtOd75HFRKct1R0sDMwO48GB7ZCTCGAig54=
X-Google-Smtp-Source: AGHT+IE1HmITe0Ce9nBTzT2zymjP74qkGKrSuGnFnn/XIptM0AmO3P2NqhRw6x7UHnez+3LrF/kyKQ==
X-Received: by 2002:a05:6602:3c6:b0:83b:47:8d5 with SMTP id
 ca18e2360f4ac-83ecdc538d9mr1612444039f.3.1732567543556; 
 Mon, 25 Nov 2024 12:45:43 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/13] efi_loader: Drop extra brackets in efi_mem_carve_out()
Date: Mon, 25 Nov 2024 13:44:51 -0700
Message-ID: <20241125204456.1525752-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
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

 lib/efi_loader/efi_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index f687e49c98e..32c5143e205 100644
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
2.43.0

