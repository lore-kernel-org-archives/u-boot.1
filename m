Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B78EC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5923582A56;
	Thu,  8 May 2025 23:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cUiLGHIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74BE382A39; Thu,  8 May 2025 23:42:31 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490648269F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72b82c8230aso538061a34.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746740548; x=1747345348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vqxcNuwWEr1TkYtp5e7eMG4w7EZUosScTiCeq1/4HE=;
 b=cUiLGHIyT9UADpwWPymfdOCBxVtEwM2JApBRRG8sD8rTdX+Zdd7IS8COmAJQehIq7a
 34Ipgvp9ekIMNkL40OkoBFtOzCoIjZlwuFOhxMyqU7GniSd8eBn3BWRN6GERe1TvEmxC
 CU5+fJEeMsVD1dLfF73fzGBSZiOGW5ZwKsfxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746740548; x=1747345348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vqxcNuwWEr1TkYtp5e7eMG4w7EZUosScTiCeq1/4HE=;
 b=OjamgD4cIFj4OfqqZG5CzQgi7RiSIYeCGaqMKOrAt5u2JYXjF/5oqJB8zcve8DR2hO
 jsgcJa22Jqt+eaTr+l2QJe5R3vypvATk+beATReLNxpUdHFdfIpqqCuah9Z9SQrCXNTj
 Ou+61Yd6uNdFdRhR1W5A0z5ncmSrdAOEN4rACai8XCYCw9Q3vjpGt5/CvXTziH858Jv5
 kj9xlsmtm7CkVOByaWecjPL+WHv950x+8nb3qkXwTRymPgaHvx61ZoXKRWmSGj6DsrdM
 R0rexTBm7nvEjTGkW+msz/Wmv8ymGGUT/xwcczpd8+6uuC0ugzjVUfwC5IiNkbvi2eum
 +xCg==
X-Gm-Message-State: AOJu0YzX5UdD4uHQlAggbC8VkEfz14cTZ987fJMzS52Hry2yvHCche0V
 kpjkZx89W3P3OY8U8LcOdYdFsY9e1MpPn2+iZTR71COB/g3fPMlTcD+wACaQkhaueCTfsmHXisS
 W
X-Gm-Gg: ASbGncvk3RzgbAxr1bO4Lme3gDQIp/2r58gOTxoUvyFi1dIgEXBhEBOfQtGMkJ7UMCh
 uMt82iOlZRIM/VrYErmcngdQ85milMIvfkYMvW/3oaDEupQMVgBudzV6xKU/PQDNoYzme8qpwsM
 fkmpZB9ZIUmsu0x77uLxfL5M5+mlIoflvXWfQ+qlwQHjfDqndlx3lR8o5k/ZSeCZ+SEncpQaU5v
 d9INoQ2pdADTj4H2D+b0+wMzp7ufBM2rTipAaNYDw+EtjSjvqdXDvyc0ezkfYu96ARhxkzMOKJM
 BpyVTcXWshFbsARnHEA4IZ7U3GxrKJ96pfmVs2M+TmZdVez+6LhgOlJK++01kVfhuTnYrL3sT6Y
 biclXkdUcjyUKua4=
X-Google-Smtp-Source: AGHT+IGWLEBD00x0IiVSgEoRfp+sBGIcD/f/ugXtpFi6jGPwCjcGrF6Rlyh8aiXPFhmVWCmotQpYKA==
X-Received: by 2002:a05:6830:442c:b0:72b:94a4:9143 with SMTP id
 46e09a7af769-732269beb4fmr903018a34.2.1746740548089; 
 Thu, 08 May 2025 14:42:28 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264d439esm266167a34.30.2025.05.08.14.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 14:42:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] doc: pytest: Document the test_button test
Date: Thu,  8 May 2025 15:34:45 -0600
Message-ID: <20250508214222.643020-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508214222.643020-1-trini@konsulko.com>
References: <20250507232500.527782-1-trini@konsulko.com>
 <20250508214222.643020-1-trini@konsulko.com>
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

Add this test to the documentation. No changes to the test itself were
required.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 doc/develop/pytest/index.rst       | 1 +
 doc/develop/pytest/test_button.rst | 8 ++++++++
 test/py/tests/test_button.py       | 2 ++
 3 files changed, 11 insertions(+)
 create mode 100644 doc/develop/pytest/test_button.rst

diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index 4d949cfd1d2d..0a7c1b21a24b 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -21,6 +21,7 @@ Individual tests
    test_bind
    test_bootmenu
    test_bootstage
+   test_button
    test_efi_loader
    test_net
    test_net_boot
diff --git a/doc/develop/pytest/test_button.rst b/doc/develop/pytest/test_button.rst
new file mode 100644
index 000000000000..4e5a29f20a7b
--- /dev/null
+++ b/doc/develop/pytest/test_button.rst
@@ -0,0 +1,8 @@
+test_button
+===========
+
+.. automodule:: test_button
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_button.py b/test/py/tests/test_button.py
index f0d85be896d8..f3f68169e148 100644
--- a/test/py/tests/test_button.py
+++ b/test/py/tests/test_button.py
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+"""Tests for the button command"""
+
 import pytest
 
 @pytest.mark.boardspec('sandbox')
-- 
2.43.0

