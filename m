Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBF6D1CDA0
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239C188F28;
	Tue, 22 Oct 2024 08:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Rer3y7kk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59CD88FA8; Tue, 22 Oct 2024 08:04:35 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4430E88ECB
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20241022060431a516bb2e1e4ca32ff7 for <u-boot@lists.denx.de>;
 Tue, 22 Oct 2024 08:04:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7w1mqQws2jHAteuxILou+N2K8bKbQWWcFJuN3eYmP/0=;
 b=Rer3y7kko512EEBZ3fN3z/pa9byz/8/oyhr1uv30CVziYbD0gDlA4bZO30H9JGmzqqry6w
 zhu/T8t+yWQX9sIl79UKOqWCgTflLq+cLQzOd9tPd3PQNRuGHisgxfJyUADQEkF5qEqGYijm
 fTnlI2vXINb1y2tmkULiOrot7CmDdBVGZHKzeRJ+9BYWt5L/Fg+vrCrTeCLwk8UvKChOt5MD
 IHxjkJWbMbALGh47bJAvjQO6oUiTt8hiqgFzAbbKijn3wkWgbK7x/n36Ge/xQA7pSbGjLr+D
 ZIuFFgR7P9dgKEIToNZum78dWRuYigXC/RA7YYUTElwkVXKtYoWwnVGA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 01/13] board: siemens: iot2050: Fix mistake in list of
 writable env vars
Date: Tue, 22 Oct 2024 08:04:18 +0200
Message-ID: <a7fa22f8d9f1844a0a31579c3444e4ef1cae2a62.1729577070.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1729577070.git.jan.kiszka@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
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

