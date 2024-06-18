Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F3C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 06:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EE888431;
	Tue, 18 Jun 2024 08:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cgtXX7e7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA988843A; Tue, 18 Jun 2024 08:16:49 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E498840E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BD2AD3FC08; 
 Tue, 18 Jun 2024 06:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718691406;
 bh=96Jc42RfPZloS8EG6bkN99zEihaF1nh/J9MsDL2NZrE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cgtXX7e792q3JUqhfov1JiV8ydS/gtnlU6U3NEMoEBBICeBZeheVEbPMEZ/ATexZ2
 8mlpq3Oey+ROLlER0RiOkj40dRSYjfMg8/0IK9pJaG32wfNaY2jE1hGyUoNTxatHkQ
 yVGWtrTXveqAJSjWIKf9r3YJBYwEAe1q9uP2SjawiKK9trBINRG65aEVuL2jSh73zH
 HqpFfRBUvCtCihs/zX1KixACD3T1dQzVsappQvEvHs5k/jxIVDZKSFAPn94ExaZMbf
 O46kzT6rltXAREXOjp8w3LV6EVTDN3ZbX/Y22Gg/t/Xn3LjV7JSwcum0hGo+utgzpk
 pi2kNMpjvFW3Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: FIT links in develop/uefi/uefi.rst
Date: Tue, 18 Jun 2024 08:16:44 +0200
Message-ID: <20240618061644.11677-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Correct the links to the FIT documentation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/uefi/uefi.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0389b269c01..ea70dcbda86 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -72,7 +72,7 @@ bootm command. This feature is available if U-Boot is configured with::
 
     CONFIG_BOOTM_EFI=y
 
-A sample configuration is provided as file doc/uImage.FIT/uefi.its.
+A sample configuration is provided in :doc:`../../usage/fit/uefi`.
 
 Below you find the output of an example session starting GRUB::
 
@@ -96,7 +96,7 @@ Below you find the output of an example session starting GRUB::
     ## Transferring control to EFI (at address 404000d0) ...
     Welcome to GRUB!
 
-See doc/uImage.FIT/howto.txt for an introduction to FIT images.
+See :doc:`../../usage/fit/howto` for an introduction to FIT images.
 
 Configuring UEFI secure boot
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.43.0

