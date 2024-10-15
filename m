Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA25CFC505
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 01:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87BDC89235;
	Tue, 15 Oct 2024 03:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rv1MXP4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6208923B; Tue, 15 Oct 2024 03:33:18 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE5B8922B
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 03:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so30613716d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728955995; x=1729560795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GArWgzDuXyjStFdNJGImbjT7TzGW2zsLpiZC/Aq/JBs=;
 b=Rv1MXP4KLw/IS4sDnPOIA8tdL49bjpm0VaVFolwQo10nIm4f4/KsAcshFeGqmLnHRO
 mdQl+aLS6sp9py82w0c5sTCRcwdg3FjBqvF/oA1CYBjrSQrwFIgYGwNv8keOH/H9CKIv
 q5P1Zpfs+8hlF9q/9YHkV+FnTa+HZ299YGGgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728955995; x=1729560795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GArWgzDuXyjStFdNJGImbjT7TzGW2zsLpiZC/Aq/JBs=;
 b=L8mQeXYHvfDdwIA01hQB2mSWcrNOJEDc7OhBfHuDeBsSZGp3LEFrv5AqoFSZo1IbF+
 4H2sqWBXap50pI+xczc9j8WPM+0/U2ltOKM9bKmZK8h//kGx4HFlSfh0CVP7Ywz3s/2B
 0wQ5K+paPxyy0DHPDHx7NS/zys3e7jgjykSZYzEIjIk5PQa7uKKAbzdtm6zagKIZcBaX
 okYVX0CixMsm18fo/E4+CJJYKPSwo5MaMQtEgOqzBZNOdxSLc7DYH2aFUWHaKfu7041i
 bOXjxU7I5KCBc+AmNhnCY+CrVQu+vhrWxI8PtsD8tRS7UfbKPivRD4jctsyv7ZTbChbP
 j5Lg==
X-Gm-Message-State: AOJu0YwrqLvpfkAFlJ/SHTF18qW0CH0pRjZ+77edIULYQrVYloeGJwot
 dvCaTvCDug8bNuP4FtethEMEQ2q+0jDSwYvvBOHiHpIEQpBIRue3Up+gvdLkvr5pR5iqCyVC5JN
 r1yI=
X-Google-Smtp-Source: AGHT+IHUyj4BAq/UobDRCjteVqywbbj0fsm0b0XdH+KUdzRnJTohnmtgQzeAFTQIeryRS7jXimx/lw==
X-Received: by 2002:a05:6214:2e43:b0:6cb:e90c:7c6d with SMTP id
 6a1803df08f44-6cbf9d20b37mr168362096d6.14.1728955995364; 
 Mon, 14 Oct 2024 18:33:15 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc229654c4sm1358286d6.128.2024.10.14.18.33.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 18:33:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Azure: Update to latest containers
Date: Mon, 14 Oct 2024 19:33:10 -0600
Message-ID: <20241015013310.289277-1-trini@konsulko.com>
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

Soon Azure will be removing the macOS-12 container in following their
normal support schedule. Move us to macOS-14 so we won't have problems
there for a while. At the same time, our Windows container is the oldest
supported, so move to the newer option. Finally, Ubuntu 22.04 is the
middle option currently, but 24.04 should be fine.

Link: https://github.com/actions/runner-images/issues/10721
Signed-off-by: Tom Rini <trini@konsulko.com>
---
That issue is, as of this writing, the only place to list macOS-15, so
I'm using 14 instead.
---
 .azure-pipelines.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b66d49a62ba0..18700c4cc7be 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -1,7 +1,7 @@
 variables:
-  windows_vm: windows-2019
-  ubuntu_vm: ubuntu-22.04
-  macos_vm: macOS-12
+  windows_vm: windows-2022
+  ubuntu_vm: ubuntu-24.04
+  macos_vm: macOS-14
   ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240808-21Aug2024
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
-- 
2.43.0

