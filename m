Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D17C021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7040B81110;
	Wed, 26 Feb 2025 19:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="c7thN1Pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3F680FF2; Wed, 26 Feb 2025 19:45:11 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2179D80FD4
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 19:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1740595507;
 bh=65pZ0Q6NQiERrrPJSpFJpoIAXM+rQ5PclNIw8xS5IyE=;
 h=From:To:Cc:Subject:Date:From;
 b=c7thN1PdBRFenLDjKPrx+CChXknkBK1avAbemdJVkTijPmFesxCZyEPwo2dzZue+v
 96ADzD3c5VqwtFUxcRmmebfUzJbH6g4SgAk3i+vszNlbdWXdUdqekfZCFSmbGHN2QU
 P2O7cyARRLqf1UnAfVdZqvVA8zohcwv81R34dHw1vmdcCdzE/n6KRIkMEYNQPEDPLG
 C5j+8nW2zzr84m8+xW0HytdcA7zRGuxH3uW/wl+ggpxbM/ZeVBiUj8X5Wa7rPuy7d4
 7zrZqKkOok9aR5vw3kZN+hDo0zVg5gqbhaXjrY5WsQsqyG/dJyTbQ35zQ9FnMzF1e9
 RZTzv2AiflC7Q==
Received: from jupiter.universe (dyndsl-091-249-076-032.ewe-ip-backbone.de
 [91.249.76.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E81B17E05EA;
 Wed, 26 Feb 2025 19:45:07 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 3166E480035; Wed, 26 Feb 2025 19:45:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/4] USB-PD TCPM improvements
Date: Wed, 26 Feb 2025 19:44:43 +0100
Message-ID: <20250226184506.64114-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.47.2
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

Changes since PATCHv1:
 * https://lore.kernel.org/u-boot/20241031175404.114773-5-sebastian.reichel@collabora.com/
 * rebased to v2025.04-rc3 (no changes needed)

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
2.47.2

