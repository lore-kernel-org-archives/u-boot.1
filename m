Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156EAC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 21:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39F7829A0;
	Mon, 12 May 2025 23:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U+eFMDkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD0C829A0; Mon, 12 May 2025 23:51:29 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E246080C83
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 23:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72b82c8230aso1388060a34.2
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747086685; x=1747691485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ou47wvYwNsVie8bKFb4ut6iCI+KAJ2KINcijjnlt/JA=;
 b=U+eFMDkzpNEKjNX6NrLIAo7o5AH8hCfx9kVjncEW49D7Z0YJ4ID3ABvNpSmMaoNjou
 IHT7fqsBlcuXBHOaBRtyupTHx2TtHe9ySaJm1McY0IfaHBR5tp+c7QVVzxzVQ25Lmere
 9mzXZgFX+hsW/FvdwuirlBhIR+e5O9U/+ozcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747086685; x=1747691485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ou47wvYwNsVie8bKFb4ut6iCI+KAJ2KINcijjnlt/JA=;
 b=EitzvJSZfKULIx5D/Jg0IcvUgVDw1iKKTUcMLelBjXQlGsXUlKuNLb8quCdRKI4+5M
 v3NsrXk81/A6leiMTBdd/cFfaMEVWmFrtTcU8Pib8tNeIoapDtlSjECi4Ge+ac11H3MP
 qB7yLXUy48B/adtLRUWVW6X8c5C0prkWhE/bfp4uuU+wwKtIHstiAJalfB8yL9h90ztf
 Gz/C9goDIBkYOTJZblRSXIM3OfwWMubF3J6J4jZn4Wr4diJsfS3Z4gRgjgAWHWRfN19s
 OXR7PahAMLO1pSpXO+k7tQQIx3Dr/e+enZUj6EvBAk18UzKLOwa3AQD2LSk1jwrvP9rF
 fkpA==
X-Gm-Message-State: AOJu0YzdpHjodCFAZo7heT/SlbgUmzOQT0YjeTtd3S5nmOjZzvI4cYRz
 PHI7mMJm0EuMdRVhuyM8h0FOMIt4Uz+iRdKQTrgqhiCN2m6KkrCVHGL0RaJvEsyBH2LezSLTEhU
 pTIw=
X-Gm-Gg: ASbGncvp46aSZONNz5PgZ/KqicqH2LBtYBW+++QxY+vuhLVafVP1A5C6Ebj66MPVy2G
 fjoNVk/SDLfydvZZA8XdHZv1VCWjQp49YsMvMR4PTzTQyCpgmIxDUQYaOaU+8rrfdqfnGWlIvs5
 NdGIgmeguAbbvjr/COZLw3yYY03IZOsIlCB3jMrg7CAuM8bc5SKRbas+kbltXWj9MNTJhQE2M2R
 Pie4irRa3NPsmqznTZCNbYrP4zcBebG2WdQeweB1AowVsWDhH0kmtkyHtiTpypgdimSZp6MLEl1
 VE0wvjlFni2OHjdb6Hjrtq+ydDz46uY1aWyevdkTnbBlTnGz+MGAwJC0Q1j2j+pZIIH//oME7Lx
 HF8aSDtszmZqn3NA=
X-Google-Smtp-Source: AGHT+IGUnBuMpauQxy1NC4OK85k7sS0rg/93tKZ4Ngdc4s9mylF/EP1WkrmXfPGreBJJpcISmoukeQ==
X-Received: by 2002:a05:6830:91a:b0:72b:992b:e41 with SMTP id
 46e09a7af769-73226b0b4d8mr8326529a34.23.1747086685621; 
 Mon, 12 May 2025 14:51:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264f4134sm1714838a34.41.2025.05.12.14.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 14:51:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] CI, docs: Install test/py/requirements.txt as well
Date: Mon, 12 May 2025 15:51:23 -0600
Message-ID: <20250512215123.2361227-1-trini@konsulko.com>
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

As noted by Quentin, in CI we should be at least versioning the pytest
that we install. To avoid problems later, go with the whole requirements
file being used. Furthermore, our documentation building for readthedocs
must also have pytest so install the requirements file there as well.

Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 .readthedocs.yml     | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 9c136513bb9e..15520c4dafd5 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -92,7 +92,7 @@ stages:
           set -e
           python3 -m venv /tmp/venvhtml
           . /tmp/venvhtml/bin/activate
-          pip install -r doc/sphinx/requirements.txt pytest
+          pip install -r doc/sphinx/requirements.txt -r test/py/requirements.txt
           make htmldocs KDOC_WERROR=1
           make infodocs
 
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7aadd5d8b735..49f3c588cfcf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -164,7 +164,7 @@ docs:
   script:
     - python3 -m venv /tmp/venvhtml
     - . /tmp/venvhtml/bin/activate
-    - pip install -r doc/sphinx/requirements.txt pytest
+    - pip install -r doc/sphinx/requirements.txt -r test/py/requirements.txt
     - make htmldocs KDOC_WERROR=1
     - make infodocs
 
diff --git a/.readthedocs.yml b/.readthedocs.yml
index 16418f286dce..9b6d251b7387 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -22,3 +22,4 @@ formats: []
 python:
   install:
     - requirements: doc/sphinx/requirements.txt
+    - requirements: test/py/requirements.txt
-- 
2.43.0

