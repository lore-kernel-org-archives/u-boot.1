Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F86FC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B62978391A;
	Wed, 28 May 2025 18:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IsyqZ8jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E2C83979; Wed, 28 May 2025 18:08:35 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4FFE83903
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-8647a81e683so85274039f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748448512; x=1749053312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=waY0fgc3qCci9ftjX9hsg8FzEE9LcDyz9etB0ZWAZv0=;
 b=IsyqZ8jlTVuwLucUkGMSSlKdsDcltVTC/hS5oFI42+PsOPXC577R1XLduO5vPNvq+Y
 1lS4AxB+cehJL49SzUw6WYPmn1xMUdNYV1AYYcg8gSmozXZAHs619zjdPQVRVtT3I74a
 awsOgjCtrdFNaN3/nTnABazQz5MqoWwtS0smA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748448512; x=1749053312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=waY0fgc3qCci9ftjX9hsg8FzEE9LcDyz9etB0ZWAZv0=;
 b=A7wMEPqza9x4t1+X2aukNH1nZhgvHspVmRWELqWmJxS0t2eUUPf0enNyCZ0O5/p9qi
 mVQrt2UviuC2hNqy4JM8OVsKb41uhjTqxZxUZc9ooELZJhmHA2qZYLIegmZsdoO+s9sp
 D9MHjnVpd3sI99f/BmykK4w6VW1WLsBnrcirTNk14nr993sufyjJ1fztvky1y3wNECOg
 m6PI/mOJzqZiN7ekLBitFY6V2m7MLO+lfMYc71AB8j/KaS0VdOu3uryFh5YGAd07DkiB
 /Izk7hOY7teJXqKoj3vEfJXuwx/dZ2a86At9cT1f/hWxHlJ0z02hMlHJZYFbq7G9j44J
 59SA==
X-Gm-Message-State: AOJu0YxdnO6yGs81JnEQjX2bfwNxGfZFe2uiie7YV0cqzXceT2SwYYaH
 geQGfSjeHKEtM4cGKmHHiYSuPhFGdK8UKR0zTbCw9D8R+KP4KB9X6u0SvGxV5arx0NTVGWIKYLy
 rQliIH/S3
X-Gm-Gg: ASbGncs9D48g76ot+MLZJzbovb10WWVO2oXKdI5hfTkl9o5iJ2Pv5Rns44fLdvCPzBr
 7M0CMuMOTBSD0RmWVyQSYBwtZGtH5fZeduPPohO1G5TmbuPCtrCWnLZAnny+7TC60heLNj/aeTc
 /AfzjypSeJhx5p6s5FEme8KZQTzeqea2pXNg66Vf6DeFGQs0GCfDMX51zxLFWGim35HenwIR9bI
 yr5umTfOxdPoPd0bmaAZK2JGx8eePWgYxcK68LsLmummCGm48ADyZRbqKwHZGVjGX/kcSALMe7i
 ZBLXJTPm0Tsh/bz9vPrlo9nKNv2r6m86Wz78JjN54zGTzr1M5n5qJ4779O7kGmeHqDsCAzxLgy8
 asEqwufVKg5G7vvlkWaxFNVY=
X-Google-Smtp-Source: AGHT+IEcna1xRGzfseFFFha+qbjsqVgzWVNtpY68nRQaYrOLRGX1azO2uI36nTHyM+9j31s0qpDcfg==
X-Received: by 2002:a05:6602:408c:b0:86a:246:ee96 with SMTP id
 ca18e2360f4ac-86cbb8ed94dmr2335489539f.11.1748448511805; 
 Wed, 28 May 2025 09:08:31 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd586873sm276277173.90.2025.05.28.09.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 09:08:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] efi: Update maintainers for EFI_CLIENT
Date: Wed, 28 May 2025 10:03:17 -0600
Message-ID: <20250528160323.1184731-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528160323.1184731-1-sjg@chromium.org>
References: <20250528160323.1184731-1-sjg@chromium.org>
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

The 'EFI PAYLOAD' entry really refers to the EFI loader and EFI APP
refers to the app and the payload.

Rename 'EFI PAYLOAD' to 'EFI LOADER' and 'EFI APP' to 'EFI CLIENT'

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46ef4359961..8109f0b4df1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1092,7 +1092,7 @@ F:	drivers/core/
 F:	include/dm/
 F:	test/dm/
 
-EFI APP
+EFI CLIENT
 M:	Simon Glass <sjg@chromium.org>
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 S:	Maintained
@@ -1106,7 +1106,7 @@ F:	lib/efi_client/
 F:	scripts/build-efi.sh
 F:	test/dm/efi_media.c
 
-EFI PAYLOAD
+EFI LOADER
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 S:	Maintained
-- 
2.43.0

base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
branch: efit
