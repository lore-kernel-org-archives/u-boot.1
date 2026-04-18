Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EDDF436BC
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 06:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7783F83BC8;
	Sat, 18 Apr 2026 08:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F/fpyKyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7A083FF5; Sat, 18 Apr 2026 08:32:20 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9EF83B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 08:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 017BF3F0C6; 
 Sat, 18 Apr 2026 06:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776493938;
 bh=D1d/7WUqxje3mhUrIZnjGwIC1g2onBLL21mnb6Tm+vA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=F/fpyKyXwp2b1ciIzsA65h4yfDVXIW//apoF6xtr9XWT5JXWhTUgAfj1ianlDIbJM
 PUCXISkXGNiqz0t4TTRSbrOW14Qf0+Dq4RuwFOGsF3l5zo0KJ8iE+NvaDh1dGRFOSm
 PYiqU02tkbCJuNxBswyY3AljfGPKe9rih5enT+HOGHKX27oMhahnopAv1CWARBZn3M
 ujDKpPohRZnBGCYYpxda+NcdCMoq3ep5SDbvR510z52nqaQ6pZSw7j75vl6d9sJRPf
 WxKMvmIZCV1K39RpOVa7Y633W3nLXcf0mYkG5H67vSAXv+sqylfa0XMh4EelE+IM52
 vJ+1IGSQHJjMGLTE11I1mJm1YhGSgoFMj8k+VOXGN1qLCvwEf6znkYBnYo0UjC6FHw
 9jr+yE1rAJYEhS0B7vs0IVU/rddFBNDbpj+8dmmndrusQyP2Rur8R4M4IMMXolTMxa
 G7n8sxHZk33Dk48H+opnvOZoruILJIbbSsZEBE7siNc79zm8nMC35wqUU4teGYxC6f
 JHxioiDnsOts1GnskBdZ4mUTyq/W0vzcEknj5EnnjPXm6/oX9IAoF6UaQan2uWna7L
 J/ZTYQhNWKroX3cI2rF8ldqvfvW9IgbQYP1IG5rBsGzdcU2/5MnMmxKO0Oc73nhloV
 YZlpvV22fmzAorzUrCVPIVFY=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools/asn1_compiler: avoid -Wdiscarded-qualifiers
Date: Sat, 18 Apr 2026 08:32:13 +0200
Message-ID: <20260418063213.110024-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Building with GCC 15.2 results in warnings:

    tools/asn1_compiler.c: In function ‘tokenise’:
    tools/asn1_compiler.c:442:37: warning:
    assignment discards ‘const’ qualifier from pointer target type
    [-Wdiscarded-qualifiers]
      442 |             dir = bsearch(&tokens[tix], directives,
          |                 ^

    tools/asn1_compiler.c: In function ‘main’:
    tools/asn1_compiler.c:632:11: warning:
    assignment discards ‘const’ qualifier from pointer target type
    [-Wdiscarded-qualifiers]
      632 |         p = strchr(grammar_name, '.');
          |           ^

bsearch() is defined as

       void *bsearch(size_t n, size_t size;
                     const void key[size], const void base[size * n],
                     size_t n, size_t size,
                     typeof(int (const void [size], const void [size]))
                         *compar);

* Use the correct type for dir.

strchr() is defined as

        char *strchr(const char *s, int c).

* Use a conversion for the assignment to p.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/asn1_compiler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/asn1_compiler.c b/tools/asn1_compiler.c
index 03fb7e03758..c2ca467e18f 100644
--- a/tools/asn1_compiler.c
+++ b/tools/asn1_compiler.c
@@ -409,7 +409,7 @@ static void tokenise(char *buffer, char *end)
 
 			/* Handle string tokens */
 			if (isalpha(*p)) {
-				const char **dir;
+				const char * const *dir;
 
 				/* Can be a directive, type name or element
 				 * name.  Find the end of the name.
@@ -629,7 +629,7 @@ int main(int argc, char **argv)
 		perror(NULL);
 		exit(1);
 	}
-	p = strchr(grammar_name, '.');
+	p = (char *)strchr(grammar_name, '.');
 	if (p)
 		*p = '\0';
 
-- 
2.53.0

