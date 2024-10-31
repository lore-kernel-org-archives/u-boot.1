Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1FDD767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF921892C6;
	Thu, 31 Oct 2024 18:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Epmea5KI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29E7892E6; Thu, 31 Oct 2024 18:54:08 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C587892C6
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1730397245;
 bh=JYHIALV9lOKnNKNoCLywLi2cAfB/poVXozvosK+Kcv0=;
 h=From:To:Cc:Subject:Date:From;
 b=Epmea5KIAUcZVI96khaG2XkpQv5M85VE97NaScjeey4DZBHiHBXTlfG4YZVgWJPLL
 Kd32ZKWC1zzCakcPnq+cCisg4ggwnB0AEx7i+3js3XLRSPjvLgL/bFafGk37vgvg2K
 q+/JgyH5tV2jT3qEMphMdc0qjslQZaqr1RrXt+HmHDBbYE5vsNsm9VAAMHA0QwMkBs
 nrRivimm0760j2ZkuXQ8A/kwCVINE1YWGGAyoUxp1soV2q2gA6KxX8B5qYtcw3X2pR
 2lVqN6cnILGfpE3TgjnQr/GtHH6IbU/eE18ZzQnLhy0WbfFv4NaRoNDJgJq7zehI2q
 0EAAWmkiH4HPA==
Received: from jupiter.universe (dyndsl-091-248-210-236.ewe-ip-backbone.de
 [91.248.210.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E238117E36C6;
 Thu, 31 Oct 2024 18:54:04 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 94B83480075; Thu, 31 Oct 2024 18:54:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 0/4] USB-PD TCPM improvements
Date: Thu, 31 Oct 2024 18:50:29 +0100
Message-ID: <20241031175404.114773-1-sebastian.reichel@collabora.com>
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

Hi,

I have a couple of fixes/improvements for the TCPM code. Three are fixing
actual problems I noticed on the Rock 5B, which prevented booting up the
system. One of them simply adds an error print before potentially committing
hara-kiri by triggering a hard reset, which helps people understanding
why their boards reset themself in case there are more problems. I've
recently added the same print to the kernel TCPM code.

Greetings,

-- Sebastian

Sebastian Reichel (4):
  usb: tcpm: improve handling of some power-supplies
  usb: tcpm: avoid resets for missing source capability messages
  usb: tcpm: print error on hard reset
  usb: tcpm: improve data role mismatch error recovery

 drivers/usb/tcpm/tcpm-internal.h |  1 +
 drivers/usb/tcpm/tcpm.c          | 95 ++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 11 deletions(-)

-- 
2.45.2

