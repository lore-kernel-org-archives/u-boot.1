Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F96E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 02:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C63D8006E;
	Sun, 15 Dec 2024 03:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pGd7uufS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A1280098; Sun, 15 Dec 2024 03:37:53 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8AA08006D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 03:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DEB1C3F387; 
 Sun, 15 Dec 2024 02:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734230270;
 bh=dEKWaAgFYyvcc8yXvAvxE0TC4U6sMv61fovcYv1xDWY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pGd7uufS6oeMzVvi4eaemUGOeZikl6UCM4YVzKEwXtfCzm6ktvc/LrcCq8fno4Vou
 UaxbBe+bT3zwGodx1jufm1pEc+Am+E5RClJfSzBWFxnjo3Z4PyBKUL02c52LuzcKP1
 timklJHLVk3K07HnwfSs4AcyqP9u+/2Sy6mE9W+uJXOVoh6dJRsNfCDNFKBZsvYivj
 uPVuMfK0B5LPweRdLZujC0LLHWaNUkaZpTjLQ3mPnbIAgPfudkq2qAu8E5ekwPnyLW
 FYqBtHplBU8/dSJ+jgVeTBhpfUpTny6amS1uVA2k9sVXuJ5AR3aXztPGmb7z4+mFsi
 eJjDFfDIhECCg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] scripts/spelling.txt: add GPL-2.0+
Date: Sun, 15 Dec 2024 03:37:30 +0100
Message-ID: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The correct SPDX identifier for the 'GNU General Public License v2.0 or
later' is GPL-2.0-or-later.

Checkpatch.pl uses the misspelled words from spelling.txt both as keys of a
hash and as part of a regular expression. For usage in the regular
expression special characters like the plus sign need to be escaped.

Heinrich Schuchardt (2):
  scripts/checkpatch.pl: allow special characters in spelling.txt
  scripts/spelling.txt: add GPL-2.0+

 scripts/checkpatch.pl | 2 +-
 scripts/spelling.txt  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.45.2

