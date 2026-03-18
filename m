Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2883A1088E58
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 00:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E35D838FA;
	Thu, 19 Mar 2026 01:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=xuku.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=xuku.com header.i=@xuku.com header.b="r5yXyiQN";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gyBg4g8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A4F83952; Wed, 18 Mar 2026 22:15:30 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8187E8352B
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 22:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=xuku.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=neil@xuku.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5BCB5140006E;
 Wed, 18 Mar 2026 17:15:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 17:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xuku.com; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1773868526; x=1773954926; bh=j3bkGaRSHKQfKxPUTNSOI
 SHoVYKiOrAIKUFWFZshe0Y=; b=r5yXyiQNu2+4Aa8feS1DSM3REj0QgecKRmB1S
 MhoV0xseTCOjvk1Qrwhip5+fA+hivxgMAO5zbx+NkW1IlZ7tphxl+WbTJWQSn20j
 773bIFIon7UPMUSjIQi1tAch05wndmWzQDuQD4dInEBI8+lwOlyr4yNE/KXWAa2V
 E8x0Nf3MXM2ZbpeEU7MqbEDrRkBYOhRxPcuk5dj+oVILmj3wBLjXYFSWD777/Paq
 ijeBuBxRdeI0H2u+QGrDB7aSAe8pI4TaXxhzzdQHjjFmEWkC46qao3V75R3ZwM+r
 FJIk2jjEjD6Zx1C+nONwK6mFoKOgZpDohnv32RIykB5M25i7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1773868526; x=1773954926; bh=j3bkGaRSHKQfKxPUTNSOISHoVYKiOrAIKUF
 WFZshe0Y=; b=gyBg4g8xqGiv2uiQZOKrcvJS3PrYFgJas+5m5bj/1Fh2UhmdQQ2
 P1jPKCof2vPzVqPX5RnjVo2zhb4sQt8k+GWjwd7n9NtzYfHlTI6HT0yNzxXKwzOf
 IoSqIXhUJD9C+I9ROGiBDSLRwNZxYovRQsts2cDWFvdqCIMJaneuw+PM5u2ZJqCs
 MotBdTNcIox1clQDC6XFmKV8IVzq3L2KYfbF2N86D7aSCNtjjiUc5Vj5e4DcWVMP
 SaNrZXPad9kxIEJ8X7cstGX8qAOU6c2wIkCjljKG5e8euS3Q7kBzQFxi0ujjBko/
 fkHb9Kz1PzEa2Nuv3OyVF7sRSgE3fx70Eow==
X-ME-Sender: <xms:7RW7aVk9KFjZsV2A9qKuDZ0T042YKdd4TtIUAukjWOzQo49ybcYE8Q>
 <xme:7RW7aYQMHh5ltOZbdN6a_Oz2hzzcwOyy1goomD01y4Dacjl7Q-mBf9eFKnabxSQuE
 FI4HIyEyxN28YtPPPDUboC1EherESfasH8IsU1yJ4YR7YuqDVw>
X-ME-Received: <xmr:7RW7aZD0NwhFeCfXLAECDiEoCFkoDAP2wDCnXVcx78c40kbgVAOaoK9FUxLNo7oKSZ6GzTt8XIw65a0b2ydbUkw9qv7iNkoS1kPo0z2gVSq8d4gQa5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehudekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpefpvghilhcuuegvrhhkmhgrnhcuoehnvghilhesgihukhhurdgtohhm
 qeenucggtffrrghtthgvrhhnpeeiudefteefgfdtvddtveevieffudevteeljeegjedvve
 euveeltdfhkeelkeeuieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlseiguhhkuh
 drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepthhrihhnih
 eskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepnhgvihhlseiguhhkuhdrtghomh
X-ME-Proxy: <xmx:7RW7afQEFwP2ybWeaXLYTb37m5ubU3izc3wVzd6M7wSOilews5nxAQ>
 <xmx:7hW7aXrPkZKRafGbZ0SRiZUDw1uXhwesr5kD2G6IdorZ5pPRkt0dpQ>
 <xmx:7hW7aRx0hoM90o9WR071XfUoZ2J1AL5G1zRwZDiVIDaGYNR-6yu84w>
 <xmx:7hW7acKhM4wcL2FHMRvDwu5NGKJA-3p3oxZo4OrVFQtwSGMKLzb4fw>
 <xmx:7hW7aflKEptXtc8jWMiQmfVb-6OeLZ9pGITfS3PoLB6EiSyDrQHVqiK4>
Feedback-ID: ibe734310:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:15:25 -0400 (EDT)
From: Neil Berkman <neil@xuku.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Neil Berkman <neil@xuku.com>
Subject: [PATCH] env: flash: add catch-all for unrecognized flags in
 env_flash_init()
Date: Wed, 18 Mar 2026 14:15:15 -0700
Message-ID: <20260318211515.35246-1-neil@xuku.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Mar 2026 01:46:15 +0100
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

When both environment copies have valid CRCs but the flag bytes do not
match any recognized pair, env_flash_init() falls through without
setting gd->env_addr or gd->env_valid. This is a problem because:

1. env_init() then sets gd->env_addr = &default_environment (in RAM).

2. In env_flash_load(), the pointer comparison
   gd->env_addr != &flash_addr->data evaluates true (RAM != flash),
   triggering the pointer swap that selects the secondary copy.

3. The repair logic writes OBSOLETE (0x00) to the non-active flag but
   cannot promote the other flag from 0x00 to ACTIVE (0x01) because
   NOR flash requires a sector erase to set bits. Both copies end up
   with flag=0x00.

4. On every subsequent boot, flag1 == flag2 triggers the ENV_REDUND
   path, printing a spurious "recovered successfully" warning until
   an explicit saveenv erases and rewrites the sectors.

The recognized flag values are ACTIVE (0x01), OBSOLETE (0x00), and
erased (0xFF). Of the 256 possible flag values, the existing chain of
if/else-if handles only three: 253 of 256 values fall through without
setting gd->env_addr. Combined with 0x00 (already stuck on NOR),
254 of 256 values eventually reach the persistent-warning state.

Other env backends (SPI flash, NAND, MMC) handle this through
env_check_redund() in env/common.c, which uses a numeric comparison
of the flags as a serial counter and always reaches a decision. The
CFI flash backend is the only one that uses its own flag-matching
logic.

Add a catch-all else clause that defaults to the primary copy with
ENV_REDUND status, matching the existing behavior for the flag1==flag2
case. This ensures gd->env_addr is always set, preventing the
unintended pointer swap. The condition is recoverable via saveenv.

Signed-off-by: Neil Berkman <neil@xuku.com>

Reproducer: https://gist.github.com/neilberkman/4155612a7942d3f510f204eb85e61943

The SPI flash backend (env/sf.c) has a related but distinct issue:
it retained legacy boolean save semantics but its load path now uses
the common serial-number logic in env_check_redund(), creating an
inconsistency under interrupted updates. That has wider implications
for fw_env.c and would need separate discussion.
---
 env/flash.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/env/flash.c b/env/flash.c
index 0f7393d8..31dd1656 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -108,6 +108,14 @@ static int env_flash_init(void)
 	} else if (flag2 == 0xFF) {
 		gd->env_addr	= addr2;
 		gd->env_valid	= ENV_REDUND;
+	} else {
+		/*
+		 * Unrecognized flag pair (e.g. bit-flip on NOR flash).
+		 * Default to primary copy to prevent unintended pointer
+		 * swap in env_flash_load().
+		 */
+		gd->env_addr	= addr1;
+		gd->env_valid	= ENV_REDUND;
 	}
 
 	return 0;
-- 
2.43.0

