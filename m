Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEB1C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 06:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90AE84AE7;
	Wed, 15 Jul 2026 08:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qmyu4Oup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C63C84AEB; Wed, 15 Jul 2026 08:46:46 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B8684ADD
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=k3/L1j7rnMNYyYbgLXXRPyBQfbTxujFcVKKpEw7z5UI=; b=qmyu4OupwcqeUn1zdjzYikYRzV
 ZyS2quaODmes5BhyKLz1c0ha02XCTTGqfjrL7Lp2lJc5GQDWbf670oiNQRuxve/GygviMr5V3/zVl
 FmArjYxieH+V5aoYRjwIyAYgUTOFcF1t98HFxECe7fGglaHSyutcKbSQYf80373laD9h4QsFh0GGO
 /As6cW8IOPYtTTOh9jnxyyuJRqSvlWGkkDMJYWrwz0XUOZ2WnWNqec6F26c9eRcxlmgUkHJ/RY4vX
 hdIp8+Vk6RXgzdMvauIRVrpfZsV/Tvm3JkMUUhI4BoJZSJn/Rh6l3o3m3ED59kWyI9pCIJmiXgsPT
 iF8fdT9w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjtOG-000BZf-0h; Wed, 15 Jul 2026 08:46:44 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjtOF-000Orn-2r; Wed, 15 Jul 2026 08:46:43 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>,
	Tom Rini <trini@konsulko.com>
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 u-boot@ew.tq-group.com, u-boot@lists.denx.de,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH] configs: tqma6ul: add support for redundant environment
Date: Wed, 15 Jul 2026 08:46:15 +0200
Message-ID: <20260715064618.462554-1-Max.Merchel@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Activate the redundant environment and set the required offset.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 configs/tqma6ul_common.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/tqma6ul_common.config b/configs/tqma6ul_common.config
index c076fb5d295..6b1fecb9071 100644
--- a/configs/tqma6ul_common.config
+++ b/configs/tqma6ul_common.config
@@ -18,6 +18,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x88000000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x110000
 CONFIG_IMX_MODULE_FUSE=y
 CONFIG_SYS_MEMTEST_START=0x82000000
 CONFIG_SYS_MEMTEST_END=0x83000000
@@ -76,6 +77,7 @@ CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_ROOTPATH="/srv/nfs"

base-commit: 8dbe57ba648648c4897717cebbc4505a8e0a8c23
-- 
2.43.0

