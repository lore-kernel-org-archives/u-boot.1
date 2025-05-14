Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA43CC3ABDA
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 22:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CBAD82B0E;
	Thu, 15 May 2025 00:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VSpAREM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB3082AC1; Thu, 15 May 2025 00:50:19 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E20482AF6
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 00:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-605fda00c30so200956eaf.1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747263015; x=1747867815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lQdJEbhz8xyhQUtweyNy4gHyestb1Uj1Plr/+SYo/O8=;
 b=VSpAREM2sf4LajadnKnWYDCZt5bELZEEp6qc8ugGeoVnLVg6e9xa2jt/C8nwNy15qR
 bXNGeeyagc5vDqLD5Gt90CgXhufYHw764EvKaHrIuPrK8/Ok+L5RFuNm0T/AveGsJhPm
 m1HHMbyeHgGRbJRytoXeEMcrVzYEAsGE94v1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747263015; x=1747867815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQdJEbhz8xyhQUtweyNy4gHyestb1Uj1Plr/+SYo/O8=;
 b=eIEoVLz56u940hfe349lM1Ikvga9DOYDOtu9x8PDeoHKeyiuPy+Aw9jPw5GfKOAdGk
 AXX3zpLcFXNfdx0u3a7c/jQjH0AEU0WwVEuf7DRlSO+lHINEpAWoTEL0ZQlYOYz5klfA
 ZUpNxNc0S3cMP4AI5U09UhvJlyLKeninLlfLbvUnflTsE71gQuujuYWy+EtQHK4GVYek
 Du5WZbTH5idPBz70VTg1DQeubO0J5DcRQ924M8ZqgzkI+KioaSxBNGhBQqZvPHzkhRje
 7FNnU5TwGhzznrfFSReyMAO6vZacwE7Ki5KqhPZWv/Ypz3qrvGEMeVl51LaLP0Wy/86v
 HZ/w==
X-Gm-Message-State: AOJu0YyARbMOnw49SQQaBDTFbIP8YoIcIIQQF6hbTBmz4hA12vW8qFfv
 zCKL3w5nQwWzMJY1AnAMpJ2hfM90xUAF6iWlu3dej0Ocwiw2d1GczVSHUTCGwgNoCjMKnYsPh+O
 l
X-Gm-Gg: ASbGncu0Irca/qQzJExQ/lhFPO971kq7kWgnvUyEWGUCcrlOrZI57eiutv8jDG4lWMa
 Fl6BciBtsfSQ+GknEK3MtoBcfCMBBIajhJu19cakwc+gKYf3rXhCNLQE4ZLeJ/7Kcfbqv6Luc7f
 6UgVCSyRNRBBEkXMHR98CwqcUyUSQlm/+QiwtpYG8+f8deY3xstPnU1DdXPzmtOJmWb/qRljSdU
 vMBCozM1D0RHd+Ono/C4StC3pRw2oONcdxXoahC+vCooCnbNwjdXYPpmw4z20WwS8qYCVllQloJ
 UbQxRlk5wgUE+FBnzoGkhiheEW9KMflC2Q/DnNRw1XFp9Tms0rQ0dlYcKu1gEvPMVvBdclAXXNE
 EleYT4QZmFJvETok=
X-Google-Smtp-Source: AGHT+IE6dWDyCk4LwMvK8N6BPElPZTuRMcgA+r2rbanzjPDX7t+DUe552oNtMoF4d2rIzyvbDlYF+w==
X-Received: by 2002:a05:6820:2713:b0:606:5531:d903 with SMTP id
 006d021491bc7-609df1a353cmr2185088eaf.2.1747263014991; 
 Wed, 14 May 2025 15:50:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe52271sm2636530eaf.21.2025.05.14.15.50.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 15:50:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 5/5] include/command.h: Drop <env.h>
Date: Wed, 14 May 2025 16:46:04 -0600
Message-ID: <20250514225002.15361-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514225002.15361-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
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

Now that all of the cases of code that relied on <command.h> to provide
<env.h> (or one of the headers that it includes, and so forth) have been
fixed, we can drop the include from here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/command.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/command.h b/include/command.h
index 4158ca11b0ef..5d225cd197f7 100644
--- a/include/command.h
+++ b/include/command.h
@@ -10,7 +10,6 @@
 #ifndef __COMMAND_H
 #define __COMMAND_H
 
-#include <env.h>
 #include <linker_lists.h>
 
 #include <linux/compiler_attributes.h>
-- 
2.43.0

