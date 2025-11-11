Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59847CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 05:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB99A83B05;
	Tue, 11 Nov 2025 06:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="JwDSKcpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5815883B27; Tue, 11 Nov 2025 06:48:45 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E685D83B1E
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2A2D310A4E4; Tue, 11 Nov 2025 06:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762840122; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=x1bQ4HgSnn2ZLtLY7gF+p08IlVidxr8OjqO9KQCYaGI=;
 b=JwDSKcpy+L0n0oTydxPw+DvM1AZil36kS7+BLseh7DXmEof6kkjGNiCe04qvGUcNbp/lkY
 8+sPpP2m2w1yyegK1Xq747qcZeQoA1BsbvDJcZW2Rj3B61mGPSeKzW71GRWHD80ms6+QaQ
 inckUpdAqE+CXOdgUmowK8GVgMMfNBVzl3hLby7QlLPqmc4caDCOldsXpMoagNGDF9BkI0
 i42gf2KQWuqMInRMc9x/vacrICw077vT//FGyxua7GOlgWteTCX+I+hcXd8Ezm2cXUukvC
 nP1f/4RUGI1TxLbMUfEWCCKopswiXfTNiOWUXerJIK/NzzHW8IfhC24ZcmcSjw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/5] test: cmd: fix a typo in md5 test
Date: Tue, 11 Nov 2025 06:48:12 +0100
Message-Id: <20251111054813.1966-6-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251111054813.1966-1-hs@nabladev.com>
References: <20251111054813.1966-1-hs@nabladev.com>
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
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

---

Changes in v2:
Added Reviewed-by tag from Heinrich

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

