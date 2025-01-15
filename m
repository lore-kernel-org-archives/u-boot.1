Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558F7C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 16:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBE680657;
	Wed, 15 Jan 2025 17:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="RHy/jCOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AFBB806DD; Wed, 15 Jan 2025 17:16:30 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76F98033D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 009B71484066; Wed, 15 Jan 2025 17:16:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1736957786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/MvyH4WFSAbgfTBNQUMiJnX88BdV/M8j20w1Xhzwi4Q=;
 b=RHy/jCOL3N8+tOM0w0SKOaFklC9MKk5WTNnMXlinWsoHCFb1Ahs/oqhqX/YFNRQmiWQhWC
 OW3zpqbWgITq0+/9NxA5CaarLHGMkCIU+HKYkftAXYbYH6lb3YphXt3hEs7Dyv0TlqPSoD
 wCcKk5kb8nZnz2PU8VPhIvvZTkm2nA41JRxg/TgR+FBkEUVuCc2KOkWHFTvIwCcqCdABsP
 he2b8xGtKS5E6enY59NczZkg/4unlEEsmahT+7B976awzarDnuwGKBfTk6uNrNOiZ75Xm3
 MMwsZGwGgGSwgsbvyjxinQLmq3Ol3BHG1ToLaaVqc4XkObS624TsKMSoXkEODA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 0/2] spi: Collected fixes
Date: Wed, 15 Jan 2025 17:16:19 +0100
Message-Id: <20250115161621.1551826-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

two patches for header issues I came across when working on (Q)SPI
drivers for atmel boards.

Greets
Alex

v1:
- implicit, not a series but a single patch no one reacted to
- Link: https://lore.kernel.org/u-boot/20241218160947.681253-1-ada@thorsis.com/

v2:
- resend patch 1/2
- add new patch 2/2

Cc: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>

Alexander Dahl (2):
  spi: atmel: Really drop atmel_spi.h
  Revert "mem: spi-mem: add declaration for spi_mem_default_supports_op"

 drivers/spi/atmel_spi.h | 86 -----------------------------------------
 include/spi-mem.h       |  3 --
 2 files changed, 89 deletions(-)
 delete mode 100644 drivers/spi/atmel_spi.h


base-commit: e26a9ac4c6900cac2fa043ac50a3a3c038f4505d
-- 
2.39.5

