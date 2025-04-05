Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3B0C36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 18:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593748215B;
	Sat,  5 Apr 2025 20:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743878808;
	bh=NPkbXEO6cU7W5SDBIvLPuVZf5jHyno+66HKYxcRUk4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LTXb2FTU0uhliHEhh5k7hgPg4VctqeXZ+OXARsyiYxfjWA14QKT8zUY1LG6a5DfN+
	 jRY6UXy5i+Qjlu+tpb67YxlpWJcly9IfDj26qA6dbpZybkLTmKLypWK8RmvbDa0GNv
	 dfpoN757ei3KHEp8PxYEoh4+bNTYtr2uQRG+Yk+/mOHiTwGxxDpLc+ApjsFa+wGSwB
	 qk0q4IrTqcGKjDSvhTGKf92vumxEo7h0Q2EouOVFeDbUyFrcbLcNqFH2vu7ZVKpWot
	 PjiwVjNY0kOma2Pv/GJPyQRsGv0HIS7QvffbXQxVnd6zdhVWmK4H2/dbjhHJkMeD8P
	 ipMidnAAvZuyg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6009E82ACB; Sat,  5 Apr 2025 20:46:47 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B5582A96
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 20:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="R7ZiXLEY"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C99910252EF9; 
 Sat,  5 Apr 2025 20:46:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743878803; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=NPkbXEO6cU7W5SDBIvLPuVZf5jHyno+66HKYxcRUk4A=;
 b=R7ZiXLEYHZ8YmKwycrJHTMCGRD82IF+4jXz82rVlyK6Dc4oV1yxn6xPPdIR+dGLDIIdWTT
 /bDtFP/icHNF6tzhEP0jLRbkskgWomy/hDeud/jfuakSxjgD1fWmDavTJkMG/+6JkxdtSA
 UsITORoFqZOE6rivwReqrQ41JknhqC7i7m7pFiG2ZWSjnh17i8IdNUAVf7YAIfKoGUi30U
 D1dJPnH3YhxBYcnTwPZ0a3ME3J5BoJaLZzJyglEdnymk5T33rz72Vzipa91CZOpn06TY0p
 LJ0dIEqtbZ/TBphIulyaHIw0wriVQBMOoTwDiDnz3I0zfNjUoTgDRfX/aUk4Yw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/8] tools/buildman/requirements.txt: update coverage
Date: Sat,  5 Apr 2025 20:46:20 +0200
Message-Id: <20250405184626.22377-3-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405184626.22377-1-hs@denx.de>
References: <20250405184626.22377-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Heiko Schocher <hs@nabladev.com>

-coverage==6.2
+coverage==7.6.2

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 tools/buildman/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 052d0ed5c6..50231d1756 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,4 +1,4 @@
-coverage==6.2
+coverage==7.6.2
 jsonschema==4.17.3
 pycryptodome==3.20
 pyyaml==6.0
-- 
2.20.1

