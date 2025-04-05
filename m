Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208A5C36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 19:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 485418215B;
	Sat,  5 Apr 2025 21:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743879974;
	bh=JVj5B4fBWvojS5n/wJP/ZI4gRi9/7aoecyTtdzIBCWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qie94ZlatLy5xxGRJHshbSRKY+3+DB0ovsCe5S22u/2im2rBUZIOPKkJnSTRehA4G
	 5TbwrN/RcAARkkI1vzRTnX/9Ov0roLQ4tt71GTL4ruFcLnCwxVyge35Xa9FiCry10C
	 6kP0pc6Bf0NyHTzSd53FW7UhccfKtIgLpL1Ux1v0Rl47o3wI7MjG56lSdOBtsALb0A
	 e6Tptis3azsO1r5X43pN9voqvyIiNXROWkSk/vcPO1oZaJFWJFer8LhWe44N5pK72/
	 MyVjEe5vU9JH9EtEj4GfNQFaGHnITWwyMtB6uHeM6B0jyT1jAb8LYMzG73kSU2/Fw2
	 vvTsEJ0Y+GN/A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6441882AF1; Sat,  5 Apr 2025 21:06:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0C382AAF
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 21:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DKss9FOe"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CF1F10252EF9; 
 Sat,  5 Apr 2025 21:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743879969; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=JVj5B4fBWvojS5n/wJP/ZI4gRi9/7aoecyTtdzIBCWw=;
 b=DKss9FOewZpDVtOwSjqJK7f/YytAIkQkAIs7yBgJVjI+357dr9yN4VplzZaNiQKnN/w9TE
 EWpiZprOynCNfWachaPhzjJeF0wq4AU8UTGzHe/b9NsJ3WuI+alfr+9XPlEGEKy4JouzgJ
 GMPubS+AjCYy/x+R+2/opm7HLB+eiLYsteEzLfJfNxnkgs1IzwVVaESsuIpJRRki/xYKaF
 Ib3uVyavBvVC+UQFNMD3MkvnywhVxsX4ylpy+ODppfGhNuvxCEVdncqd0fAFJPzfzn/Aob
 TewDKhGyLw9UyAWMWhpO76pdi+dfwxzXrfXqASNds507aElH/RkX4iQEiaW+KQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/8] tools/buildman/requirements.txt: update coverage
Date: Sat,  5 Apr 2025 21:05:54 +0200
Message-Id: <20250405190600.24081-3-hs@denx.de>
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

-coverage==6.2
+coverage==7.6.2

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

(no changes since v1)

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

