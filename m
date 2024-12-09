Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9482DE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D148970E;
	Mon,  9 Dec 2024 17:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nWKtHv41";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE8B889753; Mon,  9 Dec 2024 17:29:11 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B117989718
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ea3bf79a03so1864641b6e.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761748; x=1734366548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAiVf99Wf/iuTZZVb7R7+NADu871+VIZm957Xp7pBr8=;
 b=nWKtHv414clCOS/DwOpqYNnWmsIl1HIW6DtHQBhrOtc8/pDofXBpFKbS+4Z1r0zWN2
 kxG7pMeo5nomXjVHWmrWeQ4kbCJXetDeN7RAS9MNWhPtQipz3+I5pHHLs2M9SiUpJ6bl
 VoC2YkK8ro+ErnKWkmtQhfamwN1SjU9OIeZUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761748; x=1734366548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAiVf99Wf/iuTZZVb7R7+NADu871+VIZm957Xp7pBr8=;
 b=P34s9RnjD68PRM0058E0I5v8puPV0oF+sZ+wRNqakJ9oi7zIs32ezRvQb4+XN75Vc4
 1GqRKXLQRsi6C/rzus7RkFDG+DYcsEpC0/r8bZ09pzJN1t6HGsQn7xqWXOw7qsXXOOtE
 W+d161NVC2qOe3jpWXRdhosOLCgivgpjJnZJDu9hsD8Sq2HpZ3GPlSflBuVEISYL16WD
 /amsJ3Qm7WSA+M+h4evxARxYSgLbjzLT4SYMYC2DSuYNL75OnUR+3LTsBMUj46Z8pwcO
 BwpOl464cs0fNQG7rRIGQTORvyA2IzhhZYubDIv14664Kn903ikfGNXyAnajUJp0WDJc
 Z5mw==
X-Gm-Message-State: AOJu0YwvmUE/PNP0yGBckVlhaMON4+MmpCMW+UfHJSIvE/8nyStVUI1M
 7d7DM7LJaumFoia6wOBNhAtk6G/p0TeEV1cpSu4GQ4tTVqt3v4egwLaXOXg0r26vrFQflKgcP4A
 =
X-Gm-Gg: ASbGnctMChzWt5QijO0kwi6EDo+M4H/Dyya7M6J2hp21F81MvK4jq8VSFWNq3463/O1
 ri6NcwKhEnr36TbEDZMoPU/05RarnkM81WQuHQmulfUqZKnT4rjFMBqhPa7P1F/+nS7DXtbOVJs
 HQP6SIpqWfw71hT9IVMkfqdmppFE+OiaOidB6q0BDmInvvkd/98QacYBzlIB9zum0T7d55IYgGY
 0jIfiyQxQ7GnNBmzr3ItdS9GExv4EhI9HPQzowDAy4rnelPn3G/rC+NBG8r4+t/dmG/laindQ8W
 9W0itnWE6sI=
X-Google-Smtp-Source: AGHT+IEF1qYwC7cNnhEnWbZQI/2aRGcfbvvLyQMggvKxr/V5R7BOKMgyCuQtDvHv/7E4p3CEJuu7dw==
X-Received: by 2002:a05:6602:6c02:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-8447e376d6amr1883476339f.14.1733761737211; 
 Mon, 09 Dec 2024 08:28:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:28:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] efi: Drop config.h
Date: Mon,  9 Dec 2024 09:27:57 -0700
Message-Id: <20241209162801.288363-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209162801.288363-1-sjg@chromium.org>
References: <20241209162801.288363-1-sjg@chromium.org>
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

We don't need to include this file anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/net/efi_net.c  | 1 -
 drivers/tpm/tpm2_efi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/efi_net.c b/drivers/net/efi_net.c
index 370056040f3..abc69058437 100644
--- a/drivers/net/efi_net.c
+++ b/drivers/net/efi_net.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <config.h>
 #include <dm.h>
 #include <efi.h>
 #include <efi_api.h>
diff --git a/drivers/tpm/tpm2_efi.c b/drivers/tpm/tpm2_efi.c
index 2eb144891d8..c6e7db762b5 100644
--- a/drivers/tpm/tpm2_efi.c
+++ b/drivers/tpm/tpm2_efi.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <config.h>
 #include <dm.h>
 #include <efi.h>
 #include <efi_api.h>
-- 
2.34.1

