Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C109CC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 13:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03B8839C6;
	Wed, 28 May 2025 15:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE1583A05; Wed, 28 May 2025 15:06:38 +0200 (CEST)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fa8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6961F839C1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 15:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6qWw01G6zn8s;
 Wed, 28 May 2025 15:06:36 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4b6qWv304Nz58T; Wed, 28 May 2025 15:06:35 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] dm: core: use {s,u}32 instead of int for
 dev_read_{s,u}32_default
Date: Wed, 28 May 2025 15:06:17 +0200
Message-Id: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkKN2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyML3ZTUsvii1MSU+Apjo/iU1LTE0pwSXXPjVAPLZEvTNDOTVCWg1oK
 i1LTMCrCx0bG1tQDDtmraZgAAAA==
X-Change-ID: 20250528-dev_read_x32_default-73e09c95f64e
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

Out of all the dev_read_*_default functions, only two do not properly
use the type as argument and return type: dev_read_u32_default and
dev_read_s32_default. They both use int instead of u32/s32.

Considering that it's generally not guaranteed that an int is 4 bytes
but also for consistency sake, let's have them use the expected type.

Note that I have not tested this, just stumbled upon that inconsistency
by chance.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      dm: core: use u32 instead of int for dev_read_u32_default
      dm: core: use s32 instead of int for dev_read_s32_default

 drivers/core/read.c |  8 ++++----
 include/dm/read.h   | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)
---
base-commit: e04d137231f2e9e14708a32448c879125b8e308f
change-id: 20250528-dev_read_x32_default-73e09c95f64e

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

