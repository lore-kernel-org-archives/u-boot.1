Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09010C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC6C88A2F;
	Wed, 24 Jul 2024 17:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O0AYjRec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C589D88A06; Wed, 24 Jul 2024 17:10:10 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3DE988A31
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-389ccd2f0abso27272135ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833807; x=1722438607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZCaotnKwlv8rcCZcL+GNKCooIqPqTv/vWYI7wJ776Q=;
 b=O0AYjRecKaG/2t2L/xfiKZ+UcjewAhaoxsVwLKp/ho0T3XJ0JdNWn59AJQzq7Fshqp
 YF595ESgcSrFueRJ7LDY9E6h8QW9+UD97IKsAageTXcZq1PVxa3+CGVwvHpU0k5CT2bR
 RN/o6f9XeexwSep9ppQOpk2vpSH/qzJ9OBl3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833807; x=1722438607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZCaotnKwlv8rcCZcL+GNKCooIqPqTv/vWYI7wJ776Q=;
 b=p8/vxppsrVVcmVteIgKGnTu7hRFNxjsrAMJNq02Jqy4yGroOJ/P+qCD1J8bcOXHW8I
 soB+tf/+0OFD+trtA0e/LMXW3iqFuVDVdSoQTScipakiFHzy0X3pV6+Ue8xQOJRolCgG
 tAaE7JnAbSPLvtpeE1E/svo2kV4eptKjeSa8czp0BM4EPx9VLzgDw9vte+3HE1l7SOHA
 dpMsPHvXtWOqC5US3NA3hhGXHYnLjs5+EqC1CWiX0gOgIwkppEZhHFoEFOSVQK6PqSV+
 Aa1R77Xoy9sByBBi/XoJdqfCfjWsULsf4k+hnojLaz7SGutu+vnmRC/FSpWl37ZCsIud
 ot6A==
X-Gm-Message-State: AOJu0Yyo2yj/IF2Hrxq066kdAjWCXL3h0vva/F06Ojr1ui/WMPNVbzBy
 zoZUc5/zrQvE4shyR7IsxpidJkN3iFmulzT/PLUqBLVe3UQZFZhDS7+iyC4rlt+F0a9j9l0FnfQ
 =
X-Google-Smtp-Source: AGHT+IHz1V28706U1JuUxyou/qnacroyPtqQgR1Zl7S32MraVazpNqPridOG6d+E5opRP/+Cn7DLjQ==
X-Received: by 2002:a05:6e02:1aad:b0:380:fd76:3d9e with SMTP id
 e9e14a558f8ab-398e6b9eea3mr178800205ab.22.1721833807252; 
 Wed, 24 Jul 2024 08:10:07 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Dahl <ada@thorsis.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 34/35] doc: Move generic-board documentation into rst
Date: Wed, 24 Jul 2024 09:09:21 -0600
Message-Id: <20240724150922.2343249-35-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This information is useful for people looking at how U-Boot has changed
over the years and the design decisions which led to it. Move it into
doc/ in an 'historical' section.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../historical/generic_board.rst}                | 16 ++++++++--------
 doc/develop/historical/index.rst                 | 12 ++++++++++++
 doc/develop/index.rst                            |  8 ++++++++
 3 files changed, 28 insertions(+), 8 deletions(-)
 rename doc/{README.generic-board => develop/historical/generic_board.rst} (96%)
 create mode 100644 doc/develop/historical/index.rst

diff --git a/doc/README.generic-board b/doc/develop/historical/generic_board.rst
similarity index 96%
rename from doc/README.generic-board
rename to doc/develop/historical/generic_board.rst
index bc35179fbfd..6711d3d7a89 100644
--- a/doc/README.generic-board
+++ b/doc/develop/historical/generic_board.rst
@@ -1,10 +1,9 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2014 Google, Inc
-# Simon Glass <sjg@chromium.org>
+.. SPDX-License-Identifier: GPL-2.0+
+.. (C) Copyright 2014 Google, Inc
+.. sectionauthor:: Simon Glass <sjg@chromium.org>
 
-Background
-----------
+Generic board
+-------------
 
 U-Boot traditionally had a board.c file for each architecture. This introduced
 quite a lot of duplication, with each architecture tending to do
@@ -16,7 +15,7 @@ All boards and architectures have moved to this as of mid 2016.
 
 
 What has changed?
------------------
+~~~~~~~~~~~~~~~~~
 
 The main change is that the arch/<arch>/lib/board.c file is removed in
 favour of common/board_f.c (for pre-relocation init) and common/board_r.c
@@ -28,7 +27,7 @@ have been moved to separate structures.
 
 
 Further Background
-------------------
+~~~~~~~~~~~~~~~~~~
 
 The full text of the original generic board series is reproduced below.
 
@@ -132,4 +131,5 @@ convenience.
 
 Simon Glass, sjg@chromium.org
 March 2014
+
 Updated after final removal, May 2016
diff --git a/doc/develop/historical/index.rst b/doc/develop/historical/index.rst
new file mode 100644
index 00000000000..e4462f5d2a7
--- /dev/null
+++ b/doc/develop/historical/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Historical Documents
+====================
+
+This section provides documentation about major changes in U-Boot over the
+years.
+
+.. toctree::
+   :maxdepth: 1
+
+   generic_board
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index c0107a783fc..0d0e60ab56c 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -99,3 +99,11 @@ Code quality
    :maxdepth: 1
 
    python_cq
+
+Historical documentation
+------------------------
+
+.. toctree::
+   :maxdepth: 2
+
+   historical/index
-- 
2.34.1

