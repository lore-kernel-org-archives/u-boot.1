Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC344C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C288088B0A;
	Mon, 26 Aug 2024 18:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b2uAA0e9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D60F88B37; Mon, 26 Aug 2024 18:50:09 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E246B88A08
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bf84c3d043so23474986d6.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724691006; x=1725295806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToEQvAt6e9QNH+33LPF1srLJqSTSEsOOpe3ntkVWEFw=;
 b=b2uAA0e9eKwfUmqz/EEJrKE64PO/2TeN+GH6MjsugjFmQeBniQsDYvdmNRiywq8zYf
 QjsSsk5d9KSmVrKICGnzIC1uv4a1RY/ccl3rgN5oYODIW4ZpFwkjBu64ynjK17Dnu8bl
 thDH/4VHfv0PNnqm1dPeBSduQGWzQ04eK98PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724691006; x=1725295806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToEQvAt6e9QNH+33LPF1srLJqSTSEsOOpe3ntkVWEFw=;
 b=glxqJRecMun7mPvZF+mlMpdNU22Q2kD3JOFW1C5mW4IhRWLCnsWfgC1RAhthUTwMrm
 GJSnjlpdWhhITUwXSqaDjx7rnhJiAMViSzkBeN/CSOVDKcuixu2QcKGamnpj9hY9Ed3Z
 bgjU+ZbQxxAuKCUsGfFilQeBJZxFV05I9lSUk5R5ZSYN8kEdEw+g9dNZGEOHBFW5tt/K
 XrG2V9R8k/m5umn/R8KM0OLsZYRJKeeQkc72OKO2Ufu8tuSnlLcQs0CmRA3tfqdL87ZJ
 Ltyb2XevGibuRy9l8CUguLLpJHdfhXvxAGCkVY8aez/7WJ9hR4SoZB3mwMOaybunDFL7
 5PNw==
X-Gm-Message-State: AOJu0Yy4SQ0uF82b/XPRiqnKE4+pajorSDAK/z/EWITTin7m12YQTyTB
 DWxvzti4gEy1HEo0XfPn+ljejpW8ifS0fZI5gkFuVzeDyEf0R02ZC56sVorT4N4RNVE5ojMD7M0
 f
X-Google-Smtp-Source: AGHT+IE6/XfLaJvkovEQfdjwEgwkgGZ+dsA/gwL49MCTHW+epJ7pyBqY3bSpB8Gi9hHf1+lkFedx9g==
X-Received: by 2002:a05:6214:5544:b0:6bf:4fc4:cdd2 with SMTP id
 6a1803df08f44-6c32b6c811dmr119436d6.30.1724691005726; 
 Mon, 26 Aug 2024 09:50:05 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d242sm48576136d6.16.2024.08.26.09.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:50:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH 2/6] doc/arch/mips.rst: Update toolchain list
Date: Mon, 26 Aug 2024 10:49:53 -0600
Message-Id: <20240826164957.2789525-3-trini@konsulko.com>
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

Remove both the ELDK and emdebian links as they are broken, and add a
link to the kernel.org toolchains which we use in CI.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I didn't change the buildroot link as it's still valid.

Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
---
 doc/arch/mips.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/arch/mips.rst b/doc/arch/mips.rst
index b8166087ddfe..aeb58247943a 100644
--- a/doc/arch/mips.rst
+++ b/doc/arch/mips.rst
@@ -8,9 +8,8 @@ Notes for the MIPS architecture port of U-Boot
 Toolchains
 ----------
 
-  * `ELDK < DULG < DENX <http://www.denx.de/wiki/DULG/ELDK>`_
-  * `Embedded Debian -- Cross-development toolchains <http://www.emdebian.org/crosstools.html>`_
   * `Buildroot <http://buildroot.uclibc.org/>`_
+  * `kernel.org cross-development toolchains <https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/>`_
 
 Known Issues
 ------------
-- 
2.34.1

