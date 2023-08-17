Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879BFC3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF8986BA3;
	Thu, 17 Aug 2023 19:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QuUhL4qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2ED86B96; Thu, 17 Aug 2023 19:41:30 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E501486B96
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bcf2fd5d69so120778a34.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692294086; x=1692898886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=i7DjVnXA8umFlQujAjNwNTxgLjYcmWgr5UQUrwGCaR0=;
 b=QuUhL4qbgBCXUpwjTQVKTJlZkHU6PN5v7DlBFCJDLCOJ5+Vdy7scUlgwrlOaQQgBNX
 MOKRQbck/YU7pq4BZLJNUYeoyLkMEe+aoBOl3Ga9HW56ACEQxGRhmlZZ7VkYuleyk1TH
 NUUKhnSapvijrQoQ4j7/8eMYC9YzGf7gI3L6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692294086; x=1692898886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i7DjVnXA8umFlQujAjNwNTxgLjYcmWgr5UQUrwGCaR0=;
 b=ZKxsQ+0yS4qTBnyV82YsyxYCSM676JffGZcXX626qLbXVYecLtlF7Bdd2OAiQ9ubYi
 ECzSfJdG8NuWOf50BwuFKt+KgLYx3cUqDUuyZEsnjA4w7DRaRIuLv56ftEki3S/ynavI
 REkmTBz/TgTcMYJlozGj97AY6MGNqSoJRperMn3R95TTIFmvdfYre6vgLV+a6E+fp2F6
 Hz7nTuIERbeD0WmX1x1Xhbsp2hG9I0Eet1imOia9xW9hMWLgwTfP/QQba+MhqznGwOHy
 ienBR91vDEfTKuKv975DuHHvUILMd59BMA0ZFT7976JmZWg/3o5EO+aH06aqCKajSTaO
 cu7g==
X-Gm-Message-State: AOJu0Ywu8WqfQOa9NW/ma0b5WHF7GoL+7KmnyeRue+GLHqvKo0Ht7t3b
 mbRuTFpNfYOjTrfzqEjunIClHLXJ7I9K6r/6oNC7vA==
X-Google-Smtp-Source: AGHT+IGbyOf5uuRVWa9qLBYgL8vc0yQw521QQZe1S1+Tj+ZJzJH4L/lgJcBUokSEJqSGAzlovlXQbQ==
X-Received: by 2002:a05:6358:8aa:b0:13a:a85b:a4ce with SMTP id
 m42-20020a05635808aa00b0013aa85ba4cemr167120rwj.16.1692294086391; 
 Thu, 17 Aug 2023 10:41:26 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 78-20020a250d51000000b00d1b86efc0ffsm4099005ybn.6.2023.08.17.10.41.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 10:41:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/4] usb: gadget: g_dnl.c: Drop unused includes
Date: Thu, 17 Aug 2023 13:41:22 -0400
Message-Id: <20230817174125.369849-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

We don't need <dfu.h> nor <thor.h> in this file, drop them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/usb/gadget/g_dnl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index afb7b74f3057..8423da377ca9 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -16,8 +16,6 @@
 
 #include <g_dnl.h>
 #include <usb_mass_storage.h>
-#include <dfu.h>
-#include <thor.h>
 
 #include <env_callback.h>
 
-- 
2.34.1

