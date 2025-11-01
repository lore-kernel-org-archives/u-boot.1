Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0D9CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E2A83AD1;
	Sat,  1 Nov 2025 07:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="kR/qiQBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CA383A8A; Sat,  1 Nov 2025 07:49:29 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D345F83AB4
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 43861109806; Sat,  1 Nov 2025 07:49:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761979767; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=A/qxf5qxOek/iiINM6yuWl9fcqlxf5vy7bt8aMuVczk=;
 b=kR/qiQBCchiD6ZIsnA2sR5Xb2IgL51PoUgguP16DYK0L78hmWD48O+JtQr/6JqEhmbwIP1
 RdrcxiFZvIYMqjtaKpRbj74pmX8MI7gNGXRo7Fm7Z+ipctMmdzGg5nBYdHSRe2Rhuhsh9g
 ecbV7k1aqqtGttATkq2RbSOeVSJwf/Ed5E1jS8HkZ25+X+BL4keCY+/jo3kpPVIvEdmeGC
 pURwdDj8T957jHo5yR/guZwkbZYuHYHLVwVbiJDdRASNorOAadKFVrTK7adXamamjNTVtH
 jHlwjr3fS5i+zjIXsxteJv0HODiaX4lx96SS5euMZQVvIok3Uifl8BEm5tawBw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 5/5] test: cmd: fix a typo in md5 test
Date: Sat,  1 Nov 2025 07:49:07 +0100
Message-Id: <20251101064907.5037-6-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251101064907.5037-1-hs@nabladev.com>
References: <20251101064907.5037-1-hs@nabladev.com>
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

In dm_test_cmd_hash_md5 accidentially sha256 hash
ist used. Use the correct md5 hash instead.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 test/cmd/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/hash.c b/test/cmd/hash.c
index 3f7f64d27d3..3a3869831ce 100644
--- a/test/cmd/hash.c
+++ b/test/cmd/hash.c
@@ -38,7 +38,7 @@ static int dm_test_cmd_hash_md5(struct unit_test_state *uts)
 					  "d41d8cd98f00b204e9800998ecf8427e"));
 
 	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
-		ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
+		ut_assert(run_command("hash -v md5 $loadaddr 0 foo", 0));
 		ut_assertok(ut_check_console_line(
 				uts, "hash - compute hash message digest"));
 
-- 
2.20.1

