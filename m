Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AF1CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D5A5807C0;
	Tue, 21 Oct 2025 22:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aIAv8f1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA52835B3; Tue, 21 Oct 2025 22:28:32 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3242802C1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c284d4867eso1530019a34.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761078509; x=1761683309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCA+EDLL9Y7PSODITAxFxC+XV5K3j/OMpmENQXa102M=;
 b=aIAv8f1pv0wTGB1nLTvj91EI/MdZcKaLiZ40ta6gTEDuopa+mTz9UpBavyTMa0M5Tx
 FW5mXVg4meE7CcF2ytwR79rdk7rVPDlHMdbPp0MplHjHYEQI8uX1VwcH8ikWpug4e7Z7
 TGFiWvXqJfGk5VmmuIevKHH+3jb1fN6w9cfD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761078509; x=1761683309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCA+EDLL9Y7PSODITAxFxC+XV5K3j/OMpmENQXa102M=;
 b=i66OI2mBCbWWXP+ceyLMskH+UAtC4TRId5jP5kBkwaRGBXbQ3NXZJmBe6cHjphOD/6
 AzjlDud3UF9AvE93lhQDe6Fht1z7VGHBL59t4DCsmafVVJ0tZrLv8Qycfm6XBuoJn06z
 mqNFhDuNEnSgOn9YCJDXBJOLfPBSzxCFRaC2IbsjemYd8R1VXlAFrJTDV3nt237tzJFO
 HNCB3sQZfoTfMDnScWSA97cppkg9TE2T0ZSUejpHsX+iXhxsZYjOFg1xdNMWY/yEmvJm
 ujZUwXwfQ4TGQ5c2jc93dD0LD50SC5pcUQJmgFUSacfsEmu/WbCCawpCIOZiv2ip8uTo
 IneQ==
X-Gm-Message-State: AOJu0Yz7My1F2u0a255CR0TkNvlUVM3hgdKbcH42gCPAQifAmZXVfDb4
 AE0ZnCvWqN1VATYxDj08z8m+onkB7CuGWk9MgDC+wZC5pNAsWAIIM48BWjImrR8QDfxubEZZpdH
 4fjK1Kpmixw==
X-Gm-Gg: ASbGncsx3Bs0rxeTUtav+FfpEThkVr1mTD9lJ7om/Y9CR1q3aCRfqG108+BuSNo8deZ
 5ip0Ia8A20eJs1pu2cppmbkRqKS5ykwOWKsfl2y1eEKHXb5W4v2iBhOq4Orv6TyMQL1BiR55bvl
 S8VWfuMTqB6Yd+iK44k51dExL/ekVHGCfhU0lGnehuM3TPA5Nq5VZlTa9dzE9FSUFptIlxKVsLj
 w8834iQ00FDxh5hhAcjyVnL9xfGBLjTKw2KEBUBuNeUUZAZbU07M0QzIxZbGCHQ9flqcMDZ16ox
 p37Yxm5qfLZl88LKpFUnDZSS8B8NY8ojLa5Xj0Q+SczLzK+/cvzJNv2Cx+CR81lCrcN8fSnHL7S
 8xa4MqhNTwq3xmXUSNnIkqEI//GieKXGhWhSj/RpRrZgbSVKHJnoU6LNfCuqUIspDhal0mEF+c5
 JlKU5vCKO8TzpQ5M7J6gRVFN8eCvXveUborIOAfYHjDQ==
X-Google-Smtp-Source: AGHT+IGwr523BmylpK/5zKXCXGxdivvRh0ev57SwYcXe/S7wqKU8YqQ/FiKR9U6eLOjeXtObjj2Hdg==
X-Received: by 2002:a05:6830:63cd:b0:7c2:7736:16b7 with SMTP id
 46e09a7af769-7c27cc86c04mr8937672a34.27.1761078508693; 
 Tue, 21 Oct 2025 13:28:28 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2888ef0besm3930194a34.20.2025.10.21.13.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 13:28:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/3] doc: askenv: Reword and remove return value
Date: Tue, 21 Oct 2025 14:25:33 -0600
Message-ID: <20251021202820.1272414-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021202820.1272414-1-trini@konsulko.com>
References: <20251021202820.1272414-1-trini@konsulko.com>
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

