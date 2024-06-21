Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417D3C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1401F8859B;
	Fri, 21 Jun 2024 22:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TZDMcxB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660CE8804F; Fri, 21 Jun 2024 22:46:47 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F89C8855E
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7eec09cc7f6so95407239f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002803; x=1719607603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA+FlwdkRSMhQxY2MZH+AxkvYhCzQLUcdRiqc88p2+4=;
 b=TZDMcxB7fVliRhB1pGEex+efnh8ClP+bjF4exzXKUGMXbgb5yx9/Mnh47m0BDBTSwJ
 HFVF3bO5SHaP7Ln5nfxk5UbhSYOV4PJbNqEuLQ2yEy3SzlNH/czQbSMoNzRrWz5QtKZz
 c/5qc/2TGaCzkox/4fXMWtA0z4jpFzHC1jxYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002803; x=1719607603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA+FlwdkRSMhQxY2MZH+AxkvYhCzQLUcdRiqc88p2+4=;
 b=OpRZGOltNDetdjbWNCgbPM4Y9BO2UVNqEAgC+rNOkzkpOgIY1h65is9lgYOENgTskW
 aah0KzX+ed+RuOR2Dp2fsN89ytswxUr32cVKI/Yh+cLjIZb3U4+FayLzc5z1iGEaMo5E
 LN3RCXAF1ejDW7+VJ0iySZBu8i64aMzHUfEg522Mo3kuXwaR/0n0cn+nFaA+UIxenjln
 kcDSLXfht6K3mNQ/Q1ufYfgQa0xLK6/nhaJNMV4OcdozM8BXRoYa+iiDLn/IUHGtESgX
 7s22HL2cGcq/slbziCODNpQI1gdLc0DwznIeHh/xO5yDwqgN6+x2VtSm4peCVVpGSmPs
 vLbg==
X-Gm-Message-State: AOJu0YwN9V/lYRiWDfQDjDRNLiipyilBi1nVWXIAMWXRQ253VWiTPDKq
 sQVhKzhg60OeSJKjsj6H1wltmQ5/EKZ8fHMNHEqUBjyS5Fz6sJOmQ1kjVMYkJlQO7Rk5NzLGgXp
 5EQ==
X-Google-Smtp-Source: AGHT+IG9qBDK2b6k7SyNWheSvHlZUsRahUzgxzhjYMsPUXIoo2lhMTG174a6xxOaMXEt6GoSmHy98Q==
X-Received: by 2002:a05:6602:6c0b:b0:7eb:846f:4280 with SMTP id
 ca18e2360f4ac-7f13ee87afbmr1009751239f.16.1719002802680; 
 Fri, 21 Jun 2024 13:46:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 04/11] binman: Update the entrydocs header
Date: Fri, 21 Jun 2024 14:46:25 -0600
Message-Id: <20240621204632.2706813-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621204632.2706813-1-sjg@chromium.org>
References: <20240621204632.2706813-1-sjg@chromium.org>
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

