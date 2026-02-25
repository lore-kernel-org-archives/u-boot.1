Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B4EFD3764
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 444D884057;
	Wed, 25 Feb 2026 16:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB81840AB; Wed, 25 Feb 2026 16:06:13 +0100 (CET)
Received: from pidgin.makrotopia.org (unknown [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE1A984057
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vvGQm-000000004uA-0dRy; Wed, 25 Feb 2026 15:04:04 +0000
Date: Wed, 25 Feb 2026 15:03:57 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 u-boot@lists.denx.de
Subject: [PATCH] tools/atmelimage: add const qualifier to fix compiler warning
Message-ID: <b040fc218c68db39b51c9f8d7b180ddfc332d4e6.1772031799.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

tools/atmelimage.c: In function ‘atmel_find_pmecc_parameter_in_token’:
tools/atmelimage.c:64:31: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
64 |                         param = strstr(token, "=");
   |                               ^
cc1: all warnings being treated as errors

Add 'const' qualifier to variable 'param' to prevent build failing
due to -Werror.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 tools/atmelimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/atmelimage.c b/tools/atmelimage.c
index 6a2d9d8feab..770f7a0de4e 100644
--- a/tools/atmelimage.c
+++ b/tools/atmelimage.c
@@ -55,7 +55,7 @@ static const char * const configs[] = {
 static int atmel_find_pmecc_parameter_in_token(const char *token)
 {
 	size_t pos;
-	char *param;
+	const char *param;
 
 	debug("token: '%s'\n", token);
 
-- 
2.53.0
