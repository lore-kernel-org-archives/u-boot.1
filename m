Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7659ECDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 862DE86DC7;
	Fri, 13 Oct 2023 01:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E1hBVjWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239AD86689; Fri, 13 Oct 2023 01:04:25 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCC886E0E
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-579de633419so18202857b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697151842; x=1697756642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W//peJYtzJoT8fZiZ2pPMsOa0HGkNle8EbMYeXK9/dM=;
 b=E1hBVjWo7zk67TQmwfY8fR3wJ1zJIIP9eY1zcXr3PV1gCh79L/rK+53Keex2PyrFA0
 ZJwTXpH2HvMaC5SmkH/5Ols6gQNad2caIUF0QBWbptQXehKuwdz2XnOCnzIq4uBtwHUz
 VTUnpCzIwKld7LQ9sg3CpvPurkzGkTWAduHOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697151842; x=1697756642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W//peJYtzJoT8fZiZ2pPMsOa0HGkNle8EbMYeXK9/dM=;
 b=fZpZ0Rz4X2fkqGHfPBETaen8Aw3m81EV7DcsyovHOt4X5ZSZx2wir/iTnZCq5cQXC+
 pMWnsK0qPB7RSHzbUXL/+FhBBOK+/jyUi1QdKINTA4pNyfMmep1pHTzVxgaCfOSNDjke
 n5qwn0MMsF84FFKPsGswkl5ray2fe2aKHeKL2RQ/vV75b0f6NJvsfoIuZ5ZI1L+sZjOg
 r2ij4wvOVHwHI1KS3aKgcKYMZWhkkziwaZ3jMiY+x9Oi3X+7f9RVgpnCaiNPAaAEi+77
 5tzGujujHUnbArc84YKgKo+C931Q6R5edBM6FDkX9bEZP9M3ssGJOFD+sU1tLzJjRqgu
 ibHQ==
X-Gm-Message-State: AOJu0Yy2UFFZ7RDbTyoM/54Tc5T1wfCoPRnaf3RAn/iAQ7huIPDaTm8P
 59avKIRjAX9zeAgblHfccXCHxSz5PheZneydepGxGg==
X-Google-Smtp-Source: AGHT+IGq0MnqER/feiwnUN3pe05c9jDXV9RloJ3vKttZn4WnZJZmO6DVfzQjArMYLlPSn99auT8obg==
X-Received: by 2002:a05:690c:fc8:b0:5a8:102:fe3e with SMTP id
 dg8-20020a05690c0fc800b005a80102fe3emr2992892ywb.11.1697151842034; 
 Thu, 12 Oct 2023 16:04:02 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a816f07000000b005925765aa30sm278730ywc.135.2023.10.12.16.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 16:04:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/7] include: Add <linux/types.h> in a few places
Date: Thu, 12 Oct 2023 19:03:54 -0400
Message-Id: <20231012230359.2005249-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012230359.2005249-1-trini@konsulko.com>
References: <20231012230359.2005249-1-trini@konsulko.com>
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

These files references a number of types that are defined in
<linux/types.h> (and so forth), so include it here rather than rely on
indirect inclusion.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 include/bootstage.h | 1 +
 include/cache.h     | 2 ++
 include/cpu.h       | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/include/bootstage.h b/include/bootstage.h
index f9376c320c96..affb0e5c6a6a 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -11,6 +11,7 @@
 #ifndef _BOOTSTAGE_H
 #define _BOOTSTAGE_H
 
+#include <linux/types.h>
 #include <linux/kconfig.h>
 
 /* Flags for each bootstage record */
diff --git a/include/cache.h b/include/cache.h
index b12fec259156..296ae3c8b48e 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -6,6 +6,8 @@
 #ifndef __CACHE_H
 #define __CACHE_H
 
+#include <linux/types.h>
+
 struct udevice;
 
 /*
diff --git a/include/cpu.h b/include/cpu.h
index be02a1671298..2077ff30634b 100644
--- a/include/cpu.h
+++ b/include/cpu.h
@@ -7,6 +7,8 @@
 #ifndef __CPU_H
 #define __CPU_H
 
+#include <linux/types.h>
+
 struct udevice;
 
 /**
-- 
2.34.1

