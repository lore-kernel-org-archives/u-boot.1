Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ED0C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7EC829C3;
	Fri,  2 May 2025 16:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gtXz2OZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCB982A5E; Fri,  2 May 2025 16:48:04 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24AA182153
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8647a81e683so71418239f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197280; x=1746802080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wh1+F1P+LrUymMlTFjKclNvwQSpVMvxAzfRJyKMymKk=;
 b=gtXz2OZb5ViwpUebn+ihV50fZflbO8OabMaON/efIQWUNQs5FdD62r3x3lLLscVe6Y
 Uy+rEhpYP9wnf6JBZn1L29oEqLGbnMvZ/YvZyCFECltGOzDthmILmQ1vsB1IeOlfGyFC
 Z00Ivcof++kyzGl+SR0VlEFUEEoSiIUYAjrCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197280; x=1746802080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wh1+F1P+LrUymMlTFjKclNvwQSpVMvxAzfRJyKMymKk=;
 b=PviJm5jNfpbkC5K4w8Ya9enOzLUOB1JQWKWKhHFlwG4FrmbiJ5LrIAmfTKUxxJ8idA
 +5aIZOXaEgkQD5MOc/vSuDEeVDD/4obxsfwW3KAFCk+K88VjmmkB61vaXeL/lnuJwfiI
 excahnvChnsv06udx/g2+CREtrbr2PT9uGmUt1jp98W5PVH4Guvh3GR2d7Jz6+ev5D8L
 Q60TWmC1Fb5C987Z+MRcunmtuEio6Gr65EPdYOOvsGjWOttYnEu91PoWSFCnza8b0ZRN
 8TKeWI1w0KjCj22jWo/wAkFyFwXH0CMuiT58kf9Vd12Fyun6DLJbGv6MdaRgC1lAkKpq
 8zjg==
X-Gm-Message-State: AOJu0YwhMB7CErq87o4XJ/Pyfdmgc+UeLLIJZUWZwqfo8q9qqWFZTrMD
 d9IB3kjxtX0b5JjVm+JYhJ435JB7OgFTUsG9JVVoKvWA3P9GIbM++bXer3QnoVRHV5X/WL8XYhM
 =
X-Gm-Gg: ASbGncuDQ78jOL8yaw9SQLL9EdEAmBFt3h4tRSTFrfj/YW51TixOEMMndz4qNftxV69
 g4EyS7+C1UcobC5acZUniJhl4SM4nW9z2Q0L3cW5tIfCIJf0/5AsuC+5+RgLnt2809MxQHeZ8Bg
 FgtyG64bhKex6LAB6ASOU77FIYSqwKR3LjgdRUx97faHe3A0YUgH54+EQeE3KtuOE/BhVgX+Mf9
 VTJmugVUVmSeGXsam20THSMUHSbA4R8F/12UDf8u1HqbrvH9XRbEbPYDMbMPpDfNpp3uwRiu9Q3
 uvL2XJAkuErlDX+GyCAO8mh46ACyKycJrmqxU988tovaP6yUZ4Hnoyxzqx27D+AXeqnQhHhoGyx
 0Vg==
X-Google-Smtp-Source: AGHT+IEc/ue2xn/YcbF9BFGyu6cI60vtFqawhYVWXvARB8g0FbfwBvjGP1wbNVuqP8wVzoqEDfxbHQ==
X-Received: by 2002:a05:6602:418c:b0:861:7237:9021 with SMTP id
 ca18e2360f4ac-8669fb07b0amr379092339f.3.1746197280228; 
 Fri, 02 May 2025 07:48:00 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/60] expo: Destroy the cedit expo when done
Date: Fri,  2 May 2025 08:46:17 -0600
Message-ID: <20250502144718.313633-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

Once 'cedit run' is completed, destroy the expo so that a fresh one is
used for any future editing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/cedit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/cedit.c b/cmd/cedit.c
index b0eca7b4daf..2e15b063462 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -285,6 +285,8 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 		log_err("Failed (err=%dE)\n", ret);
 		return CMD_RET_FAILURE;
 	}
+	expo_destroy(cur_exp);
+	cur_exp = NULL;
 
 	return 0;
 }
-- 
2.43.0

