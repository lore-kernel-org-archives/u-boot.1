Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E631C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 11:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736288842A;
	Wed, 19 Jun 2024 13:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F9D88431; Wed, 19 Jun 2024 13:33:42 +0200 (CEST)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F420A8840C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 13:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W41hz4ZdjzjDj;
 Wed, 19 Jun 2024 13:33:39 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W41hz0LYszJq2; Wed, 19 Jun 2024 13:33:38 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Jun 2024 13:33:28 +0200
Subject: [PATCH] scripts/Makefile.lib: remove bootph-some-ram property from
 VPL/TPL/SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-fdtgrep-some-ram-spl-remove-v1-1-7d4a3df7f280@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAfCcmYC/x3MQQqDMBAF0KvIrDtgpAjpVUoXTv3RgcaEmSIF8
 e4NLt/mHeQwhdOjO8iwq2vZGsKto/c6bQtY52Ya+uHejyFymr+LobKXDLYps9cPG3LZwTJGkRh
 SEgi1oRqS/q79+TrPP/2L0CltAAAA
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The property isn't useful in VPL/SPL/TPL as it is only for U-Boot proper
pre-reloc, which has its own DTB.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 62f87517c09..3e68d5aa803 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -673,7 +673,7 @@ quiet_cmd_fdtgrep = FDTGREP $@
 		-n /chosen -n /config -O dtb | \
 	$(objtree)/tools/fdtgrep -r -O dtb - -o $@ \
 		-P bootph-all -P bootph-pre-ram -P bootph-pre-sram \
-		-P bootph-verify \
+		-P bootph-verify -P bootph-some-ram \
 		$(migrate_all) \
 		$(addprefix -P ,$(subst $\",,$(CONFIG_OF_SPL_REMOVE_PROPS)))
 

---
base-commit: 01a5d7547ed3a51a8ac5837c31a150f85bc475f8
change-id: 20240619-fdtgrep-some-ram-spl-remove-b69bb91ffbeb

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

