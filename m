Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5435BCED240
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 04:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F0083C93;
	Tue, 18 Nov 2025 05:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="fAWVKn0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF9C83C32; Tue, 18 Nov 2025 05:31:32 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95E283CAA
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E50B910AEEF; Tue, 18 Nov 2025 05:31:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763440290; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=smSmecxY8WAtnHEm+lbQmzTuu84KMk22Zdkwy01xDEI=;
 b=fAWVKn0nQ93bmfxRomPMYIE8uMYskkh/S77bmy4eafClvssvQ8SwTxAdVLFWg2981sdPT/
 i77c1sDBzIRILqCh2b6O8nvgmH1lPB4s4IhwWinvBigtS68KEHdYsB4jWQf/nc6XzEPbuV
 VRUTQrpiyuHYiM6lJV8OkeTH4Sc3eJjdPSeaMBz1+0Aaz6D/3cjNwbkRwhTFkZFfGSzHXx
 StXDe/CRAc9rbQs/sdc/epbvXNxdsfxE480YDbwZivdfU6R+JJGdyoNACz8MDtvOZLUEMK
 eEhIkRGecgVUaD574+kkf1MOH6rKqNAkjHaNirAjY4bM5EMBQWFE+THBGgkehg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 6/6] test: cmd: fix a typo in md5 test
Date: Tue, 18 Nov 2025 05:30:42 +0100
Message-Id: <20251118043042.27726-7-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251118043042.27726-1-hs@nabladev.com>
References: <20251118043042.27726-1-hs@nabladev.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

Changes in v3:
Added Reviewed-by from Ilias

Changes in v2:
Added Reviewed-by tag from Heinrich

 test/cmd/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/hash.c b/test/cmd/hash.c
index ced18319f34..99895982f67 100644
--- a/test/cmd/hash.c
+++ b/test/cmd/hash.c
@@ -39,7 +39,7 @@ static int dm_test_cmd_hash_md5(struct unit_test_state *uts)
 					  "d41d8cd98f00b204e9800998ecf8427e"));
 
 	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
-		ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
+		ut_assert(run_command("hash -v md5 $loadaddr 0 foo", 0));
 		ut_assertok(ut_check_console_line(
 				uts, "hash - compute hash message digest"));
 
-- 
2.20.1

