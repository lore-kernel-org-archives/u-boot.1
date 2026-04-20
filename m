Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17331F5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3F7844D4;
	Tue, 21 Apr 2026 00:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kvZBGieF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E52844F0; Tue, 21 Apr 2026 00:08:09 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C717E84496
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 210383F0C6; 
 Mon, 20 Apr 2026 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722886;
 bh=N/bkcD/YeP/Ul0mqN9souw19L+AtovwSxKDd77VVboY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=kvZBGieFtYpbblLfM0ZMCrXMfTr42GgSJIDQ5gPhrMo27F1hfaO2zzEpygmagG1KM
 LrjKhgvRa9/F1n0DI40gxpAbL7LHcIPMF+P9+oXZ9zO8/nUGFX4CxLoUvUEGQhDX59
 0KRzVU1zMJ/XsreLfptijM0xfo0epxbeo3tMbdcWdr7MVW+btrhcLx3z9+7wZCjaF2
 TFzh8Cz9uymHaeP46+gAU4iHAVKh6m4+7CUoHWJPaSSla0QhNe4oUQ2dNhl163Tyka
 gov1c7eztnXsRseeB/OuT3T/mFwGBskwXLdPEOj0T/tJTccUBsQzi3qkbH9RNMtKOm
 4F7++Ds4GECyBmA4nQH6gFtOUYnoxhuVPvKV/FybkoQ8RyvVkRTqxRBD6nfkIYLqLQ
 SgHG7Jrbhg6nLmniShb6r6p0KAqu4/etYEUumdxQ8ONYIiu/K+SE+NQ016cDNgbSCP
 5mCAQaNSTCF4Z0ZwuCSSaOd3MYmVxXJ8cHf8Bu9UcL93AJIy4gbRty/cpig9CM88uk
 +qwxMiXdSOgyzCfdkzriC7QA7+RmISynVWo0uhwTVzSgTY4nTEL8J/ksxp/7we/8Yd
 Jm1F7bi3uKpv3Z0DW/vd0EVztjaZdGzYPaVj5YdoZnNZfGW48fmRHWLsoKxSjkXOxV
 YD6pGjvPudnbGYDKm9jHFB58=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] acpi: handle duplicate tables in acpi dump
Date: Tue, 21 Apr 2026 00:08:00 +0200
Message-ID: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

Of some ACPI tables like SSDT multiple instances may exist.
Allow to print each of these with the `acpi dump` command by
adding an index parameter.

Heinrich Schuchardt (4):
  acpi: add index parameter to acpi_find_table
  cmd/acpi: add optional index parameter to acpi dump
  test: consider index parameter in acpi_find_table test
  doc: document index parameter of `acpi dump`

 cmd/acpi.c                       | 19 ++++++++++++------
 doc/usage/cmd/acpi.rst           |  8 +++++++-
 drivers/serial/serial_coreboot.c |  2 +-
 include/acpi/acpi_table.h        |  3 ++-
 lib/acpi/acpi.c                  | 21 +++++++++++++++-----
 test/dm/acpi.c                   | 34 ++++++++++++++++++++++----------
 6 files changed, 63 insertions(+), 24 deletions(-)

-- 
2.53.0

