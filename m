Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CCECDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14B288FDE;
	Fri, 27 Sep 2024 00:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MokEazBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDFF889AA; Fri, 27 Sep 2024 00:43:26 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5EF488FF2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-45832b2784bso10488861cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390603; x=1727995403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9/u1Uw/I/PqSfmemQH4CPz1z3dg2e/lQinOmIApkgs=;
 b=MokEazBt7um1nXsUMDu0hs1tdZoC+GRCk9/epxHgmU4WejjZlZF7rrqs+gst+aqe4f
 7LUxPQdQWyc3AnLkjjhCyZaz34XtoB42bES6jFxcIkzb4569Yw9oPaTQOroPdn/C7mbJ
 pA0Jb7yQq9hkt17mkIM1XawcjiYIYrN2xaN4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390603; x=1727995403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9/u1Uw/I/PqSfmemQH4CPz1z3dg2e/lQinOmIApkgs=;
 b=POmOjYWp3FzouiTU0yoxbqhrjVWP1hKP2CEZWA4S8RjExdIVICej+zh8/PmUiH7VdW
 bq9MEvCPv+cc42cjXwzPwY4aFM0NaM3PgdlSf3doCBcMhGY4XZn8lapQH9fGzM0CYrhT
 oVaadFDuNd9kUIHojtG4PvavUx4IEDxpZnX/YYwoMB7MosFO3W2AIICjPHCU2W97WKjc
 W/U/jPgLMi2uLjTBkL9cR46yDjmbxt5kP6fQrvufd9E0MlsuEgsFFheP9MRllc/tSUSo
 MdvkLZdP3O0MCp29Y3IQbA3i/QtpxYqgyoIiK86DEIPbkCafYM5h014hJOsop7rQhjSr
 1oUw==
X-Gm-Message-State: AOJu0YwCa//h8fKQ7wkH2eL6gBGLaKb1WFeH6fNo3YkTX/LfwARgVQuH
 42pA1x1wbWcP1pY9vRJp/DmjyOgxf3mXJJEIvOTDjHIoAJEQ4TusMrpeBoUsf0aJ6fIwMuFILpF
 hTQuytJE=
X-Google-Smtp-Source: AGHT+IGUl2j7konjQM9nPQvA1q9Cq1bVX2n+/QXjzmXEXP8awcqQ9ywNYALCb/vJygI8cCYE+o0wVQ==
X-Received: by 2002:a05:622a:54:b0:458:2334:b8d1 with SMTP id
 d75a77b69052e-45c9f23bf4fmr19702031cf.32.1727390603546; 
 Thu, 26 Sep 2024 15:43:23 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:43:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH 23/42] serial: Make use of the SERIAL define
Date: Fri, 27 Sep 2024 00:35:48 +0200
Message-ID: <20240926223814.1276764-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

This is always enabled for U-Boot proper, so simplify the condition
in the common Makefile.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/common/Makefile b/common/Makefile
index 9fdad4bc38d..ae8984659c0 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -65,15 +65,7 @@ obj-$(CONFIG_DDR_SPD) += ddr_spd.o
 obj-$(CONFIG_SPD_EEPROM) += ddr_spd.o
 obj-$(CONFIG_HWCONFIG) += hwconfig.o
 obj-$(CONFIG_BOUNCE_BUFFER) += bouncebuf.o
-ifdef CONFIG_XPL_BUILD
-ifdef CONFIG_TPL_BUILD
-obj-$(CONFIG_TPL_SERIAL) += console.o
-else
-obj-$(CONFIG_SPL_SERIAL) += console.o
-endif
-else
-obj-y += console.o
-endif # CONFIG_XPL_BUILD
+obj-$(CONFIG_$(SPL_TPL_)SERIAL) += console.o
 
 obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
-- 
2.43.0

