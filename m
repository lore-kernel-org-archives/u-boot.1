Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0021C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D06688B70;
	Mon, 26 Aug 2024 18:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kVtGfCrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7306888B0A; Mon, 26 Aug 2024 18:50:10 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D259988AD7
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bd6f2c9d52so23942046d6.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724691007; x=1725295807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Y1DGcNnGUzbMBawizVe9B0CJFy965ewVZ9S/In8BwY=;
 b=kVtGfCrlIJXGE2Ymp7XxYz1iIlYwn4q6nfgtIUoKsjwa5QzNjsLEhRJ34SIyaNOZGP
 m7VfSnc60vrXCtKUTvTevMqnDL6gTkoxomQ2TEI2snlnORzJ1UG8A6t8KGBzYVcoEH+w
 aSsoOv2Bsns/k+gXc9N95P8Qh4951ONejzS80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724691007; x=1725295807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Y1DGcNnGUzbMBawizVe9B0CJFy965ewVZ9S/In8BwY=;
 b=IBQLhDCeBXYKjp3dDZRxodLKFykUlO2aPocRECoF4b+hcHhOqFBqmRoLx5xrEQeiRB
 s2nRo99UPCcSSEiZP7ZAcJ7C4G4V2dpMwYtAyhdXCJPU1Wwweue9I/A+5HKM3AHx5QMr
 x4ZxZ/bhucI8iKEABF5oOoaVuIQx2ieReaWvApOgVWPuk9CANZ2FIDISRRAzg68JNevx
 YUTVpZDeK+69kXrd361K+KlSphtC8okf9tUjjph+IxItwaL3z4ndwzucy4tkppFSx9aW
 /ETkefBmpk0KEaK9iIj63MGOA9dKj5A9t7MHrjOWU/+j8cG68CqNyYfFlzX/gPKYAfKm
 ACkA==
X-Gm-Message-State: AOJu0YyERa9kTK7uKz/hA5plkoW/cOiQmf7t6DKM1pXG+LrwZ5qr7MHS
 Bh8nsMDtqNl3VbXLgGETxt2QQelM3fFC6jNYzVtl7APqXSBrrcDM/LE6u1wrNqZpU/Z1RR+GJfA
 3
X-Google-Smtp-Source: AGHT+IECMc8BQLm808sR2OGY1et5RpbYBVbODFi2ggJOD/pIELjIvbmaftpREs/7hiBZ69ZLHliAug==
X-Received: by 2002:a05:6214:4381:b0:6c1:6b40:113c with SMTP id
 6a1803df08f44-6c16dcc9228mr125886916d6.51.1724691006605; 
 Mon, 26 Aug 2024 09:50:06 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d242sm48576136d6.16.2024.08.26.09.50.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:50:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/6] doc: Update rST to not reference the old wiki
Date: Mon, 26 Aug 2024 10:49:54 -0600
Message-Id: <20240826164957.2789525-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826164957.2789525-1-trini@konsulko.com>
References: <20240826164957.2789525-1-trini@konsulko.com>
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

In two places we had references to the old wiki pages instead of links
to the relevant part of our documentation. Update (and slightly reword)
these spots.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/process.rst | 5 ++---
 doc/develop/version.rst | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 0542b3fc1245..0c6fb31e87b9 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -23,9 +23,8 @@ Management Summary
 Phases of the Development Process
 ---------------------------------
 
-U-Boot development takes place in `Release Cycles
-<https://www.denx.de/wiki/U-Boot/ReleaseCycle>`_.  A Release Cycle lasts
-normally for three months.
+U-Boot development takes place in a :doc:`release_cycle`. A Release Cycle
+lasts normally for three months.
 
 The first three weeks of each Release Cycle are called *Merge Window*.
 
diff --git a/doc/develop/version.rst b/doc/develop/version.rst
index 5c9046aa17aa..de11836af45e 100644
--- a/doc/develop/version.rst
+++ b/doc/develop/version.rst
@@ -9,7 +9,7 @@ release that came out in October 2020. Release candidates are tagged every few
 weeks as the project heads to the next release. So 2020.10-rc1 was the first
 release candidate (RC), tagged soon after 2020.07 was released.
 
-See https://www.denx.de/wiki/view/U-Boot/ReleaseCycle for full details.
+See :doc:`release_cycle` for full details.
 
 Within the build system, various Makefile variables are created, making use of
 VERSION, PATCHLEVEL and EXTRAVERSION defined at the top of 'Makefile'. There is
-- 
2.34.1

