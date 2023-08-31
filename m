Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5499C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00A808656C;
	Thu, 31 Aug 2023 05:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jx03fnV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD17A8656A; Thu, 31 Aug 2023 05:53:27 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA0C86567
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7926a450a0aso16184539f.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454003; x=1694058803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5+lRk132CVV5AqTZQVxxhSrcTTK3B99jkdIIT7VEwI=;
 b=Jx03fnV+vzZRoajm9js1oGY3ZSAiwGBSvQuivKNomg2ARBHzq/5dElBMxJ26tdQ7jP
 4Z78P6AU5p6wxC5S3g+HKMFzjQ25nqX/CyzjLXz1AfNRFdl0De8BpU4lf0tmOSS5/tsa
 257IKjwnD0BPmPeCwRdpE2Sh7H2V40+rRaaZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454003; x=1694058803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5+lRk132CVV5AqTZQVxxhSrcTTK3B99jkdIIT7VEwI=;
 b=mAl0hf/FvS5sHKnnV7S0JcjLL5Pw62vr0OVQnt40KMDNSJMXvw9s+a5M/1zJ48BzMQ
 iqh5kJbLLq8anr+ynakncySbT7zIbBTi5nDnsaIW9QxW0y/ZCeEkKU0LD94zLZ4yslPt
 t7/wYX17yWlVrqCq1Wx6RrGRfCZumqu6gx0SOsqNseTv81XIL3AEcI++V0Av/4msRSBq
 9jDGYWicj1A4GRTDc09gZwIY+iMDEAZNeZwK3FW7cSEl6lQ97bFgbGsTte4jvKgHO4lk
 RD0FgiWDOvt8TPLAYys4fde1FvucmeOMox30A0EF8xYfBE6VdPSwciAUia1POfRxS8Kv
 ntiA==
X-Gm-Message-State: AOJu0YxSVC7aADB+jno7kAT8KUDyc1Yw6ib8WxwC0pxD7cEh0c5qHZA0
 CcGK0YSkj5KFY1QAJsBivFsl4v5WusLeBBixUTM=
X-Google-Smtp-Source: AGHT+IEEVQAAUT2PiZVoM9fB8rulj9HTHbsgCLIDrT9fsCQC7wkALI+ueTb+wJD/T1om4cY5fzTjkw==
X-Received: by 2002:a6b:6d11:0:b0:794:c9a2:5fe3 with SMTP id
 a17-20020a6b6d11000000b00794c9a25fe3mr4757310iod.4.1693454003225; 
 Wed, 30 Aug 2023 20:53:23 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/19] lib: rational: Move the Kconfigs into the correct
 place
Date: Wed, 30 Aug 2023 21:52:55 -0600
Message-ID: <20230831035319.2316665-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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
2.42.0.rc2.253.gd59a3bf2b4-goog

