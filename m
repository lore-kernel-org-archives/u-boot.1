Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B22EC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567A583091;
	Wed,  2 Jul 2025 03:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+DeQEi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E8182F03; Wed,  2 Jul 2025 03:05:40 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D316E83086
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40b32b6af9eso2904872b6e.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418336; x=1752023136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ib/e9gzvsPtm/GTgPyTNF+iLDxQL3Nx9E+ZPoU0W2+4=;
 b=g+DeQEi453pRM51i8Sn443a8SA+Wy0sy4g1PX5KW2DS8A2ZlhMpj16ZUUhVOZHJE2F
 5xQBZujloozBtoBn+UHu5+EsFKTaz6MNKRtZ6ud9E0v1eTjeR0TZ8oM2MtcY8OUWJR/l
 Y27FSuCaHQ2zSU2FiDyNRZdtO+2wNQu5GzV3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418336; x=1752023136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ib/e9gzvsPtm/GTgPyTNF+iLDxQL3Nx9E+ZPoU0W2+4=;
 b=H9ozWjyQgVSzziTX1gG5zOEjkQFaBjpGIWtJ98FnXc8ZHVldU6rL2A9eWLXQFQCdL6
 SiYOqxIHe32FqfNmE77OQ+0ud/9pQgTVqZCdzIfDLlN+KFRRxHHst4b5O0AwBfhq43WR
 4HigZ34Uy0S9UzRFF6BnoP3b2sZ91BkcLXlIvfAtjdP0aVfEV2XoeKipbQEApW6jo5Hg
 /hR69glGLEN9eMLGqsH4JJSD/HuVLVpeWX/nC8lKwLzyGsmdScit5+/TY3BXe9uJcPYA
 xfswM5OULvBQUmWT3FEJqBKvfDFV30mH8zC1W+1lEKosoek+FBrG7cNL/JfDD52rzpdm
 PFWQ==
X-Gm-Message-State: AOJu0YwN0CEK8cBkNYK3KpwLdF1GKnuSXJWxehIAp+S7AcsDQhGtMAuw
 mNhMX2mUcSXkBFxwnD/Rc+lbC1LspvJFgpuyqrH4Cx4tz95jMnEQjfx6gQc6tTewsgvh7NPwARb
 7q0mn6bQ=
X-Gm-Gg: ASbGncsjBt2LTp9b6oVMQAGd+uLI023e4QWx9iXMZvZ2RyfxXd/2V9A0lblIu/QKS7B
 ndsb+GoQfaMpvvW5cRK5CAonhulIgN3insk3JhnPr/lh9YQ/ATPNTGRK2KP9Yvaynof8xmtTdm1
 AOxkRdzBwS3atOadnFPFYx1K89Uji1zPWNNY9J2Dalqo53XXAQvUDDmB2yFKJmRMAOX4FXeODCb
 foX6rYMqdsKK7e8oK/9Xy8bPzjkLp8f3PXzklR96rQHE9F8D702jYkntDoGQSEsGnxNAhYIiUm3
 u+7m68q8ncwkKSSpzL15SbrVOtMFGvkfBC4cmSgTAbaOE8aM0LHBtc99K73UfSekk776TvBC6KC
 4tNMUx7O2dYc52VxcaDbcs5oFAEqYX+DlvQ==
X-Google-Smtp-Source: AGHT+IHk+B6HUhntQwqMdwx5sEyP3EdOu16CVpVetWWZwyuvqPh0OGZ9V3u6rUNO+1OpK2MQF+yJNA==
X-Received: by 2002:a05:6808:2202:b0:406:67b7:8b62 with SMTP id
 5614622812f47-40b89116b2bmr583602b6e.38.1751418336542; 
 Tue, 01 Jul 2025 18:05:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b324054a2sm2377372b6e.31.2025.07.01.18.05.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/3] clk: Add missing <dm/device.h> to include/clk.h
Date: Tue,  1 Jul 2025 19:05:33 -0600
Message-ID: <20250702010535.19250-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In this header we make direct references to some dm/device.h functions
while not including the header directly. Add the missing include.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/clk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/clk.h b/include/clk.h
index f94135ff778a..90b42a618675 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -9,6 +9,7 @@
 #define _CLK_H_
 
 #include <dm/ofnode.h>
+#include <dm/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-- 
2.43.0

