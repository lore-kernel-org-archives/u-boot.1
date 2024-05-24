Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75391C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 13:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF91B884D5;
	Fri, 24 May 2024 15:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dG3xcYBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A1CF88542; Fri, 24 May 2024 15:28:27 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D34884CD
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 15:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4202ca70318so61890695e9.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716557304; x=1717162104;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R0iCQYi4daNCn30n0xh+kXcuBo3wyqG63DCvkayoFsg=;
 b=dG3xcYBWaM7DgqbHVRrcgoNZak44dzJH5y0zdKYPdAIbHQLa0BzDil9rr4oTRL/+AM
 eOAAd/I7A5sDQZcuxHqDfL9oaSlAisq9pMeBgJew+RMsB+Qur1jsIMSQ5A6ymnuQgqKg
 3Z+HdfBvqvAYfgiuoYGPgrw3W0yneZkXXPS8Z7xUfr729ZvFZxDuy9rdNn8oA7nfzFAD
 ir/07vL1516VdNeNkSnPZ1OFEhW71mWKllP3b93biKsRCnEfeFZKVR2pS3EbRnZMuTBh
 CbUyxTItmT37KWKk5R+G7rDvh+fjjIU/VE6Iqkmp8k7iA+GXNqfs7Mx7AfrVjrIz/AEK
 dVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716557304; x=1717162104;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0iCQYi4daNCn30n0xh+kXcuBo3wyqG63DCvkayoFsg=;
 b=bRILyfxkeQzD+U3I2nqd6PmksDcoKxn+oAx13ESJt/FABd1uJYz+0dUmLPor7NRZsy
 APAA82odkCpuZnoLg7Rx2SW4qTkzREDcH0u1muSnPEWtv/iNgt0Vw0/ybjCbJQcPGzND
 Ptr4YUHWl71jMULBOEfBUDNuW9b8s86J4XWGBNhAFzZ99TEtr+KJIPRqRkhSPngSWUJK
 zsB3dKkt8hVvNZnYeWSRTYaMqiAqrwTwvG9y+NrZyaKjnZKieSogg/ug2CwRvSwwTFOu
 H+fiwiQACUvKFEx0RGDjpAmwPfZ139agnqv0LuPrDMHbHLL6prFsNMQGaCUvynbLE+Qi
 7S5A==
X-Gm-Message-State: AOJu0YxcVTRhURNGI1IHzLXH411GEzcww5kswp8zRjCrs9lnBqvyqwLJ
 YJPvPuJ1fxt1zHl1CQgJ5O/Lp0/92XRW3orOXfjxdK4yRWK91ghi/5FTehDcXkM=
X-Google-Smtp-Source: AGHT+IEXPg6PWQxwEG+virqBkRnLPIZ6nA7Kk3JB/xpckYFhJgdNcWufJlKS4+UlzeHFiUULeBImtg==
X-Received: by 2002:a05:600c:2187:b0:41a:9fc2:a6b1 with SMTP id
 5b1f17b1804b1-421089d4473mr19590195e9.22.1716557304585; 
 Fri, 24 May 2024 06:28:24 -0700 (PDT)
Received: from mkorpershoek-xps13.local
 (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr. [86.206.229.59])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210897bc02sm20874915e9.22.2024.05.24.06.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 06:28:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 24 May 2024 15:28:21 +0200
Subject: [PATCH] doc: cmd: bootmeth: Fix extlinunx -> extlinux typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-bootflow-doc-typo-v1-1-d8e64a40e2b1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPSVUGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMT3aT8/JK0nPxy3ZT8ZN2SyoJ8XUtjY8s0C7PkNGMTAyWgvoKi1LT
 MCrCZ0bG1tQCVFjfqYwAAAA==
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-b6b73
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

Fix a trivial typo in the bootmeth documentation.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 doc/usage/cmd/bootmeth.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/bootmeth.rst b/doc/usage/cmd/bootmeth.rst
index 2903977ee54d..bac9fdf85cdc 100644
--- a/doc/usage/cmd/bootmeth.rst
+++ b/doc/usage/cmd/bootmeth.rst
@@ -48,7 +48,7 @@ The format looks like this:
 =====  ===  ==================  =================================
 Order  Seq  Name                Description
 =====  ===  ==================  =================================
-    0    0  extlinunx           Extlinux boot from a block device
+    0    0  extlinux            Extlinux boot from a block device
     1    1  efi                 EFI boot from an .efi file
     2    2  pxe                 PXE boot from a network device
     3    3  sandbox             Sandbox boot for testing

---
base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
change-id: 20240524-bootflow-doc-typo-9339f86cf340

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

