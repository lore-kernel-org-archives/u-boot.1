Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B09CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1C58749B;
	Thu, 19 Oct 2023 17:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gHgD9wQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E141B87468; Thu, 19 Oct 2023 17:01:37 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D623587259
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a81ab75f21so82750737b3.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727692; x=1698332492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dee0lhKBvxSuK2Y6NxF2rMok8KADIY6PR9/OQAsJ18=;
 b=gHgD9wQVKZaDwFA4HvqwZ634RYdZDz6GiyWRYJGNBwwl5r1KLScP3f+gncHTFxQoLc
 go5BnkiUoEwk2AsEXCobZiw1WI6yLzvmarpESvSbf5Kgcg+F9GZguhR0sytTV5leGoDT
 KjvQcbL7cikkbTE2W5UWwC3JmC5IytM/g0oiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727692; x=1698332492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dee0lhKBvxSuK2Y6NxF2rMok8KADIY6PR9/OQAsJ18=;
 b=oKaczRNwATv1MxotyOPsFRbQF+jeZWXslt7eAnr3QubPk57xZzJI4lrrwrKarnwuhj
 wo8rWbEIOWeJ5ux3u8N0GxAQS8XVVgr8psrfMV8psP5j8eti/wyrOCm6xNtWPgc2hTRH
 Xqycqa5CtVLixmxuYxVzXBENV6grpyjuQTWuBYkeOn/+eboIX3PXofETp8CC+c8LDUD0
 T6YK9+EjEd1w+GUQgHH4s+ztqQr69G0v2Iq92z7QCvuhnnQ6I0ThHy0RhqRUFI5Ljc/v
 qvXIx28mm97R26YiImiEENZl7qxAC2Td2GRByB8d3cSka31CfyQy7naVokiLUsAg2qTZ
 07lA==
X-Gm-Message-State: AOJu0YxmWEDgP9R0h3NSR/ox4EIM22GdM2SpjhZvY9CNpm7bLI9jhPE0
 6w6wVTvKB+9f+OcWDML8ZFfLeHbFY/2btFDrWmR5qw==
X-Google-Smtp-Source: AGHT+IGmXm4vRdq4VgH6ruIFwqaL2o2ilSBTTVuSwGqS4/9RwX2uK3zZ99IdHXFvL+OT8X/q00oP5g==
X-Received: by 2002:a0d:cc97:0:b0:5a7:c906:14f with SMTP id
 o145-20020a0dcc97000000b005a7c906014fmr2489656ywd.11.1697727692489; 
 Thu, 19 Oct 2023 08:01:32 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4 22/24] sandbox: Avoid requiring CMDLINE
Date: Thu, 19 Oct 2023 11:01:03 -0400
Message-Id: <20231019150105.714407-22-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Add some dependencies on features that we had been selecting so that we
can still disable CMDLINE.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v4:
- Reword the commit slightly (Tom)
- Rework overall to select if CMDLINE

Changes in v3:
- Reorder the Kconfig options a little
---
 arch/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index edfa3f7f83aa..78727050aecd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -134,7 +134,7 @@ config SANDBOX
 	select ARCH_SUPPORTS_LTO
 	select BOARD_LATE_INIT
 	select BZIP2
-	select CMD_POWEROFF
+	select CMD_POWEROFF if CMDLINE
 	select DM
 	select DM_EVENT
 	select DM_FUZZING_ENGINE
@@ -152,10 +152,10 @@ config SANDBOX
 	select PCI_ENDPOINT
 	select SPI
 	select SUPPORT_OF_CONTROL
-	select SYSRESET_CMD_POWEROFF
+	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
-	select SUPPORT_EXTENSION_SCAN
+	select SUPPORT_EXTENSION_SCAN if CMDLINE
 	select SUPPORT_ACPI
 	imply BITREVERSE
 	select BLOBLIST
-- 
2.34.1

