Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D83C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 00:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43D5D8798B;
	Thu,  1 Feb 2024 01:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NjDWkfbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF528798B; Thu,  1 Feb 2024 01:20:36 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1F18785E
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 01:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2E7833F6F3; 
 Thu,  1 Feb 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706746830;
 bh=hLBRAXRpMmcQrj/cJC2SDhP7aW2Y3C1qq10qJutscZ0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NjDWkfbgF1SGIParBcUqa/+qnhKIwMUMvQTprOMn1oXTv0m6Ak9KHzH/66bkz+cfO
 tHAxZwqwPAgM7OhUN7wreyJWitjmHJFof3HT5Co2oEK59nLWlFaGuRxE02/Qt8kedU
 vjAj28cHSho/mznJbAfV2moZtMLT6WpHWo0QYY5l2lu2mBkpK7ZZNVWSbsvLQz414y
 T4wMA/ERHnT5SG0qy/zy9kdAp92lhe1Ps3BddwKoRUioorCzeFyX041kt76SwfrF4S
 vzxljR11KxpGAJBMG8b7qilOFotJkKA0vIxhYotEZ+alVYLqbhbmGjJx7+FoxAId4V
 bisbSh3m9X2XA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] smbios: correct handling of table size
Date: Thu,  1 Feb 2024 01:20:19 +0100
Message-ID: <20240201002022.11258-1-heinrich.schuchardt@canonical.com>
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

* In the smbios command show the orrect table size for SMBIOS 2.1
  entry point.
* The SMBIOS 3 entry point has not field for the maximum structure
  size. Avoid to determine it needlessly.
* Name Structure Table Maximum Size field in the SMBIOS 3 entry point
  structure accordance to its meaning.

Heinrich Schuchardt (3):
  cmd: smbios: show correct table size for SMBIOS2.1 entry point
  smbios: do not determine maximum structure size
  smbios: correctly name Structure Table Maximum Size field

 cmd/smbios.c                | 8 ++++----
 drivers/misc/qfw_smbios.c   | 2 +-
 include/smbios.h            | 2 +-
 lib/efi_loader/efi_tcg2.c   | 4 ++--
 lib/efi_loader/smbiosdump.c | 6 +++---
 lib/smbios-parser.c         | 2 +-
 lib/smbios.c                | 9 ++-------
 7 files changed, 14 insertions(+), 19 deletions(-)

-- 
2.43.0

