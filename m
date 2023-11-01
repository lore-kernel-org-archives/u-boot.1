Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E740C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335FB87D14;
	Wed,  1 Nov 2023 17:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pzvePKvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC3987ADE; Wed,  1 Nov 2023 17:28:35 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1CD876CD
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d13ac2796so25146d6.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856108; x=1699460908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gxUfoFSeoQ92uLTyq8ztvHIQCm1ISrcOY3evzgnvS+I=;
 b=pzvePKvxk8fexf9ttQI+0semvP7CcGuSCmgVYUKZywBIKhz+uYvsS/dpirp/VyyJYX
 P+WXcbaqDXiyoGjF/9VY3CKtD/wuV9PBSsFhdFRclQbGC3o75CLVy8On1Hsa7Q7yPJjS
 OOdl5ZpFA4Te7HUzVFQMHtmppr1T0RUvsOUW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856108; x=1699460908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gxUfoFSeoQ92uLTyq8ztvHIQCm1ISrcOY3evzgnvS+I=;
 b=rF1Vxm7ngOVZbRrj8qhEtXL2j5LKOGnsmH3meSiey/EFxQgXaBsXgrAX7I/v780klt
 y4f8rGmRo9BNu17oHMKpDaBIdm4NqR8geceY6kSVsICR+Ty/qvXr1SllCpvw0Ki1W+Qw
 f8MBH1rOWsXUdPnJGtM5NJg+YdyEdMAKguo7DAjLKvppOISIEYZqPIh0mIlDDE13kHWR
 xQUMKDfCV0DfaYQepDqt08iq4V6Jytl5B3uD+hsqUC2U2m+ednZslH3JPt+VG91Jb2Gy
 U6J/3N8z5nCcqBY6kA0cWIijXNp0SiNn6t3PO03OQ3F76ya38DjTzabkd+ZXKB6et884
 l4+g==
X-Gm-Message-State: AOJu0YxNsQNl7IcQvTMKAc3IuMOIO1Box9B8qQ2HrkOdyf5FTnnPG3ak
 498Rmd9jlmFK28KLM+uWNazrT7FLQjsP633HFEhMkQ==
X-Google-Smtp-Source: AGHT+IHRos284q9L1cSZkRkdfMS3qjXprCuiTr0BbBzEwcVzawpJs8IaOxRLvcUgHWNI/jpOfc1atg==
X-Received: by 2002:a05:6214:20e6:b0:672:96a7:4614 with SMTP id
 6-20020a05621420e600b0067296a74614mr10757719qvk.17.1698856107964; 
 Wed, 01 Nov 2023 09:28:27 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 03/20] display_options.h: Correct includes
Date: Wed,  1 Nov 2023 12:28:07 -0400
Message-Id: <20231101162824.3755579-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

First, a header should never include itself so remove that. Second, this
header needs <linux/types.h> to be included as the function prototypes
use types that we get via that header.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/display_options.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/display_options.h b/include/display_options.h
index 85dacbc75902..66e596077370 100644
--- a/include/display_options.h
+++ b/include/display_options.h
@@ -9,6 +9,8 @@
 #ifndef __DISPLAY_OPTIONS_H
 #define __DISPLAY_OPTIONS_H
 
+#include <linux/types.h>
+
 /**
  * print_size() - Print a size with a suffix
  *
@@ -19,7 +21,6 @@
  * @size:	Size to print
  * @suffix	String to print after the size
  */
-#include <display_options.h>
 void print_size(uint64_t size, const char *suffix);
 
 /**
-- 
2.34.1

