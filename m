Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45836C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1406B88580;
	Fri, 21 Jun 2024 21:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kDb/zHG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04CDA8853B; Fri, 21 Jun 2024 21:52:18 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B723388549
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7eb699def37so71546539f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999534; x=1719604334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61teAF4z9QYPqE2dHTGBd5n7k4ZlCtrd5ypMBq94joc=;
 b=kDb/zHG1gA1NHm1TqczoLSSQdd+Jls3tGjvqQ0jSELH1XsOUDRZCGnSI7TWTrWAa+C
 Uf5wmUyxeA6FKUIwoiYfzrUv+4FS34+DNUv9bPvonqinlleF0Q3NdD32agsZFHwhuJ+m
 1GuoLflAUu2eyAABohOnUDvOFyE5ADKeT2Ngg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999534; x=1719604334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61teAF4z9QYPqE2dHTGBd5n7k4ZlCtrd5ypMBq94joc=;
 b=UTPt/h06Gm6Ww+Twllp2L8GttTEjjODtzQnBgzd3AxmBKGIJgXehUv7V3WIOJsy/mA
 dJLVNk0mUmMgFOqe9asU4tci3WRtPbPAvdddUfVEIIUrfHETfBsHKKE0iM5pJO5Zc+bW
 Iea4+wZ4oe9S66EQX6I+cFIk+9K25bdpoYwhUHk1/D928ghYhBaI4XEpmJHLwTq1A26w
 mb/UdX9W6LYqM7hqR1epIOhgQ3yFN6+m0JDfOwxvJ/KgDtL8DCX306Q8+PdOTvGWIy60
 qWtf3EnZRsNzFc3URArcW17wIy7N9o+3aU5XXu03waFPwWB2/KB27KfZuPNmssVYT7Mn
 dl0g==
X-Gm-Message-State: AOJu0YybuyrKVQ8ypn1osvoGeK8whzd3FM756L1ZXrZO0Em3YsUuu8bx
 yIx5f7ftn6jd1dZ23XbPjiZBpIz6oDdDA0GcV/btbw9HxL4QoaYo7+8fGMof9HCf062cBfMIoj3
 5oQ==
X-Google-Smtp-Source: AGHT+IEKDRh/BrnyxehGR7Ssx5eDhwxgj0Exzz86u5vSSEnccjEbbxFMOIUgKy/zOt7Pgn4lWcTseQ==
X-Received: by 2002:a05:6602:6b84:b0:7eb:eeba:5e83 with SMTP id
 ca18e2360f4ac-7f39abd7a16mr43045039f.9.1718999534208; 
 Fri, 21 Jun 2024 12:52:14 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 05/43] binman: Update the entrydocs header
Date: Fri, 21 Jun 2024 13:51:26 -0600
Message-Id: <20240621195204.2675252-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

Reduce the length of the underline for this header, to match the
heading itself.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/entry.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 42e0b7b9145..2ed65800d22 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -812,7 +812,7 @@ class Entry(object):
                 as missing
         """
         print('''Binman Entry Documentation
-===========================
+==========================
 
 This file describes the entry types supported by binman. These entry types can
 be placed in an image one by one to build up a final firmware image. It is
-- 
2.34.1

