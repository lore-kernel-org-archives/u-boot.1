Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2333BCDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5987D86F4F;
	Wed, 18 Oct 2023 14:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NjLpc6QV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD23B86F86; Wed, 18 Oct 2023 14:33:54 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E9F80EEB
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59b5484fbe6so82850257b3.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697632430; x=1698237230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0KTgc5M84oQLDAeSlvT958GH339+jLVr1rzNpuAlYY=;
 b=NjLpc6QVckVF1cVTj3xTBcgHhc1jL638K7AiJ9QTDJ8KRyJuyg85Sy2DzR4J9wVLTp
 YX+QU1WCnA/4SIWqFl7fb7n/pl5w9OKvleb1/7g53Em1B3zscjehbCgtYu2aWdq3rbOq
 DaSeFPz1LXtIxLvJhubuWGXGBkq2lxLAcudik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697632430; x=1698237230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0KTgc5M84oQLDAeSlvT958GH339+jLVr1rzNpuAlYY=;
 b=kzxzrXGl/Nq3dt8nFdpFWMSX7r/o23p0R4wEKDrj0hhCXHjoFWEon/uFDHDuFjuP0X
 BptMZq5KBxOOwtGqZjOCaA4M6lVcsEgeaQF865+3pgZvos8pk/I4BIHCFR7V6NzorJSR
 KJrebHBJbDMcPL81PFmMczpiA2zImzjHBGBuDv51RqrC8HHt3bd1tC41ZnmeM0L2g6QP
 Cjs/OCMMiPdkYgt/yyU3nSqG00zxN2rzT3hJqgiE8dpIPxtzVXB5SiR7ZSoFQh22IZq7
 w/Omwc05n5WMnzX2UqVPbPO5W6ORdh5sjbjMYZqgQQY19QDl4Kmo5CwZd9zCqDrbwCY4
 3cLg==
X-Gm-Message-State: AOJu0Yy2g1ioRTKGZ+ieNM5h7ABWYjcMD2qZPSuAcl6hJLSDfi0NocHa
 wXiojzSR/UPgKrPe00r6P1f0tNSmGfPStXAAdOn5fg==
X-Google-Smtp-Source: AGHT+IEolEG4DW6F2mQfHUfU2aiRAPQUk00Ms97bYJMM9/scuH6wUbzfEkUOIvlOY+kF0N2Pt885rw==
X-Received: by 2002:a05:6902:100c:b0:d9a:c4cf:a066 with SMTP id
 w12-20020a056902100c00b00d9ac4cfa066mr5854921ybt.34.1697632429819; 
 Wed, 18 Oct 2023 05:33:49 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 d132-20020a25e68a000000b00d7b957d8ed9sm1269080ybh.17.2023.10.18.05.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:33:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] sphinx: Bump urllib3 version
Date: Wed, 18 Oct 2023 08:33:48 -0400
Message-Id: <20231018123348.3676562-1-trini@konsulko.com>
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

While unlikely to be a direct issue for us, urllib3 before 2.0.7 is
vulnerable to CVE-2023-45803, so bump our version up.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 6d45a3fefffe..39ececb96c2b 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -23,4 +23,4 @@ sphinxcontrib-htmlhelp==2.0.0
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==1.0.3
 sphinxcontrib-serializinghtml==1.1.5
-urllib3==2.0.6
+urllib3==2.0.7
-- 
2.34.1

