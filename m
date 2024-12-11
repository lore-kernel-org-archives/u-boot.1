Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C5BE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9CA80312;
	Wed, 11 Dec 2024 14:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="REqmA5eF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4920B80379; Wed, 11 Dec 2024 14:55:04 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C07C80383
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844ba46e0d8so69871339f.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925299; x=1734530099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Mc2SOHZscXBipI6MC5Tl7VBc9MmxrFpy3A5HNEHk54=;
 b=REqmA5eF0fvy/3927R8Xdbnjy1qFNBYOLsFcc8AzfZtYXj79HJN0+tw+ZPcn3+3rdH
 j2nPX71/pxkKG+9qK+yB9I62Kgic7Vf7zYjFrS3iaC3KPL/W53UaFOqEqLgkE2p9e180
 eo/7J+utrNdPuWT6JuQM8tT+2iIgzLdWBZ9EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925299; x=1734530099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Mc2SOHZscXBipI6MC5Tl7VBc9MmxrFpy3A5HNEHk54=;
 b=plM43LaIzzGS10xKZnsLTvYEexwG09FCWFEPTnerE29fa8JCqCyzkYxslkRGUT3b+B
 4mB8RdqjGsG0WjQoL23+ATosJSD1IdHcqWzRzNG/oOREg01GYj+D6IoX9cIq0O+JoDpR
 WLCbcfXOk/KVVi5V69gF6K/FTh93jozvd7yoz20vr9iAAOz3BzI7DFcCOclfrK4bcm/D
 IiWuiKi9CnkpIQZepxrs5/qmrscKGVkowciANR7r5CruJRPVyf4KgE2e7l4ruQHncy3M
 XODFRf4oCQB2zsk5uB1eAQU/ncgmBHbcLP+iFLFIORv827XokH74kZpyxFu+6acTaRXn
 8OBg==
X-Gm-Message-State: AOJu0Yz+6+t7idzaxbQX8IpW0XFe8KGpKZVRfQYX74WkDD4PtQZj+7aa
 GDDrup63Bu+QoOszGtq26mHt7L1xTKvBublfJpunDJ3jfXthWK6WBZLsJnTV3nOHVX9dAfFymww
 =
X-Gm-Gg: ASbGncuSj2kAtyMGKRhoQWdpBh/Q6HGMPfdFOJ2h+GNeWcT+NVUJ4Lc25BWYVTwFDm0
 5/qdTAOUPdg+CkzD1mYb7LySe/mzxSuIZL2XgQBr5hBsTtMbAUYv5XDFVpJW9rxqvN1JNhX9Hlh
 S21QcQAVEAYOjK6xFiZICcb/cs67Gu23t7eKgJL/9njertyRd8pW5EOSQnv2h1NtT2FIUkfQRGU
 /T2zybR0aM767ztJRqluJlzE3xy+cIFWsDwXLyY+REjmHjKMFZ2C51NJvGB4aeorLg0PiVNREKq
 rWIxafOoRO9DwZU=
X-Google-Smtp-Source: AGHT+IFoNJTMrp5OGrlMJPzWA8mBBCpX1v9Z4P8zh5T0CWR5wSy2r32b34J/yII4RfVqlxvml2BWpQ==
X-Received: by 2002:a05:6e02:1a8f:b0:3a7:e0a5:aa98 with SMTP id
 e9e14a558f8ab-3aa06fbfd1cmr30371595ab.13.1733925299338; 
 Wed, 11 Dec 2024 05:54:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 20/23] efi_loader: Correct address-usage in copy_fdt()
Date: Wed, 11 Dec 2024 06:54:14 -0700
Message-Id: <20241211135418.563803-21-sjg@chromium.org>
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

Update this function to work correctly with sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index fd89ef6036f..72902a5ade3 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -486,12 +486,11 @@ static efi_status_t copy_fdt(void **fdtp)
 		log_err("Failed to reserve space for FDT\n");
 		goto done;
 	}
-	/* TODO(sjg): This does not work on sandbox */
-	new_fdt = (void *)(uintptr_t)new_fdt_addr;
+	new_fdt = map_sysmem(new_fdt_addr, fdt_size);
 	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
 	fdt_set_totalsize(new_fdt, fdt_size);
 
-	*fdtp = (void *)(uintptr_t)new_fdt_addr;
+	*fdtp = new_fdt;
 done:
 	return ret;
 }
-- 
2.34.1

