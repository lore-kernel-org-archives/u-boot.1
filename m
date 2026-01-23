Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B45BD6CFB0
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 02:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537678397D;
	Fri, 23 Jan 2026 03:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="QU+QCvZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15EB283B21; Fri, 23 Jan 2026 03:26:11 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809BB839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 03:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 44EE310F123; Fri, 23 Jan 2026 03:26:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769135161;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=BMqiZaAMplV6SeGso32oC77MXzv+7cQ+4u42V1x8uUY=;
 b=QU+QCvZ80+8fepxtoaLAMVONykT251WK83N+8Eq3HkM68n/c/jJbUf0NdosFdCn1IZStE9
 bes2W+w7SlVOkewjxAXj5zyCo8UkdO0g+ZJ6wvjPc06R+4BYknESpJ0kt/ipAMLy+hct+s
 2AsBeejrvBnOLzukc8h50q18dCbu6hZxuUs9SYSuni1GCq08iiu47tjLIOwL3YsBnsY1rs
 zyi4Vy1VQnUqTOri66jrheqqVMbuMOMnSSYALIkBBj2zPJn2Yvyn9j4kdSrZ50U0+ujmlK
 sYjVNmNWFS4AluhOTz3Mu2nZYvhGESkCo8/0/JpFn1CuHBN8tKlphp3dHZSmuQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v2 1/2] lib: sm3: fix coverity error
Date: Fri, 23 Jan 2026 03:25:51 +0100
Message-Id: <20260123022552.100884-2-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260123022552.100884-1-hs@nabladev.com>
References: <20260123022552.100884-1-hs@nabladev.com>
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v2:
rebased series to
commit 6b2d05748cf ("Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx")
added Acked-by from Ilias

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

