Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42305C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA118748D;
	Thu, 16 Nov 2023 05:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XS0c2Hia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9137687258; Thu, 16 Nov 2023 05:11:26 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C35586F73
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3576e74ae9dso1534075ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107883; x=1700712683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3E/wFD9WoLKDRUUkZ1oy5xIErEVsVFHhjfAQw/beG8=;
 b=XS0c2Hiaagp6pt2e/iCVaXg+bMbkiaf4Fg2eAuTypY5qQgnCcWmFj6Ykn4Y7LlbrDQ
 r8z0tIAX97znS5hPWKYs0UjKPjtcBZuAo+eeTFDGH8LCl3Fqk4ga2KEPdCdHVSwJa++M
 rekeyjciriaw/cZk5IZvrtMCwDWUC7bx+DHIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107883; x=1700712683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3E/wFD9WoLKDRUUkZ1oy5xIErEVsVFHhjfAQw/beG8=;
 b=uM6cbe9RQXZ7HY3wr7tRuK5v1jIpt7ciBgrEi/rDy5fO/KB3zhhLYcp/SlTdUoIrHm
 xeqS+4H1n/Gaa72OO93Rpcvk8Wxr0nI+Qvm13I8n6JXxvBlSsp19XB1A37MTqi+QHq6s
 qJSGnnbm3LHpUkpzN5aCGpy7x55jCv+kdoh3l+8Pegi4J011A6uxHCsby2KUQmPgpJGZ
 hEe3ZU+AORkjWoBZptBdZZ/j6KncNIdb1zlaRWkgzj7GqDAU7xVPVm9TwvA/pvzMKwAA
 8lVisahIexGFkbm9ETFnCR/WHp1uOBuQZY5p/EA091mfItdV+zq68FanyckZDE6MM6wo
 MlAQ==
X-Gm-Message-State: AOJu0YzDEFPIDYbvoj25WMa7AZD2VFWBYzK3pRXg379362La3FYVu99g
 oXWUswGYal4Jz2Oih2ilQyChTt5duF+hE3Hy6Sigdg==
X-Google-Smtp-Source: AGHT+IGrC60Sob8yjiRGBic4KKPpdNx0GG8DU0HVO6Bjw0H29/rzOsg6Y7OhFUG1FhFB8ojee3U+Fg==
X-Received: by 2002:a05:6e02:1e0a:b0:359:6dce:67bb with SMTP id
 g10-20020a056e021e0a00b003596dce67bbmr20535616ila.23.1700107883013; 
 Wed, 15 Nov 2023 20:11:23 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 05/32] bootstd: Add missing header file from bootdev.h
Date: Wed, 15 Nov 2023 21:10:05 -0700
Message-ID: <20231116041043.362055-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

Add a dm/uclass-id.h to the bootdev header file, since it uses
enum uclass_id

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/bootdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/bootdev.h b/include/bootdev.h
index b079a91b5b7f..c1362673d418 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -7,6 +7,7 @@
 #ifndef __bootdev_h
 #define __bootdev_h
 
+#include <dm/uclass-id.h>
 #include <linux/list.h>
 
 struct bootflow;
-- 
2.43.0.rc0.421.g78406f8d94-goog

