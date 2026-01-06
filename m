Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E89DC47BFB
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9EE483F9A;
	Tue,  6 Jan 2026 15:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="gG06yqxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBAD83F9B; Tue,  6 Jan 2026 15:14:18 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A2E83F98
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 15:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3184F10C611; Tue,  6 Jan 2026 15:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1767708856;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DehcKq07ktV4hJc92cfsEf37/n0t6Mzr+A2XfHNH8HU=;
 b=gG06yqxYAO5X/7WFymsj8VuRvVJkJR4vITCKRT6ZK2Ubzmv/Te9vDDvSDBr5Tu1Sxz23DX
 LFgqk/hxB7aZhhO/iTWCZ05AnrFfCCG+3jVr9sn7/mo302yJs7EzZk/y6U5TnsJ4bCPjvV
 EFanAhVPk5VwVJPmPveihK1Y+t2LBrvhX8fj0A+DQMuEx1A9xdMZ1keDO/0z3FYZbb7GWN
 APUXb5SeppYHJ2SnuMCeH61ywKEG3TCc9Ua5EfF9VpoIHNvEp5JPXh5d+H3qA3LLwwTl2z
 BmRTnddD5mDfbTNVwGeQMyk+cQ85K2npNW0T55g9Lf/sL3X/FObo2RTk+o0ZJw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v1 1/2] lib: sm3: fix coverity error
Date: Tue,  6 Jan 2026 15:14:04 +0100
Message-Id: <20260106141405.82637-2-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260106141405.82637-1-hs@nabladev.com>
References: <20260106141405.82637-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Coverity scan reported:

CID 449815:         Memory - illegal accesses  (OVERRUN)
Overrunning array of 64 bytes at byte offset 64 by dereferencing pointer
"sctx->buffer + partial". [Note: The source code implementation of the
function has been overridden by a builtin model.]

In line: 252
   memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial);

The respective line should be:

memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial - 1);

as partial gets incremented by one before.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 lib/sm3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sm3.c b/lib/sm3.c
index 2a4e825481d..05880099703 100644
--- a/lib/sm3.c
+++ b/lib/sm3.c
@@ -249,7 +249,7 @@ void sm3_final(struct sm3_context *sctx, uint8_t output[SM3_DIGEST_SIZE])
 
 	sctx->buffer[partial++] = 0x80;
 	if (partial > bit_offset) {
-		memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial);
+		memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial - 1);
 		partial = 0;
 
 		sm3_block(sctx, sctx->buffer, 1, W);
-- 
2.20.1

