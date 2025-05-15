Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6DCC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7005682B5B;
	Fri, 16 May 2025 01:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pnADmHRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A698982B37; Fri, 16 May 2025 01:42:22 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B2F82B6B
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c13802133so715465a34.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352539; x=1747957339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sixb50Ai7m0KVK0xM1dccBP7VV0nC8NrK85Eco8DP+A=;
 b=pnADmHRB21hDTfZ9oVqC8c+x6amH3bfsiGny3fCtYHb2E2mdVR8W4rkmKtXCl/HqSJ
 AvBesYxZjlPBsEhaQCHTLvJ8EEBsJE4QsvOsNdD37Bwoikl8KJyrbeAHcktg/OYsz0PD
 blu6IeDViyk4UBu6BW+0Pt2R3ONhUW8ea1S+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352539; x=1747957339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sixb50Ai7m0KVK0xM1dccBP7VV0nC8NrK85Eco8DP+A=;
 b=kHxXvBYX8nszV3G53aVio9KkoM6Ncxurc3WI4IwZew+YGzCkEWcrUB+zroPuK+FO7w
 iEGmGzFPVBPaVNSiwSGAev2EYaGRTj00dXc0WGTUSotMSLvqwnx+EsRw2b7Rxf6EkuDz
 0VjfKTgTPvrgdiKbEMQQYcp4uVq6fmvutUH949R7+Fyh3MeavNg+5BA93WjotVYiNaOD
 NVrwfgw5DEHF+ueLA/CKI6Nd7gyF/dIOdzMQfYr6ZhgNaHGGYS077YDPLnByKHTVzTZJ
 UoUIxavcXL1wOmyH6woYcB/gmYbjGbI+gML0Ct7PL0CZ8f8zrDUE1LNjS/zMrhTBTNGZ
 nt8Q==
X-Gm-Message-State: AOJu0YwcZBaUyesonGmFvRF9NRS9BvAud2DiXP32/du8VURJNi0fuLDF
 K8E6Yq7HAaHJlOuweqdiWxjtR15gxCl4BeuStFYqw5umaGxozQ16OIT1gWQwsvm9x+4FmUsRvXe
 bFPx9I2o=
X-Gm-Gg: ASbGncuk7GJ2EoGUkoxaRpsleREHreF8KGPa1DTnVGAaHI/2CtL76F4Bzyf0T4Z0R23
 yk/J7JNiG8ruARIz5Bc3e/qF3I5P42S1P5jVqQpLJdMR4zIx9pWeDiIohndlZ1/BkDCy5W9cgEq
 6U5MgA6v7yQL+Yq1LdsFfm/Qx0Ov3stpOTx6oo2ivcXJt4NBaPcwpwfJzFzGeKoGwLz6KvKVk/h
 dB6dqQvYwyqwNQtMyGrvpt3dFVik5mIfFbbv/Ns7gPdUcwHMupbdAxLVsHo7GY1kKxE4dk69LZK
 v1WfRJTtNqLUdVSJ004katZdcHn85TjYB/jGR68Qm8uW8JVTT842ka4AgY+9WJsDcCtqh38jXSY
 jDQvCDgyaaGIBCQk=
X-Google-Smtp-Source: AGHT+IGvsqMYkhpDYLp86xdqyNLlPo9cLhLnwv8vh5ofI9S6SSg9gAcQ+Sw8gOx4txmop8Z0PyIAKA==
X-Received: by 2002:a05:6871:a083:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-2e3c8183d6dmr301666fac.7.1747352539385; 
 Thu, 15 May 2025 16:42:19 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 18/22] net: Include byteorder in net6.h
Date: Thu, 15 May 2025 17:31:47 -0600
Message-ID: <20250515234154.1859366-19-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file uses byteorder but does not include the header file. Update
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 include/net6.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net6.h b/include/net6.h
index 2ceeaba06399..39573e490a66 100644
--- a/include/net6.h
+++ b/include/net6.h
@@ -11,6 +11,7 @@
 #define __NET6_H__
 
 #include <net.h>
+#include <asm/byteorder.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 
-- 
2.43.0

