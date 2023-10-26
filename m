Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D92C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DBC87BB7;
	Thu, 26 Oct 2023 20:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dhePn3NH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04C787B5B; Thu, 26 Oct 2023 20:32:01 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 807F487B7A
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-778a92c06d6so91075285a.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345118; x=1698949918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8SWWNT44yoA5Jj1YvnjDnimjuziWjkCW4wW0WfocA1I=;
 b=dhePn3NHgItuiTjRrH02H+oU5Y4tT4M6RmhMh62zxcc4XOk8JkWNhPPSF6AspJfLhq
 XsTVq44MSHkTbQs17TDLK5cIgM1gBBCeCKnncI8FnOk1o+eM1o5UhkrdV92qtkJYPDbA
 9kv3NownawbTOjFPFoDOhuFb1p86G8FJsdC0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345118; x=1698949918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SWWNT44yoA5Jj1YvnjDnimjuziWjkCW4wW0WfocA1I=;
 b=Lc/IOxxedHAJHnb5Z5BDhREMY/7fZoyx42TX2v1yk0z3SK1YyW2N+LGf/G+tzkibok
 Gh2AcNgwSEx9ql5X6cSPMF+Yr6+Yiwd+jaZ454+t47ArvH7eT1x9VoUXkBK7jvA6sSPF
 GZGfbsxq4NZZrh5H5MMWBItI6Byu/JwF+hHtNPJp7xfOA4QeC53bLMcHIXo9TDaoyZOs
 b9toDnYkLEXyDdKjmwZf4yl7jUgchMzrxigCqkCIjHYuhoyPHOSQtAY94a1eHb5kulyG
 52CxugkS+2ud0bH/mmI/zFkqtngalRIUFSLWKBrK1sZHj7LS/d8+RO8zVHnmHB7Dnbyo
 rIlg==
X-Gm-Message-State: AOJu0Yxon7us8yIoNRvg02R1Ox8DszcrPa+BSGIgsiyJbYcH7yAdw7SF
 /3u3QZkpI6c/83nixomaYCroTn5EydVD2uJoE0OZZA==
X-Google-Smtp-Source: AGHT+IEzAW7Jbotn3f4rbiJhMc9/rF/3oYmjtXmWEEGtqOmqNSUviDmO+TR5XVxjx47icqYG2Uq95A==
X-Received: by 2002:a05:620a:4622:b0:775:c5cc:7ce4 with SMTP id
 br34-20020a05620a462200b00775c5cc7ce4mr182010qkb.13.1698345117999; 
 Thu, 26 Oct 2023 11:31:57 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 22/30] fastboot: Depend on CMDLINE
Date: Thu, 26 Oct 2023 14:31:30 -0400
Message-Id: <20231026183138.636948-22-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

Much of the functionality of fastboot relies on being able to run
commands as defined in the environment. This means it does depend on
CMDLINE being enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v5:
- New patch
---
 drivers/fastboot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 837c6f1180da..11fc0fe1c800 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,4 +1,5 @@
 menu "Fastboot support"
+	depends on CMDLINE
 
 config FASTBOOT
 	bool
-- 
2.34.1

