Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAADE71D4F
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 16:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B7D86BDB;
	Thu,  5 Oct 2023 18:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fZ/u0Mhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA3486BDD; Thu,  5 Oct 2023 18:27:44 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EB086BD6
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 18:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59f7f2b1036so13836757b3.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696523260; x=1697128060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=szgNXrX5jWF5ONmXQb2jfTHXvf0BboxuUeH4gn48ctA=;
 b=fZ/u0Mhu2Tux6DiIfUnvV5D4xLxmdBE42+bX/kS/LQWJHjEKXHcbMjmBp1yvyXhLyg
 /Czd+TPfGH8JtktThngmw2+5rD2CqGUhEivTt8YUahYq0EryxDzO89LlKQYFodYnOpLR
 5T9EaSy0SE4RQzJY7rwhqtAaTBzlbfjVtLNMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696523260; x=1697128060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=szgNXrX5jWF5ONmXQb2jfTHXvf0BboxuUeH4gn48ctA=;
 b=UcKZ5qU4IKXdQ9j7/+9OjHeV4PXDybJkQ7/KmujBOHi42S3z/EaaIS0dxwi/2hic/k
 XjUbDpbYNpmjcfCL+8pJX6CkqvGpVkiDw/j6SsgbioOyTgKXDxpVTkmO64O7aI89GKh+
 HqI2H7BBHuqFPqjET+YH+xdy/9BxA5oRehknpOQvqfBx5WHyLfgmeUsWeGnucmZI5aHF
 JkU4szkCoxKEIIcKoY9QZNJKHGpt+auy3uuH9djIghl9/pKYLmXr0PL2GKclKhuzEzcF
 s4NtmkgFlhIdWSmjsmHab/HCbgaRfn5M2cy/97wiSW8jTJ3AjMxsTve4T9Iub/BsslfZ
 D7vw==
X-Gm-Message-State: AOJu0Yxt0WZbvbzFca9x1peO/zfn3mt8nZG87xgezgdQQ/bVbE2ITbg8
 BwIATr/mKCWOdkswph+8N+ezKhyf1BMHvryxzb/ZOA==
X-Google-Smtp-Source: AGHT+IELEs29+IgQFdzdwsB0dN9bILSUgvBqNRXDUIoJ51p4pTq1+asXVfGsXUfBnKopC7oPZnBwnQ==
X-Received: by 2002:a81:b402:0:b0:59b:eab8:7ac6 with SMTP id
 h2-20020a81b402000000b0059beab87ac6mr5381928ywi.42.1696523260360; 
 Thu, 05 Oct 2023 09:27:40 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 m131-20020a817189000000b005950e1bbf11sm609289ywc.60.2023.10.05.09.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 09:27:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] sphinx: Bump urllib3 version
Date: Thu,  5 Oct 2023 12:27:38 -0400
Message-Id: <20231005162738.3327197-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

While not a direct issue for us, urllib3 before 1.26.17 is vulnerable to
CVE-2023-43804 to bump our version up.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 6ccbe527ee79..23a296d3fca9 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -23,4 +23,4 @@ sphinxcontrib-htmlhelp==2.0.0
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==1.0.3
 sphinxcontrib-serializinghtml==1.1.5
-urllib3==1.26.9
+urllib3==1.26.17
-- 
2.34.1

