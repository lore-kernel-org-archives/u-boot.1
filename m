Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5902D711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A604983936;
	Fri, 19 Dec 2025 00:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JpU7G57H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE4D833C6; Fri, 19 Dec 2025 00:23:11 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D391883106
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-450c65f3510so770361b6e.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100187; x=1766704987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06mTdBxgZI1WY6M1Jvv+OTZnzc1KVNR8sqbPhtZ2/b8=;
 b=JpU7G57HaLsGZq1DYYE4qgkCGRzdCDBIodP8a8PyfXTLFTW1Nm2tF27dtByw8pjCNP
 w+A3+r84Y4D0loqJzAZ92s0XMytV3tpN6uG5tf6BLZkXN2cAniHy5t/Of3FxK9sfr85a
 ig7iBefO+IWnD0ThfuJdbARQtlMXo4O7khjlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100187; x=1766704987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=06mTdBxgZI1WY6M1Jvv+OTZnzc1KVNR8sqbPhtZ2/b8=;
 b=IcnxyvWzWJdx3qqo5BFKkJNzLBGYP9bmeaAgYQDyqRCgQ/qz2qRlrE0xGTdroc6awK
 MyV2iZM9zWSeW4cCrYFBo4K1vztkNs7BhoJN73R9TvIkP0bxWNOsvsVw+U2mpqcakZzL
 E5f9iTxlcJ7olfWYFr3EZndbE30aE574gYUtjIhkQ2xzlrbxZKd2T7q2DaFDECPmiC+A
 4oemF5rZVzNdow7heG+fCj5tJAnpv34B+4Cr5BD8Fh8P6cFRbs9ChYVzHJ4Op1YwVn1B
 NuWRW4ZLXbyLsX/B3xjypCOWN3cqcPM+LI1qcHb8TEwdAa0PrcvdtirfyD8LSrep0JSG
 AK1g==
X-Gm-Message-State: AOJu0Yx5vqAIlb9UvdDzMP9NjS8nFZw860XrRG61/eFFxw0x5WRlf2eG
 Fvcxz33v7kS2Tqy0lSJXf/1gZbwCzCWhISqDIEWts8tj1ODHeTGYi7s7VzKyjOGDxjQLihsnUKz
 ckQ7JxuA=
X-Gm-Gg: AY/fxX78jH7QI+gHbSlRy1IKk8XvdizukCp7gM5qwOZc1CY78Co9tJ8Lw1JUY86bYly
 YEDcRV5b1prsrVf+CK79Kyp9NswbOZsysJxrcNLCOFk6KePRv6QB70m6h4tRiBsOxFGrnAdpIvS
 AT8uIfO5r3b9hjaVLURcMG+I48Gd3j0zcBuj7lHkQxD4cvRTOzL2pZV23lzf61IC18GM+jubvnI
 RDiXt/HkgZEukJV6OtlvFf45IlRQB6osorKeegzcTtHhrn1z5qwu+XE902IwiKuhWpVLCI2htH1
 Hyz9I+BMCoRBhbPxjIGLFLmz46CqONxpiXnYplTbhGHT5RgL2bg/WUjvQo2WGCVcZnrelbzQ27s
 clbkJTjhK0wHCvR524Jw06Da/UbAwLGg71DpEHK7R5ixgfu+1/QooSv7ZrN+VdaInHxe9JRWJhJ
 xPUjx3CnK/AEb/sDkTwske045ja988jPUQVheEBxPopGTD0slWc5To
X-Google-Smtp-Source: AGHT+IEVybpoPvRddwBJf2/l3RTBHMB+aXsiK2ksYAgUkFFTHkRDACY+zJkLaofxm/8ICuXpUOk8PQ==
X-Received: by 2002:a05:6808:30a2:b0:450:c877:fd6f with SMTP id
 5614622812f47-457b22b7b56mr619884b6e.67.1766100187628; 
 Thu, 18 Dec 2025 15:23:07 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:23:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 9/9] lzma: Add SPDX-License-Identifier lines
Date: Thu, 18 Dec 2025 17:10:21 -0600
Message-ID: <20251218232255.3934258-10-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218232255.3934258-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
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

After consulting https://spdx.org/licenses/ this code should be tagged
with the LZMA-SDK-9.22 identifer, so add them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/lzma/7zTypes.h  | 1 +
 lib/lzma/Compiler.h | 1 +
 lib/lzma/LzmaDec.c  | 1 +
 lib/lzma/LzmaDec.h  | 1 +
 lib/lzma/Precomp.h  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/lib/lzma/7zTypes.h b/lib/lzma/7zTypes.h
index 18c804cf3b29..89f40f2a66e6 100644
--- a/lib/lzma/7zTypes.h
+++ b/lib/lzma/7zTypes.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* 7zTypes.h -- Basic types
 2024-01-24 : Igor Pavlov : Public domain */
 
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
index ee9afcee4dfd..b1d682e19aa4 100644
--- a/lib/lzma/Compiler.h
+++ b/lib/lzma/Compiler.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* Compiler.h : Compiler specific defines and pragmas
 : Igor Pavlov : Public domain */
 
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index 9cbe36af7182..f509afcf31fd 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LZMA-SDK-9.22
 /* LzmaDec.c -- LZMA Decoder
 2023-04-07 : Igor Pavlov : Public domain */
 
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index 9e0ef3ef5835..6f1207488b28 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* LzmaDec.h -- LZMA Decoder
 2023-04-02 : Igor Pavlov : Public domain */
 
diff --git a/lib/lzma/Precomp.h b/lib/lzma/Precomp.h
index 38f3d1eb6fdb..bcdf3d57b6c8 100644
--- a/lib/lzma/Precomp.h
+++ b/lib/lzma/Precomp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* Precomp.h -- precompilation file
 2024-01-25 : Igor Pavlov : Public domain */
 
-- 
2.43.0

