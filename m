Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FB2C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 13:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5D4680AD3;
	Wed,  5 Aug 2026 13:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEXAJNtsCSek; Wed,  5 Aug 2026 13:21:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C418A80B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785936110;
	bh=/RLfaMnp328UVwMzBy1ctVRleR8pYRUvpIw4xJxnL0g=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZqR951+/ITSPbQyQTdXUhBzFDtxvPCxYh931kS6APrPdpSkvbCGdWG8icB8a5OlWi
	 OB5Mnk34L5QkvQB5izk1Oudpn6t7Td2gHYE0tDCj/RyILGwuCu5NGKQmgFzFYa23Kk
	 M3yj4OLILOpGbQAf2HKvhdXu2DeZjsvO7DsaF+rp/WR/xKV8w4hkgbqLDDHvGcIduh
	 gZiCYliL5Wn3C0R0kEyUsPKL0NbrCWOd51qJJrwpwQGRRDQz33xzSEpdyyXUEfV4gq
	 tV/Oy9ATFRIHyBBOFThDrYvzGDjdIbLaAezA19+DSHBqHcXNY6/ZsDVWoLCpjrizXq
	 494WG+okKMaDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C418A80B1E;
	Wed,  5 Aug 2026 13:21:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F033D23F
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D98DB400B1
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8rNvtEAXqosZ for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 13:21:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=gregor.herburger@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E5B4740061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5B4740061
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5B4740061
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:47 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
Subject: [PATCH v4 0/2] rpi: copy /chosen/bootloader node with properties
 and set boot_partition
Date: Wed, 05 Aug 2026 15:21:39 +0200
Message-Id: <20260805-tryboot2-v4-0-6e6d755222a5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOM4c2oC/22Oyw7CIBBFf8WwFgNDX7ryP4wLoFOL0WKAEo3pv
 wsaY9OYWd3knjP3STw6g57sVk/iMBpv7JBCsV4R3cvhhNS0KRNgULGGCRrcQ1kbgDa6BOCirrC
 UJNVvDjtzf6sOx0/2ozqjDpnPjc7ZKw29Q/lT1qz5KmnkNJ2QvJAodVfz/cUMY3B2MPdNi1nRG
 x+se7znRsiv/iyLkDyCaVbzDhB5ufDkdVHM4WIGiwQrpjQ0ILcg1BKepukFW4tF5zYBAAA=
X-Change-ID: 20260803-tryboot2-8c5221376e5a
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785936106; l=1255;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=efnjENIouHXtfMwe7gzefyQGz9x9aH4p2Klom5tqb5Y=;
 b=ysgWOnaFqSIAKwMeol4MSBkdLkmQ95yDr4UFJPxGb6BmbXKlxY8/kMlVABevfTLff3/znO0iZ
 tjKREkQWutaA5rynnoW7YJRkZwRSFfx+vUip3mf+N4WfgWR8N7fzhi2
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1785936106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/RLfaMnp328UVwMzBy1ctVRleR8pYRUvpIw4xJxnL0g=;
 b=KdkdZkWbvdwCTkQhdpjweGojwquR+sZ4uOgppInyiqgatSz6zQxo0VKxfuVWKBcvkkYPQJ
 LO3bsO/XrRyIRQSfm2PhEAPLf+q1e3Ms5W2Pp+KH4fcQCdL/EQIB2hFniZJPxkblGZZgLj
 Dq2Ga+NkknIxNzyMZWj6fnFGoZs+zWZcej4gfaiu0/GwYFxinXyhPl6rs38nAI8qt4OX56
 EPmQnHXDr1plW4mYaW5RMyJwgjQCnm3vcBB5ixEL3sQSlEZjOc6ENS0kPCQ2jV7URACjkP
 tf+73FDrIxtJ9u/cEvgHd0xg4geCnCrn/P9MylAYGmb5kxqXlbEcOhLvo0n7YQ==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1785936106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/RLfaMnp328UVwMzBy1ctVRleR8pYRUvpIw4xJxnL0g=;
 b=HqWfWmo+hcynxhLKYhsaVaUisGcSgEXofJNe80qUg1vMNQ6XLdmMuqdfh0MD2NTlBKqt4Z
 BHJAzfIxvadjdkCg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KdkdZkWb; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=HqWfWmo+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Raspberry Pi has the "tryboot" feature where it can boot from a
different partition enabling failsafe A/B updates. After boot the
firmware adds some properties in /chosen/bootloader, e.g. partition.

Pass this node through to the OS devicetree and use partition to set the
environment variable boot_partition.

Changes in v4:
- Split into two patches
- update commit messages
- Drop Reviewed-by-tag again
- Link to v3: https://patch.msgid.link/20260804-tryboot2-v3-1-b0bc282a923b@linutronix.de

Changes in v3:
- Copy the complete '/chosen/bootloader' node instead of only the
  partition property
- Link to v2: https://patch.msgid.link/20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de

Changes in v2:
- update Reviewed-by tag

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
Gregor Herburger (2):
      rpi: set boot partition from devicetree
      rpi: pass the bootloader node through to the OS devicetree

 board/raspberrypi/rpi/rpi.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260803-tryboot2-8c5221376e5a

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

