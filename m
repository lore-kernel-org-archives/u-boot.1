Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADADE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F16D8031D;
	Wed, 11 Dec 2024 14:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbJeqO4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E2018031E; Wed, 11 Dec 2024 14:54:49 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFF7800C2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-8442ec2adc7so234647139f.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925285; x=1734530085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsYKWnBzlOzkrglf2QiLKbyBEZM0d9pfh0smNaEPwhQ=;
 b=LbJeqO4BP7MAqEE+yzDFZ84mOTSti9bVcQlIXkWEJpao6ph8Ajlo83WvZkJ8AhBIJ6
 MAZzGpzKaQw5D5SDLEmhamun4mGHFoZ4efW3zav4hgGRY9/LS+TN1Ad+p6ov4cZgDxDU
 AU1kzfKvQVb088klWrsLjIIF4jl+uIro0e4jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925285; x=1734530085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsYKWnBzlOzkrglf2QiLKbyBEZM0d9pfh0smNaEPwhQ=;
 b=sVoGikYhOd8gSjrQOeLjvRIBgDM5JuD4SKknH9210gm43Fs+JeNP0E/toJX9TdizTG
 szQZUWF0xhpewB3TCHHeSOXX2EqE3UDBccHnsi3IqIvxDTlcZS1N/viza5nz45xtk3DD
 8ooocDZF9N2NmDfyGhJQK4gs6yAvdHc1mQr0jX6IihhCa7/GIJCSboOqS1hs2CDa0fnr
 KcDEHyowilLlp/d5D91VvjtO+H/diHQvd1SXfoMV6kvzZBliUnuc4RJN656IeNfj006Y
 RWVNfWDmrI9qGrvfhxZp27oa8y1ZjcBzC9vjZA17BZKiI70OL3v5a2FYkRkw/NpmBZ7S
 LQ3g==
X-Gm-Message-State: AOJu0YyiPkhjmitEY6oeL6mrKTPOmBNvFNQ++XN4fDM8XwVZsuQWdMVR
 +tL043zRe+acrcKFVGtPsydHbzmPsN0LWY60o9uVkGKHyHnAHYYZwoXXyaOFSa3ib5mkyORO9GE
 =
X-Gm-Gg: ASbGncvWCaWhiKc8lXOyNGfvlPanMJQIot9dBCypSOQH9ezL/VtYX448zZnexptEhVA
 zRV/h+WUg/C3FkNCh5Aqiy6kUaNnZHul99R4wFyjNhwwHCOEw57duB0KxwR8cGtFeX/xjeODBy1
 c1GhwBOZjbGtzqtJvjJJtB/BgWk5Q5V4jCge1isnPA2FMs6qk1v1j56OTBj2uGluKFJlJJwNOK4
 QPZ1KaQnV8s9B99eBacZd+FGTmCNOQUx9K56WX0xR/84cToU0CXoa7dirHwBRG/QPjr7vZbHHsp
 MO3ADaC6xt/x+wc=
X-Google-Smtp-Source: AGHT+IEh+xgoKxhENNWi8yh17kSec50oYnk9J1ERE62qEXspoXXMaImjIEUQJ7QCB06JozkuUvCvug==
X-Received: by 2002:a05:6e02:1d8b:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3aa0a66cb85mr31132095ab.24.1733925285308; 
 Wed, 11 Dec 2024 05:54:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 12/23] efi_loader: Avoid assigning desc in
 efi_mem_carve_out()
Date: Wed, 11 Dec 2024 06:54:06 -0700
Message-Id: <20241211135418.563803-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

Rather than assigning desc and then changing two fields, assign all four
fields, for clarity.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 4c0fd0c5dca..f3aaa0e9288 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -268,9 +268,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 	newmap = calloc(1, sizeof(*newmap));
 	if (!newmap)
 		return EFI_CARVE_OUT_OF_RESOURCES;
-	newmap->desc = map->desc;
+	newmap->desc.type = map->desc.type;
 	newmap->desc.physical_start = carve_start;
 	newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
+	newmap->desc.attribute = map->desc.attribute;
 	/* Insert before current entry (descending address order) */
 	list_add_tail(&newmap->link, &map->link);
 
-- 
2.34.1

