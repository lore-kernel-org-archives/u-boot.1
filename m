Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AEBCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 09:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B90F8362A;
	Thu, 23 Oct 2025 11:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="FwPeiUtJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20E383693; Thu, 23 Oct 2025 11:47:36 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03EE783303
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 11:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4csh5y5G3Sz9ND;
 Thu, 23 Oct 2025 11:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1761212854;
 bh=nmHvMApR1byolxykYXpclAu3RTjxTv4PPuSaEWkc7tU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FwPeiUtJAzv9Icf0rvPDKjVR1feH745qLXS+ciW9o93wKjnMyzJfCBLJaMPipJp4B
 pfiN58MqS/OM9Q3wn8udBLgjtc5KXtfPabproMLIl2aUX68v9bLTPhNGq/vXPDjchX
 QADhr41wdT/v5hqH9lnMQQyMOoVbC42sY8uZoecQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4csh5y1TmzzdF8; Thu, 23 Oct 2025 11:47:34 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 "Andrew F. Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 4/6] mach-k3: security: Propagate verified image addr
Date: Thu, 23 Oct 2025 11:46:22 +0200
Message-ID: <20251023094631.16742-5-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023094631.16742-1-dev@pschenker.ch>
References: <20251023094631.16742-1-dev@pschenker.ch>
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

 arch/arm/mach-k3/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index 3468a370a455..9255505a7944 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -119,6 +119,8 @@ void ti_secure_image_post_process(void **p_image, size_t *p_size)
 	 */
 	*p_size = image_size;
 
+	*p_image = (void *)image_addr;
+
 	/*
 	 * Output notification of successful authentication to re-assure the
 	 * user that the secure code is being processed as expected. However
-- 
2.51.1

