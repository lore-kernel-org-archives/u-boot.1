Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CC6C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0064E820E1;
	Thu,  1 May 2025 03:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mjhd4Nuj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE1D81E72; Thu,  1 May 2025 03:05:39 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F7CE820EB
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d96d16b369so4006775ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061535; x=1746666335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsAE3IMnsJHZIQkBRUmjJ6f+rdNJVe7N/xHGa6J2UUw=;
 b=Mjhd4NujvLnSwiJ0IBccj50dlq02DLqEpuSWYFQQFAR/RHeSa+/ITTG5wcSzawPLzp
 hX9TZpSd8EwH+QEYCpM3QyqmhoZPU7fkqbYEIN/1ackJyIKjLpangV1V8HgHfpvgBPao
 wU3pWI3WkZpFRK++/N/ctFH9FD5Z5VQEVjsSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061535; x=1746666335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsAE3IMnsJHZIQkBRUmjJ6f+rdNJVe7N/xHGa6J2UUw=;
 b=k7UG+PbUVrYaAHG8t2GH8tmLSAkvNc5ztYXe3jrAgzELz2V0E4CJJhS3OYL4F1+eHI
 8BcAWiNZMocBfdSgJ5v4gob8P5JSczigv7fBHMG3iApT3RZS4545jyAxmpTWhEFroo1g
 ggH5XudUzfOeM5QZnshU6JdPN1liB6Vh90lhkxROeZrzhtnCdhnhWefxNLi9q2cacW7C
 +166kYFbmLjU6meZX9i4GBZV+G/dUHGL+LHI9LIE/bbT0TewfV6Nofg2w2bOdxfY3iVz
 D3TMQ9r0Eumpf7TAE+iThT+0XFsIYaYKpciF30OuxT/LmvvKxdEyVnYNGrSzgNYQJ6rV
 OfTw==
X-Gm-Message-State: AOJu0YwtLfjO/QvdmvQfMzI9ePg/a8lIJt0Ol3uurVUKYZCQjZCTVXk5
 J7j/Uz5TeM4LYkMnj3VHByTfF+TJwE7jrNHV2+0ZclzcDwpNMDlwdcZVffQlTHNRgBSp5BZ/Bac
 =
X-Gm-Gg: ASbGncs69jcGs3dOdfSyknuU18YSihl8AaKYZd+3A2j7AZ0GjtMnb9uLWBW6Nc7IfIE
 m4V0aqkxWrFYDHWtKuIbIByxVRJYmKkke1HbCl+HhN6MHIHvUGKDJCAtNI1xSGbUzHFUU037DuE
 EnmXZ5rtuy6A9gdSBIr5s9jc0iVTMJ3BZoUrUXKC9CiqriXpeHPwLTCDOOJLw8UQhv9BaordWlI
 1IM5+ikXgYz4EGuST9Y61vx6lC1cskfUWTIu0CmOzaz+ND6CWfBuP9TvtWRJW135o0Lo8tvbVG+
 Z6kDAHJxXDrY2DvWpttIidGw439Q5XhZp/5/Fu9aAO1Bt+mDNHDPfZF6WgTT8kM9fkcjKWdEEgy
 XuQ==
X-Google-Smtp-Source: AGHT+IHQWBDpE3l00SmxYczOpfY/w0Y0cnmUBls1KcBvs5YQxu+xMJBLAP+KDYdXdynSWNjo+xbR/Q==
X-Received: by 2002:a92:c244:0:b0:3d9:43fe:8e49 with SMTP id
 e9e14a558f8ab-3d9676c6226mr62229335ab.8.1746061535247; 
 Wed, 30 Apr 2025 18:05:35 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Ilko Iliev <iliev@ronetix.at>
Subject: [PATCH v2 07/22] ronetix: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:32 -0600
Message-ID: <20250501010456.3930701-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/ronetix/imx8mq-cm/imx8mq_cm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ronetix/imx8mq-cm/imx8mq_cm.c b/board/ronetix/imx8mq-cm/imx8mq_cm.c
index fbee2c39771..602216854ba 100644
--- a/board/ronetix/imx8mq-cm/imx8mq_cm.c
+++ b/board/ronetix/imx8mq-cm/imx8mq_cm.c
@@ -3,6 +3,7 @@
  * Copyright 2018 NXP
  */
 
+#include <env.h>
 #include <miiphy.h>
 #include <asm-generic/gpio.h>
 #include <asm/arch/imx8mq_pins.h>
-- 
2.43.0

