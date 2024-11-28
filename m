Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21652D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B265E89D79;
	Thu, 28 Nov 2024 16:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EASEBIel";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96ABD89D73; Thu, 28 Nov 2024 16:48:19 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B39589885
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3ea696c4dcaso525774b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808895; x=1733413695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnJSlIJpuk8EN2VfQxIapsJKBzZQUWFiFmoTrqIAL/E=;
 b=EASEBIelH2BGRnpeThqUi+tex1DNLZIcukKqz1dos9d328pZWZsV8sQKugsG338om+
 V9llBpGL1tZdZ4eZp47V01JBOdZcHAoUcqP4Yt2N2Ig3gl+UnMnNNQkAOrWE9c4ucCou
 x2CcPHkI+8BulWQ4qvO0/QKaNmVF7eWbhVO6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808895; x=1733413695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnJSlIJpuk8EN2VfQxIapsJKBzZQUWFiFmoTrqIAL/E=;
 b=e2Y6BAUn0IO95gfsGY0YNwxNoX68p4HHjjA96SqaHwuuPn7nZGm2+6cJ75IG0zK6px
 xGntFbqAMJEXXaZXC6QtzuYa2TtqmFpnWm8E9NP7D4ywdvZxnMJOziWz/ul8asqqMQac
 lF1k+H+OXoC4o+jiFnEJvhx6hx8AYpHnMvfUc+VLx8hOGus0+Of04QL4NPmrNlswbZ8x
 pU87p7fA3pQXfVnOv59PhCzJzhpasoq1/x6dvwdfInECk1JUBEJCLZdQCysXvNf/0H5a
 tYCF/xYrHH3XPz8Pqw1JDIdd093iqR8yYAi7dv+8NwFDGt6Y/Th+VKO5J8SZMXRsmXOh
 emvw==
X-Gm-Message-State: AOJu0Yxj5lAW4n9duUodA6SF2k44ZnFpaJJ1sMGHvTeM7TnZF/wK3AZs
 Dfzr9RcHu6o9Tro+lisjshvyzangEWH/M/Tges4zRCOszbmyg4+cqm435Wb98IEy15XNvFdFX/Y
 =
X-Gm-Gg: ASbGncvLtJoHc/Z2m53SgnRFFfEgL6ktXbig7T3mMI7Z0Qes1sPhu/SexseZEScX9mb
 i9DdQKCe+VdMKCVYwSrq1cNvEtYdddiyHlRdrz+tPH0Xck1UwKEWfyV7UwWZtG2e23aRUoo1THv
 uc/oLllFLcQjGsfu2v+BJJHdFKNaw6s5qkmMNToWrPwav0I+jCRbMO+ZySIW/ltrCLu813OuBqA
 kqenCdydXma0X2JUbFGgLw46b9zD+ZxC9TbDqsPtqjdpg==
X-Google-Smtp-Source: AGHT+IGZpQPQQbi8kntHRSCrFw0EZxfslnF4/oUsur2+2dbd4knc2qCCz9Qi/JdwmJCrki/y3GBmWQ==
X-Received: by 2002:a05:6808:1383:b0:3ea:525c:46f8 with SMTP id
 5614622812f47-3ea6dc286f1mr7737715b6e.22.1732808895370; 
 Thu, 28 Nov 2024 07:48:15 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/28] efi_loader: Avoid assigning desc in
 efi_mem_carve_out()
Date: Thu, 28 Nov 2024 08:47:13 -0700
Message-Id: <20241128154727.771871-15-sjg@chromium.org>
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

Rather than assigning desc and then changing two fields, assign all four
fields, for clarity.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 83f2e32b9a4..b51bb367899 100644
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

