Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7E4C88CB2
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 170B8869AC;
	Mon,  4 Sep 2023 16:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AtjgwjCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D00869A4; Mon,  4 Sep 2023 16:41:45 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCFB86961
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34df399c316so5760905ab.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838501; x=1694443301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wa8zTccRvHCzKytOqq/6zuYeGX/X+GHliY8eBPBMEeM=;
 b=AtjgwjCouVosYfhHGt3Gm3f/s83POr+0w06vEXvXIcqJ7Tes/yL7jZDpH7xDyGh9St
 3NOYx5qdIH76w8Pk6iRGsjaO9P0Ot8CqDO10E0SBId1SShqZ6ibxyVdFdW578Y/1qkbr
 0fREqo3iFreju6QUFHCqNuuPbAf9OHxuIicQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838501; x=1694443301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wa8zTccRvHCzKytOqq/6zuYeGX/X+GHliY8eBPBMEeM=;
 b=RVrcWqRy3Df8SvC96w2KjGtKXneLDyTNXr/R3N22wfk/bdiEvTC2h4u1ESwrqhygB5
 qTQ5cQR4PTfxGD2osHcCi9RYQ7iRG4DmXjU6zTR2qbqC2QSg/mm4NBPD0wOSDZQKxVUH
 5n5hi1YZ7KsvqqtnDjryPeXhRifQAhh3ETtIo/241YvyKKoql8l26eqFZ7dAmv78rTrJ
 LtDiHmv1oWXdWUfZM0zcz/tuc54b5QZXMBUpcqXG+KRU8GBolkgMsPgf3upGKxXLLdWV
 DNpLEAFusxNn1WR9sPSYMc19AU/S8USbVF93vzimSQLGoT+xl2ZNrJlzfKq2u7PV4C3i
 pyvg==
X-Gm-Message-State: AOJu0YyM5vsNC6rPO6EM057a/P2faRRVn32m5jqkn/LhP7bFTGLO5tn3
 /DHBa67mjRl/mkOna8HEIA0jFzsBKdenC8b67pA=
X-Google-Smtp-Source: AGHT+IEimOlcbeKiCcqR+KSCoQEuJk0qJo+wJsAY03XgbwFX6VatWT6rBuv1OzDVenSbkI6j6X7g2Q==
X-Received: by 2002:a05:6e02:ecd:b0:34d:ee0d:162b with SMTP id
 i13-20020a056e020ecd00b0034dee0d162bmr10249058ilk.17.1693838500930; 
 Mon, 04 Sep 2023 07:41:40 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/20] lib: rational: Move the Kconfigs into the correct
 place
Date: Mon,  4 Sep 2023 08:41:04 -0600
Message-ID: <20230904144131.2699824-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

These should not be part of the 'system tables' menu. Move them outside
on their own.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 7d0f3fbb93c ("lib: rational: copy the rational fraction lib...")
---

(no changes since v1)

 lib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 42e559ad0b51..9addcfab3734 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -989,6 +989,8 @@ config GENERATE_SMBIOS_TABLE
 	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
 	  the devicetree.
 
+endmenu
+
 config LIB_RATIONAL
 	bool "enable continued fraction calculation routines"
 
@@ -996,8 +998,6 @@ config SPL_LIB_RATIONAL
 	bool "enable continued fraction calculation routines for SPL"
 	depends on SPL
 
-endmenu
-
 config ASN1_COMPILER
 	bool
 	help
-- 
2.42.0.283.g2d96d420d3-goog

