Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969ABCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A243D8745F;
	Thu, 19 Oct 2023 17:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oVTjb50G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AFB387436; Thu, 19 Oct 2023 17:01:18 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2E08744A
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a82f176860so77509397b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727674; x=1698332474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OorPIuOVKVz9rFKT/jKzRAK0NZ0dSHPSox/T+J0xDbc=;
 b=oVTjb50GKedmBkKp7HApMyPfMo9jUYcic+eIpP660CRrKWYaYKVc7Hsc+TGHdS2mXq
 ALc/kDhUktTRC9QmDrCqG0MR88F5IA13s6IhADmuCo72Dc6DMesggJkc+ODRdOWDxyCY
 EQfkuv/AxUbtD7XMQyTPzzJV9k4zQyd7fzjK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727674; x=1698332474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OorPIuOVKVz9rFKT/jKzRAK0NZ0dSHPSox/T+J0xDbc=;
 b=D/YUNy9ZrM0EMvGH5rkv7vq9YSyLg49b9ck4GYAQqm0esGJXgITTysbQw1+cu12s+L
 +WoJYGs2laacFdCdjF/XuroEA+RFh2LRQsJUf44IJtQSaDiThkxg3yhWM7Y7IBd2KTAF
 ErkJnDii8+cPje58CbkzX5C7sD5CB4wK/zYfBD3xsQmKs+xzoOOGfDy+559BbSzLspr7
 qQ6rrp13tBoPrswAtBEm2JGdUYidawXz/3ficUikhzbX8bfy+BLW5hJt/cbMZdMFMell
 H90oAC1U+r0/6Yed6+QgNnKXg9f2nT4xPmdAUVgkv7jHaayayAyXRr2pmpdBo2d1/zGG
 niMg==
X-Gm-Message-State: AOJu0YzPVj4XcxEoq/N3UwlRDP46jbFHqvIDo82PqBmxQjqP2vmIdWXp
 YRW80pWLnVbataggRscaPhTgXSy+ahPAWVkGfi3C7A==
X-Google-Smtp-Source: AGHT+IHwZuNVV9MG9HhHdRaDDDpiaxl7KCEQOBD6eoz+Ka4MvCFVyrCHwa+hsPisLL8OxICmlJVAVA==
X-Received: by 2002:a05:690c:39c:b0:5a8:1d2e:e3e4 with SMTP id
 bh28-20020a05690c039c00b005a81d2ee3e4mr2877748ywb.35.1697727673723; 
 Thu, 19 Oct 2023 08:01:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4 08/24] test: Make UNIT_TEST depend on CMDLINE
Date: Thu, 19 Oct 2023 11:00:49 -0400
Message-Id: <20231019150105.714407-8-trini@konsulko.com>
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

Many tests make some use of the command line, so require it for all test
code.

This could be teased apart, perhaps with a test flag indicating that it
uses the command line. Leave that for later.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/Kconfig b/test/Kconfig
index ca648d23376f..c3db727c58e3 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -2,6 +2,7 @@ menu "Testing"
 
 config UNIT_TEST
 	bool "Unit tests"
+	depends on CMDLINE
 	help
 	  Select this to compile in unit tests for various parts of
 	  U-Boot. Test suites will be subcommands of the "ut" command.
-- 
2.34.1

