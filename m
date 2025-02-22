Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29002C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C9D980540;
	Sat, 22 Feb 2025 21:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HDlgKICc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PE+tycQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B39680AE6; Sat, 22 Feb 2025 21:35:58 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D48800C2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z0f0C168fz9sp1;
 Sat, 22 Feb 2025 21:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rQa+NKg0Zxe8gI1cDB4MfKZmzwU01uraWesmOqbaHTA=;
 b=HDlgKICcZyhU+7fDl2kt1lfajBG0VIbYXObNQgNiE6L9atXHgfYcerQXc1Mw5aOzUlOtLx
 wyxzphsYMLoEIstYRFT00dqqrbaUhmveO4LerD5WBah+x6f/Pf00UZJxKCKkIqscWm03jI
 EHNvRa4UlLc+wOlM0+9nuN3Gfd1dkUr6pvR+MqaCVKpZAVQ14P7IDhRU1qdXdm+G/PeXm1
 7IZ7T1GMnZAHRlQ9WhRwu7Jgqq8SzVqVUJk0itKyP7DPLtf5ZkhA28wFYjqwNPPJTRiljI
 Jz+XqYHspSxPnp+7vMdKFsRpZc+DE0pXP/uWDUWR8aQ04aNOCkV+DX9wdbFmHw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rQa+NKg0Zxe8gI1cDB4MfKZmzwU01uraWesmOqbaHTA=;
 b=PE+tycQsQUZKdTc6ZMyrU18t9yeEkUDS+leXtgO6ZZwn3dTO0POWOieCuqkF/tSPvL/o+z
 ucDzWjHfhOso1edyggFWAa3HhfZu3Mm+IeSwxkGtsu96bHMqeoI6an889vt37THNl1ijKb
 zOPbFujWbrtZ2MUtZnueDqnpMi89I+SptUU3JuALDmxThdz8N1JW3nEtBUJ01fuPNE86O5
 V3Hm50y7QgZ3MdOgKXtNmXjiw9emgjabUpk6Qztx31jGuHqBzHS73iue7d47JQLEHYjaQN
 v68t0SxixI26PLPVUeXfsF15/8GOu3ZXONGSb3P/x9p+MU/TZlaEQFkyzQu8Hg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 00/23] net: miiphybb: Get rid of global bb_miiphy_buses[]
Date: Sat, 22 Feb 2025 21:33:10 +0100
Message-ID: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b031919853b0871b27c
X-MBO-RS-META: cydt9xhuo4jn4kagp9xwwuyky88uo46o
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

Get rid of global bb_miiphy_buses[] which does not fit well with U-Boot
DM in favor of usual per-ethernet-MAC-driver-instance MDIO bus accessors.

Introduce the ability to allocate struct bb_miiphy_bus {} and make it wrap
struct mii_dev {}, so the struct mii_dev can be passed into MDIO bus access
infrastructure as usual. When the MDIO bus access infrastructure attempts to
access the MDIO bus and invokes any of the bbmiiphy accessors, those accessors
are passed the structu mii_dev {}, but can also access struct bb_miiphy_bus
using plain container_of() .

Clean up the drivers and update them to match.

Marek Vasut (23):
  net: ravb: Drop empty init callback
  net: sh_eth: Drop empty init callback
  net: designware: Drop NULL priv assignment
  net: ravb: Reorder bb_miiphy functions
  net: sh_eth: Reorder bb_miiphy functions
  arm: mvebu: a38x: Reorder bb_miiphy functions
  net: designware: Reorder bb_miiphy functions
  arm: mvebu: a38x: Call bb_miiphy init directly in driver probe
  net: miiphybb: Drop bb_miiphy_init() and .init callback
  net: designware: Drop bus index
  net: designware: Extract bbmiiphy initialization into dedicated
    function
  net: miiphy: Introduce mdio_init()
  net: miiphybb: Introduce bb_miiphy_alloc()/bb_miiphy_free() wrappers
  arm: mvebu: a38x: Allocate bb_miiphy using bb_miiphy_alloc() and fill
    in callbacks
  net: ravb: Allocate bb_miiphy using bb_miiphy_alloc() and fill in
    callbacks
  net: sh_eth: Allocate bb_miiphy using bb_miiphy_alloc() and fill in
    callbacks
  net: designware: Allocate bb_miiphy using bb_miiphy_alloc() and fill
    in callbacks
  net: miiphybb: Use container_of() in bb_miiphy_getbus()
  net: miiphybb: Drop name field from struct bb_miiphy_bus
  arm: mvebu: a38x: Drop use of miiphy_get_dev_by_name()
  net: ravb: Drop use of miiphy_get_dev_by_name()
  net: sh_eth: Drop use of miiphy_get_dev_by_name()
  net: miiphybb: Drop bb_miiphy_buses and bb_miiphy_buses_num

 board/gdsys/a38x/ihs_phys.c | 237 ++++++++++++++------------------
 common/board_r.c            |   3 -
 common/miiphyutil.c         |  13 +-
 drivers/net/designware.c    | 263 ++++++++++++++++++++----------------
 drivers/net/phy/miiphybb.c  |  36 ++---
 drivers/net/ravb.c          | 159 ++++++++++------------
 drivers/net/sh_eth.c        | 179 ++++++++++++------------
 include/miiphy.h            |  17 +--
 8 files changed, 438 insertions(+), 469 deletions(-)

---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de

-- 
2.47.2

