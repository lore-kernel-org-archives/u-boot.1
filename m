Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0B3D3E787
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 10:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D30E88DB2;
	Thu,  7 Nov 2024 11:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DZOsaPyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2310688CBB; Thu,  7 Nov 2024 11:39:30 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F52A8920B
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 11:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 690683F192; 
 Thu,  7 Nov 2024 10:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730975967;
 bh=7e98aAF9SI42pEJGWIsHZt3aDQekazXdqfvPyURvLTc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=DZOsaPyTkQh8B/vKAKgEwWSX9ASo2CVdcCISAffHY7S0wzvU4lY0n/AifviHHioRO
 dddmsdoA/Vsy3ypMqI1PbflgwlMUg0Hf9AHtLBIsBGAjLST+1YDepV/0ZMUoFWZWT3
 pPmL0NH+qvLKPRENx+qCM4t3Ifjqp15WM5QfDvDAjTTi/vWbSic8bKGrYyyjew29k+
 BYXpzbqf8IHZmA3RBEZBILiqfTz+QsSp22Xpxe1Jrj3PceTPjbAGxI3s9rU3wYUEuG
 IfjBaWy5J53SIc1naht4HvlddPeM+rjsG2AzgKougPJyYns5BTsws/4s72HYna6rRP
 zgXY6hU4/wiVg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: fix regular expression in test_spi_negative()
Date: Thu,  7 Nov 2024 11:39:22 +0100
Message-ID: <20241107103922.46907-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
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

Escape sequence \s is only allowable in raw strings.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_spi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index caca9303271..44e54738dd0 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -695,7 +695,7 @@ def test_spi_negative(u_boot_console):
 
         # Read to relocation address
         output = u_boot_console.run_command('bdinfo')
-        m = re.search('relocaddr\s*= (.+)', output)
+        m = re.search(r'relocaddr\s*= (.+)', output)
         res_area = int(m.group(1), 16)
 
         start = 0
-- 
2.45.2

