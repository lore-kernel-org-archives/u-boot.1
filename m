Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FE3C36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 18:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B30F82AB2;
	Sat,  5 Apr 2025 20:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743878811;
	bh=S3pmuzbYK9tIdI1SSsfkU0X3jh2xgM+SNFgtoiQTlSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4LecWsqYpn8djf/pyzJ80bNGAlewU4O5lF21DMQsJ9wy7c5XR43IpqagLotg6EbV
	 o4AO2S7T5QaP2SOpagAopGVTb5tTZw4ebWp4OGFz1lyo97aTdVe1UZ2ddjqvYZbRMb
	 eypX9DfZIqOO6rIsLiMNCzvxey3lIzUfpNfyOzYV0yvIEgHMDwAkI2Zj01tmgnGLq+
	 gQAVGRsWOfMT69vA9TOMhWWjuDv3XABEWPwwScq7i0gYwNV6YYb1LMyYOg6IS2r2jz
	 oC5Wy4bP50aZNR6xdcp+GCXQ1HrUjb5w4tTly6M3ZEQzT3YoBPB8hmurhEoJa9vGHI
	 nJb94k/uZMbGw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF89A82AE1; Sat,  5 Apr 2025 20:46:48 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B027582A86
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 20:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DrsFswxz"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A711210252BC1; 
 Sat,  5 Apr 2025 20:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743878806; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=S3pmuzbYK9tIdI1SSsfkU0X3jh2xgM+SNFgtoiQTlSg=;
 b=DrsFswxzbaItzzYpw/Bp73tglM6ySGromzldKVd9XX0kbHECUHF+I2NEVgUAPH42khGebq
 +UiYSCfAYUfoMSzBMakl8l5fgFVQXA5s3/1ju2x0kiDv9nTgKiMU3FPlyydcBRkB2LdzcF
 WlKmPn2BwJXnAKl4HhcYYbPOXR3WrwBdLrmQswJHHxRHqNbu+5pmAboFFwBylnz+ey2N7V
 4WnKHp7PKHNWvythb3wTOEhh0MDZsoByheIFBLfDMQFGUmENFnfr+hMD7J8/fJNajd/FF+
 KjFSHgZ4DDrC8omBneRDh3R00ACRKDGUdn/3VSj0yIW9HgYqq7kPoHAgmhy0JQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Love Kumar <love.kumar@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 5/8] test: increase timeouts
Date: Sat,  5 Apr 2025 20:46:23 +0200
Message-Id: <20250405184626.22377-6-hs@denx.de>
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

running tests on github/gitlab while board is somewhere in
the wide world, needs bigger command and standard timeouts.

Increase them to:

TIMEOUT_MS = 60000                  # Standard timeout
TIMEOUT_CMD_MS = 45000              # Command-echo timeout

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 test/py/u_boot_console_base.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 7eaceb39d9..0aabedc394 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -30,8 +30,8 @@ PAT_ID = 0
 PAT_RE = 1
 
 # Timeout before expecting the console to be ready (in milliseconds)
-TIMEOUT_MS = 30000                  # Standard timeout
-TIMEOUT_CMD_MS = 10000              # Command-echo timeout
+TIMEOUT_MS = 60000                  # Standard timeout
+TIMEOUT_CMD_MS = 45000              # Command-echo timeout
 
 # Timeout for board preparation in lab mode. This needs to be enough to build
 # U-Boot, write it to the board and then boot the board. Since this process is
-- 
2.20.1

