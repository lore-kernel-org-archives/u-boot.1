Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C9EC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF7988E57;
	Wed, 21 Aug 2024 18:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LhJQaojh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2200188E40; Wed, 21 Aug 2024 18:20:11 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E31188E75
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7092ea69218so483842a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257206; x=1724862006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frhQA5ILUsz42KJd8pJHwJTbR6zxgQzsoRaaKvRIME8=;
 b=LhJQaojh8di8AhgZgzfDxIcFtidhCg6B+56QYPYWy/gq8xZyiSY7FthsVSuRUW2Mjw
 sqTcqiVIQp1mOrrG7AZ0jVzjVhSC8is5gTTBW6XI3pQKAtA9bYICJ/EGGAjBG0LdG9rV
 UnVN+nmvU1bANEc61icR1oWO3TzDq51lYZjNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257206; x=1724862006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frhQA5ILUsz42KJd8pJHwJTbR6zxgQzsoRaaKvRIME8=;
 b=gM+4rymX5Aib9E5INs6E2NqkpwscdZYhH8Z7ulnlytQogLGnVvf2aP05L7JyPligO1
 lnKr4peQ/pwzs9QfrGKWsIvtHik5m6USMS2khknwJttRHbnCeyDzUHCCJqIHYxf+Rx5P
 p8bOo8te31ILkzOWrvgTBUYbeL64s5HcZWkZbtdqtN+JiVJNAtlFPgd6ADH6/qdyU6bW
 e+l2UElepYjQ+ZVQeDnp5pzeNfZuM3eaWAZFi+XTUH4cy1qbwMZlhKutwy+BC19ARCO2
 j81zi/APVOoIk6PnexdCUD4cIpVPGbsGDRaYvswK4jo1StKwMMhncBX2zGE7tIU2Eh95
 NRSA==
X-Gm-Message-State: AOJu0YxTQmOUWCdaB7Ij7nr5bhcODmsTgxvRf7ahPyBVSm7MH8f4Fc4y
 xVpWtbLAAlig9CUsjxxBPkDlg+pcCll0F6xdLmKwPQtLe/84QmdUR4wFTsxsCtOEYYtHZwgWnM4
 =
X-Google-Smtp-Source: AGHT+IHAOyZrL6ltQ3JvuJVgptsps0uv+NMdZgEE/lfc+8yP4ebfVT02gmVNH/1kZdyJXouZFUEbIw==
X-Received: by 2002:a05:6830:2a93:b0:6f9:afdc:8554 with SMTP id
 46e09a7af769-70e01bc65dfmr69687a34.15.1724257206201; 
 Wed, 21 Aug 2024 09:20:06 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 34/35] doc: Move generic-board documentation into rst
Date: Wed, 21 Aug 2024 10:19:26 -0600
Message-Id: <20240821161927.695717-35-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

(no changes since v1)

 .../historical/generic_board.rst}               | 17 +++++++++--------
 doc/develop/historical/index.rst                | 12 ++++++++++++
 doc/develop/index.rst                           |  8 ++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)
 rename doc/{README.generic-board => develop/historical/generic_board.rst} (96%)
 create mode 100644 doc/develop/historical/index.rst

diff --git a/doc/README.generic-board b/doc/develop/historical/generic_board.rst
similarity index 96%
rename from doc/README.generic-board
rename to doc/develop/historical/generic_board.rst
index bc35179fbfd..12550a140e0 100644
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
 
@@ -132,4 +131,6 @@ convenience.
 
 Simon Glass, sjg@chromium.org
 March 2014
+
 Updated after final removal, May 2016
+
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

