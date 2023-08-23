Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056B2C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89273864FA;
	Wed, 23 Aug 2023 23:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F+Tt5Wmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FCA6864F2; Wed, 23 Aug 2023 23:11:15 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD55855CE
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79231457b7fso127244839f.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825072; x=1693429872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYz1gi8zN996oK2EufVc5asTI4fDQTc+8sSPxlHiKeA=;
 b=F+Tt5Wmh4sEyYdzrk6sbpabf/9JimoCitZS7tszHpgBCebv2zJClqp/30LTjgjAl6a
 pXdehD01XPvw9vV+qEh+JzsTd1AB/LBhGyimaT7BUA34UP6cpVaKwIogAXIP6zQMxXGP
 dUM4NYSJ/O+2ZIk7HuKDVt3PKq484+rnN2OMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825072; x=1693429872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYz1gi8zN996oK2EufVc5asTI4fDQTc+8sSPxlHiKeA=;
 b=j0Arxe/JSXqJ0ej4clw+zxbOOTVpDX7O1ufdJN8xSiPPMh/l1NCCRUDX0T/4AFyAE5
 M3TtstIZKTIvIegEbokYRcy/sMbnSfDty3fDsAiaAI5HZi37Y0fgPO8hNOG7kYU7ZCwR
 j1tTjYk44eyTME+rZjTIOchjfs27SHnYlX8k9MJTprGGom9E6XkTizwQjZLJLQArQMUq
 nJJmtetXdyZZv6e1/QUAB1hbknbAe26EziGvHA1UZHRzDj8Q+dTGwffZcQP6Kc7e6u8j
 0JBjHNwwDdpZhuOgwj3vZ+2kzZ0DuNTOacegWaqGh5pgvbOysQ9U0s2jhmNgkV7POyls
 OFDg==
X-Gm-Message-State: AOJu0Yx832g+ktDO+ACiUMzRjZkVGUCe9AhOKqpQFxaXU+zsUxng7e3H
 AT7P+0mW7JkLFqHwBahYwrXz3tyIWUoAomcSJns=
X-Google-Smtp-Source: AGHT+IGYwQ+7O0/JaKv0cBabrNnb8QQ0B5KRTaXmpzOUYxy5hejhPYTzzxNoap3/rf4TCG2uh2g40A==
X-Received: by 2002:a05:6e02:1a6d:b0:34b:aa34:a5d1 with SMTP id
 w13-20020a056e021a6d00b0034baa34a5d1mr4631491ilv.26.1692825072066; 
 Wed, 23 Aug 2023 14:11:12 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 05/20] x86: Allow APCI in SPL
Date: Wed, 23 Aug 2023 15:10:22 -0600
Message-ID: <20230823211059.1235147-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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

This is needed so we can find the DBG2 table provided by coreboot. Add a
Kconfig so it can be enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 42e559ad0b5..1d63099b8e1 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -289,6 +289,14 @@ config ACPI
 	  not necessarily include generation of tables
 	  (see GENERATE_ACPI_TABLE), but allows for tables to be located.
 
+config SPL_ACPI
+	bool "Enable support for ACPI libraries in SPL"
+	depends on SPL && SUPPORT_ACPI
+	help
+	  Provides library functions for dealing with ACPI tables in SPL. This
+	  does not necessarily include generation of tables
+	  (see GENERATE_ACPI_TABLE), but allows for tables to be located.
+
 config GENERATE_ACPI_TABLE
 	bool "Generate an ACPI (Advanced Configuration and Power Interface) table"
 	depends on ACPI
-- 
2.42.0.rc1.204.g551eb34607-goog

