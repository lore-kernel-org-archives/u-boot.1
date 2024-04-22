Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC75C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 16:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E168888B;
	Mon, 22 Apr 2024 18:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PXGX7E+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5851D8888B; Mon, 22 Apr 2024 18:45:00 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F1088205
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 18:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6eb86aeeb2cso2926937a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713804297; x=1714409097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+E2Z3pg9DLj2I72hsc1bGK1ymd2t6Wq2FILYuU3KVuQ=;
 b=PXGX7E+4ohBwCe+N6ntNH/Gz65Z69S6OnjtAe4b8poxUxRgwGy9aV3cePkq+Nk0OzB
 qBFVXeSzV2tu9CTc9b1CrUlrGcRcbr9qvmKtc2vt79PIDxyQdnTiLw9ll4GPbwMtXHjy
 9HO3ZmJ+6eG8kij8bTF5aov0SpfbU2B6mnha4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713804297; x=1714409097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+E2Z3pg9DLj2I72hsc1bGK1ymd2t6Wq2FILYuU3KVuQ=;
 b=i66zkdN+9fSFVbANdbACdwm+/JZeOgJloelvOboS5/ygVlaUO8Wz0Ngxhgu22BXejJ
 fDX/t5RTXB/l3MeXgIn8UFtKS2OkA0CPsY2Q6nOi3K3EqvmE/r0g/PHHLSETk05oascH
 wDysOPCaXJNEbY1dUvMwbtmsLFtGwxz3Sx51Ux2CKQrfvaRgo995jajvTSi4bUnzH21h
 pxJcx+MtFHiWlVDOWg7Oa7f36i7Nat93eSD0t4zln20dXfml1IXFvjW2kKbZS9pr5+JR
 91ObqO/76/hBNroleFP2ye5iX1ozhUDS6jh1Lx4nYS38RN9XJhzlaF4OI6YtlNWdbeu3
 7QYg==
X-Gm-Message-State: AOJu0YxuY8dDTBguaIh9pr4ReodCc5k+Uf6kWKPeQhbtyaIp/CoW3gyE
 Q1phoDNpKqSlKPdLNEu7TzIEaJ/y7xP3X1zQsV8dmIBezJERXaDKeuJPhXGZs/E+mYi7rrehE+C
 E4A05eg==
X-Google-Smtp-Source: AGHT+IE5IgVEQqqDDCKxKyfSckh94ZWyGIW2JL6boOC6LYPypXlRHbqo6DXZ+pGIPI7R3TcQ/V9rmQ==
X-Received: by 2002:a05:6830:4413:b0:6eb:7e60:6028 with SMTP id
 q19-20020a056830441300b006eb7e606028mr15158943otv.30.1713804296726; 
 Mon, 22 Apr 2024 09:44:56 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 vv4-20020a05620a562400b0078d66c78d43sm4462708qkn.44.2024.04.22.09.44.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 09:44:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc: release_cycle: Note when next branch opens
Date: Mon, 22 Apr 2024 10:44:54 -0600
Message-Id: <20240422164454.1900211-1-trini@konsulko.com>
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

While I have said this in various release emails, it should be
documented here as well that the next branch opens with the second
release candidate.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/release_cycle.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/develop/release_cycle.rst b/doc/develop/release_cycle.rst
index 8d4c112f1493..7931521ad9bb 100644
--- a/doc/develop/release_cycle.rst
+++ b/doc/develop/release_cycle.rst
@@ -19,6 +19,9 @@ Cycle as follows:
 * After the merge window closes, no new features may be added to allow for a
   release candidate phase which is intended to fix bugs and regressions.
 
+* To help with late pull requests, the **next** branch will open when the
+  second release candidate is published.
+
 *Note:* While we try to adhere to the release schedule, we will
 not hesitate and take the liberty to delay a release if there are
 good reasons, for example if there are known bugs or other technical
-- 
2.34.1

