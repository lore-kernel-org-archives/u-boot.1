Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF72CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 16:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B86836F0;
	Fri, 24 Oct 2025 18:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UDmVDZ1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B21783678; Fri, 24 Oct 2025 18:06:08 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9B3836C8
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 18:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c280b71af9so643473a34.2
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761321962; x=1761926762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgp9FBA1MYvRRB1yHRwhj21gH5RErAKdMaT+asM0AzA=;
 b=UDmVDZ1pZOaebedBZEnmNAC+R7hYz0K15Ra5VmxpNU/TZ7+bWzBBgEEE0rFlN9nxeL
 Ux4pXSdDqgNXDzMn6EEmLUV1FmSWCkVCG4QWSKBNxm5SnsNzzx4DLnQc+2Vo42Usi1S0
 ZYxN3SrqM+788TayERlnMXE18RVl+PRvt36E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761321962; x=1761926762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgp9FBA1MYvRRB1yHRwhj21gH5RErAKdMaT+asM0AzA=;
 b=BkTMWVHM8bdfl09gCNh/3zLOs4/Fk4DmBWSYQJQOmLdDykQPZ6HhlW3mPBVnyve744
 7kBYnO9Ni7p7+U8G5zpNaPd7CoW44BxCDqsNgV5Y/zUhjtP+aVCtu9i2WbFjAxaLqQs5
 5ykJ4ErgkVFL1Bh8pW5smyJeVg/KO8DnSnhwBUUrQHFkaX31gkWy3mTZ+5wSCDQTRHtq
 YFrV32I62y0K4CiELkZpH3zr2axvCB99S0gA8oXqZ+qXZJ4Ruoo390eR1UXpZj8P4QCR
 yk1lpLl9zYNCDgm544VmxdilO7+dHjhxe3a3ZKwyQ8rr2iDBHxI0BsP/ofwL/7hdz1XA
 K2wg==
X-Gm-Message-State: AOJu0YxQ/MnXpYhNRfZ77mSErOaK0QWhE14L8dW/1Fb4GFaWaYzytdkb
 5RYibS36HxI1WRf9GJEVhay3u5doE4RKuSYLjAWiwKNMqepLtEjXbpD6zBn6aaeMevnpQTY7pfM
 bZq4sxl8B8g==
X-Gm-Gg: ASbGncu/Dqwz3WHOs/IE+ZbPjM7v9FP90D0MVyEnRv/6TqWjRWH94ryf+v5ZKiP9p9C
 /nnRYO0q+Rl7cbd1V+N+CEsfTCRmdFgjMt9eK6tfW5OsOpby7aseVYWorHkcrLmCS+FDnVElCU8
 Oy22bNksY+87fcXaiEfMt5YbVkUTrT1RimVdEiB7MuREmj3Q3w/OvMLs4bkhDxcBUSn3NhG1Y6R
 WHQOShAuZJQ67gvAVb9IkQVCSLX/gIIbKCy5uVw3PVUWQdZwfsubckH/bQgzq2a+ATVsdxLLPr0
 Setf1ZXYF5YWPKNv3JEV3F5eNeB4e9yM2FAZXNypo+F+rmK9l1zqeAZFIeEAmRCtPFirZLcoi1G
 fpUqwi53upT94DvPGjgBk+WK+Y4BMUGoVwrwnkF7TIDexgCVqug7QLc9WuUY2w2kZhd1PP5NnP9
 63m//81uWejNsIkXYaW8r44jI2a3myeCFsB/DmOH4X3ORzuV/1esSI
X-Google-Smtp-Source: AGHT+IG8strlYAa4rkyWSSEOWTov2eJQL7+7F9mYZiF0F5XCjDaZwUUo3LeMJL22s3erK1/oWMi92A==
X-Received: by 2002:a05:6808:221b:b0:43f:42d4:acd2 with SMTP id
 5614622812f47-443a301446fmr10520423b6e.51.1761321962216; 
 Fri, 24 Oct 2025 09:06:02 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654d7fb99d1sm1250225eaf.9.2025.10.24.09.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:06:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 2/3] doc: askenv: Reword and remove return value
Date: Fri, 24 Oct 2025 10:02:58 -0600
Message-ID: <20251024160557.2317081-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251024160557.2317081-1-trini@konsulko.com>
References: <20251024160557.2317081-1-trini@konsulko.com>
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

With the addition of general text about how the return value is handled,
remove the examples from the askenv documentation as they are all normal
expected results.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/usage/cmd/askenv.rst | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
index e2b3c5379aea..a8867ce4d266 100644
--- a/doc/usage/cmd/askenv.rst
+++ b/doc/usage/cmd/askenv.rst
@@ -42,9 +42,8 @@ Value of a environment variable env1 without message and size parameters:
 
 ::
 
-    => askenv env1;echo $?
+    => askenv env1
     Please enter 'env1': val1
-    0
     => printenv env1
     env1=val1
 
@@ -52,9 +51,8 @@ Value of a environment variable env2 with message and size parameters:
 
 ::
 
-    => askenv env2 Please type-in a value for env2: 10;echo $?
+    => askenv env2 Please type-in a value for env2: 10
     Please type-in a value for env2: 1234567890123
-    0
     => printenv env2
     env2=1234567890
 
@@ -62,31 +60,12 @@ Value of a environment variable env3 with size parameter only:
 
 ::
 
-    => askenv env3 10;echo $?
+    => askenv env3 10
     Please enter 'env3': val3
-    0
     => printenv env3
     env3=val3
 
-Return Value of askenv command, when used without any other arguments:
-
-::
-
-    => askenv;echo $?
-    askenv - get environment variables from stdin
-
-    Usage:
-    askenv name [message] [size]
-        - display 'message' and get environment variable 'name' from stdin (max 'size' chars)
-    1
-
 Configuration
 -------------
 
 The askenv command is only available if CMD_ASKENV=y
-
-Return value
-------------
-
-The return value $? is set to 0 (true).
-If no other arguments are specified (along with askenv), it is set to 1 (false).
-- 
2.43.0

