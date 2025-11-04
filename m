Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCABBCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 23:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2599383957;
	Wed,  5 Nov 2025 00:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ctp3RuEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E74A83957; Wed,  5 Nov 2025 00:29:38 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C52839B1
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 00:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A19F14089F; 
 Tue,  4 Nov 2025 23:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762298975;
 bh=UOAa2YD0SqelDQp/DjqPGOapog1OA54xBpnpK+0thD0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ctp3RuEJ12hbPPZ28PQegl24Z6GhGyTocapX1JNaA87081rRon2fL0MpqmquKIXrC
 ll/eaRr4gBQ4t3JfxWV9XZqboAavo8Y5auHnHbkR4mlOJRGoKt/0f9t2j3/ZGL6/RB
 ajfCFled2LhUVLkMDVxfPAOAWeyb3mXaxvhtFfUfszaZNYfjLaeAT/rnVeuWzpperp
 UtI6BJtfVixaIsuvXbdK5WlfL11R8gqwEOM0z419qd0xlrHhAUWVxlDPsMb5QgmyxR
 lIamgm6vyJOnf/f2uI5GZg/zpgsQzIirTbH1UXZfN7zh6q/AlThsrJ0nR+pKJld6H8
 yitluIX0rV55OnrR06+QU3jRcl6oVVXGoq6k00XYVxsmSduMzdNvwLThBD1knpKKrO
 zZgEefuswxfwaxadloRsWuyH52ivH9e0LGRcX1d9eks6gVLT+1Iw0M4UzDWcUEb7Xf
 QkT6mBbutrZq3DnBTjWRDe27ybhGNNasd4WYe4HgukC6pm53t9P2zQDi05RtHSBot4
 EIJsTKdjQ1xFhaaSclxhK1un3EDhD3XScGqRcrE+cTnXRbRTmAbmKBhOZygLholWZn
 NlBUOU+ExwGba+NSV3s4IKY1KXj0ofBgcDnQrSqga1Ew3feKpp3i1drQ7FpuapVAqh
 MZ3pbgds2lXuUBponr1BYCEY=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_driver: correct formatting in efi_uc_stop()
Date: Wed,  5 Nov 2025 00:29:33 +0100
Message-ID: <20251104232933.88528-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Correct indentation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_driver/efi_uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
index 7392c60f0f9..bd46c9f5539 100644
--- a/lib/efi_driver/efi_uclass.c
+++ b/lib/efi_driver/efi_uclass.c
@@ -227,7 +227,7 @@ static efi_status_t EFIAPI efi_uc_stop(
 				goto out;
 		}
 		ret = EFI_SUCCESS;
-			goto out;
+		goto out;
 	}
 
 	/* Destroy all children */
-- 
2.51.0

