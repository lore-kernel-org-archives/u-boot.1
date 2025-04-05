Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80D0C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 19:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F5D82AF1;
	Sat,  5 Apr 2025 21:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743879974;
	bh=ujuNerHO8TUG9KzXNoMGyN7Jte8uNmwq6rCzUr/F+kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRR4kM+6jCScyHQZWA0ch9X0mO/uYnPoyKrSy6l8RW1ltaEi0LBqxGq4Sm33Sruwh
	 Ub8U59nFfB1tesSFJUJEfc1V28KqtqzgU7oq4vvP5IucX63Ow2UR488AZohTlYETc7
	 mAx3wEl260Zehayyx/7VM5C9Xny0EEM6iAOGAlncgNsuu6thebx6tbMrqyU2u7T1jN
	 DCgnB73ZeWTerO+R+JEj0LKEpsWqnEMx3LfA3G1eIaWTlJMi/Fl3MMk4cnL6WQVWnI
	 A3Oo6jHydeIvV8PokNOIAaS0GlAH5LBI8qnjmZvQ8OSvp6yHiZnQ55wLzTC9wURN9W
	 Vc98qzKmHu15A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E29382AB1; Sat,  5 Apr 2025 21:06:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9854D82AB2
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 21:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eVypCYbd"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CCFBC10252EFE; 
 Sat,  5 Apr 2025 21:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743879970; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ujuNerHO8TUG9KzXNoMGyN7Jte8uNmwq6rCzUr/F+kU=;
 b=eVypCYbdFLzDyt5l54YyYKx2cXkzDdQ7v3YoMXtN4lptbL9tHEgGtCUXC3T3spu2Awgif/
 bT1OWxQ6GoUfzenh0w1Cu/4m8v2uFjHmfUgTshHBrPgm+bj7Ftse0TXuyuJBbiYM8/Ihth
 NaZBu1lU7Z0lJSWgaR4qK+pOUJ0JZ3mBWWZvaw+i/GqFqgdGk/eCZajrWA7QpI5I2pvg+8
 B/dpzT0cX8j36a1LEZMu9sR2B3VB7MxK1Yyb1s6lyjkH2bQj7fm3BR/JxXyBbzxSz1iEME
 3EV2cP2XAbZOqkN0mTFFV79wKhl1skszSPlcm/0Y/fJNNvAMpss5rsKxigkDYQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/8] test/py/requirements.txt: increase filelock version
Date: Sat,  5 Apr 2025 21:05:55 +0200
Message-Id: <20250405190600.24081-4-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405190600.24081-1-hs@denx.de>
References: <20250405190600.24081-1-hs@denx.de>
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
---

(no changes since v1)

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

