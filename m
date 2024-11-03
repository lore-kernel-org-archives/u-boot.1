Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4223BE67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6534890DF;
	Sun,  3 Nov 2024 01:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d+ON/O3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 232CC89119; Sun,  3 Nov 2024 01:37:46 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069DE8908F
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20caccadbeeso32898915ad.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594262; x=1731199062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPjKigl4EG0qwFglAgJBQm00iJMytKBfGab7aZpEBZ8=;
 b=d+ON/O3f3yX8wB8QFoQ4GP2Ue8Cpgs0CVwulKNMnkcZiE6JGKRgcl2HvP4AmhNo24n
 A8KQjn4KrI2pEU+1CZyzXzQNe8nii25Vo71GDNf2dEpzcwvVpapDSU7wHMMJ8iZHcvjS
 IbtsgNCd3m9TI3zK2IXSeEvle4nETxUpcQurE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594262; x=1731199062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPjKigl4EG0qwFglAgJBQm00iJMytKBfGab7aZpEBZ8=;
 b=jGEBSo2lt4XUi9iAWo+rEDYuM44tFHiVOWMZom7pydoNlejMU3XTYqlZRTnBVUdkMx
 zg5O3xY3fZYxHbpm+aOp1yHgsqWFlyx/6UR7UG4RtfEIn7JMguIrsGBI9gYsCQH2TS1x
 kGGepO0tvFbuZOvQuVar/Lh/6dJx9Xqu8pKdqC8aKmFQOovE5+haMeelLG1u4nuHz+d9
 fo7ATvilIYucOpTVFY0SynPyvRiLd6Ulsv7UTBzp6mqFK1zDgkUO1U2rJOCg5pz3pJOI
 QJ9+DzeT+IhFYw6S5n9FbPOUZ4OpOCy7ikpK7ftJxQ6U+nVBzbvNrBRW5MEXGiqOJ6/D
 RobQ==
X-Gm-Message-State: AOJu0YzNUUc7BX/zmgr4BLDX7fj5kKs7VaIqKT0jyTD8KT6UHSjNAeS9
 CybGVJPen6rXArMRVpjn3F8eo1LJlpiovE7p9v01JXfFml170Mq672TGW/jxlFsLppIMKabXid5
 1Mg==
X-Google-Smtp-Source: AGHT+IEYl4wvx5H/3g2lwasoXiaC++4h9sOJl/uojb0/0yR6d/K44yASYHeFHJpqMLCDZmlsqD4HaQ==
X-Received: by 2002:a17:902:ec85:b0:20c:e6e4:9d9f with SMTP id
 d9443c01a7336-21103c5a332mr148976025ad.40.1730594261980; 
 Sat, 02 Nov 2024 17:37:41 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:37:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH v3 17/25] igep00x0: Drop unused status_led.h header file
Date: Sat,  2 Nov 2024 18:33:09 -0600
Message-ID: <20241103003322.626036-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 board/isee/igep00x0/igep00x0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index a35a7cd3b1f..35bb8c55806 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <net.h>
-#include <status_led.h>
 #include <dm.h>
 #include <ns16550.h>
 #include <twl4030.h>
-- 
2.43.0

