Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF0DC36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 18:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A50EF82ACF;
	Sat,  5 Apr 2025 20:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743878808;
	bh=8PU/CHKwLlvu3pRAr7Lun3WEjeY6v7Stevn19nx2SUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHCdgZSl3IlTjvaynd4pJlE8K6QkXwSYuony84HVCCTUvdUt5CK06m4uru+oJDhH0
	 uy+rSo+1Kga9htgoZE2UhF69wLh1OeqpqmOrZTNX7BThOZwg79ehNFiGEukPh3yFFA
	 7UIZ8I5XlXvaBXavE7inm7X1gI95QTiaSCdFi5HwMZrsYWCSig/0GWLGMUq80Qij2G
	 yLHTB7yB66ZC2nYZJakK2v02uJai86WyICWzqToG1x76EuwB9Ijw5oWE1fBMTyjZmn
	 4NeGorq8aNZOXWrv9neRDdshqW4Kf7plZRky6CCUQ6yp5CC2tDH/dA9do8kQiIpnL7
	 WK9QsZwCvsqVw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7077B82A96; Sat,  5 Apr 2025 20:46:47 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0709A82AA3
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 20:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="augQCrx2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0DCEA10252EFA; 
 Sat,  5 Apr 2025 20:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743878804; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=8PU/CHKwLlvu3pRAr7Lun3WEjeY6v7Stevn19nx2SUQ=;
 b=augQCrx29JEFwbT7a1LE/sa06UPzEtKN/vakyuwe+0QL8SKf7vTriMHFejiDYHoasBtME6
 48oFd661s8JcfsgOT/4NZOGVjJDEzJrd0O/C2cVBLmiPZg4ZnvMPOnJUyt9kLhD0Tg4xHe
 oom9pJJ738KUE/H+GvO8QW2fCQxQuz1BFLyRlFXgE0RLYO8qIsECe+vaXVByPnwBQd07Oc
 MyPzOK46ZFYW+rvUrjfMrijxlHVWrsdQ/Dc+uMceTX9jnfU7YOf+Lz0Vsv0hYU/OpM4/rt
 uFpAY/mee9IC35AYk1wWHGyZbxSXjwnjr6NnvK81xtM++A4ip6UuQgZ3uZ8K+w==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 3/8] test/py/requirements.txt: increase filelock version
Date: Sat,  5 Apr 2025 20:46:21 +0200
Message-Id: <20250405184626.22377-4-hs@denx.de>
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

building on gitlab with

image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024

drops error:

ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
virtualenv 20.13.0+ds requires filelock<4,>=3.2, but you have filelock 3.0.12 which is incompatible.

Increase to version 3.2.0

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 9b15e97f51..22315b4ed5 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -3,7 +3,7 @@ attrs==19.3.0
 concurrencytest==0.1.2
 coverage==7.6.2
 extras==1.0.0
-filelock==3.0.12
+filelock==3.2.0
 fixtures==3.0.0
 importlib-metadata==0.23
 linecache2==1.0.0
-- 
2.20.1

