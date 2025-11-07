Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0CACCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529E583D9C;
	Fri,  7 Nov 2025 14:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="R6yWznTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8756683D62; Fri,  7 Nov 2025 14:03:09 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA41A83D7A
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2zkc317Jzkmn;
 Fri,  7 Nov 2025 14:03:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762520584;
 bh=QdQy3MsATpssS6QiiOjsFzccpEczdjATy7HAShmFXT4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R6yWznTHs1ZFboSXqvHwXu7pTXnyG5HTE9f4Ra+D7uIvtUH8m19IonPMkvyEyxh3W
 z497J7GW/eYnr+fan4u1/QlCx6sby2f598zWNN55IcSbKYRxiyjBEGIUTO1emGo0UO
 Pv/WS0o1YZOIepf/Mv03IcoAHCfxbjS/zliHHDFw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2zkb70XQzSS0; Fri,  7 Nov 2025 14:03:03 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 "Andrew F. Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/6] mach-k3: security: Propagate verified image addr
Date: Fri,  7 Nov 2025 14:01:03 +0100
Message-ID: <20251107130216.3084134-5-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107130216.3084134-1-dev@pschenker.ch>
References: <20251107130216.3084134-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Philippe Schenker <philippe.schenker@impulsing.ch>

The ti_secure_image_check() function may relocate the image during
authentication, updating image_addr to point to the verified location.
The caller was not updated with this new address, causing it to
reference the original unverified location.

Update p_image with the verified image address after authentication
to ensure subsequent operations use the correct location.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>

---

Changes in v2:
- Fixed pointer cast warning by using uintptr_t intermediate cast. The
  direct cast from u64 to pointer caused a -Wint-to-pointer-cast warning
  on 32-bit ARM R5 targets. Using (uintptr_t) as intermediate cast is
  safer and architecture-aware, ensuring proper handling on both 32-bit
  and 64-bit targets.

 arch/arm/mach-k3/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index 3468a370a455..c7017bba99ab 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -119,6 +119,8 @@ void ti_secure_image_post_process(void **p_image, size_t *p_size)
 	 */
 	*p_size = image_size;
 
+	*p_image = (void *)(uintptr_t)image_addr;
+
 	/*
 	 * Output notification of successful authentication to re-assure the
 	 * user that the secure code is being processed as expected. However
-- 
2.51.2

