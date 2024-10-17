Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D06D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA01789271;
	Fri, 18 Oct 2024 01:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kdW2SrxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1882F89251; Fri, 18 Oct 2024 01:25:05 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDFD891E3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83aaf8189bcso50075939f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207501; x=1729812301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnA0/Ig+TCDhjO4e+kjss3XT0SGZ5G4aD1pKBxBtwKw=;
 b=kdW2SrxYUijks7Bf1Ss/X/rFDYOP+tFYJzwoQBr8z6b3fVdCZaZ/H2eJlqRBfjoa5v
 EW48znycg44e2edoy524htvF93ftuLdScf8CU1b9LnbtXUuqs3WjERjoCaEahPy1USOM
 bCZFD5igrGizaVFMIYTXf9YgTSbN74NBGYs9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207501; x=1729812301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnA0/Ig+TCDhjO4e+kjss3XT0SGZ5G4aD1pKBxBtwKw=;
 b=l4wJEQdVQt4nXHT3L3XFYr0AasxObSNbysZOe0Xt4H1Es5x9dCXeuaI1k1wvMPFwmf
 P275Ki++GIVYtLn7ogc5CwOlr/hbCIcdzUvTRtytQfLx9jP2f9Fy6FYy20uU+JRiLYRD
 xF+ZKPup+cvyWGSqknHRl6eDeBPqvNTXsdQA/EsaBO/eAJgzfUV6VUwq8K0OHbXaZJ+U
 ETWX/7zCGXjD7L12WBn0PUWvcZr8JMqaVmwrgVoWr5WPAMBTmjnFX4QqI9rGjOPuIFYX
 4xwcva1Y/BK1ki3OxpIuLZsPSTgajIGPJIVUWLLuLhv6AGfTtUnQWdgxOZBj9aVR9sLy
 GvKg==
X-Gm-Message-State: AOJu0YyXJM76kRNJrgrg6z+4GJlH08MgZ6DWSqhdH5qoNau9naEDAdO6
 jbdk+Ki3lQubMFyGzf5YUujSVjOwOKHZvWJQsEZ46tWuU/lQWsLKb4+RLzg5222qsgIbEYKZQzo
 =
X-Google-Smtp-Source: AGHT+IEn39EQ+S3PD87FE0dxybps2j81g29bPoqVwJj7H2vX/RP4NvVPbmWzu32FXYDHXhoTuUmbLA==
X-Received: by 2002:a05:6e02:216d:b0:3a3:b143:98 with SMTP id
 e9e14a558f8ab-3a3f407423amr4544915ab.15.1729207501582; 
 Thu, 17 Oct 2024 16:25:01 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 21/34] test: boot: Update bootflow_iter() for console checking
Date: Thu, 17 Oct 2024 17:24:00 -0600
Message-Id: <20241017232413.724808-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

This test checks console output so should have the UTF_CONSOLE flag. Add
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8ea284098e7..efb82ee628b 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -370,7 +370,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
 /* Check using the system bootdev */
-- 
2.34.1

