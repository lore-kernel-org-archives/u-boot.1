Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F95C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABA4583AB9;
	Wed,  6 Aug 2025 16:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GY0lfJXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84C48431A; Wed,  6 Aug 2025 16:56:58 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F657842FC
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-61999e5fbb1so2307905eaf.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492215; x=1755097015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PhMBWlCL2dnBI3hWO1OgeP7YIyI1vbt9AdpeevCZNII=;
 b=GY0lfJXi6Qlx01Udpm3rJLtX3wk8u61vtqOUFrSrcExMCxiW4nbg1vHB1drmwRq+oW
 dchgVKMBoTUtHKE9+fbGk4Z4flMtHAAnA1Lu8cQxdIyToyKPIu8PeAn6BL5XhHHbcy+f
 /4C2dkKxEbwAejNlGSRG+0KZvu9s05KzvQn3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492215; x=1755097015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhMBWlCL2dnBI3hWO1OgeP7YIyI1vbt9AdpeevCZNII=;
 b=ChUZosJ0VBNZqtB4zz6LIt9bhMY43P0V5B+Gluo6VDIYbhovu/+HaQzJmwzro9QfVz
 zZ4Pd502AMzf94MGlflqMhvKnv7YOBcD/PSGFHLEeX1xULgBDt3cRbcH6MUxmxzxE1RY
 pRBMZTsYsE7WOnrLPffCOrYr2Cc0pzr3/nOAVK74b0Z6Prey3qoEYz7d7/OfP1CpBpUf
 CFiyyMSvOSygEmweegxMMH8ATej+sDbFvmMQr8ot1kb2xggzM9QUrW1AE8peTTEsh0oQ
 fmVOZ+o8Un4Ld44HNmhVCFmzSw2L8KWQ5x9I02TLLMEUP8ujU02IyJwBqrNjsdSZKanH
 nLGg==
X-Gm-Message-State: AOJu0Yyb9ZyBRt/Ecmq+wwHUSOOGE0DGhpbSvae8jiCrUV+nqGv4Y2hc
 eX7/qUDyvRGgmoRIpv1ykSg+JTebjQhaxhZiPOP2edNFRlAm9qp1suzzzy12ji0Mwr9MZxQwxxH
 PO6vHnb0=
X-Gm-Gg: ASbGnctebSei87qTN7KV+HnOqe4JeKbRsAP9+u1/OITJiZqtXSoedlE36t9n44YqlWO
 oAFAoCloFovmxjgU4NnmLWN55BsoDmrr4YS3OjXINdMZ8+m+wO7CW/bHxLKVSynngeO90sbrpMD
 B36YjZXJPUCziBmTmwfFlrR8eBr43IpMxtptsTyJBhbEjbV/emDP3Sdp9eJHn+GFh0qpayyWp49
 k9t9zFIrRYrmvEihEScNkwk/tA43r8UOQ1/nRbfQNQdq7wW0M8tGf9R50pwlbJmPU5sMyAEQJbf
 pIWxqm5B8xjy9Qiw6AmEUttg9FNoVsnt3/U+ABThQn+7yV9WGmQuE1gOBCFbWLFJwEhEtN/nvH0
 sq8dK3A1DDsBrVINuXni/ZlySjNukPknb91xFJabzioM4+hf40ynABVEVTQs=
X-Google-Smtp-Source: AGHT+IFy1M93qCZWcE1njNy+D+4+ZFgLrzMVSA7EcAptQ4v5SUcFlgTyujuh1VigyP7drhYtjp1R7g==
X-Received: by 2002:a05:6820:290a:b0:618:f1b8:a5a3 with SMTP id
 006d021491bc7-61b5f3d11fbmr2318189eaf.7.1754492215134; 
 Wed, 06 Aug 2025 07:56:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6199c99b222sm1644790eaf.28.2025.08.06.07.56.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 6/8] video: ihs_video_out: Add missing <asm/io.h> to
 ihs_video_out.c
Date: Wed,  6 Aug 2025 08:56:47 -0600
Message-ID: <20250806145649.1664724-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145649.1664724-1-trini@konsulko.com>
References: <20250806145649.1664724-1-trini@konsulko.com>
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

This driver references IO macros while relying on an indirection
inclusion of <asm/io.h>. Add the missing include directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/ihs_video_out.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/ihs_video_out.c b/drivers/video/ihs_video_out.c
index bf4d4995c36c..e2130274b491 100644
--- a/drivers/video/ihs_video_out.c
+++ b/drivers/video/ihs_video_out.c
@@ -15,6 +15,7 @@
 #include <regmap.h>
 #include <video_osd.h>
 #include <asm/gpio.h>
+#include <asm/io.h>
 
 static const uint MAX_X_CHARS = 53;
 static const uint MAX_Y_CHARS = 26;
-- 
2.43.0

