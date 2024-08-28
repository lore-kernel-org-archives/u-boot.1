Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE02C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69FE388BDC;
	Wed, 28 Aug 2024 03:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MzIcqs38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC3188B86; Wed, 28 Aug 2024 03:45:59 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D36888BCD
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-82784c8bca5so196303539f.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809556; x=1725414356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAetxCH5aDSa/hc6y9SHJF5yh5OGRXixtfudaaGG4Go=;
 b=MzIcqs38xv+q/2+mjLsBtHIWw2SyxqJhE+fAGD3UI7mT0fNLAbWvwcpKoX8MAMG4CT
 Nh6jvN8AE6zwsQnH+S2+J1cWQE8n/h6vP/g1HrIqiN9fZv6OUtvzFjrB8ze1V/ECD5pf
 ZGi2B+qZxsgZavpKO0zZ11Udo7apMFGD+PNDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809556; x=1725414356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAetxCH5aDSa/hc6y9SHJF5yh5OGRXixtfudaaGG4Go=;
 b=iyKPkvJ3+wtCofzCJm5gQjchAslJ/Zbxq9gISsvsc6zDX+t2qzJjkon2eUCZy12OKg
 L4zNlDoaWedWdz6XkWUo9JL6sNTC9kfy6KHC62tyN2Jce+u3t05uZqvN2adeeyMuAMpi
 IyLNbNg8YfL8QGsToTY8VVvHIsiDphOCY98iQsK8s0JF4kYYoK4nDoMWbx7wHaaZjoEJ
 9UxbyBdhenBAp74CGFEMt1WJgBcWZGj/TH2QG1PzoXJbctRFdQJU+qkA8WH0ohCIB41v
 EKk/XkdsQKF86DiyzVJQFpjhVQrj6qMlEFzAunD6EozQG2uReLYydsQLgHMn5r6nLAtY
 h8Eg==
X-Gm-Message-State: AOJu0Yw1Ek+H28l3x0AeU2w1Rnt8QW9h/U0yUkLEMv1G9sBikqsfriNk
 wyH7damBEtA+I+4iaW2+koWoq389NKbVSTW+A9/s1LGSXYdnHfXpO7HxWpl8Y7MYdTyR39nggic
 =
X-Google-Smtp-Source: AGHT+IEnU+AKjAmh4LbHel4dgAKPWQJun8xH56zjqVhuqVpx7i/eA9j1WQbcPGqk1/lzBl/J5WMtnw==
X-Received: by 2002:a05:6602:2dc6:b0:829:f6f3:f77c with SMTP id
 ca18e2360f4ac-829f6f3f8a0mr328446139f.8.1724809555973; 
 Tue, 27 Aug 2024 18:45:55 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/18] arm: cache: Drop a stale comment
Date: Tue, 27 Aug 2024 19:45:29 -0600
Message-Id: <20240828014538.3322013-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

This header includes more than just dummy functions, so drop this
comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index b2ae74a59f1..648edf308f6 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -4,8 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-/* for now: just dummy functions to satisfy the linker */
-
 #include <config.h>
 #include <cpu_func.h>
 #include <log.h>
-- 
2.34.1

