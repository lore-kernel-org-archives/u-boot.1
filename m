Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B8CC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F02686A67;
	Thu, 17 Aug 2023 03:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hkd7VaD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5FFA86A44; Thu, 17 Aug 2023 03:52:05 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E871286A03
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bca857accbso6050960a34.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237121; x=1692841921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRCAvvNVG2SuodnMWL206cCszb+k+4jbkXmVdKuyefg=;
 b=Hkd7VaD/TPxpNVt47DRjrITKnEHDjylgjNR7MM7ow3ZUUvll74Yh49VeK5ENl9E7f+
 vesikX/NIOnowwboA/x5nqj+yAEkQe36ON8ekQ7QW9z4dz1LJvVDbtuBHeyKFUScO1gM
 GNOoDjoKwRs4uy+kel6ncB2+t3Pd8ANa9wgS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237121; x=1692841921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRCAvvNVG2SuodnMWL206cCszb+k+4jbkXmVdKuyefg=;
 b=XAeTQKvoPW8sCvBoVxC6ORjbO7UlP1C5WgOpfif72+6DMeCEOJUvlAIXArA6r/bY2y
 sNJmb4xCwhG33rrwUYhzA9xgxNSriIQsCXl3X9GSYEJnhJvPSyraISOlfNK6EDJDzGUI
 /MEIl8mTrcs616pJ6Hzo37hiIYKbIz4SoRVFyR3oaVWxfsgglhvAuPoCpm9ycXfLGft2
 9nEbSA0IO0OuPrrlc3BJmoeovgLJN1wIB51SJYgd+AlUQsVLmZKwj4uj3beYUUzgq9x8
 xkO2ojHaHLbkX0Em9FUjkc626dqrSlzV9U8CDH8NVjZ6kth94GnsxuItrGS6OyiHgs7g
 4Ikw==
X-Gm-Message-State: AOJu0Yxp509qowbmkG2q/mmU07X0MwrJxUfLyV5jTrByN1/hNZpfdVTg
 GxFpI68qHU5d3fsfEjdAiv0M4QSwpqwOoyE6HXQ=
X-Google-Smtp-Source: AGHT+IFLAcFx1UAvjBWz3Gyb1+BUC3y7bWydi0+ZtAExRREYNJOfUKJ61AsVylz3nTu0vos2lPEOBQ==
X-Received: by 2002:a9d:73d7:0:b0:6b9:e412:b02b with SMTP id
 m23-20020a9d73d7000000b006b9e412b02bmr3596731otk.2.1692237121528; 
 Wed, 16 Aug 2023 18:52:01 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:52:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH 3/9] x86: Allow APCI in SPL
Date: Wed, 16 Aug 2023 19:51:38 -0600
Message-ID: <20230817015149.774847-4-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
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

 lib/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 42e559ad0b51..1d63099b8e18 100644
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
2.41.0.694.ge786442a9b-goog

