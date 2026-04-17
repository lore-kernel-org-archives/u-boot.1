Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EFDF436BF
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 17:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3E584246;
	Fri, 17 Apr 2026 19:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JI4Gx/pr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 486D78425F; Fri, 17 Apr 2026 19:33:53 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 302CA8422D
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 19:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4C11741EFC; 
 Fri, 17 Apr 2026 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776447230;
 bh=V+uGSdW4scYKRcl/8b2pQ9LCwQw8vz7twZrjROuJCiU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JI4Gx/prgxhyHWeCnFddYxECW4uwXpINHWICV/q/Ip2JUHVVhF54fO/2CiJ03l6zr
 m1KnlNnSQMF5qi2n6BJ6GInULo18bZVSWWbndaFKIWn8wK3FkH+X5W13bOIeRxSwVA
 sZ+IdqAt0kS4fTPnnfa/SYZc1ZE3uxlz25UpFyNZzTjqMd4wCNrWxXIwQIVXJBi2A/
 E/OmUglWEeNQu3QDOGTbcqCmR+kp0Z7lK3bwKpR0/LvkdtRNCSdli+pklLWPYeFVgq
 MKGYVXVPyPKHzsy7dGc4zGvSk2CGzbhqzgltG2rqoUh/HmYyNRGwhSkF9P9jj7/A1m
 xD8GiYEmxxddS5/XjwXvi1BlKk+AxCC+hafhaxUqvkMWv3JSWKrxJys9lv2sGsmFdO
 5GmD39qS0fNsL1tQ1tD6blt88ZRqPXAfr4O6K4bQcIEJ5IyQ81Vfc8Kn+CTh2lI3+K
 Vob6SOgkQJRh5/bVob5gR0h/956aybVW2a9AUt3N59PjNRrNSupHS8FCBBy9k7vO4v
 56STHTTHrLvXf6hUn2I4zBp1RVZiynXdMJw5SI7hYIZTFez2OsyfCFJMqsU7rNyThl
 SoO1YwZPGcBcU669yYsSK/VpTiQ+ABscLdK73hNpBqQL6NqPui9tm11jABdTG8TbtZ
 /c3luYlYhnZv/I9+LYt4Hx78=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Mailmap entry for Javier Tia
Date: Fri, 17 Apr 2026 19:33:45 +0200
Message-ID: <20260417173345.6559-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

Javier has left Linaro. Forward to his new email address.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 337dcba5545..df143d7f31b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -67,6 +67,7 @@ Jagan Teki <jaganna@xilinx.com>
 Jagan Teki <jagannadh.teki@gmail.com>
 Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
+Javier Tia <floss@jetm.me> <javier.tia@linaro.org>
 Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
 Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
-- 
2.53.0

