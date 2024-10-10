Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849E0CF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E14F58910B;
	Thu, 10 Oct 2024 07:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="h6pk9W0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF69890DF; Thu, 10 Oct 2024 07:55:59 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2051A89023
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202410100555563d16ba5a7594d401e3 for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7w1mqQws2jHAteuxILou+N2K8bKbQWWcFJuN3eYmP/0=;
 b=h6pk9W0GqRNLa2jv+x+WV1SYUA4D3HpK/SBPOdzFaXXxe/HEQILkYCDWgByUhstkYFWHwQ
 EtMTVGrGf4YQ/szn83Qz+mHvZm401KD0LykHdQpHKwpEJhAYxNTQJA3FP/Ps6TxeTMhV0rAR
 0mlt+la+rYUWzKCVhWF9l8vw+a6Vc3jpobQX7SRQLtNhlPg/M5w6+jKrdWGoOFUp1J9X4Vm6
 DgDsT/yXvKCaiGyzZqybk3vI5EcFHh1ykjFuYAll9mKoFOdtJLxrfjcGa/zZPkfawaOlOTMm
 LV3VA9DibftEeWr4T5S040WIUKXDK5h/VXXxxmLy/7DU6LQk2D7p9onw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 01/11] board: siemens: iot2050: Fix mistake in list of
 writable env vars
Date: Thu, 10 Oct 2024 07:55:45 +0200
Message-ID: <f1a4ce2a80a6d49863717f5f4cb04fd48399b304.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This prevented to set m2_manual_config - as evaluated by
m2_connector_setup - under strict configurations for secure boot.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/configs/iot2050.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
index 94a9c767882..0f92e0d25dc 100644
--- a/include/configs/iot2050.h
+++ b/include/configs/iot2050.h
@@ -39,7 +39,7 @@
 #define CFG_ENV_FLAGS_LIST_STATIC					\
 	"board_uuid:sw,board_name:sw,board_serial:sw,board_a5e:sw,"	\
 	"mlfb:sw,fw_version:sw,seboot_version:sw,"			\
-	"m2_manuel_config:sw,"						\
+	"m2_manual_config:sw,"						\
 	"eth1addr:mw,eth2addr:mw,watchdog_timeout_ms:dw,boot_targets:sw"
 #endif
 
-- 
2.43.0

